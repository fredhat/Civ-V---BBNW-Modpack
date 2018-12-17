-- Tuscany_CoreFunctions
-- Author: Sukritact
-- Heavily Edited By: F0S
--=======================================================================================================================
WARN_NOT_SHARED = false; include( "Sukritact_SaveUtils.lua" ); MY_MOD_NAME = "TuscanUA";
include("FLuaVector.lua")
--=======================================================================================================================
-- Utility Functions
--=======================================================================================================================
-- JFD_IsCivilisationActive
-------------------------------------------------------------------------------------------------------------------------
local iCiv = GameInfoTypes["CIVILIZATION_TUSCANY"]

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
-------------------------------------------------------------------------------------------------------------------------
-- IsBuildingReal
-------------------------------------------------------------------------------------------------------------------------
function IsBuildingReal(iBuilding)
    if GameInfo.Buildings[iBuilding].GreatWorkCount == -1 or (GameInfo.Buildings[iBuilding].PrereqTech == nil and (GameInfo.Buildings[iBuilding].FaithCost == -1 and GameInfo.Buildings[iBuilding].Cost == -1)) then
        return false
    else
        return true
    end
end
--=======================================================================================================================
-- Tuscan UA: Cradle of the Renaissance
--=======================================================================================================================
-- Cradle of the Renaissance: Initial Processes
-------------------------------------------------------------------------------------------------------------------------
local tGreatPeople = {}
tGreatPeople.GREAT_WORK_SLOT_MUSIC = GameInfoTypes.UNIT_MUSICIAN
tGreatPeople.GREAT_WORK_SLOT_LITERATURE = GameInfoTypes.UNIT_WRITER
tGreatPeople.GREAT_WORK_SLOT_ART_ARTIFACT = GameInfoTypes.UNIT_ARTIST
local tBuildings = {}
local iMissionCreateGreatWork = GameInfoTypes.MISSION_CREATE_GREAT_WORK
local iBuildingDuomo = GameInfoTypes.BUILDING_DUOMO
-------------------------------------------------------------------------------------------------------------------------
-- Cradle of the Renaissance: Main Code
-------------------------------------------------------------------------------------------------------------------------
function TuscanUA(pPlayer)
	local pCity = pPlayer:GetCapitalCity()
	if pCity then
		for iBuilding, sVal in pairs(tBuildings) do
			if pCity:IsHasBuilding(iBuilding) then
				if pCity:IsCapital() then
					if load(pPlayer, iBuilding) == nil then
						local iGreatWorks = GameInfo.Buildings[iBuilding].GreatWorkCount
						if iGreatWorks > 0 then
							for i = 1, iGreatWorks do
								pPlayer:InitUnit(tGreatPeople[sVal], pCity:GetX(), pCity:GetY()):PushMission(iMissionCreateGreatWork)
							end
							save(pPlayer, iBuilding, true)
						end
					end
				else
					if iBuilding == iBuildingDuomo and load(pPlayer, "DuomoGW") == nil then
						pPlayer:InitUnit(tGreatPeople[sVal], pCity:GetX(), pCity:GetY()):PushMission(iMissionCreateGreatWork)
						save(pPlayer, "DuomoGW", true)
					end
				end
			end
		end
	end
end

function TuscanUATrigger1(iPlayer)
	local pPlayer = Players[iPlayer]
	if pPlayer:IsEverAlive() and pPlayer:GetCivilizationType() == iCiv then
		TuscanUA(pPlayer)
	end
end

function TuscanUATrigger2(iPlayer, iCity, iType)
	if iType ~= CityUpdateTypes.CITY_UPDATE_TYPE_PRODUCTION then return end
	local pPlayer = Players[iPlayer]
	if pPlayer:IsEverAlive() and pPlayer:GetCivilizationType() == iCiv then
		TuscanUA(pPlayer)
	end
end

if JFD_IsCivilisationActive(iCiv) then
	for Building in GameInfo.Buildings() do
		iBuilding = Building.ID
		if IsBuildingReal(iBuilding) then
			if GameInfo.BuildingClasses[GameInfo.Buildings[iBuilding].BuildingClass].MaxGlobalInstances == -1 and GameInfo.BuildingClasses[GameInfo.Buildings[iBuilding].BuildingClass].MaxPlayerInstances == -1 then
				tBuildings[iBuilding] = GameInfo.Buildings[iBuilding].GreatWorkSlotType
			end
		end
	end
	GameEvents.PlayerDoTurn.Add(TuscanUATrigger1)
	GameEvents.PlayerAdoptPolicy.Add(TuscanUATrigger1)
	Events.SpecificCityInfoDirty.Add(TuscanUATrigger2)
end
--=======================================================================================================================
-- Tuscan UU: Condottieri
--=======================================================================================================================
-- Condottieri: Main Code
-------------------------------------------------------------------------------------------------------------------------
local iPromotion = GameInfoTypes.PROMOTION_FREE_COMPANY

function GetGoldCombatBonus(pPlayer)
	return math.min(10, math.floor(pPlayer:GetGold() / 100))
end

function FreeCompanyEffect(iPlayer)
	local pPlayer = Players[iPlayer]
	if pPlayer:IsEverAlive() then
		for pUnit in pPlayer:Units() do
			if pUnit and pUnit:IsHasPromotion(iPromotion) then
				pUnit:SetBaseCombatStrength(GameInfo.Units[pUnit:GetUnitType()].Combat + GetGoldCombatBonus(pPlayer))
			end
		end
	end
end

function FreeCompanyEffectDirtyTrigger()
	local iPlayer = Game.GetActivePlayer()
	local pPlayer = Players[iPlayer]
	if pPlayer:IsTurnActive() then
		FreeCompanyEffect(iPlayer)
	end
end

function FreeCompanyEffectInitialTrigger(iPlayer, iUnit)
	local pPlayer = Players[iPlayer]
	local pUnit = pPlayer:GetUnitByID(iUnit)
	if pUnit and pUnit:IsHasPromotion(iPromotion) then
		GameEvents.PlayerDoTurn.Add(FreeCompanyEffect)
		Events.SerialEventGameDataDirty.Add(FreeCompanyEffectDirtyTrigger)
		Events.SerialEventUnitCreated.Remove(FreeCompanyEffectInitialTrigger)
		save("GAME", "FreeCompanyEffectInitalised", true)
		FreeCompanyEffect(iPlayer)
	end
end

if load("GAME", "FreeCompanyEffectInitalised") then
	GameEvents.PlayerDoTurn.Add(FreeCompanyEffect)
	Events.SerialEventGameDataDirty.Add(FreeCompanyEffectDirtyTrigger)
else
	Events.SerialEventUnitCreated.Add(FreeCompanyEffectInitialTrigger)
end
--=======================================================================================================================
--=======================================================================================================================