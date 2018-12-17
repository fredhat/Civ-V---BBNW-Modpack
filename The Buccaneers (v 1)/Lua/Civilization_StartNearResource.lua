-- Civilization_StartNearResource
-- Author: Sukritact
-- Edited By: F0S
--------------------------------------------------------------
--[[

For luxuries and bonuses, this code will replace one of the
local resource with another. The 'replacee' will always be of
the same type, so luxuries will always replace luxuries, etc.

The replacee is removed completely in an attempt to maintain 
balance (so you won't end up with too many types of luxuries)

For strategics, a source of quantity between 2-4 is placed on the first
valid tile empty of other resources.

If no normally valid tiles are found then the resource will be 
forcibly placed; the only limitation being resources that can 
be placed in the sea will never appear on land and vice-versa

Resources that already exist locally are ignored.

]]
--------------------------------------------------------------
WARN_NOT_SHARED = false; include("Sukritact_SaveUtils"); MY_MOD_NAME = "Civilization_StartNearResource";
include("PlotIterators")
--------------------------------------------------------------
-- Utility functions
--------------------------------------------------------------
function GetRandom(lower, upper)
    return Map.Rand((upper + 1) - lower, "") + lower
end
--------------------------------------------------------------
-- Main Code
--------------------------------------------------------------
if GetPersistentProperty("Civilization_StartNearResource") ~= nil then
    return
else
    SetPersistentProperty("Civilization_StartNearResource", true)
end

for iPlayer = 0, GameDefines.MAX_MAJOR_CIVS - 1 do
    local pPlayer = Players[iPlayer]
    if pPlayer:IsEverAlive() then
        local iCiv = pPlayer:GetCivilizationType()
        local tResourcestoPlace = {}
		local tResourceAmount = {}
        local iEntries = 0
        for row in GameInfo.Civilization_StartNearResource("CivilizationType = '" .. GameInfo.Civilizations[iCiv].Type .. "'") do
            tResourcestoPlace[row.ResourceType] = GameInfoTypes[row.ResourceType]
			tResourceAmount[row.ResourceType] = row.Amount
            iEntries = iEntries + 1
        end
        if iEntries > 0 then
			local pPlot = pPlayer:GetStartingPlot()
			if pPlot then
				for sKey, iVal in pairs(tResourcestoPlace) do
					local sResourceClass = GameInfo.Resources[iVal].ResourceClassType
					local iNumtoPlace = GetRandom(1,3)
					if tResourceAmount[sKey] and GetRandom(0,1) then return end
					local bStrategic = false
					local bHasPlaced = false
					if sResourceClass == "RESOURCECLASS_RUSH" or sResourceClass == "RESOURCECLASS_MODERN" then
						bStrategic = true
					end
					--Strategics
					if bStrategic then
						for pIterPlot in PlotAreaSpiralIterator(pPlot, 3, GetRandom(1,6), DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
							if pIterPlot and pIterPlot:CanHaveResource(iVal, true) and pIterPlot:GetResourceType() == -1 then
								pIterPlot:SetResourceType(iVal, GetRandom(2,4))
								bHasPlaced = true
								break
							end
						end
						--If None have yet been placed
						local bWater = false
						if not bHasPlaced then
							for row in GameInfo.Resource_TerrainBooleans("ResourceType = '" .. sKey .. "'") do
								if row.TerrainType == TERRAIN_OCEAN or row.TerrainType == TERRAIN_COAST then
									bWater = true
								end
							end
							for pIterPlot in PlotAreaSpiralIterator(pPlot, 3, GetRandom(1,6), DIRECTION_CLOCKWISE, DIRECTION_INWARDS, CENTRE_EXCLUDE) do
								if not pIterPlot:IsMountain() and pIterPlot:GetResourceType() == -1 and pIterPlot:GetFeatureType() == -1 then
									if pIterPlot:IsWater() and not pIterPlot:IsLake() and bWater then
										pIterPlot:SetResourceType(iVal, GetRandom(2,4))
										break
									end
								end
							end
						end
					--Luxuries
					else
						local bWater = false
						for row in GameInfo.Resource_TerrainBooleans("ResourceType = '" .. sKey .. "'") do
							if row.TerrainType == TERRAIN_OCEAN or row.TerrainType == TERRAIN_COAST then
								bWater = true
							end
						end
						local tPlots = {}
						for pIterPlot in PlotAreaSpiralIterator(pPlot, 3, GetRandom(1,6), DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
							if not pIterPlot:IsMountain() and pIterPlot:GetResourceType() == -1 and not pIterPlot:IsLake() then
								table.insert(tPlots, pIterPlot)
							end
						end
						while iNumtoPlace > 0 and #tPlots > 0 do
							local iRandom = GetRandom(1, #tPlots)
							local pSpawnPlot = tPlots[iRandom]
							if pSpawnPlot:CanHaveResource(iVal, true) then
								--Fine Tuning
								if pSpawnPlot:IsWater() then
									if bWater and pSpawnPlot:GetFeatureType() == -1 then
										pSpawnPlot:SetResourceType(iVal, 1)
										iNumtoPlace = iNumtoPlace - 1
									end
								else
									if iVal == GameInfo.Resources["RESOURCE_SUGAR"].ID then
										local iFeature = pSpawnPlot:GetFeatureType()
										local iTerrain = pSpawnPlot:GetTerrainType()
										if iFeature == FeatureTypes.FEATURE_FLOOD_PLAINS or iFeature == FeatureTypes.FEATURE_MARSH or ((iTerrain == TerrainTypes.TERRAIN_GRASS or iTerrain == TerrainTypes.TERRAIN_PLAINS) and iFeature == -1 and not pSpawnPlot:IsHills()) then
											pSpawnPlot:SetResourceType(iVal, 1)
											iNumtoPlace = iNumtoPlace - 1
										end
									elseif iVal == GameInfo.Resources["RESOURCE_WINE"].ID then
										local iFeature = pSpawnPlot:GetFeatureType()
										local iTerrain = pSpawnPlot:GetTerrainType()
										if (iTerrain == TerrainTypes.TERRAIN_GRASS or iTerrain == TerrainTypes.TERRAIN_PLAINS) and iFeature == -1 and not pSpawnPlot:IsHills() then
											pSpawnPlot:SetResourceType(iVal, 1)
											iNumtoPlace = iNumtoPlace - 1
										end
									else
										pSpawnPlot:SetResourceType(iVal, 1)
										iNumtoPlace = iNumtoPlace - 1
									end
								end
							end
							table.remove(tPlots, pSpawnPlot)
						end
					end
				end
			end
        end
    end
end
--------------------------------------------------------------