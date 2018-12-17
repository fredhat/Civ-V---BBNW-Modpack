-- JFD_Castile_Functions
-- Author: F0S
--==========================================================================================================================
-- UTILITIES
--==========================================================================================================================
-- GLOBALS
----------------------------------------------------------------------------------------------------------------------------
local civilisationID = GameInfoTypes["CIVILIZATION_JFD_CASTILE"]

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
-- UNIQUE FUNCTIONS
--==========================================================================================================================
local buildingCastileDummyID = GameInfoTypes["BUILDING_JFD_CASTILE_DUMMY_GOLDEN_AGE"]

function CircumnavigatedGoldenAge(teamID)
	for playerID = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
		local player = Players[playerID]
		if player:IsEverAlive() and player:GetCivilizationType() == civilisationID and player:GetTeam() == teamID then
			local capital = player:GetCapitalCity()
			if capital and not capital:IsHasBuilding(buildingCastileDummyID) then
				capital:SetNumRealBuilding(buildingCastileDummyID, 1)
			end
		end
	end
end

if JFD_IsCivilisationActive(civilisationID) then
	GameEvents.CircumnavigatedGlobe.Add(CircumnavigatedGoldenAge)
end
--==========================================================================================================================
--==========================================================================================================================