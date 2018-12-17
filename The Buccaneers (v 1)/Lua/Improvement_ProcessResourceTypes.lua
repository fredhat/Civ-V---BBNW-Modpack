-- Improvement_ProcessResourceTypes
-- Author: Sukritact
-- Edited By: F0S
--------------------------------------------------------------
--[[
To use, ensure that both resources (the one to be improved, and 
the one to be gained), can both be improved by this improvement.

This code will simply replace the "raw resource" with the 
"processed resource". It will keep track of the tiles that have been
saved, and revert the tile back to the original resource if it finds the
required improvement missing.

Resource management (from trade, pillaging, etc), will be handled
by the game as it normally does.
]]
--------------------------------------------------------------
WARN_NOT_SHARED = false; include("Sukritact_SaveUtils"); MY_MOD_NAME = "Improvement_ProcessResourceTypes";
--------------------------------------------------------------
-- Utility Functions
--------------------------------------------------------------
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

function DecompilePlotID(sKey)
    iBreak = string.find(sKey, "Y")
    iX = tonumber(string.sub(sKey, 1, iBreak - 1))
    iY = tonumber(string.sub(sKey, iBreak + 1))
    pPlot = Map.GetPlot(iX, iY)
    return pPlot
end

function CompilePlotID(pPlot)
    iX = pPlot:GetX()
    iY = pPlot:GetY()
    return(iX .. "Y" .. iY)
end
--------------------------------------------------------------
-- Initial Processes
--------------------------------------------------------------
--Populate table with previous entries
local tPlots = {}

function InitPlotTables()
    for iPlot = 0, Map.GetNumPlots() - 1, 1 do
		local pPlot = Map.GetPlotByIndex(iPlot)
		if pPlot then
			local iRes = load(pPlot, "iRes")
			if iRes then
				local sKey = CompilePlotID(pPlot)
				tPlots[sKey] = iRes
			end
		end
	end
end
--------------------------------------------------------------
-- Main Code
--------------------------------------------------------------
local improvementDistilleryID = GameInfoTypes["IMPROVEMENT_BUCCANEER_DISTILLERY"]
local improvementDistilleryUpgradeID = GameInfoTypes["IMPROVEMENT_BUCCANEER_DISTILLERY_VINTAGE"]
local resourceSugarID = GameInfoTypes["RESOURCE_SUGAR"]
local resourceRumID = GameInfoTypes["RESOURCE_RUM"]

function OnImprovementBuilt(iPlayer, iX, iY, iImprovement)
    local pPlayer = Players[iPlayer]
	if pPlayer:IsEverAlive() and pPlayer:GetCivilizationType() == civilisationID then
		if iImprovement == improvementDistilleryID then
			local pPlot = Map.GetPlot(iX, iY)
			if pPlot then
				local iRes = pPlot:GetResourceType()
				if iRes > -1 and iRes == resourceSugarID then
					pPlot:SetImprovementType(-1)
					pPlot:SetResourceType(resourceRumID, pPlot:GetNumResource())
					pPlot:SetImprovementType(iImprovement)
					save(pPlot, "iRes", iRes)
					local sKey = CompilePlotID(pPlot)
					tPlots[sKey] = iRes
				end
			end
		end
	end
end

function CheckTiles()
    for sKey, iRes in pairs(tPlots) do
        local pPlot = DecompilePlotID(sKey)
		if pPlot then
			iImprovement = pPlot:GetImprovementType()
			if iImprovement and iImprovement ~= improvementDistilleryID and iImprovement ~= improvementDistilleryUpgradeID then
				local iPlotRes = pPlot:GetResourceType()
				if iPlotRes > -1 and iRes == iPlotRes then
					pPlot:SetResourceType(resourceSugarID, pPlot:GetNumResource())
					save(pPlot, "iRes", nil)
					tPlots[sKey] = nil
				end
			end
		end
    end
end

if JFD_IsCivilisationActive(civilisationID) then
	InitPlotTables()
	GameEvents.BuildFinished.Add(OnImprovementBuilt)
	Events.SerialEventCityInfoDirty.Add(CheckTiles)
	GameEvents.PlayerDoTurn.Add(CheckTiles)
end
--------------------------------------------------------------