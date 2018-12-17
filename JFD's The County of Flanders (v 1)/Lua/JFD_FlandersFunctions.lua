-- JFD_FlandersFunctions
-- Author: JFD
-- Edited By: F0S
--=======================================================================================================================
-- Includes
--=======================================================================================================================
include("FLuaVector.lua")
include("IconSupport")
WARN_NOT_SHARED = false; include( "Sukritact_SaveUtils.lua" ); MY_MOD_NAME = "JFD_FlandersFunctions";
include("PlotIterators")
--=======================================================================================================================
-- UTILITIES
--=======================================================================================================================
-- JFD_CityHasImprovedResource
------------------------------------------------------------------------------------------------------------------------
function JFD_CityHasImprovedResource(playerID, city, resourceID, improvementID)
	for cityPlot = 0, city:GetNumCityPlots() - 1, 1 do
		local plot = city:GetCityIndexPlot(cityPlot)
		if plot and plot:GetOwner() == playerID then
			if plot:GetResourceType() == resourceID and plot:GetImprovementType() == improvementID and not plot:IsImprovementPillaged() then
				return true
			end
		end
	end
	return false
end
------------------------------------------------------------------------------------------------------------------------
-- JFD_GetNumTradeRoutesLeavingThisCity
------------------------------------------------------------------------------------------------------------------------
function JFD_GetNumTradeRoutesLeavingThisCity(playerID, city)
	local player = Players[playerID]
	local tradeRoutes = player:GetTradeRoutes()
	local numTradeRoutes = 0
	for i, v in ipairs(tradeRoutes) do
		local originatingCity = v.FromCity
		if originatingCity:GetID() == city:GetID() then
			numTradeRoutes = numTradeRoutes + 1
			if v.Domain == DomainTypes.DOMAIN_SEA then
				numTradeRoutes = numTradeRoutes + 1
			end
		end
	end
	return numTradeRoutes
end
--------------------------------------------------------------------------------------------------------------------------
-- JFD_GetRandom
--------------------------------------------------------------------------------------------------------------------------
function JFD_GetRandom(lower, upper)
    return Game.Rand((upper + 1) - lower, "") + lower
end
------------------------------------------------------------------------------------------------------------------------
-- JFD_IsCivilisationActive
------------------------------------------------------------------------------------------------------------------------
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
-- Sukritact_PlaceResource
--------------------------------------------------------------
function Sukritact_PlaceResource(startingPlot, resourceID, playerID, cityID)
    local plots = {}
	local player = Players[playerID]
	local playerTeam = player:GetTeam()
    for loopPlot in PlotAreaSweepIterator(startingPlot, 3, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
        table.insert(plots, loopPlot)
    end
	local isPlaced = false
	while not isPlaced and #plots > 0 do
		local randomNumber = JFD_GetRandom(1, #plots)
		local plot = plots[randomNumber]
		if not plot:IsMountain() and plot:IsHills() and not plot:IsCity() and plot:GetResourceType() == -1 and plot:GetFeatureType() == -1 and plot:GetTerrainType() ~= TerrainTypes.TERRAIN_SNOW then
			plot:SetResourceType(resourceID, 1)
			plot:SetOwner(-1)
			plot:SetOwner(playerID, cityID)
			plot:SetRevealed(playerTeam, true)
			plot:UpdateFog()
			isPlaced = true
		end
		table.remove(plots, randomNumber)
	end
end
--=======================================================================================================================
-- CORE FUNCTIONS	
--=======================================================================================================================
-- Globals
--------------------------------------------------------------------------------------------------------------------------
local activePlayerID 			= Game.GetActivePlayer()
local activePlayer 				= Players[activePlayerID]
local activePlayerTeam 			= Teams[Game.GetActiveTeam()]
local civilisationID 			= GameInfoTypes["CIVILIZATION_JFD_FLANDERS"]
local isFlandersCivActive 		= JFD_IsCivilisationActive(civilisationID)
local isFlandersActivePlayer 	= activePlayer:GetCivilizationType() == civilisationID
----------------------------------------------------------------------------------------------------------------------------
-- JFD_InitFlanders
----------------------------------------------------------------------------------------------------------------------------		
local resourceSheepID = GameInfoTypes["RESOURCE_SHEEP"]

function JFD_FlandersSheep(playerID, iX, iY)
	local player = Players[playerID]
	if player:IsEverAlive() and player:GetCivilizationType() == civilisationID then
		local plot = Map.GetPlot(iX, iY)
		local city = plot:GetPlotCity()
		local cityID = city:GetID()
		if city and city:IsOriginalCapital() then
			Sukritact_PlaceResource(plot, resourceSheepID, playerID, cityID)
		end
	end 	
end
----------------------------------------------------------------------------------------------------------------------------
-- JFD_WoolExports
----------------------------------------------------------------------------------------------------------------------------
local buildingFlandersID = GameInfoTypes["BUILDING_JFD_FLANDERS"]
local improvementPastureID = GameInfoTypes["IMPROVEMENT_PASTURE"]
		
function JFD_WoolExports(playerID)
	local player = Players[playerID]
	if player:IsEverAlive() and player:GetCivilizationType() == civilisationID then
		for city in player:Cities() do
			if JFD_CityHasImprovedResource(playerID, city, resourceSheepID, improvementPastureID) then
				local numWoolExports = math.min(JFD_GetNumTradeRoutesLeavingThisCity(playerID, city), 5)
				city:SetNumRealBuilding(buildingFlandersID, numWoolExports)
			else
				if city:IsHasBuilding(buildingFlandersID) then
					city:SetNumRealBuilding(buildingFlandersID, 0)
				end
			end
		end
	end
end

function JFD_WoolExportsDirty()
	local iPlayer = Game.GetActivePlayer()
    local pPlayer = Players[iPlayer]
	if pPlayer:IsTurnActive() then
        JFD_WoolExports(iPlayer)
    end
end
----------------------------------------------------------------------------------------------------------------------------
-- JFD_AIMilitia
----------------------------------------------------------------------------------------------------------------------------	
local unitMilitiaID	= GameInfoTypes["UNIT_JFD_GOEDENDAG"]
local buildingHeroicEpicID = GameInfoTypes["BUILDING_HEROIC_EPIC"]
local unitPromotionMoraleID = GameInfoTypes["PROMOTION_MORALE"]
local unitPromotionMilitiaID = GameInfoTypes["PROMOTION_JFD_FLANDERS_MILITIA"]

function JFD_MilitiaSpeed(gameSpeed)
	if gameSpeed == GameInfoTypes["GAMESPEED_QUICK"] then
		return 3
	elseif gameSpeed == GameInfoTypes["GAMESPEED_STANDARD"] then
		return 5
	elseif gameSpeed == GameInfoTypes["GAMESPEED_EPIC"] then
		return 8
	else
		return 12
	end
end

function JFD_AIMilitia(teamID, otherTeamID)
	local player = Players[Teams[teamID]:GetLeaderID()]
	local otherPlayer = Players[Teams[otherTeamID]:GetLeaderID()]
	if otherPlayer:IsEverAlive() and otherPlayer:GetCivilizationType() == civilisationID and player:IsEverAlive() and not player:IsMinorCiv() and not otherPlayer:IsHuman() then
		for city in otherPlayer:Cities() do
			if city:CanTrain(unitMilitiaID) and city:GetPopulation() > 3 then
				local newUnit = otherPlayer:InitUnit(unitMilitiaID, city:GetX(), city:GetY(), UNITAI_DEFENSE)
				newUnit:SetExperience(city:GetProductionExperience(newUnit:GetUnitType()))
				if city:IsHasBuilding(buildingHeroicEpicID) then
					newUnit:SetHasPromotion(unitPromotionMoraleID, true)
				end
				newUnit:SetHasPromotion(unitPromotionMilitiaID, true)
				newUnit:SetMoves(0)
				--local numCitizens = city:GetPopulation()
				--city:SetPopulation(numCitizens - 1, true)
				city:ChangePopulation(-1, true)
				Network.SendUpdateCityCitizens(city:GetID())
			end
		end
	end
end

if isFlandersCivActive and not isFlandersActivePlayer then
	GameEvents.DeclareWar.Add(JFD_AIMilitia)
end
----------------------------------------------------------------------------------------------------------------------------
-- JFD_BelfortConstructed
----------------------------------------------------------------------------------------------------------------------------
local buildingBelfort1ID = GameInfoTypes["BUILDING_JFD_BELFORT"]
local buildingBelfort2ID = GameInfoTypes["BUILDING_JFD_BELFORT_2"]
local buildingBelfort3ID = GameInfoTypes["BUILDING_JFD_BELFORT_3"]
local buildingGold = GameInfoTypes["BUILDING_JFD_F_GOLD"]


function JFD_BelfortConstructed(playerID, cityID, buildingID)
	local player = Players[playerID]
	if player:IsEverAlive() and player:GetCivilizationType() == civilisationID then
		local city = player:GetCityByID(cityID)
		if buildingID == buildingBelfort1ID or buildingID == buildingBelfort2ID or buildingID == buildingBelfort3ID then
			local cultureBoost = city:GetBaseYieldRate(YieldTypes.YIELD_GOLD)*3
			player:ChangeJONSCulture(cultureBoost)
			local goldBuildings = 0
			if city:IsHasBuilding(buildingBelfort1ID) then
				goldBuildings = goldBuildings + 1
			end
			if city:IsHasBuilding(buildingBelfort2ID) then
				goldBuildings = goldBuildings + 1
			end
			if city:IsHasBuilding(buildingBelfort3ID) then
				goldBuildings = goldBuildings + 1
			end
			city:SetNumRealBuilding(buildingGold, goldBuildings*goldBuildings)
			if player:IsHuman() and player:IsTurnActive() then
				local hex = ToHexFromGrid(Vector2(city:GetX(), city:GetY()))
				Events.AddPopupTextEvent(HexToWorld(hex), Locale.ConvertTextKey("[COLOR_CULTURE_STORED]+{1_Num}[ENDCOLOR] [ICON_CULTURE]", cultureBoost), 1)
				Events.GameplayFX(hex.x, hex.y, -1)
			end
		end
	end
end

function JFD_BelfortGold(playerID)
	local player = Players[playerID]
	if player:IsEverAlive() then
		for city in player:Cities() do
			local goldBuildings = 0
			if city:IsHasBuilding(buildingBelfort1ID) then
				goldBuildings = goldBuildings + 1
			end
			if city:IsHasBuilding(buildingBelfort2ID) then
				goldBuildings = goldBuildings + 1
			end
			if city:IsHasBuilding(buildingBelfort3ID) then
				goldBuildings = goldBuildings + 1
			end
			city:SetNumRealBuilding(buildingGold, goldBuildings*goldBuildings)
		end
	end
end

function JFD_BelfortGoldDirty()
	local playerID = Game.GetActivePlayer()
    local player = Players[playerID]
	if player:IsTurnActive() then
        JFD_BelfortGold(playerID)
    end
end

function JFD_BelfortGoldInitialTrigger(playerID, cityID, buildingID)
	local player = Players[playerID]
	local city = player:GetCityByID(cityID)
	if city and city:IsHasBuilding(buildingBelfort1ID) then
		GameEvents.CityConstructed.Add(JFD_BelfortConstructed)
		GameEvents.PlayerDoTurn.Add(JFD_BelfortGold)
		Events.SerialEventGameDataDirty.Add(JFD_BelfortGoldDirty)
		GameEvents.CityConstructed.Remove(JFD_BelfortGoldInitialTrigger)
		save("GAME", "JFD_BelfortGoldInitalised", true)
		JFD_BelfortConstructed(playerID, cityID, buildingID)
	end
end

if isFlandersCivActive then
	GameEvents.PlayerCityFounded.Add(JFD_FlandersSheep)
	GameEvents.PlayerDoTurn.Add(JFD_WoolExports)
	Events.SerialEventGameDataDirty.Add(JFD_WoolExportsDirty)
	if load("GAME", "JFD_BelfortGoldInitalised") then
		GameEvents.CityConstructed.Add(JFD_BelfortConstructed)
		GameEvents.PlayerDoTurn.Add(JFD_BelfortGold)
		Events.SerialEventGameDataDirty.Add(JFD_BelfortGoldDirty)
	else
		GameEvents.CityConstructed.Add(JFD_BelfortGoldInitialTrigger)
	end
end
--------------------------------------------------------------------------------------------------------------------------
-- JFD_BlockBelfries
--------------------------------------------------------------------------------------------------------------------------
function JFD_BlockBelfries(playerID, cityID, buildingID)
	local player = Players[playerID]
	local playerTeam = Teams[player:GetTeam()]
	if (buildingID == buildingBelfort2ID or buildingID == buildingBelfort3ID) and player:GetCivilizationType() ~= civilisationID then
		return
	end
	return true
end

GameEvents.CityCanConstruct.Add(JFD_BlockBelfries)
--==========================================================================================================================
-- UI FUNCTIONS
--==========================================================================================================================
--Globals
----------------------------------------------------------------------------------------------------------------------------
local isCityViewOpen = false
----------------------------------------------------------------------------------------------------------------------------
-- JFD_UpdateMilitiaRecruitment
----------------------------------------------------------------------------------------------------------------------------
function JFD_UpdateMilitiaRecruitment()
	Controls.UnitBackground:SetHide(true)
	Controls.UnitImage:SetHide(true)
	Controls.UnitButton:SetDisabled(true)
	Controls.UnitButton:LocalizeAndSetToolTip(nil)
	local militia = GameInfo.Units[unitMilitiaID]
	if not activePlayerTeam:IsHasTech(GameInfoTypes[militia.PrereqTech]) then return end
	if activePlayerTeam:IsHasTech(GameInfoTypes[militia.ObsoleteTech]) then return end
	local city = UI.GetHeadSelectedCity()
	if city and not city:IsOccupied() and not city:IsPuppet() then
		local isDisabled = true
		local garrisonedUnit = city:GetGarrisonedUnit()
		local buttonText = "TXT_KEY_JFD_RECRUIT_GOEDENDAG"
		local buttonToolTip = "TXT_KEY_JFD_RECRUIT_GOEDENDAG_TT"
		local cityTurns = load(city:Plot(),"cityTurns")
		if garrisonedUnit then
			if garrisonedUnit:IsHasPromotion(unitPromotionMilitiaID) and load(garrisonedUnit,"militiaCity") == city:GetID() then
				isDisabled = false
				buttonText = "TXT_KEY_JFD_RETURN_GOEDENDAG"
				buttonToolTip = "TXT_KEY_JFD_RETURN_GOEDENDAG_TT"
			end
		else
			if city:CanTrain(militia.ID) and city:GetPopulation() > 3 and (cityTurns == nil or cityTurns == 0) then
				isDisabled = false
			end
		end
		if isDisabled then
			if cityTurns ~= nil and cityTurns ~= 0 then
				buttonToolTip = Locale.ConvertTextKey("TXT_KEY_JFD_RECRUIT_GOEDENDAG_TT_DISABLED_TURNS", cityTurns)
			else
				buttonToolTip = "TXT_KEY_JFD_RECRUIT_GOEDENDAG_TT_DISABLED"
			end
		end
		IconHookup(militia.PortraitIndex, 64, militia.IconAtlas, Controls.UnitImage)
		Controls.UnitBackground:SetHide(false)
		Controls.UnitImage:SetHide(false)
		Controls.UnitButton:LocalizeAndSetText(buttonText)
		--Controls.UnitButton:LocalizeAndSetToolTip(buttonToolTipDisabled)
		Controls.UnitButton:SetDisabled(isDisabled)
		Controls.UnitButton:LocalizeAndSetToolTip(buttonToolTip)		
	end
end
----------------------------------------------------------------------------------------------------------------------------
-- JFD_OnHireMilitia
----------------------------------------------------------------------------------------------------------------------------
function JFD_OnHireMilitia()
	local city = UI.GetHeadSelectedCity();
	if city then
		local cityX = city:GetX()
		local cityY = city:GetY()
		local garrisonedUnit = city:GetGarrisonedUnit()
		local militia = GameInfo.Units[unitMilitiaID]
		if garrisonedUnit then
			if garrisonedUnit:IsHasPromotion(unitPromotionMilitiaID) and load(garrisonedUnit,"militiaCity") == city:GetID() then
				garrisonedUnit:Kill(false, -1)
				--local numCitizens = city:GetPopulation()
				--city:SetPopulation(numCitizens + 1, true)
				city:ChangePopulation(1, true)
				Network.SendUpdateCityCitizens(city:GetID())
				local hex = ToHexFromGrid(Vector2(cityX, cityY))
				Events.AddPopupTextEvent(HexToWorld(hex), Locale.ConvertTextKey("[COLOR_POSITIVE_TEXT]+{1_Num}[ENDCOLOR][ICON_CITIZEN]", 1), 1)
				Events.GameplayFX(hex.x, hex.y, -1)
			end
		else
			local newUnit = activePlayer:InitUnit(unitMilitiaID, cityX, cityY, UNITAI_DEFENSE)
			newUnit:SetExperience(city:GetProductionExperience(newUnit:GetUnitType()))
			if city:IsHasBuilding(buildingHeroicEpicID) then
				newUnit:SetHasPromotion(unitPromotionMoraleID, true)
			end
			newUnit:SetHasPromotion(unitPromotionMilitiaID, true)
			newUnit:SetMoves(0)
			--local numCitizens = city:GetPopulation()
			--city:SetPopulation(numCitizens - 1, true)
			city:ChangePopulation(-1, true)
			Network.SendUpdateCityCitizens(city:GetID())
			save(newUnit,"militiaCity",city:GetID())
			save(city:Plot(),"cityTurns",JFD_GetConscriptionSpeed(Game.GetGameSpeedType()))
		end
	end
	JFD_UpdateMilitiaRecruitment()
end
Controls.UnitButton:RegisterCallback(Mouse.eLClick, JFD_OnHireMilitia)
----------------------------------------------------------------------------------------------------------------------------
-- JFD_OnEnterCityScreen
----------------------------------------------------------------------------------------------------------------------------
function JFD_OnEnterCityScreen()
	isCityViewOpen = true
	JFD_UpdateMilitiaRecruitment()
end
----------------------------------------------------------------------------------------------------------------------------
-- JFD_OnExitCityScreen
----------------------------------------------------------------------------------------------------------------------------
function JFD_OnExitCityScreen()
	isCityViewOpen = false
	JFD_UpdateMilitiaRecruitment()
end
----------------------------------------------------------------------------------------------------------------------------
-- JFD_OnNextCityScren
----------------------------------------------------------------------------------------------------------------------------
function JFD_OnNextCityScren()
	if isCityViewOpen then
		JFD_UpdateMilitiaRecruitment()
	end
end

function JFD_FlandersMilitiaTurn(playerID)
	local player = Players[playerID]
	if player:IsEverAlive() and player:GetCivilizationType() == civilisationID and player:IsHuman() then
		for city in player:Cities() do
			local cityTurns = load(city:Plot(),"cityTurns")
			if cityTurns and cityTurns > 0 then
				save(city:Plot(),"cityTurns",cityTurns - 1)
			else
				save(city:Plot(),"cityTurns",0)
			end
		end
	end
end

if isFlandersCivActive and isFlandersActivePlayer then
	GameEvents.PlayerDoTurn.Add(JFD_FlandersMilitiaTurn)
	Events.SerialEventEnterCityScreen.Add(JFD_OnEnterCityScreen)
	Events.SerialEventExitCityScreen.Add(JFD_OnExitCityScreen)
	Events.SerialEventCityScreenDirty.Add(JFD_OnNextCityScren)
end
--==========================================================================================================================
--==========================================================================================================================