-- United Kingdom Functions
-- Author: JFD
-- Edited By: F0S
--==========================================================================================================================
-- UTILITY FUNCTIONS
--==========================================================================================================================
-- JFD_IsCivilisationActive
--------------------------------------------------------------
local civilisationID = GameInfoTypes["CIVILIZATION_JFD_UNITED_KINGDOM"]

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
------------------------------------------------------------------------------------------------------------------------
-- JFD_GetNumPledgesofProtection
------------------------------------------------------------------------------------------------------------------------
function JFD_GetNumPledgesofProtection(playerID)
	local player = Players[playerID]
	local playerTeam = Teams[player:GetTeam()]
	local numPledgesofProtection = 0
	for cityStatePlayerID, cityStatePlayer in pairs(Players) do
		if cityStatePlayer:IsEverAlive() and cityStatePlayer:IsMinorCiv() then
			if cityStatePlayer:IsProtectedByMajor(playerID) then
				numPledgesofProtection = numPledgesofProtection + 1
			end
		end	
	end
	return numPledgesofProtection 
end
------------------------------------------------------------------------------------------------------------------------
-- JFD_GetNumSeaTradeRoutesFromCity
------------------------------------------------------------------------------------------------------------------------
function JFD_GetNumSeaTradeRoutesFromCity(player, city)
	local numSeaTradeRoutes = 0
	local tradeRoutes = player:GetTradeRoutes()
	for i, v in ipairs(tradeRoutes) do
		local domain = v.Domain
		if city == v.FromCity then
			if domain == GameInfoTypes["DOMAIN_SEA"] then
				numSeaTradeRoutes = numSeaTradeRoutes + 1
			end
		end
	end
	return numSeaTradeRoutes * player:GetCurrentEra()
end
--=======================================================================================================================
-- CORE FUNCTIONS	
--=======================================================================================================================
-- JFD_AirAndNavalProduction
------------------------------------------------------------------------------------------------------------------------
local buildingNavalAirProductionID = GameInfoTypes["BUILDING_JFD_NAVAL_AND_AIR_PRODUCTION"]

function JFD_AirAndNavalProduction(playerID)
	local player = Players[playerID]
	if player:IsEverAlive() and player:GetCivilizationType() == civilisationID then
		for city in player:Cities() do
			if city then
				local numPledges = math.min(10, JFD_GetNumPledgesofProtection(playerID))
				if city:GetNumBuilding(buildingNavalAirProductionID) ~= numPledges then
					city:SetNumRealBuilding(buildingNavalAirProductionID, numPledges)
				end
			end
		end
	end
end

function JFD_AirAndNavalProductionDirty()
	local playerID = Game.GetActivePlayer()
    local player = Players[playerID]
	if player:IsTurnActive() then
        JFD_AirAndNavalProduction(playerID)
    end
end
------------------------------------------------------------------------------------------------------------------------
-- JFD_SeaTradeRouteProduction
------------------------------------------------------------------------------------------------------------------------
local buildingSeaTradeProductionID = GameInfoTypes["BUILDING_JFD_SEA_TRADE_PRODUCTION"]
local buildingChurchillTrackerID = GameInfoTypes["BUILDING_JFD_CHURCHILL_TRACKER"]

function JFD_SeaTradeRouteProduction(playerID)
	local player = Players[playerID]
	if player:IsEverAlive() and player:GetCivilizationType() == civilisationID then
		for city in player:Cities() do
			if city and city:IsCoastal() then
				local numSeaTradeRoutes = JFD_GetNumSeaTradeRoutesFromCity(player, city)
				if city:GetNumBuilding(buildingSeaTradeProductionID) ~= numSeaTradeRoutes then
					city:SetNumRealBuilding(buildingSeaTradeProductionID, numSeaTradeRoutes)
				end
				if numSeaTradeRoutes > 0 then
					if not city:IsHasBuilding(buildingChurchillTrackerID) then
						city:SetNumRealBuilding(buildingChurchillTrackerID, 1)
					end
				else
					if city:IsHasBuilding(buildingChurchillTrackerID) then
						city:SetNumRealBuilding(buildingChurchillTrackerID, 0)
					end
				end
			end
		end
	end
end

function JFD_SeaTradeRouteProductionDirty()
	local playerID = Game.GetActivePlayer()
    local player = Players[playerID]
	if player:IsTurnActive() then
        JFD_SeaTradeRouteProduction(playerID)
    end
end

if JFD_IsCivilisationActive(civilisationID) then
	GameEvents.PlayerDoTurn.Add(JFD_AirAndNavalProduction)
	Events.SerialEventGameDataDirty.Add(JFD_AirAndNavalProductionDirty)
	GameEvents.PlayerDoTurn.Add(JFD_SeaTradeRouteProduction)
	Events.SerialEventGameDataDirty.Add(JFD_SeaTradeRouteProductionDirty)
end
--=======================================================================================================================
--=======================================================================================================================