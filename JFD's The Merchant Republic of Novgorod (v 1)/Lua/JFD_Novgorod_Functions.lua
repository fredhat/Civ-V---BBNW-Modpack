-- JFD_Novgorod_Functions
-- Author: JFD
-- Heavily Edited By: F0S
--=======================================================================================================================
-- UTILITIES
--=======================================================================================================================
-- JFD_AtPeace
--------------------------------------------------------------------------------------------------------------------------
WARN_NOT_SHARED = false; include( "Sukritact_SaveUtils.lua" ); MY_MOD_NAME = "JFD_Novgorod_Functions";

function JFD_AtPeace(playerID)
	local atPeace = false
	if Teams[Players[playerID]:GetTeam()]:GetAtWarCount(true) == 0 then 
		atPeace = true 
	end
	return atPeace
end
--------------------------------------------------------------------------------------------------------------------------
-- JFD_GetNumTradeRoutesToPlayer
--------------------------------------------------------------------------------------------------------------------------
function JFD_GetNumTradeRoutesToPlayer(playerID, otherPlayerID)
	local player = Players[playerID]
	local otherPlayer = Players[otherPlayerID]
	local tradeRoutes = player:GetTradeRoutes()
	local otherTradeRoutes = otherPlayer:GetTradeRoutes()
	local numTradeRoutesToPlayer = 0
	for i, v in ipairs(tradeRoutes) do
		if v.ToCity:GetOwner() == otherPlayerID then numTradeRoutesToPlayer = numTradeRoutesToPlayer + 1 end
	end
	for i, v in ipairs(otherTradeRoutes) do
		if v.ToCity:GetOwner() == playerID then numTradeRoutesToPlayer = numTradeRoutesToPlayer + 1 end
	end
	return numTradeRoutesToPlayer
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
-------------------------------------------------------------------------------------------------------------------------
-- DecompilePlotID
-------------------------------------------------------------------------------------------------------------------------
function DecompilePlotID(key)
    breakID = string.find(key, "Y")
    plotX = tonumber(string.sub(key, 1, breakID - 1))
    plotY = tonumber(string.sub(key, breakID + 1))
    plot = Map.GetPlot(plotX, plotY)
    return plot
end
-------------------------------------------------------------------------------------------------------------------------
-- CompilePlotID
-------------------------------------------------------------------------------------------------------------------------
function CompilePlotID(plot)
    plotX = plot:GetX()
    plotY = plot:GetY()
    return(plotX .. "Y" .. plotY)
end
--=======================================================================================================================
-- CORE FUNCTIONS	
--=======================================================================================================================
-- Globals
--------------------------------------------------------------------------------------------------------------------------
local civilisationID = GameInfoTypes["CIVILIZATION_JFD_NOVGOROD"]
local isNovgorodCivActive = JFD_IsCivilisationActive(civilisationID)
----------------------------------------------------------------------------------------------------------------------------
-- JFD_NovgorodExtraTRs
----------------------------------------------------------------------------------------------------------------------------	
local buildingNovgorodExtraTradeID = GameInfoTypes["BUILDING_JFD_NOVGOROD_TR"] 

function JFD_NovgorodExtraTRs(playerID)
	local player = Players[playerID]
	if player:IsEverAlive() and player:GetCivilizationType() == civilisationID then
		for city in player:Cities() do
			if city:IsCapital() then
				if not city:IsHasBuilding(buildingNovgorodExtraTradeID) then
					city:SetNumRealBuilding(buildingNovgorodExtraTradeID, 1)
				end
			else
				if city:IsHasBuilding(buildingNovgorodExtraTradeID) then
					city:SetNumRealBuilding(buildingNovgorodExtraTradeID, 0)
				end
			end
		end
	end
end

function JFD_NovgorodExtraTRsConquest(oldOwnerID, capital, iX, iY, newOwnerID)
	JFD_NovgorodExtraTRs(oldOwnerID)
	JFD_NovgorodExtraTRs(newOwnerID)
end
----------------------------------------------------------------------------------------------------------------------------
-- JFD_PeaceOfNovgorod
----------------------------------------------------------------------------------------------------------------------------	
function JFD_PeaceOfNovgorod(teamID, otherTeamID)
	for playerID = 0, GameDefines.MAX_MAJOR_CIVS - 1 do
		local player = Players[playerID]
		if player:IsEverAlive() and player:GetTeam() == teamID and not player:IsMinorCiv() then
			for otherPlayerID = 0, GameDefines.MAX_MAJOR_CIVS - 1 do
				if otherPlayerID ~= playerID then
					local otherPlayer = Players[otherPlayerID]
					if otherPlayer:IsEverAlive() and otherPlayer:GetTeam() == otherTeamID and not otherPlayer:IsMinorCiv() then
						if player:GetCivilizationType() == civilisationID or otherPlayer:GetCivilizationType() == civilisationID then
							return (JFD_GetNumTradeRoutesToPlayer(playerID, otherPlayerID) < 3)
						end
					end
				end
			end
		end
	end
	return true
end
----------------------------------------------------------------------------------------------------------------------------
-- JFD_NovgorodTradeCalcs
----------------------------------------------------------------------------------------------------------------------------
local buildingPogostID = GameInfoTypes["BUILDING_JFD_POGOST"]
local buildingPogostConnectionID = GameInfoTypes["BUILDING_JFD_POGOST_CONNECTION"]
local buildingNovgorodDefenseID = GameInfoTypes["BUILDING_JFD_NOVGOROD_DEFENSE"]
local buildingNovgorodTrackerID = GameInfoTypes["BUILDING_JFD_NOVGOROD_TRACKER"]

function JFD_NovgorodTradeCalcs(playerID)
	local player = Players[playerID]
    if player:IsEverAlive() and player:GetCivilizationType() == civilisationID then 
		local tableNovgorodDefense = {}
		local tableNovgorodProduction = {}
		for city in player:Cities() do
			if city then
				local cityPlot = city:Plot()
				if cityPlot then
					tableNovgorodDefense[CompilePlotID(cityPlot)] = 0
					tableNovgorodProduction[CompilePlotID(cityPlot)] = 0
				end
			end
		end
		for otherPlayerID = 0, GameDefines.MAX_MAJOR_CIVS - 1 do
			if otherPlayerID ~= playerID then
				local otherPlayer = Players[otherPlayerID]
				if otherPlayer:IsEverAlive() and not otherPlayer:IsMinorCiv() then
					local otherTradeRoutes = otherPlayer:GetTradeRoutes()
					for otherCity in otherPlayer:Cities() do
						local numTradeRoutesDefense = 0
						local numTradeRoutesProduction = 0
						for i, v in ipairs(otherTradeRoutes) do
							if v.FromCity:GetID() == otherCity:GetID() and v.ToCity:GetOwner() == playerID then
								numTradeRoutesDefense = numTradeRoutesDefense + 1
								local cityPlot = v.ToCity:Plot()
								if cityPlot then
									local index = CompilePlotID(cityPlot)
									local novgorodDefense = tableNovgorodDefense[index]
									if novgorodDefense ~= nil then tableNovgorodDefense[index] = novgorodDefense + 1 end
									if v.ToCity:IsHasBuilding(buildingPogostID) then
										numTradeRoutesProduction = numTradeRoutesProduction + 1
										local novgorodProduction = tableNovgorodProduction[index]
										if novgorodProduction ~= nil then tableNovgorodProduction[index] = novgorodProduction + 1 end
									end
								end
							end
							if (numTradeRoutesDefense + numTradeRoutesProduction) > 0 then
								if not otherCity:IsHasBuilding(buildingNovgorodTrackerID) then
									otherCity:SetNumRealBuilding(buildingNovgorodTrackerID, 1)
								end
							else
								if otherCity:IsHasBuilding(buildingNovgorodTrackerID) then
									otherCity:SetNumRealBuilding(buildingNovgorodTrackerID, 0)
								end
							end
							if otherCity:GetNumBuilding(buildingNovgorodDefenseID) ~= math.min(numTradeRoutesDefense, 5) then
								otherCity:SetNumRealBuilding(buildingNovgorodDefenseID, math.min(numTradeRoutesDefense, 5))
							end
							if otherCity:GetNumBuilding(buildingPogostConnectionID) ~= numTradeRoutesProduction then
								otherCity:SetNumRealBuilding(buildingPogostConnectionID, numTradeRoutesProduction)
							end
						end
					end
				end
			end
		end
		for city in player:Cities() do
			if city then
				local cityPlot = city:Plot()
				if cityPlot then
					local numTradeRoutesDefense = tableNovgorodDefense[CompilePlotID(cityPlot)]
					local numTradeRoutesProduction = tableNovgorodProduction[CompilePlotID(cityPlot)]
					if (numTradeRoutesDefense + numTradeRoutesProduction) > 0 then
						if not city:IsHasBuilding(buildingNovgorodTrackerID) then
							city:SetNumRealBuilding(buildingNovgorodTrackerID, 1)
						end
					else
						if city:IsHasBuilding(buildingNovgorodTrackerID) then
							city:SetNumRealBuilding(buildingNovgorodTrackerID, 0)
						end
					end
					if city:GetNumBuilding(buildingNovgorodDefenseID) ~= math.min(numTradeRoutesDefense, 5) then
						city:SetNumRealBuilding(buildingNovgorodDefenseID, math.min(numTradeRoutesDefense, 5))
					end
					if city:GetNumBuilding(buildingPogostConnectionID) ~= numTradeRoutesProduction then
						city:SetNumRealBuilding(buildingPogostConnectionID, numTradeRoutesProduction)
					end
				end
			end
		end
	end
end

function JFD_NovgorodTradeCalcsDirty()
	local playerID = Game.GetActivePlayer()
	local player = Players[playerID]
	if player:IsTurnActive() then
		JFD_NovgorodTradeCalcs(playerID)
	end
end

if isNovgorodCivActive then
	GameEvents.PlayerCityFounded.Add(JFD_NovgorodExtraTRs)
	GameEvents.PlayerDoTurn.Add(JFD_NovgorodExtraTRs)
	GameEvents.CityCaptureComplete.Add(JFD_NovgorodExtraTRsConquest)
	GameEvents.CanDeclareWar.Add(JFD_PeaceOfNovgorod)
	GameEvents.PlayerDoTurn.Add(JFD_NovgorodTradeCalcs)
	Events.SerialEventCityInfoDirty.Add(JFD_NovgorodTradeCalcsDirty)
end
----------------------------------------------------------------------------------------------------------------------------
-- JFD_BoyarNobility
----------------------------------------------------------------------------------------------------------------------------
local buildingBoyarPeaceID = GameInfoTypes["BUILDING_JFD_BOYAR_PEACE"]
local buildingBoyarWarID = GameInfoTypes["BUILDING_JFD_BOYAR_WAR"]
local unitPromotionBoyarID = GameInfoTypes["PROMOTION_JFD_BOYAR"]

function JFD_BoyarNobility(playerID)
	local player = Players[playerID]
	if player:IsEverAlive() then
		for city in player:Cities() do
			local boyarIsHere = false
			local plot = city:Plot()
			for unitID = 0, plot:GetNumUnits() - 1, 1 do
				local unit = plot:GetUnit(unitID)
				if unit and unit:IsHasPromotion(unitPromotionBoyarID) then
					boyarIsHere = true
					break
				end
			end
			if boyarIsHere then
				if JFD_AtPeace(playerID) then
					city:SetNumRealBuilding(buildingBoyarPeaceID, 1)
					city:SetNumRealBuilding(buildingBoyarWarID, 0)
				else
					city:SetNumRealBuilding(buildingBoyarWarID, 1)
					city:SetNumRealBuilding(buildingBoyarPeaceID, 0)
				end
			else
				city:SetNumRealBuilding(buildingBoyarPeaceID, 0)
				city:SetNumRealBuilding(buildingBoyarWarID, 0)
			end
		end
	end
end

function JFD_BoyarNobilityWar(teamID, otherTeamID, isWar)
	for playerID = 0, GameDefines.MAX_MAJOR_CIVS - 1 do
		local player = Players[playerID]
		if player:IsEverAlive() and (player:GetTeam() == teamID or player:GetTeam() == otherTeamID) then
			for city in player:Cities() do
				local boyarIsHere = false
				local plot = city:Plot()
				for unitID = 0, plot:GetNumUnits() - 1, 1 do
					local unit = plot:GetUnit(unitID)
					if unit and unit:IsHasPromotion(unitPromotionBoyarID) then
						boyarIsHere = true
						break
					end
				end
				if boyarIsHere then
					if JFD_AtPeace(playerID) then
						city:SetNumRealBuilding(buildingBoyarPeaceID, 1)
						city:SetNumRealBuilding(buildingBoyarWarID, 0)
					else
						city:SetNumRealBuilding(buildingBoyarWarID, 1)
						city:SetNumRealBuilding(buildingBoyarPeaceID, 0)
					end
				else
					city:SetNumRealBuilding(buildingBoyarPeaceID, 0)
					city:SetNumRealBuilding(buildingBoyarWarID, 0)
				end
			end
		end
	end
end

function JFD_BoyarNobilityInitialTrigger(playerID, unitID)
	local player = Players[playerID]
	local unit = player:GetUnitByID(unitID)
	if unit and unit:IsHasPromotion(unitPromotionBoyarID) then
		GameEvents.PlayerDoTurn.Add(JFD_BoyarNobility)
		GameEvents.UnitSetXY.Add(JFD_BoyarNobility)
		Events.SerialEventUnitCreated.Add(JFD_BoyarNobility)
		Events.WarStateChanged.Add(JFD_BoyarNobilityWar)
		Events.SerialEventUnitCreated.Remove(JFD_BoyarNobilityInitialTrigger)
		save("GAME", "JFD_BoyarNobilityInitalised", true)
		JFD_BoyarNobility(playerID)
	end
end

if load("GAME", "JFD_BoyarNobilityInitalised") then
	GameEvents.PlayerDoTurn.Add(JFD_BoyarNobility)
	GameEvents.UnitSetXY.Add(JFD_BoyarNobility)
	Events.SerialEventUnitCreated.Add(JFD_BoyarNobility)
	Events.WarStateChanged.Add(JFD_BoyarNobilityWar)
else
	Events.SerialEventUnitCreated.Add(JFD_BoyarNobilityInitialTrigger)
end
--==========================================================================================================================
--==========================================================================================================================