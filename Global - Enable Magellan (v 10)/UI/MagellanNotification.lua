-- MagellanNotification
-- Original Author: William Howard
--------------------------------------------------------------
-- Custom notification for circumnavigation
include("IconSupport")

local Magellan = {
	label = "TXT_KEY_MAGELLAN_NOTIFICATIONS", 
	key = "MAGELLAN_NOTIFICATIONS", 
	item = "Magellan",
	show = true, 
	ui = true, 
}

function OnMagellanNotification(cbData)
	local instance = {}
	ContextPtr:BuildInstanceForControl("MagellanItem", instance, cbData.parent)
	cbData.instance = instance
end
Magellan.callback = OnMagellanNotification

function OnMagellanNotificationIdRequest()
	if (Magellan.id ~= nil) then
		LuaEvents.MagellanNotificationId(Magellan.id)
	end
end
LuaEvents.MagellanNotificationIdRequest.Add(OnMagellanNotificationIdRequest)

function Register()
	LuaEvents.CustomNotificationAddin(Magellan)
	OnMagellanNotificationIdRequest()
end
Register()