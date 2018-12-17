-- JFD_ByzantiumTheodora_Functions
-- Author: JFD
-- Edited By: F0S
--==========================================================================================================================
-- UTILITY FUNCTIONS
--==========================================================================================================================
-- GLOBALS
----------------------------------------------------------------------------------------------------------------------------
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
-- GLOBALS
----------------------------------------------------------------------------------------------------------------------------
local civilisationID = GameInfoTypes["CIVILIZATION_BYZANTIUM"]
--------------------------------------------------------------------------------------------------------------------------
-- Byzantium Piety
--------------------------------------------------------------------------------------------------------------------------
--JFD_InitByzantium
local policyBranchPietyID = GameInfoTypes["POLICY_BRANCH_PIETY"]
local policyPietyID = GameInfoTypes["POLICY_PIETY"]

function JFD_InitByzantium()
	for playerID, player in pairs(Players) do
		local player = Players[playerID]
		if player and player:IsEverAlive() and player:GetCivilizationType() == civilisationID then
			if not player:IsPolicyBranchUnlocked(policyBranchPietyID) then
				player:SetNumFreePolicies(player:GetNumFreePolicies() + 1)
				player:SetNumFreePolicies(player:GetNumFreePolicies() - 1)
				player:SetPolicyBranchUnlocked(policyBranchPietyID, 1)
				player:SetHasPolicy(policyPietyID, 1)
			end
		end
	end 
end
--------------------------------------------------------------------------------------------------------------------------
-- STOUDION
--------------------------------------------------------------------------------------------------------------------------
--JFD_Byzantium_Stoudion_CityTrained
local buildingStoudionID = GameInfoTypes["BUILDING_JFD_STOUDION"]
local unitPromotionStoudionID = GameInfoTypes["PROMOTION_JFD_STOUDION"]
local unitPromotionSightPenaltyID = GameInfoTypes["PROMOTION_SIGHT_PENALTY"]
local unitMissionaryID = GameInfoTypes["UNIT_MISSIONARY"]

function JFD_Byzantium_Stoudion_CityTrained(playerID, cityID, unitID)
	local player = Players[playerID]
	if player:IsEverAlive() then
		local city = player:GetCityByID(cityID)
		if city and city:IsHasBuilding(buildingStoudionID) then
			local unit = player:GetUnitByID(unitID)
			if unit and unit:GetUnitType() == unitMissionaryID then
				unit:SetHasPromotion(unitPromotionStoudionID, true)
				unit:SetHasPromotion(unitPromotionSightPenaltyID, false)
			end
		end
	end
end

if JFD_IsCivilisationActive(civilisationID) then
	Events.SequenceGameInitComplete.Add(JFD_InitByzantium)
	GameEvents.CityTrained.Add(JFD_Byzantium_Stoudion_CityTrained)
end
--==========================================================================================================================
--==========================================================================================================================