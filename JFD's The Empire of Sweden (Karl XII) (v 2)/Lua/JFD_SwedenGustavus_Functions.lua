-- JFD_SwedenGustavus_Functions
-- Author: JFD
-- Edited By: F0S
--==========================================================================================================================
-- UTILITY FUNCTIONS
--==========================================================================================================================
-- MOD CHECKS
--------------------------------------------------------------------------------------------------------------------------
local civilizationID = GameInfoTypes["CIVILIZATION_JFD_SWEDEN_GUSTAV"]

-- JFD_IsCivilisationActive
function JFD_IsCivilisationActive(civilizationID)
	for iSlot = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
		local slotStatus = PreGame.GetSlotStatus(iSlot)
		if slotStatus == SlotStatus["SS_TAKEN"] or slotStatus == SlotStatus["SS_COMPUTER"] then
			if PreGame.GetCivilization(iSlot) == civilizationID then
				return true
			end
		end
	end
	return false
end
--==========================================================================================================================
-- UU FUNCTIONS
--==========================================================================================================================
-- REGAL SHIP
----------------------------------------------------------------------------------------------------------------------------
local promotionRegalShipID = GameInfoTypes["PROMOTION_JFD_REGAL_SHIP"]

-- JFD_SwedenGustavus_RegalShip
function JFD_SwedenGustavus_RegalShip(playerID)
	local player = Players[playerID]
	if player:IsEverAlive() then 
		for unit in player:Units() do
			if unit and unit:GetDamage() > 0 and unit:GetDomainType() == GameInfoTypes["DOMAIN_LAND"] then
				local isRegalShipNearby = false
				for regalShip in player:Units() do
					if regalShip and regalShip:IsHasPromotion(promotionRegalShipID) then
						if Map.PlotDistance(unit:GetX(), unit:GetY(), regalShip:GetX(), regalShip:GetY()) < 3 then
							isRegalShipNearby = true
						end
					end
				end
				if isRegalShipNearby then
					unit:ChangeDamage(-1 * math.min(unit:GetDamage(), 10))
				end	
			end
		end
	end
end

if JFD_IsCivilisationActive(civilizationID) then
	GameEvents.PlayerDoTurn.Add(JFD_SwedenGustavus_RegalShip)
end
--==========================================================================================================================
--==========================================================================================================================