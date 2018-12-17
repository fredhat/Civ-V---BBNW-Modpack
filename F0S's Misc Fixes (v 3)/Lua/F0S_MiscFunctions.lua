-- F0S_MiscFunctions
-- Author: F0S
--==========================================================================================================================
-- UTILITY FUNCTIONS
--==========================================================================================================================
WARN_NOT_SHARED = false; include( "Sukritact_SaveUtils.lua" ); MY_MOD_NAME = "F0S_MiscFunctions";
--==========================================================================================================================
-- JFD_IsCivilisationActive
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
--------------------------------------------------------------
-- GetCivSpecificUnit
--------------------------------------------------------------
function GetCivSpecificUnit(player, unitClass)
	local unitType = nil
	local civType = GameInfo.Civilizations[player:GetCivilizationType()].Type
	for override in GameInfo.Civilization_UnitClassOverrides{CivilizationType = civType, UnitClassType = unitClass} do
		unitType = override.UnitType
		break
	end
	if unitType == nil then
		unitType = GameInfo.UnitClasses[unitClass].DefaultUnit
	end
	return unitType
end
--=======================================================================================================================
-- CORE MISC FUNCTIONS	
--=======================================================================================================================
-- F0S_InitShaka
--------------------------------------------------------------
local civilisationZuluID = GameInfoTypes["CIVILIZATION_ZULU"]
local policyBranchHonorID = GameInfoTypes["POLICY_BRANCH_HONOR"]
local policyHonorID = GameInfoTypes["POLICY_HONOR"]
local tableEraUnits = {}
tableEraUnits.ERA_ANCIENT = "UNITCLASS_WARRIOR"
tableEraUnits.ERA_CLASSICAL = "UNITCLASS_SPEARMAN"
tableEraUnits.ERA_MEDIEVAL = "UNITCLASS_PIKEMAN"
tableEraUnits.ERA_RENAISSANCE = "UNITCLASS_MUSKETMAN"
tableEraUnits.ERA_INDUSTRIAL = "UNITCLASS_RIFLEMAN"
tableEraUnits.ERA_MODERN = "UNITCLASS_GREAT_WAR_INFANTRY"
tableEraUnits.ERA_POSTMODERN = "UNITCLASS_INFANTRY"
tableEraUnits.ERA_FUTURE = "UNITCLASS_MECHANIZED_INFANTRY"

function F0S_InitShaka()
	for playerID, player in pairs(Players) do
		local player = Players[playerID]
		if player:IsEverAlive() and player:GetCivilizationType() == civilisationZuluID then
			if not player:IsPolicyBranchUnlocked(policyBranchHonorID) then
				player:SetNumFreePolicies(player:GetNumFreePolicies() + 1)
				player:SetNumFreePolicies(player:GetNumFreePolicies() - 1)
				player:SetPolicyBranchUnlocked(policyBranchHonorID, 1)
				player:SetHasPolicy(policyHonorID, 1)
				local plot = player:GetStartingPlot()
				if plot then
					local unitClass = tableEraUnits[GameInfo.Eras[player:GetCurrentEra()].Type]
					local unitType = GetCivSpecificUnit(player, unitClass)
					local unitAIType = GameInfo.Units[unitType].DefaultUnitAI
					local unit = player:InitUnit(GameInfoTypes[unitType], plot:GetX(), plot:GetY(), GameInfoTypes[unitAIType])
					unit:JumpToNearestValidPlot()
				end
			end
		end
	end 
end

if JFD_IsCivilisationActive(civilisationZuluID) then
	Events.SequenceGameInitComplete.Add(F0S_InitShaka)
end
--------------------------------------------------------------
-- F0S_CelticFaithFromForests
--------------------------------------------------------------
local civilisationCeltsID = GameInfoTypes["CIVILIZATION_CELTS"]
local buildingCelticFaithID = GameInfoTypes["BUILDING_F0S_CELT_FAITH"]
local directions = {DirectionTypes.DIRECTION_NORTHEAST, DirectionTypes.DIRECTION_EAST, DirectionTypes.DIRECTION_SOUTHEAST,
					DirectionTypes.DIRECTION_SOUTHWEST, DirectionTypes.DIRECTION_WEST, DirectionTypes.DIRECTION_NORTHWEST}

function F0S_GetNumAdjacentForest(playerID, city)
	local numAdjacentForests = 0
	local cityX = city:GetX()
	local cityY = city:GetY()
	for loop, direction in ipairs(directions) do
		local adjacentPlot = Map.PlotDirection(cityX, cityY, direction)
		if adjacentPlot and adjacentPlot:GetOwner() == playerID and adjacentPlot:GetFeatureType() == FeatureTypes.FEATURE_FOREST then
			numAdjacentForests = numAdjacentForests + 1
		end
	end
    return numAdjacentForests     
end

function F0S_CelticFaithFromForestsTurn(playerID)
	local player = Players[playerID]
	if player:IsEverAlive() and player:GetCivilizationType() == civilisationCeltsID then
		for city in player:Cities() do
			if city then
				local numCityForests = math.ceil(F0S_GetNumAdjacentForest(playerID, city) / 2)
				if city:GetNumBuilding(buildingCelticFaithID) ~= numCityForests then
					city:SetNumRealBuilding(buildingCelticFaithID, numCityForests)
				end
			end
		end
	end
end

function F0S_CelticFaithFromForestsFounded(playerID, cityX, cityY)
	local player = Players[playerID]
	if player:IsEverAlive() and player:GetCivilizationType() == civilisationCeltsID then
		local plot = Map.GetPlot(cityX, cityY)
		if plot then
			local city = plot:GetPlotCity()
			if city then
				local numCityForests = math.ceil(F0S_GetNumAdjacentForest(playerID, city) / 2)
				if city:GetNumBuilding(buildingCelticFaithID) ~= numCityForests then
					city:SetNumRealBuilding(buildingCelticFaithID, numCityForests)
				end
			end
		end
	end
end

function F0S_CelticFaithFromForestsDirty()
	local playerID = Game.GetActivePlayer()
	local player = Players[playerID]
	if player:IsTurnActive() then
		F0S_CelticFaithFromForestsTurn(playerID)
	end
end
--------------------------------------------------------------
-- F0S_CelticStrengthFromFaith
--------------------------------------------------------------
local promotionStrengthFaithID = GameInfoTypes["PROMOTION_STRENGTH_FROM_FAITH"]
local promotionStrengthFaithInfoID = GameInfoTypes["PROMOTION_STRENGTH_FROM_FAITH_INFO"]

function F0S_IsInReligiousCityTerritory(player, unit)
	local capital = player:GetCapitalCity()
	if capital then
		local religionID = player:GetReligionCreatedByPlayer()
		if religionID <= 0 then religionID = capital:GetReligiousMajority() end
		if religionID > 0 then
			local plot = Map.GetPlot(unit:GetX(), unit:GetY())
			if plot then
				local plotOwner = Players[plot:GetOwner()]
				if plotOwner then
					for city in plotOwner:Cities() do
						for i = 0, city:GetNumCityPlots() - 1, 1 do
							local cityPlot = city:GetCityIndexPlot(i)
							if cityPlot and cityPlot == plot then
								if city:GetReligiousMajority() == religionID then
									return true
								end
							end
						end
					end
				end
			end
		end
	end
	return false
end

function F0S_CelticStrengthFromFaithTurn(playerID)
	local player = Players[playerID]
	if player:IsEverAlive() and player:GetCivilizationType() == civilisationCeltsID then
		for unit in player:Units() do
			if unit and unit:IsHasPromotion(promotionStrengthFaithID) or unit:IsHasPromotion(promotionStrengthFaithInfoID) then
				if F0S_IsInReligiousCityTerritory(player, unit) then
					if unit:IsHasPromotion(promotionStrengthFaithInfoID) then
						unit:SetHasPromotion(promotionStrengthFaithID, true)
						unit:SetHasPromotion(promotionStrengthFaithInfoID, false)
					end
				else
					if unit:IsHasPromotion(promotionStrengthFaithID) then
						unit:SetHasPromotion(promotionStrengthFaithID, false)
						unit:SetHasPromotion(promotionStrengthFaithInfoID, true)
					end
				end
			end
		end
	end
end

function F0S_CelticStrengthFromFaithTurnDirty()
	local playerID = Game.GetActivePlayer()
	local player = Players[playerID]
	if player:IsTurnActive() then
		F0S_CelticStrengthFromFaithTurn(playerID)
	end
end

if JFD_IsCivilisationActive(civilisationCeltsID) then
	GameEvents.PlayerDoTurn.Add(F0S_CelticFaithFromForestsTurn)
	GameEvents.PlayerCityFounded.Add(F0S_CelticFaithFromForestsFounded)
	Events.SerialEventGameDataDirty.Add(F0S_CelticFaithFromForestsDirty)
	GameEvents.PlayerDoTurn.Add(F0S_CelticStrengthFromFaithTurn)
	Events.SerialEventGameDataDirty.Add(F0S_CelticStrengthFromFaithTurnDirty)
end
--------------------------------------------------------------
-- F0S_MongolianGold
--------------------------------------------------------------
local civilisationMongolsID = GameInfoTypes["CIVILIZATION_MONGOL"]
local buildingMongolianGoldID = GameInfoTypes["BUILDING_F0S_MONGOLIAN_GOLD"]

function F0S_MongolianGoldCheck(player)
	for city in player:Cities() do
		if city then
			if city:IsCapital() then
				if not city:IsHasBuilding(buildingMongolianGoldID) then
					city:SetNumRealBuilding(buildingMongolianGoldID, 1)
				end
			else
				if city:IsHasBuilding(buildingMongolianGoldID) then
					city:SetNumRealBuilding(buildingMongolianGoldID, 0)
				end
			end
		end
	end
end

function F0S_MongolianGoldTurn(playerID)
	local player = Players[playerID]
	if player:IsEverAlive() and player:GetCivilizationType() == civilisationMongolsID then
		F0S_MongolianGoldCheck(player)
	end
end

function F0S_MongolianGoldCapture(oldOwnerID, capital, plotX, plotY, newOwnerID)
	local player = Players[newOwnerID]
	local otherPlayer = Players[oldOwnerID]
	if player:IsEverAlive() and player:GetCivilizationType() == civilisationMongolsID then
		F0S_MongolianGoldCheck(player)
	elseif otherPlayer:IsEverAlive() and otherPlayer:GetCivilizationType() == civilisationMongolsID then
		F0S_MongolianGoldCheck(otherPlayer)
	end
end

function F0S_MongolianGoldFounded(playerID, cityX, cityY)
	local player = Players[playerID]
	if player:IsEverAlive() and player:GetCivilizationType() == civilisationMongolsID then
		local plot = Map.GetPlot(cityX, cityY)
		if plot then
			local city = plot:GetPlotCity()
			if city and city:IsCapital() then
				if not city:IsHasBuilding(buildingMongolianGoldID) then
					city:SetNumRealBuilding(buildingMongolianGoldID, 1)
				end
			end
		end
	end
end

if JFD_IsCivilisationActive(civilisationMongolsID) then
	GameEvents.PlayerDoTurn.Add(F0S_MongolianGoldTurn)
	GameEvents.CityCaptureComplete.Add(F0S_MongolianGoldCapture)
	GameEvents.PlayerCityFounded.Add(F0S_MongolianGoldFounded)
end
--------------------------------------------------------------
-- F0S_InitVenice
--------------------------------------------------------------
local civilisationVeniceID = GameInfoTypes["CIVILIZATION_VENICE"]
local policyVeniceID = GameInfoTypes["POLICY_F0S_VENICE"]

function F0S_InitVenice(player)
	for playerID, player in pairs(Players) do
		local player = Players[playerID]
		if player:IsEverAlive() and player:GetCivilizationType() == civilisationVeniceID then
			if not player:HasPolicy(policyVeniceID) then
				player:SetNumFreePolicies(player:GetNumFreePolicies() + 1)
				player:SetNumFreePolicies(player:GetNumFreePolicies() - 1)
				player:SetHasPolicy(policyVeniceID, true)	
			end
		end
	end 
end

if JFD_IsCivilisationActive(civilisationVeniceID) then
	Events.SequenceGameInitComplete.Add(F0S_InitVenice)
end
--------------------------------------------------------------
-- F0S_InitGreece
--------------------------------------------------------------
local civilisationGreeceID = GameInfoTypes["CIVILIZATION_GREECE"]
local policyGreeceID = GameInfoTypes["POLICY_F0S_GREECE"]

function F0S_InitGreece(player)
	for playerID, player in pairs(Players) do
		local player = Players[playerID]
		if player:IsEverAlive() and player:GetCivilizationType() == civilisationGreeceID then
			if not player:HasPolicy(policyGreeceID) then
				player:SetNumFreePolicies(player:GetNumFreePolicies() + 1)
				player:SetNumFreePolicies(player:GetNumFreePolicies() - 1)
				player:SetHasPolicy(policyGreeceID, true)	
			end
		end
	end 
end
--------------------------------------------------------------
-- F0S_GreekAgora
--------------------------------------------------------------
local buildingAgoraID = GameInfoTypes["BUILDING_F0S_AGORA"]
local buildingAgoraBonusFoodID = GameInfoTypes["BUILDING_F0S_AGORA_BONUS_FOOD"]
local buildingAgoraBonusHappyID = GameInfoTypes["BUILDING_F0S_AGORA_BONUS_HAPPY"]
local buildingAgoraBonusCultureID = GameInfoTypes["BUILDING_F0S_AGORA_BONUS_CULTURE"]
local buildingAgoraBonusFaithID = GameInfoTypes["BUILDING_F0S_AGORA_BONUS_FAITH"]
local buildingAgoraBonusXPID = GameInfoTypes["BUILDING_F0S_AGORA_BONUS_XP"]

function F0S_GreekAgoraTurn(playerID)
	local player = Players[playerID]
	if player:IsEverAlive() and player:GetCivilizationType() == civilisationGreeceID then
		local aHap = 0
		local aFood = 0
		local aFaith = 0
		local aCult = 0
		local aXp = 0
		for minorPlayerID = 0, GameDefines.MAX_CIV_PLAYERS - 1 do
			local minorCiv = Players[minorPlayerID]
			if minorCiv:IsEverAlive() and minorCiv:IsMinorCiv() and minorCiv:GetCapitalCity() then
				if minorCiv:GetMinorCivFriendshipLevelWithMajor(playerID) == 1 then
					local minorCivTrait = GameInfo.MinorCivilizations[minorCiv:GetMinorCivType()].MinorCivTrait
					if minorCivTrait == "MINOR_TRAIT_CULTURED" then
						aCult = aCult + 1
					elseif minorCivTrait == "MINOR_TRAIT_MILITARISTIC" then
						aXp = aXp + 1
					elseif minorCivTrait == "MINOR_TRAIT_MARITIME" then
						aFood = aFood + 1
					elseif minorCivTrait == "MINOR_TRAIT_MERCANTILE" then
						aHap = aHap + 1
					elseif minorCivTrait == "MINOR_TRAIT_RELIGIOUS" then
						aFaith = aFaith + 1
					end
				elseif minorCiv:GetMinorCivFriendshipLevelWithMajor(playerID) == 2 then
					local minorCivTrait = GameInfo.MinorCivilizations[minorCiv:GetMinorCivType()].MinorCivTrait
					if minorCivTrait == "MINOR_TRAIT_CULTURED" then
						aCult = aCult + 2
					elseif minorCivTrait == "MINOR_TRAIT_MILITARISTIC" then
						aXp = aXp + 2
					elseif minorCivTrait == "MINOR_TRAIT_MARITIME" then
						aFood = aFood + 2
					elseif minorCivTrait == "MINOR_TRAIT_MERCANTILE" then
						aHap = aHap + 2
					elseif minorCivTrait == "MINOR_TRAIT_RELIGIOUS" then
						aFaith = aFaith + 2
					end
				end
			end
		end
		for city in player:Cities() do
			if city then
				if city:IsHasBuilding(buildingAgoraID) then
					city:SetNumRealBuilding(buildingAgoraBonusFoodID, aFood)
					city:SetNumRealBuilding(buildingAgoraBonusHappyID, aHap)
					city:SetNumRealBuilding(buildingAgoraBonusCultureID, aCult)
					city:SetNumRealBuilding(buildingAgoraBonusFaithID, aFaith)
					city:SetNumRealBuilding(buildingAgoraBonusXPID, aXp)
				else
					city:SetNumRealBuilding(buildingAgoraBonusFoodID, 0)
					city:SetNumRealBuilding(buildingAgoraBonusHappyID, 0)
					city:SetNumRealBuilding(buildingAgoraBonusCultureID, 0)
					city:SetNumRealBuilding(buildingAgoraBonusFaithID, 0)
					city:SetNumRealBuilding(buildingAgoraBonusXPID, 0)
				end
			end
		end
	end
end

function F0S_GreekAgoraDirty()
	local playerID = Game.GetActivePlayer()
    local player = Players[playerID]
	if player:IsTurnActive() then
        F0S_GreekAgoraTurn(playerID)
    end
end

function F0S_GreekAgoraInitialTrigger(playerID, cityID, buildingID)
	local player = Players[playerID]
	local city = player:GetCityByID(cityID)
	if city and city:IsHasBuilding(buildingAgoraID) then
		if load("GAME", "F0S_GreekAgoraInitalised") == nil then
			GameEvents.PlayerDoTurn.Add(F0S_GreekAgoraTurn)
			Events.SerialEventGameDataDirty.Add(F0S_GreekAgoraDirty)
			save("GAME", "F0S_GreekAgoraInitalised", true)
			F0S_GreekAgoraTurn(playerID)
		end
	end
end

if JFD_IsCivilisationActive(civilisationGreeceID) then
	Events.SequenceGameInitComplete.Add(F0S_InitGreece)
	if load("GAME", "F0S_GreekAgoraInitalised") then
		GameEvents.PlayerDoTurn.Add(F0S_GreekAgoraTurn)
		Events.SerialEventGameDataDirty.Add(F0S_GreekAgoraDirty)
	else
		GameEvents.CityConstructed.Add(F0S_GreekAgoraInitialTrigger)
	end
end
--------------------------------------------------------------
-- F0S_ArtemisFood
--------------------------------------------------------------
local buildingArtemisID = GameInfoTypes["BUILDING_TEMPLE_ARTEMIS"]
local buildingClassArtemisID = GameInfoTypes["BUILDINGCLASS_TEMPLE_ARTEMIS"]
local buildingArtemisFoodBonusID = GameInfoTypes["BUILDING_F0S_ARTEMIS_FOOD_BONUS"]

function F0S_ArtemisFoodCheck(player)
	local hasArtemis = player:GetBuildingClassCount(buildingClassArtemisID) or 0
	if hasArtemis then
		for city in player:Cities() do
			if not city:IsHasBuilding(buildingArtemisFoodBonusID) then
				city:SetNumRealBuilding(buildingArtemisFoodBonusID, 1)
			end
		end
	else
		for city in player:Cities() do
			if city:IsHasBuilding(buildingArtemisFoodBonusID) then
				city:SetNumRealBuilding(buildingArtemisFoodBonusID, 0)
			end
		end
	end
end

function F0S_ArtemisFoodTurn(playerID)
	local player = Players[playerID]
	if player:IsEverAlive() then
		F0S_ArtemisFoodCheck(player)
	end
end

function F0S_ArtemisFoodCapture(oldOwnerID, capital, plotX, plotY, newOwnerID)
	local player = Players[newOwnerID]
	local otherPlayer = Players[oldOwnerID]
	if player:IsEverAlive() then
		F0S_ArtemisFoodCheck(player)
	end
	if otherPlayer:IsEverAlive() then
		F0S_ArtemisFoodCheck(otherPlayer)
	end
end

function F0S_ArtemisFoodFounded(playerID, cityX, cityY)
	local player = Players[playerID]
	if player:IsEverAlive() then
		local plot = Map.GetPlot(cityX, cityY)
		if plot then
			local city = plot:GetPlotCity()
			if city then
				local hasArtemis = player:GetBuildingClassCount(buildingClassArtemisID) or 0
				if hasArtemis then
					if not city:IsHasBuilding(buildingArtemisFoodBonusID) then
						city:SetNumRealBuilding(buildingArtemisFoodBonusID, 1)
					end
				end
			end
		end
	end
end

function F0S_ArtemisFoodConstructed(playerID, cityID, buildingID)
    local player = Players[playerID]
	local city = player:GetCityByID(cityID)
    if city and city:IsHasBuilding(buildingArtemisID) then
        for otherCity in player:Cities() do
			if otherCity and not otherCity:IsHasBuilding(buildingArtemisFoodBonusID) then
				otherCity:SetNumRealBuilding(buildingArtemisFoodBonusID, 1)
			end
		end
    end
end

GameEvents.PlayerDoTurn.Add(F0S_ArtemisFoodTurn)
GameEvents.CityCaptureComplete.Add(F0S_ArtemisFoodCapture)
GameEvents.PlayerCityFounded.Add(F0S_ArtemisFoodFounded)
GameEvents.CityConstructed.Add(F0S_ArtemisFoodConstructed)
--------------------------------------------------------------
-- F0S_CannonBattery
--------------------------------------------------------------
local promotionBatteryID = GameInfoTypes["PROMOTION_BATTERY"]
local promotionBatteryInfoID = GameInfoTypes["PROMOTION_BATTERY_INFO"]
local improvementFortID = GameInfoTypes["IMPROVEMENT_FORT"]
local improvementCitadelID = GameInfoTypes["IMPROVEMENT_CITADEL"]
local improvementSwedishFortID = GameInfoTypes["IMPROVEMENT_JFD_SWEDISH_FORT"]
local improvementSwedishCitadelID = GameInfoTypes["IMPROVEMENT_JFD_SWEDISH_CITADEL"]

function F0S_CannonBattery(playerID, unit, unitX, unitY)
	local plot = Map.GetPlot(unitX, unitY)
	if plot then
		if unit:IsHasPromotion(promotionBatteryID) or unit:IsHasPromotion(promotionBatteryInfoID) then
			local isFortified = false
			if plot:GetOwner() == playerID or plot:GetOwner() == -1 then
				if plot:IsCity() or ((plot:GetImprovementType() == improvementFortID or plot:GetImprovementType() == improvementCitadelID or plot:GetImprovementType() == improvementSwedishFortID or plot:GetImprovementType() == improvementSwedishCitadelID) and not plot:IsImprovementPillaged()) then
					isFortified = true
				end
			end
			if isFortified then
				if unit:IsHasPromotion(promotionBatteryInfoID) then
					unit:SetHasPromotion(promotionBatteryID, true)
					unit:SetHasPromotion(promotionBatteryInfoID, false)
				end
			else
				if unit:IsHasPromotion(promotionBatteryID) then
					unit:SetHasPromotion(promotionBatteryID, false)
					unit:SetHasPromotion(promotionBatteryInfoID, true)
				end
			end
		end
	end
end

function F0S_CannonBatteryOther(playerID)
	local player = Players[playerID]
	if player:IsEverAlive() then
		for unit in player:Units() do
			if unit then
				F0S_CannonBattery(playerID, unit, unit:GetX(), unit:GetY())
			end
		end
	end
end

function F0S_CannonBatteryXY(playerID, unitID, unitX, unitY)
	local player = Players[playerID]
	if player:IsEverAlive() then
		local unit = player:GetUnitByID(unitID)
		if unit then
			F0S_CannonBattery(playerID, unit, unitX, unitY)
		end
	end
end

function F0S_CannonBatteryInitialTrigger(playerID, unitID)
	local player = Players[playerID]
	local unit = player:GetUnitByID(unitID)
	if unit and unit:IsHasPromotion(promotionBatteryInfoID) then
		GameEvents.PlayerDoTurn.Add(F0S_CannonBatteryOther)
		GameEvents.UnitSetXY.Add(F0S_CannonBatteryXY)
		GameEvents.BuildFinished.Add(F0S_CannonBatteryOther)
		Events.SerialEventUnitCreated.Add(F0S_CannonBatteryXY)
		Events.SerialEventUnitCreated.Remove(F0S_CannonBatteryInitialTrigger)
		save("GAME", "F0S_CannonBatteryInitalised", true)
		F0S_CannonBatteryXY(playerID, unitID, unit:GetX(), unit:GetY())
	end
end

if load("GAME", "F0S_CannonBatteryInitalised") then
	GameEvents.PlayerDoTurn.Add(F0S_CannonBatteryOther)
	GameEvents.UnitSetXY.Add(F0S_CannonBatteryXY)
	GameEvents.BuildFinished.Add(F0S_CannonBatteryOther)
	Events.SerialEventUnitCreated.Add(F0S_CannonBatteryXY)
else
	Events.SerialEventUnitCreated.Add(F0S_CannonBatteryInitialTrigger)
end
--==========================================================================================================================
--==========================================================================================================================