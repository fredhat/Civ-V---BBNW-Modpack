-- JFD_CoreFunctions
-- Author: JFD
-- Heavily Edited By: F0S
--==========================================================================================================================
-- UTILITY FUNCTIONS
--==========================================================================================================================
-- JFD_IsCivilisationActive
--------------------------------------------------------------
WARN_NOT_SHARED = false; include( "Sukritact_SaveUtils.lua" ); MY_MOD_NAME = "JFD_BelgiumFunctions";

local civilisationID = GameInfoTypes["CIVILIZATION_JFD_BELGIUM"]

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
--------------------------------------------------------------------------------------------------------------------------
-- JFD_GetUniqueUnit
--------------------------------------------------------------------------------------------------------------------------
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
--==========================================================================================================================
-- CORE FUNCTIONS
--==========================================================================================================================
-- JFD_TreatyOfLondon
----------------------------------------------------------------------------------------------------------------------------
local militarySupport = {}
militarySupport.ERA_ANCIENT = "UNITCLASS_WARRIOR"
militarySupport.ERA_CLASSICAL = "UNITCLASS_SPEARMAN"
militarySupport.ERA_MEDIEVAL = "UNITCLASS_PIKEMAN"
militarySupport.ERA_RENAISSANCE = "UNITCLASS_MUSKETMAN"
militarySupport.ERA_INDUSTRIAL = "UNITCLASS_RIFLEMAN"
militarySupport.ERA_MODERN = "UNITCLASS_GREAT_WAR_INFANTRY"
militarySupport.ERA_POSTMODERN = "UNITCLASS_INFANTRY"
militarySupport.ERA_FUTURE = "UNITCLASS_MECHANIZED_INFANTRY"
		
function JFD_SendMilitarySupport(player, otherPlayer)
	local unitClass = militarySupport[GameInfo.Eras[otherPlayer:GetCurrentEra()].Type]
	local unitType = JFD_GetUniqueUnit(otherPlayer, unitClass)
	local aiType = GameInfo.Units[unitType].DefaultUnitAI
	player:AddFreeUnit(GameInfoTypes[unitType], GameInfoTypes[aiType])
	if player:IsHuman() and player:IsTurnActive() then
		local description = Locale.ConvertTextKey('TXT_KEY_JFD_BELGIUM_MILITARY_SUPPORT', otherPlayer:GetName())
		local descriptionShort = Locale.ConvertTextKey("TXT_KEY_JFD_BELGIUM_MILITARY_SUPPORT_SHORT", otherPlayer:GetName())
		player:AddNotification(NotificationTypes["NOTIFICATION_GENERIC"], description, descriptionShort)
	end
end

function JFD_TreatyOfLondon(teamOne, teamTwo)
	for attackingPlayerID = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do			
		for defendingPlayerID = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
			local attackingPlayer = Players[attackingPlayerID]
			local defendingPlayer = Players[defendingPlayerID]
			if attackingPlayer:IsEverAlive() and not attackingPlayer:IsMinorCiv() and defendingPlayer:IsEverAlive() and not defendingPlayer:IsMinorCiv() then
				if attackingPlayer:GetTeam() == teamOne and defendingPlayer:GetTeam() == teamTwo then
					if defendingPlayer:GetCivilizationType() == civilisationID and Teams[defendingPlayer:GetTeam()]:GetAtWarCount(true) <= 1 then 
						local belgianFriends = {}
						for friendPlayerID, friend in pairs(Players) do
							if friend:IsEverAlive() and friendPlayerID ~= defendingPlayerID and not friend:IsMinorCiv() and friend:IsDoF(defendingPlayerID) then
								table.insert(belgianFriends, friendPlayerID)
							elseif friend:IsEverAlive() and friend:IsMinorCiv() and friend:GetMinorCivFriendshipLevelWithMajor(defendingPlayerID) == 2 then
								table.insert(belgianFriends, friendPlayerID)
							end
						end
						for i, v in pairs(belgianFriends) do
							JFD_SendMilitarySupport(defendingPlayer, Players[v])	
						end
					end
				end
			end
		end	
	end
end
--------------------------------------------------------------------------------------------------------------------------
-- JFD_BelgianWorker
--------------------------------------------------------------------------------------------------------------------------
local unitWorkerID = GameInfoTypes["UNIT_WORKER"]
local unitBelgianWorkerID = GameInfoTypes["UNIT_JFD_BELGIAN_WORKER"]
local improvementBelgianPlantationID = GameInfoTypes["IMPROVEMENT_JFD_BELGIAN_PLANTATION"]

function JFD_BelgianWorkerTraining(playerID, unitID)
	local player = Players[playerID]
    if unitID == unitBelgianWorkerID then 
		return 
	end
	return true
end

GameEvents.PlayerCanTrain.Add(JFD_BelgianWorkerTraining)

function JFD_BelgianWorker(playerID, unitID)
    local player = Players[playerID]
    if player:IsEverAlive() and player:GetCivilizationType() == civilisationID then 
       	 local unit = player:GetUnitByID(unitID)
		 if unit and unit:GetUnitType() == unitWorkerID then
			local newUnit
			newUnit = player:InitUnit(unitBelgianWorkerID, unit:GetX(), unit:GetY(), UNITAI_WORKER)
			newUnit:Convert(unit)
         end
    end
end

function JFD_BelgianColonies(playerID, iX, iY, improvementID)
	local player = Players[playerID]
    if player:IsEverAlive() and player:GetCivilizationType() == civilisationID then 
		if improvementID == improvementBelgianPlantationID then
			local plot = Map.GetPlot(iX, iY)
			if plot and plot:GetOwner() == -1 then
				plot:SetOwner(playerID)
			end
		end
	end
end

if JFD_IsCivilisationActive(civilisationID) then
	GameEvents.DeclareWar.Add(JFD_TreatyOfLondon)
	Events.SerialEventUnitCreated.Add(JFD_BelgianWorker)
	GameEvents.BuildFinished.Add(JFD_BelgianColonies)
end
----------------------------------------------------------------------------------------------------------------------------
-- JFD_ChasseurMarch
----------------------------------------------------------------------------------------------------------------------------
local promotionChasseurInfoID = GameInfoTypes["PROMOTION_JFD_CHASSEUR_INFO"]
local promotionChasseurMarchID = GameInfoTypes["PROMOTION_JFD_CHASSEUR_MARCH"]

function JFD_GetWarPartner(player)
	local warPartner = false
	for otherPlayerID = 0, GameDefines.MAX_CIV_PLAYERS-1 do
		if otherPlayerID ~= player:GetID() then
			if Teams[Players[otherPlayerID]:GetTeam()]:IsAtWar(player:GetTeam()) then
				warPartner = Players[otherPlayerID]
			end
		end
	end
	return warPartner
end

function JFD_ChasseurMarch(playerID)
	local player = Players[playerID]
	local playerTeamID = player:GetTeam()
	if player:IsEverAlive() then
		local belgianFriends = {}
		local belgianEnemies = {}
		local coalitionWar = false
		for otherPlayerID = 0, GameDefines.MAX_CIV_PLAYERS-1 do
			if otherPlayerID ~= playerID then
				local otherTeamID = Players[otherPlayerID]:GetTeam()
				if Teams[otherTeamID]:IsAtWar(playerTeamID) then
					table.insert(belgianEnemies, otherTeamID)
				elseif Players[otherPlayerID]:IsDoF(playerID) then
					table.insert(belgianFriends, otherTeamID)
				end
			end
		end
		for i, v in pairs(belgianFriends) do
			for j, w in pairs(belgianEnemies) do
				if Teams[v]:IsAtWar(w) then
					coalitionWar = true
					break
				end
			end
		end
		for unit in player:Units() do
			if coalitionWar then
				if unit:IsHasPromotion(promotionChasseurInfoID) then
					unit:SetHasPromotion(promotionChasseurMarchID, true)
					unit:SetHasPromotion(promotionChasseurInfoID, false)
				end
			else
				if unit:IsHasPromotion(promotionChasseurMarchID) then
					unit:SetHasPromotion(promotionChasseurMarchID, false)
					unit:SetHasPromotion(promotionChasseurInfoID, true)
				end
			end
		end
	end
end

function JFD_ChasseurMarchDirty()
	local playerID = Game.GetActivePlayer()
    local player = Players[playerID]
	if player:IsTurnActive() then
        JFD_ChasseurMarch(playerID)
    end
end

function JFD_ChasseurMarchInitialTrigger(playerID, unitID)
	local player = Players[playerID]
	local unit = player:GetUnitByID(unitID)
	if unit and unit:IsHasPromotion(promotionChasseurInfoID) then
		GameEvents.PlayerDoTurn.Add(JFD_ChasseurMarch)
		Events.SerialEventGameDataDirty.Add(JFD_ChasseurMarchDirty)
		Events.SerialEventUnitCreated.Remove(JFD_ChasseurMarchInitialTrigger)
		save("GAME", "JFD_ChasseurMarchInitalised", true)
		JFD_ChasseurMarch(playerID)
	end
end

if load("GAME", "JFD_ChasseurMarchInitalised") then
	GameEvents.PlayerDoTurn.Add(JFD_ChasseurMarch)
	Events.SerialEventGameDataDirty.Add(JFD_ChasseurMarchDirty)
else
	Events.SerialEventUnitCreated.Add(JFD_ChasseurMarchInitialTrigger)
end
--==========================================================================================================================
--==========================================================================================================================