-- CholaUA
-- Author: Sukritact
-- Edited by F0S
--------------------------------------------------------------
local iModifier = ((GameInfo.GameSpeeds[Game.GetGameSpeedType()].GoldGiftMod)/100)
local civilisationID = GameInfoTypes["CIVILIZATION_CHOLA"]
local iFakeAdmiral = GameInfo.Buildings["BUILDING_CHOLA_DUMMY_ADMIRAL"].ID
local iFakeGold = GameInfo.Buildings["BUILDING_CHOLA_DUMMY_GOLD"].ID
local iIronCurtain = GameInfo.Policies["POLICY_IRON_CURTAIN"].ID
local tCholaGold = {}
local tCholaAdmiral = {}
local tCholaInfluence = {}

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

function CholaUA(iPlayer, bIsTurnStart)
    local pPlayer = Players[iPlayer]
    if pPlayer:GetCivilizationType() == civilisationID then
        tCholaGold[iPlayer] = 0
        tCholaAdmiral[iPlayer] = 0
        tCholaInfluence[iPlayer] = {}
        local tTradeRoutes = pPlayer:GetTradeRoutes()
        for i,v in ipairs(tTradeRoutes) do
            if v.FromID == iPlayer then
                local iDelta = 3
				local iDeltaInfluence = 1
				local pEra = pPlayer:GetCurrentEra()
				iDelta = iDelta + (0.5 * pEra)
				iDeltaInfluence = iDeltaInfluence + (0.5 * pEra)
				if pPlayer:HasPolicy(iIronCurtain) then
					iDelta = iDelta * 1.5
				end
                iDeltaInfluence = iDeltaInfluence * iModifier
                if v.Domain == DomainTypes.DOMAIN_SEA then
                    iDelta = iDelta * 2
                    iDeltaInfluence = iDeltaInfluence * 2
                end
                if v.FromID == v.ToID then
                    tCholaGold[iPlayer] = tCholaGold[iPlayer] + iDelta
                else
                    local pToCiv = Players[v.ToID]
                    if pToCiv:IsMinorCiv() then
                        tCholaAdmiral[iPlayer] = tCholaAdmiral[iPlayer] + iDelta
                        if tCholaInfluence[iPlayer][v.ToID] == nil then
                            tCholaInfluence[iPlayer][v.ToID] = iDeltaInfluence
                        else
                            tCholaInfluence[iPlayer][v.ToID] = tCholaInfluence[iPlayer][v.ToID] + iDeltaInfluence
                        end
                    end
                end
            end
        end
        if bIsTurnStart then
            for iToCiv, iInfluence in pairs(tCholaInfluence[iPlayer]) do
                local pToCiv = Players[iToCiv]
                pToCiv:ChangeMinorCivFriendshipWithMajor(iPlayer, math.floor(iInfluence))
            end
            pPlayer:ChangeNavalCombatExperience(math.floor(tCholaAdmiral[iPlayer]))
            pPlayer:ChangeGold(math.floor(tCholaGold[iPlayer]))
        end
		if iPlayer == Game.GetActivePlayer() and pPlayer:GetCapitalCity() then
            pPlayer:GetCapitalCity():SetNumRealBuilding(iFakeAdmiral, math.floor(tCholaAdmiral[iPlayer]))
			pPlayer:GetCapitalCity():SetNumRealBuilding(iFakeGold, math.floor(tCholaGold[iPlayer]))
        end   
    end
end

function CholaUATrigger1(iPlayer)
    local bIsTurnStart = true
    CholaUA(iPlayer, bIsTurnStart)
end

function CholaUATrigger2()
    local iPlayer = Game.GetActivePlayer()
    local pPlayer = Players[iPlayer]
    local bIsTurnStart = false
    if pPlayer:IsTurnActive() then
        CholaUA(iPlayer, bIsTurnStart)
    end
end

if JFD_IsCivilisationActive(civilisationID) then
	GameEvents.PlayerDoTurn.Add(CholaUATrigger1)
	Events.SerialEventGameDataDirty.Add(CholaUATrigger2)
end