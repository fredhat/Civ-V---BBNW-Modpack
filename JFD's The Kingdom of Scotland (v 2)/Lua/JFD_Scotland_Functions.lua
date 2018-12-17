-- JFD_ScotlandFunctions
-- Author: JFD
-- Heavily Edited By: F0S
--=======================================================================================================================
-- UTILITY FUNCTIONS	
--=======================================================================================================================
-- JFD_IsCivilisationActive
------------------------------------------------------------------------------------------------------------------------
include("FLuaVector.lua")

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
-- Globals
----------------------------------------------------------------------------------------------------------------------------
local civilisationID = GameInfoTypes["CIVILIZATION_JFD_SCOTLAND"]
local isScotlandCivActive = JFD_IsCivilisationActive(civilisationID)
------------------------------------------------------------------------------------------------------------------------
-- JFD_ScottishGreatPeoplePoints
------------------------------------------------------------------------------------------------------------------------
local buildingScottishWriterSID = GameInfoTypes["BUILDING_JFD_SCOTTISH_WRITERS"]
local specialistEngineerID = GameInfoTypes["SPECIALIST_ENGINEER"]
local specialistMerchantID = GameInfoTypes["SPECIALIST_MERCHANT"]
local specialistScientistID = GameInfoTypes["SPECIALIST_SCIENTIST"]

function JFD_ScottishGreatPeoplePoints(playerID)
	local player = Players[playerID]
	if player:IsEverAlive() and player:GetCivilizationType() == civilisationID then
		for city in player:Cities() do
			if player:IsGoldenAge() then
				local numGWP = 0
				if city:GetSpecialistCount(specialistEngineerID) > 0 then
					numGWP = numGWP + city:GetSpecialistCount(specialistEngineerID)
				end
				if city:GetSpecialistCount(specialistMerchantID) > 0 then
					numGWP = numGWP + city:GetSpecialistCount(specialistMerchantID)
				end
				if city:GetSpecialistCount(specialistScientistID) > 0 then
					numGWP = numGWP + city:GetSpecialistCount(specialistScientistID)
				end
				city:SetNumRealBuilding(buildingScottishWriterSID, numGWP)
			else
				city:SetNumRealBuilding(buildingScottishWriterSID, 0)
			end
		end
	end
end

function JFD_ScottishGreatPeoplePointsDirty()
	local playerID = Game.GetActivePlayer()
    local player = Players[playerID]
	if player:IsTurnActive() then
        JFD_ScottishGreatPeoplePoints(playerID)
    end
end
------------------------------------------------------------------------------------------------------------------------
-- JFD_ScottishGreatPeopleGoldenAges
------------------------------------------------------------------------------------------------------------------------
local promotionScottishGPID = GameInfoTypes["PROMOTION_JFD_SCOTTISH_GP"]

function JFD_ScottishGreatPeopleGoldenAges(playerID, unitID)
    local player = Players[playerID]
    if player:IsEverAlive() and player:GetCivilizationType() == civilisationID then 
		local unit = player:GetUnitByID(unitID)
       	if unit and unit:IsGreatPerson() and not unit:IsHasPromotion(promotionScottishGPID) then	
			local goldenAgeBoost = math.ceil(player:GetGoldenAgeProgressThreshold() * 15 / 100)
			if not player:IsGoldenAge() then
				player:ChangeGoldenAgeProgressMeter(goldenAgeBoost)
				if player:IsHuman() and player:IsTurnActive() and goldenAgeBoost > 0 then
					local hex = ToHexFromGrid(Vector2(unit:GetX(), unit:GetY()))
					Events.AddPopupTextEvent(HexToWorld(hex), Locale.ConvertTextKey("[COLOR_POSITIVE_TEXT]+{1_Num}[ENDCOLOR] [ICON_GOLDEN_AGE]", goldenAgeBoost), 1)
					Events.GameplayFX(hex.x, hex.y, -1)
				end
			end
			unit:SetHasPromotion(promotionScottishGPID, true)
		end
    end
end
------------------------------------------------------------------------------------------------------------------------
-- JFD_CollegeGoldenAges
------------------------------------------------------------------------------------------------------------------------
local buildingClassUniversityID = GameInfoTypes["BUILDINGCLASS_UNIVERSITY"]
local buildingCollegeID = GameInfoTypes["BUILDING_JFD_COLLEGE"]
local buildingScottishCollegeID = GameInfoTypes["BUILDING_JFD_SCOTTISH_COLLEGE"]

function JFD_CollegeGoldenAges(playerID)
	local player = Players[playerID]
	if player:IsEverAlive() and player:GetCivilizationType() == civilisationID then
		for city in player:Cities() do
			if city:IsHasBuilding(buildingCollegeID) and city:GetNumGreatWorksInBuilding(buildingClassUniversityID) > 0 then
				local numFullColleges = player:CountNumBuildings(buildingScottishCollegeID)
				if numFullColleges < 5 then
					city:SetNumRealBuilding(buildingScottishCollegeID, 1)
				elseif numFullColleges > 5 then
					city:SetNumRealBuilding(buildingScottishCollegeID, 0)
				end
			else
				city:SetNumRealBuilding(buildingScottishCollegeID, 0)
			end
		end
	end
end

function JFD_CollegeGoldenAgesDirty()
	local playerID = Game.GetActivePlayer()
    local player = Players[playerID]
	if player:IsTurnActive() then
        JFD_CollegeGoldenAges(playerID)
    end
end
------------------------------------------------------------------------------------------------------------------------
-- JFD_HighlanderXP
------------------------------------------------------------------------------------------------------------------------
local greatWorkLiteratureID = GameInfoTypes["GREAT_WORK_SLOT_LITERATURE"]
local promotionHighlanderXPInfoID = GameInfoTypes["PROMOTION_JFD_HIGHLANDER_XP_INFO"]
local promotionHighlanderXPID = GameInfoTypes["PROMOTION_JFD_HIGHLANDER_XP"]

function JFD_HighlanderXP(playerID, cityID, unitID)
    local player = Players[playerID]
    if player:IsEverAlive() and player:GetCivilizationType() == civilisationID then 
		local unit = player:GetUnitByID(unitID)
       	if unit and unit:IsHasPromotion(promotionHighlanderXPInfoID) then
			local city = player:GetCityByID(cityID)
			if city then
				local greatWorksXP = city:GetNumGreatWorks(greatWorkLiteratureID) * 10
				if greatWorksXP > 0 then
					unit:ChangeExperience(unit:GetExperience() + greatWorksXP)
				end
			end
			unit:SetHasPromotion(promotionHighlanderXPID,true)
			unit:SetHasPromotion(promotionHighlanderXPInfoID,false)
		end
    end
end

if isScotlandCivActive then
	GameEvents.PlayerDoTurn.Add(JFD_ScottishGreatPeoplePoints)
	Events.SerialEventGameDataDirty.Add(JFD_ScottishGreatPeoplePointsDirty)
	Events.SerialEventUnitCreated.Add(JFD_ScottishGreatPeopleGoldenAges)
	GameEvents.PlayerDoTurn.Add(JFD_CollegeGoldenAges)
	Events.SerialEventGameDataDirty.Add(JFD_CollegeGoldenAgesDirty)
	GameEvents.CityTrained.Add(JFD_HighlanderXP)
end
--==========================================================================================================================
--==========================================================================================================================