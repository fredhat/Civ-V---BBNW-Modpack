-- JFD_BavariaFunctions
-- Author: JFD
-- Heavily Edited By: F0S
--==========================================================================================================================
-- UTILITY FUNCTIONS
--==========================================================================================================================
WARN_NOT_SHARED = false; include( "Sukritact_SaveUtils" ); MY_MOD_NAME = "JFD_BavariaFunctions";
include("FLuaVector.lua")

local civilisationID = GameInfoTypes["CIVILIZATION_JFD_BAVARIA"]
--------------------------------------------------------------
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
--------------------------------------------------------------
-- IsBuildingReal
--------------------------------------------------------------
function IsBuildingReal(buildingID)
    return not (GameInfo.Buildings[buildingID].GreatWorkCount == -1 or (GameInfo.Buildings[buildingID].PrereqTech == nil and (GameInfo.Buildings[buildingID].FaithCost == -1 and GameInfo.Buildings[buildingID].Cost == -1)))
end
--==========================================================================================================================
-- CORE FUNCTIONS
--==========================================================================================================================
-- JFD_BavarianCulture
----------------------------------------------------------------------------------------------------------------------------
local cultureID = GameInfo.Yields["YIELD_CULTURE"].ID
local tourismID = GameInfo.Yields["YIELD_TOURISM"].ID
local buildingHotelID = GameInfoTypes["BUILDING_HOTEL"]
local buildingAirportID = GameInfoTypes["BUILDING_AIRPORT"]
local buildingTouristCenterID = GameInfoTypes["BUILDING_TOURIST_CENTER"]
local buildingBavarianTourismID = GameInfoTypes["BUILDING_JFD_BAVARIAN_TOURISM"]
local wonders = {}

function JFD_BavarianCulture(player)
	for city in player:Cities() do
		local cityID = city:GetID()
		local numWonders = 0
		for iKey, sVal in pairs(wonders) do
			if city:IsHasBuilding(iKey) then
				if sVal == "Wonder" then
					numWonders = numWonders + 1
				end
			end
		end
		local delta = numWonders * 2
		local oldDelta = load( player, cityID .. "Y" .. cultureID)
		if oldDelta == nil then
			oldDelta = 0
		end
		save( player, cityID .. "Y" .. cultureID, delta)
		city:ChangeJONSCulturePerTurnFromBuildings(delta - oldDelta)
		local numTourismMods = 0
		if city:IsHasBuilding(buildingHotelID) then
			numTourismMods = numTourismMods + 0.5
		end
		if city:IsHasBuilding(buildingAirportID) then
			numTourismMods = numTourismMods + 0.5
		end
		if city:IsHasBuilding(buildingTouristCenterID) then
			numTourismMods = numTourismMods + 1
		end
		city:SetNumRealBuilding(buildingBavarianTourismID, math.floor(delta * numTourismMods))
	end
end

function JFD_BavarianCultureTrigger1(playerID)
    local player = Players[playerID]
    if player:IsEverAlive() and player:GetCivilizationType() == civilisationID then
        JFD_BavarianCulture(player)
    end
end

function JFD_BavarianCultureTrigger2()
    local playerID = Game.GetActivePlayer()
    local player = Players[playerID]
    if player:IsEverAlive() and player:IsTurnActive() then
        if player:GetCivilizationType() == civilisationID then
            JFD_BavarianCulture(player)
        end
    end
end

function JFD_BavarianCultureTrigger3(playerID, cityID, typeID)
	if typeID ~= CityUpdateTypes.CITY_UPDATE_TYPE_PRODUCTION then return end
	local player = Players[playerID]
	if player:IsEverAlive() and player:GetCivilizationType() == civilisationID then
		JFD_BavarianCulture(player)
	end
end
----------------------------------------------------------------------------------------------------------------------------
-- JFD_BavarianProduction
----------------------------------------------------------------------------------------------------------------------------
local buildingBavarianMusicID = GameInfoTypes["BUILDING_JFD_BAVARIAN_MUSIC"]
local buildingBavarianProductionID = GameInfoTypes["BUILDING_JFD_BAVARIAN_PRODUCTION"]

function JFD_BavarianProduction(playerID)
	local player = Players[playerID]
    if player:IsEverAlive() then 
		for city in player:Cities() do
			if city:IsHasBuilding(buildingBavarianMusicID) then
				local buildingClass = GameInfo.Buildings[buildingBavarianMusicID].BuildingClass
				local buildingClassID = GameInfo.BuildingClasses[buildingClass].ID
				local numGreatWorks = city:GetNumGreatWorksInBuilding(buildingClassID)
				if numGreatWorks > 0 then
					city:SetNumRealBuilding(buildingBavarianProductionID, 1)
				else
					city:SetNumRealBuilding(buildingBavarianProductionID, 0)
				end
			else
				city:SetNumRealBuilding(buildingBavarianProductionID, 0)
			end
		end
	end
end

function JFD_BavarianProductionDirty()
	local playerID = Game.GetActivePlayer()
    local player = Players[playerID]
	if player:IsTurnActive() then
        JFD_BavarianProduction(playerID)
    end
end
----------------------------------------------------------------------------------------------------------------------------
-- JFD_BavarianMusicSlots
----------------------------------------------------------------------------------------------------------------------------
function JFD_BavarianMusicSlots(playerID)
	local player = Players[playerID]
    if player:IsEverAlive() and player:GetCivilizationType() == civilisationID then 
		for city in player:Cities() do
			for building in GameInfo.Buildings() do
				if GameInfo.BuildingClasses[building.BuildingClass].MaxGlobalInstances == 1 then
					if city:IsHasBuilding(building.ID) then
						if not city:IsHasBuilding(buildingBavarianMusicID) then
							city:SetNumRealBuilding(buildingBavarianMusicID, 1)
							break
						end
					end
				end
			end
		end
	end
end

function JFD_BavarianMusicSlotsDirty()
	local playerID = Game.GetActivePlayer()
    local player = Players[playerID]
	if player:IsTurnActive() then
        JFD_BavarianMusicSlots(playerID)
    end
end
----------------------------------------------------------------------------------------------------------------------------
-- JFD_SchlossGreatMusicianPoints
----------------------------------------------------------------------------------------------------------------------------
local improvementSchlossID = GameInfoTypes["IMPROVEMENT_JFD_SCHLOSS"]
local buildingCSDummyCultureID = GameInfoTypes["BUILDING_CS_DUMMY_CULTURE"]
local specialistMusicianID = GameInfoTypes["SPECIALIST_MUSICIAN"]

function JFD_SchlossGreatMusicianPoints(playerID, iX, iY, improvementID)
	local player = Players[playerID]
    if player:IsEverAlive() and player:GetCivilizationType() == civilisationID then 
		if improvementID == improvementSchlossID then
			local cultureRate = player:GetTotalJONSCulturePerTurn()
			local capitalCity = player:GetCapitalCity()
			if capitalCity then
				if player:IsGoldenAge() then
					cultureRate = cultureRate + math.ceil(capitalCity:GetNumBuilding(buildingCSDummyCultureID) * 1.2)
				else
					cultureRate = cultureRate + capitalCity:GetNumBuilding(buildingCSDummyCultureID)
				end
				capitalCity:ChangeSpecialistGreatPersonProgressTimes100(specialistMusicianID, (cultureRate * 300))
				if player:IsHuman() and player:IsTurnActive() then
					local hex = ToHexFromGrid(Vector2(iX, iY))
					Events.AddPopupTextEvent(HexToWorld(hex), Locale.ConvertTextKey("[COLOR_POSITIVE_TEXT]+{1_Num}[ENDCOLOR] [ICON_GREAT_MUSICIAN]", (cultureRate * 3)), 1)
					Events.GameplayFX(hex.x, hex.y, -1)
				end
			end
		end
	end
end
----------------------------------------------------------------------------------------------------------------------------
-- JFD_HartshierSchlossCulture
----------------------------------------------------------------------------------------------------------------------------
local promotionHartschierID = GameInfoTypes["PROMOTION_JFD_HARTSCHIER"]
local improvementSchlossCulturedID = GameInfoTypes["IMPROVEMENT_JFD_SCHLOSS_CULTURED"]

function JFD_HartshierSchlossCulture(playerID)
	local player = Players[playerID]
    if player:IsEverAlive() then 
		for city in player:Cities() do
			for cityPlot = 0, city:GetNumCityPlots() - 1, 1 do
				local plot = city:GetCityIndexPlot(cityPlot)
				if plot then
					if plot:GetOwner() == playerID then
						if plot:GetImprovementType() == improvementSchlossID then
							local isCultured = false
							for iVal = 0,(plot:GetNumUnits() - 1) do
								local unit = plot:GetUnit(iVal)
								if unit and unit:GetOwner() == playerID and unit:IsHasPromotion(promotionHartschierID) then
									isCultured = true
									break
								end
							end
							if isCultured then plot:SetImprovementType(improvementSchlossCulturedID) end
						elseif plot:GetImprovementType() == improvementSchlossCulturedID then
							local isCultured = false
							for iVal = 0,(plot:GetNumUnits() - 1) do
								local unit = plot:GetUnit(iVal)
								if unit and unit:GetOwner() == playerID and unit:IsHasPromotion(promotionHartschierID) then
									isCultured = true
									break
								end
							end
							if not isCultured then plot:SetImprovementType(improvementSchlossID) end
						end
					end
				end
			end
		end
	end
end

function JFD_HartshierSchlossCultureInitialTrigger(playerID, unitID)
	local player = Players[playerID]
	local unit = player:GetUnitByID(unitID)
	if unit and unit:IsHasPromotion(promotionHartschierID) then
		GameEvents.PlayerDoTurn.Add(JFD_HartshierSchlossCulture)
		GameEvents.UnitSetXY.Add(JFD_HartshierSchlossCulture)
		GameEvents.BuildFinished.Add(JFD_HartshierSchlossCulture)
		Events.SerialEventUnitCreated.Remove(JFD_HartshierSchlossCultureInitialTrigger)
		save("GAME", "JFD_BavariaInitalised", true)
		JFD_HartshierSchlossCulture(playerID)
	end
end

if JFD_IsCivilisationActive(civilisationID) then
	GameEvents.PlayerDoTurn.Add(JFD_BavarianProduction)
	Events.SerialEventGameDataDirty.Add(JFD_BavarianProductionDirty)
	GameEvents.PlayerDoTurn.Add(JFD_BavarianMusicSlots)
	Events.SerialEventGameDataDirty.Add(JFD_BavarianMusicSlotsDirty)
	GameEvents.BuildFinished.Add(JFD_SchlossGreatMusicianPoints)
	if load("GAME", "JFD_BavariaInitalised") then
		GameEvents.PlayerDoTurn.Add(JFD_HartshierSchlossCulture)
		GameEvents.UnitSetXY.Add(JFD_HartshierSchlossCulture)
		GameEvents.BuildFinished.Add(JFD_HartshierSchlossCulture)
	else
		Events.SerialEventUnitCreated.Add(JFD_HartshierSchlossCultureInitialTrigger)
	end
end
--==========================================================================================================================
--==========================================================================================================================