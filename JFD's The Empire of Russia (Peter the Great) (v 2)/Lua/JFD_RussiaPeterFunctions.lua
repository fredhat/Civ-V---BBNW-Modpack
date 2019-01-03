-- Petrine Russia Functions
-- Author: JFD
-- Heavily Edited By: F0S
--=======================================================================================================================
-- UTILITY FUNCTIONS
--==========================================================================================================================
WARN_NOT_SHARED = false; include( "Sukritact_SaveUtils.lua" ); MY_MOD_NAME = "JFD_RussiaPeterFunctions";
local civilisationID = GameInfoTypes["CIVILIZATION_JFD_PETRINE_RUSSIA"]
--------------------------------------------------------------------------------------------------------------------------
-- JFD_IsCivilisationActive
--------------------------------------------------------------------------------------------------------------------------
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
--------------------------------------------------------------------------------------------------------------------------
-- F0S_GetPeter
--------------------------------------------------------------------------------------------------------------------------
function F0S_GetPeter()
	if load("GAME", "JFD_PlayerPeterID") == nil then	
		for playerID = 0, GameDefines.MAX_MAJOR_CIVS - 1 do
			local player = Players[playerID]			
			if player ~= nil and player:GetCivilizationType() == civilisationID then
				save("GAME", "JFD_PlayerPeterID", playerID)
				break
			end
		end
	end
end
--------------------------------------------------------------------------------------------------------------------------
-- JFD_GetNumDoFsWithPlayer
--------------------------------------------------------------------------------------------------------------------------
function JFD_GetNumDoFsWithPlayer(playerID)
	local player = Players[playerID]
	local numDoFs = 0
	for otherPlayerID = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
		if otherPlayerID ~= playerID then
			local otherPlayer = Players[otherPlayerID]
			if otherPlayer:IsEverAlive() and otherPlayer:IsDoF(playerID) then
				numDoFs = numDoFs + 1
			end
		end
	end
	return numDoFs
end
--------------------------------------------------------------------------------------------------------------------------
-- JFD_GetRandom
--------------------------------------------------------------------------------------------------------------------------
function JFD_GetRandom(lower, upper)
    return Game.Rand((upper + 1) - lower, "") + lower
end
--==========================================================================================================================
-- CORE FUNCTIONS
--==========================================================================================================================
--InitPeter
----------------------------------------------------------------------------------------------------------------------------
local policyPetrineRussiaID = GameInfoTypes["POLICY_JFD_PETRINE_RUSSIA"]

function InitPeter()
	for playerID = 0, GameDefines.MAX_MAJOR_CIVS - 1 do
		local player = Players[playerID]
		if player:IsEverAlive() and player:GetCivilizationType() == civilisationID then
			if not player:HasPolicy(GameInfoTypes["POLICY_JFD_PETRINE_RUSSIA"]) then
				player:SetNumFreePolicies(player:GetNumFreePolicies() + 1)
				player:SetNumFreePolicies(player:GetNumFreePolicies() - 1)
				player:SetHasPolicy(GameInfoTypes["POLICY_JFD_PETRINE_RUSSIA"], true)	
			end
		end
	end 
end
----------------------------------------------------------------------------------------------------------------------------
-- F0S_ScientificDiffusion
----------------------------------------------------------------------------------------------------------------------------	
-- For Reference:
-- Tech Level 0 = This is the first player to research this tech
-- Tech Level 1 = This is tech was research by a non-friend
-- Tech Level 2 = This is tech was researched by a friend
function F0S_ScientificDiffusion(teamID, techID, change)
	local playerPeterID = load("GAME", "JFD_PlayerPeterID")
	if playerPeterID ~= nil then
		local playerPeter = Players[playerPeterID]
		local teamPeterID = playerPeter:GetTeam()
		local teamPeter = Teams[teamPeterID]
		if playerPeter:IsEverAlive() and teamPeterID ~= teamID then
			local teamTechsPeter = teamPeter:GetTeamTechs()
			local techLeft = teamTechsPeter:GetResearchLeft(techID)
			if not teamTechsPeter:HasTech(techID) and techLeft > 0 then
				local techLevel = load("GAME", techID) or 0
				if techLevel < 2 then
					local techMultiplier = 1 - techLevel
					for playerID = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
						local player = Players[playerID]
						if player:IsDoF(playerPeterID) and player:GetTeam() == teamID then
							techMultiplier = techMultiplier + 1
							break
						end
					end
					if techMultiplier > 0 then
						local techCost = teamTechsPeter:GetResearchCost(techID)
						local techReduction = math.min(techLeft, math.floor(.25 * techMultiplier * techCost))
						teamTechsPeter:ChangeResearchProgress(techID, techReduction, playerPeterID)
						save("GAME", techID, (techMultiplier + techLevel))
					end
				end
			end
		end
	end
end

----------------------------------------------------------------------------------------------------------------------------
-- JFD_TwoDeckerTrained
----------------------------------------------------------------------------------------------------------------------------	
local promotionSecondHandInfoID = GameInfoTypes["PROMOTION_JFD_SECOND_HAND_INFO"]

function JFD_TwoDeckerTrained(playerID, cityID, unitID)
	local player = Players[playerID]
	if player:IsEverAlive() and player:GetCivilizationType() == civilisationID then
		local unit = player:GetUnitByID(unitID)
		if unit and unit:IsHasPromotion(promotionSecondHandInfoID) then
			local numXPToGive = JFD_GetNumDoFsWithPlayer(playerID) * 10
			unit:ChangeExperience(numXPToGive)
		end
	end
end
----------------------------------------------------------------------------------------------------------------------------
-- JFD_KrepostExpansion
----------------------------------------------------------------------------------------------------------------------------	
local buildingKrepostID = GameInfoTypes["BUILDING_KREPOST"]
local buildingPetrineExpansionID = GameInfoTypes["BUILDING_JFD_PETRINE_EXPANSION"]

function JFD_KrepostExpansion(playerID)
	local player = Players[playerID]
	if player:IsEverAlive() then
		for city in player:Cities() do
			if city:IsHasBuilding(buildingKrepostID) then
				local unit = city:GetGarrisonedUnit()
				if unit and unit:GetCombatLimit() > 0 and unit:GetDomainType() == DomainTypes.DOMAIN_LAND then
					city:SetNumRealBuilding(buildingPetrineExpansionID, 1)
				else
					city:SetNumRealBuilding(buildingPetrineExpansionID, 0)
				end
			else
				city:SetNumRealBuilding(buildingPetrineExpansionID, 0)
			end
		end
	end
end

function JFD_KrepostExpansionInitialTrigger(playerID, cityID, buildingID)
	local player = Players[playerID]
	local city = player:GetCityByID(cityID)
	if city and city:IsHasBuilding(buildingKrepostID) then
		GameEvents.PlayerDoTurn.Add(JFD_KrepostExpansion)
		GameEvents.UnitSetXY.Add(JFD_KrepostExpansion)
		GameEvents.CityConstructed.Add(JFD_KrepostExpansion)
		Events.SerialEventUnitCreated.Add(JFD_KrepostExpansion)
		GameEvents.CityConstructed.Remove(JFD_KrepostExpansionInitialTrigger)
		save("GAME", "JFD_KrepostExpansionInitalised", true)
		JFD_KrepostExpansion(playerID)
	end
end

if JFD_IsCivilisationActive(civilisationID) then
	F0S_GetPeter()
	Events.SequenceGameInitComplete.Add(InitPeter)
	GameEvents.TeamTechResearched.Add(F0S_ScientificDiffusion)
	GameEvents.CityTrained.Add(JFD_TwoDeckerTrained)
	if load("GAME", "JFD_KrepostExpansionInitalised") then
		GameEvents.PlayerDoTurn.Add(JFD_KrepostExpansion)
		GameEvents.UnitSetXY.Add(JFD_KrepostExpansion)
		GameEvents.CityConstructed.Add(JFD_KrepostExpansion)
		Events.SerialEventUnitCreated.Add(JFD_KrepostExpansion)
	else
		GameEvents.CityConstructed.Add(JFD_KrepostExpansionInitialTrigger)
	end
end	
------------------------------------------------------------------------------------
-- JFD_BanyaHealing
------------------------------------------------------------------------------------
local civilisationCatherineID = GameInfoTypes["CIVILIZATION_RUSSIA"]
local promotionBanyaID = GameInfoTypes["PROMOTION_JFD_BANYA"]
local buildingBanyaID = GameInfoTypes["BUILDING_JFD_BANYA"]

function JFD_BanyaHealing(playerID, unitID)
	local player = Players[playerID]
	if player:IsEverAlive() then
		local unit = player:GetUnitByID(unitID)
		if unit and load(unit, "BanyaUnits") == nil and not unit:IsHasPromotion(promotionBanyaID) and unit:GetCombatLimit() > 0 and unit:GetDomainType() == DomainTypes.DOMAIN_LAND then
			local city = Map.GetPlot(unit:GetX(), unit:GetY()):GetPlotCity()
			if city and city:IsHasBuilding(buildingBanyaID) then
				unit:SetHasPromotion(promotionBanyaID, true)
			end
		end
		save(unit, "BanyaUnits", true)
	end
end

function JFD_BanyaHealingInitialTrigger(playerID, cityID, buildingID)
	local player = Players[playerID]
	local city = player:GetCityByID(cityID)
	if city and city:IsHasBuilding(buildingBanyaID) then
		Events.SerialEventUnitCreated.Add(JFD_BanyaHealing)
		GameEvents.CityConstructed.Remove(JFD_BanyaHealingInitialTrigger)
		save("GAME", "JFD_BanyaHealingInitalised", true)
	end
end

if JFD_IsCivilisationActive(civilisationCatherineID) then
	if load("GAME", "JFD_BanyaHealingInitalised") then
		Events.SerialEventUnitCreated.Add(JFD_BanyaHealing)
	else
		GameEvents.CityConstructed.Add(JFD_BanyaHealingInitialTrigger)
	end
end
--==========================================================================================================================
--==========================================================================================================================