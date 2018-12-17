-- NazcaUA
-- Author: Sukritact
-- Heavily Edited By: F0S
--------------------------------------------------------------
WARN_NOT_SHARED = false; include( "Sukritact_SaveUtils.lua" ); MY_MOD_NAME = "Nazca";
--------------------------------------------------------------
local civilizationID = GameInfoTypes["CIVILIZATION_NAZCA"]
--------------------------------------------------------------
-- Utility Functions
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

function GetRandom(lower, upper)
    return (Game.Rand((upper + 1) - lower, "")) + lower
end
--------------------------------------------------------------
-- NazcaUAPart1
--------------------------------------------------------------
local iGeoglyphs = GameInfo.Improvements["IMPROVEMENT_GEOGLYPHS"].ID
local iBuildingNazcaDummy = GameInfo.Buildings["BUILDING_NAZCA_DUMMY"].ID

function NazcaUAPart1SetDummy(pPlayer, iNumGeoglyphs)
	local capitalCity = pPlayer:GetCapitalCity()
	if capitalCity and capitalCity:GetNumBuilding(iBuildingNazcaDummy) ~= iNumGeoglyphs then
		capitalCity:SetNumRealBuilding(iBuildingNazcaDummy, iNumGeoglyphs)
	end
end

function NazcaUAPart1Turn(iPlayer)
    local pPlayer = Players[iPlayer]
    if pPlayer:IsEverAlive() and pPlayer:GetCivilizationType() == civilizationID then
		local iNumGeoglyphs = pPlayer:GetImprovementCount(iGeoglyphs)
		NazcaUAPart1SetDummy(pPlayer, iNumGeoglyphs)
		pPlayer:ChangeGoldenAgeProgressMeter(iNumGeoglyphs)
    end
end

function NazcaUAPart1Founded(iPlayer)
    local pPlayer = Players[iPlayer]
    if pPlayer:IsEverAlive() and pPlayer:GetCivilizationType() == civilizationID then
        local iNumGeoglyphs = pPlayer:GetImprovementCount(iGeoglyphs)
		NazcaUAPart1SetDummy(pPlayer, iNumGeoglyphs)
    end
end

function NazcaUAPart1Capture(oldOwnerID, capital, plotX, plotY, newOwnerID)
    local oPlayer = Players[oldOwnerID]
	local pPlayer = Players[newOwnerID]
    if oPlayer:IsEverAlive() and oPlayer:GetCivilizationType() == civilizationID then
        local iNumGeoglyphs = oPlayer:GetImprovementCount(iGeoglyphs)
		NazcaUAPart1SetDummy(oPlayer, iNumGeoglyphs)
    end
    if pPlayer:IsEverAlive() and pPlayer:GetCivilizationType() == civilizationID then
        local iNumGeoglyphs = pPlayer:GetImprovementCount(iGeoglyphs)
		NazcaUAPart1SetDummy(pPlayer, iNumGeoglyphs)
    end
end

function NazcaUAPart1Build(playerID, plotX, plotY, improvementID)
    local pPlayer = Players[playerID]
    if pPlayer:IsEverAlive() and pPlayer:GetCivilizationType() == civilizationID then 
        local plot = Map.GetPlot(plotX, plotY)
        if plot and improvementID == iGeoglyphs then
            local iNumGeoglyphs = pPlayer:GetImprovementCount(iGeoglyphs)
			NazcaUAPart1SetDummy(pPlayer, iNumGeoglyphs)
        end
    end
end
--------------------------------------------------------------
-- NazcaUAPart2
--------------------------------------------------------------
local iPolicyBranchTradition = GameInfo.PolicyBranchTypes["POLICY_BRANCH_TRADITION"].ID
local iPolicyBranchLiberty = GameInfo.PolicyBranchTypes["POLICY_BRANCH_LIBERTY"].ID
local iPolicyBranchHonor = GameInfo.PolicyBranchTypes["POLICY_BRANCH_HONOR"].ID
local iPolicyBranchPiety = GameInfo.PolicyBranchTypes["POLICY_BRANCH_PIETY"].ID
local iPolicyBranchPatronage = GameInfo.PolicyBranchTypes["POLICY_BRANCH_PATRONAGE"].ID
local iPolicyBranchAesthetics = GameInfo.PolicyBranchTypes["POLICY_BRANCH_AESTHETICS"].ID
local iBuildingHeroicEpic = GameInfo.Buildings["BUILDING_HEROIC_EPIC"].ID
local iPromotionMorale = GameInfo.UnitPromotions["PROMOTION_MORALE"].ID

function NazcaUAPart2Founded(iPlayer, cityX, cityY)
    local pPlayer = Players[iPlayer]
    if pPlayer:IsEverAlive() and pPlayer:GetCivilizationType() == civilizationID then
        local iNumFounded = load(pPlayer, "NumFounded")
        if iNumFounded == nil then
            iNumFounded = 1
        elseif iNumFounded < 4 then
			local policyOptions = {}
			local branchOptions = {}
			pPlayer:SetNumFreePolicies(pPlayer:GetNumFreePolicies() + 1)
			for row in GameInfo.Policies() do
				local policy = GameInfoTypes[row.Type]
				if pPlayer:CanAdoptPolicy(policy) then
					if row.PolicyBranchType == "POLICY_BRANCH_TRADITION" or row.PolicyBranchType == "POLICY_BRANCH_LIBERTY" or row.PolicyBranchType == "POLICY_BRANCH_HONOR" or row.PolicyBranchType == "POLICY_BRANCH_PIETY" or row.PolicyBranchType == "POLICY_BRANCH_PATRONAGE" or row.PolicyBranchType == "POLICY_BRANCH_AESTHETICS" then
						if not pPlayer:HasPolicy(policy) then
							table.insert(policyOptions, policy)
						end
					end
				end
			end
			if not pPlayer:IsPolicyBranchUnlocked(iPolicyBranchTradition) then
				if pPlayer:CanUnlockPolicyBranch(iPolicyBranchTradition) then
					table.insert(branchOptions, iPolicyBranchTradition)
				end
			end
			if not pPlayer:IsPolicyBranchUnlocked(iPolicyBranchLiberty) then
				if pPlayer:CanUnlockPolicyBranch(iPolicyBranchLiberty) then
					table.insert(branchOptions, iPolicyBranchLiberty)
				end
			end
			if not pPlayer:IsPolicyBranchUnlocked(iPolicyBranchHonor) then
				if pPlayer:CanUnlockPolicyBranch(iPolicyBranchHonor) then
					table.insert(branchOptions, iPolicyBranchHonor)
				end
			end
			if not pPlayer:IsPolicyBranchUnlocked(iPolicyBranchPiety) then
				if pPlayer:CanUnlockPolicyBranch(iPolicyBranchPiety) then
					table.insert(branchOptions, iPolicyBranchPiety)
				end
			end
			if not pPlayer:IsPolicyBranchUnlocked(iPolicyBranchPatronage) then
				if pPlayer:CanUnlockPolicyBranch(iPolicyBranchPatronage) then
					table.insert(branchOptions, iPolicyBranchPatronage)
				end
			end
			if not pPlayer:IsPolicyBranchUnlocked(iPolicyBranchAesthetics) then
				if pPlayer:CanUnlockPolicyBranch(iPolicyBranchAesthetics) then
					table.insert(branchOptions, iPolicyBranchAesthetics)
				end
			end
			pPlayer:SetNumFreePolicies(pPlayer:GetNumFreePolicies() - 1)
			local rand = GetRandom(0, 1)
			if #branchOptions > 0 and (rand == 1 or #policyOptions < 1) then
				local branch = branchOptions[GetRandom(1, #branchOptions)]
				pPlayer:SetPolicyBranchUnlocked(branch, 1)
				pPlayer:SetHasPolicy(GameInfoTypes[GameInfo.PolicyBranchTypes[branch].FreePolicy], 1)
				if branch == iPolicyBranchHonor then
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
				if pPlayer:IsHuman() and pPlayer:IsTurnActive() then
					local title = "Ceremonial Sites!"
					local city = Map.GetPlot(cityX, cityY):GetPlotCity()
					local descr = Locale.ConvertTextKey("The founding of {1_CityName} has inspired your people to adopt {2_PolicyName}.", city:GetName(), Locale.ConvertTextKey(GameInfo.PolicyBranchTypes[branch].Description))
					pPlayer:AddNotification(NotificationTypes.NOTIFICATION_GENERIC, descr, title, -1, -1)
				end
			elseif #policyOptions > 0 and (rand == 0 or #branchOptions < 1) then
				local policy = policyOptions[GetRandom(1, #policyOptions)]
				pPlayer:SetHasPolicy(policy, 1)
				if pPlayer:IsHuman() and pPlayer:IsTurnActive() then
					local title = "Ceremonial Sites!"
					local city = Map.GetPlot(cityX,cityY):GetPlotCity()
					local descr = Locale.ConvertTextKey("The founding of {1_CityName} has inspired your people to adopt {2_PolicyName}.", city:GetName(), Locale.ConvertTextKey(GameInfo.Policies[policy].Description))
					pPlayer:AddNotification(NotificationTypes.NOTIFICATION_GENERIC, descr, title, -1, -1)
				end
			end
            iNumFounded = iNumFounded + 1
            save(pPlayer, "NumFounded", iNumFounded)
        end
    end
end

if JFD_IsCivilisationActive(civilizationID) then
    GameEvents.PlayerDoTurn.Add(NazcaUAPart1Turn)
    GameEvents.PlayerCityFounded.Add(NazcaUAPart1Founded)
    GameEvents.CityCaptureComplete.Add(NazcaUAPart1Capture)
    GameEvents.BuildFinished.Add(NazcaUAPart1Build)
    GameEvents.PlayerCityFounded.Add(NazcaUAPart2Founded)
end
--------------------------------------------------------------