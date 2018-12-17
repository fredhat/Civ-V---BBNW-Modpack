-- PillarsOfAshoka
-- Author: Sukritact
-- Edited By: F0S
--------------------------------------------------------------
WARN_NOT_SHARED = false; include( "SaveUtils" ); MY_MOD_NAME = "PillarsOfAshoka";

local iPillars = GameInfo.Buildings["BUILDING_MAURYAN_PILLAR_OF_ASHOKA"].ID
local civilisationID = GameInfoTypes["CIVILIZATION_MAURYA"]

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

function BlockPillarsOfAshokaSell(iPlayer, iBuilding)
	if iBuilding == iPillars then
		return
	end
	return true
end

function PillarsOfAshoka(iPlayer)
    local pPlayer = Players[iPlayer]
	if pPlayer:IsEverAlive() and pPlayer:GetCivilizationType() == civilisationID then
		for pCity in pPlayer:Cities() do
			local iCity = pCity:GetID()
			if pCity:IsHasBuilding(iPillars) then
				if load(pPlayer, iCity) ~= true then
					local iReligion = pPlayer:GetReligionCreatedByPlayer()
					if iReligion <= 0 then iReligion = pPlayer:GetCapitalCity():GetReligiousMajority() end
					if iReligion ~= -1 then
						for religion in GameInfo.Religions("ID <> '" .. iReligion .. "'") do
							pCity:ConvertPercentFollowers(iReligion, religion.ID, 100)
						end
						pCity:AdoptReligionFully(iReligion)
						pCity:ConvertPercentFollowers(iReligion, -1, 100)
					end
					save(pPlayer, iCity, true)
				end
			end
		end
	end
end

function PillarsOfAshokaPolicyTrigger(iPlayer, iPolicy)
    local pPlayer = Players[iPlayer]
    if pPlayer:GetCivilizationType() == civilisationID and iPolicy == GameInfoTypes["POLICY_IRON_CURTAIN"] then
        GameEvents.PlayerDoTurn.Add(PillarsOfAshoka)
        GameEvents.CityConstructed.Add(PillarsOfAshoka)
		GameEvents.PlayerAdoptPolicy.Remove(PillarsOfAshokaPolicyTrigger)
        GameEvents.CityConstructed.Remove(PillarsOfAshokaInitialTrigger)
        save("GAME", "PillarsOfAshokaInitalised", true)
    end
end

function PillarsOfAshokaInitialTrigger(iPlayer, iCity, iBuilding)
    local pPlayer = Players[iPlayer]
	local pCity = pPlayer:GetCityByID(iCity)
    if pCity and pCity:IsHasBuilding(iPillars) then
        GameEvents.PlayerDoTurn.Add(PillarsOfAshoka)
        GameEvents.CityConstructed.Add(PillarsOfAshoka)
		GameEvents.PlayerAdoptPolicy.Remove(PillarsOfAshokaPolicyTrigger)
        GameEvents.CityConstructed.Remove(PillarsOfAshokaInitialTrigger)
        save("GAME", "PillarsOfAshokaInitalised", true)
        PillarsOfAshoka(iPlayer)
    end
end

if JFD_IsCivilisationActive(civilisationID) then
	GameEvents.CityBuildingsIsBuildingSellable.Add(BlockPillarsOfAshokaSell)
	if load("GAME", "PillarsOfAshokaInitalised") then
        GameEvents.PlayerDoTurn.Add(PillarsOfAshoka)
        GameEvents.CityConstructed.Add(PillarsOfAshoka)
    else
		GameEvents.PlayerAdoptPolicy.Add(PillarsOfAshokaPolicyTrigger)
        GameEvents.CityConstructed.Add(PillarsOfAshokaInitialTrigger)
    end
end