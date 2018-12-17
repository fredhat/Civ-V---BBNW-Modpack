-- Hypereon_SecondFrenchFunctions
-- Author: Hypereon
-- Edited By: F0S
--------------------------------------------------------------
WARN_NOT_SHARED = false; include( "Sukritact_SaveUtils.lua" ); MY_MOD_NAME = "Hypereon_SecondFrenchFunctions";
include("UniqueDiplomacyUtils.lua")
include("FLuaVector.lua")
--------------------------------------------------------------
-- JFD_IsCivilizationActive
--------------------------------------------------------------
function JFD_IsCivilizationActive(civilizationID)
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

function JFD_GetNumRealPolicies(player)
	local numPolicies = 0
	for row in GameInfo.Policies() do
		local policy = GameInfoTypes[row.Type]
		if (row.CultureCost > 0) and player:HasPolicy(policy) then
			numPolicies = numPolicies + 1
		end
	end
	return numPolicies
end

local activePlayerID= Game.GetActivePlayer()
local activePlayer = Players[activePlayerID]
local civilizationID = GameInfoTypes["CIVILIZATION_HYPEREON_SECONDFRANCE"]
local isSecondFranceCivActive = JFD_IsCivilizationActive(civilizationID)
--==========================================================================================================================
-- DIPLOMACY FUNCTIONS
--==========================================================================================================================
-- DIPLOMACY - JFD as example
----------------------------------------------------------------------------------------------------------------------------
local BismarckID = GameInfoTypes["CIVILIZATION_GERMANY"]
local NapoleonID = GameInfoTypes["CIVILIZATION_FRANCE"]
local JuarezID = GameInfoTypes["CIVILIZATION_MEXICOREPUBLIC"]

function Hypereon_NapoleonIIIUniqueResponses()
	-- If the player is Bismarck
	if BismarckID and activePlayer:GetLeaderType() == BismarckID then
		ChangeDiplomacyResponse("LEADER_HYPEREON_NAPOLEONIII", "RESPONSE_FIRST_GREETING", "TXT_KEY_LEADER_HYPEREON_NAPOLEONIII_FIRSTGREETING%", "TXT_KEY_LEADER_HYPEREON_NAPOLEONIII_FIRSTGREETING_BISMARCK%", 500)
	end
	-- If the player is Napoleon
	if NapoleonID and activePlayer:GetLeaderType() == NapoleonID then
		ChangeDiplomacyResponse("LEADER_HYPEREON_NAPOLEONIII", "RESPONSE_FIRST_GREETING", "TXT_KEY_LEADER_HYPEREON_NAPOLEONIII_FIRSTGREETING%", "TXT_KEY_LEADER_HYPEREON_NAPOLEONIII_FIRSTGREETING_NAPOLEON%", 500)
	end
	-- If the player is CL's Benito Juarez
	if JuarezID and activePlayer:GetLeaderType() == JuarezID then
		ChangeDiplomacyResponse("LEADER_HYPEREON_NAPOLEONIII", "RESPONSE_FIRST_GREETING", "TXT_KEY_LEADER_HYPEREON_NAPOLEONIII_FIRSTGREETING%", "TXT_KEY_LEADER_HYPEREON_NAPOLEONIII_FIRSTGREETING_JUAREZ%", 500)
	end
end

for playerID = 0, GameDefines.MAX_MAJOR_CIVS - 1, 1 do
	local player = Players[playerID]
	if player and player:IsEverAlive() and not player:IsHuman() and player:GetCivilizationType() == civilizationID then
		Events.SequenceGameInitComplete.Add(Hypereon_NapoleonIIIUniqueResponses)
		break
	end
end
----------------------------------------------------------------------------------------------------------------------------
-- NAPOLEON III TRAIT (JFD as reference)
----------------------------------------------------------------------------------------------------------------------------
local buildingHypereonSecondFranceTraitID = GameInfoTypes["BUILDING_HYPEREON_SECONDFRANCE_TRAIT"]

-- Disabled for balance reasons
--[[
function Hypereon_GoldenAgePointsFromCapture(oldOwnerID, capital, cityX, cityY, newOwnerID)
	local player = Players[newOwnerID]
	if player:IsEverAlive() and player:GetCivilizationType() == civilizationID then
		local capturedCity = Map.GetPlot(cityX, cityY):GetPlotCity()
		local cityPopulation = capturedCity:GetPopulation()
		player:ChangeGoldenAgeProgressMeter(math.ceil(cityPopulation * 25))
	end
end
]]--

function Hypereon_GoldenAgePointsFromPolicies(playerID)
	local player = Players[playerID]
	if player:IsEverAlive() and player:GetCivilizationType() == civilizationID then
		local numGAPoints = (JFD_GetNumRealPolicies(player) * 15)
		if not player:IsGoldenAge() then
			player:ChangeGoldenAgeProgressMeter(numGAPoints)
			if player:IsHuman() and player:IsTurnActive() then
				local capital = player:GetCapitalCity()
				if capital then
					local hex = ToHexFromGrid(Vector2(capital:GetX(), capital:GetY()))
					Events.AddPopupTextEvent(HexToWorld(hex), Locale.ConvertTextKey("[COLOR_POSITIVE_TEXT]+{1_Num}[ENDCOLOR] [ICON_GOLDEN_AGE]", numGAPoints), 1)
					Events.GameplayFX(hex.x, hex.y, -1)
				end
			end
		end
	end
end

function Hypereon_SecondFranceTrait(playerID)
	local player = Players[playerID]
    if player:IsEverAlive() and player:GetCivilizationType() == civilizationID then 
		if player:IsGoldenAge() then
			for city in player:Cities() do
				if city:IsCapital() then
					if not city:IsHasBuilding(buildingHypereonSecondFranceTraitID) then
						city:SetNumRealBuilding(buildingHypereonSecondFranceTraitID, 1)
					end
				else
					if city:IsHasBuilding(buildingHypereonSecondFranceTraitID) then
						city:SetNumRealBuilding(buildingHypereonSecondFranceTraitID, 0)
					end
				end
			end
		else
			for city in player:Cities() do
				if city:IsHasBuilding(buildingHypereonSecondFranceTraitID) then
					city:SetNumRealBuilding(buildingHypereonSecondFranceTraitID, 0)
				end
			end
		end
	end
end

function Hypereon_SecondFranceTraitDirty()
	local iPlayer = Game.GetActivePlayer()
    local pPlayer = Players[iPlayer]
	if pPlayer:IsTurnActive() then
        Hypereon_SecondFranceTrait(iPlayer)
    end
end
----------------------------------------------------------
--GRANDE-ECOLE--------------------------------------------
----------------------------------------------------------
local buildingHypereonGrandeEcoleID = GameInfoTypes["BUILDING_HYPEREON_GRANDE_ECOLE"]
local buildingHypereonGrandeEcoleBaseID = GameInfoTypes["BUILDING_HYPEREON_GRANDE_ECOLE_BASE"]
local buildingHypereonGrandeEcoleScienceID = GameInfoTypes["BUILDING_HYPEREON_GRANDE_ECOLE_SCIENCE"]
local buildingHypereonGrandeEcoleMilitaryID = GameInfoTypes["BUILDING_HYPEREON_GRANDE_ECOLE_MILITARY"]
local buildingHypereonGrandeEcoleEconomyID = GameInfoTypes["BUILDING_HYPEREON_GRANDE_ECOLE_ECONOMY"]

function Hypereon_BlockGrandeEcoleSell(playerID, buildingID)
	if buildingID == buildingHypereonGrandeEcoleID or buildingID == buildingHypereonGrandeEcoleScienceID or buildingID == buildingHypereonGrandeEcoleMilitaryID or buildingID == buildingHypereonGrandeEcoleEconomyID then
		return
	end
	return true
end

function Hypereon_GrandeEcole(playerID, cityID, buildingID)
	local player = Players[playerID]
	if player:IsEverAlive() and player:GetCivilizationType() == civilizationID then
		if buildingID == buildingHypereonGrandeEcoleID then
			local city = player:GetCityByID(cityID)
			if city:IsHasBuilding(buildingHypereonGrandeEcoleID) then
				city:SetNumRealBuilding(buildingHypereonGrandeEcoleBaseID, 1)
			else
				city:SetNumRealBuilding(buildingHypereonGrandeEcoleBaseID, 0)
			end
		end
	end
end

if isSecondFranceCivActive then
	--GameEvents.CityCaptureComplete.Add(Hypereon_GoldenAgePointsFromCapture)
	GameEvents.PlayerAdoptPolicy.Add(Hypereon_GoldenAgePointsFromPolicies)
	--GameEvents.PlayerAdoptPolicyBranch.Add(Hypereon_GoldenAgePointsFromPolicies)
	GameEvents.PlayerDoTurn.Add(Hypereon_SecondFranceTrait)
	Events.SerialEventGameDataDirty.Add(Hypereon_SecondFranceTraitDirty)
	GameEvents.CityBuildingsIsBuildingSellable.Add(Hypereon_BlockGrandeEcoleSell)
	GameEvents.CityConstructed.Add(Hypereon_GrandeEcole)
end
----------------------------------------------------------
--ZOUAVE--------------------------------------------------
----------------------------------------------------------
local ColonialDraft = GameInfo.UnitPromotions["PROMOTION_HYPEREON_COLONIAL_DRAFT"].ID

function Hypereon_CountNapoleonPuppets(player)
	local iNumNapoleonPuppets = 0
	for city in player:Cities() do
		if city:IsPuppet() then
			iNumNapoleonPuppets = iNumNapoleonPuppets + 1
		end
	end
	return iNumNapoleonPuppets
end

function ColonialDraftCalc(playerID)
	local player = Players[playerID]
	if player:IsEverAlive() then
		local iNumNapoleonPuppets = math.min(Hypereon_CountNapoleonPuppets(player),10)
		for unit in player:Units() do 
			if unit:IsHasPromotion(ColonialDraft) then
				unit:SetBaseCombatStrength(GameInfo.Units[unit:GetUnitType()].Combat + iNumNapoleonPuppets)
			end
		end
	end
end

function ColonialDraftCalcInitialTrigger(playerID, unitID)
	local player = Players[playerID]
	local unit = player:GetUnitByID(unitID)
	if unit and unit:IsHasPromotion(ColonialDraft) then
		GameEvents.PlayerDoTurn.Add(ColonialDraftCalc)
		GameEvents.UnitSetXY.Add(ColonialDraftCalc)
		Events.SerialEventUnitCreated.Add(ColonialDraftCalc)
		Events.SerialEventUnitCreated.Remove(ColonialDraftCalcInitialTrigger)
		save("GAME", "ColonialDraftCalcInitalised", true)
		ColonialDraftCalc(playerID)
	end
end

if load("GAME", "ColonialDraftCalcInitalised") then
	GameEvents.PlayerDoTurn.Add(ColonialDraftCalc)
	GameEvents.UnitSetXY.Add(ColonialDraftCalc)
	Events.SerialEventUnitCreated.Add(ColonialDraftCalc)
else
	Events.SerialEventUnitCreated.Add(ColonialDraftCalcInitialTrigger)
end
----------------------------------------------------------
----------------------------------------------------------