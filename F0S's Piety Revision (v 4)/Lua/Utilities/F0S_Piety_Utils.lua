-- F0S_Piety_Utils
-- Author: F0S
--=======================================================================================================================
-- UTILITIES
--=======================================================================================================================
-- GLOBALS
------------------------------------------------------------------------------------------------------------------------
function GetStrongestMilitaryUnit(player, ignoreResources, ...)
	local unit = {["Combat"] = 0}
	for i, unitCombatType in pairs(arg) do
		for row in GameInfo.Units("CombatClass = \'" .. unitCombatType .. "\'") do
			if player:CanTrain(row.ID, ignoreResources) and row.Combat > unit.Combat then
				unit = row
			end
		end
	end
	return unit.ID
end

function GetUniqueUnit(player, unitClass)
	local unitType = nil
	local civType = GameInfo.Civilizations[player:GetCivilizationType()].Type
	for uniqueUnit in GameInfo.Civilization_UnitClassOverrides{CivilizationType = civType, UnitClassType = unitClass} do
		unitType = uniqueUnit.UnitType
		break
	end
	if unitType == nil then
		unitType = GameInfo.UnitClasses[unitClass].DefaultUnit
	end
	return unitType
end

function GetPlayerHolyCity(player)
	local cityToReturn = player:GetCapitalCity()
	local religionID = player:GetReligionCreatedByPlayer()
	if religionID > ReligionTypes.RELIGION_PANTHEON then
		local holyCity = Game.GetHolyCityForReligion(religionID, -1)
		if holyCity and holyCity:GetOwner() == player:GetID() then
			cityToReturn = holyCity
		end
	end
	return cityToReturn
end

function CityHasBelief(city, beliefID)
	local religionID = city:GetReligiousMajority()
	local player = Players[city:GetOwner()]
	if religionID > ReligionTypes.RELIGION_PANTHEON then
		for i,v in ipairs(Game.GetBeliefsInReligion(religionID)) do
			if v == beliefID then return true end
		end
	elseif religionID == ReligionTypes.RELIGION_PANTHEON and player:HasCreatedPantheon() then
		return (player:GetBeliefInPantheon() == beliefID)
	end
	return false
end

function PlayerHasBelief(player, beliefID)
	local religionID = player:GetReligionCreatedByPlayer()
	if religionID > ReligionTypes.RELIGION_PANTHEON then
		for i,v in ipairs(Game.GetBeliefsInReligion(religionID)) do
			if v == beliefID then return true end
		end
	elseif religionID == ReligionTypes.RELIGION_PANTHEON and player:HasCreatedPantheon() then
		return (player:GetBeliefInPantheon() == beliefID)
	end
	return false
end
--=======================================================================================================================
--=======================================================================================================================