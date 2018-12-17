-- Mussolini Italy Functions
-- Author: JFD
-- Heavily Edited By: F0S
--=======================================================================================================================
-- UTILITY FUNCTIONS
--=======================================================================================================================
WARN_NOT_SHARED = false; include( "Sukritact_SaveUtils.lua" ); MY_MOD_NAME = "Musolini Italy Functions";
include("FLuaVector.lua")

local civilisationID = GameInfoTypes["CIVILIZATION_JFD_ITALY"]

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

function JFD_AddBuilding(player, city, buildingID, num)
	if city:GetNumBuilding(buildingID) ~= num then
		city:SetNumRealBuilding(buildingID, num)
	end
end

function JFD_RemoveBuilding(player, city, buildingID)
	if city:IsHasBuilding(buildingID) then
		city:SetNumRealBuilding(buildingID, 0)
	end
end
--==========================================================================================================================
-- CORE FUNCTIONS
--==========================================================================================================================
--JFD_ItalianProduction
----------------------------------------------------------------------------------------------------------------------------
local buildingItalianProductionID = GameInfoTypes["BUILDING_JFD_ITALIAN_PRODUCTION"]

function JFD_CheckCoastline(playerID, city)
	local isAlone = true
	for otherPlayerID = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
		if otherPlayerID ~= playerID then
			local otherPlayer = Players[otherPlayerID]
			if otherPlayer:IsEverAlive() and not otherPlayer:IsMinorCiv() then
				for otherCity in otherPlayer:Cities() do
					if city:Plot():GetArea() == otherCity:Plot():GetArea() then
						isAlone = false
						break
					end
				end
			end
		end
	end
	return isAlone
end

function JFD_ItalianProduction(playerID)
	local player = Players[playerID]
	if player:IsEverAlive() and player:GetCivilizationType() == civilisationID then
		for city in player:Cities() do
			if city:IsCoastal() and JFD_CheckCoastline(playerID, city) then
				JFD_AddBuilding(player, city, buildingItalianProductionID, 1)
			else
				JFD_RemoveBuilding(player, city, buildingItalianProductionID)
			end
		end
	end
end
----------------------------------------------------------------------------------------------------------------------------
--JFD_GoldenAgeCoastalCities
----------------------------------------------------------------------------------------------------------------------------
function JFD_GoldenAgeCoastalCityCapture(oldOwnerID, capital, iX, iY, newOwnerID)
	local player = Players[newOwnerID]
	if player:IsEverAlive() then
		local city = Map.GetPlot(iX, iY):GetPlotCity()
		if player:GetCivilizationType() == civilisationID then
			if city and city:IsCoastal() then
				local goldenAgeReward = math.ceil(player:GetGoldenAgeProgressThreshold() * 33 / 100)
				if capital then goldenAgeReward = goldenAgeReward * 2 end
				if not player:IsGoldenAge() then
					player:ChangeGoldenAgeProgressMeter(goldenAgeReward)
					if player:IsHuman() and player:IsTurnActive() and goldenAgeReward > 0 then
						local hex = ToHexFromGrid(Vector2(iX, iY))
						Events.AddPopupTextEvent(HexToWorld(hex), Locale.ConvertTextKey("[COLOR_POSITIVE_TEXT]+{1_Num}[ENDCOLOR] [ICON_GOLDEN_AGE]", goldenAgeReward), 1)
						Events.GameplayFX(hex.x, hex.y, -1)
					end
				end
				for otherCity in player:Cities() do
					if otherCity:IsCoastal() and JFD_CheckCoastline(newOwnerID, otherCity) then
						JFD_AddBuilding(player, otherCity, buildingItalianProductionID, 1)
					else
						JFD_RemoveBuilding(player, otherCity, buildingItalianProductionID)
					end
				end
			end
		else
			if city and city:IsCoastal() then
				for otherPlayerID = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
					local otherPlayer = Players[otherPlayerID]
					if otherPlayer:IsEverAlive() and otherPlayer:GetCivilizationType() == civilisationID then
						for otherCity in otherPlayer:Cities() do
							if otherCity:IsCoastal() and JFD_CheckCoastline(otherPlayerID, otherCity) then
								JFD_AddBuilding(otherPlayer, otherCity, buildingItalianProductionID, 1)
							else
								JFD_RemoveBuilding(otherPlayer, otherCity, buildingItalianProductionID)
							end
						end
					end
				end
			end
		end
	end
end
		
function JFD_GoldenAgeCoastalCityFounded(playerID, iX, iY)
	local player = Players[playerID]
	if player:IsEverAlive() then
		local city = Map.GetPlot(iX, iY):GetPlotCity()
		if player:GetCivilizationType() == civilisationID then
			if city and city:IsCoastal() then
				local goldenAgeReward = math.ceil(player:GetGoldenAgeProgressThreshold() * 33 / 100)
				if city:IsOriginalCapital() then goldenAgeReward = goldenAgeReward * 2 end
				if not player:IsGoldenAge() then
					player:ChangeGoldenAgeProgressMeter(goldenAgeReward)
					if player:IsHuman() and player:IsTurnActive() and goldenAgeReward > 0 then
						local hex = ToHexFromGrid(Vector2(iX, iY))
						Events.AddPopupTextEvent(HexToWorld(hex), Locale.ConvertTextKey("[COLOR_POSITIVE_TEXT]+{1_Num}[ENDCOLOR] [ICON_GOLDEN_AGE]", goldenAgeReward), 1)
						Events.GameplayFX(hex.x, hex.y, -1)
					end
				end
				for otherCity in player:Cities() do
					if otherCity:IsCoastal() and JFD_CheckCoastline(playerID, otherCity) then
						JFD_AddBuilding(player, otherCity, buildingItalianProductionID, 1)
					else
						JFD_RemoveBuilding(player, otherCity, buildingItalianProductionID)
					end
				end
			end
		else
			if city and city:IsCoastal() then
				for otherPlayerID = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
					local otherPlayer = Players[otherPlayerID]
					if otherPlayer:IsEverAlive() and otherPlayer:GetCivilizationType() == civilisationID then
						for otherCity in otherPlayer:Cities() do
							if otherCity:IsCoastal() and JFD_CheckCoastline(otherPlayerID, otherCity) then
								JFD_AddBuilding(otherPlayer, otherCity, buildingItalianProductionID, 1)
							else
								JFD_RemoveBuilding(otherPlayer, otherCity, buildingItalianProductionID)
							end
						end
					end
				end
			end
		end
	end
end

if JFD_IsCivilisationActive(civilisationID) then
	GameEvents.PlayerDoTurn.Add(JFD_ItalianProduction)
	GameEvents.CityCaptureComplete.Add(JFD_GoldenAgeCoastalCityCapture)
	GameEvents.PlayerCityFounded.Add(JFD_GoldenAgeCoastalCityFounded)
end
----------------------------------------------------------------------------------------------------------------------------
--JFD_CarabineiriResistance
----------------------------------------------------------------------------------------------------------------------------
local promotionCarabineriPolicingID = GameInfoTypes["PROMOTION_JFD_CARABINEIRI_POLICING"]

function JFD_CarabineiriResistance(playerID)
	local player = Players[playerID]
	if player:IsEverAlive() then
		for city in player:Cities() do
			local unit = city:GetGarrisonedUnit()
			if unit and city:GetResistanceTurns() > 0 then
				if unit:IsHasPromotion(promotionCarabineriPolicingID) then
					city:ChangeResistanceTurns(-1)
				end
			end
		end
	end
end

function JFD_CarabineiriResistanceInitialTrigger(playerID, unitID)
	local player = Players[playerID]
	local unit = player:GetUnitByID(unitID)
	if unit and unit:IsHasPromotion(promotionCarabineriPolicingID) then
		GameEvents.PlayerDoTurn.Add(JFD_CarabineiriResistance)
		Events.SerialEventUnitCreated.Remove(JFD_CarabineiriResistanceInitialTrigger)
		save("GAME", "JFD_CarabineiriResistanceInitalised", true)
		JFD_CarabineiriResistance(playerID)
	end
end

if load("GAME", "JFD_CarabineiriResistanceInitalised") then
	GameEvents.PlayerDoTurn.Add(JFD_CarabineiriResistance)
else
	Events.SerialEventUnitCreated.Add(JFD_CarabineiriResistanceInitialTrigger)
end
--==========================================================================================================================
--==========================================================================================================================