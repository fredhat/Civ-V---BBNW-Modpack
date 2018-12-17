-- JFD_ScotlandUIExperience
-- Author: JFD
-- Edited By: F0S
--==========================================================================================================================
-- UTILITY FUNCTIONS
--==========================================================================================================================
WARN_NOT_SHARED = false; include( "Sukritact_SaveUtils.lua" ); MY_MOD_NAME = "JFD_ScotlandUIExperience";
--------------------------------------------------------------
-- JFD_IsCivilisationActive
--------------------------------------------------------------
local civilisationID = GameInfoTypes["CIVILIZATION_MC_SCOTLAND"]

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
-- CORE SCOTLAND FUNCTIONS
--==========================================================================================================================
--JFD_ClanCastleExperience
----------------------------------------------------------------------------------------------------------------------------
local improvementScottishClanCastleID = GameInfoTypes["IMPROVEMENT_MC_SCOTTISH_CLAN_CASTLE"]
local buildingScottishClanCastleExperienceID = GameInfoTypes["BUILDING_MC_SCOTTISH_CLAN_CASTLE_EXPERIENCE"]

function JFD_GetNumberWorkedClanCastles(playerID, city)
	local numWorkedClanCastles = 0
	for cityPlot = 0, city:GetNumCityPlots() - 1, 1 do
		local plot = city:GetCityIndexPlot(cityPlot)
		if plot then
			if plot:GetOwner() == playerID then
				if city:IsWorkingPlot(plot) then	
					if plot:GetImprovementType() == improvementScottishClanCastleID and not plot:IsImprovementPillaged() then 
						numWorkedClanCastles = numWorkedClanCastles + 1
					end
				end
			end
		end
	end
	return numWorkedClanCastles
end

function JFD_ClanCastleExperience(playerID)
	local player = Players[playerID]
	if player:IsEverAlive() then
		for city in player:Cities() do
			if city then
				local numClanCastles = JFD_GetNumberWorkedClanCastles(playerID, city)
				if city:GetNumBuilding(buildingScottishClanCastleExperienceID) ~= numClanCastles then
					city:SetNumRealBuilding(buildingScottishClanCastleExperienceID, numClanCastles)
				end
			end
		end
	end
end

function JFD_ClanCastleExperienceDirty()
	local playerID = Game.GetActivePlayer()
    local player = Players[playerID]
	if player:IsTurnActive() then
        JFD_ClanCastleExperience(playerID)
    end
end

function JFD_ClanCastleExperienceInitialTrigger(playerID, plotX, plotY, improvementID)
	if improvementID == improvementScottishClanCastleID then
		GameEvents.PlayerDoTurn.Add(JFD_ClanCastleExperience)
		Events.SerialEventGameDataDirty.Add(JFD_ClanCastleExperienceDirty)
		GameEvents.BuildFinished.Remove(JFD_ClanCastleExperienceInitialTrigger)
		save("GAME", "JFD_ClanCastleExperienceInitalised", true)
		JFD_ClanCastleExperience(playerID)
	end
end

if JFD_IsCivilisationActive(civilisationID) then
	if load("GAME", "JFD_ClanCastleExperienceInitalised") then
		GameEvents.PlayerDoTurn.Add(JFD_ClanCastleExperience)
		Events.SerialEventGameDataDirty.Add(JFD_ClanCastleExperienceDirty)
	else
		GameEvents.BuildFinished.Add(JFD_ClanCastleExperienceInitialTrigger)
	end
end
--==========================================================================================================================
--==========================================================================================================================