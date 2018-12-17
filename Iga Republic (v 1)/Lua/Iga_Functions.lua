-- Iga_Functions
-- Author: F0S
--==========================================================================================================================
-- UTILITY FUNCTIONS
--==========================================================================================================================
WARN_NOT_SHARED = false; include( "Sukritact_SaveUtils" ); MY_MOD_NAME = "Iga_Functions";
--==========================================================================================================================
local civilisationID = GameInfoTypes["CIVILIZATION_IGA"]
--------------------------------------------------------------
-- JFD_IsCivilisationActive
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
--==========================================================================================================================
-- CORE FUNCTIONS
--==========================================================================================================================
-- InitIga
----------------------------------------------------------------------------------------------------------------------------
local policyFasterSpiesID = GameInfoTypes["POLICY_IGA_FASTER_SPIES"]

function InitIga()
	for iPlayer = 0, GameDefines.MAX_CIV_PLAYERS - 1 do
		local player = Players[iPlayer]
		if player:IsEverAlive() and player:GetCivilizationType() == civilisationID then
			if not player:HasPolicy(policyFasterSpiesID) then
				player:SetNumFreePolicies(player:GetNumFreePolicies() + 1)
				player:SetNumFreePolicies(player:GetNumFreePolicies() - 1)
				player:SetHasPolicy(policyFasterSpiesID, true)	
			end
		end
	end
end
----------------------------------------------------------------------------------------------------------------------------
-- IgaPromotionChecks
----------------------------------------------------------------------------------------------------------------------------
local promotionKishomonID = GameInfoTypes["PROMOTION_KISHOMON"]
local promotionConcealedID = GameInfoTypes["PROMOTION_CONCEALED"]
local improvementKakurezatoID = GameInfoTypes["IMPROVEMENT_KAKUREZATO"]
local promotionKakurezatoBoostID = GameInfoTypes["PROMOTION_KAKUREZATO_BOOST"]

function IgaHasInvisiblePromotion(playerID, unit)
	local plot = Map.GetPlot(unit:GetX(), unit:GetY())
	if plot and (plot:GetFeatureType() == FeatureTypes.FEATURE_FOREST or plot:GetFeatureType() == FeatureTypes.FEATURE_JUNGLE) and unit:IsHasPromotion(promotionKishomonID) then
		if not unit:IsHasPromotion(promotionConcealedID) then
			unit:SetHasPromotion(promotionConcealedID, true)
			--local newUnit = Players[playerID]:InitUnit(unit:GetUnitType(), unit:GetX(), unit:GetY(), unit:GetUnitAiType())
			--newUnit:Convert(unit)
		end
	else
		if unit:IsHasPromotion(promotionConcealedID) then
			unit:SetHasPromotion(promotionConcealedID, false)
			--local newUnit = Players[playerID]:InitUnit(unit:GetUnitType(), unit:GetX(), unit:GetY(), unit:GetUnitAiType())
			--newUnit:Convert(unit)
		end
	end
end

function IgaIsKakurezatoBoost(playerID, unit, isTurn)
	local plot = Map.GetPlot(unit:GetX(), unit:GetY())
	if plot and plot:GetImprovementType() == improvementKakurezatoID and not plot:IsImprovementPillaged() then
		if not unit:IsHasPromotion(promotionKakurezatoBoostID) then
			unit:SetHasPromotion(promotionKakurezatoBoostID, true)
			unit:SetMoves(unit:MaxMoves())
		end
		save(unit, "IgaKakurezatoBoost", 3)
	else
		local numTurns = load(unit, "IgaKakurezatoBoost")
		if numTurns and numTurns > 0 then
			save(unit, "IgaKakurezatoBoost", (numTurns - 1))
		else
			if unit:IsHasPromotion(promotionKakurezatoBoostID) then
				unit:SetHasPromotion(promotionKakurezatoBoostID, false)
				unit:SetMoves(unit:MaxMoves())
			end
		end
	end
end

function IgaPromotionChecksTurn(playerID)
	local player = Players[playerID]
	if player:IsEverAlive() and player:GetCivilizationType() == civilisationID then
		for unit in player:Units() do
			if unit and unit:GetCombatLimit() > 0 and unit:GetDomainType() == DomainTypes.DOMAIN_LAND then
				IgaHasInvisiblePromotion(playerID, unit)
				IgaIsKakurezatoBoost(playerID, unit)
			end
		end
	end
end

function IgaPromotionChecksXY(playerID, unitID)
	local player = Players[playerID]
	if player:IsEverAlive() and player:GetCivilizationType() == civilisationID then
		local unit = player:GetUnitByID(unitID)
		if unit and unit:GetCombatLimit() > 0 and unit:GetDomainType() == DomainTypes.DOMAIN_LAND then
			IgaHasInvisiblePromotion(playerID, unit)
		end
	end
end
----------------------------------------------------------------------------------------------------------------------------
-- Iga_MedievalSpy
----------------------------------------------------------------------------------------------------------------------------
local eraMedievalID = GameInfoTypes["ERA_MEDIEVAL"]
local buildingSpyDummyID = GameInfoTypes["BUILDING_IGA_SPY_DUMMY"]

function IgaMedievalSpy(arg0, playerID)
	local player = Players[playerID]
	if player:IsEverAlive() and player:GetCivilizationType() == civilisationID then
		local currentEraID = player:GetCurrentEra()
		if currentEraID == eraMedievalID then
			local capitalCity = player:GetCapitalCity()
			if capitalCity and not capitalCity:IsHasBuilding(buildingSpyDummyID) then
				capitalCity:SetNumRealBuilding(buildingSpyDummyID, 1)
			end
		end
	end
end

if JFD_IsCivilisationActive(civilisationID) then
	Events.SequenceGameInitComplete.Add(InitIga)
	GameEvents.PlayerDoTurn.Add(IgaPromotionChecksTurn)
	GameEvents.UnitSetXY.Add(IgaPromotionChecksXY)
	Events.SerialEventUnitCreated.Add(IgaPromotionChecksXY)
	Events.SerialEventEraChanged.Add(IgaMedievalSpy)
end
--==========================================================================================================================
--==========================================================================================================================