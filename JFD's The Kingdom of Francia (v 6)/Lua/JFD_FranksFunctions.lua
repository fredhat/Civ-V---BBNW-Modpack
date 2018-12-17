-- JFD_FranksFunction
-- Author: JFD
-- Heavily Edited By: F0S
--=======================================================================================================================
-- UTILITY FUNCTIONS
--=======================================================================================================================
WARN_NOT_SHARED = false; include( "Sukritact_SaveUtils.lua" ); MY_MOD_NAME = "JFD_FranksFunctions";
include("FLuaVector.lua")
--------------------------------------------------------------
-- JFD_IsCivilisationActive
--------------------------------------------------------------
local civilisationID = GameInfoTypes["CIVILIZATION_JFD_THE_FRANKS"]

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
-------------------------------------------------------------------------------------------------------------------------
-- GetStrongestMilitaryUnit
-------------------------------------------------------------------------------------------------------------------------
function GetStrongestMilitaryUnit(pPlayer, bIgnoreResources, ...)
	local tUnit = {["Combat"] = 0}
	for iKey, sCombatType in pairs(arg) do
		for row in GameInfo.Units("CombatClass = \'" .. sCombatType .. "\'") do
			if pPlayer:CanTrain(row.ID, bIgnoreResources) and row.Combat > tUnit.Combat then
				tUnit = row
			end
		end
	end
	return tUnit.ID
end
--==========================================================================================================================
-- CORE FUNCTIONS
--==========================================================================================================================
--JFD_CharlemagnesPiety
----------------------------------------------------------------------------------------------------------------------------
local iMod = GameInfo.GameSpeeds[Game.GetGameSpeedType()].GoldPercent

function JFD_CharlemagnePiety(oldOwnerID, isCapital, iX, iY, newOwnerID, iPop, bConquest)
	local player = Players[newOwnerID]
	if player:IsEverAlive() and player:GetCivilizationType() == civilisationID then
		if oldOwnerID ~= newOwnerID then
			local city = Map.GetPlot(iX, iY):GetPlotCity()
			if city then
				local faithReward = (iMod * iPop)
				if not isCapital then
					faithReward = math.floor(faithReward / 2)
				end
				player:ChangeFaith(faithReward)
				if player:IsHuman() and player:IsTurnActive() and faithReward > 0 then
					local hex = ToHexFromGrid(Vector2(iX, iY))
					Events.AddPopupTextEvent(HexToWorld(hex), Locale.ConvertTextKey("[COLOR_WHITE]+{1_Num}[ENDCOLOR][ICON_PEACE]", faithReward), 1)
					Events.GameplayFX(hex.x, hex.y, -1)
				end
			end
		end
	end
end
----------------------------------------------------------------------------------------------------------------------------
--JFD_ProphetFreePolicies
----------------------------------------------------------------------------------------------------------------------------
local missionFreePolicyID = GameInfoTypes["MISSION_PROPHET_FREE_POLICY"]
local unitclassProphetlID = GameInfoTypes["UNITCLASS_PROPHET"]

--JFD_ProphetFreePolicies_MissionPossible
function JFD_ProphetFreePolicies_MissionPossible(playerID, unitID, missionID, data1, data2, _, _, plotX, plotY, bTestVisible)
	if missionID == missionFreePolicyID then
		local player = Players[playerID]
		if player:IsEverAlive() and player:GetCivilizationType() == civilisationID then
			local unit = player:GetUnitByID(unitID)
			if unit and unit:GetUnitClassType() == unitclassProphetlID then
				return (unit:GetSpreadsLeft() >= 4)
			end
		end
	end
	return false
end

--JFD_ProphetFreePolicies_MissionStart
function JFD_ProphetFreePolicies_MissionStart(playerID, unitID, missionID, data1, data2, flags, turn)
	local player = Players[playerID]
	if missionID == missionFreePolicyID then
		if player:IsEverAlive() then
			if player:IsHuman() and player:IsTurnActive() then
				local decriptionShort = Locale.ConvertTextKey('TXT_KEY_JFD_FREE_POLICY_SHORT')
				local description = Locale.ConvertTextKey('TXT_KEY_JFD_FREE_POLICY_DESC')
				player:AddNotification(NotificationTypes["NOTIFICATION_FREE_POLICY"], description, decriptionShort)
			end
			player:ChangeNumFreePolicies(1)
			return CUSTOM_MISSION_ACTION
		end
	end
	return CUSTOM_MISSION_NO_ACTION
end

--JFD_ProphetFreePolicies_MissionCompleted
function JFD_ProphetFreePolicies_MissionCompleted(playerID, unitID, missionID, data1, data2, flags, turn)
	local player = Players[playerID]
	if missionID == missionFreePolicyID then
		if player:IsEverAlive() then
			local unit = player:GetUnitByID(unitID)
			if unit then
				unit:Kill(true, -1)
				return true
			end
		end
	end
	return false
end

if JFD_IsCivilisationActive(civilisationID) then
	GameEvents.CityCaptureComplete.Add(JFD_CharlemagnePiety)
	GameEvents.CustomMissionPossible.Add(JFD_ProphetFreePolicies_MissionPossible)
	GameEvents.CustomMissionStart.Add(JFD_ProphetFreePolicies_MissionStart)
	GameEvents.CustomMissionCompleted.Add(JFD_ProphetFreePolicies_MissionCompleted)
end
----------------------------------------------------------------------------------------------------------------------------
--JFD_CharlemagnesSiegeUnits
----------------------------------------------------------------------------------------------------------------------------
local improvementSiegeUnitID = GameInfoTypes["IMPROVEMENT_JFD_SIEGE_UNIT"]
local unitPaladinID = GameInfoTypes["UNIT_JFD_PALADIN"]

function JFD_CharlemagnesSiegeUnits(playerID, iX, iY, improvementID)
	local player = Players[playerID]
    if player:IsEverAlive() then 
		if improvementID == improvementSiegeUnitID then
			local plot = Map.GetPlot(iX, iY)
			if plot then
				local unitID = GetStrongestMilitaryUnit(player, false, "UNITCOMBAT_SIEGE")
				plot:SetImprovementType(-1)
				player:InitUnit(unitID, iX, iY, UNITAI_CITY_BOMBARD)
			end
		end
	end
end

function JFD_CharlemagnesSiegeUnitsInitialTrigger(playerID, unitID)
	local player = Players[playerID]
	local unit = player:GetUnitByID(unitID)
	if unit and unit:GetUnitType() == unitPaladinID then
		GameEvents.BuildFinished.Add(JFD_CharlemagnesSiegeUnits)
		Events.SerialEventUnitCreated.Remove(JFD_CharlemagnesSiegeUnitsInitialTrigger)
		save("GAME", "JFD_CharlemagnesSiegeUnitsInitalised", true)
	end
end

if load("GAME", "JFD_CharlemagnesSiegeUnitsInitalised") then
	GameEvents.BuildFinished.Add(JFD_CharlemagnesSiegeUnits)
else
	Events.SerialEventUnitCreated.Add(JFD_CharlemagnesSiegeUnitsInitialTrigger)
end
--=======================================================================================================================================================================================
--=======================================================================================================================================================================================