-- IndianUA
-- Author: Sukritact
-- Edited By: F0S
--------------------------------------------------------------
local iCivType = GameInfoTypes["CIVILIZATION_INDIA"]
local iFakeFood = GameInfo.Buildings["BUILDING_INDIA_FOOD_BONUS"].ID

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

function IndianUA(iPlayer)
	local pPlayer = Players[iPlayer]
	if pPlayer:IsEverAlive() and pPlayer:GetCivilizationType() == iCivType then
		for pCity in pPlayer:Cities() do
			local pPlot = pCity:Plot()
			if pPlot:IsRiver() then
				if not pCity:IsHasBuilding(iFakeFood) then
					pCity:SetNumRealBuilding(iFakeFood, 1)
				end
			else
				if pCity:IsHasBuilding(iFakeFood) then
					pCity:SetNumRealBuilding(iFakeFood, 0)
				end
			end
		end
	end
end

function IndianUACapture(oldOwnerID, capital, plotX, plotY, newOwnerID)
	local pPlayer = Players[newOwnerID]
	local otherPlayer = Players[oldOwnerID]
	if pPlayer:IsEverAlive() and pPlayer:GetCivilizationType() == iCivType then
		local pPlot = Map.GetPlot(plotX, plotY)
		if pPlot then
			local capturedCity = pPlot:GetPlotCity()
			if capturedCity and pPlot:IsRiver() and not capturedCity:IsHasBuilding(iFakeFood) then
				capturedCity:SetNumRealBuilding(iFakeFood, 1)
			end
		end
	end
end

function IndianUAFounded(iPlayer, iCityX, iCityY)
	local pPlayer = Players[iPlayer]
	local pPlot = Map.GetPlot(iCityX, iCityY)
	local pCity = pPlot:GetPlotCity()
	if pPlayer:IsEverAlive() and pPlayer:GetCivilizationType() == iCivType then
		if pPlot:IsRiver() then
			if not pCity:IsHasBuilding(iFakeFood) then
				pCity:SetNumRealBuilding(iFakeFood, 1)
			end
		end
	end
end

if JFD_IsCivilisationActive(iCivType) then
	GameEvents.PlayerDoTurn.Add(IndianUA)
	GameEvents.CityCaptureComplete.Add(IndianUACapture)
	GameEvents.PlayerCityFounded.Add(IndianUAFounded)
end