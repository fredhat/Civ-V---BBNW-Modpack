-- JFD_ExCE_Exploration_Functions
-- Author: JFD
-- Heavily Edited By: F0S
--========================================================================================================================
-- INCLUDES
--========================================================================================================================
include("FLuaVector.lua")
include("JFD_ExCEUtilities.lua")
include("PlotIterators.lua")
--========================================================================================================================
-- RANDOM SEED
--========================================================================================================================
math.randomseed(os.time())
--========================================================================================================================
-- EXPLORATION FUNCTIONS
--========================================================================================================================
-- GLOBAL
--------------------------------------------------------------------------------------------------------------------------
local CUSTOM_MISSION_NO_ACTION = 0
local CUSTOM_MISSION_ACTION = 1
local CUSTOM_MISSION_DONE = 2
local CUSTOM_MISSION_ACTION_AND_DONE = 3
--------------------------------------------------------------------------------------------------------------------------
-- EXPLORATION
--------------------------------------------------------------------------------------------------------------------------
local unitPromotionGreatReconID = GameInfoTypes["PROMOTION_JFD_GREAT_RECON"]
local missionReconFoundID = GameInfoTypes["MISSION_RECON_FOUND"]
local buildingClassBelemTowerID = GameInfoTypes["BUILDINGCLASS_JFD_BELEM_TOWER"]
local civilisationAustriaID = GameInfoTypes["CIVILIZATION_AUSTRIA"]
local civilisationVeniceID = GameInfoTypes["CIVILIZATION_VENICE"]

--JFD_ExCE_Exploration_ReconFoundPossible
function JFD_ExCE_Exploration_ReconFoundPossible(playerID, unitID, missionID, data1, data2, _, _, plotX, plotY, bTestVisible)
	local player = Players[playerID]
	if missionID == missionReconFoundID and not (player:GetCivilizationType() == civilisationAustriaID or player:GetCivilizationType() == civilisationVeniceID) then
		local unit = player:GetUnitByID(unitID)
		if unit:IsHasPromotion(unitPromotionGreatReconID) and ((unit:GetLevel() > 4) or (player:GetBuildingClassCount(buildingClassBelemTowerID) > 0)) then
			local plot = Map.GetPlot(plotX, plotY)
			if plot:IsTerraFirma(unit) then
				local capital = player:GetCapitalCity()
				if capital then
					if plot:GetArea() ~= capital:Plot():GetArea() then
						if plot:GetOwner() == -1 or plot:GetOwner() == playerID then
							for nearbyPlot in PlotAreaSpiralIterator(plot, 3, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_INCLUDE) do
								if nearbyPlot:IsCity() then
									return false
								end
							end
							return not player:IsEmpireVeryUnhappy()
						end
					end
				else
					if plot:GetOwner() == -1 or plot:GetOwner() == playerID then
						for nearbyPlot in PlotAreaSpiralIterator(plot, 3, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_INCLUDE) do
							if nearbyPlot:IsCity() then
								return false
							end
						end
						return not player:IsEmpireVeryUnhappy()
					end
				end
			end
		end
	end
	return false
end
GameEvents.CustomMissionPossible.Add(JFD_ExCE_Exploration_ReconFoundPossible)

--JFD_ExCE_Exploration_ReconFoundStart
function JFD_ExCE_Exploration_ReconFoundStart(playerID, unitID, missionID, data1, data2, flags, turn)
	local player = Players[playerID]
	if missionID == missionReconFoundID then
		local unit = player:GetUnitByID(unitID)
		player:Found(unit:GetX(), unit:GetY())
		return CUSTOM_MISSION_ACTION
	end
	return CUSTOM_MISSION_NO_ACTION
end
GameEvents.CustomMissionStart.Add(JFD_ExCE_Exploration_ReconFoundStart)

--JFD_ExCE_Exploration_ReconFoundCompleted
function JFD_ExCE_Exploration_ReconFoundCompleted(playerID, unitID, missionID, data1, data2, flags, turn)
	local player = Players[playerID]
	if missionID == missionReconFoundID then
		local unit = player:GetUnitByID(unitID)
		unit:Kill(true, -1)
		return true
	end
	return false
end
GameEvents.CustomMissionCompleted.Add(JFD_ExCE_Exploration_ReconFoundCompleted)
--------------------------------------------------------------------------------------------------------------------------
-- Free Luxury Code
--------------------------------------------------------------------------------------------------------------------------
local numFreeLuxuries = 2

--JFD_DoGiveFreeLuxury
function JFD_DoGiveFreeLuxury(playerID, unitID)
	local player = Players[playerID]
	if player:IsEverAlive() then
		local unit = player:GetUnitByID(unitID)
		local availableLuxuries = {}
		for resource_data in GameInfo.Resources() do
			if resource_data.ResourceClassType == "RESOURCECLASS_LUXURY" then
				if Map.GetNumResources(resource_data.ID) < 1 then
					table.insert(availableLuxuries, resource_data)
				end
			end
		end
		if unit and #availableLuxuries > 0 then
			local resource = availableLuxuries[math.random(#availableLuxuries)]
			player:ChangeNumResourceTotal(resource.ID, numFreeLuxuries)
			local plotX = -1
			local plotY = -1
			local capital = player:GetCapitalCity()
			if capital then
				plotX = capital:GetX()
				plotY = capital:GetY()
			end
			if player:IsHuman() and player:IsTurnActive() then
				player:AddNotification(NotificationTypes["NOTIFICATION_DISCOVERED_LUXURY_RESOURCE"], Locale.ConvertTextKey("TXT_KEY_NOTIFICATION_CITY_FREE_RESOURCE", GameInfo.Units[unit:GetUnitType()].Description, resource.Description), Locale.ConvertTextKey("TXT_KEY_NOTIFICATION_CITY_FREE_RESOURCE_SUMMARY"), plotX, plotY, resource.ID, -1)
			end
		end
	end
end
--------------------------------------------------------------------------------------------------------------------------
-- MISSIONS
--------------------------------------------------------------------------------------------------------------------------
local missionFreeLuxuryID = GameInfoTypes["MISSION_FREE_LUXURY"]
local unitclassGreatAdmiralID = GameInfoTypes["UNITCLASS_GREAT_ADMIRAL"]

--JFD_ExCE_Exploration_MissionPossible
function JFD_ExCE_Exploration_MissionPossible(playerID, unitID, missionID, data1, data2, _, _, plotX, plotY, bTestVisible)
	local player = Players[playerID]
	if missionID == missionFreeLuxuryID then
		if player:IsEverAlive() then
			local unit = player:GetUnitByID(unitID)
			if unit and unit:GetUnitClassType() == unitclassGreatAdmiralID then
				local plot = Map.GetPlot(plotX, plotY)
				if plot:GetOwner() ~= playerID then
					return bTestVisible
				end
				return true
			end
		end
	end
	return false
end
GameEvents.CustomMissionPossible.Add(JFD_ExCE_Exploration_MissionPossible)

--JFD_ExCE_Exploration_MissionStart
function JFD_ExCE_Exploration_MissionStart(playerID, unitID, missionID, data1, data2, flags, turn)
	if missionID == missionFreeLuxuryID then
		JFD_DoGiveFreeLuxury(playerID, unitID)
		return CUSTOM_MISSION_ACTION
	end
	return CUSTOM_MISSION_NO_ACTION
end
GameEvents.CustomMissionStart.Add(JFD_ExCE_Exploration_MissionStart)

--JFD_ExCE_Exploration_MissionCompleted
function JFD_ExCE_Exploration_MissionCompleted(playerID, unitID, missionID, data1, data2, flags, turn)
	local player = Players[playerID]
	if missionID == missionFreeLuxuryID then
		if player:IsEverAlive() then
			local unit = player:GetUnitByID(unitID)
			if unit then
				unit:Kill(true, -1)
				return true
			end
		end
	end
	return false
end
GameEvents.CustomMissionCompleted.Add(JFD_ExCE_Exploration_MissionCompleted)
--------------------------------------------------------------------------------------------------------------------------
-- Colonialism
--------------------------------------------------------------------------------------------------------------------------
local unitClassWorkerID = GameInfoTypes["UNITCLASS_WORKER"]

function ColonialismPolicy(playerID, cityX, cityY)
	local player = Players[playerID]
	local plot = Map.GetPlot(cityX, cityY)
	local city = plot:GetPlotCity()
	if player:IsEverAlive() then
		if player:HasPolicy(GameInfoTypes["POLICY_NAVIGATION_SCHOOL"]) then
			local workerUnitToSpawn = JFD_GetUniqueUnit(player, unitClassWorkerID)
			player:InitUnit(GameInfoTypes[workerUnitToSpawn], cityX, cityY, UNITAI_WORKER)
			for adjacentPlot in PlotAreaSpiralIterator(plot, 3, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
				if adjacentPlot:GetOwner() == -1 then
					local possibleTile = false
					for adjacentestPlot in PlotAreaSpiralIterator(adjacentPlot, 1, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
						if adjacentestPlot:GetOwner() == playerID then
							possibleTile = true
							break
						end
					end
					if possibleTile and math.random(100) > 50 then
						adjacentPlot:SetOwner(playerID, city:GetID())
						adjacentPlot:SetRevealed(player:GetTeam(), true)
						adjacentPlot:UpdateFog()
					end
				end
			end
		end
		if player:HasPolicy(GameInfoTypes["POLICY_RESETTLEMENT"]) then
			local workerUnitToSpawn = JFD_GetUniqueUnit(player, unitClassWorkerID)
			player:InitUnit(GameInfoTypes[workerUnitToSpawn], cityX, cityY, UNITAI_WORKER)
		end
	end
end

GameEvents.PlayerCityFounded.Add(ColonialismPolicy)
--------------------------------------------------------------------------------------------------------------------------
-- GreatAdmiralPromotions
--------------------------------------------------------------------------------------------------------------------------
local unitPromotionExplorationID = GameInfoTypes["PROMOTION_NAVAL_TRADITION"]
local unitPromotionExplorationEmbarkID = GameInfoTypes["PROMOTION_EXPLORATION_EMBARK"]
local unitPromotionGreatLighthouseID = GameInfoTypes["PROMOTION_GREAT_LIGHTHOUSE"]
local unitPromotionBelemID = GameInfoTypes["PROMOTION_JFD_BELEM"]

function GreatAdmiralPromotions(playerID)
	local player = Players[playerID]
	local unit = player:GetUnitByID(unitID)
	if player and player:IsEverAlive() then
		for unit in player:Units() do
			if unit and unit:GetUnitClassType() == GameInfoTypes["UNITCLASS_GREAT_ADMIRAL"] then
				JFD_AddPromotion(unit, unitPromotionExplorationEmbarkID, false)
				JFD_AddPromotion(unit, unitPromotionBelemID, false)
				if player:HasPolicy(GameInfoTypes["POLICY_EXPLORATION"]) then
					JFD_AddPromotion(unit, unitPromotionExplorationID, true)
				end
				if player:GetBuildingClassCount(GameInfoTypes["BUILDINGCLASS_GREAT_LIGHTHOUSE"]) > 0 then
					JFD_AddPromotion(unit, unitPromotionGreatLighthouseID, true)
				end
			end
		end
	end
end

function GreatAdmiralPromotionsUnit(playerID, unitID)
	local player = Players[playerID]
	local unit = player:GetUnitByID(unitID)
	if player and player:IsEverAlive() then
		if unit and unit:GetUnitClassType() == GameInfoTypes["UNITCLASS_GREAT_ADMIRAL"] then
			JFD_AddPromotion(unit, unitPromotionExplorationEmbarkID, false)
			JFD_AddPromotion(unit, unitPromotionBelemID, false)
			if player:HasPolicy(GameInfoTypes["POLICY_EXPLORATION"]) then
				JFD_AddPromotion(unit, unitPromotionExplorationID, true)
			end
			if player:GetBuildingClassCount(GameInfoTypes["BUILDINGCLASS_GREAT_LIGHTHOUSE"]) > 0 then
				JFD_AddPromotion(unit, unitPromotionGreatLighthouseID, true)
			end
		end
	end
end

GameEvents.PlayerDoTurn.Add(GreatAdmiralPromotions)
GameEvents.CityConstructed.Add(GreatAdmiralPromotions)
GameEvents.PlayerAdoptPolicy.Add(GreatAdmiralPromotions)
Events.SerialEventUnitCreated.Add(GreatAdmiralPromotionsUnit)
--=======================================================================================================================
--=======================================================================================================================