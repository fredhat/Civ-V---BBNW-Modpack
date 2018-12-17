-- Steampunk Airships Functions
-- Author: William Howard
-- Heavily Edited By: F0S
--==========================================================================================================================
WARN_NOT_SHARED = false; include( "Sukritact_SaveUtils.lua" ); MY_MOD_NAME = "Steampunk Airships Functions";
local unitClassAirshipID = GameInfoTypes["UNITCLASS_AIRSHIP"]
local civilisationHannibalID = GameInfoTypes["CIVILIZATION_JFD_CARTHAGE_HANNIBAL"]
----------------------------------------------------------------------------------------------------------------------------
-- OnCanMoveInto
----------------------------------------------------------------------------------------------------------------------------
function OnCanMoveInto(playerID, unitID, plotX, plotY, isAttack, isDeclareWar)
	local player = Players[playerID]
	local unit = player:GetUnitByID(unitID)
	if unit and unit:GetUnitClassType() == unitClassAirshipID then
		local plot = Map.GetPlot(plotX, plotY)
		if plot then
			if player:IsEverAlive() then
				return (not plot:IsMountain() or player:GetCivilizationType() == civilisationHannibalID)
			else
				return not plot:IsMountain()
			end
		end
	end
	return true
end

GameEvents.CanMoveInto.Add(OnCanMoveInto)
----------------------------------------------------------------------------------------------------------------------------
-- CloseAirSupportDefense
----------------------------------------------------------------------------------------------------------------------------
local promotionCloseAirSupportID = GameInfoTypes["PROMOTION_CLOSE_AIR_SUPPORT"]
local promotionCloseAirSupportDefenseID = GameInfoTypes["PROMOTION_CLOSE_AIR_SUPPORT_DEFENSE"]
local unitCombatArcherID = GameInfoTypes["UNITCOMBAT_ARCHER"]
local unitCombatMeleeID = GameInfoTypes["UNITCOMBAT_MELEE"]
local unitCombatGunID = GameInfoTypes["UNITCOMBAT_GUN"]
local direction_types = {
	DirectionTypes["DIRECTION_NORTHEAST"],
	DirectionTypes["DIRECTION_NORTHWEST"],
	DirectionTypes["DIRECTION_EAST"],
	DirectionTypes["DIRECTION_SOUTHEAST"],
	DirectionTypes["DIRECTION_SOUTHWEST"],
	DirectionTypes["DIRECTION_WEST"]
}

function CloseAirSupportDefense(playerID, unit, plot)
	local player = Players[playerID]
	local adjacentToHelicopter = false
	for loop, direction in ipairs(direction_types) do
		local adjPlot = Map.PlotDirection(unit:GetX(), unit:GetY(), direction)
		if adjPlot then
			if unit:IsHasPromotion(promotionCloseAirSupportID) and not unit:IsEmbarked() then
				for i = 0, adjPlot:GetNumUnits() - 1 do
					local adjUnit = adjPlot:GetUnit(i)
					if adjUnit and adjUnit:GetOwner() == playerID and not adjUnit:IsEmbarked() then
						if unit:IsHasPromotion(promotionCloseAirSupportID) and (adjUnit:GetUnitCombatType() == unitCombatArcherID or adjUnit:GetUnitCombatType() == unitCombatMeleeID or adjUnit:GetUnitCombatType() == unitCombatGunID) then
							if not adjUnit:IsHasPromotion(promotionCloseAirSupportDefenseID) then
								adjUnit:SetHasPromotion(promotionCloseAirSupportDefenseID, true)
							end
						elseif adjUnit:IsHasPromotion(promotionCloseAirSupportID) and (unit:GetUnitCombatType() == unitCombatArcherID or unit:GetUnitCombatType() == unitCombatMeleeID or unit:GetUnitCombatType() == unitCombatGunID) then
							adjacentToHelicopter = true
							break
						end
					end
				end
			end
		end
	end
	if adjacentToHelicopter then
		if not unit:IsHasPromotion(promotionCloseAirSupportDefenseID) then
			unit:SetHasPromotion(promotionCloseAirSupportDefenseID, true)
		end
	else
		if unit:IsHasPromotion(promotionCloseAirSupportDefenseID) then
			unit:SetHasPromotion(promotionCloseAirSupportDefenseID, false)
		end
	end
end

function CloseAirSupportDefenseTurn(playerID)
	local player = Players[playerID]
	if player:IsEverAlive() then
		for unit in player:Units() do
			if unit then
				local plot = Map.GetPlot(unit:GetX(), unit:GetY())
				if plot then CloseAirSupportDefense(playerID, unit, plot) end
			end
		end
	end
end

function CloseAirSupportDefenseXY(playerID, unitID)
	local player = Players[playerID]
	if player:IsEverAlive() then
		local unit = player:GetUnitByID(unitID)
		if unit then
			local plot = Map.GetPlot(unit:GetX(), unit:GetY())
			if plot then CloseAirSupportDefense(playerID, unit, plot) end
		end
	end
end

function CloseAirSupportDefenseInitialTrigger(playerID, unitID)
	local player = Players[playerID]
	local unit = player:GetUnitByID(unitID)
	if unit and unit:IsHasPromotion(promotionCloseAirSupportID) then
		GameEvents.PlayerDoTurn.Add(CloseAirSupportDefenseTurn)
		GameEvents.UnitSetXY.Add(CloseAirSupportDefenseXY)
		Events.SerialEventUnitCreated.Add(CloseAirSupportDefenseXY)
		Events.SerialEventUnitCreated.Remove(CloseAirSupportDefenseInitialTrigger)
		save("GAME", "CloseAirSupportDefenseInitalised", true)
		CloseAirSupportDefenseXY(playerID, unitID)
	end
end

if load("GAME", "CloseAirSupportDefenseInitalised") then
	GameEvents.PlayerDoTurn.Add(CloseAirSupportDefenseTurn)
	GameEvents.UnitSetXY.Add(CloseAirSupportDefenseXY)
	Events.SerialEventUnitCreated.Add(CloseAirSupportDefenseXY)
else
	Events.SerialEventUnitCreated.Add(CloseAirSupportDefenseInitialTrigger)
end
--==========================================================================================================================
--==========================================================================================================================