-- JFD_ByzantiumJustinian_Functions
-- Author: JFD
-- Edited By: F0S
--==========================================================================================================================
-- INCLUDES
--==========================================================================================================================
WARN_NOT_SHARED = false; include( "Sukritact_SaveUtils.lua" ); MY_MOD_NAME = "JFD_ByzantiumJustinian";
include("UniqueDiplomacyUtils.lua")
include("FLuaVector.lua")
--==========================================================================================================================
-- UTILITY FUNCTIONS
--==========================================================================================================================
-- GLOBALS
----------------------------------------------------------------------------------------------------------------------------
local civilisationID = GameInfoTypes["CIVILIZATION_JFD_BYZANTIUM_JUSTINIAN"]

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
--==========================================================================================================================
-- DIPLOMACY FUNCTIONS
--==========================================================================================================================
-- DIPLOMACY
----------------------------------------------------------------------------------------------------------------------------
local civilizationByzantiumID = GameInfoTypes["CIVILIZATION_BYZANTIUM"]
local civilizationByzantiumAlexiosID = GameInfoTypes["CIVILIZATION_JFD_BYZANTIUM_ALEXIOS"]
local activePlayerID = Game.GetActivePlayer()
local activePlayer = Players[activePlayerID]

--JFD_ByzantiumJustinian_SequenceGameInitComplete
function JFD_ByzantiumJustinian_SequenceGameInitComplete()
	if civilizationByzantiumID and activePlayer:GetCivilizationType() == civilizationByzantiumID then
		ChangeDiplomacyResponse("LEADER_JFD_JUSTINIAN", "RESPONSE_FIRST_GREETING",  "TXT_KEY_LEADER_JFD_JUSTINIAN_FIRSTGREETING%",	"TXT_KEY_LEADER_JFD_JUSTINIAN_THEODORA_FIRSTGREETING_1",	500)
		ChangeDiplomacyResponse("LEADER_JFD_JUSTINIAN", "RESPONSE_DEFEAT",			"TXT_KEY_LEADER_JFD_JUSTINIAN_DEFEAT%",			"TXT_KEY_LEADER_JFD_JUSTINIAN_THEODORA_DEFEATED_1",			500)
	elseif civilizationByzantiumAlexiosID and activePlayer:GetCivilizationType() == civilizationByzantiumAlexiosID then
		ChangeDiplomacyResponse("LEADER_JFD_JUSTINIAN", "RESPONSE_FIRST_GREETING",  "TXT_KEY_LEADER_JFD_JUSTINIAN_FIRSTGREETING%",	"TXT_KEY_LEADER_JFD_JUSTINIAN_ALEXIOS_FIRSTGREETING_1",		500)
		ChangeDiplomacyResponse("LEADER_JFD_JUSTINIAN", "RESPONSE_DEFEAT",			"TXT_KEY_LEADER_JFD_JUSTINIAN_DEFEAT%",			"TXT_KEY_LEADER_JFD_JUSTINIAN_ALEXIOS_DEFEATED_1",			500)
	end
end

for playerID = 0, GameDefines.MAX_MAJOR_CIVS - 1, 1 do
	local player = Players[playerID]
	if player and player:IsEverAlive() and not player:IsHuman() and player:GetCivilizationType() == civilisationID then
		Events.SequenceGameInitComplete.Add(JFD_ByzantiumJustinian_SequenceGameInitComplete)
		break
	end
end
--==========================================================================================================================
-- UNIQUE FUNCTIONS
--==========================================================================================================================
-- RENOVATIO IMPERII
----------------------------------------------------------------------------------------------------------------------------
function JFD_GetPrereqTech(buildingID)
	local prereqTech = GameInfo.Buildings[buildingID].PrereqTech
	return prereqTech
end

function JFD_AddJustinianBuilding(playerID, city, buildingType, buildingDescription, production)
	if city:GetBuildingProductionTurnsLeft(GameInfoTypes[buildingType]) == 1 and not city:IsHasBuilding(GameInfoTypes[buildingType]) then
		local descriptionShort = Locale.ConvertTextKey("TXT_KEY_JFD_JUSTINIAN_RENOVATION_SHORT", buildingDescription, city:GetName())
		local description = Locale.ConvertTextKey("TXT_KEY_JFD_JUSTINIAN_RENOVATION_DESCRIPTION", buildingDescription, city:GetName())
		city:SetNumRealBuilding(GameInfoTypes[buildingType], 1)
		save(Map.GetPlot(city:GetX(),city:GetY()),buildingDescription,1)
		local player = Players[playerID]
		local rewardGGPoints = math.ceil(city:GetBuildingPurchaseCost(GameInfoTypes[buildingType])/10)
		player:ChangeCombatExperience(rewardGGPoints)
		if player:IsHuman() and player:IsTurnActive() then
			player:AddNotification(NotificationTypes["NOTIFICATION_GENERIC"], description, descriptionShort)
			local hex = ToHexFromGrid(Vector2(city:GetX(), city:GetY()))
			Events.AddPopupTextEvent(HexToWorld(hex), Locale.ConvertTextKey("[COLOR_POSITIVE_TEXT]+{1_Num}[ENDCOLOR][ICON_GREAT_PEOPLE]", rewardGGPoints), 1)
			Events.GameplayFX(hex.x, hex.y, -1)
		end
	else
		city:ChangeBuildingProduction(GameInfoTypes[buildingType], production)
	end
end	
	
function JFD_JustinianRenovation(playerID)
	local player = Players[playerID]
	if player:IsEverAlive() and player:GetCivilizationType() == civilisationID then
		for city in player:Cities() do
			local currentProductionYield = city:GetBaseYieldRate(GameInfoTypes["YIELD_PRODUCTION"]) 
			local currentProductionModifiers = city:GetBuildingProductionModifier()
			if currentProductionModifiers > 0 then
				currentProductionYield = currentProductionYield * (1 + (currentProductionModifiers / 100))
			end
			local teamTechs = Teams[player:GetTeam()]:GetTeamTechs()
			if teamTechs:HasTech(GameInfoTypes[JFD_GetPrereqTech(GameInfoTypes["BUILDING_COURTHOUSE"])]) and not city:IsHasBuilding(GameInfoTypes["BUILDING_COURTHOUSE"]) and city:IsOccupied() and load(Map.GetPlot(city:GetX(),city:GetY()),"Courthouse") == nil then 
				JFD_AddJustinianBuilding(playerID, city, "BUILDING_COURTHOUSE", "Courthouse", currentProductionYield)
			elseif teamTechs:HasTech(GameInfoTypes[JFD_GetPrereqTech(GameInfoTypes["BUILDING_SHRINE"])]) and not city:IsHasBuilding(GameInfoTypes["BUILDING_SHRINE"]) and load(Map.GetPlot(city:GetX(),city:GetY()),"Shrine") == nil then
				JFD_AddJustinianBuilding(playerID, city, "BUILDING_SHRINE", "Shrine", currentProductionYield)
			elseif teamTechs:HasTech(GameInfoTypes[JFD_GetPrereqTech(GameInfoTypes["BUILDING_TEMPLE"])]) and not city:IsHasBuilding(GameInfoTypes["BUILDING_TEMPLE"]) and city:IsHasBuilding(GameInfoTypes["BUILDING_SHRINE"]) and load(Map.GetPlot(city:GetX(),city:GetY()),"Temple") == nil then 
				JFD_AddJustinianBuilding(playerID, city, "BUILDING_TEMPLE", "Temple", currentProductionYield)
			elseif teamTechs:HasTech(GameInfoTypes[JFD_GetPrereqTech(GameInfoTypes["BUILDING_BARRACKS"])]) and not city:IsHasBuilding(GameInfoTypes["BUILDING_BARRACKS"]) and load(Map.GetPlot(city:GetX(),city:GetY()),"Barracks") == nil then
				JFD_AddJustinianBuilding(playerID, city, "BUILDING_BARRACKS", "Barracks", currentProductionYield)
			elseif teamTechs:HasTech(GameInfoTypes[JFD_GetPrereqTech(GameInfoTypes["BUILDING_ARMORY"])]) and not city:IsHasBuilding(GameInfoTypes["BUILDING_ARMORY"]) and city:IsHasBuilding(GameInfoTypes["BUILDING_BARRACKS"]) and load(Map.GetPlot(city:GetX(),city:GetY()),"Armory") == nil then 
				JFD_AddJustinianBuilding(playerID, city, "BUILDING_ARMORY", "Armory", currentProductionYield)
			elseif teamTechs:HasTech(GameInfoTypes[JFD_GetPrereqTech(GameInfoTypes["BUILDING_MILITARY_ACADEMY"])]) and not city:IsHasBuilding(GameInfoTypes["BUILDING_MILITARY_ACADEMY"]) and city:IsHasBuilding(GameInfoTypes["BUILDING_ARMORY"]) and load(Map.GetPlot(city:GetX(),city:GetY()),"Military Academy") == nil then 
				JFD_AddJustinianBuilding(playerID, city, "BUILDING_MILITARY_ACADEMY", "Military Academy", currentProductionYield)
			end
		end
	end
end

function JFD_JustinianRenovation_CityConstructed(playerID, cityID, buildingID)
	local player = Players[playerID]
	if player:IsEverAlive() and player:GetCivilizationType() == civilisationID then
		local city = player:GetCityByID(cityID)
		if city then
			if buildingID == GameInfoTypes["BUILDING_COURTHOUSE"] and load(Map.GetPlot(city:GetX(),city:GetY()),"Courthouse") == nil then
				local rewardGGPoints = math.ceil(city:GetBuildingPurchaseCost(buildingID)/10)
				player:ChangeCombatExperience(rewardGGPoints)
				if player:IsHuman() and player:IsTurnActive() then
					local hex = ToHexFromGrid(Vector2(city:GetX(), city:GetY()))
					Events.AddPopupTextEvent(HexToWorld(hex), Locale.ConvertTextKey("[COLOR_POSITIVE_TEXT]+{1_Num}[ENDCOLOR][ICON_GREAT_PEOPLE]", rewardGGPoints), 1)
					Events.GameplayFX(hex.x, hex.y, -1)
				end
			elseif buildingID == GameInfoTypes["BUILDING_SHRINE"] and load(Map.GetPlot(city:GetX(),city:GetY()),"Shrine") == nil  then
				local rewardGGPoints = math.ceil(city:GetBuildingPurchaseCost(buildingID)/10)
				player:ChangeCombatExperience(rewardGGPoints)
				if player:IsHuman() and player:IsTurnActive() then
					local hex = ToHexFromGrid(Vector2(city:GetX(), city:GetY()))
					Events.AddPopupTextEvent(HexToWorld(hex), Locale.ConvertTextKey("[COLOR_POSITIVE_TEXT]+{1_Num}[ENDCOLOR][ICON_GREAT_PEOPLE]", rewardGGPoints), 1)
					Events.GameplayFX(hex.x, hex.y, -1)
				end
			elseif buildingID == GameInfoTypes["BUILDING_TEMPLE"] and load(Map.GetPlot(city:GetX(),city:GetY()),"Temple") == nil  then
				local rewardGGPoints = math.ceil(city:GetBuildingPurchaseCost(buildingID)/10)
				player:ChangeCombatExperience(rewardGGPoints)
				if player:IsHuman() and player:IsTurnActive() then
					local hex = ToHexFromGrid(Vector2(city:GetX(), city:GetY()))
					Events.AddPopupTextEvent(HexToWorld(hex), Locale.ConvertTextKey("[COLOR_POSITIVE_TEXT]+{1_Num}[ENDCOLOR][ICON_GREAT_PEOPLE]", rewardGGPoints), 1)
					Events.GameplayFX(hex.x, hex.y, -1)
				end
			elseif buildingID == GameInfoTypes["BUILDING_BARRACKS"] and load(Map.GetPlot(city:GetX(),city:GetY()),"Barracks") == nil  then
				local rewardGGPoints = math.ceil(city:GetBuildingPurchaseCost(buildingID)/10)
				player:ChangeCombatExperience(rewardGGPoints)
				if player:IsHuman() and player:IsTurnActive() then
					local hex = ToHexFromGrid(Vector2(city:GetX(), city:GetY()))
					Events.AddPopupTextEvent(HexToWorld(hex), Locale.ConvertTextKey("[COLOR_POSITIVE_TEXT]+{1_Num}[ENDCOLOR][ICON_GREAT_PEOPLE]", rewardGGPoints), 1)
					Events.GameplayFX(hex.x, hex.y, -1)
				end
			elseif buildingID == GameInfoTypes["BUILDING_ARMORY"] and load(Map.GetPlot(city:GetX(),city:GetY()),"Armory") == nil  then
				local rewardGGPoints = math.ceil(city:GetBuildingPurchaseCost(buildingID)/10)
				player:ChangeCombatExperience(rewardGGPoints)
				if player:IsHuman() and player:IsTurnActive() then
					local hex = ToHexFromGrid(Vector2(city:GetX(), city:GetY()))
					Events.AddPopupTextEvent(HexToWorld(hex), Locale.ConvertTextKey("[COLOR_POSITIVE_TEXT]+{1_Num}[ENDCOLOR][ICON_GREAT_PEOPLE]", rewardGGPoints), 1)
					Events.GameplayFX(hex.x, hex.y, -1)
				end
			elseif buildingID == GameInfoTypes["BUILDING_MILITARY_ACADEMY"] and load(Map.GetPlot(city:GetX(),city:GetY()),"Military Academy") == nil  then
				local rewardGGPoints = math.ceil(city:GetBuildingPurchaseCost(buildingID)/10)
				player:ChangeCombatExperience(rewardGGPoints)
				if player:IsHuman() and player:IsTurnActive() then
					local hex = ToHexFromGrid(Vector2(city:GetX(), city:GetY()))
					Events.AddPopupTextEvent(HexToWorld(hex), Locale.ConvertTextKey("[COLOR_POSITIVE_TEXT]+{1_Num}[ENDCOLOR][ICON_GREAT_PEOPLE]", rewardGGPoints), 1)
					Events.GameplayFX(hex.x, hex.y, -1)
				end
			end
		end
	end
end
----------------------------------------------------------------------------------------------------------------------------
-- HIPPODROME
----------------------------------------------------------------------------------------------------------------------------
local buildingHippodromeID = GameInfoTypes["BUILDING_JFD_HIPPODROME"]

function JFD_JustinianHippodrome_CityTrained(playerID, cityID, unitID, isGold, isFaith)
	local player = Players[playerID]
	if not isGold and not isFaith then
		if player:IsEverAlive() then
			local city = player:GetCityByID(cityID)
			if city and city:IsHasBuilding(buildingHippodromeID) then
				local unit = player:GetUnitByID(unitID)
				if unit and unit:GetCombatLimit() > 0 and unit:GetDomainType() == DomainTypes.DOMAIN_LAND then
					local rewardGold = unit:GetExperience()
					player:ChangeGold(rewardGold)
					if player:IsHuman() and player:IsTurnActive() then
						local hex = ToHexFromGrid(Vector2(city:GetX(), city:GetY()))
						Events.AddPopupTextEvent(HexToWorld(hex), Locale.ConvertTextKey("[COLOR_YELLOW]+{1_Num}[ENDCOLOR][ICON_GOLD]", rewardGold), 1)
						Events.GameplayFX(hex.x, hex.y, -1)
					end
				end
			end
		end
	end
end

if JFD_IsCivilisationActive(civilisationID) then
	GameEvents.PlayerDoTurn.Add(JFD_JustinianRenovation)
	GameEvents.CityConstructed.Add(JFD_JustinianRenovation_CityConstructed)
	GameEvents.CityTrained.Add(JFD_JustinianHippodrome_CityTrained)
end
--==========================================================================================================================
--==========================================================================================================================