-- JFD_Milan_Functions
-- Author: JFD
-- Heavily Edited By: F0S
--==========================================================================================================================
-- UTILITY FUNCTIONS
--==========================================================================================================================
-- JFD_AtPeace
--------------------------------------------------------------
WARN_NOT_SHARED = false; include( "Sukritact_SaveUtils.lua" ); MY_MOD_NAME = "JFD_Milan_Functions";

function JFD_AtPeace(playerID)
	local atPeace = false
	if Teams[Players[playerID]:GetTeam()]:GetAtWarCount(true) == 0 then atPeace = true end
	return atPeace
end
--------------------------------------------------------------
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
--==========================================================================================================================
-- CORE FUNCTIONS
--==========================================================================================================================
--Globals
----------------------------------------------------------------------------------------------------------------------------
local civilisationID = GameInfoTypes["CIVILIZATION_JFD_MILAN"]
local isMilanCivActive = JFD_IsCivilisationActive(civilisationID)
local buildingClassBigBenID = GameInfoTypes["BUILDINGCLASS_BIG_BEN"]
local policyMercantilismID = GameInfoTypes["POLICY_MERCANTILISM"]
local policySkyscrapersID = GameInfoTypes["POLICY_SKYSCRAPERS"]
local policyMobilizationID = GameInfoTypes["POLICY_MOBILIZATION"]
local policyMilanWarTimeInfluenceID = GameInfoTypes["POLICY_JFD_MILAN_WAR"]
local policyMilanPeaceTimeInfluenceID = GameInfoTypes["POLICY_JFD_MILAN_PEACE"]
local policyDefaultMilanUnitID = GameInfoTypes["POLICY_JFD_MILAN_UNIT_0"]
local policyDefaultMilanBuildingID = GameInfoTypes["POLICY_JFD_MILAN_BUILDING_0"]
local policiesMilanUnit = {
	[GameInfoTypes["POLICY_JFD_MILAN_UNIT_1"]] = 1,
	[GameInfoTypes["POLICY_JFD_MILAN_UNIT_2"]] = 2,
	[GameInfoTypes["POLICY_JFD_MILAN_UNIT_3"]] = 3,
	[GameInfoTypes["POLICY_JFD_MILAN_UNIT_4"]] = 4,
	[GameInfoTypes["POLICY_JFD_MILAN_UNIT_5"]] = 5,
	[GameInfoTypes["POLICY_JFD_MILAN_UNIT_6"]] = 6,
	[GameInfoTypes["POLICY_JFD_MILAN_UNIT_7"]] = 7,
	[GameInfoTypes["POLICY_JFD_MILAN_UNIT_8"]] = 8,
	[GameInfoTypes["POLICY_JFD_MILAN_UNIT_9"]] = 9,
	[GameInfoTypes["POLICY_JFD_MILAN_UNIT_10"]] = 10
}
local policiesMilanBuilding = {
	[GameInfoTypes["POLICY_JFD_MILAN_BUILDING_1"]] = 1,
	[GameInfoTypes["POLICY_JFD_MILAN_BUILDING_2"]] = 2,
	[GameInfoTypes["POLICY_JFD_MILAN_BUILDING_3"]] = 3,
	[GameInfoTypes["POLICY_JFD_MILAN_BUILDING_4"]] = 4,
	[GameInfoTypes["POLICY_JFD_MILAN_BUILDING_5"]] = 5,
	[GameInfoTypes["POLICY_JFD_MILAN_BUILDING_6"]] = 6,
	[GameInfoTypes["POLICY_JFD_MILAN_BUILDING_7"]] = 7,
	[GameInfoTypes["POLICY_JFD_MILAN_BUILDING_8"]] = 8,
	[GameInfoTypes["POLICY_JFD_MILAN_BUILDING_9"]] = 9,
	[GameInfoTypes["POLICY_JFD_MILAN_BUILDING_10"]] = 10
}
local buildingPalazzoID = GameInfoTypes["BUILDING_JFD_PALAZZO"]
local yieldGoldID = GameInfoTypes["YIELD_GOLD"]
----------------------------------------------------------------------------------------------------------------------------
-- JFD_InitMilan
----------------------------------------------------------------------------------------------------------------------------
function JFD_InitMilan()
	for playerID, player in pairs(Players) do
		local player = Players[playerID]
		if player:IsEverAlive() and player:GetCivilizationType() == civilisationID then
			if not player:HasPolicy(policyMilanPeaceTimeInfluenceID) then
				player:SetNumFreePolicies(player:GetNumFreePolicies() + 1)
				player:SetNumFreePolicies(player:GetNumFreePolicies() - 1)
				player:SetHasPolicy(policyMilanPeaceTimeInfluenceID, true)	
			end
			if not player:HasPolicy(policyDefaultMilanUnitID) then
				player:SetNumFreePolicies(player:GetNumFreePolicies() + 1)
				player:SetNumFreePolicies(player:GetNumFreePolicies() - 1)
				player:SetHasPolicy(policyDefaultMilanUnitID, true)	
			end
			if not player:HasPolicy(policyDefaultMilanBuildingID) then
				player:SetNumFreePolicies(player:GetNumFreePolicies() + 1)
				player:SetNumFreePolicies(player:GetNumFreePolicies() - 1)
				player:SetHasPolicy(policyDefaultMilanBuildingID, true)	
			end
		end
	end 
end
----------------------------------------------------------------------------------------------------------------------------
-- JFD_MilaneseInvestments
----------------------------------------------------------------------------------------------------------------------------
function JFD_MilaneseInvestments(playerID)
	local player = Players[playerID]
    if player:IsEverAlive() and player:GetCivilizationType() == civilisationID then 
		local player = Players[playerID]
		local costMod = 0
		for minorPlayerID = 0, GameDefines.MAX_CIV_PLAYERS - 1 do
			local minorCiv = Players[minorPlayerID]
			if minorCiv:IsMinorCiv() and minorCiv:GetCapitalCity() and minorCiv:IsEverAlive() then
				if minorCiv:GetMinorCivFriendshipLevelWithMajor(playerID) > 1 then
					costMod = costMod + 2
				elseif minorCiv:GetMinorCivFriendshipLevelWithMajor(playerID) > 0 then
					costMod = costMod + 1
				end
			end
		end
		if costMod > 10 then costMod = 10 end
		local unitCostMax = 15
		local buildingCostMax = 15
		if player:GetBuildingClassCount(buildingClassBigBenID) > 0 then
			unitCostMax = unitCostMax - 3
			buildingCostMax = buildingCostMax - 3
		end	
		if player:HasPolicy(policyMercantilismID) then
			unitCostMax = unitCostMax - 5
			buildingCostMax = buildingCostMax - 5
		end
		if player:HasPolicy(policyMobilizationID) then unitCostMax = unitCostMax - 7 end
		if player:HasPolicy(policySkyscrapersID) then buildingCostMax = buildingCostMax - 7 end
		local unitCostMod = math.min(costMod,unitCostMax)
		local buildingCostMod = math.min(costMod,buildingCostMax)
		if unitCostMod > 0 then
			local unitTable = {false, false, false, false, false, false, false, false, false, false}
			unitTable[unitCostMod] = true
			for policyMilanUnit, iRank in pairs(policiesMilanUnit) do
				if unitTable[iRank] then
					if not player:HasPolicy(policyMilanUnit) then
						player:SetHasPolicy(policyMilanUnit, true)
					end
				else
					if player:HasPolicy(policyMilanUnit) then
						player:SetHasPolicy(policyMilanUnit, false)
					end
				end
			end
		else
			for policyMilanUnit, iRank in pairs(policiesMilanUnit) do
				if player:HasPolicy(policyMilanUnit) and not player:HasPolicy(policyDefaultMilanUnitID) then
					player:SetHasPolicy(policyMilanUnit, false)
					player:SetHasPolicy(policyDefaultMilanUnitID, true)
				end
			end
		end
		if buildingCostMod > 0 then
			local buildingTable = {false, false, false, false, false, false, false, false, false, false}
			buildingTable[buildingCostMod] = true
			for policyMilanBuilding, iRank in pairs(policiesMilanBuilding) do
				if buildingTable[iRank] then
					if not player:HasPolicy(policyMilanBuilding) then
						player:SetHasPolicy(policyMilanBuilding, true)
					end
				else
					if player:HasPolicy(policyMilanBuilding) then
						player:SetHasPolicy(policyMilanBuilding, false)
					end
				end
			end
		else
			for policyMilanBuilding, iRank in pairs(policiesMilanBuilding) do
				if player:HasPolicy(policyMilanBuilding) and not player:HasPolicy(policyDefaultMilanBuildingID) then
					player:SetHasPolicy(policyMilanBuilding, false)
					player:SetHasPolicy(policyDefaultMilanBuildingID, true)
				end
			end
		end
	end
end

function JFD_MilaneseInvestmentsDirty()
	local playerID = Game.GetActivePlayer()
    local player = Players[playerID]
	if player:IsTurnActive() then
        JFD_MilaneseInvestments(playerID)
    end
end
----------------------------------------------------------------------------------------------------------------------------
-- JFD_MilanWarTimeInfluence
----------------------------------------------------------------------------------------------------------------------------
function JFD_MilanWarTimeInfluence(playerID)
	local player = Players[playerID]
    if player:IsEverAlive() and player:GetCivilizationType() == civilisationID then 
		if JFD_AtPeace(playerID) then
			if player:HasPolicy(policyMilanWarTimeInfluenceID) then
				player:SetHasPolicy(policyMilanWarTimeInfluenceID, false)
			end
			if not player:HasPolicy(policyMilanPeaceTimeInfluenceID) then
				player:SetHasPolicy(policyMilanPeaceTimeInfluenceID, true)
			end
		else
			if player:HasPolicy(policyMilanPeaceTimeInfluenceID) then
				player:SetHasPolicy(policyMilanPeaceTimeInfluenceID, false)
			end
			if not player:HasPolicy(policyMilanWarTimeInfluenceID) then
				player:SetHasPolicy(policyMilanWarTimeInfluenceID, true)
			end
		end
	end
end

function JFD_MilanWarTimeInfluenceWar(teamOne, teamTwo, war)
	for playerID = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do			
		player = Players[playerID]
		if player:GetTeam() == teamOne or player:GetTeam() == teamTwo then
			JFD_MilanWarTimeInfluence(playerID)
		end
	end	
end
----------------------------------------------------------------------------------------------------------------------------
-- JFD_PalazzoGoldtoMerchants
----------------------------------------------------------------------------------------------------------------------------
function JFD_PalazzoGoldtoMerchants(playerID)
	local player = Players[playerID]
    if player:IsEverAlive() then 
		for city in player:Cities() do
			if city:IsHasBuilding(buildingPalazzoID) then
				local merchantBoost = math.ceil(city:GetBaseYieldRate(yieldGoldID) / 10)
				city:SetNumRealBuilding(GameInfoTypes["BUILDING_JFD_MILAN_GMP"], merchantBoost)
			else
				city:SetNumRealBuilding(GameInfoTypes["BUILDING_JFD_MILAN_GMP"], 0)
			end	
		end
	end
end

function JFD_PalazzoGoldtoMerchantsDirty()
	local playerID = Game.GetActivePlayer()
    local player = Players[playerID]
	if player:IsTurnActive() then
        JFD_PalazzoGoldtoMerchants(playerID)
    end
end

function JFD_PalazzoGoldtoMerchantsInitialTrigger(playerID, cityID, buildingID)
	local player = Players[playerID]
	local city = player:GetCityByID(cityID)
	if city and city:IsHasBuilding(buildingPalazzoID) then
		GameEvents.PlayerDoTurn.Add(JFD_PalazzoGoldtoMerchants)
		Events.SerialEventGameDataDirty.Add(JFD_PalazzoGoldtoMerchantsDirty)
		GameEvents.CityConstructed.Remove(JFD_PalazzoGoldtoMerchantsInitialTrigger)
		save("GAME", "JFD_PalazzoGoldtoMerchantsInitalised", true)
		JFD_PalazzoGoldtoMerchants(playerID)
	end
end

if isMilanCivActive then
	Events.SequenceGameInitComplete.Add(JFD_InitMilan)
	GameEvents.PlayerDoTurn.Add(JFD_MilaneseInvestments)
	Events.SerialEventGameDataDirty.Add(JFD_MilaneseInvestmentsDirty)
	GameEvents.PlayerDoTurn.Add(JFD_MilanWarTimeInfluence)
	Events.WarStateChanged.Add(JFD_MilanWarTimeInfluenceWar)
	if load("GAME", "JFD_PalazzoGoldtoMerchantsInitalised") then
		GameEvents.PlayerDoTurn.Add(JFD_PalazzoGoldtoMerchants)
		Events.SerialEventGameDataDirty.Add(JFD_PalazzoGoldtoMerchantsDirty)
	else
		GameEvents.CityConstructed.Add(JFD_PalazzoGoldtoMerchantsInitialTrigger)
	end
end
--==========================================================================================================================
--==========================================================================================================================