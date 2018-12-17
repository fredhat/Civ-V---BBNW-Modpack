-- JFD_Ottoman_Functions
-- Original Author: JFD
-- Edited By: F0S
--==========================================================================================================================
-- UTILITY FUNCTIONS
--==========================================================================================================================
-- JFD_IsCivilisationActive
--------------------------------------------------------------
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
-- CORE FUNCTIONS	
--==========================================================================================================================
-- JFD_OTTOMANS
----------------------------------------------------------------------------------------------------------------------------
local iCivType = GameInfoTypes["CIVILIZATION_OTTOMAN"]
local iFakeFaith = GameInfoTypes["BUILDING_JFD_OTTOMANS_FAITH"]
local iFakeCulture = GameInfoTypes["BUILDING_JFD_OTTOMANS_CULTURE"]
local iFakeScience = GameInfoTypes["BUILDING_JFD_OTTOMANS_SCIENCE"]
local iTrackFaith = GameInfoTypes["BUILDING_JFD_OTTOMANS_TRACK_F"]
local iTrackCulture = GameInfoTypes["BUILDING_JFD_OTTOMANS_TRACK_C"]
local iTrackScience = GameInfoTypes["BUILDING_JFD_OTTOMANS_TRACK_S"]
local iArtisticGenius = GameInfoTypes["POLICY_ARTISTIC_GENIUS"]
local iCulturalExchange = GameInfoTypes["POLICY_ETHICS"]
local iFreeThought = GameInfoTypes["POLICY_FREE_THOUGHT"]
local iScientificRevolution = GameInfoTypes["POLICY_SCIENTIFIC_REVOLUTION"]
local tSpecialists = {
	[GameInfoTypes["SPECIALIST_WRITER"]] = 1,
	[GameInfoTypes["SPECIALIST_ARTIST"]] = 2,
	[GameInfoTypes["SPECIALIST_MUSICIAN"]] = 3,
	[GameInfoTypes["SPECIALIST_SCIENTIST"]] = 4,
	[GameInfoTypes["SPECIALIST_ENGINEER"]] = 5,
	[GameInfoTypes["SPECIALIST_MERCHANT"]] = 6,
}
local tReligion = {}

function OttomanUA(iPlayer)
	local pPlayer = Players[iPlayer]
	if pPlayer:IsEverAlive() and pPlayer:GetCivilizationType() == iCivType then
		for pCity in pPlayer:Cities() do
			local iNumReligions = 0
			for sKey, iVal in pairs(tReligion) do
				if pCity:GetNumFollowers(iVal) >= 1 then
					iNumReligions = iNumReligions + 1
				end
			end
			local iNumSpecialists = 0
			for iSpecialist, iVal in pairs(tSpecialists) do
				iNumSpecialists = iNumSpecialists + pCity:GetSpecialistCount(iSpecialist)
			end
			pCity:SetNumRealBuilding(iFakeFaith, iNumReligions * iNumSpecialists)
			pCity:SetNumRealBuilding(iTrackFaith, iNumReligions)
			if pPlayer:HasPolicy(iArtisticGenius) and pPlayer:HasPolicy(iCulturalExchange) then
				pCity:SetNumRealBuilding(iFakeCulture, (iNumReligions + 1) * iNumSpecialists)
				pCity:SetNumRealBuilding(iTrackCulture, iNumReligions + 1)
			end
			if pPlayer:HasPolicy(iFreeThought) and pPlayer:HasPolicy(iScientificRevolution) then
				pCity:SetNumRealBuilding(iFakeScience, (iNumReligions + 1) * iNumSpecialists)
				pCity:SetNumRealBuilding(iTrackScience, iNumReligions + 1)
			end
		end
	end
end

function OttomanUADirty()
	local iPlayer = Game.GetActivePlayer()
    local pPlayer = Players[iPlayer]
	if pPlayer:IsTurnActive() then
        OttomanUA(iPlayer)
    end
end

if JFD_IsCivilisationActive(iCivType) then
	for Religion in GameInfo.Religions() do
		if Religion.ID ~= GameInfo.Religions.RELIGION_PANTHEON.ID then
			tReligion[Religion.Type] = Religion.ID
		end
	end
	GameEvents.PlayerDoTurn.Add(OttomanUA)
	Events.SerialEventGameDataDirty.Add(OttomanUADirty)
end
----------------------------------------------------------------------------------------------------------------------------
-- JFD_VANDALS
----------------------------------------------------------------------------------------------------------------------------
local iCivTypeAlt = GameInfoTypes["CIVILIZATION_JFD_THE_VANDALS"]
local iPolicyVandals = GameInfoTypes["POLICY_JFD_VANDALS"]

function InitVandals(player)
	for playerID, player in pairs(Players) do
		local player = Players[playerID]
		if player:GetCivilizationType() == iCivTypeAlt then
			if not player:HasPolicy(iPolicyVandals) then
				player:SetNumFreePolicies(player:GetNumFreePolicies() + 1)
				player:SetNumFreePolicies(player:GetNumFreePolicies() - 1)
				player:SetHasPolicy(iPolicyVandals, true)	
			end
		end
	end 
end

if JFD_IsCivilisationActive(iCivTypeAlt) then
	Events.SequenceGameInitComplete.Add(InitVandals)
end
--==========================================================================================================================
--==========================================================================================================================