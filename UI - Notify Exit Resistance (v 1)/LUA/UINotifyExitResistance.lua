-- UINotifyExitResistance
-- Author: William Howard
-- Edited By: F0S
--==========================================================================================================================
local g_NotificationType = NotificationTypes.NOTIFICATION_GENERIC
----------------------------------------------------------------------------------------------------------------------------
-- OnCityResistanceNotificationId
----------------------------------------------------------------------------------------------------------------------------
function OnCityResistanceNotificationId(id)
	g_NotificationType = id
end

LuaEvents.CityResistanceNotificationId.Add(OnCityResistanceNotificationId)
----------------------------------------------------------------------------------------------------------------------------
-- NotifyCitiesExitedResistance
----------------------------------------------------------------------------------------------------------------------------
local cityResistanceCache = {}

function NotifyCitiesExitedResistance(iPlayer)
	local pPlayer = Players[iPlayer]
	local cache = cityResistanceCache[iPlayer] or {}
	for _, iCity in ipairs(cache) do
		local pCity = pPlayer:GetCityByID(iCity)
		if pCity and not pCity:IsResistance() then
			local sHeading = Locale.ConvertTextKey("TXT_KEY_CITY_NOTIFICATIONS_RESISTANCE_HEADING", pCity:GetName())
			local sMessage = Locale.ConvertTextKey("TXT_KEY_CITY_NOTIFICATIONS_RESISTANCE_TEXT", pCity:GetName())
			pPlayer:AddNotification(g_NotificationType, sMessage, sHeading, pCity:GetX(), pCity:GetY(), pCity:GetOwner(), pCity:GetID())
		end
	end
end

function CacheCitiesInResistance(iPlayer)
	local pPlayer = Players[iPlayer]
	local cache = {}
	for pCity in pPlayer:Cities() do
		if pCity:IsResistance() then
			table.insert(cache, pCity:GetID())
		end
	end
	cityResistanceCache[iPlayer] = cache
end

function OnPlayerDoTurn(iPlayer)
	local pPlayer = Players[iPlayer]
	if pPlayer:IsEverAlive() and pPlayer:IsHuman() then
		NotifyCitiesExitedResistance(iPlayer)
		CacheCitiesInResistance(iPlayer)
	end
end

GameEvents.PlayerDoTurn.Add(OnPlayerDoTurn)

for iPlayer = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
	local pPlayer = Players[iPlayer]
	if pPlayer:IsEverAlive() and pPlayer:IsHuman() then
		CacheCitiesInResistance(iPlayer)
	end
end

LuaEvents.CityResistanceNotificationIdRequest()
--==========================================================================================================================
--==========================================================================================================================