-- JFD_ScotlandEverything
-- Author: JFD
-- Heavily Edited By: F0S
--==========================================================================================================================
-- UTILITY FUNCTIONS
--==========================================================================================================================
WARN_NOT_SHARED = false; include( "Sukritact_SaveUtils.lua" ); MY_MOD_NAME = "JFD_ScotlandEverything";
include("PlotIterators")
--------------------------------------------------------------
-- JFD_IsCivilisationActive
--------------------------------------------------------------
local civilisationID = GameInfoTypes["CIVILIZATION_MC_SCOTLAND"]

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
-- JFD_GetUniqueUnit
--------------------------------------------------------------
function JFD_GetUniqueUnit(player, unitClass)
	local unitType = nil
	local civType = GameInfo.Civilizations[player:GetCivilizationType()].Type 
	for uniqueUnit in GameInfo.Civilization_UnitClassOverrides{CivilizationType = civType, UnitClassType = unitClass} do
		unitType = uniqueUnit.UnitType
		break
	end
	if unitType == nil then
		unitType = GameInfo.UnitClasses[unitClass].DefaultUnit
	end
	return unitType
end
--==========================================================================================================================
-- CORE SCOTLAND FUNCTIONS
--==========================================================================================================================
-- JFD_RobertBruceFlankingEnemiesBonus
--------------------------------------------------------------
local promotionLandFreeID = GameInfoTypes["PROMOTION_JFD_LAND_OF_THE_FREE"]
local promotionLandFreeInfoID = GameInfoTypes["PROMOTION_JFD_LAND_OF_THE_FREE_INFO"]

function JFD_GetNumEnemyUnits(playerID, unit)
	local numEnemyUnits = 0
	local plot = Map.GetPlot(unit:GetX(), unit:GetY())
	if plot then
		for adjacentPlot in PlotAreaSweepIterator(plot, 1, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
			if adjacentPlot and adjacentPlot:GetUnit() then
				for i = 0, adjacentPlot:GetNumUnits() - 1 do
					local adjacentUnit = adjacentPlot:GetUnit(i)
					if adjacentUnit:GetOwner() ~= playerID and adjacentUnit:GetCombatLimit() > 0 and adjacentUnit:GetDomainType() == DomainTypes.DOMAIN_LAND and not adjacentUnit:IsEmbarked() and Teams[Players[adjacentUnit:GetOwner()]:GetTeam()]:IsAtWar(Players[playerID]:GetTeam()) then
						numEnemyUnits = numEnemyUnits + 1
					end
				end
			end
		end
	end
	return numEnemyUnits
end

function JFD_GiveFlankedPromotion(playerID, unit)
	local flankingEnemies = false
	if JFD_GetNumEnemyUnits(playerID, unit) > 1 then
		flankingEnemies = true
	end
	if flankingEnemies then
		if not unit:IsHasPromotion(promotionLandFreeID) then
			unit:SetHasPromotion(promotionLandFreeID, true)
			unit:SetHasPromotion(promotionLandFreeInfoID, false)
		end
	else
		if unit:IsHasPromotion(promotionLandFreeID) then
			unit:SetHasPromotion(promotionLandFreeID, false)
			unit:SetHasPromotion(promotionLandFreeInfoID, true)
		end
	end
end

function JFD_RobertBruceFlankingEnemiesBonus(playerID)
	local player = Players[playerID]
	if player:IsEverAlive() then
		for unit in player:Units() do
			if unit and (unit:IsHasPromotion(promotionLandFreeID) or unit:IsHasPromotion(promotionLandFreeInfoID)) then
				JFD_GiveFlankedPromotion(playerID, unit)
			end
		end
	end
end

function JFD_RobertBruceFlankingEnemiesBonusOther(playerID, unitID)
	local player = Players[playerID]
	if player:IsEverAlive() then
		local unit = player:GetUnitByID(unitID)
		if unit then
			local plot = Map.GetPlot(unit:GetX(), unit:GetY())
			if unit:IsHasPromotion(promotionLandFreeID) or unit:IsHasPromotion(promotionLandFreeInfoID) then
				JFD_GiveFlankedPromotion(playerID, unit)
			elseif plot then
				for adjacentPlot in PlotAreaSweepIterator(plot, 2, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
					if adjacentPlot and adjacentPlot:GetUnit() then
						for i = 0, adjacentPlot:GetNumUnits() - 1 do
							local otherUnit = adjacentPlot:GetUnit(i)
							if otherUnit and (otherUnit:IsHasPromotion(promotionLandFreeID) or otherUnit:IsHasPromotion(promotionLandFreeInfoID)) then
								JFD_GiveFlankedPromotion(otherUnit:GetOwner(), otherUnit)
							end
						end
					end
				end
			end
		end
	end
end
------------------------------------------------------------------------------------------------------------------------
-- JFD_ScottishClanDefense
------------------------------------------------------------------------------------------------------------------------
local improvementScottishClanCastleID = GameInfoTypes["IMPROVEMENT_MC_SCOTTISH_CLAN_CASTLE"]
local scottishClans = {}
scottishClans.ERA_ANCIENT = "UNITCLASS_WARRIOR"
scottishClans.ERA_CLASSICAL = "UNITCLASS_SPEARMAN"
scottishClans.ERA_MEDIEVAL = "UNITCLASS_PIKEMAN"
scottishClans.ERA_RENAISSANCE = "UNITCLASS_MUSKETMAN"
scottishClans.ERA_INDUSTRIAL = "UNITCLASS_RIFLEMAN"
scottishClans.ERA_MODERN = "UNITCLASS_GREAT_WAR_INFANTRY"
scottishClans.ERA_POSTMODERN = "UNITCLASS_INFANTRY"
scottishClans.ERA_FUTURE = "UNITCLASS_MECHANIZED_INFANTRY"

function JFD_SpawnScottishClans(playerID)
	local player = Players[playerID]
	for city in player:Cities() do
		if city then
			for plotID = 0, city:GetNumCityPlots() - 1, 1 do
				local plot = city:GetCityIndexPlot(plotID)
				if plot and plot:GetImprovementType() == improvementScottishClanCastleID and not plot:IsImprovementPillaged() and plot:GetOwner() == playerID then
					local unitClass = scottishClans[GameInfo.Eras[player:GetCurrentEra()].Type]
					local unitType = JFD_GetUniqueUnit(player, unitClass)
					player:InitUnit(GameInfoTypes[unitType], plot:GetX(), plot:GetY(), UNITAI_DEFENSE):JumpToNearestValidPlot()
				end
			end
		end
	end
end
	
function JFD_ScottishClanDefense(teamOne, teamTwo)
	for attackingPlayerID = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do			
		for defendingPlayerID = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
			attackingPlayer = Players[attackingPlayerID]
			defendingPlayer = Players[defendingPlayerID]
			if attackingPlayer:IsEverAlive() and not attackingPlayer:IsMinorCiv() and defendingPlayer:IsEverAlive() and not defendingPlayer:IsMinorCiv() then
				if attackingPlayer:GetTeam() == teamOne and defendingPlayer:GetTeam() == teamTwo then
					if defendingPlayer:GetCivilizationType() == civilisationID and Teams[defendingPlayer:GetTeam()]:GetAtWarCount(true) <= 1 then 
						JFD_SpawnScottishClans(defendingPlayerID)
					end
				end
			end
		end	
	end
end

function JFD_ScottishClanDefenseInitialTrigger(playerID, plotX, plotY, improvementID)
	if improvementID == improvementScottishClanCastleID then
		GameEvents.DeclareWar.Add(JFD_ScottishClanDefense)
		GameEvents.BuildFinished.Remove(JFD_ScottishClanDefenseInitialTrigger)
		save("GAME", "JFD_ScottishClanDefenseInitalised", true)
	end
end
------------------------------------------------------------------------------------------------------------------------
-- JFD_ScottishCultureFromHills
------------------------------------------------------------------------------------------------------------------------
local buildingScottishCultureID = GameInfoTypes["BUILDING_MC_SCOTTISH_CULTURE"]

function JFD_GetNumAdjacentHills(playerID, city)
	local numAdjacentHills = 0
	local plot = Map.GetPlot(city:GetX(), city:GetY())
	if plot then
		for adjacentPlot in PlotAreaSweepIterator(plot, 1, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
			if adjacentPlot:GetOwner() == playerID and adjacentPlot:IsHills() then
				numAdjacentHills = numAdjacentHills + 1
			end
		end
	end
    return numAdjacentHills     
end

function JFD_ScottishCultureFromHillsTurn(playerID)
	local player = Players[playerID]
	if player:IsEverAlive() and player:GetCivilizationType() == civilisationID then
		for city in player:Cities() do
			if city then
				local numAdjacentHills = math.ceil(JFD_GetNumAdjacentHills(playerID, city)/2)
				if city:GetNumBuilding(buildingScottishCultureID) ~= numAdjacentHills then
					city:SetNumRealBuilding(buildingScottishCultureID, numAdjacentHills)
				end
			end
		end
	end
end

function JFD_ScottishCultureFromHillsFounded(playerID, cityX, cityY)
	local player = Players[playerID]
	if player:IsEverAlive() and player:GetCivilizationType() == civilisationID then
		local city = Map.GetPlot(cityX, cityY):GetPlotCity()
		if city then
			local numAdjacentHills = math.ceil(JFD_GetNumAdjacentHills(newOwnerID, city)/2)
			if city:GetNumBuilding(buildingScottishCultureID) ~= numAdjacentHills then
				city:SetNumRealBuilding(buildingScottishCultureID, numAdjacentHills)
			end
		end
	end
end

function JFD_ScottishCultureFromHillsCapture(oldOwnerID, capital, cityX, cityY, newOwnerID)
	local player = Players[newOwnerID]
	if player:IsEverAlive() and player:GetCivilizationType() == civilisationID then
		local city = Map.GetPlot(cityX, cityY):GetPlotCity()
		if city then
			local numAdjacentHills = math.ceil(JFD_GetNumAdjacentHills(newOwnerID, city)/2)
			if city:GetNumBuilding(buildingScottishCultureID) ~= numAdjacentHills then
				city:SetNumRealBuilding(buildingScottishCultureID, numAdjacentHills)
			end
		end
	end
end
------------------------------------------------------------------------------------------------------------------------
-- Scottish Strength from Culture
------------------------------------------------------------------------------------------------------------------------
local promotionStrengthCultureID = GameInfoTypes["PROMOTION_STRENGTH_FROM_CULTURE"]
local promotionStrengthCultureInfoID = GameInfoTypes["PROMOTION_STRENGTH_FROM_CULTURE_INFO"]

function JFD_ScottishCulturalStrength(playerID)
	local player = Players[playerID]
	if player:IsEverAlive() then
		for unit in player:Units() do
			if unit and (unit:IsHasPromotion(promotionStrengthCultureID) or unit:IsHasPromotion(promotionStrengthCultureInfoID)) then
				if player:GetNumPolicyBranchesFinished() > 0 then
					if not unit:IsHasPromotion(promotionStrengthCultureID) then
						unit:SetHasPromotion(promotionStrengthCultureID, true)
						unit:SetHasPromotion(promotionStrengthCultureInfoID, false)
					end
				else
					if unit:IsHasPromotion(promotionStrengthCultureID) then
						unit:SetHasPromotion(promotionStrengthCultureID, false)
						unit:SetHasPromotion(promotionStrengthCultureInfoID, true)
					end
				end
			end
		end
	end
end

function JFD_ScottishCulturalStrengthOther(playerID, unitID)
	local player = Players[playerID]
	if player:IsEverAlive() then
		local unit = player:GetUnitByID(unitID)
		if unit and (unit:IsHasPromotion(promotionStrengthCultureID) or unit:IsHasPromotion(promotionStrengthCultureInfoID)) then
			if player:GetNumPolicyBranchesFinished() > 0 then
				if not unit:IsHasPromotion(promotionStrengthCultureID) then
					unit:SetHasPromotion(promotionStrengthCultureID, true)
					unit:SetHasPromotion(promotionStrengthCultureInfoID, false)
				end
			else
				if unit:IsHasPromotion(promotionStrengthCultureID) then
					unit:SetHasPromotion(promotionStrengthCultureID, false)
					unit:SetHasPromotion(promotionStrengthCultureInfoID, true)
				end
			end
		end
	end
end

if JFD_IsCivilisationActive(civilisationID) then
	GameEvents.PlayerDoTurn.Add(JFD_RobertBruceFlankingEnemiesBonus)
	GameEvents.UnitSetXY.Add(JFD_RobertBruceFlankingEnemiesBonusOther)
	Events.SerialEventUnitCreated.Add(JFD_RobertBruceFlankingEnemiesBonusOther)
	if load("GAME", "JFD_ScottishClanDefenseInitalised") then
		GameEvents.DeclareWar.Add(JFD_ScottishClanDefense)
	else
		GameEvents.BuildFinished.Add(JFD_ScottishClanDefenseInitialTrigger)
	end
	GameEvents.PlayerDoTurn.Add(JFD_ScottishCultureFromHillsTurn)
	GameEvents.PlayerCityFounded.Add(JFD_ScottishCultureFromHillsFounded)
	GameEvents.CityCaptureComplete.Add(JFD_ScottishCultureFromHillsCapture)
	GameEvents.PlayerDoTurn.Add(JFD_ScottishCulturalStrength)
	GameEvents.PlayerAdoptPolicy.Add(JFD_ScottishCulturalStrength)
	Events.SerialEventUnitCreated.Add(JFD_ScottishCulturalStrengthOther)
end