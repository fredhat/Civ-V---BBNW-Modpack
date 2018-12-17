-- FreeUnitQuantity
-- Author: Leugi
-- Heavily Edited By: F0S
--------------------------------------------------------------
local iCivType = GameInfoTypes["CIVILIZATION_MARATHA"]
local iUnitSepoy = GameInfo.Units["UNIT_MARATHA_SEPOY"].ID
local iBuildingHeroicEpic = GameInfo.Buildings["BUILDING_HEROIC_EPIC"].ID
local iTechnologyGunpowder = GameInfo.Technologies["TECH_GUNPOWDER"].ID
local iPromotionMilitia = GameInfo.UnitPromotions["PROMOTION_JFD_MARATHA_MILITIA"].ID
local iPromotionMorale = GameInfo.UnitPromotions["PROMOTION_MORALE"].ID
local iNumUnits = 3

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

function FreeUnitQuantityGift(iTeam, iTech)
	local pTeam = Teams[iTeam]
	local iPlayer = pTeam:GetLeaderID()
	local pPlayer = Players[iPlayer]
	if pPlayer:IsEverAlive() and pPlayer:GetCivilizationType() == iCivType then
		if iTech == iTechnologyGunpowder then
			for pCity in pPlayer:Cities() do
				if pCity:IsCapital() then
					while iNumUnits > 1 do
						local pUnit = pPlayer:InitUnit(iUnitSepoy, pCity:GetX(), pCity:GetY(), UNITAI_ATTACK)
						pUnit:JumpToNearestValidPlot()
						pUnit:SetExperience(pCity:GetProductionExperience(pUnit:GetUnitType()))
						if pCity:IsHasBuilding(iBuildingHeroicEpic) then
							pUnit:SetHasPromotion(iPromotionMorale, true)
						end
						pUnit:SetHasPromotion(iPromotionMilitia, true)
						iNumUnits = iNumUnits - 1
					end
				end
			end
		end
	end
end

function FreeUnitQuantityGiftAdvancedStart()
	local iPlayer = Game.GetActivePlayer()
    local pPlayer = Players[iPlayer]
	local iTeam = pPlayer:GetTeam()
	local pTeam = Teams[iTeam]
	if pPlayer:IsEverAlive() and pPlayer:GetCivilizationType() == iCivType then
		if pPlayer:GetNumCities() < 1 then
			if pTeam:IsHasTech(iTechnologyGunpowder) then
				while iNumUnits > 1 do
					local pPlot = pPlayer:GetStartingPlot()
					local pUnit = pPlayer:InitUnit (iUnitSepoy, pPlot:GetX(), pPlot:GetY(), UNITAI_ATTACK)
					pUnit:JumpToNearestValidPlot()
					pUnit:SetHasPromotion(iPromotionMilitia, true)
					iNumUnits = iNumUnits - 1
				end
			end
		end
	end
end

if JFD_IsCivilisationActive(iCivType) then
	GameEvents.TeamTechResearched.Add(FreeUnitQuantityGift)
	Events.LoadScreenClose.Add(FreeUnitQuantityGiftAdvancedStart)
end