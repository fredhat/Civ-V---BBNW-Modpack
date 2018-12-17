-- ManutaraScripts
-- Author: Leugi
-- Edited By: F0S
--=======================================================================================================================
WARN_NOT_SHARED = false; include( "Sukritact_SaveUtils.lua" ); MY_MOD_NAME = "ManutaraScripts";
--=======================================================================================================================
-- Utility Functions
--=======================================================================================================================
-- JFD_IsCivilisationActive
-------------------------------------------------------------------------------------------------------------------------
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
-- TangataManify
--=======================================================================================================================
local unitMatatoaID = GameInfoTypes["UNIT_MC_RAPA_NUI_MATATOA"]
local unitTangatuManuID = GameInfoTypes["UNIT_MC_RAPA_NUI_TANGATA_MANU"]
local improvementManutaraID = GameInfoTypes["IMPROVEMENT_MANUTARA_SITE"]
local resourceManutaraID = GameInfoTypes["RESOURCE_MANUTARA_EGG"]
local civilisationID = GameInfoTypes["CIVILIZATION_MC_RAPA_NUI"]

function TangataManify(playerID, plotX, plotY, improvementID)
	local player = Players[playerID]
	if player:IsEverAlive() then
		for unit in player:Units() do
			if unit and unit:GetUnitType() == unitMatatoaID then
				local plot = unit:GetPlot()
				if plot and plot == Map.GetPlot(plotX, plotY) and improvementID == improvementManutaraID then
					if plot:GetNumResource() > 1 then
						plot:SetImprovementType(-1)
						if player:IsHuman() and player:IsTurnActive() then
							local title = Locale.ConvertTextKey("TXT_KEY_NOTIFICATION_NOEGG_TITLE")
							local descr = Locale.ConvertTextKey("TXT_KEY_NOTIFICATION_NOEGG")
							player:AddNotification(NotificationTypes.NOTIFICATION_GENERIC, descr, title, plotX, plotY)
						end
					else
						local newUnit = player:InitUnit(unitTangatuManuID, unit:GetX(), unit:GetY(), UNITAI_RANGED)
						newUnit:Convert(unit)
						plot:SetImprovementType(-1)
						plot:SetResourceType(resourceManutaraID, 1)
						if player:IsHuman() and player:IsTurnActive() then
							local title =  Locale.ConvertTextKey("TXT_KEY_MC_TANGATAMANU_ALERT_TITLE")
							local descr =  Locale.ConvertTextKey("TXT_KEY_MC_TANGATAMANU_ALERT")
							player:AddNotification(NotificationTypes.NOTIFICATION_GENERIC, descr, title, plotX, plotY)
						end
					end
				end
			end
		end
	end
end

function ManutaraScriptsInitialTrigger(playerID, unitID)
	local player = Players[playerID]
	local unit = player:GetUnitByID(unitID)
	if unit and unit:GetUnitType() == unitMatatoaID then
		GameEvents.BuildFinished.Add(TangataManify)
		Events.SerialEventUnitCreated.Remove(ManutaraScriptsInitialTrigger)
		save("GAME", "ManutaraScriptsInitalised", true)
	end
end

if load("GAME", "ManutaraScriptsInitalised") then
	GameEvents.BuildFinished.Add(TangataManify)
else
	Events.SerialEventUnitCreated.Add(ManutaraScriptsInitialTrigger)
end
--=======================================================================================================================
--=======================================================================================================================