-- JFD_NorwayFunctions
-- Author: JFD
-- Edited By: F0S
--=======================================================================================================================
-- UTILITY FUNCTIONS	
--=======================================================================================================================
-- JFD_IsCivilisationActive
------------------------------------------------------------------------------------------------------------------------
WARN_NOT_SHARED = false; include( "Sukritact_SaveUtils.lua" ); MY_MOD_NAME = "JFD_NorwayFunctions";
include("PlotIterators")

local civilisationID = GameInfoTypes["CIVILIZATION_JFD_NORWAY"]

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
-- CORE FUNCTIONS	
--=======================================================================================================================
--InitHaakon
-------------------------------------------------------------------------------------------------------------------------
function JFD_RevealCoast(playerID)
	local player = Players[playerID]
	local startingPlot = player:GetStartingPlot()
	local teamID = player:GetTeam()
	local distance = 20
	if Map.GetWorldSize() >= GameInfoTypes["WORLDSIZE_HUGE"] then distance = 30 end
	for i = 0, Map.GetNumPlots() - 1, 1 do
		local plot = Map.GetPlotByIndex(i)
		if plot and plot:GetTerrainType() == GameInfoTypes["TERRAIN_COAST"] and Map.PlotDistance(startingPlot:GetX(), startingPlot:GetY(), plot:GetX(), plot:GetY()) <= distance then
			plot:SetRevealed(teamID, true)
			plot:UpdateFog()
		end
	end
end

function JFD_InitHaakon(player)
	for playerID = 0, GameDefines.MAX_MAJOR_CIVS - 1 do
		local player = Players[playerID]
		if player:IsEverAlive() and player:GetCivilizationType() == civilisationID then
			player:SetEmbarkedGraphicOverride("ART_DEF_UNIT_U_DANISH_LONGBOAT")
			JFD_RevealCoast(playerID)
		end
	end 
end
--------------------------------------------------------------------------------------------------------------------------
-- JFD_NorwayFish
--------------------------------------------------------------------------------------------------------------------------
local resourceFishID = GameInfoTypes["RESOURCE_FISH"]
local radius = 3

function GetRandom(lower, upper)
    return Game.Rand((upper + 1) - lower, "") + lower
end

function JFD_NorwayFish(playerID, iX, iY)
	local player = Players[playerID]
	if player:IsEverAlive() and player:GetCivilizationType() == civilisationID then
		local plot = Map.GetPlot(iX, iY)
		if plot then
			local city = plot:GetPlotCity()
			if city and city:IsOriginalCapital() then
				local tablePlots = {}
				for loopPlot in PlotAreaSweepIterator(plot, radius, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
					table.insert(tablePlots, loopPlot)
				end
				local isPlaced = false
				while not isPlaced and #tablePlots > 0 do
					local randomPlot = GetRandom(1, #tablePlots)
					local spawnPlot = tablePlots[randomPlot]
					if spawnPlot then
						if spawnPlot:GetTerrainType() == GameInfoTypes["TERRAIN_COAST"] and spawnPlot:GetFeatureType() == -1 and not spawnPlot:IsLake() and not spawnPlot:IsCity() and spawnPlot:GetResourceType() == -1 and (spawnPlot:GetOwner() == -1 or spawnPlot:GetOwner() == playerID) then
							spawnPlot:SetResourceType(resourceFishID, 1)
							spawnPlot:SetOwner(-1)
							spawnPlot:SetOwner(playerID, city:GetID())
							spawnPlot:SetRevealed(player:GetTeam(), true)
							spawnPlot:UpdateFog()
							isPlaced = true
						end
					end
					table.remove(tablePlots, randomPlot)
				end
			end
		end
	end 	
end
--------------------------------------------------------------------------------------------------------------------------
-- JFD_StaveChurch
--------------------------------------------------------------------------------------------------------------------------
local buildingStaveChurchID = GameInfoTypes["BUILDING_JFD_STAVE_CHURCH"]
local buildingStaveStorageID = GameInfoTypes["BUILDING_JFD_STAVE_STORAGE"]
local buildingNorwayFishID = GameInfoTypes["BUILDING_JFD_NORWAY_FISH"]

function JFD_StaveChurch(playerID)
	local player = Players[playerID]
	if player:IsEverAlive() then
		for city in player:Cities() do
			if city:IsHasBuilding(buildingStaveChurchID) then
				city:SetNumRealBuilding(buildingStaveStorageID, math.min(city:GetBaseYieldRate(YieldTypes.YIELD_FAITH), 20))
			else
				if city:IsHasBuilding(buildingStaveStorageID) then
					city:SetNumRealBuilding(buildingStaveStorageID, 0)
				end
			end
			if not city:IsHasBuilding(buildingNorwayFishID) then
				city:SetNumRealBuilding(buildingNorwayFishID, 1)
			end
		end
	end
end

function JFD_StaveChurchDirty()
	local playerID = Game.GetActivePlayer()
    local player = Players[playerID]
	if player:IsTurnActive() then
        JFD_StaveChurch(playerID)
    end
end

function JFD_StaveChurchInitialTrigger(playerID, cityID, buildingID)
	local player = Players[playerID]
	local city = player:GetCityByID(cityID)
	if city and city:IsHasBuilding(buildingStaveChurchID) then
		GameEvents.PlayerDoTurn.Add(JFD_StaveChurch)
		Events.SerialEventGameDataDirty.Add(JFD_StaveChurchDirty)
		GameEvents.CityConstructed.Remove(JFD_StaveChurchInitialTrigger)
		save("GAME", "JFD_StaveChurchInitalised", true)
		JFD_StaveChurch(playerID)
	end
end
--------------------------------------------------------------------------------------------------------------------------
-- JFD_OnModernEra
--------------------------------------------------------------------------------------------------------------------------
local eraRenaissanceID = GameInfoTypes["ERA_RENAISSANCE"]
local eraIndustrialID = GameInfoTypes["ERA_INDUSTRIAL"]

function JFD_OnModernEra(arg0,playerID)
	local player = Players[playerID]
	local currentEraID = player:GetCurrentEra()
	if player:IsEverAlive() and player:GetCivilizationType() == civilisationID then
		if currentEraID == eraRenaissanceID then
			player:SetEmbarkedGraphicOverride("ART_DEF_UNIT_GALLEON")
		elseif currentEraID == eraIndustrialID then
			player:SetEmbarkedGraphicOverride("ART_DEF_UNIT_TRANSPORT")
		end
	end
end

if JFD_IsCivilisationActive(civilisationID) then
	Events.LoadScreenClose.Add(JFD_InitHaakon)
	GameEvents.PlayerCityFounded.Add(JFD_NorwayFish)
	if load("GAME", "JFD_StaveChurchInitalised") then
		GameEvents.PlayerDoTurn.Add(JFD_StaveChurch)
		Events.SerialEventGameDataDirty.Add(JFD_StaveChurchDirty)
	else
		GameEvents.CityConstructed.Add(JFD_StaveChurchInitialTrigger)
	end
	Events.SerialEventEraChanged.Add(JFD_OnModernEra)
end
--==========================================================================================================================
--==========================================================================================================================