-- JFD_CoreFunctions
-- Author: JFD
-- Heavily Edited By: F0S
--==========================================================================================================================
-- UTILITY FUNCTIONS
--==========================================================================================================================
-- JFD_IsCivilisationActive
--------------------------------------------------------------
include("NewSaveUtils.lua")
include("FLuaVector.lua")

local civilisationGreatBritainID = GameInfoTypes["CIVILIZATION_JFD_GREAT_BRITAIN"]

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
--==========================================================================================================================
-- CORE VICTORIA FUNCTIONS
--==========================================================================================================================
-- JFD_CityStartingGold
--------------------------------------------------------------
local buildingColonyTrackerID = GameInfoTypes["BUILDING_JFD_COLONY_TRACKER"]
local buildingVictorianGoldID = GameInfoTypes["BUILDING_JFD_VICTORIAN_GOLD"]
local buildingVictorianScienceID = GameInfoTypes["BUILDING_JFD_VICTORIAN_SCIENCE"]

function JFD_GetCityStartingGold(player, city)
	local numStartingGold = 100
	local gameSpeed = GameInfo.GameSpeeds[Game.GetGameSpeedType()].GoldPercent
	local eraGold = GameInfo.Eras[player:GetCurrentEra()].StartingGold
	local capital = player:GetCapitalCity()
	if capital then
		local plotDistance = Map.PlotDistance(city:GetX(), city:GetY(), capital:GetX(), capital:GetY())
		numStartingGold = numStartingGold + (plotDistance * 10)
	end
	if eraGold > 0 then
		numStartingGold = numStartingGold + eraGold
	end
	numStartingGold = math.floor(numStartingGold * (gameSpeed / 100))
	return numStartingGold
end

function JFD_CityStartingGold(playerID, iX, iY)
	local player = Players[playerID]
	if player:IsEverAlive() and player:GetCivilizationType() == civilisationGreatBritainID then
		local plot = Map.GetPlot(iX, iY)
		local city = plot:GetPlotCity()
		if city and not city:IsCapital() then
			local startingGold = math.floor(JFD_GetCityStartingGold(player, city))
			player:ChangeGold(startingGold)
			if player:IsHuman() and player:IsTurnActive() then
				local hex = ToHexFromGrid(Vector2(iX, iY))
				Events.AddPopupTextEvent(HexToWorld(hex), Locale.ConvertTextKey("[COLOR_YELLOW]+{1_Num}[ENDCOLOR] [ICON_GOLD]", startingGold), 1)
				Events.GameplayFX(hex.x, hex.y, -1)
			end
		end
		JFD_GoldScienceFromCities(playerID)
	end 	
end
--------------------------------------------------------------
-- JFD_GoldScienceFromCities
--------------------------------------------------------------
function JFD_GoldScienceFromCities(playerID)
	local player = Players[playerID]
	if player:IsEverAlive() and player:GetCivilizationType() == civilisationGreatBritainID then
		local capital = player:GetCapitalCity()
		if capital then
			local goldBonus = 0
			local scienceBonus = 0
			for city in player:Cities() do
				if city:IsCapital() then
					if not city:IsHasBuilding(buildingColonyTrackerID) then
						city:SetNumRealBuilding(buildingColonyTrackerID, 1)
					end
				else
					local plot = Map.GetPlot(city:GetX(), city:GetY())
					if plot:GetArea() ~= capital:Plot():GetArea() then
						goldBonus = goldBonus + math.ceil(city:GetBaseYieldRate(YieldTypes.YIELD_GOLD) / 10) 
						scienceBonus = scienceBonus + math.ceil(city:GetBaseYieldRate(YieldTypes.YIELD_SCIENCE) / 10)
					end
					if city:IsHasBuilding(buildingVictorianGoldID) then
						city:SetNumRealBuilding(buildingVictorianGoldID, 0)
					end
					if city:IsHasBuilding(buildingVictorianScienceID) then
						city:SetNumRealBuilding(buildingVictorianScienceID, 0)
					end
					if city:IsHasBuilding(buildingColonyTrackerID) then
						city:SetNumRealBuilding(buildingColonyTrackerID, 0)
					end
				end
			end
			capital:SetNumRealBuilding(buildingVictorianGoldID, goldBonus)
			capital:SetNumRealBuilding(buildingVictorianScienceID, scienceBonus)
		end
	end
end

function JFD_GoldScienceFromCitiesDirty()
	local playerID = Game.GetActivePlayer()
    local player = Players[playerID]
	if player:IsTurnActive() then
        JFD_GoldScienceFromCities(playerID)
    end
end

if JFD_IsCivilisationActive(civilisationGreatBritainID) then
	GameEvents.PlayerCityFounded.Add(JFD_CityStartingGold)
	GameEvents.PlayerDoTurn.Add(JFD_GoldScienceFromCities)
	Events.SerialEventCityInfoDirty.Add(JFD_GoldScienceFromCitiesDirty)
end
--------------------------------------------------------------
-- JFD_RedcoatProduction
--------------------------------------------------------------
local promotionRedcoatID = GameInfoTypes["PROMOTION_JFD_REDCOAT_GARRISON"]
local buildingRedcoatProductionID = GameInfoTypes["BUILDING_JFD_REDCOAT_PRODUCTION"]

function JFD_RedcoatProduction(playerID)
	local player = Players[playerID]
	if player:IsEverAlive() then
		local playerUnhappiness = player:GetUnhappiness() - player:GetHappiness()
		for city in player:Cities() do
			if playerUnhappiness > 0 then
				if city:GetGarrisonedUnit() and city:GetGarrisonedUnit():IsHasPromotion(promotionRedcoatID) then
					city:SetNumRealBuilding(buildingRedcoatProductionID, 2*playerUnhappiness)
				else
					city:SetNumRealBuilding(buildingRedcoatProductionID, 0)
				end
			else
				city:SetNumRealBuilding(buildingRedcoatProductionID, 0)
			end
		end
	end
end

function JFD_RedcoatProductionCapture(oldOwnerID, isCapital, iX, iY, newOwnerID, iPop, bConquest)
	local player = Players[newOwnerID]
	if player:IsEverAlive() then
		local city = Map.GetPlot(iX, iY):GetPlotCity()
		if city then
			local playerUnhappiness = player:GetUnhappiness() - player:GetHappiness()
			if playerUnhappiness > 0 then
				if city:GetGarrisonedUnit() and city:GetGarrisonedUnit():IsHasPromotion(promotionRedcoatID) then
					city:SetNumRealBuilding(buildingRedcoatProductionID, 2*playerUnhappiness)
				else
					city:SetNumRealBuilding(buildingRedcoatProductionID, 0)
				end
			else
				city:SetNumRealBuilding(buildingRedcoatProductionID, 0)
			end
		end
	end
end

function JFD_RedcoatProductionInitialTrigger(playerID, unitID)
	local player = Players[playerID]
	local unit = player:GetUnitByID(unitID)
	if unit and unit:IsHasPromotion(GameInfoTypes["PROMOTION_JFD_REDCOAT_GARRISON"]) then
		GameEvents.PlayerDoTurn.Add(JFD_RedcoatProduction)
		GameEvents.UnitSetXY.Add(JFD_RedcoatProduction)
		GameEvents.PlayerCityFounded.Add(JFD_RedcoatProduction)
		GameEvents.CityCaptureComplete.Add(JFD_RedcoatProductionCapture)
		Events.SerialEventUnitCreated.Add(JFD_RedcoatProduction)
		Events.SerialEventUnitCreated.Remove(JFD_RedcoatProductionInitialTrigger)
		SetPersistentProperty("JFD_RedcoatProductionInitalised", true)
		JFD_RedcoatProduction(playerID)
	end
end

if GetPersistentProperty("JFD_RedcoatProductionInitalised") then
	GameEvents.PlayerDoTurn.Add(JFD_RedcoatProduction)
	GameEvents.UnitSetXY.Add(JFD_RedcoatProduction)
	GameEvents.PlayerCityFounded.Add(JFD_RedcoatProduction)
	GameEvents.CityCaptureComplete.Add(JFD_RedcoatProductionCapture)
	Events.SerialEventUnitCreated.Add(JFD_RedcoatProduction)
else
	Events.SerialEventUnitCreated.Add(JFD_RedcoatProductionInitialTrigger)
end
--==========================================================================================================================
-- CORE ELIZABETH FUNCTIONS
--==========================================================================================================================
-- JFD_ElizabethanPolicies
--------------------------------------------------------------------------------------------------------------------------
local civilisationEnglandID = GameInfoTypes["CIVILIZATION_ENGLAND"]
local policyEnglandAdmirals = GameInfoTypes["POLICY_ENGLAND_ADMIRALS"]

function JFD_ElizabethanPolicies(playerID, iX, iY)
	local player = Players[playerID]
	local plot = Map.GetPlot(iX, iY)
	local city = plot:GetPlotCity()
	if player:IsEverAlive() and player:GetCivilizationType() == civilisationEnglandID and city:IsCapital() then 
		if not player:HasPolicy(policyEnglandAdmirals) then
			player:SetNumFreePolicies(player:GetNumFreePolicies() + 1)
			player:SetNumFreePolicies(player:GetNumFreePolicies() - 1)
			player:SetHasPolicy(policyEnglandAdmirals, true)
		end
	end 	
end
--------------------------------------------------------------------------------------------------------------------------
-- JFD_ElizabethanAdmirals
--------------------------------------------------------------------------------------------------------------------------
local unitGreatAdmiralID = GameInfoTypes["UNIT_GREAT_ADMIRAL"]
local unitElizabethanGreatAdmiralID = GameInfoTypes["UNIT_JFD_ELIZABETHAN_ADMIRAL"]

function JFD_ElizabethanAdmiralTraining(playerID, unitID)
	local player = Players[playerID]
    if unitID == unitElizabethanGreatAdmiralID then 
		return 
	end
	return true
end
GameEvents.PlayerCanTrain.Add(JFD_ElizabethanAdmiralTraining)

function JFD_ElizabethanAdmirals(playerID, unitID)
    local player = Players[playerID]
	if player:IsEverAlive() and player:GetCivilizationType() == civilisationEnglandID then 
	  	 local unit = player:GetUnitByID(unitID)
		 if unit and unit:GetUnitType() == unitGreatAdmiralID then
			if player:IsHuman() then
				local newUnit = player:InitUnit(unitElizabethanGreatAdmiralID, unit:GetX(), unit:GetY(), UNITAI_ADMIRAL)
				newUnit:Convert(unit)
			else
				player:ChangeGoldenAgeTurns(4)
			end
	    end
	end
end
--------------------------------------------------------------------------------------------------------------------------
-- JFD_ElizabethanGoldenAges
--------------------------------------------------------------------------------------------------------------------------
local promotionElizabethanGoldenAgeID = GameInfoTypes["PROMOTION_JFD_ELIZABETH_GOLDEN_AGE"]

function JFD_ElizabethanGoldenAges(playerID)
	local player = Players[playerID]
	if player:IsEverAlive() and player:GetCivilizationType() == civilisationEnglandID then
		for unit in player:Units() do
			local unitCombatClass = unit:GetUnitCombatType()
			if unitCombatClass == "UNITCOMBAT_NAVALRANGED" or unitCombatClass == "UNITCOMBAT_NAVALMELEE" or unitCombatClass == "UNITCOMBAT_SUBMARINE" or unitCombatClass == "UNITCOMBAT_CARRIER" then
				if not unit:IsHasPromotion(promotionElizabethanGoldenAgeID) then
					unit:SetHasPromotion(promotionElizabethanGoldenAgeID, true)
				end
			else
				if unit:IsHasPromotion(promotionElizabethanGoldenAgeID) then
					unit:SetHasPromotion(promotionElizabethanGoldenAgeID, false)
				end
			end
		end
	end
end
----------------------------------------------------------------------------------------------------------------------------
-- JFD_ElizabethanPlaywrights
----------------------------------------------------------------------------------------------------------------------------
local unitElizabethanWriterID = GameInfoTypes["UNIT_JFD_ELIZABETHAN_WRITER"]
local buildingPlayhouseID = GameInfoTypes["BUILDING_JFD_PLAYHOUSE"]
local missionCreateGreatWorkID = GameInfoTypes["MISSION_CREATE_GREAT_WORK"]

function JFD_ElizabethanWriterTraining(playerID, unitID)
	local player = Players[playerID]
    if unitID == unitElizabethanWriterID then 
		return 
	end
	return true
end
GameEvents.PlayerCanTrain.Add(JFD_ElizabethanWriterTraining)

function JFD_ElizabethanPlaywrights(playerID, cityID, buildingID)
	local player = Players[playerID]
	if player:IsEverAlive() and player:GetCivilizationType() == civilisationEnglandID then 
		local playWrightsBorn = GetPersistentProperty("JFD_PlaywrightsBorn") or 0
		if buildingID == buildingPlayhouseID and playWrightsBorn < 4 then
			local city = player:GetCityByID(cityID)
			player:InitUnit(unitElizabethanWriterID, city:GetX(), city:GetY()):PushMission(missionCreateGreatWorkID)
			SetPersistentProperty("JFD_PlaywrightsBorn", playWrightsBorn+1)
		end
	end
end
--------------------------------------------------------------------------------------------------------------------------
-- JFD_GrandCarrackHealEnabled
--------------------------------------------------------------------------------------------------------------------------
local promotionGreatAdmiralID = GameInfoTypes["PROMOTION_GREAT_ADMIRAL"]
local promotionGrandCarrackHealID = GameInfoTypes["PROMOTION_JFD_GRAND_CARRACK_HEAL"]
local promotionGrandCarrackHealInfoID = GameInfoTypes["PROMOTION_JFD_GRAND_CARRACK_HEAL_INFO"]

function JFD_GrandCarrackHealEnabled(playerID)
	local player = Players[playerID]
	local admiralAdjacent = false
	if player:IsEverAlive() then
		for unit in player:Units() do
			if unit and unit:GetCombatLimit() > 0 then
				for admiral in player:Units() do
					if admiral and admiral:IsHasPromotion(promotionGreatAdmiralID) then
						if Map.PlotDistance(unit:GetX(), unit:GetY(), admiral:GetX(), admiral:GetY()) <= 1 then
							admiralAdjacent = true
							break
						end
					end
				end
				if admiralAdjacent then
					if not unit:IsHasPromotion(promotionGrandCarrackHealID) and unit:IsHasPromotion(promotionGrandCarrackHealInfoID) then
						unit:SetHasPromotion(promotionGrandCarrackHealID, true)
						unit:SetHasPromotion(promotionGrandCarrackHealInfoID, false)
					end
				else
					if not unit:IsHasPromotion(promotionGrandCarrackHealInfoID) and unit:IsHasPromotion(promotionGrandCarrackHealID) then
						unit:SetHasPromotion(promotionGrandCarrackHealID, false)
						unit:SetHasPromotion(promotionGrandCarrackHealInfoID, true)
					end
				end
			end
		end
	end
end

function JFD_GrandCarrackHealInitialTrigger(playerID, unitID)
	local player = Players[playerID]
	local unit = player:GetUnitByID(unitID)
	if unit and unit:IsHasPromotion(promotionGrandCarrackHealInfoID) then
		GameEvents.PlayerDoTurn.Add(JFD_GrandCarrackHealEnabled)
		GameEvents.UnitSetXY.Add(JFD_GrandCarrackHealEnabled)
		Events.SerialEventUnitCreated.Add(JFD_GrandCarrackHealEnabled)
		Events.SerialEventUnitCreated.Remove(JFD_GrandCarrackHealInitialTrigger)
		SetPersistentProperty("JFD_AdjacentToAdmiralInitalised", true)
		JFD_GrandCarrackHealEnabled(playerID)
	end
end

if JFD_IsCivilisationActive(civilisationEnglandID) then
	GameEvents.PlayerCityFounded.Add(JFD_ElizabethanPolicies)
	Events.SerialEventUnitCreated.Add(JFD_ElizabethanAdmirals)
	GameEvents.PlayerDoTurn.Add(JFD_ElizabethanGoldenAges)
	GameEvents.UnitSetXY.Add(JFD_ElizabethanGoldenAges)
	Events.SerialEventUnitCreated.Add(JFD_ElizabethanGoldenAges)
	GameEvents.CityConstructed.Add(JFD_ElizabethanPlaywrights)
	if GetPersistentProperty("JFD_AdjacentToAdmiralInitalised") then
		GameEvents.PlayerDoTurn.Add(JFD_GrandCarrackHealEnabled)
		GameEvents.UnitSetXY.Add(JFD_GrandCarrackHealEnabled)
		Events.SerialEventUnitCreated.Add(JFD_GrandCarrackHealEnabled)
	else
		Events.SerialEventUnitCreated.Add(JFD_GrandCarrackHealInitialTrigger)
	end
end
--==========================================================================================================================
--==========================================================================================================================