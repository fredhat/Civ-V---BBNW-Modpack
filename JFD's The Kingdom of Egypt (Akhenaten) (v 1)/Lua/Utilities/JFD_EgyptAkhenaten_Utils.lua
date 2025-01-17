-- JFD_EgyptAkhenaten_Utils
-- Author: JFD
-- Edited By: F0S
--==========================================================================================================================
-- INCLUDES
--==========================================================================================================================
include("FLuaVector.lua")
include("PlotIterators.lua")
WARN_NOT_SHARED = false; include("NewSaveUtils.lua"); MY_MOD_NAME = "JFD_EgyptAkhenaten";
--==========================================================================================================================
-- UTILITY FUNCTIONS
--------------------------------------------------------------------------------------------------------------------------
-- JFD_GetRandom
function JFD_GetRandom(lower, upper)
    return Game.Rand((upper + 1) - lower, "") + lower
end
--==========================================================================================================================
-- GLOBALS
--==========================================================================================================================
-- Globals
----------------------------------------------------------------------------------------------------------------------------
local activePlayerID				= Game.GetActivePlayer()
local activePlayer					= Players[activePlayerID]
local civilizationEgyptAkhenatenID 	= GameInfoTypes["CIVILIZATION_JFD_EGYPT_AKHENATEN"]
--==========================================================================================================================
-- UTILITIES
--==========================================================================================================================
-- UTILITIES
----------------------------------------------------------------------------------------------------------------------------
local buildingVerse1ID = GameInfoTypes["BUILDING_JFD_ATEN_VERSE_1"]
local buildingVerse2ID = GameInfoTypes["BUILDING_JFD_ATEN_VERSE_2"]
local buildingVerse3ID = GameInfoTypes["BUILDING_JFD_ATEN_VERSE_3"]
local buildingVerse4ID = GameInfoTypes["BUILDING_JFD_ATEN_VERSE_4"]

local improvementObeliskID = GameInfoTypes["IMPROVEMENT_JFD_OBELISK"]
local improvementCompleteObeliskID = GameInfoTypes["IMPROVEMENT_JFD_COMPLETE_OBELISK"]
local improvementFarm = GameInfoTypes["IMPROVEMENT_FARM"]
local featureFloodPlains = GameInfoTypes["FEATURE_FLOOD_PLAINS"]
local terrainPlains = GameInfoTypes["TERRAIN_PLAINS"]
local terrainDesert = GameInfoTypes["TERRAIN_DESERT"]
local terrainGrassland = GameInfoTypes["TERRAIN_GRASS"]
local resourceWheatID = GameInfoTypes["RESOURCE_WHEAT"]
local unitProphetID = GameInfoTypes["UNIT_PROPHET"]

-- JFD_PlaceObeliskWheat
function JFD_PlaceObeliskWheat(playerID, plot)
	for adjacentPlot in PlotAreaSpiralIterator(plot, 3, JFD_GetRandom(1,6), DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
		if (adjacentPlot:GetImprovementType() == improvementFarm or adjacentPlot:GetImprovementType() == -1) and adjacentPlot:GetResourceType() == -1 and (adjacentPlot:GetFeatureType() == -1 or adjacentPlot:GetFeatureType() == featureFloodPlains) and (adjacentPlot:GetTerrainType() == terrainPlains or adjacentPlot:GetTerrainType() == terrainDesert or adjacentPlot:GetTerrainType() == terrainGrassland) and not adjacentPlot:IsMountain() and not adjacentPlot:IsHills() and not adjacentPlot:IsCity() and (adjacentPlot:GetOwner() == -1 or adjacentPlot:GetOwner() == playerID) then
			local adjacentPlotX = adjacentPlot:GetX()
			local adjacentPlotY = adjacentPlot:GetY()
			local hex = ToHexFromGrid(Vector2(adjacentPlotX, adjacentPlotY))
			if adjacentPlot:GetImprovementType() == improvementFarm then adjacentPlot:SetImprovementType(-1) end
			adjacentPlot:SetResourceType(resourceWheatID, 1)
			local player = Players[playerID]
			if player:IsHuman() and player:IsTurnActive() then
				LuaEvents.SerialEventRawResourceIconRestored(hex.x, hex.y, adjacentPlotX, adjacentPlotY, resourceWheatID)
				Events.AddPopupTextEvent(HexToWorld(hex), Locale.ConvertTextKey("+[ICON_RES_WHEAT]"), 1)
				Events.GameplayFX(hex.x, hex.y, -1)
			end
			break
		end
	end
end

-- JFD_PlaceCompleteObelisk
function JFD_PlaceCompleteObelisk(city)
	for i = 0, city:GetNumCityPlots() - 1, 1 do
		local uPlot = city:GetCityIndexPlot(i)
		if uPlot and uPlot:GetImprovementType() == improvementObeliskID then
			uPlot:SetImprovementType(improvementCompleteObeliskID)
		end
	end
end

-- JFD_RemoveCompleteObelisk
function JFD_RemoveCompleteObelisk(city)
	for i = 0, city:GetNumCityPlots() - 1, 1 do
		local uPlot = city:GetCityIndexPlot(i)
		if uPlot and uPlot:GetImprovementType() == improvementCompleteObeliskID then
			uPlot:SetImprovementType(improvementObeliskID)
		end
	end
end


-- JFD_GetNumVersesAvailable
function JFD_GetNumVersesAvailable()
	return (GetPersistentProperty("JFD_NumVersesAvailable") or 0)
end

-- JFD_ChangeNumVersesAvailable
function JFD_ChangeNumVersesAvailable(playerID)
	local currentNumAtenVersesAvailable = JFD_GetNumVersesAvailable()
	local newNumAtenVersesAvailable = currentNumAtenVersesAvailable + 1
	if newNumAtenVersesAvailable > 4 then return end
	local player = Players[playerID]
	local capital = player:GetCapitalCity()
	local numVerse = JFD_GetNumAtenVersesUsed(playerID) + 1
	if capital then
		JFD_SetHasVerse(playerID, capital, numVerse, 1)
		if player:IsHuman() and player:IsTurnActive() then
			player:AddNotification(NotificationTypes["NOTIFICATION_GREAT_PERSON_ACTIVE_PLAYER"], Locale.ConvertTextKey("TXT_KEY_NOTIFICATION_JFD_ATEN_NEW_VERSE"), Locale.ConvertTextKey("TXT_KEY_NOTIFICATION_JFD_ATEN_NEW_VERSE_SHORT"), -1, -1, unitProphetID)
		end
		if numVerse == 4 and JFD_HasCompleteHymn(playerID,capital) then
			JFD_PlaceCompleteObelisk(capital)
		end
		SetPersistentProperty("JFD_NumVersesAvailable", newNumAtenVersesAvailable)
	end
end

-- JFD_FindVerseLocation
function JFD_FindVerseLocation(playerID, verseNum)
	local player = Players[playerID]
	for city in player:Cities() do
		if JFD_HasVerse(playerID, city, verseNum) then
			return city
		end
	end
	return nil
end

-- JFD_GetNumAtenVersesUsed
function JFD_GetNumAtenVersesUsed(playerID)
	local player = Players[playerID]
	local numAtenVersesUsed = 0
	for verseNum = 1, 4 do
		local buildingVerseID = GameInfoTypes["BUILDING_JFD_ATEN_VERSE_" .. verseNum]
		numAtenVersesUsed = numAtenVersesUsed + player:CountNumBuildings(buildingVerseID)
	end
	return numAtenVersesUsed
end

-- JFD_GetNumAtenVersesUsedThisCity
function JFD_GetNumAtenVersesUsedThisCity(playerID, city)
	local player = Players[playerID]
	local numAtenVersesUsed = 0
	for verseNum = 1, 4 do
		local buildingVerseID = GameInfoTypes["BUILDING_JFD_ATEN_VERSE_" .. verseNum]
		if city:IsHasBuilding(buildingVerseID) then numAtenVersesUsed = numAtenVersesUsed + 1 end
	end
	return numAtenVersesUsed
end

-- JFD_HasVerse
function JFD_HasVerse(playerID, city, verseNum)
	local buildingVerseID = GameInfoTypes["BUILDING_JFD_ATEN_VERSE_" .. verseNum]
	return city:GetNumBuilding(buildingVerseID) > 0
end

-- JFD_HasCompleteHymn
function JFD_HasCompleteHymn(playerID, city)
	if city then
		return JFD_GetNumAtenVersesUsedThisCity(playerID, city) >= 4
	else
		return JFD_GetNumAtenVersesUsed(playerID) >= 4
	end
	return false
end

-- JFD_SetHasVerse
function JFD_SetHasVerse(playerID, city, verseNum, num)
	local player = Players[playerID]
	local buildingVerseID = GameInfoTypes["BUILDING_JFD_ATEN_VERSE_" .. verseNum]
	city:SetNumRealBuilding(buildingVerseID, num)
	for otherCity in player:Cities() do
		if otherCity:GetID() ~= city:GetID() then
			if otherCity:IsHasBuilding(buildingVerseID) then
				otherCity:SetNumRealBuilding(buildingVerseID, 0)
			end
		end
	end
end
--==========================================================================================================================
--==========================================================================================================================