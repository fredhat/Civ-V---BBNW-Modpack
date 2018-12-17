-- JFD_CoreFunctions
-- Author: JFD
-- Edited By: F0S
--==========================================================================================================================
-- UTILITY FUNCTIONS
--==========================================================================================================================
-- JFD_IsCivilisationActive
--------------------------------------------------------------
local civilisationID = GameInfoTypes["CIVILIZATION_JFD_SWITZERLAND"]

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
--  JFD_GetGoldFromDoF
--------------------------------------------------------------------------------------------------------------------------
function JFD_GetGoldFromDoF(playerID)
	local player = Players[playerID]
	local goldBoost = 0
	for iPlayer = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
		local otherPlayer = Players[iPlayer]
		if otherPlayer:IsEverAlive() and iPlayer ~= playerID then
			if Teams[player:GetTeam()]:IsHasMet(otherPlayer:GetTeam()) then
				if not otherPlayer:IsDoF(playerID) and not otherPlayer:IsDenouncedPlayer(playerID) and not otherPlayer:IsDenouncingPlayer(playerID) and not Teams[otherPlayer:GetTeam()]:IsAtWar(player:GetTeam()) then
					local otherPlayerGold = otherPlayer:CalculateGoldRate()
					goldBoost = goldBoost + math.floor(otherPlayerGold * 33/100)
				end
			end
		end
	end
	return goldBoost
end
--------------------------------------------------------------------------------------------------------------------------
--JFD_NeutralCityStates
----------------------------------------------------------------------------------------------------------------------------
function JFD_NeutralCityStates(teamID, otherTeamID)
	local player = Players[Teams[teamID]:GetLeaderID()]
	local otherPlayer = Players[Teams[otherTeamID]:GetLeaderID()]
	if player:IsEverAlive() and player:IsMinorCiv() and otherPlayer:IsEverAlive() and otherPlayer:GetCivilizationType() == civilisationID then
		Teams[otherTeamID]:MakePeace(teamID)
		player:ChangeMinorCivFriendshipWithMajor(otherPlayer:GetID(), 1)
	end
end

function OnNotificationAdded(iNotificationId, iNotificationType, sHeader, sSummary, iData1, iData2, iPlayer)
	if Players[iPlayer]:GetCivilizationType() == civilisationID and sSummary == Locale.ConvertTextKey("TXT_KEY_MISC_MINOR_ALLIES_DECLARED_WAR_ON_YOU_SUMMARY") then
		UI.RemoveNotification(iNotificationId)
	end
end
----------------------------------------------------------------------------------------------------------------------------
-- JFD_SwissManpower
----------------------------------------------------------------------------------------------------------------------------
function JFD_SwissManpower(playerID, isTurn)
	local player = Players[playerID]
	if player:IsEverAlive() then
		if not player:IsMinorCiv() and not player:IsBarbarian() then
			local numManpower = player:GetNumResourceTotal(GameInfoTypes["RESOURCE_JFD_MANPOWER"], true)
			for city in player:Cities() do
				if player:GetCivilizationType() == civilisationID then
					city:SetNumRealBuilding(GameInfoTypes["BUILDING_JFD_SWISS_MANPOWER_HANDICAP"], math.min(10, numManpower))
					local goldBoost = JFD_GetGoldFromDoF(playerID)
					local pCapital = player:GetCapitalCity()
					if goldBoost > 0 and pCapital then
						pCapital:SetNumRealBuilding(GameInfoTypes["BUILDING_JFD_SWISS_GOLD"], goldBoost)
						if isTurn then
							player:ChangeGold(goldBoost)
						end
					else
						pCapital:SetNumRealBuilding(GameInfoTypes["BUILDING_JFD_SWISS_GOLD"], 0)
					end
				else
					city:SetNumRealBuilding(GameInfoTypes["BUILDING_JFD_SWISS_MANPOWER"], math.min(5, numManpower))
				end
			end
		end
	end
end

function JFD_SwissManpowerTurn(playerID)
    JFD_SwissManpower(playerID,true)
end

function JFD_SwissManpowerDirty()
	local iPlayer = Game.GetActivePlayer()
    local pPlayer = Players[iPlayer]
	if pPlayer:IsTurnActive() then
        JFD_SwissManpower(iPlayer,false)
    end
end

if JFD_IsCivilisationActive(civilisationID) then
	GameEvents.DeclareWar.Add(JFD_NeutralCityStates)
	Events.NotificationAdded.Add(OnNotificationAdded)
	GameEvents.PlayerDoTurn.Add(JFD_SwissManpowerTurn)
	Events.SerialEventGameDataDirty.Add(JFD_SwissManpowerDirty)
end
--=======================================================================================================================================================================================
--=======================================================================================================================================================================================