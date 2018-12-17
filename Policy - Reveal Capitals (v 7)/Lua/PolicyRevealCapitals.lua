-- PolicyRevealCapitals
-- Author: William Howard
-- Heavily Edited By: F0S
--------------------------------------------------------------
-- UtilityFunctions
--------------------------------------------------------------
local directions = {DirectionTypes.DIRECTION_NORTHEAST, DirectionTypes.DIRECTION_EAST,
                    DirectionTypes.DIRECTION_SOUTHEAST, DirectionTypes.DIRECTION_SOUTHWEST, 
                    DirectionTypes.DIRECTION_WEST,      DirectionTypes.DIRECTION_NORTHWEST}

function showPlot(iTeam, pPlot)
	pPlot:SetRevealed(iTeam, true)
	pPlot:UpdateFog()
end

function showCell(pPlayer, pPlot)
	local iTeam = pPlayer:GetTeam()
	showPlot(iTeam, pPlot)
	for loop, direction in ipairs(directions) do
		showPlot(iTeam, Map.PlotDirection(pPlot:GetX(), pPlot:GetY(), direction))
	end
end
--------------------------------------------------------------
-- PolicyRevealCapitals
--------------------------------------------------------------
local iPolicyBranchPatronage = GameInfoTypes["POLICY_BRANCH_PATRONAGE"]
local iPolicyBranchCommerce = GameInfoTypes["POLICY_BRANCH_COMMERCE"]

function PolicyRevealCapitals(iPlayerId, iPolicyBranchTypeId) 
	pPlayer = Players[iPlayerId]
	if pPlayer:IsEverAlive() and pPlayer:IsHuman() then
		if iPolicyBranchTypeId == iPolicyBranchPatronage then
			for i = GameDefines.MAX_MAJOR_CIVS, GameDefines.MAX_CIV_PLAYERS - 1 do
				local pCSPlayer = Players[i]
				if pCSPlayer:IsEverAlive() and pCSPlayer:GetStartingPlot() then
					showCell(pPlayer, pCSPlayer:GetStartingPlot())
				end
			end
		elseif iPolicyBranchTypeId == iPolicyBranchCommerce then
			for i = 0, GameDefines.MAX_MAJOR_CIVS - 1 do
				local pCivPlayer = Players[i]
				if pCivPlayer:IsEverAlive() and pCivPlayer:GetStartingPlot() then
					showCell(pPlayer, pCivPlayer:GetStartingPlot())
				end
			end
		end
	end
end

GameEvents.PlayerAdoptPolicyBranch.Add(PolicyRevealCapitals)
--------------------------------------------------------------
-- CSPolicies
--------------------------------------------------------------
local iCivilisationMeiji = GameInfoTypes["CIVILIZATION_JFD_JAPAN_MEIJI"]
local iFakeCSCulture = GameInfo.Buildings["BUILDING_CS_DUMMY_CULTURE"].ID
local iFakeCSCultureGA = GameInfo.Buildings["BUILDING_CS_DUMMY_CULTURE_GA"].ID
local iFakeCSScience = GameInfo.Buildings["BUILDING_CS_DUMMY_SCIENCE"].ID
local iFakePolicyTradeRoute = GameInfo.Buildings["BUILDING_POLICY_DUMMY_TRADE_ROUTE"].ID
local iPhilanthropy = GameInfo.Policies["POLICY_PHILANTHROPY"].ID
local iScholasticism = GameInfo.Policies["POLICY_SCHOLASTICISM"].ID
local iMerchantConfederacy = GameInfo.Policies["POLICY_MERCHANT_CONFEDERACY"].ID
local iCulturalDiplomacy = GameInfo.Policies["POLICY_CULTURAL_DIPLOMACY"].ID
local iEconomicUnion = GameInfo.Policies["POLICY_ECONOMIC_UNION"].ID
local iWagonTrains = GameInfo.Policies["POLICY_CARAVANS"].ID
local iMerchantNavy = GameInfo.Policies["POLICY_MERCHANT_NAVY"].ID
local iRationalism = GameInfo.PolicyBranchTypes["POLICY_BRANCH_RATIONALISM"].ID
local tCSCulture = {}
local tCSCultureGA = {}
local tCSScience = {}
local tCSScienceExtra = {}

function CSPolicies(iPlayer, bIsTurnStart)
    local pPlayer = Players[iPlayer]
	tCSCulture[iPlayer] = 0
	tCSCultureGA[iPlayer] = 0
	tCSScience[iPlayer] = tCSScienceExtra[iPlayer] or 0
	if pPlayer:IsEverAlive() and not pPlayer:IsBarbarian() and not pPlayer:IsMinorCiv() then
		if pPlayer:HasPolicy(iPhilanthropy) then
			local tTradeRoutes = pPlayer:GetTradeRoutes()
			for i,v in ipairs(tTradeRoutes) do
				if v.FromID == iPlayer then
					local iDelta = 3
					if v.Domain == DomainTypes.DOMAIN_SEA then
						iDelta = iDelta * 2
					end
					if v.FromID ~= v.ToID then
						local pToCiv = Players[v.ToID]
						if pToCiv:IsEverAlive() and pToCiv:IsMinorCiv() then
							tCSCulture[iPlayer] = tCSCulture[iPlayer] + iDelta
						end
					end
				end
			end
		end
		if pPlayer:HasPolicy(iScholasticism) then
			local tTradeRoutes = pPlayer:GetTradeRoutes()
			for i,v in ipairs(tTradeRoutes) do
				if v.FromID == iPlayer then
					local iDelta = 3
					if v.Domain == DomainTypes.DOMAIN_SEA then
						iDelta = iDelta * 2
					end
					if v.FromID ~= v.ToID then
						local pToCiv = Players[v.ToID]
						if pToCiv:IsEverAlive() and pToCiv:IsMinorCiv() then
							tCSScience[iPlayer] = tCSScience[iPlayer] + iDelta
						end
					end
				end
			end
		end
		if tCSCulture[iPlayer] > 0 then
			if pPlayer:IsGoldenAge() then
				if pPlayer:GetCivilizationType() == iCivilisationMeiji then
					tCSCultureGA[iPlayer] = math.ceil(tCSCulture[iPlayer] * 0.3)
				else
					tCSCultureGA[iPlayer] = math.ceil(tCSCulture[iPlayer] * 0.2)
				end
			end
		end
		if bIsTurnStart then
			if tCSCulture[iPlayer] > 0 then
				pPlayer:ChangeJONSCulture(tCSCulture[iPlayer] + tCSCultureGA[iPlayer])
			end
			if tCSScience[iPlayer] > 0 then
				local iResearch = pPlayer:GetCurrentResearch()
				if iResearch > 0 then
					local tTechs = Teams[pPlayer:GetTeam()]:GetTeamTechs()
					if pPlayer:IsPolicyBranchUnlocked(iRationalism) then
						tTechs:ChangeResearchProgress(iResearch, math.ceil(tCSScience[iPlayer] * 1.1), iPlayer)
					else
						tTechs:ChangeResearchProgress(iResearch, tCSScience[iPlayer], iPlayer)
					end
					tCSScienceExtra[iPlayer] = 0
				else
					tCSScienceExtra[iPlayer] = tCSScience[iPlayer]
				end
			end
		end
		for pCity in pPlayer:Cities() do
			if pCity then
				if pCity:IsCapital() then
					pCity:SetNumRealBuilding(iFakeCSCulture, tCSCulture[iPlayer])
					pCity:SetNumRealBuilding(iFakeCSCultureGA, tCSCultureGA[iPlayer])
					pCity:SetNumRealBuilding(iFakeCSScience, tCSScience[iPlayer])
				else
					pCity:SetNumRealBuilding(iFakeCSCulture, 0)
					pCity:SetNumRealBuilding(iFakeCSCultureGA, 0)
					pCity:SetNumRealBuilding(iFakeCSScience, 0)
				end
			end
		end
		local capital = pPlayer:GetCapitalCity()
	end
end

function CSPoliciesTrigger1(iPlayer)
    local bIsTurnStart = true
    CSPolicies(iPlayer, bIsTurnStart)
end

function CSPoliciesTrigger2()
    local iPlayer = Game.GetActivePlayer()
    local pPlayer = Players[iPlayer]
    local bIsTurnStart = false
    if pPlayer:IsTurnActive() then
        CSPolicies(iPlayer, bIsTurnStart)
    end
end

function CSPoliciesTrigger3(iPlayer, iPolicy)
    local pPlayer = Players[iPlayer]
    if pPlayer:IsEverAlive() and not pPlayer:IsBarbarian() and not pPlayer:IsMinorCiv() and (iPolicy == iMerchantConfederacy and pPlayer:HasPolicy(iCulturalDiplomacy)) or (iPolicy == iCulturalDiplomacy and pPlayer:HasPolicy(iMerchantConfederacy)) then
		for iMinor = GameDefines.MAX_MAJOR_CIVS, GameDefines.MAX_CIV_PLAYERS-1, 1 do
			local pMinor = Players[iMinor]
			if pMinor:IsEverAlive() and Teams[pPlayer:GetTeam()]:IsHasMet(pMinor:GetTeam()) then
				pMinor:ChangeMinorCivFriendshipWithMajor(iPlayer, 30)
			end
		end
    end
	if iPolicy == iMerchantConfederacy or iPolicy == iEconomicUnion or iPolicy == iWagonTrains or iPolicy == iMerchantNavy then
		PolicyTradeTrigger1(iPlayer)
	end
end

function PolicyTradeTrigger1(iPlayer)
	local pPlayer = Players[iPlayer]
	if pPlayer:IsEverAlive() and not pPlayer:IsBarbarian() and not pPlayer:IsMinorCiv() then
		local numTrade = 0
		if pPlayer:HasPolicy(iMerchantConfederacy) then
			numTrade = numTrade + 2
		end
		if pPlayer:HasPolicy(iEconomicUnion) then
			numTrade = numTrade + 1
		end
		if pPlayer:HasPolicy(iWagonTrains) then
			numTrade = numTrade + 1
		end
		if pPlayer:HasPolicy(iMerchantNavy) then
			numTrade = numTrade + 2
		end
		for pCity in pPlayer:Cities() do
			if pCity then
				if pCity:IsCapital() then
					if pCity:GetNumBuilding(iFakePolicyTradeRoute) ~= numTrade then
						pCity:SetNumRealBuilding(iFakePolicyTradeRoute, numTrade)
					end
				else
					if pCity:IsHasBuilding(iFakePolicyTradeRoute) then
						pCity:SetNumRealBuilding(iFakePolicyTradeRoute, 0)
					end
				end
			end
		end
	end
end

function PolicyTradeTrigger2(oldOwnerID, capital, plotX, plotY, newOwnerID)
	PolicyTradeTrigger1(oldOwnerID)
	PolicyTradeTrigger1(newOwnerID)
end

GameEvents.PlayerDoTurn.Add(CSPoliciesTrigger1)
GameEvents.PlayerDoTurn.Add(PolicyTradeTrigger1)
Events.SerialEventGameDataDirty.Add(CSPoliciesTrigger2)
GameEvents.CityCaptureComplete.Add(PolicyTradeTrigger2)
GameEvents.PlayerAdoptPolicy.Add(CSPoliciesTrigger3)
--------------------------------------------------------------
-- MilitaristicCSXP
--------------------------------------------------------------
local iCivilisationSiam = GameInfoTypes["CIVILIZATION_SIAM"]
local iFakeMilitaristicCSXP = GameInfo.Buildings["BUILDING_MILITARISTIC_CS_BONUS"].ID

function MilitaristicCSXP(iPlayer)
	local pPlayer = Players[iPlayer]
	if pPlayer:IsEverAlive() and not pPlayer:IsBarbarian() and not pPlayer:IsMinorCiv() then
		local cXp = 0
		local aXp = 0
		for iMinor = GameDefines.MAX_MAJOR_CIVS, GameDefines.MAX_CIV_PLAYERS-1, 1 do
			local pMinor = Players[iMinor]
			if pMinor:IsEverAlive() and pMinor:GetCapitalCity() then
				if GameInfo.MinorCivilizations[pMinor:GetMinorCivType()].MinorCivTrait == "MINOR_TRAIT_MILITARISTIC" then
					if pMinor:GetMinorCivFriendshipLevelWithMajor(iPlayer) == 1 then
						cXp = cXp + 1
					elseif pMinor:GetMinorCivFriendshipLevelWithMajor(iPlayer) == 2 then
						cXp = cXp + 2
						aXp = aXp + 1
					end
				end
			end
		end
		if pPlayer:GetCivilizationType() == iCivilisationSiam then
			cXp = cXp * 2
			aXp = aXp * 2
		end
		for pCity in pPlayer:Cities() do
			if pCity then
				if pCity:IsCapital() then
					if pCity:GetNumBuilding(iFakeMilitaristicCSXP) ~= cXp then
						pCity:SetNumRealBuilding(iFakeMilitaristicCSXP, cXp)
					end
				else
					if pCity:GetNumBuilding(iFakeMilitaristicCSXP) ~= aXp then
						pCity:SetNumRealBuilding(iFakeMilitaristicCSXP, aXp)
					end
				end
			end
		end
	end
end

function MilitaristicCSXPDirty()
	local iPlayer = Game.GetActivePlayer()
    local pPlayer = Players[iPlayer]
	if pPlayer:IsTurnActive() then
        MilitaristicCSXP(iPlayer)
    end
end

GameEvents.PlayerDoTurn.Add(MilitaristicCSXP)
Events.SerialEventGameDataDirty.Add(MilitaristicCSXPDirty)
--------------------------------------------------------------