-- HeiauSpecialist
-- Author: JFD
-- Heavily Edited By: F0S
--=======================================================================================================================
WARN_NOT_SHARED = false; include( "Sukritact_SaveUtils.lua" ); MY_MOD_NAME = "HaiauSpecialist";
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
-------------------------------------------------------------------------------------------------------------------------
-- JFD_GetRandom
-------------------------------------------------------------------------------------------------------------------------
function JFD_GetRandom(lower, upper)
	return Game.Rand((upper + 1) - lower, "") + lower
end
--=======================================================================================================================
-- JFD_HeiauSpecialist
--=======================================================================================================================
local civilisationID = GameInfoTypes["CIVILIZATION_POLYNESIA"]
local buildingHeiauID = GameInfoTypes["BUILDING_MC_HAWAIIAN_HEIAU"]
local tableSpecialistBuildings = {
	[GameInfoTypes.BUILDING_MC_HEIAU_SCIENTIST] = 1,
	[GameInfoTypes.BUILDING_MC_HEIAU_MERCHANT] = 2,
	[GameInfoTypes.BUILDING_MC_HEIAU_ENGINEER] = 3,
	[GameInfoTypes.BUILDING_MC_HEIAU_ARTIST] = 4,
	[GameInfoTypes.BUILDING_MC_HEIAU_MUSICIAN] = 5,
	[GameInfoTypes.BUILDING_MC_HEIAU_WRITER] = 6
}
local tableSpecialistBuildingsAlt = {
	[GameInfoTypes.BUILDING_MC_HEIAU_SCIENTIST_ALT] = 1,
	[GameInfoTypes.BUILDING_MC_HEIAU_MERCHANT_ALT] = 2,
	[GameInfoTypes.BUILDING_MC_HEIAU_ENGINEER_ALT] = 3,
	[GameInfoTypes.BUILDING_MC_HEIAU_ARTIST_ALT] = 4,
	[GameInfoTypes.BUILDING_MC_HEIAU_MUSICIAN_ALT] = 5,
	[GameInfoTypes.BUILDING_MC_HEIAU_WRITER_ALT] = 6
}
 
function JFD_HeiauSpecialist(playerID)
	local player = Players[playerID]
	if player:IsEverAlive() and player:GetCivilizationType() == civilisationID then
		for city in player:Cities() do
			if city and city:IsHasBuilding(buildingHeiauID) then
				local hasSpecialistBuilding = false
				for buildingID, buildingIndex in pairs(tableSpecialistBuildings) do
					if city:IsHasBuilding(buildingID) then
						hasSpecialistBuilding = true
					end
				end
				if not hasSpecialistBuilding then
					local randomBuilding = JFD_GetRandom(1, 6)
					for buildingID, buildingIndex in pairs(tableSpecialistBuildings) do
						if buildingIndex == randomBuilding then
							city:SetNumRealBuilding(buildingID, 1)
						end
					end
				end
				local hasSpecialistBuildingAlt = false
				for buildingID, buildingIndex in pairs(tableSpecialistBuildingsAlt) do
					if city:IsHasBuilding(buildingID) then
						hasSpecialistBuildingAlt = true
					end
				end
				if not hasSpecialistBuildingAlt then
					local randomBuilding = JFD_GetRandom(1, 6)
					for buildingID, buildingIndex in pairs(tableSpecialistBuildingsAlt) do
						if buildingIndex == randomBuilding then
							city:SetNumRealBuilding(buildingID, 1)
						end
					end
				end
			end
		end
	end
end

function JFD_HeiauSpecialistDirty()
	local playerID = Game.GetActivePlayer()
    local player = Players[playerID]
	if player:IsTurnActive() then
        JFD_HeiauSpecialist(playerID)
    end
end

function JFD_HeiauSpecialistInitialTrigger(playerID, cityID, buildingID)
	local player = Players[playerID]
	local city = player:GetCityByID(cityID)
	if city and city:IsHasBuilding(buildingHeiauID) then
		GameEvents.PlayerDoTurn.Add(JFD_HeiauSpecialist)
		Events.SerialEventGameDataDirty.Add(JFD_HeiauSpecialistDirty)
		GameEvents.CityConstructed.Remove(JFD_HeiauSpecialistInitialTrigger)
		save("GAME", "JFD_HeiauInitalised", true)
		JFD_HeiauSpecialist(playerID)
	end
end

if JFD_IsCivilisationActive(civilisationID) then
	if load("GAME", "JFD_HeiauInitalised") then
		GameEvents.PlayerDoTurn.Add(JFD_HeiauSpecialist)
		Events.SerialEventGameDataDirty.Add(JFD_HeiauSpecialistDirty)
	else
		GameEvents.CityConstructed.Add(JFD_HeiauSpecialistInitialTrigger)
	end
end
--=======================================================================================================================
--=======================================================================================================================