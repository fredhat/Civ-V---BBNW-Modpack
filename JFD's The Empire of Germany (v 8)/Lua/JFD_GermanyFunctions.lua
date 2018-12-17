-- Bismarckian Germany Functions
-- Author: JFD
-- Heavily Edited By: F0S
--=======================================================================================================================
-- UTILITY FUNCTIONS	
--=======================================================================================================================
-- JFD_IsCivilisationActive
------------------------------------------------------------------------------------------------------------------------
WARN_NOT_SHARED = false; include( "Sukritact_SaveUtils.lua" ); MY_MOD_NAME = "JFD_GermanyFunctions";

local civilisationID = GameInfoTypes["CIVILIZATION_GERMANY"]

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
-- JFD_CityStateConquests
----------------------------------------------------------------------------------------------------------------------------
local buildingBismarckDelegateID = GameInfoTypes["BUILDING_JFD_BISMARCK_DELEGATE"]

function JFD_CityStateConquests(oldOwnerID, isCapital, cityX, cityY, newOwnerID, pop, isConquest)
	local player = Players[newOwnerID]
	local capturedPlayer = Players[oldOwnerID]
	if player:IsEverAlive() and capturedPlayer:IsEverAlive() and player:GetCivilizationType() == civilisationID and isConquest then
		local cityPlot = Map.GetPlot(cityX, cityY)
		if cityPlot then
			local city = cityPlot:GetPlotCity()
			if city and city:IsOriginalCapital() and capturedPlayer:IsMinorCiv() then
				if not city:IsHasBuilding(buildingBismarckDelegateID) then
					city:SetNumRealBuilding(buildingBismarckDelegateID, 1)
				end
				if load(cityPlot, "BismarckPolicy") == nil then
					if player:IsHuman() and player:IsTurnActive() then
						local decriptionShort = Locale.ConvertTextKey('TXT_KEY_JFD_FREE_POLICY_GERMANY_SHORT')
						local description = Locale.ConvertTextKey('TXT_KEY_JFD_FREE_POLICY_GERMANY_DESC')
						player:AddNotification(NotificationTypes["NOTIFICATION_FREE_POLICY"], description, decriptionShort)
					end
					player:ChangeNumFreePolicies(1)
					save(cityPlot, "BismarckPolicy", 1)
				end
				city:ChangeResistanceTurns(-1 * math.floor(city:GetResistanceTurns()))
			end
		end
	end
end

if JFD_IsCivilisationActive(civilisationID) then
	GameEvents.CityCaptureComplete.Add(JFD_CityStateConquests)
end
--==========================================================================================================================
--==========================================================================================================================