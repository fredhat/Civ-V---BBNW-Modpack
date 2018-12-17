-- JFD_PolandPilsudski_Functions
-- Author: JFD
-- Edited By: F0S
--==========================================================================================================================
-- UTILITY FUNCTIONS
--==========================================================================================================================
-- JFD_IsCivilisationActive
------------------------------------------------------------------------------------------------------------------------
WARN_NOT_SHARED = false; include( "Sukritact_SaveUtils.lua" ); MY_MOD_NAME = "JFD_PolandPilsudski_Functions";

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
-- JFD_IsFightingStrongerFoe
------------------------------------------------------------------------------------------------------------------------
function JFD_IsFightingStrongerFoe(playerID)
	local player = Players[playerID]
	for otherPlayerID = 0, GameDefines.MAX_MAJOR_CIVS - 1 do
		local otherPlayer = Players[otherPlayerID]
		if player:GetMilitaryMight() < otherPlayer:GetMilitaryMight() then
			if Teams[player:GetTeam()]:IsAtWar(otherPlayer:GetTeam()) then
				return true
			end
		end
	end
	return false
end
--==========================================================================================================================
-- CORE FUNCTIONS
--==========================================================================================================================
-- Globals
--------------------------------------------------------------------------------------------------------------------------
local civilisationID = GameInfoTypes["CIVILIZATION_JFD_POLAND_PILSUDSKI"]
local isPolandPilsudskiCivActive = JFD_IsCivilisationActive(civilisationID)
-------------------------------------------------------------------------------------------------------------------------
--JFD_PilsudskiPoland
-------------------------------------------------------------------------------------------------------------------------
local policyPolandWorkersID = GameInfoTypes["POLICY_JFD_POLAND_WORKERS"]
local promotionPilsudskiID = GameInfoTypes["PROMOTION_JFD_PILSUDSKI"]

function InitPilsudskiPoland(player)
	for playerID, player in pairs(Players) do
		local player = Players[playerID]
		if player:IsEverAlive() and player:GetCivilizationType() == civilisationID then
			if not player:HasPolicy(policyPolandWorkersID) then
				player:SetNumFreePolicies(player:GetNumFreePolicies() + 1)
				player:SetNumFreePolicies(player:GetNumFreePolicies() - 1)
				player:SetHasPolicy(policyPolandWorkersID, true)	
			end
		end
	end 
end

function JFD_PilsudskiPoland(playerID)
	local player = Players[playerID]
	if player:IsEverAlive() and player:GetCivilizationType() == civilisationID then
		if JFD_IsFightingStrongerFoe(playerID) then
			for unit in player:Units() do
				if unit and unit:GetCombatLimit() > 0 and not unit:IsHasPromotion(promotionPilsudskiID) then
					unit:SetHasPromotion(promotionPilsudskiID, true)
				end
			end
		else
			for unit in player:Units() do
				if unit and unit:IsHasPromotion(promotionPilsudskiID) then
					unit:SetHasPromotion(promotionPilsudskiID, false)
				end
			end
		end
	end
end

function JFD_PilsudskiPolandDirty()
	local playerID = Game.GetActivePlayer()
    local player = Players[playerID]
	if player:IsTurnActive() then
        JFD_PilsudskiPoland(playerID)
    end
end

if isPolandPilsudskiCivActive then
	Events.SequenceGameInitComplete.Add(InitPilsudskiPoland)
	GameEvents.PlayerDoTurn.Add(JFD_PilsudskiPoland)
	Events.SerialEventGameDataDirty.Add(JFD_PilsudskiPolandDirty)
end
----------------------------------------------------------------------------------------------------------------------------
-- JFD_UhlanStrengthUpgrade
----------------------------------------------------------------------------------------------------------------------------
local techCombustionID = GameInfoTypes["TECH_COMBUSTION"]
local promotionUhlanCombustionID = GameInfoTypes["PROMOTION_JFD_UHLAN_COMBUSTION"]

function JFD_UhlanUpgrade(unit, team)
	if unit and unit:IsHasPromotion(promotionUhlanCombustionID) and team:IsHasTech(techCombustionID) then
		unit:SetBaseCombatStrength(56)
		unit:SetHasPromotion(promotionUhlanCombustionID, false)
	end
end

function JFD_UhlanStrengthUpgradeTurn(playerID)
	local player = Players[playerID]
	local teamID = player:GetTeam()
	local team = Teams[teamID]
	if player:IsEverAlive() then
		for unit in player:Units() do
			JFD_UhlanUpgrade(unit, team)
		end
	end
end

function JFD_UhlanStrengthUpgradeTech(teamID, techID)
	if techID == techCombustionID then
		for playerID = 0, GameDefines.MAX_MAJOR_CIVS - 1 do
			local player = Players[playerID]			
			if player:IsEverAlive() and player:GetTeam() == teamID then
				for unit in player:Units() do
					JFD_UhlanUpgrade(unit, Teams[teamID])
				end
			end
		end
	end
end

function JFD_UhlanStrengthUpgradeCreated(playerID, unitID)
	local player = Players[playerID]
	local teamID = player:GetTeam()
	local team = Teams[teamID]
	if player:IsEverAlive() then
		local unit = player:GetUnitByID(unitID)
		JFD_UhlanUpgrade(unit, team)
	end
end
----------------------------------------------------------------------------------------------------------------------------
-- JFD_UhlanPreKillFunction
----------------------------------------------------------------------------------------------------------------------------
local promotionUhlanID = GameInfoTypes["PROMOTION_JFD_UHLAN"]
local storedPlayerID = -1

function JFD_UhlanPreKillFunction(unitOwnerID, unitID, unitType, unitX, unitY, isDelay, killingPlayerID)
	if isDelay then
		storedPlayerID = -1
		local unit = Players[unitOwnerID]:GetUnitByID(unitID)
		if unit and unit:GetCombatLimit() > 0 then
			storedPlayerID = killingPlayerID	
		end
	elseif storedPlayerID ~= -1 then
		for unit in Players[storedPlayerID]:Units() do
			if unit and unit:IsHasPromotion(promotionUhlanID) then
				local plot = Map.GetPlot(unitX, unitY)
				if plot and unit:GetPlot() == plot then
					JFD_UhlanKillFunction(unit)
					return		
				end
			end
		end
	end
end

function JFD_UhlanKillFunction(unit)
	unit:ChangeMoves(60)
	unit:SetMadeAttack(false)
	local teamID = Players[unit:GetOwner()]:GetTeam()
	for i = 0, 5 do
		local plot = Map.PlotDirection(unit:GetX(), unit:GetY(), i)
		if plot and not plot:IsCity() then
			for j = 0, plot:GetNumUnits() - 1 do
				local plotUnit = plot:GetUnit(j)
				if plotUnit and plotUnit:GetCombatLimit() > 0 and plotUnit:GetDomainType() == DomainTypes.DOMAIN_LAND then
					if Teams[teamID]:IsAtWar(Players[plotUnit:GetOwner()]:GetTeam()) then
						plotUnit:ChangeDamage(math.min(10, math.max(0, 100 - plotUnit:GetDamage())), unit:GetOwner())
					end
				end
			end
		end
	end
end

function JFD_UhlanStrengthUpgradeInitialTrigger(playerID, unitID)
	local player = Players[playerID]
	local unit = player:GetUnitByID(unitID)
	if unit and unit:IsHasPromotion(promotionUhlanID) then
		GameEvents.PlayerDoTurn.Add(JFD_UhlanStrengthUpgradeTurn)
		GameEvents.TeamTechResearched.Add(JFD_UhlanStrengthUpgradeTech)
		Events.SerialEventUnitCreated.Add(JFD_UhlanStrengthUpgradeCreated)
		GameEvents.UnitPrekill.Add(JFD_UhlanPreKillFunction)
		Events.SerialEventUnitCreated.Remove(JFD_UhlanStrengthUpgradeInitialTrigger)
		save("GAME", "JFD_UhlanStrengthUpgradeInitalised", true)
		JFD_UhlanStrengthUpgradeCreated(playerID, unitID)
	end
end

if load("GAME", "JFD_UhlanStrengthUpgradeInitalised") then
	GameEvents.PlayerDoTurn.Add(JFD_UhlanStrengthUpgradeTurn)
	GameEvents.TeamTechResearched.Add(JFD_UhlanStrengthUpgradeTech)
	Events.SerialEventUnitCreated.Add(JFD_UhlanStrengthUpgradeCreated)
	GameEvents.UnitPrekill.Add(JFD_UhlanPreKillFunction)
else
	Events.SerialEventUnitCreated.Add(JFD_UhlanStrengthUpgradeInitialTrigger)
end