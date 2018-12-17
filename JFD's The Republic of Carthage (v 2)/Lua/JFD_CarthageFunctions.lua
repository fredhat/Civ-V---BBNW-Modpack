-- JFD_CoreFunctions
-- Author: JFD
-- Heavily Edited By: F0S
--==========================================================================================================================
-- UTILITY FUNCTIONS
--==========================================================================================================================
WARN_NOT_SHARED = false; include( "Sukritact_SaveUtils.lua" ); MY_MOD_NAME = "JFD_CarthageFunctions";
include("PlotIterators")
include("FLuaVector.lua")
--------------------------------------------------------------
-- JFD_IsCivilisationActive
--------------------------------------------------------------
local civilisationDidoID = GameInfoTypes["CIVILIZATION_CARTHAGE"]
local civilisationHannibalID = GameInfoTypes["CIVILIZATION_JFD_CARTHAGE_HANNIBAL"]

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
-- CORE DIDO FUNCTIONS
--==========================================================================================================================
-- JFD_DidoWaterClaims
----------------------------------------------------------------------------------------------------------------------------
local resourceShellfishID = GameInfoTypes["RESOURCE_JFD_SHELLFISH"]
local radius = 3

function JFD_DidoWaterClaims(playerID, iX, iY)
	local player = Players[playerID]
	if player:IsEverAlive() and player:GetCivilizationType() == civilisationDidoID then
		local plot = Map.GetPlot(iX, iY)
		if plot then
			local city = plot:GetPlotCity()
			if city then
				local tablePlots = {}
				for loopPlot in PlotAreaSweepIterator(plot, radius, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
					if loopPlot and (loopPlot:GetTerrainType() == GameInfoTypes["TERRAIN_COAST"] or loopPlot:GetTerrainType() == GameInfoTypes["TERRAIN_OCEAN"]) then
						table.insert(tablePlots, loopPlot)
					end
				end
				local isPlaced = false
				while #tablePlots > 0 do
					local randomPlot = GetRandom(1, #tablePlots)
					local spawnPlot = tablePlots[randomPlot]
					if spawnPlot then
						if not isPlaced and spawnPlot:GetTerrainType() == GameInfoTypes["TERRAIN_COAST"] and spawnPlot:GetFeatureType() == -1 and not spawnPlot:IsLake() and not spawnPlot:IsCity() and spawnPlot:GetResourceType() == -1 and (spawnPlot:GetOwner() == -1 or spawnPlot:GetOwner() == playerID) then
							spawnPlot:SetResourceType(resourceShellfishID, 1)
							spawnPlot:SetOwner(-1)
							isPlaced = true
						end
						if spawnPlot:GetOwner() == -1 then
							spawnPlot:SetOwner(playerID, city:GetID())
							spawnPlot:SetRevealed(player:GetTeam(), true)
							spawnPlot:UpdateFog()
						end
					end
					table.remove(tablePlots, randomPlot)
				end
			end
		end
	end 	
end
----------------------------------------------------------------------------------------------------------------------------
-- JFD_NavalDefense
----------------------------------------------------------------------------------------------------------------------------	
local buildingCothonID = GameInfoTypes["BUILDING_JFD_COTHON"]
local promotionCothonID = GameInfoTypes["PROMOTION_JFD_COTHON"]
local buildingDidoCarthageID = GameInfoTypes["BUILDING_JFD_DIDO_CARTHAGE"]

function JFD_NavalDefense(playerID)
	local player = Players[playerID]
	if player:IsEverAlive() then
		for city in player:Cities() do
			if city and city:IsHasBuilding(buildingCothonID) then
				local inCity = false
				local navalUnit = nil
				local plot = Map.GetPlot(city:GetX(), city:GetY()) 
				if plot then
					for i = 0, plot:GetNumUnits() - 1 do
						local unit = plot:GetUnit(i)
						if unit and unit:IsHasPromotion(promotionCothonID) then
							inCity = true
							navalUnit = unit
							break
						end
					end
				end
				if inCity and navalUnit ~= nil then
					local unitStrength = math.floor(navalUnit:GetBaseCombatStrength() * 25 / 100)
					if city:GetNumBuilding(buildingDidoCarthageID) ~= unitStrength then
						city:SetNumRealBuilding(buildingDidoCarthageID, unitStrength)
					end
				else
					if city:IsHasBuilding(buildingDidoCarthageID) then
						city:SetNumRealBuilding(buildingDidoCarthageID, 0)
					end
				end
			else
				if city:IsHasBuilding(buildingDidoCarthageID) then
					city:SetNumRealBuilding(buildingDidoCarthageID, 0)
				end
			end
		end
	end
end

if JFD_IsCivilisationActive(civilisationDidoID) then
	GameEvents.PlayerCityFounded.Add(JFD_DidoWaterClaims)
	GameEvents.PlayerDoTurn.Add(JFD_NavalDefense) 
	GameEvents.UnitSetXY.Add(JFD_NavalDefense)
	Events.SerialEventUnitCreated.Add(JFD_NavalDefense)
end
--==========================================================================================================================
-- CORE HANNIBAL FUNCTIONS
--==========================================================================================================================
-- JFD_MilitaryGarrisonProduction
----------------------------------------------------------------------------------------------------------------------------	
local buildingHanibalCarthageID = GameInfoTypes["BUILDING_JFD_HANNIBAL_CARTHAGE"]

function JFD_MilitaryGarrisonProduction(playerID)
	local player = Players[playerID]
	if player:IsEverAlive() and player:GetCivilizationType() == civilisationHannibalID then
		if Teams[player:GetTeam()]:GetAtWarCount(true) == 0 then
			for city in player:Cities() do
				if city then
					local unit = city:GetGarrisonedUnit()
					if unit then
						local unitStrength = math.min(unit:GetBaseCombatStrength(), 50)
						if city:GetNumBuilding(buildingHanibalCarthageID) ~= unitStrength then
							city:SetNumRealBuilding(buildingHanibalCarthageID, unitStrength)
						end
					else
						if city:IsHasBuilding(buildingHanibalCarthageID) then
							city:SetNumRealBuilding(buildingHanibalCarthageID, 0)
						end
					end
				end
			end
		else
			for city in player:Cities() do
				if city and city:IsHasBuilding(buildingHanibalCarthageID) then
					city:SetNumRealBuilding(buildingHanibalCarthageID, 0)
				end
			end
		end
	end
end

function JFD_MilitaryGarrisonProductionWar(teamOne, teamTwo, war)
	for playerID = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
		JFD_MilitaryGarrisonProduction(playerID)
	end
end

if JFD_IsCivilisationActive(civilisationHannibalID) then
	GameEvents.PlayerDoTurn.Add(JFD_MilitaryGarrisonProduction)
	GameEvents.UnitSetXY.Add(JFD_MilitaryGarrisonProduction)
	Events.SerialEventUnitCreated.Add(JFD_MilitaryGarrisonProduction)
	Events.WarStateChanged.Add(JFD_MilitaryGarrisonProductionWar)
end
----------------------------------------------------------------------------------------------------------------------------
-- JFD_ShophetGreatAdmiral
----------------------------------------------------------------------------------------------------------------------------	
local promotionShophetGeneralID = GameInfoTypes["PROMOTION_JFD_SHOPHET_GENERAL"]
local promotionShophetAmdiralID = GameInfoTypes["PROMOTION_JFD_SHOPHET_ADMIRAL"]
local promotionGreatGeneralID = GameInfoTypes["PROMOTION_GREAT_GENERAL"]
local promotionGreatAdmiralID = GameInfoTypes["PROMOTION_GREAT_ADMIRAL"]
local promotionShophetID = GameInfoTypes["PROMOTION_JFD_SHOPHET"]
local unitGreatAdmiralID = GameInfoTypes["UNIT_GREAT_ADMIRAL"]
local unitShophetID = GameInfoTypes["UNIT_JFD_SHOPHET"]

function JFD_ShophetGreatAdmiral(playerID, unitID, unitX, unitY)
	local player = Players[playerID]
	if player:IsEverAlive() then
		local unit = player:GetUnitByID(unitID)
		if unit then
			local plot = Map.GetPlot(unitX, unitY)
			if plot then
				if unit:IsHasPromotion(promotionShophetGeneralID) then
					if plot:IsWater() then
						local newShophet = player:InitUnit(unitGreatAdmiralID, unitX, unitY)
						unit:SetEmbarked(false)
						newShophet:Convert(unit, false)
						newShophet:SetHasPromotion(promotionShophetGeneralID, false)
						newShophet:SetHasPromotion(promotionGreatGeneralID, false)
						newShophet:SetHasPromotion(promotionShophetID, false)
						newShophet:SetHasPromotion(promotionShophetAmdiralID, true)
					end
				elseif unit:IsHasPromotion(promotionShophetAmdiralID) then
					if not plot:IsWater() then
						local newShophet = player:InitUnit(unitShophetID, unitX, unitY)
						newShophet:Convert(unit, false)
						newShophet:SetHasPromotion(promotionShophetAmdiralID, false)
						newShophet:SetHasPromotion(promotionGreatAdmiralID, false)
						newShophet:SetHasPromotion(promotionShophetGeneralID, true)
						newShophet:SetHasPromotion(promotionShophetID, true)
					end
				end
			end			
		end
	end
end
----------------------------------------------------------------------------------------------------------------------------
-- JFD_HannibalAtTheGates
----------------------------------------------------------------------------------------------------------------------------
function JFD_HannibalAtTheGates(playerID)
	local player = Players[playerID]
	if player:IsEverAlive() then
		for unit in player:Units() do
			if unit and unit:IsHasPromotion(promotionShophetID) then
				local unitX = unit:GetX()
				local unitY = unit:GetY()
				for otherPlayerID, otherPlayer in pairs(Players) do
					if otherPlayer:IsEverAlive() and otherPlayerID ~= playerID then
						local otherPlayerTeam = Teams[otherPlayer:GetTeam()]
						if otherPlayerTeam:IsAtWar(player:GetTeam()) then
							for city in otherPlayer:Cities() do
								if city then
									local cityX = city:GetX()
									local cityY = city:GetY()
									local damage = 0
									if Map.PlotDistance(unitX, unitY, cityX, cityY) < 2 then
										damage = 30
									elseif Map.PlotDistance(unitX, unitY, cityX, cityY) < 3 then
										damage = 15
									end
									if damage > 0 then
										if player:IsHuman() or otherPlayer:IsHuman() then
											Events.AddPopupTextEvent(HexToWorld(ToHexFromGrid(Vector2(cityX, cityY))), Locale.ConvertTextKey("[COLOR_NEGATIVE_TEXT]-{1_Num} Hannibal ante Portas[ENDCOLOR]", damage))
										end
										city:ChangeDamage(damage)
									end
								end
							end
						end
					end
				end
			end
		end
	end
end	
----------------------------------------------------------------------------------------------------------------------------
-- JFD_ShophetHealOnDefeat
----------------------------------------------------------------------------------------------------------------------------
local promotionShophetHealID = GameInfoTypes["PROMOTION_JFD_SHOPHET_HEAL"]

function JFD_ShophetHealOnDefeat(playerID)
	local player = Players[playerID]
	if player:IsEverAlive() then
		--could cause desyncs
		for unit in player:Units() do
			if unit and unit:GetCombatLimit() > 0 then
				local shophetNearby = false
				for shophet in player:Units() do
					if shophet and shophet:IsHasPromotion(promotionShophetID) then
						if shophet:IsHasPromotion(promotionShophetGeneralID) and unit:GetDomainType() == DomainTypes.DOMAIN_LAND then
							shophetNearby = Map.PlotDistance(unit:GetX(), unit:GetY(), shophet:GetX(), shophet:GetY()) < 3
						end
					end
				end
				if shophetNearby then
					if not unit:IsHasPromotion(promotionShophetHealID) then
						unit:SetHasPromotion(promotionShophetHealID, true)
					end
				else
					if unit:IsHasPromotion(promotionShophetHealID) then
						unit:SetHasPromotion(promotionShophetHealID, false)
					end
				end
			end
		end
	end
end

function JFD_ShophetInitialTrigger(playerID, unitID)
	local player = Players[playerID]
	local unit = player:GetUnitByID(unitID)
	if unit and unit:IsHasPromotion(promotionShophetID) then
		GameEvents.UnitSetXY.Add(JFD_ShophetGreatAdmiral)
		GameEvents.PlayerDoTurn.Add(JFD_HannibalAtTheGates)
		GameEvents.PlayerDoTurn.Add(JFD_ShophetHealOnDefeat)
		GameEvents.UnitSetXY.Add(JFD_ShophetHealOnDefeat) 
		Events.SerialEventUnitCreated.Add(JFD_ShophetHealOnDefeat) 
		Events.SerialEventUnitCreated.Remove(JFD_ShophetInitialTrigger)
		save("GAME", "JFD_ShophetInitalised", true)
		JFD_ShophetHealOnDefeat(playerID)
	end
end

if load("GAME", "JFD_ShophetInitalised") then
	GameEvents.UnitSetXY.Add(JFD_ShophetGreatAdmiral)
	GameEvents.PlayerDoTurn.Add(JFD_HannibalAtTheGates)
	GameEvents.PlayerDoTurn.Add(JFD_ShophetHealOnDefeat)
	GameEvents.UnitSetXY.Add(JFD_ShophetHealOnDefeat)
	Events.SerialEventUnitCreated.Add(JFD_ShophetHealOnDefeat) 
else
	Events.SerialEventUnitCreated.Add(JFD_ShophetInitialTrigger)
end
--==========================================================================================================================
--==========================================================================================================================