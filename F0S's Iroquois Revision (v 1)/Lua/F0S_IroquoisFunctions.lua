-- F0S_IroquoisFunctions
-- Author: F0S
--==========================================================================================================================
-- UTILITY FUNCTIONS
--==========================================================================================================================
WARN_NOT_SHARED = false; include( "Sukritact_SaveUtils.lua" ); MY_MOD_NAME = "F0S_IroquoisFunctions";
--==========================================================================================================================
-- JFD_IsCivilisationActive
--------------------------------------------------------------
local civilisationID = GameInfoTypes["CIVILIZATION_IROQUOIS"]

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
-------------------------------------------------------------------------------------------------------------------------
-- GetRandom
-------------------------------------------------------------------------------------------------------------------------
function GetRandom(lower, upper)
	return Game.Rand((upper + 1) - lower, "") + lower
end
--=======================================================================================================================
-- CORE IROQUOIS FUNCTIONS	
--=======================================================================================================================
-- F0S_IsMohawkInvisible
--------------------------------------------------------------
local promotionForestInvisibleInfoID = GameInfoTypes["PROMOTION_F0S_FOREST_INVISIBLE_INFO"]
local promotionForestInvisibleID = GameInfoTypes["PROMOTION_F0S_FOREST_INVISIBLE"]

function F0S_IsMohawkInvisible(playerID, unit, unitX, unitY)
	local plot = Map.GetPlot(unitX, unitY)
	if plot and plot:GetFeatureType() == FeatureTypes.FEATURE_FOREST then
		if unit:IsHasPromotion(promotionForestInvisibleInfoID) then
			unit:SetHasPromotion(promotionForestInvisibleInfoID, false)
			unit:SetHasPromotion(promotionForestInvisibleID, true)
		end
	else
		if unit:IsHasPromotion(promotionForestInvisibleID) then
			unit:SetHasPromotion(promotionForestInvisibleInfoID, true)
			unit:SetHasPromotion(promotionForestInvisibleID, false)
		end
	end
end

function F0S_IsMohawkInvisibleTurn(playerID)
	local player = Players[playerID]
	if player:IsEverAlive() then
		for unit in player:Units() do
			if unit then F0S_IsMohawkInvisible(playerID, unit, unit:GetX(), unit:GetY()) end
		end
	end
end

function F0S_IsMohawkInvisibleXY(playerID, unitID)
	local player = Players[playerID]
	if player:IsEverAlive() then
		local unit = player:GetUnitByID(unitID)
		if unit then F0S_IsMohawkInvisible(playerID, unit, unit:GetX(), unit:GetY()) end
	end
end

function F0S_IsMohawkInvisibleInitialTrigger(playerID, unitID)
	local player = Players[playerID]
	local unit = player:GetUnitByID(unitID)
	if unit and unit:IsHasPromotion(promotionForestInvisibleInfoID) then
		GameEvents.PlayerDoTurn.Add(F0S_IsMohawkInvisibleTurn)
		GameEvents.UnitSetXY.Add(F0S_IsMohawkInvisibleXY)
		Events.SerialEventUnitCreated.Add(F0S_IsMohawkInvisibleXY)
		Events.SerialEventUnitCreated.Remove(F0S_IsMohawkInvisibleInitialTrigger)
		save("GAME", "F0S_IsMohawkInvisibleInitalised", true)
		F0S_IsMohawkInvisibleXY(playerID, unitID)
	end
end

if load("GAME", "F0S_IsMohawkInvisibleInitalised") then
	GameEvents.PlayerDoTurn.Add(F0S_IsMohawkInvisibleTurn)
	GameEvents.UnitSetXY.Add(F0S_IsMohawkInvisibleXY)
	Events.SerialEventUnitCreated.Add(F0S_IsMohawkInvisibleXY)
else
	Events.SerialEventUnitCreated.Add(F0S_IsMohawkInvisibleInitialTrigger)
end
--------------------------------------------------------------
-- F0S_PlantForest
--------------------------------------------------------------
local improvementPlantForestID = GameInfoTypes["IMPROVEMENT_PLANT_FOREST"]
local tableForestResources = {}	
local resourceChance = 10

function F0S_IsValidReforest(plot)
	local terrainType = plot:GetTerrainType()
	if plot:IsWater() or plot:IsMountain() or plot:IsCity() then return false end
	if terrainType == TerrainTypes.TERRAIN_SNOW or terrainType == TerrainTypes.TERRAIN_DESERT then return false end
	if plot:GetImprovementType() == improvementPlantForestID then return true end
	return false
end

function F0S_PlantForest(playerID, iX, iY, improvementID)
	local player = Players[playerID]
    if player:IsEverAlive() and player:GetCivilizationType() == civilisationID then 
		if improvementID and improvementID == improvementPlantForestID then
			local plot = Map.GetPlot(iX, iY)
			if plot and IsValidReforest(plot) then
				plot:SetImprovementType(-1)
				plot:SetFeatureType(FeatureTypes.FEATURE_FOREST, -1)
				if #tableForestResources > 0 and GetRandom(1, 100) <= resourceChance then
					local resourceID = GameInfo.Resources[tableForestResources[GetRandom(1, #tableForestResources)]].ID
					if resourceID then
						plot:SetResourceType(resourceID, 1)
					end
				end
				if load("GAME", "F0S_IsMohawkInvisibleInitalised") then
					F0S_IsMohawkInvisibleTurn(playerID)
				end
			end
		end
	end
end

if JFD_IsCivilisationActive(civilisationID) then
	if #tableForestResources == 0 then
		for row in GameInfo.Resource_FeatureBooleans("FeatureType = 'FEATURE_FOREST'") do
			table.insert(tableForestResources, row.ResourceType)
		end
	end
	GameEvents.BuildFinished.Add(F0S_PlantForest)
end
--==========================================================================================================================
--==========================================================================================================================