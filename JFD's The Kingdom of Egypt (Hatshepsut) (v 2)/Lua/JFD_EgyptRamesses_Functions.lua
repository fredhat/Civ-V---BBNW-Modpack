-- JFD_EgyptRamesses_Functions
-- Author: JFD
-- Edited By: F0S
--==========================================================================================================================
-- INCLUDES
--==========================================================================================================================
WARN_NOT_SHARED = false; include( "Sukritact_SaveUtils.lua" ); MY_MOD_NAME = "JFD_JFD_EgyptRamesses";
include("FLuaVector.lua")
--==========================================================================================================================
-- UTILITY FUNCTIONS
--==========================================================================================================================
-- GLOBALS
----------------------------------------------------------------------------------------------------------------------------
local civilisationID = GameInfoTypes["CIVILIZATION_EGYPT"]

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
--==========================================================================================================================
-- UNIQUE FUNCTIONS
--==========================================================================================================================
-- WORKS OF OZYMANDIUS
----------------------------------------------------------------------------------------------------------------------------
local buildingRamessesID = GameInfoTypes["BUILDING_JFD_EGYPT_RAMESSES"]
local iModifier = ((GameInfo.GameSpeeds[Game.GetGameSpeedType()].GoldPercent)/300)

function JFD_WorksOfOzymandias(playerID)
	local player = Players[playerID]
	if player:IsEverAlive() and player:GetCivilizationType() == civilisationID then
		for city in player:Cities() do
			if not city:HasBuilding(buildingRamessesID) then
				city:SetNumRealBuilding(buildingRamessesID, 1)
			end
		end
	end
end

function JFD_WorksOfOzymandias_CityCaptureComplete(oldOwnerID, capital, plotX, plotY, newOwnerID)
	local player = Players[newOwnerID]
	if player:IsEverAlive() and player:GetCivilizationType() == civilisationID then
		local city = Map.GetPlot(plotX, plotY):GetPlotCity()
		if not city:HasBuilding(buildingRamessesID) then
			city:SetNumRealBuilding(buildingRamessesID, 1)
		end
		local cityOriginalOwnerID = city:GetOriginalOwner()
		local previousOwner = Players[oldOwnerID]
		if cityOriginalOwnerID ~= newOwnerID and not previousOwner:IsMinorCiv() then
			if load(Map.GetPlot(plotX, plotY),"WorksOfOzymandias") == nil then
				for playerCity in player:Cities() do
					local rewardProduction = math.floor(300 * iModifier) + (math.floor(30 * iModifier) * playerCity:GetPopulation())
					playerCity:ChangeProduction(rewardProduction)
					if player:IsHuman() and player:IsTurnActive() then
						local hex = ToHexFromGrid(Vector2(playerCity:GetX(), playerCity:GetY()))
						Events.AddPopupTextEvent(HexToWorld(hex), Locale.ConvertTextKey("[COLOR_POSITIVE_TEXT]+{1_Num}[ENDCOLOR][ICON_PRODUCTION]", rewardProduction), 1)
						Events.GameplayFX(hex.x, hex.y, -1)
					end
				end
				save(Map.GetPlot(plotX, plotY),"WorksOfOzymandias",1)
			end
		end
	end
end

if JFD_IsCivilisationActive(civilisationID) then
	GameEvents.PlayerDoTurn.Add(JFD_WorksOfOzymandias)
	GameEvents.PlayerCityFounded.Add(JFD_WorksOfOzymandias)
	GameEvents.CityCaptureComplete.Add(JFD_WorksOfOzymandias_CityCaptureComplete)	
end
--==========================================================================================================================
--==========================================================================================================================