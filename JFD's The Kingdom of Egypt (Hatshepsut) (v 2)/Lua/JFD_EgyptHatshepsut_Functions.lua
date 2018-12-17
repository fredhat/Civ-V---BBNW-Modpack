-- JFD_EgyptHatshepsut_Functions
-- Author: JFD
-- Edited By: F0S
--==========================================================================================================================
-- INCLUDES
--==========================================================================================================================
WARN_NOT_SHARED = false; include( "Sukritact_SaveUtils.lua" ); MY_MOD_NAME = "JFD_EgyptHatshepsut_Functions";
--==========================================================================================================================
-- UTILITY FUNCTIONS
--==========================================================================================================================
-- GLOBALS
----------------------------------------------------------------------------------------------------------------------------
local civilisationID = GameInfoTypes["CIVILIZATION_JFD_EGYPT_HATSHEPSUT"]

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
-- UNIQUE FUNCTIONS
--==========================================================================================================================
-- EXPEDITION TO TA NETJER
----------------------------------------------------------------------------------------------------------------------------
local unitMerchantBargeID = GameInfoTypes["UNIT_JFD_MERCHANT_BARGE"]

function JFD_EgyptHatshepsut_ExpeditionToTaNetjer_TeamMeet(playerMetID, playerID)
	local player = Players[playerID]
	local playerMet = Players[playerMetID]
	local goldPercent = GameInfo.GameSpeeds[Game.GetGameSpeedType()].GoldPercent
	local title = "Expedition to Ta Netjer"
	if playerMet:IsEverAlive() and playerMet:GetCivilizationType() == civilisationID and not player:IsMinorCiv() then
		local teamID = playerMet:GetTeam()
		local rewardGold = goldPercent * (playerMet:GetCurrentEra() + 1)
		for city in player:Cities() do
			if city:IsCoastal() then
				local cityPlot = Map.GetPlot(city:GetX(), city:GetY())
				cityPlot:ChangeVisibilityCount(teamID, 1)
				cityPlot:SetRevealed(teamID, true)
				cityPlot:UpdateFog()
			end
		end
		playerMet:ChangeGold(rewardGold)
		if playerMet:IsHuman() and playerMet:IsTurnActive() then
			local descr = Locale.ConvertTextKey("TXT_KEY_TRAIT_JFD_EGYPT_HATSHEPSUT_MSG", rewardGold, player:GetName())
			playerMet:AddNotification(NotificationTypes.NOTIFICATION_GENERIC, descr, title, -1, -1)
        end
	elseif player:IsEverAlive() and player:GetCivilizationType() == civilisationID and not playerMet:IsMinorCiv() then
		local teamID = player:GetTeam()
		local rewardGold = goldPercent * (player:GetCurrentEra() + 1)
		for city in playerMet:Cities() do
			if city:IsCoastal() then
				local cityPlot = Map.GetPlot(city:GetX(), city:GetY())
				cityPlot:ChangeVisibilityCount(teamID, 1)
				cityPlot:SetRevealed(teamID, true)
				cityPlot:UpdateFog()
			end
		end
		player:ChangeGold(rewardGold)
		if player:IsHuman() and player:IsTurnActive() then
			local descr = Locale.ConvertTextKey("TXT_KEY_TRAIT_JFD_EGYPT_HATSHEPSUT_MSG", rewardGold, playerMet:GetName())
			player:AddNotification(NotificationTypes.NOTIFICATION_GENERIC, descr, title, -1, -1)
        end
	end
end

function JFD_EgyptHatshepsut_ExpeditionToTaNetjer_TeamTechResearched(teamID, techID)
	local playerID = Teams[teamID]:GetLeaderID()
	local player = Players[playerID]
	if player:IsEverAlive() and player:GetCivilizationType() == civilisationID then
		local techTradeRouteChange = GameInfo.Technologies[techID].InternationalTradeRoutesChange 
		if techTradeRouteChange > 0 then
			local capital = player:GetCapitalCity()
			if capital then
				player:InitUnit(unitMerchantBargeID, capital:GetX(), capital:GetY(), UNITAI_TRADE_UNIT)
			end
		end
	end
end

function JFD_EgyptHatshepsut_ExpeditionToTaNetjer_InitOnSettle(playerID, plotX, plotY)
	local player = Players[playerID]
	local playerTeam = Teams[player:GetTeam()]
	local plot = Map.GetPlot(plotX, plotY)
	local city = plot:GetPlotCity()
	if player:IsEverAlive() and player:GetCivilizationType() == civilisationID then
		if city and city:IsCapital() then
			for tech in GameInfo.Technologies("InternationalTradeRoutesChange > 0") do
				if playerTeam:IsHasTech(tech.ID) then
					player:InitUnit(unitMerchantBargeID, city:GetX(), city:GetY(), UNITAI_TRADE_UNIT)
				end
			end
		end
	end
end
----------------------------------------------------------------------------------------------------------------------------
-- BURIAL TOMB
----------------------------------------------------------------------------------------------------------------------------
local buildingBurialTombID = GameInfoTypes["BUILDING_BURIAL_TOMB"]
local buildingBurialTombHappyID = GameInfoTypes["BUILDING_JFD_BURIAL_TOMB_HAPPINESS"]

function JFD_EgyptHatshepsut_BurialTomb(playerID)
	local player = Players[playerID]
	if player:IsEverAlive() then
	     for city in player:Cities() do
			if city:GetWeLoveTheKingDayCounter() > 0 and city:IsHasBuilding(buildingBurialTombID) then
				if not city:IsHasBuilding(buildingBurialTombHappyID) then
					city:SetNumRealBuilding(buildingBurialTombHappyID, 1)
				end
			else
				if city:IsHasBuilding(buildingBurialTombHappyID) then
					city:SetNumRealBuilding(buildingBurialTombHappyID, 0)
				end
			end
		end
	end
end

function JFD_EgyptHatshepsut_BurialTombDirty()
	local iPlayer = Game.GetActivePlayer()
    local pPlayer = Players[iPlayer]
	if pPlayer:IsTurnActive() then
        JFD_EgyptHatshepsut_BurialTomb(iPlayer)
    end
end

function JFD_EgyptHatshepsut_BurialTombInitialTrigger(playerID, cityID, buildingID)
	local player = Players[playerID]
	local city = player:GetCityByID(cityID)
	if city and city:IsHasBuilding(buildingBurialTombID) then
		GameEvents.PlayerDoTurn.Add(JFD_EgyptHatshepsut_BurialTomb)
		Events.SerialEventGameDataDirty.Add(JFD_EgyptHatshepsut_BurialTombDirty)
		GameEvents.CityConstructed.Remove(JFD_EgyptHatshepsut_BurialTombInitialTrigger)
		save("GAME", "JFD_EgyptHatshepsut_BurialTombInitalised", true)
		JFD_EgyptHatshepsut_BurialTomb(playerID)
	end
end
----------------------------------------------------------------------------------------------------------------------------
-- MERCHANT BARGE
----------------------------------------------------------------------------------------------------------------------------
function JFD_EgyptHatshepsut_MerchantBarge(playerID, unitID, unitTypeID)
	local player = Players[playerID]
	if player:IsEverAlive() and player:GetCivilizationType() == civilisationID then
		local tradeRoutes = player:GetTradeRoutes()
		for _, tradeRoute in ipairs(tradeRoutes) do
			local tradeRouteDomain = tradeRoute.Domain
			if tradeRouteDomain == GameInfoTypes["DOMAIN_SEA"] then
				local fromCity = tradeRoute.FromCity
				local toCity = tradeRoute.ToCity
				if toCity:IsCapital() and toCity:GetOwner() ~= playerID then
					if fromCity:GetWeLoveTheKingDayCounter() == 0 then
						fromCity:ChangeWeLoveTheKingDayCounter(2)
					elseif fromCity:GetWeLoveTheKingDayCounter() == 1 then
						fromCity:ChangeWeLoveTheKingDayCounter(1)
					end
					if toCity:GetWeLoveTheKingDayCounter() == 0 then
						toCity:ChangeWeLoveTheKingDayCounter(2)
					elseif toCity:GetWeLoveTheKingDayCounter() == 1 then
						toCity:ChangeWeLoveTheKingDayCounter(1)
					end
				end
			end
		end
	end
end

if JFD_IsCivilisationActive(civilisationID) then
	GameEvents.TeamMeet.Add(JFD_EgyptHatshepsut_ExpeditionToTaNetjer_TeamMeet)
	GameEvents.TeamTechResearched.Add(JFD_EgyptHatshepsut_ExpeditionToTaNetjer_TeamTechResearched)
	GameEvents.PlayerCityFounded.Add(JFD_EgyptHatshepsut_ExpeditionToTaNetjer_InitOnSettle)
	if load("GAME", "JFD_EgyptHatshepsut_BurialTombInitalised") then
		GameEvents.PlayerDoTurn.Add(JFD_EgyptHatshepsut_BurialTomb)
		Events.SerialEventGameDataDirty.Add(JFD_EgyptHatshepsut_BurialTombDirty)
	else
		GameEvents.CityConstructed.Add(JFD_EgyptHatshepsut_BurialTombInitialTrigger)
	end
	GameEvents.PlayerDoTurn.Add(JFD_EgyptHatshepsut_MerchantBarge)
end
--==========================================================================================================================
--==========================================================================================================================