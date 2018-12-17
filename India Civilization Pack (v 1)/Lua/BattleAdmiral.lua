-- BattleAdmiral
-- Author: Leugi
-- Edited By: F0S
--------------------------------------------------------------
WARN_NOT_SHARED = false; include( "SaveUtils" ); MY_MOD_NAME = "BattleAdmiral";

local BAdmiralPromotion = GameInfo.UnitPromotions["PROMOTION_BATTLE_ADMIRAL_0"].ID
local BALevel1 = GameInfo.UnitPromotions["PROMOTION_BATTLE_ADMIRAL_1"].ID
local BALevel2 = GameInfo.UnitPromotions["PROMOTION_BATTLE_ADMIRAL_2"].ID
local BALevel3 = GameInfo.UnitPromotions["PROMOTION_BATTLE_ADMIRAL_3"].ID
local BALevel4 = GameInfo.UnitPromotions["PROMOTION_BATTLE_ADMIRAL_4"].ID
local BALevel5 = GameInfo.UnitPromotions["PROMOTION_BATTLE_ADMIRAL_5"].ID

local BALevel1Prereq = GameInfo.Technologies["TECH_SAILING"].ID
local BALevel2Prereq = GameInfo.Technologies["TECH_ASTRONOMY"].ID
local BALevel3Prereq = GameInfo.Technologies["TECH_NAVIGATION"].ID
local BALevel4Prereq = GameInfo.Technologies["TECH_STEAM_POWER"].ID
local BALevel5Prereq = GameInfo.Technologies["TECH_ELECTRICITY"].ID

local BALevel1Combat = 15
local BALevel2Combat = 25
local BALevel3Combat = 35
local BALevel4Combat = 50
local BALevel5Combat = 60

function BattleAdmiral(pUnit, pTeam)
	if pTeam:IsHasTech(BALevel5Prereq) then
		if not pUnit:IsHasPromotion(BALevel5) then
			pUnit:SetHasPromotion(BALevel1, false)
			pUnit:SetHasPromotion(BALevel2, false)
			pUnit:SetHasPromotion(BALevel3, false)
			pUnit:SetHasPromotion(BALevel4, false)
			pUnit:SetHasPromotion(BALevel5, true)
			pUnit:SetBaseCombatStrength(BALevel5Combat)
		end
	elseif pTeam:IsHasTech(BALevel4Prereq) then
		if not pUnit:IsHasPromotion(BALevel4) then
			pUnit:SetHasPromotion(BALevel1, false)
			pUnit:SetHasPromotion(BALevel2, false)
			pUnit:SetHasPromotion(BALevel3, false)
			pUnit:SetHasPromotion(BALevel4, true)
			pUnit:SetBaseCombatStrength(BALevel4Combat)
		end
	elseif pTeam:IsHasTech(BALevel3Prereq) then
		if not pUnit:IsHasPromotion(BALevel3) then
			pUnit:SetHasPromotion(BALevel1, false)
			pUnit:SetHasPromotion(BALevel2, false)
			pUnit:SetHasPromotion(BALevel3, true)
			pUnit:SetBaseCombatStrength(BALevel3Combat)
		end
	elseif pTeam:IsHasTech(BALevel2Prereq) then
		if not pUnit:IsHasPromotion(BALevel2) then
			pUnit:SetHasPromotion(BALevel1, false)
			pUnit:SetHasPromotion(BALevel2, true)
			pUnit:SetBaseCombatStrength(BALevel2Combat)
		end
	elseif pTeam:IsHasTech(BALevel1Prereq) then
		if not pUnit:IsHasPromotion(BALevel1) then
			pUnit:SetHasPromotion(BALevel1, true)
			pUnit:SetBaseCombatStrength(BALevel1Combat)
		end
	end
end

function BattleAdmiralTurn(iPlayer)
	local pPlayer = Players[iPlayer]
	local iTeam = pPlayer:GetTeam()
	local pTeam = Teams[iTeam]
	if pPlayer:IsEverAlive() then
		for pUnit in pPlayer:Units() do
			if pUnit:IsHasPromotion(BAdmiralPromotion) then
				BattleAdmiral(pUnit, pTeam)
			end
		end
	end
end

function BattleAdmiralXY(iPlayer, iUnitID)
	local pPlayer = Players[iPlayer]
	local iTeam = pPlayer:GetTeam()
	local pTeam = Teams[iTeam]
	local pUnit = pPlayer:GetUnitByID(iUnitID)
	if pPlayer:IsEverAlive() then
		if pUnit:IsHasPromotion(BAdmiralPromotion) then
			BattleAdmiral(pUnit, pTeam)
		end
	end
end

function BattleAdmiralTech(iTeam, iTech)
	local pTeam = Teams[iTeam]
	local iPlayer = pTeam:GetLeaderID()
	local pPlayer = Players[iPlayer]
	if pPlayer:IsEverAlive() then
		for pUnit in pPlayer:Units() do
			if pUnit:IsHasPromotion(BAdmiralPromotion) then
				BattleAdmiral(pUnit, pTeam)
			end
		end
	end
end

function BattleAdmiralInitialTrigger(iPlayer, iUnit)
	local pPlayer = Players[iPlayer]
	local iTeam = pPlayer:GetTeam()
	local pTeam = Teams[iTeam]
	local pUnit = pPlayer:GetUnitByID(iUnit)
	if pUnit and pUnit:IsHasPromotion(BAdmiralPromotion)  then
		GameEvents.PlayerDoTurn.Add(BattleAdmiralTurn)
		GameEvents.UnitSetXY.Add(BattleAdmiralXY)
		GameEvents.TeamTechResearched.Add(BattleAdmiralTech)
		Events.SerialEventUnitCreated.Remove(BattleAdmiralInitialTrigger)
		save("GAME", "BattleAdmiralInitalised", true)
		BattleAdmiral(pUnit, pTeam)
	end
end

if load("GAME", "BattleAdmiralInitalised") then
	GameEvents.PlayerDoTurn.Add(BattleAdmiralTurn)
	GameEvents.UnitSetXY.Add(BattleAdmiralXY)
	GameEvents.TeamTechResearched.Add(BattleAdmiralTech)
else
	Events.SerialEventUnitCreated.Add(BattleAdmiralInitialTrigger)
end