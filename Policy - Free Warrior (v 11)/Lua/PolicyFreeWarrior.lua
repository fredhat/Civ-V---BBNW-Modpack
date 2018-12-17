-- PolicyFreeWarrior
-- Author: William Howard
-- Edited By: F0S
--------------------------------------------------------------
-- Utility Functions
--------------------------------------------------------------
local tEraUnits = {}
tEraUnits.ERA_ANCIENT = "UNITCLASS_WARRIOR"
tEraUnits.ERA_CLASSICAL = "UNITCLASS_SPEARMAN"
tEraUnits.ERA_MEDIEVAL = "UNITCLASS_PIKEMAN"
tEraUnits.ERA_RENAISSANCE = "UNITCLASS_MUSKETMAN"
tEraUnits.ERA_INDUSTRIAL = "UNITCLASS_RIFLEMAN"
tEraUnits.ERA_MODERN = "UNITCLASS_GREAT_WAR_INFANTRY"
tEraUnits.ERA_POSTMODERN = "UNITCLASS_INFANTRY"
tEraUnits.ERA_FUTURE = "UNITCLASS_MECHANIZED_INFANTRY"

function GetCivSpecificUnit(pPlayer, sUnitClass)
	local sUnitType = nil
	local sCivType = GameInfo.Civilizations[pPlayer:GetCivilizationType()].Type
	for pOverride in GameInfo.Civilization_UnitClassOverrides{CivilizationType = sCivType, UnitClassType = sUnitClass} do
		sUnitType = pOverride.UnitType
		break
	end
	if sUnitType == nil then
		sUnitType = GameInfo.UnitClasses[sUnitClass].DefaultUnit
	end
	return sUnitType
end
--------------------------------------------------------------
-- PolicyFreeWarrior
--------------------------------------------------------------
local iPolicyBranchHonor = GameInfo.PolicyBranchTypes["POLICY_BRANCH_HONOR"].ID
local iBuildingHeroicEpic = GameInfo.Buildings["BUILDING_HEROIC_EPIC"].ID
local iPromotionMorale = GameInfo.UnitPromotions["PROMOTION_MORALE"].ID

function PolicyFreeWarrior(iPlayerId, iPolicyBranchTypeId) 
	local pPlayer = Players[iPlayerId]
	if pPlayer:IsEverAlive() and iPolicyBranchTypeId == iPolicyBranchHonor then
		local pCity = pPlayer:GetCapitalCity()
		local pPlot = pCity and pCity:Plot() or pPlayer:GetStartingPlot()
		if pPlot then
			local sUnitClass = tEraUnits[GameInfo.Eras[pPlayer:GetCurrentEra()].Type]
			local sUnitType = GetCivSpecificUnit(pPlayer, sUnitClass)
			local sAIType = GameInfo.Units[sUnitType].DefaultUnitAI
			local pUnit = pPlayer:InitUnit(GameInfoTypes[sUnitType], pPlot:GetX(), pPlot:GetY(), GameInfoTypes[sAIType])
			pUnit:JumpToNearestValidPlot()
			if pCity then
				pUnit:SetExperience(pCity:GetProductionExperience(pUnit:GetUnitType()))
				if pCity:IsHasBuilding(iBuildingHeroicEpic) then
					pUnit:SetHasPromotion(iPromotionMorale, true)
				end
			end
		end
	end
end

GameEvents.PlayerAdoptPolicyBranch.Add(PolicyFreeWarrior)
--------------------------------------------------------------