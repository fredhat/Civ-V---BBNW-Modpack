-- F0S_NetherlandsFunctions
-- Author: F0S
--=======================================================================================================================
-- UTILITY FUNCTIONS
--==========================================================================================================================
-- JFD_IsCivilisationActive
--------------------------------------------------------------
local civilisationID = GameInfoTypes["CIVILIZATION_NETHERLANDS"]

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
-- CORE NETHERLANDS FUNCTIONS	
--=======================================================================================================================
-- F0S_DisembarkPolders
--------------------------------------------------------------
local improvementPolderID = GameInfoTypes["IMPROVEMENT_POLDER"]

function F0S_DisembarkPolders(playerID, iX, iY, improvementID)
	local player = Players[playerID]
    if player:IsEverAlive() and player:GetCivilizationType() == civilisationID then 
		if improvementID and improvementID == improvementPolderID then
			local plot = Map.GetPlot(iX, iY)
			if plot then
				local embarkedUnits = {}
				for i = 0, plot:GetNumUnits() - 1 do
					local unit = plot:GetUnit(i)
					if unit:IsEmbarked() then
						table.insert(embarkedUnits, unit)
					end
				end
				for _,unit in pairs(embarkedUnits) do
					local newUnit = player:InitUnit(unit:GetUnitType(), unit:GetX(), unit:GetY())
					unit:SetEmbarked(false)
					newUnit:Convert(unit, false)
					newUnit:FinishMoves()
				end
			end
		end
	end
end
--------------------------------------------------------------
-- F0S_ForeignCityBuildings
--------------------------------------------------------------
local tableTradeBuildings = {
	[GameInfoTypes.BUILDING_GRANARY] = 1,
	[GameInfoTypes.BUILDING_WORKSHOP] = 2,
	[GameInfoTypes.BUILDING_CARAVANSARY] = 3,
	[GameInfoTypes.BUILDING_MARKET] = 4,
	[GameInfoTypes.BUILDING_BANK] = 5,
	[GameInfoTypes.BUILDING_STOCK_EXCHANGE] = 6
}
local buildingHarborID = GameInfoTypes["BUILDING_HARBOR"]

function F0S_ForeignCityBuildings(playerID, iX, iY)
	local player = Players[playerID]
	if player:IsEverAlive() and player:GetCivilizationType() == civilisationID then
		local plot = Map.GetPlot(iX, iY)
		if plot then
			local city = plot:GetPlotCity()
			if city and not city:IsCapital() then
				local capital = player:GetCapitalCity()
				if capital and plot:GetArea() ~= capital:Plot():GetArea() then
					for buildingID, buildingIndex in pairs(tableTradeBuildings) do
						if capital:IsHasBuilding(buildingID) and not city:IsHasBuilding(buildingID) then
							city:SetNumRealBuilding(buildingID, 1)
						end
					end
					if plot:IsCoastalLand() and capital:IsHasBuilding(buildingHarborID) and not city:IsHasBuilding(buildingHarborID) then
						city:SetNumRealBuilding(buildingHarborID, 1)
					end
				end
			end
		end
	end 	
end

if JFD_IsCivilisationActive(civilisationID) then
	GameEvents.BuildFinished.Add(F0S_DisembarkPolders)
	GameEvents.PlayerCityFounded.Add(F0S_ForeignCityBuildings)
end
--==========================================================================================================================
--==========================================================================================================================