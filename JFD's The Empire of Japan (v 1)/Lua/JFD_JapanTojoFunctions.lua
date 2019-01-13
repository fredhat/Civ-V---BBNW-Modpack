-- JFD_AmericaRooseveltFunctions
-- Author: JFD
-- Heavily Edited By: F0S
--==========================================================================================================================
-- UTILITY FUNCTIONS
--==========================================================================================================================
-- JFD_IsCivilisationActive
--------------------------------------------------------------
include("FLuaVector.lua")

local civilisationTojoID = GameInfoTypes["CIVILIZATION_JFD_JAPAN_TOJO"]
local civilisationNobunagaID = GameInfoTypes["CIVILIZATION_JAPAN"]
local terrainCoastID = GameInfoTypes["TERRAIN_COAST"]
local terrainOceanID = GameInfoTypes["TERRAIN_OCEAN"]
local techBuffer = 0

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
-- CORE TOJO FUNCTIONS
--==========================================================================================================================
--JFD_TojoNavalScienceFromKills
----------------------------------------------------------------------------------------------------------------------------
function JFD_TojoNavalScienceFromKills(killerID, killedID, killedUnitType)
	local player = Players[killerID]
	if player:IsEverAlive() and player:GetCivilizationType() == civilisationTojoID then
		local unitCombatClass = GameInfo.Units[killedUnitType].CombatClass
		if unitCombatClass == "UNITCOMBAT_NAVALRANGED" or unitCombatClass == "UNITCOMBAT_NAVALMELEE" or unitCombatClass == "UNITCOMBAT_SUBMARINE" or unitCombatClass == "UNITCOMBAT_CARRIER" then
			local scienceBoost = math.floor(GameInfo.Units[killedUnitType].Combat)
			local researchID = player:GetCurrentResearch()
			if researchID > 0 then
				local teamTechs = Teams[player:GetTeam()]:GetTeamTechs()
				teamTechs:ChangeResearchProgress(researchID, scienceBoost, killerID)
				local capital = player:GetCapitalCity()
				if player:IsHuman() and player:IsTurnActive() and capital then
					local hex = ToHexFromGrid(Vector2(capital:GetX(), capital:GetY()))
					Events.AddPopupTextEvent(HexToWorld(hex), Locale.ConvertTextKey("[COLOR_RESEARCH_RATE]+{1_Num}[ENDCOLOR] [ICON_RESEARCH]", scienceBoost), 1)
					Events.GameplayFX(hex.x, hex.y, -1)
				end
			else
				techBuffer = techBuffer + scienceBoost
			end
		end
	end
end
-------------------------------------------------------------------------------------------------------------------------
--JFD_TojoWaterTileScience
-------------------------------------------------------------------------------------------------------------------------
function JFD_TojoWaterTileScience(hexX, hexY)
	local plot = Map.GetPlot(ToGridFromHex(hexX, hexY))
	if plot then
		local playerID = plot:GetOwner()
		if playerID > -1 then
			local player = Players[playerID]
			if player:IsEverAlive() and player:GetCivilizationType() == civilisationTojoID then
				if plot:GetTerrainType() == terrainCoastID or plot:GetTerrainType() == terrainOceanID then
					local scienceBoost = math.floor(player:GetScience() / 2)
					local researchID = player:GetCurrentResearch()
					if researchID > 0 then
						local teamTechs = Teams[player:GetTeam()]:GetTeamTechs()
						teamTechs:ChangeResearchProgress(researchID, scienceBoost, playerID)
						if player:IsHuman() and player:IsTurnActive() then
							local hex = ToHexFromGrid(Vector2(plot:GetX(), plot:GetY()))
							Events.AddPopupTextEvent(HexToWorld(hex), Locale.ConvertTextKey("[COLOR_RESEARCH_RATE]+{1_Num}[ENDCOLOR][ICON_RESEARCH]", scienceBoost), 1)
							Events.GameplayFX(hex.x, hex.y, -1)
						end
					else
						techBuffer = techBuffer + scienceBoost
					end
				end
			end
		end
	end
end
----------------------------------------------------------------------------------------------------------------------------
-- JFD_TojoBufferScienceTurn
----------------------------------------------------------------------------------------------------------------------------
function JFD_TojoBufferScienceTurn(playerID)
	local player = Players[playerID]
	if player:IsEverAlive() and player:GetCivilizationType() == civilisationTojoID then
		if techBuffer > 0 then
			local researchID = player:GetCurrentResearch()
			if researchID > 0 then
				local teamTechs = Teams[player:GetTeam()]:GetTeamTechs()
				teamTechs:ChangeResearchProgress(researchID, techBuffer, playerID)
				local capital = player:GetCapitalCity()
				if player:IsHuman() and player:IsTurnActive() and capital then
					local hex = ToHexFromGrid(Vector2(capital:GetX(), capital:GetY()))
					Events.AddPopupTextEvent(HexToWorld(hex), Locale.ConvertTextKey("[COLOR_RESEARCH_RATE]+{1_Num}[ENDCOLOR] [ICON_RESEARCH]", techBuffer), 1)
					Events.GameplayFX(hex.x, hex.y, -1)
				end
				techBuffer = 0
			end
		end
	end
end
----------------------------------------------------------------------------------------------------------------------------
-- JFD_TojoNavalPuppets
----------------------------------------------------------------------------------------------------------------------------
local buildingTojoPuppetID = GameInfoTypes["BUILDING_JFD_TOJO_PUPPET_DUMMY"]

function JFD_TojoNavalPuppets(playerID)
	local player = Players[playerID]
	if player:IsEverAlive() and player:GetCivilizationType() == civilisationTojoID then
		for city in player:Cities() do
			local inCity = false
			local plot = Map.GetPlot(city:GetX(), city:GetY()) 
			for i = 0, plot:GetNumUnits() - 1 do
				local unit = plot:GetUnit(i)
				if unit then
					local unitCombatClass = unit:GetUnitCombatType()
					if unitCombatClass == "UNITCOMBAT_NAVALRANGED" or unitCombatClass == "UNITCOMBAT_NAVALMELEE" or unitCombatClass == "UNITCOMBAT_SUBMARINE" or unitCombatClass == "UNITCOMBAT_CARRIER" then
						inCity = true
						break
					end
				end
			end
			if inCity then
				if not city:IsHasBuilding(buildingTojoPuppetID) then
					city:SetNumRealBuilding(buildingTojoPuppetID, 1)
				end
			else
				if city:IsHasBuilding(buildingTojoPuppetID) then
					city:SetNumRealBuilding(buildingTojoPuppetID, 0)
				end
			end
		end
	end
end
--------------------------------------------------------------------------------------------------------------------------
--JFD_TojoNavalPuppetsCityCaptured
----------------------------------------------------------------------------------------------------------------------------
function JFD_TojoNavalPuppetsCityCaptured(oldPlayerID, isCapital, plotX, plotY, newPlayerID)
	JFD_TojoNavalPuppets(newPlayerID)
end

if JFD_IsCivilisationActive(civilisationTojoID) then
	GameEvents.UnitKilledInCombat.Add(JFD_TojoNavalScienceFromKills)
	Events.SerialEventHexCultureChanged.Add(JFD_TojoWaterTileScience)
	GameEvents.PlayerDoTurn.Add(JFD_TojoBufferScienceTurn)
	GameEvents.PlayerDoTurn.Add(JFD_TojoNavalPuppets)
	GameEvents.UnitSetXY.Add(JFD_TojoNavalPuppets)
	GameEvents.PlayerCityFounded.Add(JFD_TojoNavalPuppets)
	GameEvents.CityCaptureComplete.Add(JFD_TojoNavalPuppetsCityCaptured)
end
--==========================================================================================================================
-- CORE NOBUNAGA FUNCTIONS
--==========================================================================================================================
-- JFD_DojoExperienceFromCulture
----------------------------------------------------------------------------------------------------------------------------
local promotionDojoID = GameInfoTypes["PROMOTION_JFD_DOJO"]
local buildingDojoID = GameInfoTypes["BUILDING_JFD_DOJO"]
local buildingTempleID = GameInfoTypes["BUILDING_TEMPLE"]

function JFD_DojoExperienceFromCulture(playerID, cityID, unitID)
	local player = Players[playerID]
	if player:IsEverAlive() then
		local unit = player:GetUnitByID(unitID)
		if unit and unit:GetCombatLimit() > 0 and unit:GetDomainType() == DomainTypes.DOMAIN_LAND and not unit:IsHasPromotion(promotionDojoID) then
			local city = player:GetCityByID(CityID)
			if city and city:IsHasBuilding(buildingDojoID) then
				local experiencePercent = 0.25
				if city:IsHasBuilding(buildingTempleID) then experiencePercent = 0.50 end
				unit:ChangeExperience(math.ceil(city:GetYieldRate(GameInfoTypes["YIELD_CULTURE"]) * experiencePercent))
				unit:SetHasPromotion(promotionDojoID, true)
			end
		end
	end
end

if JFD_IsCivilisationActive(civilisationNobunagaID) then
	GameEvents.CityTrained.Add(JFD_DojoExperienceFromCulture)
end
--==========================================================================================================================
--==========================================================================================================================