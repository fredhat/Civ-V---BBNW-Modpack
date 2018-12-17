-- F0S_Piety_Functions
-- Author: F0S
--=======================================================================================================================
-- INCLUDES
--=======================================================================================================================
WARN_NOT_SHARED = false; include( "SaveUtils" ); MY_MOD_NAME = "F0S_Piety_Functions";
include("FLuaVector.lua")
include("F0S_Piety_Utils.lua")
--=======================================================================================================================
-- UTILITIES
--=======================================================================================================================
-- GLOBALS
------------------------------------------------------------------------------------------------------------------------
-- Players
local activePlayerID = Game.GetActivePlayer()
local activePlayer = Players[activePlayerID]
-- UnitClasses
local unitClassSettlerID = GameInfoTypes["UNITCLASS_SETTLER"]
local unitClassInquisitorID = GameInfoTypes["UNITCLASS_INQUISITOR"]
local unitClassMissionaryID = GameInfoTypes["UNITCLASS_MISSIONARY"]
local unitClassProphetID = GameInfoTypes["UNITCLASS_PROPHET"]
local unitClassWarriorID = GameInfoTypes["UNITCLASS_WARRIOR"]
-- Missions
local missionCreateGreatWorkID = GameInfoTypes["MISSION_CREATE_GREAT_WORK"]
-- God of War
local beliefGodWarID = GameInfo.Beliefs["BELIEF_GOD_WAR"].ID
local promotionMoraleID = GameInfoTypes["PROMOTION_MORALE"]
local promotionGodWarID = GameInfoTypes["PROMOTION_F0S_GODWAR"]
-- Sacred Waters
local beliefSacredWatersID = GameInfo.Beliefs["BELIEF_SACRED_WATERS"].ID
local promotionSacredWatersID = GameInfoTypes["PROMOTION_F0S_SACRED_WATERS"]
-- Rain Dancing
local beliefRainDancingID = GameInfo.Beliefs["BELIEF_RELIGIOUS_SETTLEMENTS"].ID
local buildingRainDancingID = GameInfo.Buildings["BUILDING_F0S_PIETY_DUMMY_LAKES"].ID
-- Ceremonial Burial and Divine Celebration
local beliefCeremonialBurialID = GameInfo.Beliefs["BELIEF_CEREMONIAL_BURIAL"].ID
local beliefDivineCelebrationID = GameInfo.Beliefs["BELIEF_CHARITABLE_MISSIONS"].ID
local buildingGoldenAgeID = GameInfo.Buildings["BUILDING_F0S_PIETY_DUMMY_GOLDEN_AGE"].ID
-- Spiritual Traders
local beliefSpiritualTradersID = GameInfo.Beliefs["BELIEF_F0S_SPIRITUAL_TRADERS"].ID
local buildingSpiritualTradersRouteID = GameInfo.Buildings["BUILDING_F0S_PIETY_DUMMY_TRADE"].ID
local buildingSpiritualTradersFaithID = GameInfo.Buildings["BUILDING_F0S_PIETY_DUMMY_FAITH"].ID
-- Holy Warriors
local beliefHolyWarriorsID = GameInfo.Beliefs["BELIEF_HOLY_WARRIORS"].ID
local buildingHolyWarriorsID = GameInfo.Buildings["BUILDING_F0S_PIETY_DUMMY_XP"].ID
-- Choral Music
local beliefChoralMusicID = GameInfo.Beliefs["BELIEF_CHORAL_MUSIC"].ID
local buildingChoralMusicID = GameInfo.Buildings["BUILDING_F0S_PIETY_DUMMY_GMP"].ID
-- Religious Art
local beliefReligiousArtID = GameInfo.Beliefs["BELIEF_RELIGIOUS_ART"].ID
local buildingReligiousArtID = GameInfo.Buildings["BUILDING_F0S_PIETY_DUMMY_GAP"].ID
-- Liturgical Drama
local beliefLiturgicalDramaID = GameInfo.Beliefs["BELIEF_LITURGICAL_DRAMA"].ID
local buildingLiturgicalDramaID = GameInfo.Buildings["BUILDING_F0S_PIETY_DUMMY_GWP"].ID
-- City of God
local beliefCityOfGodID = GameInfo.Beliefs["BELIEF_HOLY_ORDER"].ID
local buildingCityOfGodID = GameInfo.Buildings["BUILDING_F0S_PIETY_DUMMY_PRESSURE"].ID
-- Underground Sect
local beliefUndergroundSectID = GameInfo.Beliefs["BELIEF_F0S_UNDERGROUND_SECT"].ID
local buildingUndergroundSectID = GameInfo.Buildings["BUILDING_F0S_PIETY_DUMMY_SPY"].ID
-- Papal Primacy
local beliefPapalPrimacyID = GameInfo.Beliefs["BELIEF_EVANGELISM"].ID
local buildingPapalPrimacyID = GameInfo.Buildings["BUILDING_F0S_PIETY_DUMMY_DIPLOMAT"].ID
-- Religious Settlements
local beliefReligiousSettlementsID = GameInfo.Beliefs["BELIEF_PEACE_LOVING"].ID
-- Religious Migration
local beliefReligiousMigrationID = GameInfo.Beliefs["BELIEF_CHURCH_PROPERTY"].ID
-- Pilgrimage
local beliefPilgrimageID = GameInfo.Beliefs["BELIEF_PILGRIMAGE"].ID
local promotionPilgrimageID = GameInfoTypes["PROMOTION_UNWELCOME_EVANGELIST"]
-- Deus Vult
local beliefDeusVultID = GameInfo.Beliefs["BELIEF_MISSIONARY_ZEAL"].ID
-- Holy Relics
local beliefHolyRelicsID = GameInfo.Beliefs["BELIEF_F0S_HOLY_RELICS"].ID
local buildingHolyRelicsID = GameInfo.Buildings["BUILDING_F0S_RELIQUARY"].ID
------------------------------------------------------------------------------------------------------------------------
-- UTILITY FUNCTIONS
------------------------------------------------------------------------------------------------------------------------
-- GetNumForeignTradeRoutes
function GetNumForeignTradeRoutes(player)
	local numForeignTradeRoutes = 0
	local playerID = player:GetID()
	for otherPlayerID = 0, GameDefines.MAX_CIV_PLAYERS - 1 do
		local otherPlayer = Players[otherPlayerID]
		if otherPlayerID == playerID then
			for i, v in ipairs(otherPlayer:GetTradeRoutes()) do
				if v.ToID ~= playerID then
					numForeignTradeRoutes = numForeignTradeRoutes + 1
					if v.Domain == DomainTypes.DOMAIN_SEA then
						numForeignTradeRoutes = numForeignTradeRoutes + 1
					end
				end
			end
		else
			for i, v in ipairs(otherPlayer:GetTradeRoutes()) do
				if v.ToID == playerID then
					numForeignTradeRoutes = numForeignTradeRoutes + 1
					if v.Domain == DomainTypes.DOMAIN_SEA then
						numForeignTradeRoutes = numForeignTradeRoutes + 1
					end
				end
			end
		end
	end
	return numForeignTradeRoutes
end

-- GetNumReligiousAllies
function GetNumReligiousAllies(player)
	local numReligiousAllies = 0
	local religionID = player:GetReligionCreatedByPlayer()
	if religionID > ReligionTypes.RELIGION_PANTHEON then
		for otherPlayerID = 0, GameDefines.MAX_CIV_PLAYERS - 1 do
			local minorPlayer = Players[otherPlayerID]
			if minorPlayer:IsEverAlive() and minorPlayer:IsMinorCiv() then
				local minorCapitalCity = minorPlayer:GetCapitalCity()
				if minorCapitalCity and minorCapitalCity:GetReligiousMajority() == religionID and (minorPlayer:GetMinorCivFriendshipLevelWithMajor(player:GetID()) == 2) then
					numReligiousAllies = numReligiousAllies + 1
				end
			end
		end
	end
	return numReligiousAllies
end

-- GetNumForeignFollowers
function GetNumForeignFollowers(player)
	local numForeignFollowers = 0
	local religionID = player:GetReligionCreatedByPlayer()
	if religionID > ReligionTypes.RELIGION_PANTHEON then
		for otherPlayerID = 0, GameDefines.MAX_CIV_PLAYERS - 1 do
			local otherPlayer = Players[otherPlayerID]
			if otherPlayer:IsEverAlive() and otherPlayerID ~= player:GetID() then
				for city in otherPlayer:Cities() do
					if city:GetReligiousMajority() == religionID then
						numForeignFollowers = numForeignFollowers + 1
					end
				end
			end
		end
	end
	return numForeignFollowers
end

-- CityHasBuildingClass
function CityHasBuildingClass(city, buildingClass)
  for row in GameInfo.Buildings() do
		local building = GameInfoTypes[row.Type]
		if (row.BuildingClass == buildingClass) and city:IsHasBuilding(building) then
			return true
		end
	end
  return false
end

-- BoolToInt
function BoolToInt(var)
  return var and 1 or 0
end
------------------------------------------------------------------------------------------------------------------------
-- RELIGION BUILDING CHECKS
------------------------------------------------------------------------------------------------------------------------
-- BuildingCheck
function BuildingCheck(player)
	local numCapitalGWP = 0
	local numCapitalGAP = 0
	local numCapitalGMP = 0
	local capitalCity = player:GetCapitalCity()
	local holyCity = GetPlayerHolyCity(player)
	for city in player:Cities() do
		-- Rain Dancing Lake Building Check
		city:SetNumRealBuilding(buildingRainDancingID, BoolToInt(CityHasBelief(city, beliefRainDancingID)))
		-- Holy Warriors XP Building Check
		city:SetNumRealBuilding(buildingHolyWarriorsID, BoolToInt(CityHasBelief(city, beliefHolyWarriorsID)))
		-- Liturgical Drama City Counter
		if CityHasBelief(city, beliefLiturgicalDramaID) then
			numCapitalGWP = numCapitalGWP + (BoolToInt(CityHasBuildingClass(city, "BUILDINGCLASS_AMPHITHEATER")) * 3)
		end
		-- Religious Art City Counter
		if CityHasBelief(city, beliefReligiousArtID) then
			numCapitalGAP = numCapitalGAP + (BoolToInt(CityHasBuildingClass(city, "BUILDINGCLASS_TEMPLE")) * 3) + BoolToInt(CityHasBuildingClass(city, "BUILDINGCLASS_JFD_CHAPEL_ART")) + BoolToInt(CityHasBuildingClass(city, "BUILDINGCLASS_JFD_CHAPEL_MUSIC"))
		end
		-- Choral Music City Counter
		if CityHasBelief(city, beliefChoralMusicID) then
			numCapitalGMP = numCapitalGMP + (BoolToInt(CityHasBuildingClass(city, "BUILDINGCLASS_OPERA_HOUSE")) * 3)
		end
		-- Remove Capital Buildings from Non-Capital
		if city ~= capitalCity then
			city:SetNumRealBuilding(buildingSpiritualTradersRouteID, 0)
			city:SetNumRealBuilding(buildingSpiritualTradersFaithID, 0)
			city:SetNumRealBuilding(buildingLiturgicalDramaID, 0)
			city:SetNumRealBuilding(buildingReligiousArtID, 0)
			city:SetNumRealBuilding(buildingChoralMusicID, 0)
			city:SetNumRealBuilding(buildingPapalPrimacyID, 0)
		end
	end
	if capitalCity then
		-- Spiritual Traders Capital Buildings
		if PlayerHasBelief(player, beliefSpiritualTradersID) then
			capitalCity:SetNumRealBuilding(buildingSpiritualTradersRouteID, 1)
			capitalCity:SetNumRealBuilding(buildingSpiritualTradersFaithID, GetNumForeignTradeRoutes(player))
		end
		-- Liturgical Drama Capital Buildings
		capitalCity:SetNumRealBuilding(buildingLiturgicalDramaID, numCapitalGWP)
		-- Liturgical Drama Capital Buildings
		capitalCity:SetNumRealBuilding(buildingReligiousArtID, numCapitalGAP)
		-- Liturgical Drama Capital Buildings
		capitalCity:SetNumRealBuilding(buildingChoralMusicID, numCapitalGMP)
		-- Papal Primacy Capital Buildings
		if PlayerHasBelief(player, beliefPapalPrimacyID) then
			capitalCity:SetNumRealBuilding(buildingPapalPrimacyID, GetNumReligiousAllies(player))
		end
	end
	if holyCity then
		-- City of God Pressure Building Check
		if PlayerHasBelief(player, beliefCityOfGodID) then
			holyCity:SetNumRealBuilding(buildingCityOfGodID, 1)
		end
		-- Holy Relics Reliquaries Check
		if PlayerHasBelief(player, beliefHolyRelicsID) then
			holyCity:SetNumRealBuilding(buildingHolyRelicsID, 1)
		end
	end
end
------------------------------------------------------------------------------------------------------------------------
-- RELIGION FOUNDING TRIGGERS
------------------------------------------------------------------------------------------------------------------------
--PantheonFoundedTrigger
function PantheonFoundedTrigger(playerID, capitalCityID, religionID, beliefID)
	local player = Players[playerID]
	if player:IsEverAlive() and player:GetCapitalCity() then
		local capitalCity = player:GetCapitalCity()
		if capitalCity then
			local cityX = capitalCity:GetX()
			local cityY = capitalCity:GetY()
			if beliefID == beliefGodWarID then
				local warriorUnitToSpawn = GetUniqueUnit(player, unitClassWarriorID)
				local unit = player:InitUnit(GameInfoTypes[warriorUnitToSpawn], cityX, cityY, UNITAI_ATTACK)
				unit:SetExperience(capitalCity:GetProductionExperience(unit:GetUnitType()))
				unit:SetHasPromotion(promotionMoraleID, true)
				unit:SetHasPromotion(promotionGodWarID, true)
				unit:SetName("Kratos")
				unit:JumpToNearestValidPlot()
			end
		end
		BuildingCheck(player)
	end
end

GameEvents.PantheonFounded.Add(PantheonFoundedTrigger)

-- ReligionFoundedTrigger
function ReligionFoundedTrigger(playerID, holyCityID, religionID, ...)
	local player = Players[playerID]
	if player:IsEverAlive() then
		local targetCity = GetPlayerHolyCity(player)
		if targetCity then
			local cityX = targetCity:GetX()
			local cityY = targetCity:GetY()
			for i,v in ipairs(arg) do
				-- Religious Settlements Settler
				if v == beliefReligiousSettlementsID then
					local settlerUnitToSpawn = GetUniqueUnit(player, unitClassSettlerID)
					player:InitUnit(GameInfoTypes[settlerUnitToSpawn], cityX, cityY, UNITAI_SETTLE)
				-- Ceremonial Burial Golden Age
				elseif v == beliefCeremonialBurialID then
					targetCity:SetNumRealBuilding(buildingGoldenAgeID, (targetCity:GetNumBuilding(buildingGoldenAgeID) + 1))
				-- Religious Migration Pop Boost
				elseif v == beliefReligiousMigrationID then
					targetCity:ChangePopulation(3, true)
					Network.SendUpdateCityCitizens(targetCity:GetID())
				-- Pilgrimage Missionaries
				elseif v == beliefPilgrimageID then
					local missionaryUnitToSpawn = GetUniqueUnit(player, unitClassMissionaryID)
					player:InitUnit(GameInfoTypes[missionaryUnitToSpawn], cityX, cityY, UNITAI_MISSIONARY)
					player:InitUnit(GameInfoTypes[missionaryUnitToSpawn], cityX, cityY, UNITAI_MISSIONARY)
					for unit in player:Units() do
						if unit:GetUnitClassType() == unitClassMissionaryID and unit:IsHasPromotion(promotionPilgrimageID) then
							unit:SetHasPromotion(promotionPilgrimageID, false)
						end
					end
				-- Deus Vult Army
				elseif v == beliefDeusVultID then
					local inquisitorUnitToSpawn = GetUniqueUnit(player, unitClassInquisitorID)
					player:InitUnit(GameInfoTypes[inquisitorUnitToSpawn], cityX, cityY, UNITAI_INQUISITOR)
					player:InitUnit(GameInfoTypes[inquisitorUnitToSpawn], cityX, cityY, UNITAI_INQUISITOR)
					local strongestMountedUnitID = GetStrongestMilitaryUnit(player, true, "UNITCOMBAT_MOUNTED", "UNITCOMBAT_MOUNTED_RANGED", "UNITCOMBAT_ARMOR") or "UNIT_HORSEMAN"
					local mountedUnitToSpawn = GetUniqueUnit(player, GameInfo.Units[strongestMountedUnitID].Class)
					player:InitUnit(GameInfoTypes[mountedUnitToSpawn], cityX, cityY, UNITAI_ATTACK):JumpToNearestValidPlot()
					player:InitUnit(GameInfoTypes[mountedUnitToSpawn], cityX, cityY, UNITAI_ATTACK):JumpToNearestValidPlot()
					local strongestMeleeUnitID = GetStrongestMilitaryUnit(player, true, "UNITCOMBAT_MELEE", "UNITCOMBAT_GUN") or "UNIT_WARRIOR"
					local meleeUnitToSpawn = GetUniqueUnit(player, GameInfo.Units[strongestMeleeUnitID].Class)
					player:InitUnit(GameInfoTypes[meleeUnitToSpawn], cityX, cityY, UNITAI_ATTACK):JumpToNearestValidPlot()
					player:InitUnit(GameInfoTypes[meleeUnitToSpawn], cityX, cityY, UNITAI_ATTACK):JumpToNearestValidPlot()
					local strongestSiegeUnitID = GetStrongestMilitaryUnit(player, true, "UNITCOMBAT_SIEGE") or "UNIT_CATAPULT"
					local siegeUnitToSpawn = GetUniqueUnit(player, GameInfo.Units[strongestSiegeUnitID].Class)
					player:InitUnit(GameInfoTypes[siegeUnitToSpawn], cityX, cityY, UNITAI_CITY_BOMBARD):JumpToNearestValidPlot()
					player:InitUnit(GameInfoTypes[siegeUnitToSpawn], cityX, cityY, UNITAI_CITY_BOMBARD):JumpToNearestValidPlot()
				-- City of God Holy City Pressure
				elseif v == beliefCityOfGodID then
					targetCity:SetNumRealBuilding(buildingCityOfGodID, 1)
				-- Underground Sect Spy
				elseif v == beliefUndergroundSectID then
					targetCity:SetNumRealBuilding(buildingUndergroundSectID, 1)
				end
			end
		end
		BuildingCheck(player)
	end
end

GameEvents.ReligionFounded.Add(ReligionFoundedTrigger)

-- ReligionEnhancedTrigger
function ReligionEnhancedTrigger(playerID, religionID, ...)
	local player = Players[playerID]
	if player:IsEverAlive() then
		local targetCity = GetPlayerHolyCity(player)
		if targetCity then
			local cityX = targetCity:GetX()
			local cityY = targetCity:GetY()
			for i,v in ipairs(arg) do
				-- Deus Vult Army
				if v == beliefDeusVultID then
					local inquisitorUnitToSpawn = GetUniqueUnit(player, unitClassInquisitorID)
					player:InitUnit(GameInfoTypes[inquisitorUnitToSpawn], cityX, cityY, UNITAI_INQUISITOR)
					player:InitUnit(GameInfoTypes[inquisitorUnitToSpawn], cityX, cityY, UNITAI_INQUISITOR)
					local strongestMountedUnitID = GetStrongestMilitaryUnit(player, true, "UNITCOMBAT_MOUNTED", "UNITCOMBAT_MOUNTED_RANGED", "UNITCOMBAT_ARMOR") or "UNIT_HORSEMAN"
					local mountedUnitToSpawn = GetUniqueUnit(player, GameInfo.Units[strongestMountedUnitID].Class)
					player:InitUnit(GameInfoTypes[mountedUnitToSpawn], cityX, cityY, UNITAI_ATTACK):JumpToNearestValidPlot()
					player:InitUnit(GameInfoTypes[mountedUnitToSpawn], cityX, cityY, UNITAI_ATTACK):JumpToNearestValidPlot()
					local strongestMeleeUnitID = GetStrongestMilitaryUnit(player, true, "UNITCOMBAT_MELEE", "UNITCOMBAT_GUN") or "UNIT_WARRIOR"
					local meleeUnitToSpawn = GetUniqueUnit(player, GameInfo.Units[strongestMeleeUnitID].Class)
					player:InitUnit(GameInfoTypes[meleeUnitToSpawn], cityX, cityY, UNITAI_ATTACK):JumpToNearestValidPlot()
					player:InitUnit(GameInfoTypes[meleeUnitToSpawn], cityX, cityY, UNITAI_ATTACK):JumpToNearestValidPlot()
					local strongestSiegeUnitID = GetStrongestMilitaryUnit(player, true, "UNITCOMBAT_SIEGE") or "UNIT_CATAPULT"
					local siegeUnitToSpawn = GetUniqueUnit(player, GameInfo.Units[strongestSiegeUnitID].Class)
					player:InitUnit(GameInfoTypes[siegeUnitToSpawn], cityX, cityY, UNITAI_CITY_BOMBARD):JumpToNearestValidPlot()
					player:InitUnit(GameInfoTypes[siegeUnitToSpawn], cityX, cityY, UNITAI_CITY_BOMBARD):JumpToNearestValidPlot()
				-- City of God Holy City Pressure
				elseif v == beliefCityOfGodID then
					targetCity:SetNumRealBuilding(buildingCityOfGodID, 1)
				-- Underground Sect Spy
				elseif v == beliefUndergroundSectID then
					targetCity:SetNumRealBuilding(buildingUndergroundSectID, 1)
				end
			end
		end
		BuildingCheck(player)
	end
end

GameEvents.ReligionEnhanced.Add(ReligionEnhancedTrigger)

-- ReligionReformedTrigger
function ReligionReformedTrigger(playerID, religionID, beliefID)
	local player = Players[playerID]
	if player:IsEverAlive() then
		BuildingCheck(player)
		local targetCity = GetPlayerHolyCity(player)
		if targetCity then
			--Divine Celebration Golden Age
			if beliefID == beliefDivineCelebrationID then
				targetCity:SetNumRealBuilding(buildingGoldenAgeID, (targetCity:GetNumBuilding(buildingGoldenAgeID) + 1))
			--Reliquaries Artifact
			elseif beliefID == beliefHolyRelicsID then
				local prophetUnitToSpawn = GetUniqueUnit(player, unitClassProphetID)
				player:InitUnit(GameInfoTypes[prophetUnitToSpawn], targetCity:GetX(), targetCity:GetY()):PushMission(missionCreateGreatWorkID)
			end
		end
	end
end

GameEvents.ReligionReformed.Add(ReligionReformedTrigger)
------------------------------------------------------------------------------------------------------------------------
-- RELIGION OTHER TRIGGERS
------------------------------------------------------------------------------------------------------------------------
-- PietyTurnTrigger
function PietyTurnTrigger(playerID)
	local player = Players[playerID]
	if player:IsEverAlive() then
		BuildingCheck(player)
	end
end

GameEvents.PlayerDoTurn.Add(PietyTurnTrigger)

-- PietyCityFoundedTrigger
function PietyCityFoundedTrigger(playerID, cityX, cityY)
	local player = Players[playerID]
	local plot = Map.GetPlot(cityX, cityY)
	local city = plot:GetPlotCity()
	local religionID = player:GetReligionCreatedByPlayer()
	if player:IsEverAlive() then
		-- Religious Migration Population
		if PlayerHasBelief(player, beliefReligiousMigrationID) then
			local popChange = GetNumForeignFollowers(player)
			if popChange > 0 then
				city:ChangePopulation(math.min(popChange,10), true)
				Network.SendUpdateCityCitizens(city:GetID())
			end
		-- Religious Settlements New City Religion
		elseif PlayerHasBelief(player, beliefReligiousSettlementsID) then
			for religion in GameInfo.Religions("ID <> '" .. religionID .. "'") do
				city:ConvertPercentFollowers(religionID, religion.ID, 100)
			end
			city:AdoptReligionFully(religionID)
			city:ConvertPercentFollowers(religionID, -1, 100)
		end
	end
end

GameEvents.PlayerCityFounded.Add(PietyCityFoundedTrigger)

-- PietyUnitCreatedTrigger
function PietyUnitCreatedTrigger(playerID, unitID)
    local player = Players[playerID]
    if player:IsEverAlive() then
		local unit = player:GetUnitByID(unitID)
		if unit then
			-- Sacred Waters Promotion
			if load(unit, "SacredWaters") == nil and not unit:IsHasPromotion(promotionSacredWatersID) and unit:GetCombatLimit() > 0 and unit:GetDomainType() == DomainTypes.DOMAIN_LAND then
				local city = Map.GetPlot(unit:GetX(), unit:GetY()):GetPlotCity()
				if city and city:Plot():IsRiver() and CityHasBelief(city, beliefSacredWatersID) then
					unit:SetHasPromotion(promotionSacredWatersID, true)
				end
			end
			save(unit, "SacredWaters", true)
			-- Pilgrimage Missionary Unwelcome Evangelists
			if unit:GetUnitClassType() == unitClassMissionaryID and PlayerHasBelief(player, beliefPilgrimageID) and unit:IsHasPromotion(promotionPilgrimageID) then
				unit:SetHasPromotion(promotionPilgrimageID, false)
			end
		end
    end
end

Events.SerialEventUnitCreated.Add(PietyUnitCreatedTrigger)

-- PietyUniversalTrigger
function PietyUniversalTrigger()
    if activePlayer:IsTurnActive() then
        BuildingCheck(activePlayer)
    end
end

Events.SerialEventGameDataDirty.Add(PietyUniversalTrigger)
------------------------------------------------------------------------------------------------------------------------
-- GREAT PROPHETS
------------------------------------------------------------------------------------------------------------------------
-- PietyGreatProphetCanHaveGreatWork
function PietyGreatProphetCanHaveGreatWork(playerID, unitID, greatWorkID)
	local player = Players[playerID]
	local unit = player:GetUnitByID(unitID)
	if unit and unit:GetUnitClassType() == unitClassProphetID then
		return PlayerHasBelief(player, beliefHolyRelicsID)
	end
	return true
end

GameEvents.UnitCanHaveGreatWork.Add(PietyGreatProphetCanHaveGreatWork)
--------------------------------------------------------------------------------------------------------------------------
-- PROPHET MISSIONS
--------------------------------------------------------------------------------------------------------------------------
-- PietyMissionPossible
local missionGoldenAgeID = GameInfo.Missions["MISSION_PROPHET_GOLDEN_AGE"].ID

function PietyMissionPossible(playerID, unitID, missionID, data1, data2, _, _, plotX, plotY, bTestVisible)
	local player = Players[playerID]
	if missionID == missionGoldenAgeID then
		if player:IsEverAlive() then
			local unit = player:GetUnitByID(unitID)
			if unit and unit:GetUnitClassType() == unitClassProphetID then
				if PlayerHasBelief(player, beliefDivineCelebrationID) then
					return unit:GetSpreadsLeft() >= 4
				end
			end
		end
	end
	return false
end

GameEvents.CustomMissionPossible.Add(PietyMissionPossible)

-- PietyMissionStart
local CUSTOM_MISSION_NO_ACTION = 0
local CUSTOM_MISSION_ACTION = 1
local CUSTOM_MISSION_DONE = 2
local CUSTOM_MISSION_ACTION_AND_DONE = 3
function PietyMissionStart(playerID, unitID, missionID, data1, data2, flags, turn)
	local player = Players[playerID]
	if missionID == missionGoldenAgeID then
		if player:IsEverAlive() then
			local capital = player:GetCapitalCity()
			if capital then
				capital:SetNumRealBuilding(buildingGoldenAgeID, (capital:GetNumBuilding(buildingGoldenAgeID) + 1))
				return CUSTOM_MISSION_ACTION
			end
		end
	end
	return CUSTOM_MISSION_NO_ACTION
end

GameEvents.CustomMissionStart.Add(PietyMissionStart)

-- PietyMissionCompleted
function PietyMissionCompleted(playerID, unitID, missionID, data1, data2, flags, turn)
	local player = Players[playerID]
	if missionID == missionGoldenAgeID then
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

GameEvents.CustomMissionCompleted.Add(PietyMissionCompleted)
------------------------------------------------------------------------------------------------------------------------
-- POLICIES
------------------------------------------------------------------------------------------------------------------------
local buildingMonasteryID = GameInfo.Buildings["BUILDING_MONASTERY"].ID
local policyMonasticismID = GameInfo.Policies["POLICY_FREE_RELIGION"].ID

-- PurchaseMonasteriesPiety
function PurchaseMonasteriesPiety(playerID, cityID, buildingTypeID)
	local player = Players[playerID]
	if buildingTypeID == buildingMonasteryID then
		return player:HasPolicy(policyMonasticismID)
	end
	return true
end

GameEvents.CityCanConstruct.Add(PurchaseMonasteriesPiety)
------------------------------------------------------------------------------------------------------------------------
-- MISSIONS
------------------------------------------------------------------------------------------------------------------------
local improvementMissionID = GameInfo.Improvements["IMPROVEMENT_MISSION"].ID
directions = {DirectionTypes.DIRECTION_NORTHEAST, DirectionTypes.DIRECTION_EAST, DirectionTypes.DIRECTION_SOUTHEAST,
              DirectionTypes.DIRECTION_SOUTHWEST, DirectionTypes.DIRECTION_WEST, DirectionTypes.DIRECTION_NORTHWEST}

-- CanBuildMissions
function CanBuildMissions(playerID, unitID, plotX, plotY, buildID)
	local player = Players[playerID]
	if player:IsEverAlive() then
		if buildID == GameInfoTypes["BUILD_MISSION"] then
			for loop, direction in ipairs(directions) do
				local adjacentPlot = Map.PlotDirection(plotX, plotY, direction)
				if adjacentPlot:GetImprovementType() == improvementMissionID then
					return false
				end
			end
		end
	end
	return true
end

GameEvents.PlayerCanBuild.Add(CanBuildMissions)
--=======================================================================================================================
--=======================================================================================================================