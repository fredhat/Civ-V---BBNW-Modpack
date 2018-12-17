-- JFD_FranceNapoleon_Functions
-- Author: JFD
-- Heavily Edited By: F0S
--=======================================================================================================================
-- Includes
--=======================================================================================================================
include("FLuaVector.lua")
include("IconSupport")
include("NewSaveUtils.lua"); MY_MOD_NAME = "NapoleonicFrance";
--=======================================================================================================================
-- UTILITIES
--=======================================================================================================================
-- JFD_IsCivilisationActive
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

-- JFD_GetRandom
function JFD_GetRandom(lower, upper)
    return Game.Rand((upper + 1) - lower, "") + lower
end

local unitClassGreatGeneralID = GameInfoTypes["UNITCLASS_GREAT_GENERAL"]

-- JFD_GetGreatGeneralStationedInCity
function JFD_GetGreatGeneralStationedInCity(city)
	local plot = city:Plot()
	for i = 0, plot:GetNumUnits() - 1, 1 do
		local unit = plot:GetUnit(i)
		if unit then
			if unit:GetUnitClassType() == unitClassGreatGeneralID then
				return unit
			end
		end
	end
	return nil
end
--=======================================================================================================================
-- UNIQUE FUNCTIONS	
--=======================================================================================================================
-- GLOBALS
--------------------------------------------------------------------------------------------------------------------------
local activePlayerID	   = Game.GetActivePlayer()
local activePlayer		   = Players[activePlayerID]
local buildingCourthouseID = GameInfoTypes["BUILDING_COURTHOUSE"]
local civilizationID	   = GameInfoTypes["CIVILIZATION_JFD_FRANCE_NAPOLEON"]
local isFranceCivActive    = JFD_IsCivilisationActive(civilizationID)
local isFranceActivePlayer = activePlayer:GetCivilizationType() == civilizationID
----------------------------------------------------------------------------------------------------------------------------
-- SUN OF AUSTERLITZ
----------------------------------------------------------------------------------------------------------------------------	
local unitGeneralID	= GameInfoTypes["UNIT_GREAT_GENERAL"]
local unitFranceGeneralID = GameInfoTypes["UNIT_JFD_GENERAL_FRANCE"]

-- JFD_FranceNapoleon_GreatGeneralPlayerCanTrain
function JFD_FranceNapoleon_GreatGeneralPlayerCanTrain(playerID, unitID)
	return unitID ~= unitFranceGeneralID
end

GameEvents.PlayerCanTrain.Add(JFD_FranceNapoleon_GreatGeneralPlayerCanTrain)

-- JFD_FranceNapoleon_GreatGeneral
function JFD_FranceNapoleon_GreatGeneral(playerID, unitID)
    local player = Players[playerID]
	if player:IsEverAlive() and player:GetCivilizationType() == civilizationID then 
	  	 if player:GetUnitClassCount(unitClassGreatGeneralID) == 0 then return end
		 local unit = player:GetUnitByID(unitID) 
		 if unit and unit:GetUnitType() == unitGeneralID then
			local newUnit = player:InitUnit(unitFranceGeneralID, unit:GetX(), unit:GetY(), UNITAI_GENERAL)
			newUnit:Convert(unit)
	    end
	end
end

-- JFD_FranceNapoleon_GreatGeneralOnWar
function JFD_FranceNapoleon_GreatGeneralOnWar(teamID, otherTeamID)
	local team = Teams[teamID]
	local otherTeam = Teams[otherTeamID]
	if not team:IsMinorCiv() and not otherTeam:IsMinorCiv() then
		for playerID = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do	
			local player = Players[playerID]
			if player:IsEverAlive() and player:GetCivilizationType() == civilizationID then
				if (player:GetTeam() == teamID and team:GetAtWarCount(true) <= 1) or (player:GetTeam() == otherTeamID and otherTeam:GetAtWarCount(true) <= 1) then
					local capital = player:GetCapitalCity()
					if capital then
						player:InitUnit(unitFranceGeneralID, capital:GetX(), capital:GetY(), UNITAI_GENERAL):JumpToNearestValidPlot()
					end
				end
			end
		end
	end
end
-----------------
-- UI
-----------------	
local isCityViewOpen = false

-- JFD_FranceNapoleon_UpdateGGBox
function JFD_FranceNapoleon_UpdateGGBox()
	Controls.FranceNapoleonIBox:SetHide(true)
	Controls.FranceNapoleonIButton:SetDisabled(true)
	Controls.FranceNapoleonIButton:LocalizeAndSetToolTip(nil)
	local city = UI.GetHeadSelectedCity()
	if city and city:IsOccupied() and not city:IsHasBuilding(buildingCourthouseID) then
		local isDisabled = false
		if city:IsRazing() or city:IsPuppet() or not JFD_GetGreatGeneralStationedInCity(city) then
			isDisabled = true
		end
		IconHookup(48, 64, "UNIT_ATLAS_2", Controls.FranceNapoleonIImg)
		Controls.FranceNapoleonIBox:SetHide(false)
		Controls.FranceNapoleonIButton:LocalizeAndSetText("TXT_KEY_JFD_NAPOLEON_GENERAL_EXPEND")
		Controls.FranceNapoleonIButton:LocalizeAndSetToolTip(buttonToolTipDisabled)
		Controls.FranceNapoleonIButton:SetDisabled(isDisabled)
		Controls.FranceNapoleonIButton:LocalizeAndSetToolTip("TXT_KEY_JFD_NAPOLEON_GENERAL_EXPEND_TT_OCCUPIED")		
		if isDisabled then
			Controls.FranceNapoleonIButton:LocalizeAndSetToolTip("TXT_KEY_JFD_NAPOLEON_GENERAL_EXPEND_TT_OCCUPIED_DISABLED")		
		end
	end
end

-- JFD_FranceNapoleon_ExpendGG
function JFD_FranceNapoleon_ExpendGG()
	local city = UI.GetHeadSelectedCity()
	if city then
		local unitGreatGeneral = JFD_GetGreatGeneralStationedInCity(city)
		local hex = ToHexFromGrid(Vector2(city:GetX(), city:GetY()))
		if unitGreatGeneral then
			Events.GameplayFX(hex.x, hex.y, -1)
			unitGreatGeneral:Kill(false, -1)
		end
		city:ChangeResistanceTurns(-city:GetResistanceTurns())
		city:SetNumRealBuilding(buildingCourthouseID, 1)
	end
	JFD_FranceNapoleon_UpdateGGBox()
end

-- JFD_OnEnterCityScreen
function JFD_OnEnterCityScreen()
	isCityViewOpen = true
	JFD_FranceNapoleon_UpdateGGBox()
end

-- JFD_OnExitCityScreen
function JFD_OnExitCityScreen()
	isCityViewOpen = false
	JFD_FranceNapoleon_UpdateGGBox()
end

-- JFD_OnNextCityScren
function JFD_OnNextCityScren()
	if isCityViewOpen then
		JFD_FranceNapoleon_UpdateGGBox()
	end
end

if isFranceCivActive and isFranceActivePlayer then
	Controls.FranceNapoleonIButton:RegisterCallback(Mouse.eLClick, JFD_FranceNapoleon_ExpendGG)
	Events.SerialEventEnterCityScreen.Add(JFD_OnEnterCityScreen)
	Events.SerialEventExitCityScreen.Add(JFD_OnExitCityScreen)
	Events.SerialEventCityScreenDirty.Add(JFD_OnNextCityScren)
end
----------------------------------------------------------------------------------------------------------------------------
-- MARSHAL'S TEACHINGS
----------------------------------------------------------------------------------------------------------------------------
local promotionTeachingsID = GameInfoTypes["PROMOTION_JFD_TEACHINGS"]

-- JFD_StackedGreatGeneralXP
function JFD_StackedGreatGeneralXP(playerID)
	local player = Players[playerID]
	if player:IsEverAlive() then
		for unit in player:Units() do
			if unit:IsHasPromotion(promotionTeachingsID) then
				local plot = unit:GetPlot()
				for i = 0, plot:GetNumUnits() - 1, 1 do
					local plotUnit = plot:GetUnit(i)
					if plotUnit and plotUnit:GetUnitClassType() == unitClassGreatGeneralID then
						unit:ChangeExperience(5)
					end
				end
			end
		end
	end
end

if isFranceCivActive then
	Events.SerialEventUnitCreated.Add(JFD_FranceNapoleon_GreatGeneral)
	GameEvents.DeclareWar.Add(JFD_FranceNapoleon_GreatGeneralOnWar)
	GameEvents.PlayerDoTurn.Add(JFD_StackedGreatGeneralXP)
end
----------------------------------------------------------------------------------------------------------------------------
-- CHEVAU-LEGER
----------------------------------------------------------------------------------------------------------------------------	
local promotionBonusWhenDamagedID = GameInfoTypes["PROMOTION_JFD_BONUS_WHEN_DAMAGED"]

-- JFD_ExtraStrengthFromDamage
function JFD_ExtraStrengthFromDamage(playerID)
	local player = Players[playerID]
	if player:IsEverAlive() then
		for unit in player:Units() do
			if unit:IsHasPromotion(promotionBonusWhenDamagedID) then
				local currentDamage = unit:GetDamage()
				local baseStrength = GameInfo.Units[unit:GetUnitType()].Combat
				local extraStrength = 0
				extraStrength = math.floor(currentDamage / 5)
				if baseStrength ~= (baseStrength + extraStrength) then
					unit:SetBaseCombatStrength(baseStrength + extraStrength)
				else	
					unit:SetBaseCombatStrength(baseStrength)
				end
			end
		end
	end
end

function JFD_ExtraStrengthFromDamageDirty()
	local playerID = Game.GetActivePlayer()
    local player = Players[playerID]
	if player:IsTurnActive() then
        JFD_ExtraStrengthFromDamage(playerID)
    end
end

function JFD_ExtraStrengthFromDamageInitialTrigger(playerID, unitID)
	local player = Players[playerID]
	local unit = player:GetUnitByID(unitID)
	if unit and unit:IsHasPromotion(promotionBonusWhenDamagedID) then
		GameEvents.PlayerDoTurn.Add(JFD_ExtraStrengthFromDamage)
		Events.SerialEventGameDataDirty.Add(JFD_ExtraStrengthFromDamageDirty) 
		Events.SerialEventUnitCreated.Remove(JFD_ExtraStrengthFromDamageInitialTrigger)
		SetPersistentProperty("JFD_ExtraStrengthFromDamageInitalised", true)
	end
end

if GetPersistentProperty("JFD_ExtraStrengthFromDamageInitalised") then
	GameEvents.PlayerDoTurn.Add(JFD_ExtraStrengthFromDamage)
	Events.SerialEventGameDataDirty.Add(JFD_ExtraStrengthFromDamageDirty) 
else
	Events.SerialEventUnitCreated.Add(JFD_ExtraStrengthFromDamageInitialTrigger)
end
--==========================================================================================================================
--==========================================================================================================================