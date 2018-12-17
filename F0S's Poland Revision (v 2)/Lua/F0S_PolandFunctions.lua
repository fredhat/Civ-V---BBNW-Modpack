-- F0S_PolandFunctions
-- Author: F0S
--=======================================================================================================================
-- UTILITY FUNCTIONS
--==========================================================================================================================
-- JFD_IsCivilisationActive
--------------------------------------------------------------
WARN_NOT_SHARED = false; include( "Sukritact_SaveUtils.lua" ); MY_MOD_NAME = "F0S_PolandFunctions";
local civilisationID = GameInfoTypes["CIVILIZATION_POLAND"]

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
-- CORE POLAND FUNCTIONS	
--=======================================================================================================================
function PolandPolicies()
	for playerID, player in pairs(Players) do
		local player = Players[playerID]
		if player:IsEverAlive() and player:GetCivilizationType() == civilisationID then
			local playerEra = load(player, "CurrentEra")
			if playerEra == nil then
				playerEra = 0
			end
			local actualPlayerEra = player:GetCurrentEra()
			if actualPlayerEra > playerEra then
				if actualPlayerEra > 1 then
					if player:IsHuman() and player:IsTurnActive() then
						local decriptionShort = Locale.ConvertTextKey('TXT_KEY_F0S_POLISH_POLICY_SHORT')
						local description = Locale.ConvertTextKey('TXT_KEY_F0S_POLISH_POLICY_DESC')
						player:AddNotification(NotificationTypes["NOTIFICATION_FREE_POLICY"], description, decriptionShort)
					end
					player:ChangeNumFreePolicies(1)
				end
			end
			save(player, "CurrentEra", actualPlayerEra)
		end
	end
end

if JFD_IsCivilisationActive(civilisationID) then
	Events.TechAcquired.Add(PolandPolicies)
end
--==========================================================================================================================
--==========================================================================================================================