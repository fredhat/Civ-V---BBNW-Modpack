-- BuildingYieldFromGreatWorksInCity
-- Original Author: Sukritact
-- Lightly Edited By: F0S
--------------------------------------------------------------
WARN_NOT_SHARED = false; include( "SaveUtils" ); MY_MOD_NAME = "BuildingYieldFromGreatWorksInCity";

function BuildingYieldFromGreatWorksInCity(iPlayer)
	local pPlayer = Players[iPlayer]
	for row in GameInfo.Building_YieldFromGreatWorksInCity() do
		local iBuilding = GameInfo.Buildings[row.BuildingType].ID
		local iYield = YieldTypes[row.YieldType]
		local iDeltaModifier = row.Yield
		for pCity in pPlayer:Cities() do
			local iCity = pCity:GetID()
			local iGreatWorksNum = pCity:GetNumGreatWorks()
			local iDelta = (iGreatWorksNum*iDeltaModifier)
			if pCity:IsHasBuilding(iBuilding) then
				if iYield == 4 then
					local iOldDelta = load( pPlayer, iCity .. "B" .. iBuilding .. "Y" .. 4)
					save( pPlayer, iCity .. "B" .. iBuilding .. "Y" .. 4, iDelta)
					if iOldDelta == nil then
						pCity:ChangeJONSCulturePerTurnFromBuildings(iDelta)
					else
						pCity:ChangeJONSCulturePerTurnFromBuildings(iDelta - iOldDelta)
					end
				elseif iYield == 5 then
					pCity:SetNumRealBuilding(GameInfoTypes["BUILDING_ABUSIMBEL_FAITH_DUMMY"], iDelta)
					--if IsTurnStart == true then
						--pPlayer:ChangeFaith(iDelta)
					--end
				else
					local iOldDelta = load( pPlayer, iCity .. "B" .. iBuilding .. "Y" .. iYield)
					save (pPlayer, iCity .. "B" .. iBuilding .. "Y" .. iYield, iDelta)
					if iOldDelta == nil then
						pCity:ChangeBaseYieldRateFromBuildings(iYield, iDelta)
					else
						pCity:ChangeBaseYieldRateFromBuildings(iYield, iDelta - iOldDelta)
					end
				end
			else
				if iYield == 4 then
					local iOldDelta = load( pPlayer, iCity .. "B" .. iBuilding .. "Y" .. 4)
					if iOldDelta == nil then
						
					elseif iOldDelta > 0 then
						save (pPlayer, iCity .. "B" .. iBuilding .. "Y" .. 4, 0)
						pCity:ChangeJONSCulturePerTurnFromBuildings(-iOldDelta)
					end
				elseif iYield == 5 then
					pCity:SetNumRealBuilding(GameInfoTypes["BUILDING_ABUSIMBEL_FAITH_DUMMY"], 0)
				else
					local iOldDelta = load( pPlayer, iCity .. "B" .. iBuilding .. "Y" .. iYield)
					if iOldDelta == nil then
						
					elseif iOldDelta > 0 then
						save (pPlayer, iCity .. "B" .. iBuilding .. "Y" .. iYield, 0)
						pCity:ChangeBaseYieldRateFromBuildings(iYield, -iOldDelta)
					end
				end
			end
		end	
	end
end

function BuildingYieldFromGreatWorksInCityFaith(iPlayer)
	IsTurnStart = true
	BuildingYieldFromGreatWorksInCity(iPlayer)
	IsTurnStart = false
end

function BuildingYieldFromGreatWorksInCitySwap()
	local iPlayer = Game.GetActivePlayer()
	IsTurnStart = false
	BuildingYieldFromGreatWorksInCity(iPlayer)
end

GameEvents.PlayerDoTurn.Add(BuildingYieldFromGreatWorksInCityFaith)
Events.SerialEventCityInfoDirty.Add(BuildingYieldFromGreatWorksInCitySwap)