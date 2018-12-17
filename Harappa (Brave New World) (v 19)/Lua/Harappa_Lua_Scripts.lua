-- Harappa Lua Scripts
-- Author: Tomatekh
-- Heavily Edited By: F0S
--------------------------------------------------------------
WARN_NOT_SHARED = false; include( "Sukritact_SaveUtils.lua" ); MY_MOD_NAME = "Harappa_Lua_Scripts";

local direction_types = {
	DirectionTypes.DIRECTION_NORTHEAST,
	DirectionTypes.DIRECTION_NORTHWEST,
	DirectionTypes.DIRECTION_EAST,
	DirectionTypes.DIRECTION_SOUTHEAST,
	DirectionTypes.DIRECTION_SOUTHWEST,
	DirectionTypes.DIRECTION_WEST,
}

local pSupplyTrain = GameInfoTypes.PROMOTION_HARAPPA_SUPPLY_TRAIN
local bSewer = GameInfoTypes.BUILDING_HARAPPA_DRAIN
local bDummyHappy = GameInfoTypes.BUILDING_HARAPPA_DUMMY_HAPPY
local hTrait = GameInfoTypes.BUILDING_HARAPPA_DUMMY_TRAIT
local hTrade = GameInfoTypes.BUILDING_HARAPPA_DUMMY_TRADE
local uCaravan = GameInfoTypes.UNIT_CARAVAN
local pTradeSeals = GameInfoTypes.POLICY_TRADE_SEALS
local civilisationID = GameInfoTypes.CIVILIZATION_HARAPPA_MOD

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

-- Sewer Trigger
function SewerTrigger(iPlayer)
    local pPlayer = Players[iPlayer]
    for pCity in pPlayer:Cities() do
        if pCity:IsHasBuilding(bSewer) then
            if pCity:Plot():IsRiver() then
				if not pCity:IsHasBuilding(bDummyHappy) then
					pCity:SetNumRealBuilding(bDummyHappy, 1)
				end
			else
				if pCity:IsHasBuilding(bDummyHappy) then
					pCity:SetNumRealBuilding(bDummyHappy, 0)
				end
			end
		else
			if pCity:IsHasBuilding(bDummyHappy) then
				pCity:SetNumRealBuilding(bDummyHappy, 0)
			end
        end
    end
end

function SewerTriggerPolicyTrigger(iPlayer, iPolicy)
    local pPlayer = Players[iPlayer]
    if pPlayer:GetCivilizationType() == civilisationID and ((iPolicy == GameInfoTypes["POLICY_LANDED_ELITE"] and pPlayer:HasPolicy(GameInfoTypes["POLICY_MONARCHY"])) or (iPolicy == GameInfoTypes["POLICY_MONARCHY"] and pPlayer:HasPolicy(GameInfoTypes["POLICY_LANDED_ELITE"]))) then
        GameEvents.PlayerDoTurn.Add(SewerTrigger)
        GameEvents.CityConstructed.Add(SewerTrigger)
		GameEvents.CitySoldBuilding.Add(SewerTrigger)
		GameEvents.PlayerAdoptPolicy.Add(SewerTrigger)
		GameEvents.PlayerAdoptPolicy.Remove(SewerTriggerPolicyTrigger)
        GameEvents.CityConstructed.Remove(SewerTriggerInitialTrigger)
        save("GAME", "SewerTriggerInitalised", true)
		SewerTrigger(iPlayer)
    end
end

function SewerTriggerInitialTrigger(iPlayer, iCity, iBuilding)
    local pPlayer = Players[iPlayer]
    if iBuilding == bSewer then
        GameEvents.PlayerDoTurn.Add(SewerTrigger)
        GameEvents.CityConstructed.Add(SewerTrigger)
		GameEvents.CitySoldBuilding.Add(SewerTrigger)
		GameEvents.PlayerAdoptPolicy.Add(SewerTrigger)
		GameEvents.PlayerAdoptPolicy.Remove(SewerTriggerPolicyTrigger)
        GameEvents.CityConstructed.Remove(SewerTriggerInitialTrigger)
        save("GAME", "SewerTriggerInitalised", true)
        SewerTrigger(iPlayer)
    end
end

-- City Trade Check
function CityTradeCheck(pPlayer)
	for pCity in pPlayer:Cities() do
		if pCity:IsCapital() then
			if not pCity:IsHasBuilding(hTrait) then
				pCity:SetNumRealBuilding(hTrait, 1)
			end
		else
			if pCity:IsHasBuilding(hTrait) then
				pCity:SetNumRealBuilding(hTrait, 0)
			end
		end
		if not pCity:IsHasBuilding(hTrade) then
			pCity:SetNumRealBuilding(hTrade, 1)
		end
	end
end


-- Capital Trade Check Turn
function CapitalTradeCheckTurn(iPlayer)
	local pPlayer = Players[iPlayer]
	if pPlayer:IsEverAlive() and pPlayer:GetCivilizationType() == civilisationID then
		CityTradeCheck(pPlayer)
	end
end

-- Capital Trade Check Capture
function CapitalTradeCheckCapture(oldOwnerID, capital, plotX, plotY, newOwnerID)
	local pPlayer = Players[newOwnerID]
	local pOtherPlayer = Players[oldOwnerID]
	if pPlayer:IsEverAlive() and pPlayer:GetCivilizationType() == civilisationID then
		CityTradeCheck(pPlayer)
	elseif pOtherPlayer:IsEverAlive() and pOtherPlayer:GetCivilizationType() == civilisationID then
		CityTradeCheck(pOtherPlayer)
	end
end

-- Trade Seals Dummy Policy
function TradeSealsDummyPolicy(iPlayer, iCityX, iCityY)
	local pPlayer = Players[iPlayer]
	local pPlot = Map.GetPlot(iCityX, iCityY)
	local pCity = pPlot:GetPlotCity()
	if pPlayer:IsEverAlive() and pPlayer:GetCivilizationType() == civilisationID then
		if pCity:IsCapital() then
			if not pCity:IsHasBuilding(hTrait) then
				pCity:SetNumRealBuilding(hTrait, 1)
			end
			if not pPlayer:HasPolicy(pTradeSeals) then
				pPlayer:SetNumFreePolicies(pPlayer:GetNumFreePolicies() + 1)
				pPlayer:SetNumFreePolicies(pPlayer:GetNumFreePolicies() - 1)
				pPlayer:SetHasPolicy(pTradeSeals, true)
				pUnit = pPlayer:InitUnit(uCaravan, pCity:GetX(), pCity:GetY(), UNITAI_TRADE_UNIT)
				pUnit:JumpToNearestValidPlot()
			end
		end
		if not pCity:IsHasBuilding(hTrade) then
			pCity:SetNumRealBuilding(hTrade, 1)
		end
	end
end

if JFD_IsCivilisationActive(civilisationID) then
	if load("GAME", "SewerTriggerInitalised") then
        GameEvents.PlayerDoTurn.Add(SewerTrigger)
        GameEvents.CityConstructed.Add(SewerTrigger)
		GameEvents.CitySoldBuilding.add(SewerTrigger)
    else
		GameEvents.PlayerAdoptPolicy.Add(SewerTriggerPolicyTrigger)
        GameEvents.CityConstructed.Add(SewerTriggerInitialTrigger)
    end
	GameEvents.PlayerDoTurn.Add(CapitalTradeCheckTurn)
	GameEvents.CityCaptureComplete.Add(CapitalTradeCheckCapture)
	GameEvents.PlayerCityFounded.Add(TradeSealsDummyPolicy)
end


--Bullock Cart Ability
function ShareMovementWithLandUnits(playerID)
	local player = Players[playerID]
	if player:IsEverAlive() then
		for unit in player:Units() do
			if unit:IsHasPromotion(pSupplyTrain) then
				local iMoves = unit:GetMoves()
				local pPlot = unit:GetPlot()
				local iNumUnits = pPlot:GetNumUnits()
				for iVal = 0,(iNumUnits - 1) do
					local otherUnit = pPlot:GetUnit(iVal)
					if otherUnit:GetOwner() == unit:GetOwner() and otherUnit:GetDomainType() == GameInfoTypes["DOMAIN_LAND"] and not otherUnit:IsEmbarked() and iMoves > otherUnit:GetMoves() then
						otherUnit:SetMoves(iMoves)
					end
				end
				for loop, direction in ipairs(direction_types) do
					local adjPlot = Map.PlotDirection(pPlot:GetX(), pPlot:GetY(), direction)
					if adjPlot:IsUnit() then
						local otherNumUnits = adjPlot:GetNumUnits()
						for iVal = 0,(otherNumUnits - 1) do
							local otherUnit = adjPlot:GetUnit(iVal)
							if otherUnit:GetOwner() == unit:GetOwner() and otherUnit:GetDomainType() == GameInfoTypes["DOMAIN_LAND"] and not otherUnit:IsEmbarked() and iMoves > otherUnit:GetMoves() then
								otherUnit:SetMoves(iMoves)
							end
						end
					end
				end
			end
		end
	end
end

function ShareMovementWithLandUnitsInitialTrigger(iPlayer, iUnit)
	local pPlayer = Players[iPlayer]
	local pUnit = pPlayer:GetUnitByID(iUnit)
	if pUnit and pUnit:IsHasPromotion(pSupplyTrain) then
		GameEvents.PlayerDoTurn.Add(ShareMovementWithLandUnits)
		Events.SerialEventUnitCreated.Remove(ShareMovementWithLandUnitsInitialTrigger)
		save("GAME", "ShareMovementWithLandUnitsInitalised", true)
	end
end

if load("GAME", "ShareMovementWithLandUnitsInitalised") then
	GameEvents.PlayerDoTurn.Add(ShareMovementWithLandUnits)
else
	Events.SerialEventUnitCreated.Add(ShareMovementWithLandUnitsInitialTrigger)
end