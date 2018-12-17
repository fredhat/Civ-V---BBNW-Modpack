-- BuccaneerUA
-- Author: Sukritact
-- Heavily Edited By: F0S
--------------------------------------------------------------
-- Utilities
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

function JFD_GetRandom(lower, upper)
    return Game.Rand((upper + 1) - lower, "") + lower
end
--------------------------------------------------------------
-- Main Code
--------------------------------------------------------------
local iCivType = GameInfoTypes["CIVILIZATION_BUCCANEER"]
local iUnitCorsair = GameInfoTypes["UNIT_BUCCANEER_CORSAIR"]
local iUnitGreatAdmiral = GameInfoTypes["UNIT_GREAT_ADMIRAL"]
local iThreshold = 50
local iMod = 10
local pBarbarian = Players[63]

function BuccaneerUA(iPlayer)
    local pPlayer = Players[iPlayer]
    if pPlayer:IsEverAlive() and pPlayer:GetCivilizationType() == iCivType then
        for pUnit in pPlayer:Units() do
            if pUnit and pUnit:GetCombatLimit() > 0 and pUnit:GetDomainType() == DomainTypes.DOMAIN_SEA then
                local pPlot = pUnit:GetPlot()
				if pPlot then
					local iPlotOwner = pPlot:GetOwner()
					if not (iPlotOwner == iPlayer or iPlotOwner == -1 or Players[iPlotOwner]:IsMinorCiv()) then
						local iTeam = pPlayer:GetTeam()
						local iPlotTeam = pPlot:GetTeam()
						if iPlotTeam and not (Teams[iPlotTeam]:IsAllowsOpenBordersToTeam(iTeam) or Teams[iTeam]:IsAtWar(iPlotTeam)) then
							local iRandom = JFD_GetRandom(1,100)
							local iTrueTreshold = iThreshold - (pUnit:GetLevel() * iMod)
							if iRandom <= iTrueTreshold then
								local pNewUnit = pBarbarian:InitUnit(pUnit:GetUnitType(), pUnit:GetX(), pUnit:GetY(), UNITAI_ATTACK)
								pNewUnit:Convert(pUnit)
								if pPlayer:IsHuman() and pPlayer:IsTurnActive() then
									local description
									if pNewUnit:GetUnitType() == iUnitCorsair or pNewUnit:GetUnitType() == iUnitGreatAdmiral then
										description = Locale.ConvertTextKey("TXT_KEY_JFD_PIRATE_DEFECT_CORSAIR", pNewUnit:GetNameNoDesc())
									else
										description = Locale.ConvertTextKey("TXT_KEY_JFD_PIRATE_DEFECT", pNewUnit:GetName())
									end
									local descriptionShort = Locale.ConvertTextKey("TXT_KEY_JFD_PIRATE_DEFECT_SHORT")
									pPlayer:AddNotification(NotificationTypes["NOTIFICATION_BARBARIAN"], description, descriptionShort, pNewUnit:GetX(), pNewUnit:GetY())
									Events.AudioPlay2DSound("AS2D_EVENT_NOTIFICATION_VERY_BAD")
								end
							end
						end
					end
				end
            end
        end
    end
end

if JFD_IsCivilisationActive(iCivType) then
    GameEvents.PlayerDoTurn.Add(BuccaneerUA)
end
--------------------------------------------------------------