-- GlobalEnableMagellan
-- Original Author: William Howard
--------------------------------------------------------------
local g_NotificationType = NotificationTypes.NOTIFICATION_GENERIC

function OnMagellanNotificationId(id)
	g_NotificationType = id
end
LuaEvents.MagellanNotificationId.Add(OnMagellanNotificationId)

function OnCircumnavigatedGlobe(iTeam)
	local pPlayer = Players[Game.GetActivePlayer()]
	local sHead = Locale.ConvertTextKey("TXT_KEY_MAGELLAN_HEAD")
	local sText = Locale.ConvertTextKey("TXT_KEY_MAGELLAN_TEXT_UNKNOWN")
	if Game.GetActiveTeam() == iTeam then
		sText = Locale.ConvertTextKey("TXT_KEY_MAGELLAN_TEXT_YOU")
	else
		if Teams[Game.GetActiveTeam()]:IsHasMet(iTeam) then
			local otherPlayer = Players[Teams[iTeam]:GetLeaderID()]
			sText = Locale.ConvertTextKey("TXT_KEY_MAGELLAN_TEXT_KNOWN", otherPlayer:GetName(), otherPlayer:GetCivilizationShortDescriptionKey())
		end
	end
	pPlayer:AddNotification(g_NotificationType, sText, sHead, -1, -1, -1, -1)
end
GameEvents.CircumnavigatedGlobe.Add(OnCircumnavigatedGlobe)

LuaEvents.MagellanNotificationIdRequest()