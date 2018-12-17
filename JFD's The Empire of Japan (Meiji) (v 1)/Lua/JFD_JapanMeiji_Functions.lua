-- JFD_JapanMeiji_Functions
-- Author: JFD
-- Edited By: F0S
--=======================================================================================================================
-- Includes
--=======================================================================================================================
WARN_NOT_SHARED = false; include( "Sukritact_SaveUtils.lua" ); MY_MOD_NAME = "JFD_JapanMeiji_Functions";
include("FLuaVector.lua")
--=======================================================================================================================
-- UTILITY FUNCTIONS	
--=======================================================================================================================
-- JFD_IsCivilisationActive
------------------------------------------------------------------------------------------------------------------------
function JFD_IsCivilisationActive(civilisationID)
	for iSlot = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
		local slotStatus = PreGame.GetSlotStatus(iSlot)
		if slotStatus == SlotStatus["SS_TAKEN"] or slotStatus == SlotStatus["SS_COMPUTER"] then
			if PreGame.GetCivilization(iSlot) == civilisationID then
				return true
			end
		end
	end
	return false
end
--------------------------------------------------------------------------------------------------------------------------
--  JFD_GetJapanMeijiCultureBonus
--------------------------------------------------------------------------------------------------------------------------
function JFD_GetJapanMeijiCultureBonus(playerID)
	local player = Players[playerID]
	local cultureBonus = player:GetTotalJONSCulturePerTurn()
	if player:IsGoldenAge() then
		cultureBonus = math.ceil(cultureBonus / 10)
	else
		cultureBonus = 0
	end
	return cultureBonus
end
--=======================================================================================================================
-- CORE FUNCTIONS	
--=======================================================================================================================
-- Globals
----------------------------------------------------------------------------------------------------------------------------
local activePlayerID = Game.GetActivePlayer()
local activePlayer = Players[activePlayerID]
local civilisationID = GameInfoTypes["CIVILIZATION_JFD_JAPAN_MEIJI"]
local isCivActive = JFD_IsCivilisationActive(civilisationID)
------------------------------------------------------------------------------------------------------------------------
-- JFD_GoldenAgeCultureModifier
------------------------------------------------------------------------------------------------------------------------
local buildingJapanMeijiDummy = GameInfoTypes["BUILDING_MEIJI_DUMMY"]

function JFD_GoldenAgeCultureModifier(playerID)
	JFD_GoldenAgeCultureModifierEffect(playerID, true)
end

function JFD_GoldenAgeCultureModifierEffect(playerID, isTurn)
	local player = Players[playerID]
	if player:IsEverAlive() and player:GetCivilizationType() == civilisationID then
		local cultureBonus = JFD_GetJapanMeijiCultureBonus(playerID)
		if isTurn then
			player:ChangeJONSCulture(cultureBonus)
		end
		local capital = player:GetCapitalCity()
		if capital then
			capital:SetNumRealBuilding(buildingJapanMeijiDummy, cultureBonus)
		end
	end
end
------------------------------------------------------------------------------------------------------------------------
-- JFD_GoldenAgeProductionModifier
------------------------------------------------------------------------------------------------------------------------
local buildingJapanMeijiProductionID = GameInfoTypes["BUILDING_JFD_JAPAN_MEIJI_GOLDEN_AGE_PRODUCTION"]

function JFD_GoldenAgeProductionModifier(playerID)
	local player = Players[playerID]
	if player:IsEverAlive() and player:GetCivilizationType() == civilisationID then
		if player:IsGoldenAge() then
			for city in player:Cities() do
				if not city:IsHasBuilding(buildingJapanMeijiProductionID) then
					city:SetNumRealBuilding(buildingJapanMeijiProductionID, 1)
				end
			end
		else
			for city in player:Cities() do
				if city:IsHasBuilding(buildingJapanMeijiProductionID) then
					city:SetNumRealBuilding(buildingJapanMeijiProductionID, 0)
				end
			end
		end	
	end
end

function JFD_GoldenAgeProductionModifierDirty()
	if activePlayer:IsTurnActive() then
        JFD_GoldenAgeProductionModifier(activePlayerID)
		JFD_GoldenAgeCultureModifierEffect(activePlayerID, false)
    end
end
------------------------------------------------------------------------------------------------------------------------
-- JFD_JapanLandUnitPromotion
------------------------------------------------------------------------------------------------------------------------
local promotionSpawnGeneralsID = GameInfoTypes["PROMOTION_SPAWN_GENERALS_I"]

function JFD_JapanLandUnitPromotion(playerID, cityID, unitID)
	local player = Players[playerID]
	if player:IsEverAlive() and player:GetCivilizationType() == civilisationID then
		local unit = player:GetUnitByID(unitID)
		if player:IsGoldenAge() then
			if unit and unit:GetCombatLimit() > 0 and unit:GetDomainType() == DomainTypes.DOMAIN_LAND and not unit:IsHasPromotion(promotionSpawnGeneralsID) then
				unit:SetHasPromotion(promotionSpawnGeneralsID, true)
			end
		end
	end
end
------------------------------------------------------------------------------------------------------------------------
-- JFD_MikasaGoldenAgePointsFromConstruction
------------------------------------------------------------------------------------------------------------------------
local unitMikasaID = GameInfoTypes["UNIT_JFD_MIKASA"]
local yieldProductionID = GameInfoTypes["YIELD_PRODUCTION"]

function JFD_MikasaGoldenAgePointsFromConstruction(playerID)
	local player = Players[playerID]
	if player:IsEverAlive() and player:GetCivilizationType() == civilisationID then
		for city in player:Cities() do
			if city:GetProductionUnit() == unitMikasaID then
				local goldenAgePoints = city:GetBaseYieldRate(yieldProductionID)
				if not player:IsGoldenAge() then
					player:ChangeGoldenAgeProgressMeter(goldenAgePoints)
					if player:IsHuman() and player:IsTurnActive() then
						local hex = ToHexFromGrid(Vector2(city:GetX(), city:GetY()))
						Events.AddPopupTextEvent(HexToWorld(hex), Locale.ConvertTextKey("[COLOR_POSITIVE_TEXT]+{1_Num}[ENDCOLOR][ICON_GOLDEN_AGE]", goldenAgePoints), 1)
						Events.GameplayFX(hex.x, hex.y, -1)
					end
				end
			end
		end
	end
end

if isCivActive then
	GameEvents.PlayerDoTurn.Add(JFD_GoldenAgeCultureModifier)
	GameEvents.PlayerDoTurn.Add(JFD_GoldenAgeProductionModifier)
	Events.SerialEventGameDataDirty.Add(JFD_GoldenAgeProductionModifierDirty)
	GameEvents.CityTrained.Add(JFD_JapanLandUnitPromotion)
	GameEvents.PlayerDoTurn.Add(JFD_MikasaGoldenAgePointsFromConstruction)
end
------------------------------------------------------------------------------------------------------------------------
-- JFD_DaimyoMeleeBonuses
------------------------------------------------------------------------------------------------------------------------
local buildingDaimyoMelee = GameInfoTypes["BUILDING_JFD_DAIMYO_MELEE_BONUSES"]
local promotionDaimyoID = GameInfoTypes["PROMOTION_JFD_DAIMYO"] 

function JFD_DaimyoMeleeBonuses(playerID)
	local player = Players[playerID]
	if player:IsEverAlive() then
		for city in player:Cities() do
			local cityPlot = city:Plot()
			local daimyoGarrison = false
			for unitID = 0, cityPlot:GetNumUnits() - 1, 1 do
				if cityPlot and cityPlot:GetUnit(unitID):IsHasPromotion(promotionDaimyoID) then
					daimyoGarrison = true
					break
				end
			end
			if daimyoGarrison then
				if not city:IsHasBuilding(buildingDaimyoMelee) then
					city:SetNumRealBuilding(buildingDaimyoMelee, 1)
				end
			else
				if city:IsHasBuilding(buildingDaimyoMelee) then
					city:SetNumRealBuilding(buildingDaimyoMelee, 0)
				end
			end
		end
	end
end

function JFD_DaimyoAIGoldenAgePoints(playerID, unitID)
    local player = Players[playerID]
    local unit = player:GetUnitByID(unitID)
    if player:IsEverAlive() and not player:IsHuman() then 
       	if unit and unit:IsHasPromotion(promotionDaimyoID) and load(unit,"DaimyoAI") == nil then
			player:ChangeGoldenAgeProgressMeter(math.floor(player:GetGoldenAgeProgressMeter() * 33/100))
			save(unit,"DaimyoAI",true)
        end
    end
end

function JFD_DaimyoInitialTrigger(playerID, unitID)
	local player = Players[playerID]
	local unit = player:GetUnitByID(unitID)
	if unit and unit:IsHasPromotion(promotionDaimyoID) then
		GameEvents.PlayerDoTurn.Add(JFD_DaimyoMeleeBonuses)
		GameEvents.UnitSetXY.Add(JFD_DaimyoMeleeBonuses)
		GameEvents.PlayerCityFounded.Add(JFD_DaimyoMeleeBonuses)
		Events.SerialEventUnitCreated.Add(JFD_DaimyoMeleeBonuses)
		Events.SerialEventUnitCreated.Add(JFD_DaimyoAIGoldenAgePoints)
		Events.SerialEventUnitCreated.Remove(JFD_DaimyoInitialTrigger)
		save("GAME", "JFD_DaimyoInitalised", true)
		JFD_DaimyoMeleeBonuses(playerID)
		JFD_DaimyoAIGoldenAgePoints(playerID, unitID)
	end
end

if load("GAME", "JFD_DaimyoInitalised") then
	GameEvents.PlayerDoTurn.Add(JFD_DaimyoMeleeBonuses)
	GameEvents.UnitSetXY.Add(JFD_DaimyoMeleeBonuses)
	GameEvents.PlayerCityFounded.Add(JFD_DaimyoMeleeBonuses)
	Events.SerialEventUnitCreated.Add(JFD_DaimyoMeleeBonuses)
	Events.SerialEventUnitCreated.Add(JFD_DaimyoAIGoldenAgePoints)
else
	Events.SerialEventUnitCreated.Add(JFD_DaimyoInitialTrigger)
end
--==========================================================================================================================
--==========================================================================================================================