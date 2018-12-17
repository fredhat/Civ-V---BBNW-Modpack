-- USSR Stalin Functions
-- Author: JFD
-- Heavily Edited By: F0S
--==========================================================================================================================
-- UTILITY FUNCTIONS
--==========================================================================================================================
-- JFD_IsCivilisationActive
--------------------------------------------------------------
WARN_NOT_SHARED = false; include( "Sukritact_SaveUtils.lua" ); MY_MOD_NAME = "JFD_StalinistSovietUnion";
local civilisationID = GameInfoTypes["CIVILIZATION_JFD_USSR_STALIN"]

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
--InitStalin
-------------------------------------------------------------------------------------------------------------------------
local policyStalinQuickID = GameInfoTypes["POLICY_JFD_STALIN_QUICK"]
local policyStalinStandardID = GameInfoTypes["POLICY_JFD_STALIN_STANDARD"]
local policyStalinEpicID = GameInfoTypes["POLICY_JFD_STALIN_EPIC"]
local policyStalinMarathonID = GameInfoTypes["POLICY_JFD_STALIN_MARATHON"]

function JFD_GetInfluenceSpeed(gameSpeed)
	if gameSpeed == GameInfoTypes["GAMESPEED_QUICK"] then
		return policyStalinQuickID
	elseif gameSpeed == GameInfoTypes["GAMESPEED_STANDARD"] then
		return policyStalinStandardID
	elseif gameSpeed == GameInfoTypes["GAMESPEED_EPIC"] then
		return policyStalinEpicID
	else
		return policyStalinMarathonID
	end
end

function InitStalin()
	for playerID, player in pairs(Players) do
		local player = Players[playerID]
		if player:IsEverAlive() and player:GetCivilizationType() == civilisationID then
			local policy = JFD_GetInfluenceSpeed(Game.GetGameSpeedType())
			if not player:HasPolicy(policy) then
				player:SetNumFreePolicies(player:GetNumFreePolicies() + 1)
				player:SetNumFreePolicies(player:GetNumFreePolicies() - 1)
				player:SetHasPolicy(policy, true)	
			end
		end
	end 
end
----------------------------------------------------------------------------------------------------------------------------
-- JFD_SatelliteStates
----------------------------------------------------------------------------------------------------------------------------
local buildingStalinCommissariatID = GameInfoTypes["BUILDING_JFD_STALIN_COMMISSARIAT"]
local buildingStalinSatellitesID = GameInfoTypes["BUILDING_JFD_STALIN_SATELLITES"]

function JFD_GetNumCityStateTradeRoutes(player)
	local numCityStatesConnected = 0
	local tradeRoutes = player:GetTradeRoutes()
	for i, v in ipairs(tradeRoutes) do
		if Players[v.ToCity:GetOwner()]:IsMinorCiv() then
			numCityStatesConnected = numCityStatesConnected + 1
		end
	end
	return numCityStatesConnected
end

function JFD_SatelliteStatesProduction(playerID)
	local player = Players[playerID]
	if player:IsEverAlive() then
		local numCityStateTradeRoutes = JFD_GetNumCityStateTradeRoutes(player)
		for city in player:Cities() do
			if city:IsHasBuilding(buildingStalinCommissariatID) then
				if city:GetNumBuilding(buildingStalinSatellitesID) ~= numCityStateTradeRoutes then
					city:SetNumRealBuilding(buildingStalinSatellitesID, numCityStateTradeRoutes)
				end
			else
				if city:IsHasBuilding(buildingStalinSatellitesID) then
					city:SetNumRealBuilding(buildingStalinSatellitesID, 0)
				end
			end
		end
	end
end

function JFD_SatelliteStatesProductionDirty()
	local playerID = Game.GetActivePlayer()
    local player = Players[playerID]
	if player:IsTurnActive() then
        JFD_SatelliteStatesProduction(playerID)
    end
end

function JFD_SatelliteStatesProductionInitialTrigger(playerID, cityID, buildingID)
	local player = Players[playerID]
	local city = player:GetCityByID(cityID)
	if city and city:IsHasBuilding(buildingStalinCommissariatID) then
		GameEvents.PlayerDoTurn.Add(JFD_SatelliteStatesProduction)
		Events.SerialEventGameDataDirty.Add(JFD_SatelliteStatesProductionDirty)
		GameEvents.CityConstructed.Remove(JFD_SatelliteStatesProductionInitialTrigger)
		save("GAME", "JFD_SatelliteStatesProductionInitalised", true)
		JFD_SatelliteStatesProduction(playerID)
	end
end
----------------------------------------------------------------------------------------------------------------------------
-- JFD_WarsawPact
----------------------------------------------------------------------------------------------------------------------------
local policyBranchAutocracyID = GameInfoTypes["POLICY_BRANCH_AUTOCRACY"]
local policyBranchFreedomID = GameInfoTypes["POLICY_BRANCH_FREEDOM"]
local policyBranchOrderID = GameInfoTypes["POLICY_BRANCH_ORDER"]
local promotionWarsawPactID = GameInfoTypes["PROMOTION_JFD_WARSAW_PACT"]

function JFD_GetIdeology(player)
	if player:IsPolicyBranchUnlocked(policyBranchAutocracyID) then
		return policyBranchAutocracyID
	elseif player:IsPolicyBranchUnlocked(policyBranchFreedomID) then
		return policyBranchFreedomID
	elseif player:IsPolicyBranchUnlocked(policyBranchOrderID) then
		return policyBranchOrderID
	end
	return nil
end

function JFD_GetWarStalins(playerID)
	local player = Players[playerID]
	local tableStalins = {}
	for otherPlayerID = 0, GameDefines.MAX_MAJOR_CIVS - 1 do
		local otherPlayer = Players[otherPlayerID]
		if otherPlayer:IsEverAlive() and otherPlayerID ~= playerID and otherPlayer:GetCivilizationType() == civilisationID then
			if Teams[player:GetTeam()]:IsAtWar(otherPlayer:GetTeam()) then
				table.insert(tableStalins, otherPlayerID)
			end
		end
	end
	return tableStalins
end

function JFD_PlotSovietTerritory(plotOwnerID, otherPlayerID)
	local plotOwner = Players[plotOwnerID]
	local otherPlayer = Players[otherPlayerID]
	local ideology = JFD_GetIdeology(otherPlayer)
	if plotOwnerID == otherPlayerID or (plotOwner:IsMinorCiv() and plotOwner:GetMinorCivFriendshipLevelWithMajor(otherPlayerID) == 2) or (ideology ~= nil and plotOwner:IsPolicyBranchUnlocked(ideology)) then
		return true
	end
	return false
end

function JFD_IsInSovietTerritory(playerID, unit, plot)
	local isUnitInSovietTerritory = false
	local warStalins = JFD_GetWarStalins(playerID)
	local plotOwnerID = plot:GetOwner()
	if #warStalins > 0 and plotOwnerID ~= -1 and plotOwnerID ~= playerID and Players[plotOwnerID]:IsEverAlive() then
		for _, otherPlayerID in pairs(warStalins) do
			if JFD_PlotSovietTerritory(plotOwnerID, otherPlayerID) then
				isUnitInSovietTerritory = true
				break
			end
		end
	end
	unit:SetHasPromotion(promotionWarsawPactID, isUnitInSovietTerritory)
end

function JFD_WarsawPactTurn(playerID)
	local player = Players[playerID]
	if player:IsEverAlive() then
		for unit in player:Units() do
			if unit then
				local plot = Map.GetPlot(unit:GetX(), unit:GetY())
				if plot then
					JFD_IsInSovietTerritory(playerID, unit, plot)
				end
			end
		end
	end
end

function JFD_WarsawPactXY(playerID, unitID, unitX, unitY)
	local player = Players[playerID]
	if player:IsEverAlive() then
		local unit = player:GetUnitByID(unitID)
		if unit then
			local plot = Map.GetPlot(unitX, unitY)
			if plot then
				JFD_IsInSovietTerritory(playerID, unit, plot)
			end
		end
	end
end

if JFD_IsCivilisationActive(civilisationID) then
	Events.SequenceGameInitComplete.Add(InitStalin)
	if load("GAME", "JFD_SatelliteStatesProductionInitalised") then
		GameEvents.PlayerDoTurn.Add(JFD_SatelliteStatesProduction)
		Events.SerialEventGameDataDirty.Add(JFD_SatelliteStatesProductionDirty)
	else
		GameEvents.CityConstructed.Add(JFD_SatelliteStatesProductionInitialTrigger)
	end
	GameEvents.PlayerDoTurn.Add(JFD_WarsawPactTurn)
	GameEvents.UnitSetXY.Add(JFD_WarsawPactXY)
end
----------------------------------------------------------------------------------------------------------------------------
-- JFD_IS2Bonuses
----------------------------------------------------------------------------------------------------------------------------
local promotionStalinIS2InfoID = GameInfoTypes["PROMOTION_JFD_STALIN_IS2_INFO"]
local promotionStalinIS2ID = GameInfoTypes["PROMOTION_JFD_STALIN_IS2"]

function JFD_IS2Bonuses(playerID, unit, plot)
	local player = Players[playerID]
	local isUnitInFriendlyTerritory = false
	if unit:IsHasPromotion(promotionStalinIS2InfoID) then
		local plotOwnerID = plot:GetOwner()
		local plotOwner = Players[plotOwnerID]
		local ideology = JFD_GetIdeology(player)
		if plotOwnerID == playerID or (plotOwner:IsMinorCiv() and plotOwner:GetMinorCivFriendshipLevelWithMajor(playerID) == 2) or (ideology ~= nil and plotOwner:IsPolicyBranchUnlocked(ideology)) then
			isUnitInFriendlyTerritory = true
		end
	end	
	if isUnitInFriendlyTerritory then
		if unit:IsHasPromotion(promotionStalinIS2InfoID) then
			unit:SetHasPromotion(promotionStalinIS2ID, true)
			unit:SetHasPromotion(promotionStalinIS2InfoID, false)
		end					
	else
		if unit:IsHasPromotion(promotionStalinIS2ID) then
			unit:SetHasPromotion(promotionStalinIS2ID, false)
			unit:SetHasPromotion(promotionStalinIS2InfoID, true)
		end	
	end
end

function JFD_IS2BonusesTurn(playerID)
	local player = Players[playerID]
	if player:IsEverAlive() then
		for unit in player:Units() do
			if unit then
				local plot = Map.GetPlot(unit:GetX(), unit:GetY())
				if plot then
					JFD_IS2Bonuses(playerID, unit, plot)
				end
			end
		end
	end
end

function JFD_IS2BonusesXY(playerID, unitID)
	local player = Players[playerID]
	if player:IsEverAlive() then
		local unit = player:GetUnitByID(unitID)
		if unit then
			local plot = Map.GetPlot(unit:GetX(), unit:GetY())
			if plot then
				JFD_IS2Bonuses(playerID, unit, plot)
			end
		end
	end
end

function JFD_IS2BonusesInitialTrigger(playerID, unitID)
	local player = Players[playerID]
	local unit = player:GetUnitByID(unitID)
	if unit and unit:IsHasPromotion(promotionStalinIS2InfoID) then
		GameEvents.PlayerDoTurn.Add(JFD_IS2BonusesTurn)
		GameEvents.UnitSetXY.Add(JFD_IS2BonusesXY)
		Events.SerialEventUnitCreated.Add(JFD_IS2BonusesXY)
		Events.SerialEventUnitCreated.Remove(JFD_IS2BonusesInitialTrigger)
		save("GAME", "JFD_IS2BonusesInitalised", true)
		JFD_IS2BonusesXY(playerID, unitID)
	end
end

if load("GAME", "JFD_IS2BonusesInitalised") then
	GameEvents.PlayerDoTurn.Add(JFD_IS2BonusesTurn)
	GameEvents.UnitSetXY.Add(JFD_IS2BonusesXY)
	Events.SerialEventUnitCreated.Add(JFD_IS2BonusesXY)
else
	Events.SerialEventUnitCreated.Add(JFD_IS2BonusesInitialTrigger)
end
--=======================================================================================================================
--=======================================================================================================================