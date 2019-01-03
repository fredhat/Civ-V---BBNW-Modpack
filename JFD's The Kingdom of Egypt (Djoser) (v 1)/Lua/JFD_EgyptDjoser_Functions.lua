-- JFD_EgyptDjoser_Functions
-- Author: JFD
-- Heavily Edited By: F0S
--==========================================================================================================================
-- INCLUDES
--==========================================================================================================================
WARN_NOT_SHARED = false; include( "Sukritact_SaveUtils.lua" ); MY_MOD_NAME = "JFD_EgyptDjoser_Functions";
--==========================================================================================================================
-- UTILITY FUNCTIONS
--==========================================================================================================================
-- MOD CHECKS
--------------------------------------------------------------------------------------------------------------------------
function JFD_IsCivilisationActive(civilizationID)
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
--==========================================================================================================================
-- GLOBALS
--==========================================================================================================================
-- Globals
----------------------------------------------------------------------------------------------------------------------------
local civilizationID = GameInfoTypes["CIVILIZATION_JFD_EGYPT_DJOSER"]
local isEgyptDjoserCivActive = JFD_IsCivilisationActive(civilizationID)
--==========================================================================================================================
-- UNIQUE FUNCTIONS
--==========================================================================================================================
-- FEATS OF IMUTHES
----------------------------------------------------------------------------------------------------------------------------
local buildingEgyptDjoserProductionBonusID = GameInfoTypes["BUILDING_JFD_EGYPT_DJOSER_PRODUCTION_MOD"]
local eraMedievalID = GameInfoTypes["ERA_MEDIEVAL"]
local resourceMarbleID = GameInfoTypes["RESOURCE_MARBLE"]
local buildingEgyptDjoserLimestoneBonusID = GameInfoTypes["BUILDING_JFD_EGYPT_DJOSER_LIMESTONE_BONUS"]

-- JFD_EgyptDjoser_ProductionModifiers
function JFD_EgyptDjoser_ProductionModifiers(playerID)
	local player = Players[playerID]
	if player:IsEverAlive() and player:GetCivilizationType() == civilizationID then 
		local productionModifier = player:GetWonderProductionModifier()
		for belief in GameInfo.Beliefs("WonderProductionModifier > 0") do
			local beliefID = belief.ID
			local obsoleteEraID = GameInfoTypes[belief.ObsoleteEra]
			if player:GetCurrentEra() < obsoleteEraID then
				if player:GetBeliefInPantheon() == beliefID then
					productionModifier = productionModifier + belief.WonderProductionModifier	
				end
			end
		end
		for policy in GameInfo.Policies("WonderProductionModifier > 0") do
			local policyID = policy.ID
			if player:HasPolicy(policyID) then
				productionModifier = productionModifier + policy.WonderProductionModifier
			end
		end
		for city in player:Cities() do
			local tempProductionModifier = productionModifier
			tempProductionModifier = tempProductionModifier + city:GetWonderProductionModifier()
			if player:GetCurrentEra() < eraMedievalID and city:IsHasResourceLocal(resourceMarbleID) then
				tempProductionModifier = tempProductionModifier + 15
			end
			city:SetNumRealBuilding(buildingEgyptDjoserProductionBonusID, math.floor(tempProductionModifier))
		end
	end
end

-- JFD_EgyptDjoser_ProductionModifiersDirty
function JFD_EgyptDjoser_ProductionModifiersDirty()
	local playerID = Game.GetActivePlayer()
    local player = Players[playerID]
	if player:IsTurnActive() then
        JFD_EgyptDjoser_ProductionModifiers(playerID)
    end
end

if isEgyptDjoserCivActive then
	GameEvents.PlayerDoTurn.Add(JFD_EgyptDjoser_ProductionModifiers)
	Events.SerialEventGameDataDirty.Add(JFD_EgyptDjoser_ProductionModifiersDirty)
end 
----------------------------------------------------------------------------------------------------------------------------
-- VIZIER
----------------------------------------------------------------------------------------------------------------------------
local improvementQuarryID = GameInfoTypes["IMPROVEMENT_QUARRY"]
local resourceLimestoneID = GameInfoTypes["RESOURCE_JFD_LIMESTONE"]
local buildingEgyptDjoserLimestoneBonusID = GameInfoTypes["BUILDING_JFD_EGYPT_DJOSER_LIMESTONE_BONUS"]
local unitVizierID = GameInfoTypes["UNIT_JFD_VIZIER"]
local improvementLimestoneID = GameInfoTypes["IMPROVEMENT_JFD_VIZIER_LIMESTONE"]

-- JFD_SetWonderProduction
function JFD_SetWonderProduction(playerID)
	local player = Players[playerID]
	if player:IsAlive() then 
		for city in player:Cities() do
			local hasLimestone = false
			local limestoneX = nil
			local limestoneY = nil
			for i = 0, city:GetNumCityPlots() - 1, 1 do
				local cityPlot = city:GetCityIndexPlot(i)
				if cityPlot then
					local improvementID = cityPlot:GetImprovementType() 
					local resourceID = cityPlot:GetResourceType()
					if improvementID == improvementQuarryID and resourceID == resourceLimestoneID and not cityPlot:IsImprovementPillaged() then
						hasLimestone = true
						limestoneX = cityPlot:GetX()
						limestoneY = cityPlot:GetY()
						break
					end
				end
			end
			if hasLimestone then
				if not city:IsHasBuilding(buildingEgyptDjoserLimestoneBonusID) then
					city:SetNumRealBuilding(buildingEgyptDjoserLimestoneBonusID, 1)
					if player:IsHuman() and player:IsTurnActive() then
						player:AddNotification(NotificationTypes["NOTIFICATION_DISCOVERED_BONUS_RESOURCE"], Locale.ConvertTextKey("TXT_KEY_NOTIFICATION_RESOURCE_JFD_LIMESTONE_DESC"), Locale.ConvertTextKey("TXT_KEY_NOTIFICATION_RESOURCE_JFD_LIMESTONE_SHORT_DESC"), limestoneX, limestoneY, resourceLimestoneID)
					end
				end
			else
				if city:IsHasBuilding(buildingEgyptDjoserLimestoneBonusID) then
					city:SetNumRealBuilding(buildingEgyptDjoserLimestoneBonusID, 0)
				end
			end
		end
	end
end

-- JFD_VizierBuilds
function JFD_VizierBuilds(playerID, plotX, plotY, improvementID)
	local player = Players[playerID]
	if player:IsAlive() then 
		local plot = Map.GetPlot(plotX, plotY)
		if plot and improvementID == improvementLimestoneID then
			plot:SetImprovementType(-1)
			plot:SetResourceType(resourceLimestoneID, 1)
			plot:SetNumResource(1)
			plot:SetImprovementType(improvementQuarryID)
			JFD_SetWonderProduction(playerID)
		end
	end
end

-- JFD_SetWonderProductionDirty
function JFD_SetWonderProductionDirty()
	local playerID = Game.GetActivePlayer()
    local player = Players[playerID]
	if player:IsTurnActive() then
        JFD_SetWonderProduction(playerID)
    end
end

-- JFD_VizierInitialTrigger
function JFD_VizierInitialTrigger(playerID, unitID)
	local player = Players[playerID]
	local unit = player:GetUnitByID(unitID)
	if unit and unit:GetUnitType() == unitVizierID then
		GameEvents.BuildFinished.Add(JFD_VizierBuilds)
		Events.SerialEventGameDataDirty.Add(JFD_SetWonderProductionDirty)
		Events.SerialEventUnitCreated.Remove(JFD_VizierInitialTrigger)
		save("GAME", "JFD_VizierInitalised", true)
	end
end

if load("GAME", "JFD_VizierInitalised") then
	GameEvents.BuildFinished.Add(JFD_VizierBuilds)
	Events.SerialEventGameDataDirty.Add(JFD_SetWonderProductionDirty)
else
	Events.SerialEventUnitCreated.Add(JFD_VizierInitialTrigger)
end
--==========================================================================================================================
--==========================================================================================================================