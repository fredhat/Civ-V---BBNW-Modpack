-- JFD_DenmarkNorwayFunctions
-- Author: JFD
-- Heavily Edited By: F0S
--==========================================================================================================================
-- UTILITY FUNCTIONS
--==========================================================================================================================
-- JFD_IsCivilisationActive
--------------------------------------------------------------
WARN_NOT_SHARED = false; include( "Sukritact_SaveUtils.lua" ); MY_MOD_NAME = "JFD_DenmarkNorwayFunctions";

local civilisationID = GameInfoTypes["CIVILIZATION_JFD_DENMARK_NORWAY"]

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
--JFD_GreatAdmiralPointsTurn
----------------------------------------------------------------------------------------------------------------------------
local buildingDenmarkNorwayID = GameInfoTypes["BUILDING_JFD_DENMARK_NORWAY"]

function JFD_GreatAdmiralPointsTurn(playerID)
	local player = Players[playerID]
	if player:IsEverAlive() and player:GetCivilizationType() == civilisationID then
		local greatAdmiralPoints = 0
		for city in player:Cities() do
			if city:IsHasBuilding(buildingDenmarkNorwayID) then
				greatAdmiralPoints = greatAdmiralPoints + 3*(city:GetNumSpecialistsInBuilding(buildingDenmarkNorwayID))
			end
		end
		player:ChangeNavalCombatExperience(greatAdmiralPoints)
	end
end
----------------------------------------------------------------------------------------------------------------------------
-- JFD_MeadHall_WLTKD
----------------------------------------------------------------------------------------------------------------------------
local buildingMeadHallID = GameInfoTypes["BUILDING_JFD_MEAD_HALL"]

function JFD_MeadHall_WLTKD(playerID, cityID, buildingID)
	local player = Players[playerID]
	if player:IsEverAlive() and player:GetCivilizationType() == civilisationID then
		if buildingID == buildingMeadHallID then
			local city = player:GetCityByID(cityID)
			if city then
				local plot = city:Plot()
				if plot and load(plot, "MeadHallWLTKD") == nil then
					city:ChangeWeLoveTheKingDayCounter(20)
					save(plot, "MeadHallWLTKD", 1)
				end
			end
		end
	end
end

if JFD_IsCivilisationActive(civilisationID) then
	GameEvents.PlayerDoTurn.Add(JFD_GreatAdmiralPointsTurn)
	GameEvents.CityConstructed.Add(JFD_MeadHall_WLTKD)
end
----------------------------------------------------------------------------------------------------------------------------
-- JFD_SkiInfantryMovement
----------------------------------------------------------------------------------------------------------------------------
local promotionSkiInfantryMovesInfoID = GameInfoTypes["PROMOTION_JFD_SKI_INFANTRY_MOVES_INFO"]
local promotionSkiInfantryMovesID = GameInfoTypes["PROMOTION_JFD_SKI_INFANTRY_MOVES"]

function JFD_SkiInfantryMovement(playerID)
	local player = Players[playerID]
	if player:IsEverAlive() then 
		for unit in player:Units() do
			if unit:IsHasPromotion(promotionSkiInfantryMovesInfoID) or unit:IsHasPromotion(promotionSkiInfantryMovesID) then
				if unit:GetPlot():IsHills() then
					if unit:IsHasPromotion(promotionSkiInfantryMovesInfoID) then
						unit:SetHasPromotion(promotionSkiInfantryMovesInfoID, false)
						unit:SetHasPromotion(promotionSkiInfantryMovesID, true)
						unit:SetMoves(unit:MaxMoves())
					end
				else
					if unit:IsHasPromotion(promotionSkiInfantryMovesID) then
						unit:SetHasPromotion(promotionSkiInfantryMovesInfoID, true)
						unit:SetHasPromotion(promotionSkiInfantryMovesID, false)
						unit:SetMoves(unit:MaxMoves())
					end
				end
			end
		end
	end
end

function JFD_SkiInfantryInitialTrigger(playerID, unitID)
	local player = Players[playerID]
	local unit = player:GetUnitByID(unitID)
	if unit and unit:IsHasPromotion(promotionSkiInfantryMovesInfoID) then
		GameEvents.PlayerDoTurn.Add(JFD_SkiInfantryMovement)
		Events.SerialEventUnitCreated.Remove(JFD_SkiInfantryInitialTrigger)
		save("GAME", "JFD_SkiInfantryInitalised", true)
	end
end

if load("GAME", "JFD_SkiInfantryInitalised") then
	GameEvents.PlayerDoTurn.Add(JFD_SkiInfantryMovement)
else
	Events.SerialEventUnitCreated.Add(JFD_SkiInfantryInitialTrigger)
end
--=======================================================================================================================
-- CORE DENMARK FUNCTIONS	
--=======================================================================================================================
-- JFD_InitDenmark
--------------------------------------------------------------------------------------------------------------------------
local civilisationDenmarkID = GameInfoTypes["CIVILIZATION_DENMARK"]

function JFD_InitDenmark(player)
	for playerID = 0, GameDefines.MAX_MAJOR_CIVS - 1 do
		local player = Players[playerID]
		if player:IsEverAlive() and player:GetCivilizationType() == civilisationDenmarkID then
			player:SetEmbarkedGraphicOverride("ART_DEF_UNIT_U_DANISH_LONGBOAT")
		end
	end 
end
--------------------------------------------------------------------------------------------------------------------------
-- JFD_LongboatFunctions
--------------------------------------------------------------------------------------------------------------------------
local promotionLongboatLandBonusID = GameInfoTypes["PROMOTION_JFD_LAND_UNIT_BONUS_LONGBOAT"]
local promotionLandBonusID = GameInfoTypes["PROMOTION_JFD_LAND_UNIT_BONUS"]
local unitLongboatID = GameInfoTypes["UNIT_JFD_LONGBOAT"]
local unitLongboatUpgradeID = GameInfoTypes["UNIT_JFD_LONGBOAT_UPGRADE"]
local techCompassID = GameInfoTypes["TECH_COMPASS"]

function JFD_LongboatCombatBonus(playerID)
	local player = Players[playerID]
	if player:IsEverAlive() then
		for unit in player:Units() do
			if unit and unit:GetCombatLimit() > 0 and unit:GetDomainType() == GameInfoTypes["DOMAIN_LAND"] and not unit:IsEmbarked() then
				local longboatNearby = false
				for longboat in player:Units() do
					if longboat and longboat:IsHasPromotion(promotionLongboatLandBonusID) then
						if Map.PlotDistance(unit:GetX(), unit:GetY(), longboat:GetX(), longboat:GetY()) < 3 then
							longboatNearby = true
							break
						end
					end
				end
				if longboatNearby then
					if not unit:IsHasPromotion(promotionLandBonusID) then
						unit:SetHasPromotion(promotionLandBonusID, true)
					end
				else
					if unit:IsHasPromotion(promotionLandBonusID) then
						unit:SetHasPromotion(promotionLandBonusID, false)
					end
				end
			else
				if unit:IsHasPromotion(promotionLandBonusID) then
					unit:SetHasPromotion(promotionLandBonusID, false)
				end
			end
		end
	end
end

function JFD_LongboatUpgradeTurn(playerID)
	local player = Players[playerID]
	local teamID = player:GetTeam()
	local team = Teams[teamID]
	if player:IsEverAlive() then
		for unit in player:Units() do
			if unit and unit:GetUnitType() == unitLongboatID and team:IsHasTech(techCompassID) then
				local newUnit = player:InitUnit(unitLongboatUpgradeID, unit:GetX(), unit:GetY(), UNITAI_ASSAULT_SEA)
				newUnit:Convert(unit)
			end
		end
	end
end

function JFD_LongboatUpgradeXY(playerID, unitID)
	local player = Players[playerID]
	local teamID = player:GetTeam()
	local team = Teams[teamID]
	local unit = player:GetUnitByID(unitID)
	if player:IsEverAlive() then
		if unit and unit:GetUnitType() == unitLongboatID and team:IsHasTech(techCompassID) then
			local newUnit = player:InitUnit(unitLongboatUpgradeID, unit:GetX(), unit:GetY(), UNITAI_ASSAULT_SEA)
			newUnit:Convert(unit)
		end
	end
end

function JFD_LongboatUpgradeTech(teamID, techID)
	local team = Teams[teamID]
	local playerID = team:GetLeaderID()
	local player = Players[playerID]
	if player:IsEverAlive() then
		for unit in player:Units() do
			if unit and unit:GetUnitType() == unitLongboatID and team:IsHasTech(techCompassID) then
				local newUnit = player:InitUnit(unitLongboatUpgradeID, unit:GetX(), unit:GetY(), UNITAI_ASSAULT_SEA)
				newUnit:Convert(unit)
			end
		end
	end
end

function JFD_LongboatUpgradeInitialTrigger(playerID, unitID)
	local player = Players[playerID]
	local teamID = player:GetTeam()
	local team = Teams[teamID]
	local unit = player:GetUnitByID(unitID)
	if unit and (unit:GetUnitType() == unitLongboatID or unit:GetUnitType() == unitLongboatUpgradeID) then
		GameEvents.PlayerDoTurn.Add(JFD_LongboatCombatBonus)
		GameEvents.UnitSetXY.Add(JFD_LongboatCombatBonus) 
		GameEvents.PlayerDoTurn.Add(JFD_LongboatUpgradeTurn)
		GameEvents.UnitSetXY.Add(JFD_LongboatUpgradeXY)
		GameEvents.TeamTechResearched.Add(JFD_LongboatUpgradeTech)
		Events.SerialEventUnitCreated.Remove(JFD_LongboatUpgradeInitialTrigger)
		save("GAME", "LongboatInitalised", true)
		JFD_LongboatCombatBonus(playerID)
		JFD_LongboatUpgradeXY(playerID, unitID)
	end
end
--------------------------------------------------------------------------------------------------------------------------
-- JFD_OnModernEra
--------------------------------------------------------------------------------------------------------------------------
local eraRenaissanceID = GameInfoTypes["ERA_RENAISSANCE"]
local eraIndustrialID = GameInfoTypes["ERA_INDUSTRIAL"]

function JFD_OnModernEra(arg0, playerID)
	local player = Players[playerID]
	local currentEraID = player:GetCurrentEra()
	if player:IsEverAlive() and  player:GetCivilizationType() == civilisationDenmarkID then
		if currentEraID == eraRenaissanceID then
			player:SetEmbarkedGraphicOverride("ART_DEF_UNIT_GALLEON")
		elseif currentEraID == eraIndustrialID then
			player:SetEmbarkedGraphicOverride("ART_DEF_UNIT_TRANSPORT")
		end
	end
end

if JFD_IsCivilisationActive(civilisationDenmarkID) then
	Events.LoadScreenClose.Add(JFD_InitDenmark)
	if load("GAME", "LongboatInitalised") then
		GameEvents.PlayerDoTurn.Add(JFD_LongboatCombatBonus)
		GameEvents.UnitSetXY.Add(JFD_LongboatCombatBonus) 
		GameEvents.PlayerDoTurn.Add(JFD_LongboatUpgradeTurn)
		GameEvents.UnitSetXY.Add(JFD_LongboatUpgradeXY)
		GameEvents.TeamTechResearched.Add(JFD_LongboatUpgradeTech)
	else
		Events.SerialEventUnitCreated.Add(JFD_LongboatUpgradeInitialTrigger)
	end
	Events.SerialEventEraChanged.Add(JFD_OnModernEra)
end
--=======================================================================================================================
-- CORE SONGHAI FUNCTIONS	
--=======================================================================================================================
-- JFD_SonghaiScienceFromCities
--------------------------------------------------------------------------------------------------------------------------
local civilisationSonghaiID = GameInfoTypes["CIVILIZATION_SONGHAI"]
local buildingSonghaiTrackerID = GameInfoTypes["BUILDING_JFD_SONGHAI_TRACKER"]
local buildingSonghaiScienceID = GameInfoTypes["BUILDING_JFD_SONGHAI_SCIENCE"]

function JFD_SonghaiScienceFromCities(playerID)
	local player = Players[playerID]
	if player:IsEverAlive() and player:GetCivilizationType() == civilisationSonghaiID then
		local capital = player:GetCapitalCity()
		if capital then
			local scienceBonus = 0
			local religionID = capital:GetReligiousMajority() or -1
			for city in player:Cities() do
				if city:IsCapital() then
					if not city:IsHasBuilding(buildingSonghaiTrackerID) then
						city:SetNumRealBuilding(buildingSonghaiTrackerID, 1)
					end
				else
					if religionID > 0 and city:GetReligiousMajority() == religionID then
						scienceBonus = scienceBonus + math.ceil(city:GetBaseYieldRate(YieldTypes.YIELD_SCIENCE) / 10)
					end
					if city:IsHasBuilding(buildingSonghaiScienceID) then
						city:SetNumRealBuilding(buildingSonghaiScienceID, 0)
					end
					if city:IsHasBuilding(buildingColonyTrackerID) then
						city:SetNumRealBuilding(buildingColonyTrackerID, 0)
					end
				end
			end
			capital:SetNumRealBuilding(buildingSonghaiScienceID, scienceBonus)
		end
	end
end

function JFD_SonghaiScienceFromCitiesDirty()
	local playerID = Game.GetActivePlayer()
    local player = Players[playerID]
	if player:IsTurnActive() then
        JFD_SonghaiScienceFromCities(playerID)
    end
end

if JFD_IsCivilisationActive(civilisationSonghaiID) then
	GameEvents.PlayerDoTurn.Add(JFD_SonghaiScienceFromCities)
	GameEvents.PlayerCityFounded.Add(JFD_SonghaiScienceFromCities)
	Events.SerialEventCityInfoDirty.Add(JFD_SonghaiScienceFromCitiesDirty)
end
--==========================================================================================================================
--==========================================================================================================================