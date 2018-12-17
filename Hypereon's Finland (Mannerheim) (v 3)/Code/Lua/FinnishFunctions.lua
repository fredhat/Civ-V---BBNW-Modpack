-- Finnish Functions
-- Original Author: Hypereon
-- Edited By: F0S
--------------------------------------------------------------
WARN_NOT_SHARED = false; include( "SaveUtils" ); MY_MOD_NAME = "FinnishFunctions";

local civilizationID = GameInfoTypes["CIVILIZATION_FINNS"]

function JFD_IsCivilizationActive(civilizationID)
	for iSlot = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
		local slotStatus = PreGame.GetSlotStatus(iSlot)
		if slotStatus == SlotStatus["SS_TAKEN"] or slotStatus == SlotStatus["SS_COMPUTER"] then
			if PreGame.GetCivilization(iSlot) == civilizationID then
				return true
			end
		end
	end
	return false
end

function BlockRuneSingers(playerID, unitID)
	if unitID == GameInfoTypes["UNIT_FINNIC_RUNE_SINGER"] then
		return
	end
	return true
end
GameEvents.PlayerCanTrain.Add(BlockRuneSingers)
-------------------------------------------------------------------------------------------------
--KALEVALA PROMOTION
-------------------------------------------------------------------------------------------------
local Kalevala = GameInfoTypes.PROMOTION_KALEVALA

local tFreePromotions = {
	[GameInfoTypes.PROMOTION_FINNISH_SPIRIT] = 1,
	[GameInfoTypes.PROMOTION_NATIONAL_UNITY] = 2,
	[GameInfoTypes.PROMOTION_HERITAGE_OF_KALEVALA] = 3,
	[GameInfoTypes.PROMOTION_FINNISH_TOUGHNESS] = 4,
	[GameInfoTypes.PROMOTION_PATRIOTIC_FERVOR] = 5
}

function KalevalaEffect(iPlayer)
	local pPlayer = Players[iPlayer]
	if pPlayer:IsEverAlive() then
		if pPlayer:GetCivilizationType() == civilizationID then
			local iCultureRate = pPlayer:GetTotalJONSCulturePerTurn()
			local capitalCity = pPlayer:GetCapitalCity()
			if capitalCity then
				if pPlayer:IsGoldenAge() then
					iCultureRate = iCultureRate + math.ceil(capitalCity:GetNumBuilding(GameInfoTypes["BUILDING_CS_DUMMY_CULTURE"]) * 1.2)
				else
					iCultureRate = iCultureRate + capitalCity:GetNumBuilding(GameInfoTypes["BUILDING_CS_DUMMY_CULTURE"])
				end
			end
			iCultureRate = math.floor(iCultureRate / 25)
			if iCultureRate < 1 then iCultureRate = 0 end
			if iCultureRate > 5 then iCultureRate = 5 end	
			for pUnit in pPlayer:Units() do
				if pUnit:IsHasPromotion(Kalevala) then
					if iCultureRate > 0 then
						local tTable = {false, false, false, false, false}
						for i = 1, iCultureRate do
							tTable[i] = true
						end
						for iFreePromotion, iRank in pairs(tFreePromotions) do
							pUnit:SetHasPromotion(iFreePromotion, tTable[iRank])
						end
					else
						for iFreePromotion, iRank in pairs(tFreePromotions) do
							pUnit:SetHasPromotion(iFreePromotion, false)
						end
					end
				else
					for iFreePromotion, iRank in pairs(tFreePromotions) do
						pUnit:SetHasPromotion(iFreePromotion, false)
					end
				end
			end
		else
			for pUnit in pPlayer:Units() do
				if pUnit:IsHasPromotion(Kalevala) then
					for iFreePromotion, iRank in pairs(tFreePromotions) do
						pUnit:SetHasPromotion(iFreePromotion, false)
					end
				end
			end
		end
	end
end

function KalevalaEffectDirtyTrigger()
	local iPlayer = Game.GetActivePlayer()
	local pPlayer = Players[iPlayer]
	if pPlayer:IsTurnActive() then
		KalevalaEffect(iPlayer)
	end
end
------------------------------------------------------------------------------------
-- FINNISH TRAIT
------------------------------------------------------------------------------------
local RuneSingerRate = GameInfo.GameSpeeds[Game.GetGameSpeedType()].GoldPercent

local tFaithBuildings = {
	[GameInfoTypes.BUILDING_CATHEDRAL] = 1,
	[GameInfoTypes.BUILDING_TEMPLE] = 2,
	[GameInfoTypes.BUILDING_FINNISH_SAUNA] = 3,
	[GameInfoTypes.BUILDING_SHRINE] = 4,
	[GameInfoTypes.BUILDING_MONASTERY] = 5,
	[GameInfoTypes.BUILDING_MOSQUE] = 6,
	[GameInfoTypes.BUILDING_PAGODA] = 7,
	[GameInfoTypes.BUILDING_F0S_ALTAR] = 8,
	[GameInfoTypes.BUILDING_F0S_CHURCH] = 9,
	[GameInfoTypes.BUILDING_F0S_SYNAGOGUE] = 10
}

local tFaithWonders = {
	[GameInfoTypes.BUILDING_STONEHENGE] = 1,
	[GameInfoTypes.BUILDING_HAGIA_SOPHIA] = 2,
	[GameInfoTypes.BUILDING_BOROBUDUR] = 3,
	[GameInfoTypes.BUILDING_GRAND_TEMPLE] = 4,
	[GameInfoTypes.BUILDING_MOSQUE_OF_DJENNE] = 5
}

function FinnishRunePointsCalculate(playerID)
	local player = Players[playerID]
	if player:IsEverAlive() and player:GetCivilizationType() == civilizationID then
		local finnishrunepoints = load(player, "finnishrunepoints")
		if finnishrunepoints == nil then
			finnishrunepoints = 0
		end
		for city in player:Cities() do
			for iFaithBuilding, iNum in pairs(tFaithBuildings) do
				if city:IsHasBuilding(iFaithBuilding) then
					finnishrunepoints = finnishrunepoints + 1
				end
			end
			for iFaithWonder, iNum in pairs(tFaithWonders) do
				if city:IsHasBuilding(iFaithWonder) then
					finnishrunepoints = finnishrunepoints + 3
				end
			end
		end
		save(player, "finnishrunepoints", finnishrunepoints)
	end
end

function GiveRuneSingers(playerID)
	local player = Players[playerID]
	if player:IsEverAlive() and player:GetCivilizationType() == civilizationID then
		local RuneSingersGiven = load(player, "RuneSingersTotalGiven")
		if RuneSingersGiven == nil then
			RuneSingersGiven = 0
			save(player, "RuneSingersTotalGiven", 0)
		end
		local RunePointMultiplier = 1.5 ^ (RuneSingersGiven)
		if load(player, "finnishrunepoints") > (RuneSingerRate * RunePointMultiplier) and player:GetCapitalCity() then
			local pCity = player:GetCapitalCity()
			local newUnit = player:InitUnit(GameInfo.Units["UNIT_FINNIC_RUNE_SINGER"].ID, pCity:GetX(), pCity:GetY())
			if player:IsHuman() and player:IsTurnActive() then
				player:AddNotification(NotificationTypes["NOTIFICATION_GREAT_PERSON_ACTIVE_PLAYER"], Locale.ConvertTextKey("TXT_KEY_FINNS_RUNE_SINGER_SPAWN", newUnit:GetNameNoDesc(), pCity:GetName()), Locale.ConvertTextKey("TXT_KEY_TRAIT_FINNS_SHORT"), newUnit:GetX(), newUnit:GetY(), GameInfo.Units["UNIT_FINNIC_RUNE_SINGER"].ID, -1)
			end
			save(player, "finnishrunepoints", 0)
			save(player, "RuneSingersTotalGiven", RuneSingersGiven + 1)
		end
	end
end	

------------------------------------------------------------------------------------
-- Sauna Code
------------------------------------------------------------------------------------
function JFD_FinnishSaunaUnits(playerID, unitID)
	local player = Players[playerID]
	if player:IsEverAlive() then
		local unit = player:GetUnitByID(unitID)
		if unit and load(unit, "saunaunits") == nil and not unit:IsHasPromotion(GameInfoTypes["PROMOTION_SAUNA"]) and unit:GetCombatLimit() > 0 and unit:GetDomainType() == DomainTypes.DOMAIN_LAND then
			local city = Map.GetPlot(unit:GetX(), unit:GetY()):GetPlotCity()
			if city and city:IsHasBuilding(GameInfoTypes["BUILDING_FINNISH_SAUNA"]) then
				unit:SetHasPromotion(GameInfoTypes["PROMOTION_SAUNA"], true)
			end
		end
		save(unit, "saunaunits", true)
	end
end

function JFD_FinnishSaunaUnitsInitialTrigger(iPlayer, iCity, iBuilding)
	local pPlayer = Players[iPlayer]
	local pCity = pPlayer:GetCityByID(iCity)
	if pCity and pCity:IsHasBuilding(GameInfoTypes["BUILDING_FINNISH_SAUNA"]) then
		Events.SerialEventUnitCreated.Add(JFD_FinnishSaunaUnits)
		GameEvents.CityConstructed.Remove(JFD_FinnishSaunaUnitsInitialTrigger)
		save("GAME", "JFD_FinnishSaunaUnitsInitalised", true)
	end
end

if JFD_IsCivilizationActive(civilizationID) then
	GameEvents.PlayerDoTurn.Add(KalevalaEffect)
	Events.SerialEventGameDataDirty.Add(KalevalaEffectDirtyTrigger)
	GameEvents.PlayerDoTurn.Add(FinnishRunePointsCalculate)
	GameEvents.PlayerDoTurn.Add(GiveRuneSingers)
	if load("GAME", "JFD_FinnishSaunaUnitsInitalised") then
		Events.SerialEventUnitCreated.Add(JFD_FinnishSaunaUnits)
	else
		GameEvents.CityConstructed.Add(JFD_FinnishSaunaUnitsInitialTrigger)
	end
end