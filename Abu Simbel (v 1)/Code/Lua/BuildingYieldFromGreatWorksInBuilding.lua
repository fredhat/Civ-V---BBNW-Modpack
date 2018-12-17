-- BuildingYieldFromGreatWorksInBuilding
-- Original Author: Sukritact
-- Lightly Edited By: F0S
--------------------------------------------------------------
WARN_NOT_SHARED = false; include( "SaveUtils" ); MY_MOD_NAME = "BuildingYieldFromGreatWorksInBuilding";

local isTurnStart = false;

function BuildingYieldFromGreatWorksInBuilding(iPlayer)
	local pPlayer = Players[iPlayer]
	for row in GameInfo.Building_YieldFromGreatWorksInBuilding() do
		local iBuilding = GameInfo.Buildings[row.BuildingType].ID
		local iYield = YieldTypes[row.YieldType]
		local iDeltaModifier = row.Yield
		for pCity in pPlayer:Cities() do
			local iCity = pCity:GetID()
			local strCityName = pCity:GetName()
			local strBuildingClass = GameInfo.Buildings[iBuilding].BuildingClass
			local iBuildingClass = GameInfo.BuildingClasses[strBuildingClass].ID
			local iGreatWorksNum = pCity:GetNumGreatWorksInBuilding(iBuildingClass)
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

function BuildingYieldFromGreatWorksInBuildingFaith(iPlayer)
	IsTurnStart = true
	BuildingYieldFromGreatWorksInBuilding(iPlayer)
	IsTurnStart = false
end

function BuildingYieldFromGreatWorksInBuildingSwap()
	local iPlayer = Game.GetActivePlayer()
	IsTurnStart = false
	BuildingYieldFromGreatWorksInBuilding(iPlayer)
end

GameEvents.PlayerDoTurn.Add(BuildingYieldFromGreatWorksInBuildingFaith)
Events.SerialEventCityInfoDirty.Add(BuildingYieldFromGreatWorksInBuildingSwap)