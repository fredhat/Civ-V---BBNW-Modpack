-- Lincoln America Functions
-- Author: JFD
-- Heavily Edited By: F0S
--=======================================================================================================================
-- UTILITY FUNCTIONS
--=======================================================================================================================
WARN_NOT_SHARED = false; include( "Sukritact_SaveUtils.lua" ); MY_MOD_NAME = "JFD_LincolnUSA";
--------------------------------------------------------------------------------------------------------------------------
-- JFD_IsCivilisationActive
--------------------------------------------------------------------------------------------------------------------------
local civilisationID = GameInfoTypes["CIVILIZATION_JFD_AMERICA_LINCOLN"]

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
--------------------------------------------------------------------------------------------------------------------------
-- GetRandom
--------------------------------------------------------------------------------------------------------------------------
function GetRandom(lower, upper)
    return Game.Rand((upper + 1) - lower, "") + lower
end
--==========================================================================================================================
-- CORE FUNCTIONS
--==========================================================================================================================
-- JFD_BlockMonitor
----------------------------------------------------------------------------------------------------------------------------	
local techSteamPowerID = GameInfoTypes["TECH_STEAM_POWER"]
local unitMonitorRangedID = GameInfoTypes["UNIT_JFD_MONITOR_RANGED"]

function JFD_BlockMonitor(playerID, unitID)
	local player = Players[playerID]
	local teamTechs = Teams[player:GetTeam()]:GetTeamTechs()
	if (not teamTechs:HasTech(techSteamPowerID) or player:GetCivilizationType() ~= civilisationID) and unitID == unitMonitorRangedID then 
		return
	end
	return true
end

GameEvents.PlayerCanTrain.Add(JFD_BlockMonitor)
----------------------------------------------------------------------------------------------------------------------------
-- JFD_InitLincoln
----------------------------------------------------------------------------------------------------------------------------	
local policyLincolnDummyID = GameInfoTypes["POLICY_JFD_LINCOLN_DUMMY"]

function JFD_InitLincoln()
	for playerID, player in pairs(Players) do
		local player = Players[playerID]
		if player:IsEverAlive() and player:GetCivilizationType() == civilisationID then
			if not player:HasPolicy(policyLincolnDummyID) then
				player:SetNumFreePolicies(player:GetNumFreePolicies() + 1)
				player:SetNumFreePolicies(player:GetNumFreePolicies() - 1)
				player:SetHasPolicy(policyLincolnDummyID, true)	
			end
		end
	end 
end
----------------------------------------------------------------------------------------------------------------------------
-- JFD_LincolnCapitalism
----------------------------------------------------------------------------------------------------------------------------	
local improvementMineID = GameInfoTypes["IMPROVEMENT_MINE"]
local eraIndustrialID = GameInfoTypes["ERA_INDUSTRIAL"]
local buildingCaravansary = GameInfo.Buildings["BUILDING_CARAVANSARY"]
local buildingMarket = GameInfo.Buildings["BUILDING_MARKET"]
local buildingBank = GameInfo.Buildings["BUILDING_BANK"]
local buildingStockExchange = GameInfo.Buildings["BUILDING_STOCK_EXCHANGE"]
local buildingMint = GameInfo.Buildings["BUILDING_MINT"]
local buildingWalls = GameInfo.Buildings["BUILDING_WALLS"]
local buildingCastle = GameInfo.Buildings["BUILDING_CASTLE"]
local buildingArsenal = GameInfo.Buildings["BUILDING_ARSENAL"]
local buildingMilitaryBase = GameInfo.Buildings["BUILDING_MILITARY_BASE"]
local resourceGoldID = GameInfoTypes["RESOURCE_GOLD"]
local resourceSilverID = GameInfoTypes["RESOURCE_SILVER"]
local resourceCopperID = GameInfoTypes["RESOURCE_COPPER"]

function JFD_GetPrereqTech(buildingID)
	return GameInfo.Buildings[buildingID].PrereqTech
end

function JFD_GetResourceInBorders(city, resourceID)
	for cityPlot = 0, city:GetNumCityPlots() - 1, 1 do
		local plot = city:GetCityIndexPlot(cityPlot)
		if plot and plot:GetImprovementType() == improvementMineID and plot:GetResourceType() == resourceID and not plot:IsImprovementPillaged() then
			return true
		end
	end
	return false
end

function JFD_AddLincolnBuilding(player, city, building, buildingDescription, production)
	if city:GetBuildingProductionTurnsLeft(building.ID) == 1 and not city:IsHasBuilding(building.ID) then
		local capitalistType = "American Merchants"
		if player:GetCurrentEra() >= eraIndustrialID then
			capitalistType = "American Investors"
		end
		local descriptionShort = Locale.ConvertTextKey("TXT_KEY_JFD_CAPITALIST_BUILDING_SHORT", building.Description, city:GetName())
		local description = Locale.ConvertTextKey("TXT_KEY_JFD_CAPITALIST_BUILDING", capitalistType, buildingDescription, city:GetName())
		city:SetNumRealBuilding(building.ID, 1)
		if player:IsHuman() and player:IsTurnActive() then
			player:AddNotification(NotificationTypes["NOTIFICATION_GENERIC"], description, descriptionShort)
		end
	else
		city:ChangeBuildingProduction(building.ID, production)
	end
end		

function JFD_LincolnCapitalism(playerID)
	local player = Players[playerID]
	if player:IsEverAlive() and player:GetCivilizationType() == civilisationID then
		for city in player:Cities() do
			local currentProductionYield = city:GetBaseYieldRate(YieldTypes.YIELD_PRODUCTION) 
			local currentProductionModifiers = city:GetBuildingProductionModifier()
			if currentProductionModifiers > 0 then
				currentProductionYield = currentProductionYield * (1 + (currentProductionModifiers / 100))
			end
			local team = Teams[player:GetTeam()]
			local teamTechs = team:GetTeamTechs()
			if team:GetAtWarCount(true) == 0 then
				if teamTechs:HasTech(GameInfoTypes[JFD_GetPrereqTech(buildingCaravansary.ID)]) and not city:IsHasBuilding(buildingCaravansary.ID) then 
					JFD_AddLincolnBuilding(player, city, buildingCaravansary.ID, "a Caravansary", currentProductionYield)
				elseif teamTechs:HasTech(GameInfoTypes[JFD_GetPrereqTech(buildingMarket.ID)]) and not city:IsHasBuilding(buildingMarket.ID) then 
					JFD_AddLincolnBuilding(player, city, buildingMarket.ID, "a Market", currentProductionYield)
				elseif teamTechs:HasTech(GameInfoTypes[JFD_GetPrereqTech(buildingBank.ID)]) and not city:IsHasBuilding(buildingBank.ID) and city:IsHasBuilding(buildingMarket.ID) then 
					JFD_AddLincolnBuilding(player, city, buildingBank.ID, "a Bank", currentProductionYield)
				elseif teamTechs:HasTech(GameInfoTypes[JFD_GetPrereqTech(buildingStockExchange.ID)]) and not city:IsHasBuilding(buildingStockExchange.ID) and city:IsHasBuilding(buildingBank.ID) then 
					JFD_AddLincolnBuilding(player, city, buildingStockExchange.ID, "a Stock Exchange", currentProductionYield)
				elseif teamTechs:HasTech(GameInfoTypes[JFD_GetPrereqTech(buildingMint.ID)]) and not city:IsHasBuilding(buildingMint.ID) and (JFD_GetResourceInBorders(city, resourceGoldID) or JFD_GetResourceInBorders(city, resourceSilverID) or JFD_GetResourceInBorders(city, resourceCopperID)) then 
					JFD_AddLincolnBuilding(player, city, buildingMint.ID, "a Mint", currentProductionYield)
				end
			else
				if teamTechs:HasTech(GameInfoTypes[JFD_GetPrereqTech(buildingWalls.ID)]) and not city:IsHasBuilding(buildingWalls.ID) then 
					JFD_AddLincolnBuilding(player, city, buildingWalls.ID, "Walls", currentProductionYield)
				elseif teamTechs:HasTech(GameInfoTypes[JFD_GetPrereqTech(buildingCastle.ID)]) and not city:IsHasBuilding(buildingCastle.ID) and city:IsHasBuilding(buildingWalls.ID) then 
					JFD_AddLincolnBuilding(player, city, buildingCastle.ID, "a Castle", currentProductionYield)
				elseif teamTechs:HasTech(GameInfoTypes[JFD_GetPrereqTech(buildingArsenal.ID)]) and not city:IsHasBuilding(buildingArsenal.ID) and city:IsHasBuilding(buildingCastle.ID) then 
					JFD_AddLincolnBuilding(player, city, buildingArsenal.ID, "a Arsenal", currentProductionYield)
				elseif teamTechs:HasTech(GameInfoTypes[JFD_GetPrereqTech(buildingMilitaryBase.ID)]) and not city:IsHasBuilding(buildingMilitaryBase.ID) and city:IsHasBuilding(buildingArsenal.ID) then 
					JFD_AddLincolnBuilding(player, city, buildingMilitaryBase.ID, "a Military Base", currentProductionYield)
				end
			end
		end
	end
end
----------------------------------------------------------------------------------------------------------------------------
--JFD_LincolnOration
----------------------------------------------------------------------------------------------------------------------------
local policyLincolnSpeech1ID = GameInfoTypes["POLICY_JFD_LINCOLN_SPEECH_ONE"]
local policyLincolnSpeech2ID = GameInfoTypes["POLICY_JFD_LINCOLN_SPEECH_TWO"]
local policyLincolnSpeech3ID = GameInfoTypes["POLICY_JFD_LINCOLN_SPEECH_THREE"]
local policyLincolnSpeech4ID = GameInfoTypes["POLICY_JFD_LINCOLN_SPEECH_FOUR"]
local policyLincolnSpeech5ID = GameInfoTypes["POLICY_JFD_LINCOLN_SPEECH_FIVE"]
local policyLincolnSpeech6ID = GameInfoTypes["POLICY_JFD_LINCOLN_SPEECH_SIX"]
local lincolnSpeeches = {
	policyLincolnSpeech1ID,
	policyLincolnSpeech2ID,
	policyLincolnSpeech3ID,
	policyLincolnSpeech4ID,
	policyLincolnSpeech5ID,
	policyLincolnSpeech6ID
}
local promotionLincolnSpeech1ID = GameInfoTypes["PROMOTION_JFD_LINCOLN_SPEECH_ONE"]
local promotionLincolnSpeech3ID = GameInfoTypes["PROMOTION_JFD_LINCOLN_SPEECH_THREE"]
local buildingLincolnSpeech3ID = GameInfoTypes["BUILDING_JFD_LINCOLN_SPEECH_THREE"]

function JFD_LincolnOration(player)
	if player:GetCivilizationType() == civilisationID then 
		local team = Teams[player:GetTeam()]
		if team:GetAtWarCount(true) == 0 then
			if not player:HasPolicy(policyLincolnDummyID) then
				for _, policyID in pairs(lincolnSpeeches) do
					if player:HasPolicy(policyID) then
						player:SetHasPolicy(policyID, false)
					end	
				end
				player:SetHasPolicy(policyLincolnDummyID, true)
				if player:IsHuman() and player:IsTurnActive() then
					local description = Locale.ConvertTextKey("TXT_KEY_JFD_LINCOLN_SPEECH_ENDED_HELP")
					local descriptionShort = Locale.ConvertTextKey("TXT_KEY_JFD_LINCOLN_SPEECH_ENDED")
					player:AddNotification(NotificationTypes["NOTIFICATION_GENERIC"], description, descriptionShort)
				end
			end
			for unit in player:Units() do
				if unit and unit:IsHasPromotion(promotionLincolnSpeech1ID) then
					unit:SetHasPromotion(promotionLincolnSpeech1ID, false)
				end
				if unit and unit:IsHasPromotion(promotionLincolnSpeech3ID) then
					unit:SetHasPromotion(promotionLincolnSpeech3ID, false)
				end
			end
			for city in player:Cities() do
				if city and city:IsHasBuilding(buildingLincolnSpeech3ID) then
					city:SetNumRealBuilding(buildingLincolnSpeech3ID, 0)
				end
			end
		else
			local randomPolicy = GetRandom(1, #lincolnSpeeches)
			if player:HasPolicy(policyLincolnDummyID) then
				player:SetHasPolicy(lincolnSpeeches[randomPolicy], true)
				player:SetHasPolicy(policyLincolnDummyID, false)
				if randomPolicy == policyLincolnSpeech1ID then
					for unit in player:Units() do
						if unit and not unit:IsHasPromotion(promotionLincolnSpeech1ID) then
							unit:SetHasPromotion(promotionLincolnSpeech1ID, false)
						end
					end
					if player:IsHuman() and player:IsTurnActive() then
						local description = Locale.ConvertTextKey("TXT_KEY_JFD_LINCOLN_SPEECH_ONE_HELP")
						local descriptionShort = Locale.ConvertTextKey("TXT_KEY_JFD_LINCOLN_SPEECH_ONE")
						player:AddNotification(NotificationTypes["NOTIFICATION_GENERIC"], description, descriptionShort)
					end
				elseif randomPolicy == policyLincolnSpeech2ID then
					if player:IsHuman() and player:IsTurnActive() then
						local description = Locale.ConvertTextKey("TXT_KEY_JFD_LINCOLN_SPEECH_TWO_HELP")
						local descriptionShort = Locale.ConvertTextKey("TXT_KEY_JFD_LINCOLN_SPEECH_TWO")
						player:AddNotification(NotificationTypes["NOTIFICATION_GENERIC"], description, descriptionShort)
					end
				elseif randomPolicy == policyLincolnSpeech3ID then
					for unit in player:Units() do
						if unit and not unit:IsHasPromotion(promotionLincolnSpeech3ID) then
							unit:SetHasPromotion(promotionLincolnSpeech3ID, false)
						end
					end
					for city in player:Cities() do
						if city and not city:IsHasBuilding(buildingLincolnSpeech3ID) then
							city:SetNumRealBuilding(buildingLincolnSpeech3ID, 1)
						end
					end
					if player:IsHuman() and player:IsTurnActive() then
						local description = Locale.ConvertTextKey("TXT_KEY_JFD_LINCOLN_SPEECH_THREE_HELP")
						local descriptionShort = Locale.ConvertTextKey("TXT_KEY_JFD_LINCOLN_SPEECH_THREE")
						player:AddNotification(NotificationTypes["NOTIFICATION_GENERIC"], description, descriptionShort)
					end
				elseif randomPolicy == policyLincolnSpeech4ID then
					if player:IsHuman() and player:IsTurnActive() then
						local description = Locale.ConvertTextKey("TXT_KEY_JFD_LINCOLN_SPEECH_FOUR_HELP")
						local descriptionShort = Locale.ConvertTextKey("TXT_KEY_JFD_LINCOLN_SPEECH_FOUR")
						player:AddNotification(NotificationTypes["NOTIFICATION_GENERIC"], description, descriptionShort)
					end
				elseif randomPolicy == policyLincolnSpeech5ID then
					if player:IsHuman() and player:IsTurnActive() then
						local description = Locale.ConvertTextKey("TXT_KEY_JFD_LINCOLN_SPEECH_FIVE_HELP")
						local descriptionShort = Locale.ConvertTextKey("TXT_KEY_JFD_LINCOLN_SPEECH_FIVE")
						player:AddNotification(NotificationTypes["NOTIFICATION_GENERIC"], description, descriptionShort)
					end
				elseif randomPolicy == policyLincolnSpeech6ID then
					if player:IsHuman() and player:IsTurnActive() then
						local description = Locale.ConvertTextKey("TXT_KEY_JFD_LINCOLN_SPEECH_SIX_HELP")
						local descriptionShort = Locale.ConvertTextKey("TXT_KEY_JFD_LINCOLN_SPEECH_SIX")
						player:AddNotification(NotificationTypes["NOTIFICATION_GENERIC"], description, descriptionShort)
					end
				end
			end
		end
	end
end

function JFD_LincolnOrationWar(teamOne, teamTwo, war)
	for playerID = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do			
		local player = Players[playerID]
		if player:IsEverAlive() and (player:GetTeam() == teamOne or player:GetTeam() == teamTwo) then
			JFD_LincolnOration(player)
		end
	end	
end

function JFD_LincolnOrationBuildingsTurn(playerID)
	local player = Players[playerID]
	if player:IsEverAlive() and player:GetCivilizationType() == civilisationID then
		for city in player:Cities() do
			if city then
				if player:HasPolicy(policyLincolnSpeech3ID) then
					if not city:IsHasBuilding(buildingLincolnSpeech3ID) then
						city:SetNumRealBuilding(buildingLincolnSpeech3ID, 1)
					end
				else
					if city:IsHasBuilding(buildingLincolnSpeech3ID) then
						city:SetNumRealBuilding(buildingLincolnSpeech3ID, 0)
					end
				end
			end
		end
	end
end

function JFD_LincolnOrationBuildingsDirty()
	local playerID = Game.GetActivePlayer()
    local player = Players[playerID]
	if player:IsTurnActive() then
        JFD_LincolnOrationBuildingsTurn(playerID)
    end
end

if JFD_IsCivilisationActive(civilisationID) then
	Events.SequenceGameInitComplete.Add(JFD_InitLincoln)
	GameEvents.PlayerDoTurn.Add(JFD_LincolnCapitalism)
	Events.WarStateChanged.Add(JFD_LincolnOrationWar)
	GameEvents.PlayerDoTurn.Add(JFD_LincolnOrationBuildingsTurn)
	Events.SerialEventGameDataDirty.Add(JFD_LincolnOrationBuildingsDirty)
end
----------------------------------------------------------------------------------------------------------------------------
-- JFD_ParrottRifleDefense
----------------------------------------------------------------------------------------------------------------------------	
local promotionParrottRifleID = GameInfoTypes["PROMOTION_JFD_PARROTT_RIFLE"]
local promotionParrottDefenseID = GameInfoTypes["PROMOTION_JFD_PARROTT_DEFENSE"]
local improvementFortID = GameInfoTypes["IMPROVEMENT_FORT"]
local improvementCitadelID = GameInfoTypes["IMPROVEMENT_CITADEL"]
local direction_types = {
	DirectionTypes["DIRECTION_NORTHEAST"],
	DirectionTypes["DIRECTION_NORTHWEST"],
	DirectionTypes["DIRECTION_EAST"],
	DirectionTypes["DIRECTION_SOUTHEAST"],
	DirectionTypes["DIRECTION_SOUTHWEST"],
	DirectionTypes["DIRECTION_WEST"]
}

function JFD_ParrottRifleDefense(playerID, unit, unitX, unitY)
	local adjacentToParrottRifle = false
	local plot = Map.GetPlot(unitX, unitY)
	if plot then
		for loop, direction in ipairs(direction_types) do
			local adjPlot = Map.PlotDirection(unitX, unitY, direction)
			if adjPlot then
				if unit:IsHasPromotion(promotionParrottRifleID) and plot:GetOwner() == playerID and (plot:GetImprovementType() == improvementFortID or plot:GetImprovementType() == improvementCitadelID) and not plot:IsImprovementPillaged() then
					for i = 0, adjPlot:GetNumUnits() - 1 do
						local adjUnit = adjPlot:GetUnit(i)
						if adjUnit and adjUnit:GetOwner() == playerID and adjUnit:GetCombatLimit() > 0 and adjUnit:GetDomainType() == DomainTypes.DOMAIN_LAND and not adjUnit:IsEmbarked() then
							if not adjUnit:IsHasPromotion(promotionParrottDefenseID) then
								adjUnit:SetHasPromotion(promotionParrottDefenseID, true)
							end
						end
					end
				end
				if adjPlot:GetOwner() == playerID and (adjPlot:GetImprovementType() == improvementFortID or adjPlot:GetImprovementType() == improvementCitadelID) and not adjPlot:IsImprovementPillaged() then
					for i = 0, adjPlot:GetNumUnits() - 1 do
						local adjUnit = adjPlot:GetUnit(i)
						if adjUnit and adjUnit:GetOwner() == playerID and adjUnit:IsHasPromotion(promotionParrottRifleID) then
							adjacentToParrottRifle = true
							break
						end
					end
				end
			end
		end
	end
	if adjacentToParrottRifle and unit:GetCombatLimit() > 0 and unit:GetDomainType() == DomainTypes.DOMAIN_LAND and not unit:IsEmbarked() then
		if not unit:IsHasPromotion(promotionParrottDefenseID) then
			unit:SetHasPromotion(promotionParrottDefenseID, true)
		end
	else
		if unit:IsHasPromotion(promotionParrottDefenseID) then
			unit:SetHasPromotion(promotionParrottDefenseID, false)
		end
	end
end


function JFD_ParrottRifleDefenseXY(playerID, unitID, unitX, unitY)
	local player = Players[playerID]
	if player:IsEverAlive() then
		local unit = player:GetUnitByID(unitID)
		if unit then
			JFD_ParrottRifleDefense(playerID, unit, unitX, unitY)
		end
	end
end

function JFD_ParrottRifleDefenseOther(playerID)
	local player = Players[playerID]
	if player:IsEverAlive() then
		for unit in player:Units() do
			if unit then
				JFD_ParrottRifleDefense(playerID, unit, unit:GetX(), unit:GetY())
			end
		end
	end
end

function JFD_ParrottRifleDefenseInitialTrigger(playerID, unitID)
	local player = Players[playerID]
	local unit = player:GetUnitByID(unitID)
	if unit and unit:IsHasPromotion(promotionParrottRifleID) then
		GameEvents.PlayerDoTurn.Add(JFD_ParrottRifleDefenseOther)
		GameEvents.UnitSetXY.Add(JFD_ParrottRifleDefenseXY)
		GameEvents.BuildFinished.Add(JFD_ParrottRifleDefenseOther)
		Events.SerialEventUnitCreated.Remove(JFD_ParrottRifleDefenseInitialTrigger)
		save("GAME", "JFD_ParrottRifleDefenseInitalised", true)
	end
end

if load("GAME", "JFD_ParrottRifleDefenseInitalised") then
	GameEvents.PlayerDoTurn.Add(JFD_ParrottRifleDefenseOther)
	GameEvents.UnitSetXY.Add(JFD_ParrottRifleDefenseXY)
	GameEvents.BuildFinished.Add(JFD_ParrottRifleDefenseOther)
else
	Events.SerialEventUnitCreated.Add(JFD_ParrottRifleDefenseInitialTrigger)
end
--==========================================================================================================================
--==========================================================================================================================