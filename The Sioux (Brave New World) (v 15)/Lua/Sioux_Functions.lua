-- Sioux_Functions
-- Author: Sukritact
-- Heavily Edited By: F0S
--=======================================================================================================================
WARN_NOT_SHARED = false; include( "Sukritact_SaveUtils.lua" ); MY_MOD_NAME = "Sioux_Functions";
include("PlotIterators.lua")
--=======================================================================================================================
-- UTILITY FUNCTIONS	
--=======================================================================================================================
-- JFD_IsCivilisationActive
-------------------------------------------------------------------------------------------------------------------------
local iCiv = GameInfoTypes.CIVILIZATION_SIOUX_MOD

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
-- Sukritact_PlaceResource
--------------------------------------------------------------
function Sukritact_PlaceResource(pCity, pPlot, iResource)
    local tPlots = {}
	local iPlayer = pCity:GetOwner()
    for pLoopPlot in PlotAreaSpiralIterator(pPlot, 3, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
		if pLoopPlot:GetOwner() == -1 or pLoopPlot:GetOwner() == iPlayer then
			if not pLoopPlot:IsWater() and pLoopPlot:IsFlatlands() and not pLoopPlot:IsMountain() and pLoopPlot:GetResourceType() == -1 and pLoopPlot:GetFeatureType() == -1 then
				if pLoopPlot:GetTerrainType() == GameInfoTypes["TERRAIN_PLAINS"] then
					table.insert(tPlots, pLoopPlot)
					table.insert(tPlots, pLoopPlot)
				elseif pLoopPlot:GetTerrainType() == GameInfoTypes["TERRAIN_GRASS"] then
					table.insert(tPlots, pLoopPlot)
				end
			end
		end
    end
	local pTargetPlot = nil
	if #tPlots > 0 then
		local iRandom = GetRandom(1, #tPlots)
		local pSpawnPlot = tPlots[iRandom]
		pSpawnPlot:SetResourceType(iResource, 1)
		pSpawnPlot:SetOwner(-1)
		pSpawnPlot:SetOwner(iPlayer, pCity:GetID())
		pSpawnPlot:SetRevealed(Players[iPlayer]:GetTeam(), true)
		pSpawnPlot:UpdateFog()
		pTargetPlot = pSpawnPlot
	end
	return pTargetPlot
end
-------------------------------------------------------------------------------------------------------------------------
-- GetRandom
-------------------------------------------------------------------------------------------------------------------------
function GetRandom(lower, upper)
    return (Game.Rand((upper + 1) - lower, "")) + lower
end
-------------------------------------------------------------------------------------------------------------------------
-- sDecompilePlotID
-------------------------------------------------------------------------------------------------------------------------
function sDecompilePlotID(sKey)
    iBreak = string.find(sKey, "Y")
    iX = tonumber(string.sub(sKey, 1, iBreak - 1))
    iY = tonumber(string.sub(sKey, iBreak + 1))
    pPlot = Map.GetPlot(iX, iY)
    return pPlot
end
-------------------------------------------------------------------------------------------------------------------------
-- sCompilePlotID
-------------------------------------------------------------------------------------------------------------------------
function sCompilePlotID(pPlot)
    iX = pPlot:GetX()
    iY = pPlot:GetY()
    return(iX .. "Y" .. iY)
end
--=======================================================================================================================
-- Sioux UI: Tipi
--=======================================================================================================================
-- Globals
-------------------------------------------------------------------------------------------------------------------------
local iTipi = GameInfoTypes.IMPROVEMENT_SIOUX_TIPI_MOD
-------------------------------------------------------------------------------------------------------------------------
-- Tipi: City Capture Relocate
-------------------------------------------------------------------------------------------------------------------------
function CityCapture_Relocate(iOldOwner, bIsCapital, iX, iY, iNewOwner, iPop, bConquest)
	local pPlayer = Players[iOldOwner]
	if pPlayer:GetCivilizationType() == iCiv then	
		local pPlot = Map.GetPlot(iX, iY)
		if pPlot then
			local pCity = pPlot:GetPlotCity()
			if pCity then
				local iCityTipis = 0
				for iCityPlot = 0, pCity:GetNumCityPlots() - 1, 1 do
					local pCityPlot = pCity:GetCityIndexPlot(iCityPlot)
					if pCityPlot then
						if pCityPlot:GetOwner() == iNewOwner and pCityPlot:GetImprovementType() == iTipi then
							if not pCityPlot:IsImprovementPillaged() then 
								iCityTipis = iCityTipis + 1
							end
							pCityPlot:SetImprovementType(-1)
						end
					end
				end
				if pPlayer:IsEverAlive() then
					local iCityTipis = math.min(iCityTipis, pCity:GetPopulation())
					local iRelocated = 0
					for pOtherCity in pPlayer:Cities() do
						if pOtherCity and iCityTipis > 0 then
							pOtherCity:ChangePopulation(1, true)
							Network.SendUpdateCityCitizens(pOtherCity:GetID())
							iRelocated = iRelocated + 1
							iCityTipis = iCityTipis - 1
						end
					end
					if pPlayer:IsHuman() and pPlayer:IsTurnActive() and iRelocated > 0 then
						local sTooltip = Locale.ConvertTextKey("TXT_KEY_TIPI_RELOCATION_NOTIFICATION", iRelocated, pCity:GetName())
						pPlayer:AddNotification(NotificationTypes.NOTIFICATION_GENERIC, sTooltip, Locale.ConvertTextKey("TXT_KEY_TIPI_RELOCATION_SHORT"), -1, -1)
					end
				end
			end
		end
	end
end
--=======================================================================================================================
-- Sioux UA: Buffalo Hunt
--=======================================================================================================================
-- Globals
-------------------------------------------------------------------------------------------------------------------------
local iBuffalo = GameInfoTypes.RESOURCE_BISON_MOD
local iBuffaloTrail = GameInfoTypes.RESOURCE_BUFFALO_TRAIL_MOD
local tBuffalo = {}
local uBuffalo = {}
local iMod = ((GameInfo.GameSpeeds[Game.GetGameSpeedType()].GoldenAgePercent)/100)
local iInterval = math.ceil(30 * iMod)
local jInterval = math.ceil(50 * iMod)
-------------------------------------------------------------------------------------------------------------------------
-- Buffalo Hunt: Buffalo Check
-------------------------------------------------------------------------------------------------------------------------
function BuffaloCheck(iX, iY)
	local pPlot = Map.GetPlot(ToGridFromHex(iX, iY))
	if pPlot then
		local iPlayer = pPlot:GetOwner()
		local iResource = pPlot:GetResourceType()
		if iPlayer > -1 then
			local pPlayer = Players[iPlayer]
			if pPlayer:IsEverAlive() and pPlayer:GetCivilizationType() == iCiv and iResource == -1 then
				local tCityPlot = load(pPlot, "tBuffaloPlots")
				if tCityPlot then
					local pCity = sDecompilePlotID(tCityPlot):GetPlotCity()
					if pCity and pCity:GetOwner() == iPlayer then
						if pPlot:GetImprovementType() > -1 then
							pPlot:SetImprovementType(-1)
						end
						pPlot:SetResourceType(iBuffaloTrail, 1)
						tBuffalo[pCity:GetID()] = pPlot
					end
				end
				local uCityPlot = load(pPlot, "uBuffaloPlots")
				if uCityPlot then
					local pCity = sDecompilePlotID(uCityPlot):GetPlotCity()
					if pCity and pCity:GetOwner() == iPlayer then
						if pPlot:GetImprovementType() > -1 then
							pPlot:SetImprovementType(-1)
						end
						pPlot:SetResourceType(iBuffaloTrail, 1)
						uBuffalo[pCity:GetID()] = pPlot
					end
				end
			else
				if iResource == iBuffalo or iResource == iBuffaloTrail then
					if pPlot:GetImprovementType() > -1 then
						pPlot:SetImprovementType(-1)
					end
					pPlot:SetResourceType(-1)
				end
			end
		else
			if iResource == iBuffalo or iResource == iBuffaloTrail then
				if pPlot:GetImprovementType() > -1 then
					pPlot:SetImprovementType(-1)
				end
				pPlot:SetResourceType(-1)
			end
		end
	end
end
-------------------------------------------------------------------------------------------------------------------------
-- Buffalo Hunt: Push Notification
-------------------------------------------------------------------------------------------------------------------------
function PushNotification(pCity, pPlot, bPlaced)	
	local pPlayer = Players[pCity:GetOwner()]
	if pPlayer:IsHuman() and pPlayer:IsTurnActive() then
		local sDirection = Locale.ConvertTextKey("TXT_KEY_TRAIT_BUFFALO_HUNT_TO")
		if not bPlaced then
			sDirection = Locale.ConvertTextKey("TXT_KEY_TRAIT_BUFFALO_HUNT_AWAY")
		end
		local sTooltip = Locale.ConvertTextKey("TXT_KEY_TRAIT_BUFFALO_HUNT_NOTIFICATION", sDirection, pCity:GetName())
		pPlayer:AddNotification(NotificationTypes.NOTIFICATION_DISCOVERED_BONUS_RESOURCE, sTooltip, Locale.ConvertTextKey("TXT_KEY_TRAIT_BUFFALO_HUNT_SHORT"), pPlot:GetX(), pPlot:GetY(), iBuffalo, -1)
	end
end
-------------------------------------------------------------------------------------------------------------------------
-- Buffalo Hunt: Place Buffalo
-------------------------------------------------------------------------------------------------------------------------
function CountTipis(iPlayer, pCity)
	local iWorkedTipis = 0
	for iPlot = 0, pCity:GetNumCityPlots() - 1, 1 do
		local pPlot = pCity:GetCityIndexPlot(iPlot)
		if pPlot then
			if pPlot:GetOwner() == iPlayer then
				if pCity:IsWorkingPlot(pPlot) then	
					if pPlot:GetImprovementType() == iTipi and not pPlot:IsImprovementPillaged() then 
						iWorkedTipis = iWorkedTipis + 1
					end
				end
			end
		end
	end
	return math.min(4, iWorkedTipis)
end

function PlaceBuffalo(pPlayer, iX, iY, isFounding, nBuffalo)
	local pPlot = Map.GetPlot(iX, iY)
	if not pPlot then return end
	local pCity = pPlot:GetPlotCity()
	if not pCity then return end
	local iCity = pCity:GetID()
	if isFounding then
		if load(pPlot, "SiouxAlreadyFounded") then
			for pLoopPlot in PlotAreaSpiralIterator(pPlot, 3, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
				if pLoopPlot:GetOwner() == -1 or pLoopPlot:GetOwner() == pPlayer:GetID() then
					local tPlot = load(pLoopPlot, "tBuffaloPlots")
					if tPlot then
						local sPlot = sDecompilePlotID(tPlot)
						if sPlot == pPlot then
							if pLoopPlot:GetImprovementType() > -1 then
								pLoopPlot:SetImprovementType(-1)
							end
							pLoopPlot:SetResourceType(iBuffaloTrail, 1)
							pLoopPlot:SetOwner(-1)
							pLoopPlot:SetOwner(pPlayer:GetID(), iCity)
							pLoopPlot:SetRevealed(pPlayer:GetTeam(), true)
							pLoopPlot:UpdateFog()
							tBuffalo[iCity] = pLoopPlot
						end
					end
					local uPlot = load(pLoopPlot, "uBuffaloPlots")
					if uPlot then
						local sPlot = sDecompilePlotID(uPlot)
						if sPlot == pPlot then
							if pLoopPlot:GetImprovementType() > -1 then
								pLoopPlot:SetImprovementType(-1)
							end
							pLoopPlot:SetResourceType(iBuffaloTrail, 1)
							pLoopPlot:SetOwner(-1)
							pLoopPlot:SetOwner(pPlayer:GetID(), iCity)
							pLoopPlot:SetRevealed(pPlayer:GetTeam(), true)
							pLoopPlot:UpdateFog()
							uBuffalo[iCity] = pLoopPlot
						end
					end
				end
			end
			return
		else
			tBuffalo[iCity] = Sukritact_PlaceResource(pCity, pPlot, iBuffaloTrail)
			if tBuffalo[iCity] then save(tBuffalo[iCity], "tBuffaloPlots", sCompilePlotID(pPlot)) end
			uBuffalo[iCity] = Sukritact_PlaceResource(pCity, pPlot, iBuffaloTrail)
			if uBuffalo[iCity] then save(uBuffalo[iCity], "uBuffaloPlots", sCompilePlotID(pPlot)) end
			save(pPlot, "SiouxAlreadyFounded", true)
			return
		end
	end
	local iUpper = 8
	if not tBuffalo[iCity] and not nBuffalo then return end
	if not uBuffalo[iCity] and nBuffalo then return end
	if tBuffalo[iCity] and tBuffalo[iCity]:GetResourceType() ~= iBuffaloTrail then iUpper = iUpper + 2 end
	if uBuffalo[iCity] and uBuffalo[iCity]:GetResourceType() ~= iBuffaloTrail then iUpper = iUpper + 2 end
	if pCity:IsCapital() then iUpper = iUpper - 2 end
	iUpper = iUpper - CountTipis(pPlayer:GetID(), pCity)
	if iUpper < 2 then iUpper = 2 end
	if GetRandom(1, iUpper) < 4 then
		if nBuffalo == 1 then
			if uBuffalo[iCity]:GetImprovementType() > -1 then
				uBuffalo[iCity]:SetImprovementType(-1)
			end
			uBuffalo[iCity]:SetResourceType(iBuffaloTrail, 1)
			return uBuffalo[iCity]
		else
			if tBuffalo[iCity]:GetImprovementType() > -1 then
				tBuffalo[iCity]:SetImprovementType(-1)
			end
			tBuffalo[iCity]:SetResourceType(iBuffaloTrail, 1)
			return tBuffalo[iCity]
		end
	else
		if nBuffalo == 1 then
			if uBuffalo[iCity]:GetImprovementType() > -1 then
				uBuffalo[iCity]:SetImprovementType(-1)
			end
			uBuffalo[iCity]:SetResourceType(iBuffalo, 1)
			return uBuffalo[iCity]
		else
			if tBuffalo[iCity]:GetImprovementType() > -1 then
				tBuffalo[iCity]:SetImprovementType(-1)
			end
			tBuffalo[iCity]:SetResourceType(iBuffalo, 1)
			return tBuffalo[iCity]
		end
	end
end
-------------------------------------------------------------------------------------------------------------------------
-- Buffalo Hunt: City Founded Place Buffalo
-------------------------------------------------------------------------------------------------------------------------
function CityFounded_PlaceBuffalo(iPlayer, iX, iY)
	local pPlayer = Players[iPlayer]
	if pPlayer:IsEverAlive() and pPlayer:GetCivilizationType() == iCiv then
		local pPlot = Map.GetPlot(iX, iY)
		if pPlot and pPlot:GetPlotCity() then
			for pLoopPlot in PlotAreaSpiralIterator(pPlot, 1, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_INCLUDE) do
				if pLoopPlot:GetOwner() == -1 or pLoopPlot:GetOwner() == iPlayer then
					if not pLoopPlot:IsWater() and pLoopPlot:IsFlatlands() and not pLoopPlot:IsMountain() and pLoopPlot:GetFeatureType() == -1 then
						if pLoopPlot:GetTerrainType() == GameInfoTypes["TERRAIN_PLAINS"] or pLoopPlot:GetTerrainType() == GameInfoTypes["TERRAIN_GRASS"] then
							PlaceBuffalo(pPlayer, iX, iY, true, 0)
							break
						end
					end
				end
			end
		end
	end
end
-------------------------------------------------------------------------------------------------------------------------
-- Buffalo Hunt: Migrate Buffalo
-------------------------------------------------------------------------------------------------------------------------
function MigrateBuffalo(iPlayer)
    local pPlayer = Players[iPlayer]
	if pPlayer:IsEverAlive() and pPlayer:GetCivilizationType() == iCiv then
		local iCurrentTurn = Game.GetGameTurn()
		if (iCurrentTurn % iInterval) == 0 then
			for pCity in pPlayer:Cities() do
				if pCity then
					local pOldPlot = tBuffalo[pCity:GetID()]
					local pPlaced = nil
					local iOldRes = nil
					if pOldPlot and pOldPlot:GetOwner() == iPlayer then
						iOldRes = pOldPlot:GetResourceType()
						pPlaced = PlaceBuffalo(pPlayer, pCity:GetX(), pCity:GetY(), false, 0)
						if pPlaced and iOldRes > -1 then
							local iNewRes = pPlaced:GetResourceType()
							if iNewRes ~= iOldRes then
								PushNotification(pCity, pPlaced, (iNewRes ~= iBuffaloTrail))
							end
						end
					end
				end
			end
		end
		if (iCurrentTurn % jInterval) == 0 then
			for pCity in pPlayer:Cities() do
				if pCity then
					local pOldPlot = uBuffalo[pCity:GetID()]
					local pPlaced = nil
					local iOldRes = nil
					if pOldPlot and pOldPlot:GetOwner() == iPlayer then
						iOldRes = pOldPlot:GetResourceType()
						pPlaced = PlaceBuffalo(pPlayer, pCity:GetX(), pCity:GetY(), false, 1)
						if pPlaced and iOldRes > -1 then
							local iNewRes = pPlaced:GetResourceType()
							if iNewRes ~= iOldRes then
								PushNotification(pCity, pPlaced, (iNewRes ~= iBuffaloTrail))
							end
						end
					end
				end
			end
		end
	end
end
-------------------------------------------------------------------------------------------------------------------------
-- Buffalo Hunt: Initialize Tables
-------------------------------------------------------------------------------------------------------------------------
function InitializeTables()
	for iPlot = 0, Map.GetNumPlots() - 1, 1 do
	    local pPlot = Map.GetPlotByIndex(iPlot)
		if pPlot then
			local iPlayer = pPlot:GetOwner()
			if iPlayer > -1 then
				local pPlayer = Players[iPlayer]
				if pPlayer:IsEverAlive() and pPlayer:GetCivilizationType() == iCiv then
					local tCityPlot = load(pPlot, "tBuffaloPlots")
					if tCityPlot then
						local pCity = sDecompilePlotID(tCityPlot):GetPlotCity()
						if pCity and pCity:GetOwner() == iPlayer then
							tBuffalo[pCity:GetID()] = pPlot
						end
					end
					local uCityPlot = load(pPlot, "uBuffaloPlots")
					if uCityPlot then
						local pCity = sDecompilePlotID(uCityPlot):GetPlotCity()
						if pCity and pCity:GetOwner() == iPlayer then
							uBuffalo[pCity:GetID()] = pPlot
						end
					end
				end
			end
		end
	end
end

if JFD_IsCivilisationActive(iCiv) then
	InitializeTables()
	GameEvents.CityCaptureComplete.Add(CityCapture_Relocate)
	Events.SerialEventHexCultureChanged.Add(BuffaloCheck)
	GameEvents.PlayerCityFounded.Add(CityFounded_PlaceBuffalo)
	GameEvents.PlayerDoTurn.Add(MigrateBuffalo)
end
--=======================================================================================================================
-- Sioux UU: Strong Heart
--=======================================================================================================================
-- Globals
-------------------------------------------------------------------------------------------------------------------------
local iStrongHeart = GameInfoTypes.UNIT_SIOUX_HORSEMAN_MOD
local iBandLeader = GameInfoTypes.PROMOTION_SIOUX_VETERAN_LEADER
local tStrongHeartNames = {
	["Rain in the Face"] = 1,
	["Gall"] = 2,
	["Two Bears"] = 3,
	["Thunderhawk"] = 4,
	["Running Antelope"] = 5,
	["Crazy Horse"] = 6,
	["Red Cloud"] = 7,
	["Struck by the Ree"] = 8,
	["Big Head"] = 9,
	["Big Eagle"] = 10,
	["Moccasin Top"] = 11,
	["Good Weasel"] = 12
}
-------------------------------------------------------------------------------------------------------------------------
-- Strong Heart: Strong Heart Check
-------------------------------------------------------------------------------------------------------------------------
function StrongHeartCheck(iPlayer)
    local pPlayer = Players[iPlayer]
    if pPlayer:IsEverAlive() then
		if load(pPlayer, "pHasStrongHeart") ~= nil then
			local tStrongHearts = {}
			local bHasStrongHeart = false
			for pUnit in pPlayer:Units() do
				if pUnit and pUnit:GetCombatLimit() > 0 then
					if tStrongHeartNames[pUnit:GetName()] then
						if pUnit:IsHasPromotion(iBandLeader) then
							bHasStrongHeart = true
							break
						else
							pUnit:SetName("")
						end
					end
					if pUnit:GetUnitType() == iStrongHeart then
						table.insert(tStrongHearts, pUnit)
					end
				end
			end
			if not bHasStrongHeart then
				if #tStrongHearts > 0 then
					local pTargetUnit = tStrongHearts[GetRandom(1, #tStrongHearts)]
					if pTargetUnit then
						pTargetUnit:SetHasPromotion(iBandLeader, true)
						pTargetUnit:SetName(tStrongHeartNames[GetRandom(1, #tStrongHeartNames)])
					else
						save(pPlayer, "pHasStrongHeart", nil)
					end
				else
					save(pPlayer, "pHasStrongHeart", nil)
				end
			end
		end
	end
end
-------------------------------------------------------------------------------------------------------------------------
-- Strong Heart: Strong Heart Created
-------------------------------------------------------------------------------------------------------------------------
function StrongHeartCreated(iPlayer, iUnit)
	local pPlayer = Players[iPlayer]
	if pPlayer:IsEverAlive() then
		if load(pPlayer, "pHasStrongHeart") == nil then
			local pUnit = pPlayer:GetUnitByID(iUnit)
			if pUnit and pUnit:GetUnitType() == iStrongHeart then
				pUnit:SetHasPromotion(iBandLeader, true)
				pUnit:SetName(tStrongHeartNames[GetRandom(1, #tStrongHeartNames)])
				save(pPlayer, "pHasStrongHeart", true)
			end
		end
	end
end
-------------------------------------------------------------------------------------------------------------------------
-- Strong Heart: Strong Heart Initial Trigger
-------------------------------------------------------------------------------------------------------------------------
function StrongHeartInitialTrigger(iPlayer, iUnit)
	local pPlayer = Players[iPlayer]
	local pUnit = pPlayer:GetUnitByID(iUnit)
	if pUnit and pUnit:GetUnitType() == iStrongHeart then
		GameEvents.PlayerDoTurn.Add(StrongHeartCheck)
		Events.SerialEventUnitCreated.Add(StrongHeartCreated)
		Events.SerialEventUnitCreated.Remove(StrongHeartInitialTrigger)
		save("GAME", "StrongHeartInitalised", true)
		StrongHeartCreated(iPlayer, iUnit)
	end
end

if load("GAME", "StrongHeartInitalised") then
	GameEvents.PlayerDoTurn.Add(StrongHeartCheck)
	Events.SerialEventUnitCreated.Add(StrongHeartCreated)
else
	Events.SerialEventUnitCreated.Add(StrongHeartInitialTrigger)
end
--=======================================================================================================================
--=======================================================================================================================