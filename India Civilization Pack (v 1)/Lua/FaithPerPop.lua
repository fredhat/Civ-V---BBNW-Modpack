-- FaithPerPop
-- Author: Sukritact
-- Edited By: F0S
--------------------------------------------------------------
WARN_NOT_SHARED = false; include( "SaveUtils" ); MY_MOD_NAME = "FaithPerPop";

local iMandir = GameInfo.Buildings["BUILDING_INDIAN_MANDIR"].ID
local iFakeFaith = GameInfo.Buildings["BUILDING_INDIA_FAITH_BONUS"].ID
local iDeltaModifier = 0.5
local civilisationID = GameInfoTypes["CIVILIZATION_INDIA"]

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

function FaithPerPop(iPlayer)
	local pPlayer = Players[iPlayer]
	if pPlayer:IsEverAlive() then
		for pCity in pPlayer:Cities() do
	        local iCity = pCity:GetID()
	        if pCity:IsHasBuilding(iMandir) then
				local iPop = pCity:GetPopulation()
				local iDelta = math.ceil(iPop * iDeltaModifier)
				pCity:SetNumRealBuilding(iFakeFaith, iDelta)
	        end
	    end
	end
end

function FaithPerPopDirty()
	local iPlayer = Game.GetActivePlayer()
    local pPlayer = Players[iPlayer]
	if pPlayer:IsTurnActive() then
        FaithPerPop(iPlayer)
    end
end

function FaithPerPopInitialTrigger(iPlayer, iCity, iBuilding)
	local pPlayer = Players[iPlayer]
	local pCity = pPlayer:GetCityByID(iCity)
	if pCity and pCity:IsHasBuilding(iMandir) then
		GameEvents.PlayerDoTurn.Add(FaithPerPop)
		Events.SerialEventGameDataDirty.Add(FaithPerPopDirty)
		GameEvents.CityConstructed.Remove(FaithPerPopInitialTrigger)
		save("GAME", "FaithPerPopInitalised", true)
		FaithPerPop(iPlayer)
	end
end

if JFD_IsCivilisationActive(civilisationID) then
	if load("GAME", "FaithPerPopInitalised") then
		GameEvents.PlayerDoTurn.Add(FaithPerPop)
		Events.SerialEventGameDataDirty.Add(FaithPerPopDirty)
	else
		GameEvents.CityConstructed.Add(FaithPerPopInitialTrigger)
	end
end