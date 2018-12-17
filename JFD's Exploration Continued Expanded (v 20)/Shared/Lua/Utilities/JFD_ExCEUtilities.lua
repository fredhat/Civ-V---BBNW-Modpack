-- JFD_ExCEUtilities
-- Author: JFD
-- Edited By: F0S
--==========================================================================================================================
-- INCLUDES
--==========================================================================================================================
include("PlotIterators.lua")
--=======================================================================================================================
-- GENERAL UTILITIES
--=======================================================================================================================
-- GET UTILITIES
--------------------------------------------------------------------------------------------------------------------------
-- JFD_GetRandom
function JFD_GetRandom(lower, upper)
	return Game.Rand((upper + 2) - lower, "") + lower
end

-- GetStrongestMilitaryUnit (Sukritact)
function GetStrongestMilitaryUnit(pPlayer, bIgnoreResources, ...)
	local tUnit = {["ID"] = GameInfoTypes.UNIT_WARRIOR, ["Combat"] = 0}
	for iKey, sCombatType in pairs(arg) do
		for row in GameInfo.Units("CombatClass = \'" .. sCombatType .. "\'") do
			if pPlayer:CanTrain(row.ID, bIgnoreResources) and row.Combat > tUnit.Combat then
				tUnit = row
			end
		end
	end
	return tUnit.ID
end
--------------------------------------------------------------------------------------------------------------------------
-- SET UTILITIES
--------------------------------------------------------------------------------------------------------------------------
-- JFD_AddPromotion
function JFD_AddPromotion(unit, promotionID, addsPromotion)
	if addsPromotion then
		if not unit:IsHasPromotion(promotionID) then
			unit:SetHasPromotion(promotionID, true)
		end
	else
		if unit:IsHasPromotion(promotionID) then
			unit:SetHasPromotion(promotionID, false)
		end
	end
end

-- JFD_GetUniqueUnit
function JFD_GetUniqueUnit(player, unitClass)
	local unitType = nil
	local civType = GameInfo.Civilizations[player:GetCivilizationType()].Type
	for uniqueUnit in GameInfo.Civilization_UnitClassOverrides{CivilizationType = civType, UnitClassType = unitClass} do
		unitType = uniqueUnit.UnitType
		break
	end
	if unitType == nil then
		unitType = GameInfo.UnitClasses[unitClass].DefaultUnit
	end
	return unitType
end

-- JFD_SendNotification
function JFD_SendNotification(playerID, notificationType, description, descriptionShort, global, data1, data2, unitID, data3, metOnly, includesSerialMessage)
	local player = Players[playerID]
	local data1 = data1 or -1
	local data2 = data2 or -1
	local unitID = unitID or -1
	local data3 = data3 or -1
	local sendNotification = false
	local sendSerialMessage = false
	if global then
		if metOnly then
			if Teams[Game.GetActiveTeam()]:IsHasMet(player:GetTeam()) then
				sendNotification = true
			end
		else
			sendNotification = true
		end
	else
		if player:IsHuman() then
			if metOnly then
				if Teams[Game.GetActiveTeam()]:IsHasMet(player:GetTeam()) then
					sendNotification = true
				end
			else
				sendNotification = true
			end
		end
	end
	if sendNotification then
		Players[Game.GetActivePlayer()]:AddNotification(NotificationTypes[notificationType], description, descriptionShort, data1, data2, unitID, data3)
		if includesSerialMessage then
			Events.GameplayAlertMessage(description)
		end
	end
end   

-- JFD_SendWorldEvent
function JFD_SendWorldEvent(playerID, description)
	local player = Players[playerID]
	local playerTeam = Teams[player:GetTeam()]
	local activePlayer = Players[Game.GetActivePlayer()]
	if not player:IsHuman() and playerTeam:IsHasMet(activePlayer:GetTeam()) then
		Players[Game.GetActivePlayer()]:AddNotification(NotificationTypes["NOTIFICATION_DIPLOMACY_DECLARATION"], description, "[COLOR_POSITIVE_TEXT]World Events[ENDCOLOR]", -1, -1)
	end
end 
----=======================================================================================================================
----=======================================================================================================================