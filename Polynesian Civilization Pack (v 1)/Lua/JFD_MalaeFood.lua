-- JFD_MalaeFood
-- Author: JFD
-- Edited By: F0S
--=======================================================================================================================
WARN_NOT_SHARED = false; include( "Sukritact_SaveUtils.lua" ); MY_MOD_NAME = "JFD_MalaeFood";
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
-- Malae Food
--=======================================================================================================================
local civilisationID = GameInfoTypes["CIVILIZATION_MC_TONGA"]
local direction_types = {
	DirectionTypes["DIRECTION_NORTHEAST"],
	DirectionTypes["DIRECTION_NORTHWEST"],
	DirectionTypes["DIRECTION_EAST"],
	DirectionTypes["DIRECTION_SOUTHEAST"],
	DirectionTypes["DIRECTION_SOUTHWEST"],
	DirectionTypes["DIRECTION_WEST"]
}
local terrainCoastID = GameInfoTypes["TERRAIN_COAST"]
local buildingTonganMalaeID = GameInfoTypes["BUILDING_MC_TONGAN_MALAE"]
local buildingMalaeFoodID = GameInfoTypes["BUILDING_MC_MALAE_FOOD"]
 
function JFD_GetNumAdjacentSeaTiles(city)
	local numAdjacentSeaTiles = 0
	local plot = Map.GetPlot(city:GetX(), city:GetY())
	if plot then
		for loop, direction in ipairs(direction_types) do
			local adjPlot = Map.PlotDirection(city:GetX(), city:GetY(), direction)
			if adjPlot and adjPlot:GetTerrainType() == terrainCoastID then     
				numAdjacentSeaTiles = numAdjacentSeaTiles + 1
			end
		end
	end
	return numAdjacentSeaTiles     
end
 
function JFD_MalaeFood(playerID)
	local player = Players[playerID]
	if player:IsEverAlive() then
		for city in player:Cities() do
			if city then
				if city:IsHasBuilding(buildingTonganMalaeID) then
					if JFD_GetNumAdjacentSeaTiles(city) > 2 and not city:IsHasBuilding(buildingMalaeFoodID) then
						city:SetNumRealBuilding(buildingMalaeFoodID, 1)
					end
				else
					city:SetNumRealBuilding(buildingMalaeFoodID, 0)
				end
			end
		end
	end
end

function JFD_MalaeFoodDirty(playerID, cityID, updateType)
	if updateType ~= CityUpdateTypes.CITY_UPDATE_TYPE_PRODUCTION then return end
	JFD_MalaeFood(playerID)
end

function JFD_MalaeFoodInitialTrigger(playerID, cityID, iBuilding)
	local player = Players[playerID]
	local city = player:GetCityByID(cityID)
	if city and city:IsHasBuilding(buildingTonganMalaeID) then
		GameEvents.PlayerDoTurn.Add(JFD_MalaeFood)
		Events.SpecificCityInfoDirty.Add(JFD_MalaeFoodDirty)
		GameEvents.CityConstructed.Remove(JFD_MalaeFoodInitialTrigger)
		save("GAME", "JFD_MalaeFoodInitalised", true)
		JFD_MalaeFood(playerID)
	end
end

if JFD_IsCivilisationActive(civilisationID) then
	if load("GAME", "JFD_MalaeFoodInitalised") then
		GameEvents.PlayerDoTurn.Add(JFD_MalaeFood)
		Events.SpecificCityInfoDirty.Add(JFD_MalaeFoodDirty)
	else
		GameEvents.CityConstructed.Add(JFD_MalaeFoodInitialTrigger)
	end
end
--=======================================================================================================================
--=======================================================================================================================