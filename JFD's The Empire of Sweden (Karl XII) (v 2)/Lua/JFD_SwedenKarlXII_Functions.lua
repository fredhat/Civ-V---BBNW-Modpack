-- JFD_SwedenKarlXII_Functions
-- Author: JFD
-- Edited By: F0S
--==========================================================================================================================
-- INCLUDES
--==========================================================================================================================
include("IconSupport")
include("FLuaVector.lua")
include("UniqueDiplomacyUtils.lua")
include("JFD_SwedenKarlXII_GlobalDefines.lua")
include("TableSaverLoader016.lua")
tableRoot = JFD_SwedenKarlXII
tableName = "JFD_SwedenKarlXII"
include("JFD_SwedenKarlXII_TSLSerializerV3.lua")
TableLoad(tableRoot, tableName)
--==========================================================================================================================
-- UTILITY FUNCTIONS
--==========================================================================================================================
-- MOD CHECKS
--------------------------------------------------------------------------------------------------------------------------
-- JFD_IsCivilisationActive
function JFD_IsCivilisationActive(civilizationID)
	for iSlot = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
		local slotStatus = PreGame.GetSlotStatus(iSlot)
		if slotStatus == SlotStatus["SS_TAKEN"] or slotStatus == SlotStatus["SS_COMPUTER"] then
			if PreGame.GetCivilization(iSlot) == civilizationID then
				return true
			end
		end
	end
	return false
end
--==========================================================================================================================
-- GLOBALS
--==========================================================================================================================
-- Globals
----------------------------------------------------------------------------------------------------------------------------
local activePlayerID				= Game.GetActivePlayer()
local activePlayer					= Players[activePlayerID]
local civilizationID 				= GameInfoTypes["CIVILIZATION_SWEDEN"]
local isSwedenKarlXIICivActive		= JFD_IsCivilisationActive(civilizationID)
local isSwedenKarlXIIActivePlayer	= activePlayer:GetCivilizationType() == civilizationID
--==========================================================================================================================
-- DIPLOMACY FUNCTIONS
--==========================================================================================================================
-- DIPLOMACY
----------------------------------------------------------------------------------------------------------------------------
local civilizationSaxonyID = GameInfoTypes["CIVILIZATION_JFD_SAXONY"]
local leaderPeterID = GameInfoTypes["LEADER_JFD_PETER"]

function JFD_SwedenKarlXIIUniqueResponses()
	-- If the player is Peter the Great
	if leaderPeterID and activePlayer:GetLeaderType() == leaderPeterID then
		ChangeDiplomacyResponse("TXT_KEY_LEADER_JFD_KARL_XII_FIRSTGREETING%", "TXT_KEY_LEADER_JFD_KARL_XII_PETER_FIRSTGREETING_1")
	-- If the player is Augustus the Strong
	elseif civilizationSaxonyID and activePlayer:GetCivilizationType() == civilizationSaxonyID then
		ChangeDiplomacyResponse("TXT_KEY_LEADER_JFD_KARL_XII_FIRSTGREETING%", "TXT_KEY_LEADER_JFD_KARL_XII_SAXONY_FIRSTGREETING_1")
	end
end

for playerID = 0, GameDefines.MAX_MAJOR_CIVS - 1, 1 do
	local player = Players[playerID]
	if player and player:IsEverAlive() and not player:IsHuman() and player:GetCivilizationType() == civilizationID then
		Events.SequenceGameInitComplete.Add(JFD_SwedenKarlXIIUniqueResponses)
		break
	end
end
--==========================================================================================================================
-- UNIQUE FUNCTIONS
--==========================================================================================================================
-- INDELNINGSVERK
----------------------------------------------------------------------------------------------------------------------------
local yieldFoodID = YieldTypes["YIELD_FOOD"]

-- JFD_SwedenKarlXII_FoodStorage
function JFD_SwedenKarlXII_FoodStorage(plotX, plotY, oldPop, newPop)
	if oldPop < newPop then
		local city = Map.GetPlot(plotX, plotY):GetPlotCity()
		local player = Players[city:GetOwner()]
		if player:IsEverAlive() and player:IsHuman() and player:GetCivilizationType() == civilizationID then
			local cityID = city:GetID()
			local currentStorage = FoodStorage[cityID] or 0
			local newStorage = math.ceil((city:GetBaseYieldRate(yieldFoodID)*25)/100)
			FoodStorage[cityID] = currentStorage + newStorage
		end
	end
end

local improvementCitadelID = GameInfoTypes["IMPROVEMENT_CITADEL"]
local improvementSwedishCitadelID = GameInfoTypes["IMPROVEMENT_JFD_SWEDISH_CITADEL"]
local improvementFortID = GameInfoTypes["IMPROVEMENT_FORT"]
local improvementSwedishFortID = GameInfoTypes["IMPROVEMENT_JFD_SWEDISH_FORT"]
local terrainTundraID = GameInfoTypes["TERRAIN_TUNDRA"]
local terrainSnowID	= GameInfoTypes["TERRAIN_SNOW"]

-- JFD_SwedenKarlXIIOnCitadelOnTundraConstructed
function JFD_SwedenKarlXII_CitadelFood(playerID, plotX, plotY, improvementID)
    local player = Players[playerID]
    if player:IsEverAlive() and player:GetCivilizationType() == civilizationID then 
		if improvementID == improvementCitadelID then
       		local plot = Map.GetPlot(plotX, plotY)
			local terrainType = plot:GetTerrainType()
			if terrainType == terrainSnowID or terrainType == terrainTundraID then
				plot:SetImprovementType(improvementSwedishCitadelID)
			end
		end
		if improvementID == improvementFortID then
       		local plot = Map.GetPlot(plotX, plotY)
			local terrainType = plot:GetTerrainType()
			if terrainType == terrainSnowID or terrainType == terrainTundraID then
				plot:SetImprovementType(improvementSwedishFortID)
			end
		end
    end
end
----------
-- UI 
----------
local isCityViewOpen = false

-- JFD_SwedenKarlXII_UpdateFoodStorage
function JFD_SwedenKarlXII_UpdateFoodStorage()
	Controls.MilitaryReserveBox:SetHide(true)
	Controls.MilitaryReserveImage:SetHide(true)
	Controls.MilitaryReserveButton:SetDisabled(true)
	Controls.MilitaryReserveButton:LocalizeAndSetToolTip(nil)
	local city = UI.GetHeadSelectedCity()
	if city then
		local cityID = city:GetID()
		local currentStorage = FoodStorage[cityID] or 0
		local currentProduction = city:GetProductionUnit()
		local currentProductionNeeded = city:GetProductionNeeded()
		local currentProductionTurnsLeft = city:GetProductionTurnsLeft()
		local militaryReserveButtonText = Locale.ConvertTextKey("TXT_KEY_JFD_SWEDEN_KARL_XII_FOOD_STORAGE", currentStorage)
		local militaryReserveButtonTT = Locale.ConvertTextKey("TXT_KEY_JFD_SWEDEN_KARL_XII_FOOD_STORAGE_DISABLED_TT")
		if currentProduction == -1 or city:IsResistance() or currentStorage <= 0 or currentProductionTurnsLeft <= 1 then
			Controls.MilitaryReserveButton:SetDisabled(true)
		else
			local currentProductionUnitCombat = GameInfo.Units[currentProduction].Combat
			if currentProductionUnitCombat == 0 then
				Controls.MilitaryReserveButton:SetDisabled(true)
			else
				militaryReserveButtonTT = Locale.ConvertTextKey("TXT_KEY_JFD_SWEDEN_KARL_XII_FOOD_STORAGE_TT_HURRY", currentStorage)
				if currentStorage > currentProductionNeeded then
					militaryReserveButtonTT = Locale.ConvertTextKey("TXT_KEY_JFD_SWEDEN_KARL_XII_FOOD_STORAGE_TT_HURRY", currentProductionNeeded)
				end
				Controls.MilitaryReserveButton:LocalizeAndSetToolTip(militaryReserveButtonTT)
				Controls.MilitaryReserveButton:SetDisabled(false)
			end
		end
		IconHookup(0, 64, "JFD_SWEDEN_KARL_RESERVE_ATLAS", Controls.MilitaryReserveImage)
		Controls.MilitaryReserveBox:SetHide(false)
		Controls.MilitaryReserveImage:SetHide(false)
		Controls.MilitaryReserveButton:SetText(militaryReserveButtonText)
		Controls.MilitaryReserveButton:LocalizeAndSetToolTip(militaryReserveButtonTT)
	end
end

-- JFD_SwedenKarlXII_FoodStorageSpent
function JFD_SwedenKarlXII_FoodStorageSpent()
	local city = UI.GetHeadSelectedCity()
	if city then
		local cityID = city:GetID()
		local currentStorage = FoodStorage[cityID] or 0
		local currentProductionNeeded = city:GetProductionNeeded()
		local productionBoost = currentStorage
		if currentStorage > currentProductionNeeded then
			productionBoost = currentProductionNeeded
		end
		local newStorage = currentStorage - productionBoost
		FoodStorage[cityID] = math.max(0, newStorage)
		city:ChangeProduction(productionBoost)
		Events.AudioPlay2DSound("AS2D_SELECT_MUSKETMAN")
		JFD_OnEnterCityScreen()
	end
end

-- JFD_OnEnterCityScreen
function JFD_OnEnterCityScreen()
	isCityViewOpen = true
	JFD_SwedenKarlXII_UpdateFoodStorage()
end

-- JFD_OnExitCityScreen
function JFD_OnExitCityScreen()
	isCityViewOpen = false
	JFD_SwedenKarlXII_UpdateFoodStorage()
end

-- JFD_OnNextCityScreen
function JFD_OnNextCityScreen()
	if isCityViewOpen then
		JFD_SwedenKarlXII_UpdateFoodStorage()
	end
end

if isSwedenKarlXIICivActive and isSwedenKarlXIIActivePlayer then
	Controls.MilitaryReserveButton:RegisterCallback(Mouse.eLClick, JFD_SwedenKarlXII_FoodStorageSpent)
	Events.SerialEventEnterCityScreen.Add(JFD_OnEnterCityScreen)
	Events.SerialEventExitCityScreen.Add(JFD_OnExitCityScreen)
	Events.SerialEventCityScreenDirty.Add(JFD_OnNextCityScreen)
	Events.SerialEventCityInfoDirty.Add(JFD_OnEnterCityScreen)
end
--==========================================================================================================================
-- UB FUNCTIONS
--==========================================================================================================================
-- ALOTTMENT HOUSE
----------------------------------------------------------------------------------------------------------------------------
local buildingWarAcademyID = GameInfoTypes["BUILDING_JFD_WAR_ACADEMY"]

-- JFD_SwedenKarlXII_WarAcademy
function JFD_SwedenKarlXII_WarAcademy(playerID, cityID, unitID, isGold, isFaith)
	local player = Players[playerID]
	if not isGold and not isFaith then
		if player:IsEverAlive() then
			local city = player:GetCityByID(cityID)
			if city and city:IsHasBuilding(buildingWarAcademyID) then
				local unit = player:GetUnitByID(unitID)
				if unit and unit:GetCombatLimit() > 0 and unit:GetDomainType() == DomainTypes.DOMAIN_LAND then
					local rewardXP = unit:GetExperience()
					player:ChangeCombatExperience(rewardXP)
					if player:IsHuman() and player:IsTurnActive() then
						local hex = ToHexFromGrid(Vector2(unit:GetX(), unit:GetY()))
						Events.AddPopupTextEvent(HexToWorld(hex), Locale.ConvertTextKey("[COLOR_POSITIVE_TEXT]+{1_Num}[ENDCOLOR][ICON_GREAT_GENERAL]", rewardXP), 1)
						Events.GameplayFX(hex.x, hex.y, -1)
					end
				end
			end
		end
	end
end

if isSwedenKarlXIICivActive then
	GameEvents.SetPopulation.Add(JFD_SwedenKarlXII_FoodStorage)
	GameEvents.BuildFinished.Add(JFD_SwedenKarlXII_CitadelFood)
	GameEvents.CityTrained.Add(JFD_SwedenKarlXII_WarAcademy)
end
--=======================================================================================================================
-- TSL UTILITIES	
--=======================================================================================================================
-- OnModLoaded
function OnModLoaded() 
	local bNewGame = not TableLoad(tableRoot, tableName)
	TableSave(tableRoot, tableName)
end
OnModLoaded()
--==========================================================================================================================
--==========================================================================================================================