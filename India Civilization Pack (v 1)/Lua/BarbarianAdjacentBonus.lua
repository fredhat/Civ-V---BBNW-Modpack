-- BarbarianAdjacentBonus
-- Author: Sukritact
-- Edited By: F0S
--------------------------------------------------------------
WARN_NOT_SHARED = false; include( "SaveUtils" ); MY_MOD_NAME = "BarbarianAdjacencyBonus";
include("PlotIterators")

local iPromotion = GameInfo.UnitPromotions["PROMOTION_ADJACENT_BARBARIAN"].ID
local iDeltaS = 3
local civilisationID = GameInfoTypes["CIVILIZATION_CHOLA"]

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

function BarbarianAdjacencyBonus(pUnit)
	if pUnit:IsHasPromotion(iPromotion) then
		local iStrength = GameInfo.Units[pUnit:GetUnitType()].Combat
		local pPlot = pUnit:GetPlot()
		local bBarbarianAdjacent = false
		for pAdjacentPlot in PlotAreaSweepIterator(pPlot, 1, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
			if pAdjacentPlot then
				local iNumUnits = pAdjacentPlot:GetNumUnits()
				for iVal = 0,(iNumUnits - 1) do
					local pPlotUnit = pAdjacentPlot:GetUnit(iVal)
					if pPlotUnit:IsBarbarian() then
						bBarbarianAdjacent = true
						break
					end
				end
			end
			if bBarbarianAdjacent then break end
		end
		if bBarbarianAdjacent then
			pUnit:SetBaseCombatStrength(iStrength + iDeltaS)
		else
			pUnit:SetBaseCombatStrength(iStrength)
		end
	end
end

function BarbarianAdjacencyBonusStartTrigger(iPlayer)
	local pPlayer = Players[iPlayer]
	if pPlayer:IsEverAlive() and not pPlayer:IsBarbarian() then
		for pUnit in pPlayer:Units() do
			BarbarianAdjacencyBonus(pUnit)
		end
	end
end

function BarbarianAdjacencyBonusMoveTrigger(iPlayer, iUnitID)
	local pPlayer = Players[iPlayer]
	local pUnit = pPlayer:GetUnitByID(iUnitID)
	if pPlayer:IsEverAlive() then
		if not pPlayer:IsBarbarian() then
			BarbarianAdjacencyBonus(pUnit)
		else
			local pPlot = pUnit:GetPlot()
			if pPlot then
				for pAdjacentPlot in PlotAreaSweepIterator(pPlot, 1, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
					if pAdjacentPlot then
						local iNumUnits = pAdjacentPlot:GetNumUnits()
						for iVal = 0,(iNumUnits - 1) do
							local pPlotUnit = pAdjacentPlot:GetUnit(iVal)
							if pPlotUnit:IsHasPromotion(iPromotion) then
								local iStrength = GameInfo.Units[pPlotUnit:GetUnitType()].Combat
								pPlotUnit:SetBaseCombatStrength(iStrength + iDeltaS)
							end
						end
					end
				end
			end
		end
	end
end

function BarbarianAdjacencyBonusInitialTrigger(iPlayer, iUnit)
	local pPlayer = Players[iPlayer]
	local pUnit = pPlayer:GetUnitByID(iUnit)
	if pUnit and pUnit:IsHasPromotion(iPromotion) then
		GameEvents.PlayerDoTurn.Add(BarbarianAdjacencyBonusStartTrigger)
		GameEvents.UnitSetXY.Add(BarbarianAdjacencyBonusMoveTrigger)
		Events.SerialEventUnitCreated.Remove(BarbarianAdjacencyBonusInitialTrigger)
		save("GAME", "BarbarianAdjacencyBonusInitalised", true)
		BarbarianAdjacencyBonus(pUnit)
	end
end

if JFD_IsCivilisationActive(civilisationID) then
	if load("GAME", "BarbarianAdjacencyBonusInitalised") then
		GameEvents.PlayerDoTurn.Add(BarbarianAdjacencyBonusStartTrigger)
		GameEvents.UnitSetXY.Add(BarbarianAdjacencyBonusMoveTrigger)
	else
		Events.SerialEventUnitCreated.Add(BarbarianAdjacencyBonusInitialTrigger)
	end
end