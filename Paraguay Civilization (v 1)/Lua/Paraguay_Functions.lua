-- Paraguay_Functions
-- Author: Leugi
-- Heavily Edited By: F0S
--------------------------------------------------------------
WARN_NOT_SHARED = false; include( "Sukritact_SaveUtils.lua" ); MY_MOD_NAME = "Paraguay_Functions";
--------------------------------------------------------------
local civilisationID = GameInfoTypes["CIVILIZATION_PARAGUAY"]
--------------------------------------------------------------
-- Utility Functions
--------------------------------------------------------------
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
--------------------------------------------------------------
-- InitParaguay
--------------------------------------------------------------
local policyMestizajeID = GameInfoTypes["POLICY_MESTIZAJE"]

function InitParaguay()
	for playerID, player in pairs(Players) do
		local player = Players[playerID]
		if player:IsEverAlive() and player:GetCivilizationType() == civilisationID then
			if not player:HasPolicy(policyMestizajeID) then
				player:SetNumFreePolicies(player:GetNumFreePolicies() + 1)
				player:SetNumFreePolicies(player:GetNumFreePolicies() - 1)
				player:SetHasPolicy(policyMestizajeID, true)	
			end
		end
	end 
end

if JFD_IsCivilisationActive(civilisationID) then
	Events.SequenceGameInitComplete.Add(InitParaguay)
end
--------------------------------------------------------------
-- InitParaguay
--------------------------------------------------------------
local promotionCarayaOutID = GameInfoTypes["PROMOTION_CARAYA_OUT"]
local promotionCarayaID = GameInfoTypes["PROMOTION_CARAYA"]

function PromotionAcaCarayaCheck(unit)
	local plot = unit:GetPlot()
	if plot then
		if plot:GetOwner() == unit:GetOwner() then
			if unit:IsHasPromotion(promotionCarayaOutID) then
				unit:SetHasPromotion(promotionCarayaID,true)
				unit:SetHasPromotion(promotionCarayaOutID,false)
			end
		else
			if unit:IsHasPromotion(promotionCarayaID) then
				unit:SetHasPromotion(promotionCarayaID,false)
				unit:SetHasPromotion(promotionCarayaOutID,true)
			end
		end
	else
		if unit:IsHasPromotion(promotionCarayaID) then
			unit:SetHasPromotion(promotionCarayaID,false)
			unit:SetHasPromotion(promotionCarayaOutID,true)
		end
	end
end

function PromotionAcaCarayaTurn(playerID)
	local player = Players[playerID]
	if player:IsEverAlive() then
		for unit in player:Units() do
			if unit and (unit:IsHasPromotion(promotionCarayaOutID) or unit:IsHasPromotion(promotionCarayaID)) then
				PromotionAcaCarayaCheck(unit)
			end
		end
	end
end

function PromotionAcaCarayaOther(playerID, unitID)
	local player = Players[playerID]
	if player:IsEverAlive() then
		local unit = player:GetUnitByID(unitID)
		if unit and (unit:IsHasPromotion(promotionCarayaOutID) or unit:IsHasPromotion(promotionCarayaID)) then
			PromotionAcaCarayaCheck(unit)
		end
	end
end

function PromotionAcaCarayaInitialTrigger(playerID, unitID)
	local player = Players[playerID]
	local unit = player:GetUnitByID(unitID)
	if unit and unit:IsHasPromotion(promotionCarayaOutID) then
		GameEvents.PlayerDoTurn.Add(PromotionAcaCarayaTurn)
		GameEvents.UnitSetXY.Add(PromotionAcaCarayaOther)
		Events.SerialEventUnitCreated.Add(PromotionAcaCarayaOther)
		Events.SerialEventUnitCreated.Remove(PromotionAcaCarayaInitialTrigger)
		save("GAME", "PromotionAcaCarayaInitalised", true)
		PromotionAcaCarayaOther(playerID, unitID)
	end
end

if load("GAME", "PromotionAcaCarayaInitalised") then
	GameEvents.PlayerDoTurn.Add(PromotionAcaCarayaTurn)
	GameEvents.UnitSetXY.Add(PromotionAcaCarayaOther)
	Events.SerialEventUnitCreated.Add(PromotionAcaCarayaOther)
else
	Events.SerialEventUnitCreated.Add(PromotionAcaCarayaInitialTrigger)
end
--------------------------------------------------------------