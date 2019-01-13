-- JFD_Turks_Functions
-- Author: JFD
-- Heavily Edited By: F0S
--==========================================================================================================================
-- UTILITY FUNCTIONS
--==========================================================================================================================
-- JFD_IsCivilisationActive
--------------------------------------------------------------------------------------------------------------------------
WARN_NOT_SHARED = false; include( "Sukritact_SaveUtils.lua" ); MY_MOD_NAME = "JFD_Turks_Functions";

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

-- GetRandom
function GetRandom(lower, upper)
    return (Game.Rand((upper + 1) - lower, "")) + lower
end
--==========================================================================================================================
-- GLOBALS
--==========================================================================================================================
-- GLOBALS
----------------------------------------------------------------------------------------------------------------------------
local civilizationID = GameInfoTypes["CIVILIZATION_JFD_TURKS"]
local isCivTurksActive = JFD_IsCivilisationActive(civilizationID)
--==========================================================================================================================
-- UA FUNCTIONS
--==========================================================================================================================
-- TRIBUTE IN BLOOD
----------------------------------------------------------------------------------------------------------------------------
-- JFD_Turks_Init
local policyTurksID = GameInfoTypes["POLICY_JFD_TURKS"]

function JFD_Turks_Init()
	for playerID = 0, GameDefines.MAX_MAJOR_CIVS - 1 do
		local player = Players[playerID]
		if player:IsEverAlive() and player:GetCivilizationType() == civilizationID then
			if not player:HasPolicy(policyTurksID) then
				player:SetNumFreePolicies(player:GetNumFreePolicies() + 1)
				player:SetNumFreePolicies(player:GetNumFreePolicies() - 1)
				player:SetHasPolicy(policyTurksID, true)
			end
		end
	end 
end

-- JFD_Turks_GPOnConquest
function JFD_Turks_GPOnConquest(oldOwnerID, capital, plotX, plotY, newOwnerID)
	local player = Players[newOwnerID]
	if player:IsEverAlive() and player:GetCivilizationType() == civilizationID then
		local plot = Map.GetPlot(plotX, plotY)
		if plot then
			local city = plot:GetPlotCity()
			if city then
				local cityOriginalOwnerID = city:GetOriginalOwner()
				local previousOwner = Players[oldOwnerID]
				if cityOriginalOwnerID ~= newOwnerID and not previousOwner:IsMinorCiv() then
					if load(plot, "TributeInBlood") == nil then
						local tableGreatPeople = {}
						for row in GameInfo.Units("Special = \'" .. GameInfo.SpecialUnits.SPECIALUNIT_PEOPLE.Type .. "\'") do
							table.insert(tableGreatPeople, row.ID)
						end
						if #tableGreatPeople > 0 then
							local randomGreatPersonID = tableGreatPeople[GetRandom(1, #tableGreatPeople)]
							local newUnit = player:InitUnit(randomGreatPersonID, plotX, plotY)
							newUnit:JumpToNearestValidPlot()
							if player:IsHuman() and player:IsTurnActive() then
								local description = Locale.ConvertTextKey('TXT_KEY_JFD_RANDOM_GP')
								local descriptionShort = Locale.ConvertTextKey("TXT_KEY_JFD_RANDOM_GP_SHORT")
								player:AddNotification(NotificationTypes["NOTIFICATION_GREAT_PERSON_ACTIVE_PLAYER"], description, descriptionShort, newUnit:GetX(), newUnit:GetY(), randomGreatPersonID, -1)
							end
							save(plot, "TributeInBlood", 1)
						end
					end
				end
			end
		end
	end
end

if isCivTurksActive then
	Events.LoadScreenClose.Add(JFD_Turks_Init)
	GameEvents.CityCaptureComplete.Add(JFD_Turks_GPOnConquest)
end
--==========================================================================================================================
--==========================================================================================================================