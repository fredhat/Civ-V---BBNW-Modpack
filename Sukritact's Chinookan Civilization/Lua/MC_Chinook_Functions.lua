-- Chinook_CoreFunctions
-- Author: F0S
-- Special Thanks To: Sukritact, JFD
--=======================================================================================================================
WARN_NOT_SHARED = false; include( "Sukritact_SaveUtils.lua" ); MY_MOD_NAME = "MC_Chinook_Functions";
include("PlotIterators.lua")
--=======================================================================================================================
-- UTILITY FUNCTIONS	
--=======================================================================================================================
-- JFD_IsCivilisationActive
-------------------------------------------------------------------------------------------------------------------------
local iCiv = GameInfoTypes.CIVILIZATION_MC_CHINOOK

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
			if pLoopPlot:GetTerrainType() == GameInfoTypes["TERRAIN_COAST"] and pLoopPlot:GetResourceType() == -1 and pLoopPlot:GetFeatureType() == -1 and not pLoopPlot:IsLake() then
				table.insert(tPlots, pLoopPlot)
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
-- Chinook UB: Plankhouse
--=======================================================================================================================
-- Globals
-------------------------------------------------------------------------------------------------------------------------
local iPlankhouse = GameInfoTypes.BUILDING_MC_PLANKHOUSE
local iPlankhouseDummy = GameInfoTypes.BUILDING_MC_PLANKHOUSE_DUMMY
-------------------------------------------------------------------------------------------------------------------------
-- Plankhouse: River Check Dirty
-------------------------------------------------------------------------------------------------------------------------
function Plankhouse_RiverCheckDirty()
	local iPlayer = Game.GetActivePlayer()
    local pPlayer = Players[iPlayer]
	if pPlayer:IsEverAlive() and pPlayer:IsTurnActive() then
        for pCity in pPlayer:Cities() do
			if pCity then
				local pPlot = pCity:Plot()
				if pPlot and pCity:IsHasBuilding(iPlankhouse) and pPlot:IsRiver() then
					if not pCity:IsHasBuilding(iPlankhouseDummy) then
						pCity:SetNumRealBuilding(iPlankhouseDummy, 1)
					end
				else
					if pCity:IsHasBuilding(iPlankhouseDummy) then
						pCity:SetNumRealBuilding(iPlankhouseDummy, 0)
					end
				end
			end
        end
    end
end
-------------------------------------------------------------------------------------------------------------------------
-- Plankhouse: River Check Initial Trigger
-------------------------------------------------------------------------------------------------------------------------
function Plankhouse_RiverCheckInitialTrigger(iPlayer, iCity, iBuilding)
	local pPlayer = Players[iPlayer]
	local pCity = pPlayer:GetCityByID(iCity)
	if pCity and pCity:IsHasBuilding(iPlankhouse) then
		Events.SerialEventGameDataDirty.Add(Plankhouse_RiverCheckDirty)
		GameEvents.CityConstructed.Remove(Plankhouse_RiverCheckInitialTrigger)
		save("GAME", "Plankhouse_RiverCheckInitalised", true)
		Plankhouse_RiverCheckDirty()
	end
end
-------------------------------------------------------------------------------------------------------------------------
-- Plankhouse: Can Build Plankhouse
-------------------------------------------------------------------------------------------------------------------------
function Plankhouse_CanBuild(iPlayer, iCity, iBuilding)
	if iBuilding == iPlankhouse then
		local pPlayer = Players[iPlayer]
		local pCity = pPlayer:GetCityByID(iCity)
		local pPlot = pCity:Plot()
		if not (pPlot:IsFreshWater() or pPlot:IsCoastalLand() or pPlot:IsRiver()) then
			return
		end
	end
	return true
end
--=======================================================================================================================
-- Chinook UA: Salmon Migration
--=======================================================================================================================
-- Globals
-------------------------------------------------------------------------------------------------------------------------
local iPlatform = GameInfoTypes.IMPROVEMENT_OFFSHORE_PLATFORM
local iFishingBoat = GameInfoTypes.IMPROVEMENT_FISHING_BOATS
local iTech = GameInfoTypes.TECH_REFRIGERATION
local iSalmon = GameInfoTypes.RESOURCE_MC_SALMON
local iOrca = GameInfoTypes.RESOURCE_MC_ORCA
local iBreedingGround = GameInfoTypes.RESOURCE_MC_BREEDING_GROUND
local tValidResources = {}
local tOil = {}
local tText = {}
local tSalmon = {}
local uSalmon = {}
local tRandom = {iOrca, iSalmon, iSalmon, iSalmon}
tText[iSalmon] = "[ICON_RES_MC_SALMON] " .. Locale.ConvertTextKey("TXT_KEY_RESOURCE_MC_SALMON")
tText[iOrca] = "[ICON_RES_MC_ORCA]" .. Locale.ConvertTextKey("TXT_KEY_RESOURCE_MC_ORCA")
local iMod = ((GameInfo.GameSpeeds[Game.GetGameSpeedType()].GoldenAgePercent)/100)
local iInterval = math.ceil(3 * iMod)
local jInterval = math.ceil(5 * iMod)
-------------------------------------------------------------------------------------------------------------------------
-- Salmon Migration: Automatic Fishing Boats
-------------------------------------------------------------------------------------------------------------------------
function AutomaticFishingBoats(iX, iY)
	local pPlot = Map.GetPlot(ToGridFromHex(iX, iY))
	if pPlot then
		local iPlayer = pPlot:GetOwner()
		local iResource = pPlot:GetResourceType()
		if iPlayer > -1 then
			local pPlayer = Players[iPlayer]
			if pPlayer:IsEverAlive() and pPlayer:GetCivilizationType() == iCiv then
				if iResource > -1 then
					local iImprovement = tValidResources[pPlot:GetResourceType()]
					if iImprovement then
						if iImprovement == iPlatform and pPlot:IsWater() then
							tOil[pPlot] = true
							if Teams[pPlayer:GetTeam()]:IsHasTech(iTech) then
								pPlot:SetImprovementType(iImprovement)
							end
						elseif pPlot:CanHaveImprovement(iImprovement) then
							pPlot:SetImprovementType(iImprovement)
						end
					end
				else
					local tCityPlot = load(pPlot, "tSalmonPlots")
					if tCityPlot then
						local pCity = sDecompilePlotID(tCityPlot):GetPlotCity()
						if pCity and pCity:GetOwner() == iPlayer then
							if pPlot:GetImprovementType() > -1 then
								pPlot:SetImprovementType(-1)
							end
							pPlot:SetResourceType(iBreedingGround, 1)
							tSalmon[pCity:GetID()] = pPlot
						end
					end
					local uCityPlot = load(pPlot, "uSalmonPlots")
					if uCityPlot then
						local pCity = sDecompilePlotID(uCityPlot):GetPlotCity()
						if pCity and pCity:GetOwner() == iPlayer then
							if pPlot:GetImprovementType() > -1 then
								pPlot:SetImprovementType(-1)
							end
							pPlot:SetResourceType(iBreedingGround, 1)
							uSalmon[pCity:GetID()] = pPlot
						end
					end
				end
			else
				if tOil[pPlot] then tOil[pPlot] = nil end
				if iResource == iSalmon or iResource == iOrca or iResource == iBreedingGround then
					if pPlot:GetImprovementType() > -1 then
						pPlot:SetImprovementType(-1)
					end
					pPlot:SetResourceType(-1)
				end
			end
		else
			if tOil[pPlot] then tOil[pPlot] = nil end
			if iResource == iSalmon or iResource == iOrca or iResource == iBreedingGround then
				if pPlot:GetImprovementType() > -1 then
					pPlot:SetImprovementType(-1)
				end
				pPlot:SetResourceType(-1)
			end
		end
	end
end
-------------------------------------------------------------------------------------------------------------------------
-- Salmon Migration: Fishing Boat Tech Check
-------------------------------------------------------------------------------------------------------------------------
function Tech_AutomaticFishingBoats(iTeam, iNewTech, iChange)
	if iNewTech == iTech then
		for pPlot, _ in pairs(tOil) do
			if pPlot then
				local iPlayer = pPlot:GetOwner()
				pPlot:SetOwner(-1)
				pPlot:SetOwner(iPlayer)
				pPlot:SetRevealed(Players[iPlayer]:GetTeam(), true)
				pPlot:UpdateFog()
			end
		end
	end
end
-------------------------------------------------------------------------------------------------------------------------
-- Salmon Migration: Push Notification
-------------------------------------------------------------------------------------------------------------------------
function PushNotification(pCity, pPlot, iResource, bPlaced)	
	local pPlayer = Players[pCity:GetOwner()]
	if pPlayer:IsHuman() and pPlayer:IsTurnActive() then
		local sDirection = Locale.ConvertTextKey("TXT_KEY_TRAIT_MC_CHINOOK_TO")
		if not bPlaced then
			sDirection = Locale.ConvertTextKey("TXT_KEY_TRAIT_MC_CHINOOK_AWAY")
		end
		local sTooltip = Locale.ConvertTextKey("TXT_KEY_TRAIT_MC_CHINOOK_NOTIFICATION", tText[iResource], sDirection, pCity:GetName())
		pPlayer:AddNotification(NotificationTypes.NOTIFICATION_DISCOVERED_BONUS_RESOURCE, sTooltip, Locale.ConvertTextKey("TXT_KEY_TRAIT_MC_CHINOOK_SHORT"), pPlot:GetX(), pPlot:GetY(), iResource, -1)
	end
end
-------------------------------------------------------------------------------------------------------------------------
-- Salmon Migration: Place Salmon
-------------------------------------------------------------------------------------------------------------------------
function PlaceSalmon(pPlayer, iX, iY, isFounding, nSalmon)
	local pPlot = Map.GetPlot(iX, iY)
	if not pPlot then return end
	local pCity = pPlot:GetPlotCity()
	if not pCity then return end
	local iCity = pCity:GetID()
	if isFounding then
		if load(pPlot, "ChinookAlreadyFounded") then
			for pLoopPlot in PlotAreaSpiralIterator(pPlot, 3, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
				if pLoopPlot:GetOwner() == -1 or pLoopPlot:GetOwner() == pPlayer:GetID() then
					local tPlot = load(pLoopPlot, "tSalmonPlots")
					if tPlot then
						local sPlot = sDecompilePlotID(tPlot)
						if sPlot == pPlot then
							if pLoopPlot:GetImprovementType() > -1 then
								pLoopPlot:SetImprovementType(-1)
							end
							pLoopPlot:SetResourceType(iBreedingGround, 1)
							pLoopPlot:SetOwner(-1)
							pLoopPlot:SetOwner(pPlayer:GetID(), iCity)
							pLoopPlot:SetRevealed(pPlayer:GetTeam(), true)
							pLoopPlot:UpdateFog()
							tSalmon[iCity] = pLoopPlot
						end
					end
					local uPlot = load(pLoopPlot, "uSalmonPlots")
					if uPlot then
						local sPlot = sDecompilePlotID(uPlot)
						if sPlot == pPlot then
							if pLoopPlot:GetImprovementType() > -1 then
								pLoopPlot:SetImprovementType(-1)
							end
							pLoopPlot:SetResourceType(iBreedingGround, 1)
							pLoopPlot:SetOwner(-1)
							pLoopPlot:SetOwner(pPlayer:GetID(), iCity)
							pLoopPlot:SetRevealed(pPlayer:GetTeam(), true)
							pLoopPlot:UpdateFog()
							uSalmon[iCity] = pLoopPlot
						end
					end
				end
			end
			return
		else
			tSalmon[iCity] = Sukritact_PlaceResource(pCity, pPlot, iBreedingGround)
			if tSalmon[iCity] then save(tSalmon[iCity], "tSalmonPlots", sCompilePlotID(pPlot)) end
			uSalmon[iCity] = Sukritact_PlaceResource(pCity, pPlot, iBreedingGround)
			if uSalmon[iCity] then save(uSalmon[iCity], "uSalmonPlots", sCompilePlotID(pPlot)) end
			save(pPlot, "ChinookAlreadyFounded", true)
			return
		end
	end
	local iUpper = 8
	if not tSalmon[iCity] and not nSalmon then return end
	if not uSalmon[iCity] and nSalmon then return end
	if tSalmon[iCity] and tSalmon[iCity]:GetResourceType() ~= iBreedingGround then iUpper = iUpper + 2 end
	if uSalmon[iCity] and uSalmon[iCity]:GetResourceType() ~= iBreedingGround then iUpper = iUpper + 2 end
	if pCity:IsCapital() then iUpper = iUpper - 2 end	
	if pCity:IsHasBuilding(iPlankhouse) then iUpper = iUpper - 2 end
	if pPlot:IsRiver() then iUpper = iUpper - 2 end
	if iUpper < 2 then iUpper = 2 end
	local iResource = tRandom[GetRandom(1, iUpper)]
	if not iResource then
		if nSalmon == 1 then
			if uSalmon[iCity]:GetImprovementType() > -1 then
				uSalmon[iCity]:SetImprovementType(-1)
			end
			uSalmon[iCity]:SetResourceType(iBreedingGround, 1)
			return uSalmon[iCity]
		else
			if tSalmon[iCity]:GetImprovementType() > -1 then
				tSalmon[iCity]:SetImprovementType(-1)
			end
			tSalmon[iCity]:SetResourceType(iBreedingGround, 1)
			return tSalmon[iCity]
		end
	else
		if nSalmon == 1 then
			if uSalmon[iCity]:GetImprovementType() > -1 then
				uSalmon[iCity]:SetImprovementType(-1)
			end
			uSalmon[iCity]:SetResourceType(iResource, 1)
			uSalmon[iCity]:SetImprovementType(iFishingBoat)
			return uSalmon[iCity]
		else
			if tSalmon[iCity]:GetImprovementType() > -1 then
				tSalmon[iCity]:SetImprovementType(-1)
			end
			tSalmon[iCity]:SetResourceType(iResource, 1)
			tSalmon[iCity]:SetImprovementType(iFishingBoat)
			return tSalmon[iCity]
		end
	end
end
-------------------------------------------------------------------------------------------------------------------------
-- Salmon Migration: City Founded Place Salmon
-------------------------------------------------------------------------------------------------------------------------
function CityFounded_PlaceSalmon(iPlayer, iX, iY)
	local pPlayer = Players[iPlayer]
	if pPlayer:IsEverAlive() and pPlayer:GetCivilizationType() == iCiv then
		PlaceSalmon(pPlayer, iX, iY, true, 0)
	end
end
-------------------------------------------------------------------------------------------------------------------------
-- Salmon Migration: Migrate Salmon
-------------------------------------------------------------------------------------------------------------------------
function MigrateSalmon(iPlayer)
    local pPlayer = Players[iPlayer]
	if pPlayer:IsEverAlive() and pPlayer:GetCivilizationType() == iCiv then
		local iCurrentTurn = Game.GetGameTurn()
		if (iCurrentTurn % iInterval) == 0 then
			for pCity in pPlayer:Cities() do
				if pCity then
					local pOldPlot = tSalmon[pCity:GetID()]
					local pPlaced = nil
					local iOldRes = nil
					if pOldPlot and pOldPlot:GetOwner() == iPlayer then
						iOldRes = pOldPlot:GetResourceType()
						pPlaced = PlaceSalmon(pPlayer, pCity:GetX(), pCity:GetY(), false, 0)
						if pPlaced and iOldRes > -1 then
							local iNewRes = pPlaced:GetResourceType()
							if iNewRes ~= iOldRes then
								if iNewRes == iBreedingGround then
									PushNotification(pCity, pPlaced, iOldRes, false)
								else
									PushNotification(pCity, pPlaced, iNewRes, true)
								end
							end
						end
					end
				end
			end
		end
		if (iCurrentTurn % jInterval) == 0 then
			for pCity in pPlayer:Cities() do
				if pCity then
					local pOldPlot = uSalmon[pCity:GetID()]
					local pPlaced = nil
					local iOldRes = nil
					if pOldPlot and pOldPlot:GetOwner() == iPlayer then
						iOldRes = pOldPlot:GetResourceType()
						pPlaced = PlaceSalmon(pPlayer, pCity:GetX(), pCity:GetY(), false, 1)
						if pPlaced and iOldRes > -1 then
							local iNewRes = pPlaced:GetResourceType()
							if iNewRes ~= iOldRes then
								if iNewRes == iBreedingGround then
									PushNotification(pCity, pPlaced, iOldRes, false)
								else
									PushNotification(pCity, pPlaced, iNewRes, true)
								end
							end
						end
					end
				end
			end
		end
	end
end
-------------------------------------------------------------------------------------------------------------------------
-- Salmon Migration: Initialize Tables
-------------------------------------------------------------------------------------------------------------------------
function InitializeTables()
	for tRow in GameInfo.Improvement_ResourceTypes() do
		if tRow.ImprovementType == "IMPROVEMENT_FISHING_BOATS" or tRow.ImprovementType == "IMPROVEMENT_OFFSHORE_PLATFORM" then
			tValidResources[GameInfoTypes[tRow.ResourceType]] = GameInfoTypes[tRow.ImprovementType]
		end
	end
	for iPlot = 0, Map.GetNumPlots() - 1, 1 do
	    local pPlot = Map.GetPlotByIndex(iPlot)
		if pPlot then
			local iPlayer = pPlot:GetOwner()
			local iResource = pPlot:GetResourceType()
			if iPlayer > -1 then
				local pPlayer = Players[iPlayer]
				if pPlayer:IsEverAlive() and pPlayer:GetCivilizationType() == iCiv then
					if iResource > -1 then
						local iImprovement = tValidResources[iResource]
						if iImprovement then
							if iImprovement == iPlatform and pPlot:IsWater() then
								tOil[pPlot] = true
							end
						end
					end
					local tCityPlot = load(pPlot, "tSalmonPlots")
					if tCityPlot then
						local pCity = sDecompilePlotID(tCityPlot):GetPlotCity()
						if pCity and pCity:GetOwner() == iPlayer then
							tSalmon[pCity:GetID()] = pPlot
						end
					end
					local uCityPlot = load(pPlot, "uSalmonPlots")
					if uCityPlot then
						local pCity = sDecompilePlotID(uCityPlot):GetPlotCity()
						if pCity and pCity:GetOwner() == iPlayer then
							uSalmon[pCity:GetID()] = pPlot
						end
					end
				end
			end
		end
	end
end

if JFD_IsCivilisationActive(iCiv) then
	InitializeTables()
	if load("GAME", "Plankhouse_RiverCheckInitalised") then
		Events.SerialEventGameDataDirty.Add(Plankhouse_RiverCheckDirty)
	else
		GameEvents.CityConstructed.Add(Plankhouse_RiverCheckInitialTrigger)
	end
	GameEvents.CityCanConstruct.Add(Plankhouse_CanBuild)
	Events.SerialEventHexCultureChanged.Add(AutomaticFishingBoats)
	GameEvents.TeamSetHasTech.Add(Tech_AutomaticFishingBoats)
	GameEvents.PlayerCityFounded.Add(CityFounded_PlaceSalmon)
	GameEvents.PlayerDoTurn.Add(MigrateSalmon)
end
--=======================================================================================================================
--=======================================================================================================================