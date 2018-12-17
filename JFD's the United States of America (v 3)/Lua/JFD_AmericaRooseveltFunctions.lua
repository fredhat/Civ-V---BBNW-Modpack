-- JFD_AmericaRooseveltFunctions
-- Author: JFD
-- Heavily Edited By: F0S
--==========================================================================================================================
-- UTILITY FUNCTIONS
--==========================================================================================================================
WARN_NOT_SHARED = false; include( "Sukritact_SaveUtils.lua" ); MY_MOD_NAME = "JFD_AmericaRooseveltFunctions";
include("PlotIterators")
--------------------------------------------------------------
-- JFD_IsCivilisationActive
--------------------------------------------------------------
local civilisationRooseveltID = GameInfoTypes["CIVILIZATION_JFD_AMERICA_ROOSEVELT"]
local civilisationWashingtonID = GameInfoTypes["CIVILIZATION_AMERICA"]

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
-- CORE ROOSEVELT FUNCTIONS
--==========================================================================================================================
--JFD_RooseveltNewDeal
----------------------------------------------------------------------------------------------------------------------------
local buildingRooseveltProductionDummyID = GameInfoTypes["BUILDING_JFD_ROOSEVELT_PRODUCTION_DUMMY"]
local buildingRooseveltEngineerDummyID = GameInfoTypes["BUILDING_JFD_ROOSEVELT_ENGINEER_DUMMY"]
local buildingRooseveltGoldDummyID = GameInfoTypes["BUILDING_JFD_ROOSEVELT_GOLD_DUMMY"]
local buildingRooseveltMerchantDummyID = GameInfoTypes["BUILDING_JFD_ROOSEVELT_MERCHANT_DUMMY"]
local buildingRooseveltIndustryMonitorID = GameInfoTypes["BUILDING_JFD_ROOSEVELT_INDUSTRY_MONITOR"]
local buildingRooseveltEconomyMonitorID = GameInfoTypes["BUILDING_JFD_ROOSEVELT_ECONOMY_MONITOR"]

function JFD_NewDealBuildingManager(city, newDealEconomy, numNewDealBuildings)
	if city:IsCapital() then
		if newDealEconomy then
			if city:GetNumBuilding(buildingRooseveltMerchantDummyID) ~= numNewDealBuildings then
				city:SetNumRealBuilding(buildingRooseveltMerchantDummyID, numNewDealBuildings)
				city:SetNumRealBuilding(buildingRooseveltEngineerDummyID, 0)
			end
		else
			if city:GetNumBuilding(buildingRooseveltEngineerDummyID) ~= numNewDealBuildings then
				city:SetNumRealBuilding(buildingRooseveltMerchantDummyID, 0)
				city:SetNumRealBuilding(buildingRooseveltEngineerDummyID, numNewDealBuildings)
			end
		end
	end
	if newDealEconomy then
		if not city:IsHasBuilding(buildingRooseveltEconomyMonitorID) then
			city:SetNumRealBuilding(buildingRooseveltEconomyMonitorID, 1)
			city:SetNumRealBuilding(buildingRooseveltIndustryMonitorID, 0)
		end
		if city:GetNumBuilding(buildingRooseveltGoldDummyID) ~= numNewDealBuildings then
			city:SetNumRealBuilding(buildingRooseveltGoldDummyID, numNewDealBuildings)
			city:SetNumRealBuilding(buildingRooseveltProductionDummyID, 0)
		end
	else
		if not city:IsHasBuilding(buildingRooseveltIndustryMonitorID) then
			city:SetNumRealBuilding(buildingRooseveltEconomyMonitorID, 0)
			city:SetNumRealBuilding(buildingRooseveltIndustryMonitorID, 1)
		end
		if city:GetNumBuilding(buildingRooseveltProductionDummyID) ~= numNewDealBuildings then
			city:SetNumRealBuilding(buildingRooseveltGoldDummyID, 0)
			city:SetNumRealBuilding(buildingRooseveltProductionDummyID, numNewDealBuildings)
		end
	end
end

function JFD_NewDealCitiesPolicy(playerID, policyID)
	local player = Players[playerID]
	if player:IsEverAlive() and player:GetCivilizationType() == civilisationRooseveltID then
		local newDealEconomy = load(player, "NewDealEconomy")
		if newDealEconomy == nil then
			save(player, "NewDealEconomy", true)
			save(player, "NewDealBuildings", 1)
			newDealEconomy = false
		else
			local numNewDealBuildings = load(player, "NewDealBuildings")
			if newDealEconomy then
				save(player, "NewDealEconomy", false)
			else
				save(player, "NewDealEconomy", true)
				save(player, "NewDealBuildings", numNewDealBuildings + 1)
			end
		end
		JFD_NewDealCitiesTurn(playerID)
		if player:IsHuman() and player:IsTurnActive() then
			if newDealEconomy then
				local descriptionShort = Locale.ConvertTextKey("TXT_KEY_JFD_ROOSEVELT_ENGINEER_MESSAGE")
				local description = Locale.ConvertTextKey("TXT_KEY_JFD_ROOSEVELT_ENGINEER_MESSAGE_HELP")
				player:AddNotification(NotificationTypes["NOTIFICATION_GENERIC"], description, descriptionShort)
			else
				local descriptionShort = Locale.ConvertTextKey("TXT_KEY_JFD_ROOSEVELT_MERCHANT_MESSAGE")
				local description = Locale.ConvertTextKey("TXT_KEY_JFD_ROOSEVELT_MERCHANT_MESSAGE_HELP")
				player:AddNotification(NotificationTypes["NOTIFICATION_GENERIC"], description, descriptionShort)
			end
		end
	end
end

function JFD_NewDealCitiesTurn(playerID)
	local player = Players[playerID]
	if player:IsEverAlive() and player:GetCivilizationType() == civilisationRooseveltID then
		local newDealEconomy = load(player, "NewDealEconomy")
		if newDealEconomy ~= nil then
			local numNewDealBuildings = load(player, "NewDealBuildings") or 0
			for city in player:Cities() do
				if city then
					JFD_NewDealBuildingManager(city, newDealEconomy, numNewDealBuildings)
				end
			end
		end
	end
end

function JFD_NewDealCitiesTurnDirty()
	local playerID = Game.GetActivePlayer()
    local player = Players[playerID]
	if player:IsTurnActive() then
        JFD_NewDealCitiesTurn(playerID)
    end
end

if JFD_IsCivilisationActive(civilisationRooseveltID) then
	GameEvents.PlayerAdoptPolicy(JFD_NewDealCitiesPolicy)
	GameEvents.PlayerDoTurn.Add(JFD_NewDealCitiesTurn)
	Events.SerialEventCityInfoDirty.Add(JFD_NewDealCitiesTurnDirty)
end
--==========================================================================================================================
-- CORE WASHINGTON FUNCTIONS
--==========================================================================================================================
-- JFD_WashingtonRanchClaimAndImprove
----------------------------------------------------------------------------------------------------------------------------
local buildingRanchID = GameInfoTypes["BUILDING_JFD_RANCH"]
local improvementCampID = GameInfoTypes["IMPROVEMENT_CAMP"]
local improvementPastureID = GameInfoTypes["IMPROVEMENT_PASTURE"]
local resourceBisonID = GameInfoTypes["RESOURCE_BISON"]
local resourceCowID = GameInfoTypes["RESOURCE_COW"]
local resourceDeerID = GameInfoTypes["RESOURCE_DEER"]
local resourceHorseID = GameInfoTypes["RESOURCE_HORSE"]
local resourceSheepID = GameInfoTypes["RESOURCE_SHEEP"]
local tableResourceImprovements = {
	[resourceBisonID] = improvementCampID,
	[resourceCowID] = improvementPastureID,
	[resourceDeerID] = improvementCampID,
	[resourceHorseID] = improvementPastureID,
	[resourceSheepID] = improvementPastureID
}

function JFD_WashingtonRanchClaimAndImprove(playerID, cityID, buildingID)
	local player = Players[playerID]
	if player:IsEverAlive() and player:GetCivilizationType() == civilisationWashingtonID then
		if buildingID == buildingRanchID then
			local city = player:GetCityByID(cityID)
			if city then
				local plot = Map.GetPlot(city:GetX(), city:GetY())
				if plot and load(plot, "hasRanchEver") == nil then
					for spawnPlot in PlotAreaSpiralIterator(plot, 3, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
						if spawnPlot:GetOwner() == -1 or spawnPlot:GetOwner() == playerID then
							print("found plot")
							for resourceID, improvementID in pairs(tableResourceImprovements) do
								print(resourceID)
								print(improvementID)
								if spawnPlot:GetResourceType() == resourceID then
									if spawnPlot:GetOwner() == -1 then
										spawnPlot:SetOwner(playerID, cityID)
										spawnPlot:SetRevealed(player:GetTeam(), true)
										spawnPlot:UpdateFog()
									end
									if spawnPlot:GetImprovementType() == -1 then
										spawnPlot:SetImprovementType(improvementID)
									end
								end
							end
						end
					end
					save(plot, "hasRanchEver", 1)
				end
			end
		end
	end 	
end

if JFD_IsCivilisationActive(civilisationWashingtonID) then
	GameEvents.CityConstructed.Add(JFD_WashingtonRanchClaimAndImprove)
end
--==========================================================================================================================
--==========================================================================================================================