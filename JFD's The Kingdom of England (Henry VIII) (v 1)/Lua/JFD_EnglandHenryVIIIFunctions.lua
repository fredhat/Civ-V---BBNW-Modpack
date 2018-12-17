-- JFD_EnglandHenryVIIIFunctions
-- Author: JFD
-- Edited By: F0S
--==========================================================================================================================
-- Includes
--==========================================================================================================================
include("FLuaVector.lua")
include("NewSaveUtils.lua")
--==========================================================================================================================
-- UTILITY FUNCTIONS
--==========================================================================================================================
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

function JFD_GetWLTKDDuration(gameSpeed)
	if gameSpeed == GameInfoTypes["GAMESPEED_QUICK"] then
		return 3
	elseif gameSpeed == GameInfoTypes["GAMESPEED_STANDARD"] then
		return 5
	elseif gameSpeed == GameInfoTypes["GAMESPEED_EPIC"] then
		return 7
	else
		return 10
	end
end

function JFD_GetNumRealPolicies(player)
	local numPolicies = 0
	for row in GameInfo.Policies() do
		local policy = GameInfoTypes[row.Type]
		if row.CultureCost > 0 and player:HasPolicy(policy) then
			numPolicies = numPolicies + 1
		end
	end
	return numPolicies
end
--==========================================================================================================================
-- CORE FUNCTIONS
--==========================================================================================================================
-- Globals
----------------------------------------------------------------------------------------------------------------------------
local civilisationID = GameInfoTypes["CIVILIZATION_JFD_HENRY_ENGLAND"]
local isHenryEnglandCivActive = JFD_IsCivilisationActive(civilisationID)
----------------------------------------------------------------------------------------------------------------------------
-- JFD_WeLoveTheKingDayFromCapture
----------------------------------------------------------------------------------------------------------------------------
function JFD_WeLoveTheKingDayFromCapture(oldOwnerID, capital, cityX, cityY, newOwnerID)
	local player = Players[newOwnerID]
	if player:IsEverAlive() and player:GetCivilizationType() == civilisationID then
		local capturedCity = Map.GetPlot(cityX, cityY):GetPlotCity()
		if capturedCity then
			local cityPopulation = capturedCity:GetPopulation()
			for city in player:Cities() do
				if city:GetWeLoveTheKingDayCounter() >= 1 then
					city:ChangeWeLoveTheKingDayCounter(cityPopulation)
				else
					city:SetWeLoveTheKingDayCounter(cityPopulation)
				end
			end
		end
	end
end
----------------------------------------------------------------------------------------------------------------------------
-- JFD_WeLoveTheKingDayFromPolicies
----------------------------------------------------------------------------------------------------------------------------
function JFD_WeLoveTheKingDayFromPolicies(playerID)
	local player = Players[playerID]
	if player:IsEverAlive() and player:GetCivilizationType() == civilisationID then
		local numWLTKD = JFD_GetNumRealPolicies(player) + JFD_GetWLTKDDuration(Game.GetGameSpeedType())
		for city in player:Cities() do
			if city:GetWeLoveTheKingDayCounter() >= 1 then
				city:ChangeWeLoveTheKingDayCounter(numWLTKD)
			else
				city:SetWeLoveTheKingDayCounter(numWLTKD)
			end
		end
	end
end
----------------------------------------------------------------------------------------------------------------------------
-- JFD_WeLoveTheKingDayGreatPeople
----------------------------------------------------------------------------------------------------------------------------
local buildingGPGenID = GameInfoTypes["BUILDING_JFD_HENRY_GPGEN"]

function JFD_WeLoveTheKingDayGreatPeople(playerID)
	local player = Players[playerID]
    if player:IsEverAlive() and player:GetCivilizationType() == civilisationID then 
		for city in player:Cities() do
			if city:GetWeLoveTheKingDayCounter() > 0 then
				if not city:IsHasBuilding(buildingGPGenID) then
					city:SetNumRealBuilding(buildingGPGenID, 1)
				end
			else
				if city:IsHasBuilding(buildingGPGenID) then
					city:SetNumRealBuilding(buildingGPGenID, 0)
				end
			end
		end
	end
end

function JFD_WeLoveTheKingDayGreatPeopleDirty()
	local playerID = Game.GetActivePlayer()
    local player = Players[playerID]
	if player:IsTurnActive() then
        JFD_WeLoveTheKingDayGreatPeople(playerID)
    end
end
----------------------------------------------------------------------------------------------------------------------------
-- JFD_JoustingGroundsCulture
----------------------------------------------------------------------------------------------------------------------------
local buildingJoustingGroundsID	= GameInfoTypes["BUILDING_JFD_JOUSTING_GROUNDS"]
local unitCombatMountedID = GameInfoTypes["UNITCOMBAT_MOUNTED"]
local unitCombatMountedRangedID = GameInfoTypes["UNITCOMBAT_MOUNTED_RANGED"]

function JFD_JoustingGroundsCulture(playerID, cityID, unitID, isGold, isFaith)
	local player = Players[playerID]
	if not isGold and not isFaith then
		if player:IsEverAlive() then 
			local city = player:GetCityByID(cityID)
			if city and city:IsHasBuilding(buildingJoustingGroundsID) then
				local unit = player:GetUnitByID(unitID)
				if unit and (unit:GetUnitCombatType() == unitCombatMountedID or unit:GetUnitCombatType() == unitCombatMountedRangedID) then
					local cultureReward = unit:GetExperience()
					player:ChangeJONSCulture(cultureReward)
					if player:IsHuman() and player:IsTurnActive() then
						local hex = ToHexFromGrid(Vector2(unit:GetX(), unit:GetY()))
						Events.AddPopupTextEvent(HexToWorld(hex), Locale.ConvertTextKey("[COLOR_CULTURE_STORED]+{1_Num}[ENDCOLOR][ICON_CULTURE]", cultureReward), 1)
						Events.GameplayFX(hex.x, hex.y, -1)
					end
				end
			end
		end
	end
end

if isHenryEnglandCivActive then
	GameEvents.CityCaptureComplete.Add(JFD_WeLoveTheKingDayFromCapture)
	GameEvents.PlayerAdoptPolicy.Add(JFD_WeLoveTheKingDayFromPolicies)
	GameEvents.PlayerAdoptPolicyBranch.Add(JFD_WeLoveTheKingDayFromPolicies)
	GameEvents.PlayerDoTurn.Add(JFD_WeLoveTheKingDayGreatPeople)
	Events.SerialEventGameDataDirty.Add(JFD_WeLoveTheKingDayGreatPeopleDirty)
	GameEvents.CityTrained.Add(JFD_JoustingGroundsCulture)
end
--==========================================================================================================================
--==========================================================================================================================