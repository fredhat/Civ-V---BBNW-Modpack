-- Leninist Russia Functions
-- Author: JFD
-- Heavily Edited By: F0S
--=======================================================================================================================
-- UTILITY FUNCTIONS
--=======================================================================================================================
WARN_NOT_SHARED = false; include( "Sukritact_SaveUtils.lua" ); MY_MOD_NAME = "JFD_LeninistSovietUnion";
local civilisationID = GameInfoTypes["CIVILIZATION_JFD_USSR_LENIN"]

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
--=======================================================================================================================
-- CORE FUNCTIONS	
--=======================================================================================================================
-- JFD_LeninSocialism
--------------------------------------------------------------------------------------------------------------------------
local unitClassWorkerID = GameInfoTypes["UNITCLASS_WORKER"]
local buildingWorkerProductionID = GameInfoTypes["BUILDING_JFD_WORKER_PRODUCTION"]

function JFD_LeninSocialism(playerID)
	local player = Players[playerID]
    if player:IsEverAlive() and player:GetCivilizationType() == civilisationID then 
		for city in player:Cities() do
			local plot = city:Plot()
			if plot then
				local workerPresent = false
				for i = 0, plot:GetNumUnits() - 1 do
					local unit = plot:GetUnit(i)
					if unit and unit:GetUnitClassType() == unitClassWorkerID then
						workerPresent = true
						break
					end
				end
				if workerPresent then
					if not city:IsHasBuilding(buildingWorkerProductionID) then
						city:SetNumRealBuilding(buildingWorkerProductionID, 1)
					end
				else
					if city:IsHasBuilding(buildingWorkerProductionID) then
						city:SetNumRealBuilding(buildingWorkerProductionID, 0)
					end
				end
			end
		end
	end
end

function JFD_LeninSocialismDirty()
	local playerID = Game.GetActivePlayer()
    local player = Players[playerID]
	if player:IsTurnActive() then
        JFD_LeninSocialism(playerID)
    end
end
--------------------------------------------------------------------------------------------------------------------------
-- JFD_LeninWorkerTraining
--------------------------------------------------------------------------------------------------------------------------
local unitLeninWorkerID = GameInfoTypes["UNIT_JFD_LENIN_WORKER"]

function JFD_LeninWorkerTraining(playerID, unitID)
	local player = Players[playerID]
    if unitID == unitLeninWorkerID then 
		return 
	end
	return true
end

GameEvents.PlayerCanTrain.Add(JFD_LeninWorkerTraining)
--------------------------------------------------------------------------------------------------------------------------
-- JFD_LeninWorkerConversion
--------------------------------------------------------------------------------------------------------------------------
local unitWorkerID = GameInfoTypes["UNIT_WORKER"]
local policyBranchAutocracyID = GameInfoTypes["POLICY_BRANCH_AUTOCRACY"]
local policyBranchFreedomID = GameInfoTypes["POLICY_BRANCH_FREEDOM"]
local policyBranchOrderID = GameInfoTypes["POLICY_BRANCH_ORDER"]

function JFD_LeninWorkerConversion(playerID, unitID)
    local player = Players[playerID]
    if player:IsEverAlive() and player:GetCivilizationType() == civilisationID then 
       	 local unit = player:GetUnitByID(unitID)
		 if unit and unit:GetUnitType() == unitWorkerID then
			if player:IsPolicyBranchUnlocked(policyBranchAutocracyID) or player:IsPolicyBranchUnlocked(policyBranchFreedomID) or player:IsPolicyBranchUnlocked(policyBranchOrderID) then
				local newUnit = player:InitUnit(unitLeninWorkerID, unit:GetX(), unit:GetY(), UNITAI_WORKER)
				newUnit:Convert(unit)
			end
         end
    end
end

function JFD_LeninIdeologyAdoption(playerID, policyTypeID)
	local player = Players[playerID]
	if player:IsEverAlive() and player:GetCivilizationType() == civilisationID then
		if player:IsPolicyBranchUnlocked(policyBranchAutocracyID) or player:IsPolicyBranchUnlocked(policyBranchFreedomID) or player:IsPolicyBranchUnlocked(policyBranchOrderID) then
			for unit in player:Units() do
				if unit and unit:GetUnitType() == unitWorkerID then
					local newUnit = player:InitUnit(unitLeninWorkerID, unit:GetX(), unit:GetY(), UNITAI_WORKER)
					newUnit:Convert(unit)
				end
			end
		end
	end
end
--------------------------------------------------------------------------------------------------------------------------
-- JFD_LeninComissariat
--------------------------------------------------------------------------------------------------------------------------
local buildingLeninCommissariatID = GameInfoTypes["BUILDING_JFD_LENIN_COMMISSARIAT"]
local buildingLeninFoodID = GameInfoTypes["BUILDING_JFD_LENIN_FOOD"]

function JFD_LeninComissariat(playerID)
	local player = Players[playerID]
    if player:IsEverAlive() then 
		for city in player:Cities() do
			if city:IsHasBuilding(buildingLeninCommissariatID) then
				local cityProduction = math.min(20, city:GetYieldRate(YieldTypes.YIELD_PRODUCTION))
				if city:GetNumBuilding(buildingLeninFoodID) ~= cityProduction then
					city:SetNumRealBuilding(buildingLeninFoodID, cityProduction)
				end
			else
				if city:IsHasBuilding(buildingLeninFoodID) then
					city:SetNumRealBuilding(buildingLeninFoodID, 0)
				end
			end
		end
	end
end

function JFD_LeninComissariatDirty()
	local playerID = Game.GetActivePlayer()
    local player = Players[playerID]
	if player:IsTurnActive() then
        JFD_LeninComissariat(playerID)
    end
end

function JFD_LeninComissariatInitialTrigger(playerID, cityID, buildingID)
	local player = Players[playerID]
	local city = player:GetCityByID(cityID)
	if city and city:IsHasBuilding(buildingLeninCommissariatID) then
		GameEvents.PlayerDoTurn.Add(JFD_LeninComissariat)
		Events.SerialEventGameDataDirty.Add(JFD_LeninComissariatDirty)
		GameEvents.CityConstructed.Remove(JFD_LeninComissariatInitialTrigger)
		save("GAME", "JFD_LeninComissariatInitalised", true)
		JFD_LeninComissariat(playerID)
	end
end

if JFD_IsCivilisationActive(civilisationID) then
	GameEvents.PlayerDoTurn.Add(JFD_LeninSocialism)
	Events.SerialEventGameDataDirty.Add(JFD_LeninSocialismDirty)
	Events.SerialEventUnitCreated.Add(JFD_LeninWorkerConversion)
	GameEvents.PlayerAdoptPolicy.Add(JFD_LeninIdeologyAdoption)
	if load("GAME", "JFD_LeninComissariatInitalised") then
		GameEvents.PlayerDoTurn.Add(JFD_LeninComissariat)
		Events.SerialEventGameDataDirty.Add(JFD_LeninComissariatDirty)
	else
		GameEvents.CityConstructed.Add(JFD_LeninComissariatInitialTrigger)
	end
end
--==========================================================================================================================
--==========================================================================================================================