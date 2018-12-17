-- JFD_TaiahaWarriorCombatBoost
-- Author: JFD
-- Edited By: F0S
--=======================================================================================================================
WARN_NOT_SHARED = false; include( "Sukritact_SaveUtils.lua" ); MY_MOD_NAME = "JFD_TaiahaWarrior";
--=======================================================================================================================
-- JFD_TaiahaWarrior
--=======================================================================================================================
local promotionTaiahaWarriorID = GameInfoTypes["PROMOTION_MC_TAIAHA_WARRIOR"]
local promotionTaiahaCombatBonusID = GameInfoTypes["PROMOTION_MC_TAIAHA_COMBAT_BONUS"]

function JFD_TaiahaWarrior(playerID)
	local player = Players[playerID]
	if player:IsEverAlive() then
		for unit in player:Units() do
			if unit and unit:GetCombatLimit() > 0 and unit:GetDomainType() == DomainTypes.DOMAIN_LAND and not unit:IsEmbarked() then
				local taiahaWarriorNearby = false
				for taiahaWarrior in player:Units() do
					if taiahaWarrior and taiahaWarrior:IsHasPromotion(promotionTaiahaWarriorID) and taiahaWarrior ~= unit and not taiahaWarrior:IsEmbarked() then
						if Map.PlotDistance(unit:GetX(), unit:GetY(), taiahaWarrior:GetX(), taiahaWarrior:GetY()) < 2 then
							taiahaWarriorNearby = true
						end
					end
				end
				if taiahaWarriorNearby then
					if not unit:IsHasPromotion(promotionTaiahaCombatBonusID) then
						unit:SetHasPromotion(promotionTaiahaCombatBonusID, true)
					end
				else
					if unit:IsHasPromotion(promotionTaiahaCombatBonusID) then
						unit:SetHasPromotion(promotionTaiahaCombatBonusID, false)
					end
				end
			end
		end
	end
end

function JFD_TaiahaWarriorInitialTrigger(playerID, unitID)
	local player = Players[playerID]
	local unit = player:GetUnitByID(unitID)
	if unit and unit:IsHasPromotion(promotionTaiahaWarriorID) then
		GameEvents.PlayerDoTurn.Add(JFD_TaiahaWarrior)
		GameEvents.UnitSetXY.Add(JFD_TaiahaWarrior) 
		Events.SerialEventUnitCreated.Remove(JFD_TaiahaWarriorInitialTrigger)
		save("GAME", "JFD_TaiahaWarriorInitalised", true)
		JFD_TaiahaWarrior(playerID)
	end
end

if load("GAME", "JFD_TaiahaWarriorInitalised") then
	GameEvents.PlayerDoTurn.Add(JFD_TaiahaWarrior)
	GameEvents.UnitSetXY.Add(JFD_TaiahaWarrior) 
else
	Events.SerialEventUnitCreated.Add(JFD_TaiahaWarriorInitialTrigger)
end
--=======================================================================================================================
--=======================================================================================================================