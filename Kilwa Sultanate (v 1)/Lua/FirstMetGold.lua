-- FirstMetGold
-- Author: JFD
-- Heavily Edited By: F0S
--==========================================================================================================================
-- UTILITY FUNCTIONS
--==========================================================================================================================
WARN_NOT_SHARED = false; include( "Sukritact_SaveUtils.lua" ); MY_MOD_NAME = "FirstMetGold";
--------------------------------------------------------------
-- JFD_IsCivilisationActive
--------------------------------------------------------------
local civilisationID = GameInfoTypes["CIVILIZATION_KILWA"]

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
-- CORE KILWA FUNCTIONS
--==========================================================================================================================
--FirstMetGold
----------------------------------------------------------------------------------------------------------------------------
local techGuildsID = GameInfoTypes["TECH_GUILDS"]

function CalculateGoldBonus(teamID, firstMajorMet)
	local goldGift = 0
	if Teams[teamID]:IsHasTech(techGuildsID) then
		if firstMajorMet then
			goldGift = 120
		else
			goldGift = 60
		end
	else
		if firstMajorMet then
			goldGift = 60
		else
			goldGift = 30
		end
	end
	return goldGift
end

function FirstMetGold(playerMetID, playerID)
	local player = Players[playerID]
	local playerMet = Players[playerMetID]
	if player:IsEverAlive() and playerMet:IsEverAlive() then
		local playerTeamID = player:GetTeam()
		local playerMetTeamID = playerMet:GetTeam()
		if playerMet:IsMinorCiv() and player:GetCivilizationType() == civilisationID and not Teams[playerTeamID]:IsAtWar(playerMetTeamID) then
			local firstMajorMet = Teams[playerMetTeamID]:GetHasMetCivCount(true) == 1
			local goldGift = CalculateGoldBonus(playerTeamID, firstMajorMet)
			player:ChangeGold(goldGift)
		end
	end
end
----------------------------------------------------------------------------------------------------------------------------
--CoralPortFoodBonus
----------------------------------------------------------------------------------------------------------------------------
local buildingSwahiliCoralPortID = GameInfoTypes["BUILDING_SWAHILI_CORAL_PORT"]
local buildingSwahiliFoodID = GameInfoTypes["BUILDING_SWAHILI_FOOD"]

function IsHasFoodTradeRoute(playerID, city)
	local player = Players[playerID]
	local tradeRoutes = player:GetTradeRoutes()
	for i, v in ipairs(tradeRoutes) do
		local originatingCity = v.FromCity
		if city == originatingCity then
			if Players[v.ToCity:GetOwner()]:IsMinorCiv() then
				return true
			end
		end
	end
	return false
end

function CoralPortFoodBonus(playerID)
	local player = Players[playerID]
	if player:IsEverAlive() then
		for city in player:Cities() do
			if city then
				if city:IsHasBuilding(buildingSwahiliCoralPortID) then
					if IsHasFoodTradeRoute(playerID, city) then
						if not city:IsHasBuilding(buildingSwahiliFoodID) then city:SetNumRealBuilding(buildingSwahiliFoodID, 1) end
					else
						if city:IsHasBuilding(buildingSwahiliFoodID) then city:SetNumRealBuilding(buildingSwahiliFoodID, 0) end
					end
				else
					if city:IsHasBuilding(buildingSwahiliFoodID) then city:SetNumRealBuilding(buildingSwahiliFoodID, 0) end
				end
			end
		end
	end
end

function CoralPortFoodBonusDirty()
	local playerID = Game.GetActivePlayer()
    local player = Players[playerID]
	if player:IsTurnActive() then
        CoralPortFoodBonus(playerID)
    end
end

function CoralPortFoodBonusInitialTrigger(playerID, cityID, buildingID)
	local player = Players[playerID]
	local city = player:GetCityByID(cityID)
	if city and city:IsHasBuilding(buildingSwahiliCoralPortID) then
		GameEvents.PlayerDoTurn.Add(CoralPortFoodBonus)
		Events.SerialEventGameDataDirty.Add(CoralPortFoodBonusDirty)
		GameEvents.CityConstructed.Remove(CoralPortFoodBonusInitialTrigger)
		save("GAME", "CoralPortFoodBonusInitalised", true)
		CoralPortFoodBonus(playerID)
	end
end

if JFD_IsCivilisationActive(civilisationID) then
	GameEvents.TeamMeet.Add(FirstMetGold)
	if load("GAME", "CoralPortFoodBonusInitalised") then
		GameEvents.PlayerDoTurn.Add(CoralPortFoodBonus)
		Events.SerialEventGameDataDirty.Add(CoralPortFoodBonusDirty)
	else
		GameEvents.CityConstructed.Add(CoralPortFoodBonusInitialTrigger)
	end
end
--==========================================================================================================================
--==========================================================================================================================