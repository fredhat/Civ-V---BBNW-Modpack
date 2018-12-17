-- Nicholas Russia Functions
-- Author: JFD
-- Heavily Edited By: F0S
--==========================================================================================================================
-- UTILITY FUNCTIONS
--==========================================================================================================================
WARN_NOT_SHARED = false; include( "Sukritact_SaveUtils.lua" ); MY_MOD_NAME = "JFD_RussiaNicholasII"
--------------------------------------------------------------
-- JFD_IsCivilisationActive
--------------------------------------------------------------
local civilisationID = GameInfoTypes["CIVILIZATION_JFD_NICHOLAS_RUSSIA"]

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
-- JFD_FaithFromWLTKD
----------------------------------------------------------------------------------------------------------------------------
local buildingWLTKDFaithID = GameInfoTypes["BUILDING_JFD_WLTKD_FAITH"]
local buildingWonderProductionID = GameInfoTypes["BUILDING_JFD_WONDER_PRODUCTION"]

function JFD_GetWeLoveTheKingDayCounter(player)
	local numCitiesWLTKD = 0
	for city in player:Cities() do
		if not city:IsCapital() and city:GetWeLoveTheKingDayCounter() > 0 then
			numCitiesWLTKD = numCitiesWLTKD + 1
		end
	end
	return math.min(numCitiesWLTKD, 4)
end

function JFD_FaithFromWLTKD(playerID)
	local player = Players[playerID]
    if player:IsEverAlive() and player:GetCivilizationType() == civilisationID then 
		local capital = player:GetCapitalCity()
		if capital then
			local numCitiesWLTKD = JFD_GetWeLoveTheKingDayCounter(player)
			local capitalFaith = capital:GetFaithPerTurn()
			local capitalWLTKDFaith = capital:GetNumBuilding(buildingWLTKDFaithID)
			local faithAmount = math.floor((capitalFaith - capitalWLTKDFaith) * (numCitiesWLTKD * .25))
			capital:SetNumRealBuilding(buildingWLTKDFaithID, faithAmount)
			capital:SetNumRealBuilding(buildingWonderProductionID, math.min(math.floor(capitalFaith * .25), 20))
		end
	end
end

function JFD_FaithFromWLTKDDirty()
	local playerID = Game.GetActivePlayer()
    local player = Players[playerID]
	if player:IsTurnActive() then
        JFD_FaithFromWLTKD(playerID)
    end
end
----------------------------------------------------------------------------------------------------------------------------
-- JFD_GuberniyaGrowthProduction
----------------------------------------------------------------------------------------------------------------------------
local buildingGuberniyaID = GameInfoTypes["BUILDING_JFD_GUBERNIYA"]
local buildingGuberniyaGrowthID = GameInfoTypes["BUILDING_JFD_GUBERNIYA_GROWTH"]
local buildingGuberniyaProductionID = GameInfoTypes["BUILDING_JFD_GUBERNIYA_PRODUCTION"]

function JFD_GetNumberDomesticRoutesToCapital(playerID)
	local player = Players[playerID]
	local tradeRoutes = player:GetTradeRoutes()
	local numDomesticRoutes = 0
	for i, v in ipairs(tradeRoutes) do
		if v.FromID == playerID then
			if v.FromID == v.ToID then
				local originatingCity = v.FromCity
				local targetCity = v.ToCity
				if targetCity:IsCapital() then
					if originatingCity:IsHasBuilding(buildingGuberniyaID) then
						numDomesticRoutes = numDomesticRoutes + 1
					end
				end
			end
		end
	end
	return math.min(numDomesticRoutes, 4)
end

function JFD_GuberniyaGrowthProduction(playerID)
	local player = Players[playerID]
    if player:IsEverAlive() then 
		for city in player:Cities() do
			if city:IsCapital() then
				local numDomesticRoutes = JFD_GetNumberDomesticRoutesToCapital(playerID)
				city:SetNumRealBuilding(buildingGuberniyaProductionID, numDomesticRoutes) 
				if city:IsHasBuilding(buildingGuberniyaID) then
					city:SetNumRealBuilding(buildingGuberniyaGrowthID, 0)
				end
			else
				if city:IsHasBuilding(buildingGuberniyaID) then
					if player:IsCapitalConnectedToCity(city) then
						city:SetNumRealBuilding(buildingGuberniyaGrowthID, 1) 
					else
						city:SetNumRealBuilding(buildingGuberniyaGrowthID, 0) 
					end
				else
					city:SetNumRealBuilding(buildingGuberniyaGrowthID, 0)
				end
				city:SetNumRealBuilding(buildingGuberniyaProductionID, 0) 
			end
		end
	end
end

function JFD_GuberniyaGrowthProductionDirty()
	local playerID = Game.GetActivePlayer()
    local player = Players[playerID]
	if player:IsTurnActive() then
        JFD_GuberniyaGrowthProduction(playerID)
    end
end

function JFD_GuberniyaGrowthProductionInitialTrigger(playerID, cityID, buildingID)
	local player = Players[playerID]
	if player:GetCityByID(cityID):IsHasBuilding(buildingGuberniyaID) then
		GameEvents.PlayerDoTurn.Add(JFD_GuberniyaGrowthProduction)
		Events.SerialEventGameDataDirty.Add(JFD_GuberniyaGrowthProductionDirty)
		GameEvents.CityConstructed.Remove(JFD_GuberniyaGrowthProductionInitialTrigger)
		save("GAME", "JFD_GuberniyaGrowthProductionInitalised", true)
		JFD_GuberniyaGrowthProduction(playerID)
	end
end
----------------------------------------------------------------------------------------------------------------------------
-- JFD_DoubleOpolcheniye
----------------------------------------------------------------------------------------------------------------------------
local unitOpolcheniyeID = GameInfoTypes["UNIT_JFD_OPOLCHENIYE"]
local promotionOpolcheniyeID = GameInfoTypes["PROMOTION_JFD_OPOLCHENIYE"]

function JFD_DoubleOpolcheniye(playerID, unitID)
    local player = Players[playerID]
    if player:IsEverAlive() and player:GetCivilizationType() == civilisationID then 
       	local unit = player:GetUnitByID(unitID)
		if unit and unit:GetUnitType() == unitOpolcheniyeID and not unit:IsHasPromotion(promotionOpolcheniyeID) then
			local newUnit = player:InitUnit(unitOpolcheniyeID, unit:GetX(), unit:GetY(), UNITAI_DEFENSE)
		    newUnit:JumpToNearestValidPlot()
			newUnit:SetLevel(unit:GetLevel())
			newUnit:SetExperience(unit:GetExperience())
			for unitPromotion in GameInfo.UnitPromotions() do
				if unit:IsHasPromotion(unitPromotion.ID) and not newUnit:IsHasPromotion(unitPromotion.ID) then
					newUnit:SetHasPromotion(unitPromotion.ID, true)
				end
			end
			unit:SetHasPromotion(promotionOpolcheniyeID, true)
			newUnit:SetHasPromotion(promotionOpolcheniyeID, true)
         end
    end
end

if JFD_IsCivilisationActive(civilisationID) then
	GameEvents.PlayerDoTurn.Add(JFD_FaithFromWLTKD)
	Events.SerialEventGameDataDirty.Add(JFD_FaithFromWLTKDDirty)
	if load("GAME", "JFD_GuberniyaGrowthProductionInitalised") then
		GameEvents.PlayerDoTurn.Add(JFD_GuberniyaGrowthProduction)
		Events.SerialEventGameDataDirty.Add(JFD_GuberniyaGrowthProductionDirty)
	else
		GameEvents.CityConstructed.Add(JFD_GuberniyaGrowthProductionInitialTrigger)
	end
	Events.SerialEventUnitCreated.Add(JFD_DoubleOpolcheniye)
end
--==========================================================================================================================
--==========================================================================================================================