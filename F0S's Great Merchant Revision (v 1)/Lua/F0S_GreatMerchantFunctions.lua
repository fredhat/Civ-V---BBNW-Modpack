-- F0S_GreatMerchantFunctions
-- Author: F0S
--==========================================================================================================================
-- CORE FUNCTIONS
--==========================================================================================================================
-- GREAT MERCHANT MISSIONS
----------------------------------------------------------------------------------------------------------------------------
-- F0S_Dummy_Trade_MissionPossible
local unitClassGreatMerchantID = GameInfo.UnitClasses["UNITCLASS_MERCHANT"].ID
local unitCaravanID = GameInfo.Units["UNIT_CARAVAN"].ID
local missionDummyTradeID = GameInfo.Missions["MISSION_DUMMY_TRADE"].ID
local buildingDummyTradeID = GameInfo.Buildings["BUILDING_F0S_MERCHANT_TRADE_DUMMY"].ID

function F0S_Dummy_Trade_MissionPossible(playerID, unitID, missionID, data1, data2, _, _, plotX, plotY, bTestVisible)
	local player = Players[playerID]
	if missionID == missionDummyTradeID then
		if player:IsEverAlive() then
			local unit = player:GetUnitByID(unitID)
			if unit and unit:GetUnitClassType() == unitClassGreatMerchantID then
				local plot = unit:GetPlot()
				if plot and plot:GetOwner() == playerID and plot:IsCity() then
					local city = plot:GetPlotCity()
					if city and not city:IsHasBuilding(buildingDummyTradeID) then
						return true
					end
				end
			end
		end
	end
	return false
end

GameEvents.CustomMissionPossible.Add(F0S_Dummy_Trade_MissionPossible)

-- F0S_Dummy_Trade_MissionStart
local CUSTOM_MISSION_NO_ACTION = 0
local CUSTOM_MISSION_ACTION = 1
local CUSTOM_MISSION_DONE = 2
local CUSTOM_MISSION_ACTION_AND_DONE = 3
function F0S_Dummy_Trade_MissionStart(playerID, unitID, missionID, data1, data2, flags, turn)
	local player = Players[playerID]
	if missionID == missionDummyTradeID then
		if player:IsEverAlive() then
			local unit = player:GetUnitByID(unitID)
			if unit then
				local plot = unit:GetPlot()
				if plot then
					local city = plot:GetPlotCity()
					if city then
						city:SetNumRealBuilding(buildingDummyTradeID, 1)
						local caravan = player:InitUnit(unitCaravanID, city:GetX(), city:GetY(), UNITAI_TRADE_UNIT)
						caravan:JumpToNearestValidPlot()
						return CUSTOM_MISSION_ACTION
					end
				end
			end
		end
	end
	return CUSTOM_MISSION_NO_ACTION
end

GameEvents.CustomMissionStart.Add(F0S_Dummy_Trade_MissionStart)

-- F0S_Dummy_Trade_MissionCompleted
function F0S_Dummy_Trade_MissionCompleted(playerID, unitID, missionID, data1, data2, flags, turn)
	local player = Players[playerID]
	if missionID == missionDummyTradeID then
		if player:IsEverAlive() then
			local unit = player:GetUnitByID(unitID)
			if unit then
				unit:Kill(true, -1)
				return true
			end
		end
	end
	return false
end

GameEvents.CustomMissionCompleted.Add(F0S_Dummy_Trade_MissionCompleted)
--==========================================================================================================================
--==========================================================================================================================