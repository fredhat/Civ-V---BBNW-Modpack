-- JFD_PaMilitaryUnitProduction
-- Author: JFD
-- Edited By: F0S
--=======================================================================================================================
-- Utility Functions
--=======================================================================================================================
-- JFD_IsCivilisationActive
-------------------------------------------------------------------------------------------------------------------------
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
--=======================================================================================================================
-- JFD_PaMilitaryProduction
--=======================================================================================================================
local civilisationID = GameInfoTypes["CIVILIZATION_MC_MAORI"]
local improvementPaID = GameInfoTypes["IMPROVEMENT_MC_MAORI_PA"]
local buildingPaMilitaryProductionID = GameInfoTypes["BUILDING_PA_MILITARY_UNIT_PRODUCTION"]

function JFD_GetNumberWorkedPas(playerID, city)
	local numWorkedPas = 0
	for plotID = 0, city:GetNumCityPlots() - 1, 1 do
		local plot = city:GetCityIndexPlot(plotID)
		if plot and plot:GetOwner() == playerID then
			if city:IsWorkingPlot(plot) then	
				if plot:GetImprovementType() == improvementPaID and not plot:IsImprovementPillaged() then 
					numWorkedPas = numWorkedPas + 1
				end
			end
		end
	end
	return numWorkedPas
end
	
function JFD_PaMilitaryProduction(playerID)
	local player = Players[playerID]
	if player:IsEverAlive() then
		for city in player:Cities() do
			if city then
				local numWorkedPas = JFD_GetNumberWorkedPas(playerID, city)
				if city:GetNumBuilding(buildingPaMilitaryProductionID) ~= numWorkedPas then
					city:SetNumRealBuilding(buildingPaMilitaryProductionID, numWorkedPas)
				end
			end
		end
	end
end

function JFD_PaMilitaryProductionDirty()
	local playerID = Game.GetActivePlayer()
    local player = Players[playerID]
	if player:IsTurnActive() then
        JFD_PaMilitaryProduction(playerID)
    end
end

if JFD_IsCivilisationActive(civilisationID) then
	GameEvents.PlayerDoTurn.Add(JFD_PaMilitaryProduction)
	Events.SerialEventGameDataDirty.Add(JFD_PaMilitaryProductionDirty)
end
--=======================================================================================================================
--=======================================================================================================================