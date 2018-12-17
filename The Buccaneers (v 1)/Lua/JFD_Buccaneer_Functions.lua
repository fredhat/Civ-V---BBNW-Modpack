-- JFD_Buccaneer_Functions
-- Author: JFD
-- Edited By: F0S
--==========================================================================================================================
include("FLuaVector.lua")
--==========================================================================================================================
-- UTILITIES
--==========================================================================================================================
-- JFD_IsCivilisationActive
----------------------------------------------------------------------------------------------------------------------------
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
--==========================================================================================================================
-- CORE FUNCTIONS
--==========================================================================================================================
-- JFD_InitPirates
----------------------------------------------------------------------------------------------------------------------------
local policyGoldFromKillsID = GameInfoTypes["POLICY_JFD_BUCCANEER_GOLD_FROM_KILLS"]

function JFD_InitPirates()
	for iPlayer=0, GameDefines.MAX_CIV_PLAYERS - 1 do
		local player = Players[iPlayer]
		if player:IsEverAlive() and player:GetCivilizationType() == civilisationID then
			if not player:HasPolicy(policyGoldFromKillsID) then
				player:SetNumFreePolicies(player:GetNumFreePolicies() + 1)
				player:SetNumFreePolicies(player:GetNumFreePolicies() - 1)
				player:SetHasPolicy(policyGoldFromKillsID, true)	
			end
		end
	end
end
----------------------------------------------------------------------------------------------------------------------------	
-- JFD_GoldFromCityCapture
----------------------------------------------------------------------------------------------------------------------------	
function JFD_GoldFromCityCapture(oldOwnerID, isCapital, cityX, cityY, newOwnerID, population, isConquest)
	local player = Players[newOwnerID]
	local capturedPlayer = Players[oldOwnerID]
	if player:IsEverAlive() and player:GetCivilizationType() == civilisationID then
		local plot = Map.GetPlot(cityX, cityY)
		if plot then
			local city = plot:GetPlotCity()
			if city and isConquest then
				local goldPillaged = math.floor(city:GetBaseYieldRate(YieldTypes.YIELD_GOLD) * 50 / 100) + 50
				player:ChangeGold(goldPillaged)
				if player:IsHuman() and player:IsTurnActive() then
					local hex = ToHexFromGrid(Vector2(cityX, cityY))
					Events.AddPopupTextEvent(HexToWorld(hex), Locale.ConvertTextKey("[COLOR_YELLOW]+{1_Num}[ENDCOLOR] [ICON_GOLD]", goldPillaged), 1)
					Events.GameplayFX(hex.x, hex.y, -1)
				end
			end
		end
	end
end

if JFD_IsCivilisationActive(civilisationID) then
	Events.SequenceGameInitComplete.Add(JFD_InitPirates)
	GameEvents.CityCaptureComplete.Add(JFD_GoldFromCityCapture)
end
--==========================================================================================================================
--==========================================================================================================================