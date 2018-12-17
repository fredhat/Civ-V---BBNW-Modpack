-- tcmJoaoII
-- Author: TarcisioCM
-- Heavily Edited By: F0S
--=======================================================================================================================
-- INCLUDES
--=======================================================================================================================
WARN_NOT_SHARED = false; include( "SaveUtils" ); MY_MOD_NAME = "tcmJoaoII";
include("PlotIterators")
include("InfoTooltipInclude")
include("FLuaVector")
--=======================================================================================================================
-- UTILITIES
--=======================================================================================================================
local civilisationPortugalID = GameInfoTypes["CIVILIZATION_TCM_AVIS_PORTUGAL"]
local civilisationPortugalBrazilID = GameInfoTypes["CIVILIZATION_PORTUGAL"]
------------------------------------------------------------------------------------------------------------------------
-- JFD_IsCivilisationActive
------------------------------------------------------------------------------------------------------------------------
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
------------------------------------------------------------------------------------------------------------------------
-- JFD_GetRandom
------------------------------------------------------------------------------------------------------------------------
function JFD_GetRandom(lower, upper)
    return Game.Rand((upper + 1) - lower, "") + lower
end
--==========================================================================================================================
-- CORE PORTUGAL FUNCTIONS
--==========================================================================================================================
-- Turns Experience from naval units into Gold
--==========================================================================================================================
function portugalExperienceToGold(playerID)
	local player = Players[playerID]
	if player:IsEverAlive() and player:GetCivilizationType() == civilisationPortugalID then
		for city in player:Cities() do
			if city then
				local totalGoldAwarded = 0
				local plot = Map.GetPlot(city:GetX(), city:GetY())
				if plot then
					for i = 0, plot:GetNumUnits() - 1 do
						local unit = plot:GetUnit(i)
						if unit and unit:GetDomainType() == DomainTypes.DOMAIN_SEA then
							local savedExp = load(unit, "tcmPortugalNavalExperience") or 0
							local currentExp = unit:GetExperience()
							if currentExp > savedExp then
								local expToGold = currentExp - savedExp
								totalGoldAwarded = totalGoldAwarded + expToGold
								player:ChangeGold(expToGold)
								save(unit, "tcmPortugalNavalExperience", currentExp)
							end
						end
					end
				end
				if player:IsHuman() and player:IsTurnActive() and totalGoldAwarded > 0 then
					local hex = ToHexFromGrid(Vector2(city:GetX(), city:GetY()))
					Events.AddPopupTextEvent(HexToWorld(hex), Locale.ConvertTextKey("[COLOR_YELLOW]+{1_Num}[ENDCOLOR][ICON_GOLD]", totalGoldAwarded), 1)
					Events.GameplayFX(hex.x, hex.y, -1)
				end
			end
		end
	end
end

function portugalExperienceClean(unitOwnerId, unitId, unitType, unitX, unitY, bDelay, eKillingPlayer)
	if bDelay then
		local player = Players[unitOwnerId]
		if player:IsEverAlive() and player:GetCivilizationType() == civilisationPortugalID then
			local unit = player:GetUnitByID(unitId)
			if unit and unit:GetDomainType() == DomainTypes.DOMAIN_SEA then
				save(unit, "tcmPortugalNavalExperience", nil)
			end
		end
	end
end

function portugalExperienceUpgrade(playerId, unitId, newUnitId, bGoodyHut)
	local player = Players[playerId]
	if player:IsEverAlive() and player:GetCivilizationType() == civilisationPortugalID then
		local unit = player:GetUnitByID(unitId)
		if unit and unit:GetDomainType() == DomainTypes.DOMAIN_SEA then
			local newUnit = player:GetUnitByID(newUnitId)
			local savedExp = load(unit, "tcmPortugalNavalExperience")
			save(newUnit, "tcmPortugalNavalExperience", savedExp)
			save(unit, "tcmPortugalNavalExperience", nil)
		end
	end
end
--==========================================================================================================================
-- Yields Culture for purchasing buildings
--==========================================================================================================================
function portugalCultureFromPurchases(ownerId, cityId, buildingType, bGold, bFaithOrCulture)
	if bGold then
		local player = Players[ownerId]
		if player:IsEverAlive() and player:GetCivilizationType() == civilisationPortugalID then
			local city = player:GetCityByID(cityId)
			if city then
				local plot = city:Plot()
				if plot then
					local building = GameInfo.Buildings[buildingType].Description
					if load(plot, "tcmPortugalPlotHasBuildingEver" .. building) == nil then
						local cultureReward = math.ceil(GameInfo.Buildings[buildingType].Cost * 0.25)
						player:ChangeJONSCulture(cultureReward)
						if player:IsHuman() and player:IsTurnActive() and cultureReward > 0 then
							local hex = ToHexFromGrid(Vector2(city:GetX(), city:GetY()))
							Events.AddPopupTextEvent(HexToWorld(hex), Locale.ConvertTextKey("[COLOR_CULTURE_STORED]+{1_Num}[ENDCOLOR][ICON_CULTURE]", cultureReward), 1)
							Events.GameplayFX(hex.x, hex.y, -1)
						end
						save(plot, "tcmPortugalPlotHasBuildingEver" .. building, true) 
					end
				end
			end
		end
	end
end
--==========================================================================================================================
-- Nau trade mission possible
--==========================================================================================================================
local missionNauTradeMissionID = GameInfo.Missions["MISSION_TCM_NAU_TRADE_MISSION"].ID
local promotionNauTradeMissionID = GameInfoTypes["PROMOTION_TCM_NAU_TRADE_MISSION"]
local modifier = ((GameInfo.GameSpeeds[Game.GetGameSpeedType()].GoldPercent)/100)
local influenceBase = 30
local goldBase = 150
local goldExtraBase = 50

function nauTradeMissionPossible(playerID, unitID, missionID, data1, data2, _, _, plotX, plotY, bTestVisible)
	local player = Players[playerID]
	if missionID == missionNauTradeMissionID then
		if player:IsEverAlive() then
			local unit = player:GetUnitByID(unitID)
			if unit and unit:IsHasPromotion(promotionNauTradeMissionID) and unit:GetLevel() >= 5 then
				local plot = unit:GetPlot()
				if plot then
					local otherPlayerID = plot:GetOwner()
					if otherPlayerID and otherPlayerID ~= -1 then
						local otherPlayer = Players[otherPlayerID]
						if otherPlayer and otherPlayer:IsEverAlive() and otherPlayer:IsMinorCiv() then
							if not Teams[player:GetTeam()]:IsAtWar(otherPlayer:GetTeam()) then
								return true
							end
						end
					end
				end
			end
		end
	end
	return false
end

GameEvents.CustomMissionPossible.Add(nauTradeMissionPossible)

local CUSTOM_MISSION_NO_ACTION = 0
local CUSTOM_MISSION_ACTION = 1
local CUSTOM_MISSION_DONE = 2
local CUSTOM_MISSION_ACTION_AND_DONE = 3
function nauTradeMissionStart(playerID, unitID, missionID, data1, data2, flags, turn)
	local player = Players[playerID]
	if missionID == missionNauTradeMissionID then
		if player:IsEverAlive() then
			local unit = player:GetUnitByID(unitID)
			if unit then
				local plot = unit:GetPlot()
				if plot then
					local otherPlayerID = plot:GetOwner()
					if otherPlayerID and otherPlayerID ~= -1 then
						local otherPlayer = Players[otherPlayerID]
						if otherPlayer and otherPlayer:IsEverAlive() and otherPlayer:IsMinorCiv() then
							if not Teams[player:GetTeam()]:IsAtWar(otherPlayer:GetTeam()) then
								local influenceGift = math.floor(influenceBase * modifier)
								otherPlayer:ChangeMinorCivFriendshipWithMajor(playerID, influenceGift)
								if player:IsHuman() and player:IsTurnActive() and influenceGift > 0 then
									local hex = ToHexFromGrid(Vector2(unit:GetX(), unit:GetY()))
									Events.AddPopupTextEvent(HexToWorld(hex), Locale.ConvertTextKey("[COLOR_POSITIVE_TEXT]+{1_Num}[ENDCOLOR][ICON_INFLUENCE]", influenceGift), 1)
									Events.GameplayFX(hex.x, hex.y, -1)
								end
								local goldGift = math.floor((goldBase + (goldExtraBase * player:GetCurrentEra())) * modifier)
								player:ChangeGold(goldGift)
								if player:IsHuman() and player:IsTurnActive() and goldGift > 0 then
									local hex = ToHexFromGrid(Vector2(unit:GetX(), unit:GetY()))
									Events.AddPopupTextEvent(HexToWorld(hex), Locale.ConvertTextKey("[COLOR_YELLOW]+{1_Num}[ENDCOLOR][ICON_GOLD]", goldGift), 1)
									Events.GameplayFX(hex.x, hex.y, -1)
								end
								return CUSTOM_MISSION_ACTION
							end
						end
					end
				end
			end
		end
	end
	return CUSTOM_MISSION_NO_ACTION
end

GameEvents.CustomMissionStart.Add(nauTradeMissionStart)

function nauTradeMissionCompleted(playerID, unitID, missionID, data1, data2, flags, turn)
	local player = Players[playerID]
	if missionID == missionNauTradeMissionID then
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

GameEvents.CustomMissionCompleted.Add(nauTradeMissionCompleted)
--==========================================================================================================================
-- Nau heal in city-state territory
--==========================================================================================================================
local promotionCityStateHealInfoID = GameInfoTypes["PROMOTION_TCM_HEAL_ON_CITY_STATE_INFO"]
local promotionCityStateHealID = GameInfoTypes["PROMOTION_TCM_HEAL_ON_CITY_STATE"]

function nauPomotionCheck(unit)
	local plot = unit:GetPlot()
	if plot then
		local otherPlayerID = plot:GetOwner()
		if otherPlayerID and otherPlayerID ~= -1 then
			local otherPlayer = Players[otherPlayerID]
			if otherPlayer and otherPlayer:IsMinorCiv() then
				if unit:IsHasPromotion(promotionCityStateHealInfoID) then
					unit:SetHasPromotion(promotionCityStateHealID, true)
					unit:SetHasPromotion(promotionCityStateHealInfoID, false)
				end
			else
				if unit:IsHasPromotion(promotionCityStateHealID) then
					unit:SetHasPromotion(promotionCityStateHealID, false)
					unit:SetHasPromotion(promotionCityStateHealInfoID, true)
				end
			end
		else
			if unit:IsHasPromotion(promotionCityStateHealID) then
				unit:SetHasPromotion(promotionCityStateHealID, false)
				unit:SetHasPromotion(promotionCityStateHealInfoID, true)
			end
		end
	else
		if unit:IsHasPromotion(promotionCityStateHealID) then
			unit:SetHasPromotion(promotionCityStateHealID, false)
			unit:SetHasPromotion(promotionCityStateHealInfoID, true)
		end
	end
end

function nauHealInCityStateTurn(playerID)
	local player = Players[playerID]
	if player:IsEverAlive() then
		for unit in player:Units() do
			if unit then nauPomotionCheck(unit) end
		end
	end
end

function nauHealInCityStateXY(playerID, unitID, unitX, unitY)
	local player = Players[playerID]
	local unit = player:GetUnitByID(unitID)
	if unit then nauPomotionCheck(unit) end
end

function nauHealInCityStateTrigger(playerID, unitID)
	local player = Players[playerID]
	local unit = player:GetUnitByID(unitID)
	if unit and unit:IsHasPromotion(promotionCityStateHealInfoID) then
		GameEvents.PlayerDoTurn.Add(nauHealInCityStateTurn)
		GameEvents.UnitSetXY.Add(nauHealInCityStateXY)
		Events.SerialEventUnitCreated.Remove(nauHealInCityStateTrigger)
		save("GAME", "nauHealInCityStateInitalised", true)
	end
end
--==========================================================================================================================
--Feitoria garrisoned unit bonus
--==========================================================================================================================
local improvementFeitoriaID = GameInfoTypes["IMPROVEMENT_FEITORIA"]
local promotionEnterCityStateID = GameInfoTypes["PROMOTION_TCM_ENTER_CITY_STATE"]
local buildingFeitoriaGold = GameInfoTypes["BUILDING_TCM_AVIS_PORTUGAL_FEITORIA_GOLD"]
local buildingFeitoriaXP = GameInfoTypes["BUILDING_TCM_AVIS_PORTUGAL_FEITORIA_EXP"]

function garrisonedOnFeitoria(playerID)
	local player = Players[playerID]
	if player:IsEverAlive() and player:GetCivilizationType() == civilisationPortugalID then
		local requiredTech = GameInfo.Builds["BUILD_FEITORIA"].PrereqTech
		local teamTechs = Teams[player:GetTeam()]:GetTeamTechs()
		if teamTechs:HasTech(GameInfoTypes[requiredTech]) then
			local totalGarrisonedUnits = 0
			for unit in player:Units() do
				if unit and unit:GetDomainType() == DomainTypes.DOMAIN_LAND and unit:GetCombatLimit() > 0 then
					local plot = unit:GetPlot()
					if plot and plot:GetImprovementType() == improvementFeitoriaID and not plot:IsImprovementPillaged() then
						totalGarrisonedUnits = totalGarrisonedUnits + 1
						if not unit:IsHasPromotion(promotionEnterCityStateID) then
							unit:SetHasPromotion(promotionEnterCityStateID, true)
						end
					else
						if unit:IsHasPromotion(promotionEnterCityStateID) then
							unit:SetHasPromotion(promotionEnterCityStateID, false)
						end
					end
				end
			end
			local capital = player:GetCapitalCity()
			if capital then
				if capital:GetNumBuilding(buildingFeitoriaGold) ~= totalGarrisonedUnits then
					capital:SetNumRealBuilding(buildingFeitoriaGold, totalGarrisonedUnits)
				end
				if capital:GetNumBuilding(buildingFeitoriaXP) ~= totalGarrisonedUnits then
					capital:SetNumRealBuilding(buildingFeitoriaXP, totalGarrisonedUnits)
				end
			end
		end
	end
end

if JFD_IsCivilisationActive(civilisationPortugalID) then
	GameEvents.PlayerDoTurn.Add(portugalExperienceToGold)
	GameEvents.UnitPrekill.Add(portugalExperienceClean)
	GameEvents.UnitUpgraded.Add(portugalExperienceUpgrade)
	GameEvents.CityConstructed.Add(portugalCultureFromPurchases)
	if load("GAME", "nauHealInCityStateInitalised") then
		GameEvents.PlayerDoTurn.Add(nauHealInCityStateTurn)
		GameEvents.UnitSetXY.Add(nauHealInCityStateXY)
	else
		Events.SerialEventUnitCreated.Add(nauHealInCityStateTrigger)
	end
	GameEvents.PlayerDoTurn.Add(garrisonedOnFeitoria)
	GameEvents.UnitSetXY.Add(garrisonedOnFeitoria)
end
--==========================================================================================================================
-- CORE PORTUGAL-BRAZIL FUNCTIONS
--==========================================================================================================================
--Winery Wine
--==========================================================================================================================
local buildingWineryID = GameInfoTypes["BUILDING_TCM_WINERY"]
local resourceWineID = GameInfoTypes["RESOURCE_WINE"]

function canSellWinery(playerID, buildingID)
	if buildingID == buildingWineryID then
		return
	end
	return true
end

function spawnWine(playerID, cityID, buildingID)
	local player = Players[playerID]
	local numtoPlace = JFD_GetRandom(1,2)
	if player:IsEverAlive() then
		if buildingID == buildingWineryID then
			local city = player:GetCityByID(cityID)
			if city then
				local plot = Map.GetPlot(city:GetX(), city:GetY())
				if plot and load(plot, "tcmHasWineryEver") == nil then
					for pIterPlot in PlotAreaSpiralIterator(plot, 3, JFD_GetRandom(1,6), DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
						if not pIterPlot:IsMountain() and pIterPlot:GetResourceType() == -1 and (pIterPlot:GetFeatureType() == FeatureTypes.NO_FEATURE or pIterPlot:GetFeatureType() == FeatureTypes.FEATURE_MARSH or pIterPlot:GetFeatureType() == FeatureTypes.FEATURE_JUNGLE or pIterPlot:GetFeatureType() == FeatureTypes.FEATURE_FOREST) and not pIterPlot:IsHills() and not pIterPlot:IsWater() and not pIterPlot:IsCity() and (pIterPlot:GetTerrainType() == TerrainTypes.TERRAIN_GRASS or pIterPlot:GetTerrainType() == TerrainTypes.TERRAIN_PLAINS) and (pIterPlot:GetOwner() == -1 or pIterPlot:GetOwner() == playerID) and pIterPlot:GetImprovementType() == -1 then
							pIterPlot:SetResourceType(resourceWineID, 1)
							pIterPlot:SetOwner(-1)
							pIterPlot:SetOwner(playerID, cityID)
							pIterPlot:SetRevealed(player:GetTeam(), true)
							pIterPlot:UpdateFog()
							numtoPlace = numtoPlace - 1
						end
						if numtoPlace < 1 then break end
					end
				end
				save(plot, "tcmHasWineryEver", 1)
			end
		end
	end
end
--==========================================================================================================================
--Portugal-Brazil UA
--==========================================================================================================================
local buildingHappyDummyID = GameInfoTypes["BUILDING_TCM_PORTUGAL_HAPPY_DUMMY"]
local buildingFoodDummyID = GameInfoTypes["BUILDING_TCM_PORTUGAL_FOOD_DUMY"]

function manageContinentHappiness(player)
	local capital = player:GetCapitalCity()
	if capital then
		local capitalPlot = capital:Plot()
		if capitalPlot and load(player, "tcmOriginalContinent") == nil then
			save(player,"tcmOriginalContinent", capitalPlot:GetArea())
		end
		for city in player:Cities() do
			if city then
				if city:IsCapital() then
					local targetPopulation = load(player, "tcmOriginalCapitalSize")
					if targetPopulation then
						if city:GetPopulation() < targetPopulation then
							if not city:IsHasBuilding(buildingFoodDummyID) then
								city:SetNumRealBuilding(buildingFoodDummyID, 1)
							end
						else
							if city:IsHasBuilding(buildingFoodDummyID) then
								city:SetNumRealBuilding(buildingFoodDummyID, 0)
							end
						end
					end
					if city:IsHasBuilding(buildingHappyDummyID) then
						city:SetNumRealBuilding(buildingHappyDummyID, 0)
					end
				else
					local plot = city:Plot()
					if plot and capitalPlot and plot:GetArea() == capitalPlot:GetArea()then
						if not city:IsHasBuilding(buildingHappyDummyID) then
							city:SetNumRealBuilding(buildingHappyDummyID, 1)
						end
					else
						if city:IsHasBuilding(buildingHappyDummyID) then
							city:SetNumRealBuilding(buildingHappyDummyID, 0)
						end
					end
					if city:IsHasBuilding(buildingFoodDummyID) then
						city:SetNumRealBuilding(buildingFoodDummyID, 0)
					end
				end
			end
		end
	end
end

function continentHappiness(playerID)
	local player = Players[playerID]
	if player:IsEverAlive() and player:GetCivilizationType() == civilisationPortugalBrazilID then
		manageContinentHappiness(player)
	end
end

function continentHappinessCityCapture(oldOwnerID, isCapital, plotX, plotY, newOwnerID)
	local player = Players[newOwnerID]
	local otherPlayer = Players[oldOwnerID]
	if player:IsEverAlive() and player:GetCivilizationType() == civilisationPortugalBrazilID then
		manageContinentHappiness(player)
	elseif otherPlayer:IsEverAlive() and otherPlayer:GetCivilizationType() == civilisationPortugalBrazilID then
		manageContinentHappiness(otherPlayer)
	end
end

if JFD_IsCivilisationActive(civilisationPortugalBrazilID) then
	GameEvents.CityBuildingsIsBuildingSellable.Add(canSellWinery)
	GameEvents.CityConstructed.Add(spawnWine)
	GameEvents.PlayerDoTurn.Add(continentHappiness)
	GameEvents.PlayerCityFounded.Add(continentHappiness)
	GameEvents.CityCaptureComplete.Add(continentHappinessCityCapture)	
end
--==========================================================================================================================
--Cacador XP
--==========================================================================================================================
local promotionDoubleXPInfoID = GameInfoTypes["PROMOTION_TCM_DOUBLE_XP_INFO"]
local promotionDoubleXPID = GameInfoTypes["PROMOTION_TCM_DOUBLE_XP"]
local unitClassGreatGeneralID = GameInfoTypes["UNITCLASS_GREAT_GENERAL"]

function cacadorGreatGeneralXP(playerID)
	local player = Players[playerID]
	if player:IsEverAlive() then
		for unit in player:Units() do
			if unit then
				if unit:GetDomainType() == DomainTypes.DOMAIN_LAND and unit:GetCombatLimit() > 0 and (unit:IsHasPromotion(promotionDoubleXPInfoID) or unit:IsHasPromotion(promotionDoubleXPID)) then
					local generalNearby = false
					for general in player:Units() do
						if general and general:GetUnitClassType() == unitClassGreatGeneralID then
							if Map.PlotDistance(unit:GetX(), unit:GetY(), general:GetX(), general:GetY()) < 3 then
								generalNearby = true
							end
						end
					end
					if generalNearby then
						if unit:IsHasPromotion(promotionDoubleXPInfoID) then
							unit:SetHasPromotion(promotionDoubleXPInfoID, false)
							unit:SetHasPromotion(promotionDoubleXPID, true)
						end
					else
						if unit:IsHasPromotion(promotionDoubleXPID) then
							unit:SetHasPromotion(promotionDoubleXPInfoID, true)
							unit:SetHasPromotion(promotionDoubleXPID, false)
						end
					end
				else
					if unit:IsHasPromotion(promotionDoubleXPID) then
						unit:SetHasPromotion(promotionDoubleXPInfoID, true)
						unit:SetHasPromotion(promotionDoubleXPID, false)
					end
				end
			end
		end
	end
end

function cacadorInitialTrigger(playerID, unitID)
	local player = Players[playerID]
	local unit = player:GetUnitByID(unitID)
	if unit and unit:IsHasPromotion(promotionDoubleXPInfoID) then
		GameEvents.PlayerDoTurn.Add(cacadorGreatGeneralXP)
		GameEvents.UnitSetXY.Add(cacadorGreatGeneralXP) 
		Events.SerialEventUnitCreated.Add(cacadorGreatGeneralXP)
		Events.SerialEventUnitCreated.Remove(cacadorInitialTrigger)
		save("GAME", "tcmCacadorInitalised", true)
		cacadorGreatGeneralXP(playerID)
	end
end

if load("GAME", "tcmCacadorInitalised") then
	GameEvents.PlayerDoTurn.Add(cacadorGreatGeneralXP)
	GameEvents.UnitSetXY.Add(cacadorGreatGeneralXP) 
	Events.SerialEventUnitCreated.Add(cacadorGreatGeneralXP)
else
	Events.SerialEventUnitCreated.Add(cacadorInitialTrigger)
end
--==========================================================================================================================
-- UI FUNCTIONS
-- This code was adapted from JFD's Sardinia-Piedmont, thus it has his name all around.
--==========================================================================================================================
local isCityViewOpen = false
----------------------------------------------------------------------------------------------------------------------------
-- PortugalBrazil_UpdateButton
----------------------------------------------------------------------------------------------------------------------------
function PortugalBrazil_UpdateButton()
	Controls.UnitBackground:SetHide(true)
	Controls.UnitButton:SetDisabled(true)
	Controls.UnitButton:LocalizeAndSetToolTip(nil)
	local city = UI.GetHeadSelectedCity()
	if city then
		local playerID = city:GetOwner()
		local player = Players[playerID]
		if player:IsEverAlive() and player:GetCivilizationType() == civilisationPortugalBrazilID then
			local plot = city:Plot()
			local originalContinent = load(player, "tcmOriginalContinent")
			if plot and originalContinent then
				if city:IsOriginalCapital() or plot:GetArea() ~= originalContinent then
					if not city:IsCapital() then
						local unitButtonText = Locale.ConvertTextKey("TXT_KEY_TCM_CLICK_TO_CHANGE_CAPITAL")
						local toolTip = Locale.ConvertTextKey("TXT_KEY_TCM_CHANGE_CAPITAL_TOOLTIP")
						Controls.UnitButton:SetDisabled(false)
						Controls.UnitButton:SetText(unitButtonText)
						Controls.UnitBackground:SetHide(false)
						Controls.UnitButton:LocalizeAndSetToolTip(toolTip)
					end
				end
			end
		end
	end
end
----------------------------------------------------------------------------------------------------------------------------
-- PortugalBrazil_OnClick
----------------------------------------------------------------------------------------------------------------------------
local buildingClassPalaceID = GameInfoTypes["BUILDINGCLASS_PALACE"]
local buildingPalaceID = GameInfoTypes["BUILDING_PALACE"]
local buildingClassTempArtHolderID = GameInfoTypes["BUILDINGCLASS_TCM_TEMP_ART_HOLDER"]
local buildingTempArtHolderID = GameInfoTypes["BUILDING_TCM_TEMP_ART_HOLDER"]

function PortugalBrazil_OnClick()
	local city = UI.GetHeadSelectedCity()
	if city then
		local playerID = city:GetOwner()
		local player = Players[playerID]
		if player:IsEverAlive() then
			local oldCapital = player:GetCapitalCity()
			if oldCapital then
				local pop = oldCapital:GetPopulation()
				save(player, "tcmOriginalCapitalSize", pop)
				if oldCapital:IsHasBuilding(buildingFoodDummyID) then
					oldCapital:SetNumRealBuilding(buildingFoodDummyID, 0)
				end
				local greatWorkIndex = oldCapital:GetBuildingGreatWork(buildingClassPalaceID, 0)
				local bSwap = false
				if greatWorkIndex > -1 then
					city:SetNumRealBuilding(buildingTempArtHolderID, 1)
					Network.SendMoveGreatWorks(playerID, oldCapital:GetID(), buildingClassPalaceID, 0, city:GetID(), buildingClassTempArtHolderID, 0)
					bSwap = true
				end
				oldCapital:SetNumRealBuilding(buildingPalaceID, 0)
				city:SetNumRealBuilding(buildingPalaceID, 1)
				if bSwap then
					Network.SendMoveGreatWorks(playerID, city:GetID(), buildingClassTempArtHolderID, 0, city:GetID(), buildingClassPalaceID, 0)
					city:SetNumRealBuilding(buildingTempArtHolderID, 0)
				end
				if pop > city:GetPopulation() then
					city:SetNumRealBuilding(buildingFoodDummyID, 1)
				end
				for otherCity in player:Cities() do
					if not otherCity:IsCapital() then
						local plot = otherCity:Plot()
						local capitalPlot = city:Plot()
						if plot and capitalPlot and plot:GetArea() == capitalPlot:GetArea()then
							if not city:IsHasBuilding(buildingHappyDummyID) then
								city:SetNumRealBuilding(buildingHappyDummyID, 1)
							end
						else
							if city:IsHasBuilding(buildingHappyDummyID) then
								city:SetNumRealBuilding(buildingHappyDummyID, 0)
							end
						end
					end
				end
			end
		end
	end
	PortugalBrazil_UpdateButton()
end

Controls.UnitButton:RegisterCallback(Mouse.eLClick, PortugalBrazil_OnClick)
----------------------------------------------------------------------------------------------------------------------------
-- PortugalBrazil__OnEnterCityScreen
----------------------------------------------------------------------------------------------------------------------------
function PortugalBrazil_OnEnterCityScreen()
	isCityViewOpen = true
	PortugalBrazil_UpdateButton()
end
----------------------------------------------------------------------------------------------------------------------------
-- PortugalBrazil__OnExitCityScreen
----------------------------------------------------------------------------------------------------------------------------
function PortugalBrazil_OnExitCityScreen()
	isCityViewOpen = false
	PortugalBrazil_UpdateButton()
end
----------------------------------------------------------------------------------------------------------------------------
-- PortugalBrazil__OnNextCityScren
----------------------------------------------------------------------------------------------------------------------------
function PortugalBrazil_OnNextCityScren()
	if isCityViewOpen then
		PortugalBrazil_UpdateButton()
	end
end

Events.SerialEventEnterCityScreen.Add(PortugalBrazil_OnEnterCityScreen)
Events.SerialEventExitCityScreen.Add(PortugalBrazil_OnExitCityScreen)
Events.SerialEventCityScreenDirty.Add(PortugalBrazil_OnNextCityScren)
--==========================================================================================================================
--==========================================================================================================================