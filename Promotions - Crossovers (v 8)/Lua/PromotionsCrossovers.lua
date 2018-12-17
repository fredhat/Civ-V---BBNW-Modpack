-- GlobalXpForScouting
-- Original Author: William Howard
-- Edited By: F0S
--------------------------------------------------------------
local upgrades = {}

function OnUnitUpgraded(iPlayer, iOldUnit, iNewUnit)
	if upgrades[iPlayer] == nil then
		upgrades[iPlayer] = {}
	end
	-- We just need to make a note that the old unit is being upgraded to the new one, the main work happens when the old unit is killed
	upgrades[iPlayer][iOldUnit] = iNewUnit
end

GameEvents.UnitUpgraded.Add(OnUnitUpgraded)

function OnUnitPrekill(iPlayer, iUnit, _, _, _, bDelay, _)
	if not bDelay and upgrades[iPlayer] and upgrades[iPlayer][iUnit] then
		local pNewUnit = Players[iPlayer]:GetUnitByID(upgrades[iPlayer][iUnit])
		local sUnitCombatType = GameInfo.Units[pNewUnit:GetUnitType()].CombatClass
		if sUnitCombatType then
			for row in GameInfo.UnitPromotions_UnitCombatCrossovers{UnitCombatType = sUnitCombatType} do
				local iFromPromotionID = GameInfo.UnitPromotions[row.FromType].ID
				local iToPromotionID = GameInfo.UnitPromotions[row.ToType].ID
				if pNewUnit:IsHasPromotion(iFromPromotionID) then
					pNewUnit:SetHasPromotion(iToPromotionID, true)
					pNewUnit:SetHasPromotion(iFromPromotionID, false)
				end
			end
		end
		upgrades[iPlayer][iUnit] = nil
	end
end

GameEvents.UnitPrekill.Add(OnUnitPrekill)
--------------------------------------------------------------