-- MughalUA
-- Author: Sukritact
-- Edited By: F0S
--------------------------------------------------------------
WARN_NOT_SHARED = false; include( "SaveUtils" ); MY_MOD_NAME = "MughalUA";
include("FLuaVector.lua")
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

function IsBuildingReal(iBuilding)
    return not (GameInfo.Buildings[iBuilding].GreatWorkCount == -1 or (GameInfo.Buildings[iBuilding].PrereqTech == nil and (GameInfo.Buildings[iBuilding].FaithCost == -1 and GameInfo.Buildings[iBuilding].Cost == -1)))
end
--------------------------------------------------------------
-- Main Code
--------------------------------------------------------------
local iProduction = GameInfo.Yields["YIELD_PRODUCTION"].ID
local iCulture = GameInfo.Yields["YIELD_CULTURE"].ID
local iTourism = GameInfo.Yields["YIELD_TOURISM"].ID
local iCivType = GameInfoTypes["CIVILIZATION_MUGHAL"]
local iHotel = GameInfoTypes["BUILDING_HOTEL"]
local iAirport = GameInfoTypes["BUILDING_AIRPORT"]
local iTouristCenter = GameInfoTypes["BUILDING_TOURIST_CENTER"]
local iMod = ((GameInfo.GameSpeeds[Game.GetGameSpeedType()].BuildPercent)/100)
local tBuildings = {}

function MughalUA(pPlayer)
    if pPlayer:IsGoldenAge() then
        for pCity in pPlayer:Cities() do
            local iCity = pCity:GetID()
            local iNumBuildings = 0
            local iNumWonders = 0
            for iKey, sVal in pairs(tBuildings) do
                if pCity:IsHasBuilding(iKey) then
                    if sVal == "Wonder" or sVal == "NationalWonder" then
                        iNumWonders = iNumWonders + 1
                    elseif sVal == "Building" then
                        iNumBuildings = iNumBuildings + 1
                    end
                end
            end
            local iDelta = iNumWonders*2
            local iOldDelta = load( pPlayer, iCity .. "Y" .. iCulture)
            if iOldDelta == nil then
                iOldDelta = 0
            end
            save( pPlayer, iCity .. "Y" .. iCulture, iDelta)
            pCity:ChangeJONSCulturePerTurnFromBuildings(iDelta - iOldDelta)
			local numTourismMods = 0
			if pCity:IsHasBuilding(iHotel) then
				numTourismMods = numTourismMods + 0.5
			end
			if pCity:IsHasBuilding(iAirport) then
				numTourismMods = numTourismMods + 0.5
			end
			if pCity:IsHasBuilding(iTouristCenter) then
				numTourismMods = numTourismMods + 1
			end
			pCity:SetNumRealBuilding(GameInfoTypes["BUILDING_MUGHAL_TOURISM_BONUS"], math.floor(iDelta * numTourismMods))
            local iDelta = math.ceil(iNumBuildings/2)
            local iOldDelta = load( pPlayer, iCity .. "Y" .. iProduction)
            if iOldDelta == nil then
                iOldDelta = 0
            end
            save( pPlayer, iCity .. "Y" .. iProduction, iDelta)
            pCity:ChangeBaseYieldRateFromBuildings(iProduction, iDelta - iOldDelta) 
        end
    else
        for pCity in pPlayer:Cities() do
            local iCity = pCity:GetID()
            local iDelta = 0
            local iOldDelta = load( pPlayer, iCity .. "Y" .. iCulture)
            if iOldDelta == nil then
                iOldDelta = 0
            end
            save( pPlayer, iCity .. "Y" .. iCulture, iDelta)
            pCity:ChangeJONSCulturePerTurnFromBuildings(iDelta - iOldDelta)
			pCity:SetNumRealBuilding(GameInfoTypes["BUILDING_MUGHAL_TOURISM_BONUS"], 0)
            local iDelta = 0
            local iOldDelta = load( pPlayer, iCity .. "Y" .. iProduction)
            if iOldDelta == nil then
                iOldDelta = 0
            end
            save( pPlayer, iCity .. "Y" .. iProduction, iDelta)
            pCity:ChangeBaseYieldRateFromBuildings(iProduction, iDelta - iOldDelta)
			for iBuilding, sVal in pairs(tBuildings) do
				if pCity:IsHasBuilding(iBuilding) then
					if not load(pPlayer, iBuilding) then
						if sVal == "Wonder"  then
							local iCost = GameInfo.Buildings[iBuilding].Cost
							local iGAPoints = math.floor((iCost*iMod)/4)
							pPlayer:ChangeGoldenAgeProgressMeter(iGAPoints)
							if pPlayer:IsHuman() and pPlayer:IsTurnActive() then
								local hex = ToHexFromGrid(Vector2(pCity:GetX(), pCity:GetY()))
								Events.AddPopupTextEvent(HexToWorld(hex), Locale.ConvertTextKey("[COLOR_POSITIVE_TEXT]+{1_Num}[ENDCOLOR] [ICON_GOLDEN_AGE]", iGAPoints), 1)
								Events.GameplayFX(hex.x, hex.y, -1)
							end
							save(pPlayer, iBuilding, true)
						end
					end
				end
			end
        end
    end
end

function MughalUATrigger1(iPlayer)
    local pPlayer = Players[iPlayer]
    if pPlayer:IsEverAlive() and pPlayer:GetCivilizationType() == iCivType then
        MughalUA(pPlayer)
    end
end

function MughalUATrigger2()
    local iPlayer = Game.GetActivePlayer()
    local pPlayer = Players[iPlayer]
    if pPlayer:IsEverAlive() and pPlayer:IsTurnActive() then
        if pPlayer:GetCivilizationType() == iCivType then
            MughalUA(pPlayer)
        end
    end
end

function MughalUATrigger3(iPlayer, iCity, iType)
	if iType ~= CityUpdateTypes.CITY_UPDATE_TYPE_PRODUCTION then return end
	local pPlayer = Players[iPlayer]
	if pPlayer:IsEverAlive() and pPlayer:GetCivilizationType() == iCivType then
		MughalUA(pPlayer)
	end
end

if JFD_IsCivilisationActive(iCivType) then
	for Building in GameInfo.Buildings() do
		iBuilding = Building.ID
		if GameInfo.BuildingClasses[GameInfo.Buildings[iBuilding].BuildingClass].MaxGlobalInstances > -1 then
			tBuildings[iBuilding] = "Wonder"
		elseif GameInfo.BuildingClasses[GameInfo.Buildings[iBuilding].BuildingClass].MaxPlayerInstances > -1 then
			tBuildings[iBuilding] = "NationalWonder"
		elseif IsBuildingReal(iBuilding) then
			tBuildings[iBuilding] = "Building"
		end
	end
	GameEvents.PlayerDoTurn.Add(MughalUATrigger1)
	GameEvents.PlayerAdoptPolicy.Add(MughalUATrigger1)
	Events.SerialEventGameDataDirty.Add(MughalUATrigger2)
	Events.SpecificCityInfoDirty.Add(MughalUATrigger3)
end