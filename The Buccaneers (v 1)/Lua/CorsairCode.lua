-- CorsairCode
-- Author: Sukritact
-- Edited By: F0S
--------------------------------------------------------------
WARN_NOT_SHARED = false; include("Sukritact_SaveUtils"); MY_MOD_NAME = "CorsairCode";
include("FLuaVector.lua")
--------------------------------------------------------------
-- Utility Functions
--------------------------------------------------------------
local tClasses = {}
tClasses[GameInfoTypes.UNITCLASS_CARGO_SHIP] = GameInfoTypes.UNITCLASS_CARGO_SHIP
tClasses[GameInfoTypes.UNITCLASS_CARAVAN] = GameInfoTypes.UNITCLASS_CARAVAN
local civilisationID = GameInfoTypes["CIVILIZATION_BUCCANEER"]

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

function JFD_GoldFromTradeRoutePillage(player, unit)
    local goldPillaged = 100
    player:ChangeGold(goldPillaged)
    if player:IsHuman() and player:IsTurnActive() then
        local hex = ToHexFromGrid(Vector2(unit:GetX(), unit:GetY()))
		Events.AddPopupTextEvent(HexToWorld(hex), Locale.ConvertTextKey("[COLOR_YELLOW]+{1_Num}[ENDCOLOR] [ICON_GOLD]", goldPillaged), 1)
		Events.GameplayFX(hex.x, hex.y, -1)
    end
end
--------------------------------------------------------------
-- Detect Plunder
--------------------------------------------------------------
function DetectPlunder(iPlayer, iUnit)
    local pPlayer = Players[iPlayer]
	if pPlayer:IsEverAlive() then
		local pUnit = pPlayer:GetUnitByID(iUnit)
		if pUnit and tClasses[pUnit:GetUnitClassType()] then
			local pTeam = Teams[pPlayer:GetTeam()]
			local pPlot = pUnit:GetPlot()
			if pPlot then
				for iVal = 0,pPlot:GetNumUnits() - 1 do
					local pPlotUnit = pPlot:GetUnit(iVal)
					if pPlotUnit and pPlotUnit:GetCombatLimit() > 0 and pTeam:IsAtWar(pPlotUnit:GetTeam()) then
						-- Being plundered, run function
						local pPlotPlayer = Players[pPlotUnit:GetOwner()]
						if pPlotPlayer:IsEverAlive() and pPlotPlayer:GetCivilizationType() == civilisationID then
							JFD_GoldFromTradeRoutePillage(pPlotPlayer, pPlotUnit)
						end
						CorsairCode(pPlotPlayer, pPlotUnit)
						break
					end
				end
			end
		end
	end
	return false
end

function ClearData(iPlayer, iUnit)
    local pPlayer = Players[iPlayer]
	if pPlayer:IsEverAlive() then
		local pUnit = pPlayer:GetUnitByID(iUnit)
		if pUnit then
			local sSave = (iUnit .. "Turns")
			save(pPlayer, sSave, nil)
			save(pPlayer, iUnit, nil)
		end
	end
end
--------------------------------------------------------------
-- Corsair Code
--------------------------------------------------------------
local iModS = 5
local iPromotion = GameInfoTypes.PROMOTION_HIGH_SEA_RAIDING

function CorsairCode(pPlayer, pUnit)
    if pUnit:IsHasPromotion(iPromotion) then
		local iUnit = pUnit:GetID()
		local iStrength = GameInfo.Units[pUnit:GetUnitType()].Combat
		-- Strength
		local iDeltaS = load(pPlayer, iUnit) or 0
		iDeltaS = iDeltaS + 1
		save(pPlayer, iUnit, iDeltaS)
		pUnit:SetBaseCombatStrength(iStrength + (iDeltaS * iModS))
		-- Turns
		local sSave = (iUnit .. "Turns")
		local iTurns = load(pPlayer, sSave) or 0
		iTurns = iTurns + 5
		save(pPlayer, sSave, iTurns)
	end
end

function CorsairMonitor(iPlayer)
    local pPlayer = Players[iPlayer]
    if pPlayer:IsEverAlive() then
        for pUnit in pPlayer:Units() do
            if pUnit and pUnit:IsHasPromotion(iPromotion) then
                local iStrength = GameInfo.Units[pUnit:GetUnitType()].Combat
                local iUnit = pUnit:GetID()
                local sSave = (iUnit .. "Turns")
                local iTurns = load(pPlayer, sSave) or 0
                iTurns = iTurns - 1
                if iTurns >= 0 then
                    save(pPlayer, sSave, iTurns)
                else
                    save(pPlayer, sSave, nil)
                    save(pPlayer, iUnit, nil)
                    pUnit:SetBaseCombatStrength(iStrength)
                end
            end
        end
    end
end

function CorsairInitialTrigger(iPlayer, iUnit)
    local pPlayer = Players[iPlayer]
    local pUnit = pPlayer:GetUnitByID(iUnit)
    if pUnit and pUnit:IsHasPromotion(iPromotion) then
        Events.SerialEventUnitDestroyed.Add(ClearData)
        GameEvents.PlayerDoTurn.Add(CorsairMonitor)
        Events.SerialEventUnitCreated.Remove(CorsairInitialTrigger)
        save("GAME", "CorsairInitalised", true)
        CorsairMonitor(iPlayer)
    end
end

if JFD_IsCivilisationActive(civilisationID) then
    GameEvents.CanSaveUnit.Add(DetectPlunder)
    if load("GAME", "CorsairInitalised") then
        Events.SerialEventUnitDestroyed.Add(ClearData)
        GameEvents.PlayerDoTurn.Add(CorsairMonitor)
    else
        Events.SerialEventUnitCreated.Add(CorsairInitialTrigger)
    end
end
--------------------------------------------------------------