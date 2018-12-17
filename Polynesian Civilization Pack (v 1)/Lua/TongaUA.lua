-- TongaUA
-- Author: JFD
-- Heavily Edited By: F0S
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
-------------------------------------------------------------------------------------------------------------------------
-- JFD_GetRandom
-------------------------------------------------------------------------------------------------------------------------
function GetRandom(lower, upper)
	return Game.Rand((upper + 1) - lower, "") + lower
end
 --=======================================================================================================================
-- InitTonga
--=======================================================================================================================
local civilisationID = GameInfoTypes["CIVILIZATION_MC_TONGA"]
local policyTongaID = GameInfoTypes["POLICY_TONGA_UA"]

function InitTonga(player)
	for playerID, player in pairs(Players) do
		local player = Players[playerID]
		if player:IsEverAlive() and player:GetCivilizationType() == civilisationID then
			if not player:HasPolicy(policyTongaID) then
				player:SetNumFreePolicies(player:GetNumFreePolicies() + 1)
				player:SetNumFreePolicies(player:GetNumFreePolicies() - 1)
				player:SetHasPolicy(policyTongaID, true)	
			end
		end
	end 
end
--=======================================================================================================================
-- JFD_TongaUA
--=======================================================================================================================
local iModifier = ((GameInfo.GameSpeeds[Game.GetGameSpeedType()].GoldPercent)/100)

function JFD_TongaUA(playerMetID, playerID)
	local player = Players[playerID]
	local playerMet = Players[playerMetID]
	if player:IsEverAlive() and playerMet:IsEverAlive() and player:GetCivilizationType() == civilisationID then
		local reward = math.floor(iModifier * 15)
		if not playerMet:IsMinorCiv() then reward = reward * 2 end
		if Teams[playerMet:GetTeam()]:GetHasMetCivCount(true) == 1 then reward = reward * 2 end
		reward = reward * (player:GetCurrentEra() + 1)
		local randomReward = GetRandom(1, 4)
		if player:GetCurrentResearch() < 1 and randomReward == 3 then randomReward = 4 end
		if randomReward == 1 then
			player:ChangeFaith(reward)
			if player:IsHuman() and player:IsTurnActive() then
				local title = "Friendly Neighbors"
				local descr = Locale.ConvertTextKey("You receive {1_Num} [ICON_PEACE] Faith from meeting {2_CivName}.", reward, playerMet:GetName())
				player:AddNotification(NotificationTypes.NOTIFICATION_GENERIC, descr, title, -1, -1)
			end
		elseif randomReward == 2 then
			player:ChangeJONSCulture(reward)
			if player:IsHuman() and player:IsTurnActive() then
				local title = "Friendly Neighbors"
				local descr = Locale.ConvertTextKey("You receive {1_Num} [ICON_CULTURE] Culture from meeting {2_CivName}.", reward, playerMet:GetName())
				player:AddNotification(NotificationTypes.NOTIFICATION_GENERIC, descr, title, -1, -1)
			end
		elseif randomReward == 3 then
			Teams[player:GetTeam()]:GetTeamTechs():ChangeResearchProgress(player:GetCurrentResearch(), reward, playerID)
			if player:IsHuman() and player:IsTurnActive() then
				local title = "Friendly Neighbors"
				local descr = Locale.ConvertTextKey("You receive {1_Num} [ICON_RESEARCH] Science from meeting {2_CivName}.", reward, playerMet:GetName())
				player:AddNotification(NotificationTypes.NOTIFICATION_GENERIC, descr, title, -1, -1)
			end
		else
			player:ChangeGold(reward)
			if player:IsHuman() and player:IsTurnActive() then
				local title = "Friendly Neighbors"
				local descr = Locale.ConvertTextKey("You receive {1_Num} [ICON_GOLD] Gold from meeting {2_CivName}.", reward, playerMet:GetName())
				player:AddNotification(NotificationTypes.NOTIFICATION_GENERIC, descr, title, -1, -1)
			end
		end
	end
end

if JFD_IsCivilisationActive(civilisationID) then
	Events.LoadScreenClose.Add(InitTonga)
	GameEvents.TeamMeet.Add(JFD_TongaUA)
end
--=======================================================================================================================
--=======================================================================================================================