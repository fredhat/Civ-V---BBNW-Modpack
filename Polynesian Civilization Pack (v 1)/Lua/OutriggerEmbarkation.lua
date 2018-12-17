-- OutriggerEmbarkation
-- Author: JFD
-- Heavily Edited By: F0S
--=======================================================================================================================
WARN_NOT_SHARED = false; include( "Sukritact_SaveUtils.lua" ); MY_MOD_NAME = "OutriggerEmbarkation";
--=======================================================================================================================
-- Utility Functions
--=======================================================================================================================
-- JFD_IsCivilisationActive
-------------------------------------------------------------------------------------------------------------------------
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
--=======================================================================================================================
-- JFD_OutriggerEmbarkation
--=======================================================================================================================
local civilisationID = GameInfoTypes["CIVILIZATION_MC_TONGA"]
local promotionOutriggerID = GameInfoTypes["PROMOTION_MC_OUTRIGGER"]
local promotionAllwaterID = GameInfoTypes["PROMOTION_MC_ALLWATER_EMBARKATION"]
local techAstronomyID = GameInfoTypes["TECH_ASTRONOMY"]

function JFD_OutriggerEmbarkation(playerID)
	local player = Players[playerID]
	if player:IsEverAlive() then
		local teamID = player:GetTeam()
		local team = Teams[teamID]
		for unit in player:Units() do
			if unit and unit:IsEmbarked() then
				local sameTile = false
				local plot = unit:GetPlot()
				if plot then
					for iVal = 0,(plot:GetNumUnits() - 1) do
						local outrigger = plot:GetUnit(iVal)
						if outrigger:IsHasPromotion(promotionOutriggerID) and outrigger:GetOwner() == playerID then
							sameTile = true
						end
					end
				end
				if sameTile then
					if not team:IsHasTech(techAstronomyID) then
						if not unit:IsHasPromotion(promotionAllwaterID) then
							unit:SetHasPromotion(promotionAllwaterID, true)
						end
					else
						if unit:IsHasPromotion(promotionAllwaterID) then
							unit:SetHasPromotion(promotionAllwaterID, false)
						end
					end
				else
					if unit:IsHasPromotion(promotionAllwaterID) then
						if (plot and plot:GetTerrainType() ~= TerrainTypes.TERRAIN_OCEAN) or team:IsHasTech(techAstronomyID) then
							unit:SetHasPromotion(promotionAllwaterID, false)
						end
					end
				end
			else
				if unit:IsHasPromotion(promotionAllwaterID) then
					unit:SetHasPromotion(promotionAllwaterID, false)
				end
			end
		end
	end
end

function JFD_OutriggerEmbarkationTech(teamID, techID)
	local playerID = Teams[teamID]:GetLeaderID()
	local player = Players[playerID] 
	if player:IsEverAlive() then
		if techID == techAstronomyID then
			for unit in player:Units() do
				if unit and unit:IsHasPromotion(promotionAllwaterID) then
					unit:SetHasPromotion(promotionAllwaterID, false)
				end
			end
		end
	end
end

function OutriggerEmbarkationInitialTrigger(playerID, unitID)
	local player = Players[playerID]
	local unit = player:GetUnitByID(unitID)
	if unit and unit:IsHasPromotion(promotionOutriggerID) then
		GameEvents.PlayerDoTurn.Add(JFD_OutriggerEmbarkation)
		GameEvents.UnitSetXY.Add(JFD_OutriggerEmbarkation)
		GameEvents.TeamTechResearched.Add(JFD_OutriggerEmbarkationTech)
		Events.SerialEventUnitCreated.Remove(OutriggerEmbarkationInitialTrigger)
		save("GAME", "OutriggerEmbarkationInitalised", true)
		JFD_OutriggerEmbarkation(playerID)
	end
end

if JFD_IsCivilisationActive(civilisationID) then
	if load("GAME", "OutriggerEmbarkationInitalised") then
		GameEvents.PlayerDoTurn.Add(JFD_OutriggerEmbarkation)
		GameEvents.UnitSetXY.Add(JFD_OutriggerEmbarkation)
		GameEvents.TeamTechResearched.Add(JFD_OutriggerEmbarkationTech)
	else
		Events.SerialEventUnitCreated.Add(OutriggerEmbarkationInitialTrigger)
	end
end
--=======================================================================================================================
--=======================================================================================================================