-- JFD_IcelandFunctions
-- Author: JFD
-- Heavily Edited By: F0S
--=======================================================================================================================
-- UTILITY FUNCTIONS	
--=======================================================================================================================
WARN_NOT_SHARED = false; include( "Sukritact_SaveUtils.lua" ); MY_MOD_NAME = "JFD_IcelandFunctions";
include("FLuaVector.lua")
------------------------------------------------------------------------------------------------------------------------
-- JFD_GetCityWithWonder
------------------------------------------------------------------------------------------------------------------------
function JFD_GetCityWithWonder(playerID, buildingID)
	local player = Players[playerID]
	local cityWithBuilding
	for city in player:Cities() do
		if city:IsHasBuilding(buildingID) then
			cityWithBuilding = city
		end
	end
	return cityWithBuilding or player:GetCapitalCity()
end

function JFD_GetRandom(lower, upper)
	return Game.Rand((upper + 1) - lower, "") + lower
end
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

function sDecompilePlotID(sKey)
    iBreak = string.find(sKey, "Y")
    iX = tonumber(string.sub(sKey, 1, iBreak - 1))
    iY = tonumber(string.sub(sKey, iBreak + 1))
    pPlot = Map.GetPlot(iX, iY)
    return pPlot
end

function sCompilePlotID(pPlot)
    iX = pPlot:GetX()
    iY = pPlot:GetY()
    return(iX .. "Y" .. iY)
end
--=======================================================================================================================
-- CORE FUNCTIONS	
--=======================================================================================================================
-- Globals
--------------------------------------------------------------------------------------------------------------------------
local buildingIcelandHappinessID = GameInfoTypes["BUILDING_JFD_ICELAND_HAPPINESS"]
local buildingThingsteadID = GameInfoTypes["BUILDING_JFD_THINGSTEAD"]
local buildingWritersGuildID = GameInfoTypes["BUILDING_WRITERS_GUILD"]
local buildingclassSkald = GameInfoTypes["BUILDINGCLASS_JFD_ICELAND"]
local civilisationID = GameInfoTypes["CIVILIZATION_JFD_ICELAND"]
local isIcelandCivActive = JFD_IsCivilisationActive(civilisationID)
local specialistWriterID = GameInfoTypes["SPECIALIST_WRITER"]
local unitSkaldID = GameInfoTypes["UNIT_JFD_SKALD"]
local unitPromotionSkaldID = GameInfoTypes["PROMOTION_JFD_SKALD"]
local unitWorkerID = GameInfoTypes["UNIT_WORKER"]
local cityPlots = {}
------------------------------------------------------------------------------------------------------------------------
-- JFD_IcelandicGreatWorks
------------------------------------------------------------------------------------------------------------------------
function JFD_IcelandicGreatWorks(playerID, unitID, unitTypeID, unitX, unitY)
	local player = Players[playerID]
	local plot = Map.GetPlot(unitX, unitY)
	if unitTypeID == unitSkaldID then
		if plot:GetPlotCity() then
			local city = plot:GetPlotCity()
			local sKey = sCompilePlotID(plot)
			if cityPlots[sKey] ~= 1 then
				local bKey = "BUILDING_JFD_ICELAND_GREAT_WORK_SKALD_0"
				for row in GameInfo.Unit_UniqueNames() do
					if row.UniqueName == player:GetUnitByID(unitID):GetNameNoDesc() then
						thisGW = row.GreatWorkType
						bKey = "BUILDING_JFD_ICELAND_" .. thisGW
						break
					end
				end
				city:SetNumRealBuilding(GameInfoTypes[bKey], 1)
				player:InitUnit(unitWorkerID, unitX, unitY, UNITAI_WORKER)
				local sKey = sCompilePlotID(plot)
				cityPlots[sKey] = 1
			end
		end
	elseif unitTypeID == GameInfoTypes["UNIT_SETTLER"] then
		if plot:GetPlotCity() then
			local sKey = sCompilePlotID(plot)
			cityPlots[sKey] = 1
		end
	end
end

function JFD_IcelandicGreatWorksTurn(playerID)
	for sKey, tTable in pairs(cityPlots) do
		local pPlot = sDecompilePlotID(sKey)
		if not pPlot:GetPlotCity() then
			cityPlots[sKey] = nil
		end
	end
end

function JFD_IcelandicGreatWorksInitialTrigger(iPlayer, iUnit)
	local pPlayer = Players[iPlayer]
	local pUnit = pPlayer:GetUnitByID(iUnit)
	if pUnit and pUnit:GetUnitType() == unitSkaldID then
		GameEvents.UnitPrekill.Add(JFD_IcelandicGreatWorks)
		GameEvents.PlayerDoTurn.Add(JFD_IcelandicGreatWorksTurn)
		Events.SerialEventUnitCreated.Remove(JFD_IcelandicGreatWorksInitialTrigger)
		save("GAME", "JFD_IcelandicGreatWorksInitalised", true)
		for iPlot = 0, Map.GetNumPlots() - 1, 1 do
		    local pPlot = Map.GetPlotByIndex(iPlot)
			if pPlot:GetPlotCity() then
				local sKey = sCompilePlotID(pPlot)
				cityPlots[sKey] = 1
		    end
		end
	end
end

if load("GAME", "JFD_IcelandicGreatWorksInitalised") then
	GameEvents.UnitPrekill.Add(JFD_IcelandicGreatWorks)
	GameEvents.PlayerDoTurn.Add(JFD_IcelandicGreatWorksTurn)
	for iPlot = 0, Map.GetNumPlots() - 1, 1 do
	    local pPlot = Map.GetPlotByIndex(iPlot)
		if pPlot:GetPlotCity() then
			local sKey = sCompilePlotID(pPlot)
			cityPlots[sKey] = 1
	    end
	end
else
	Events.SerialEventUnitCreated.Add(JFD_IcelandicGreatWorksInitialTrigger)
end
------------------------------------------------------------------------------------------------------------------------
-- JFD_GreatWriterFromNavalBattle
------------------------------------------------------------------------------------------------------------------------
function JFD_GreatWriterFromNavalBattle(killerID, killedID, killedUnitType)
	local player = Players[killerID]
	if player:IsEverAlive() and player:GetCivilizationType() == civilisationID then
		local unitCombatClass = GameInfo.Units[killedUnitType].CombatClass
		if unitCombatClass == "UNITCOMBAT_NAVALRANGED" or unitCombatClass == "UNITCOMBAT_NAVALMELEE" or GameInfo.Units[killedUnitType].CombatClass == "UNITCOMBAT_SUBMARINE" or GameInfo.Units[killedUnitType].CombatClass == "UNITCOMBAT_CARRIER" then	
			local reward = math.floor(GameInfo.Units[killedUnitType].Combat)
			local writersGuildCity = JFD_GetCityWithWonder(killerID, buildingWritersGuildID)
			writersGuildCity:ChangeSpecialistGreatPersonProgressTimes100(specialistWriterID, reward*100)
			if player:IsHuman() and player:IsTurnActive() and writersGuildCity then
				local hex = ToHexFromGrid(Vector2(writersGuildCity:GetX(), writersGuildCity:GetY()))
				Events.AddPopupTextEvent(HexToWorld(hex), Locale.ConvertTextKey("[COLOR_POSITIVE_TEXT]+{1_Num}[ENDCOLOR] [ICON_GREAT_WRITER]", reward), 1)
				Events.GameplayFX(hex.x, hex.y, -1)
			end
		end
	end
end
------------------------------------------------------------------------------------------------------------------------
-- JFD_GreatWriterFromCivilizations
------------------------------------------------------------------------------------------------------------------------
-- Disabled for balance purposes
--[[
function JFD_GreatWriterFromCivilizations(playerMetID, playerID)
	local player = Players[playerID]
	if player:IsEverAlive() and player:GetCivilizationType() == civilisationID then
        local playerMet = Players[playerMetID]
		local majorsMet = Teams[playerMet:GetTeam()]:GetHasMetCivCount(true)
		local speedMod = ((GameInfo.GameSpeeds[Game.GetGameSpeedType()].BuildPercent)/100)
		local reward = 0
		if playerMet:IsMinorCiv() then reward = 15 else reward = 30 end
        if majorsMet == 1 then reward = reward * 2 end
		reward = math.floor(reward * speedMod)
		if player:IsHuman()  =and player:IsTurnActive() and reward > 0 then
			local title = "Age of Settlement"
			local descr = Locale.ConvertTextKey("You receive {1_Num} [ICON_GREAT_PEOPLE] [COLOR_POSITIVE_TEXT]Great Writer[ENDCOLOR] points from meeting {2_CivName}.", reward, playerMet:GetName())
			player:AddNotification(NotificationTypes.NOTIFICATION_GENERIC, descr, title, -1, -1)
        end
		local writersGuildCity = JFD_GetCityWithWonder(playerID, buildingWritersGuildID)
		writersGuildCity:ChangeSpecialistGreatPersonProgressTimes100(specialistWriterID, reward*100)
	end
end
--]]
------------------------------------------------------------------------------------------------------------------------
-- JFD_SkaldicMovement
------------------------------------------------------------------------------------------------------------------------
function JFD_SkaldicMovement(playerID)
    local player = Players[playerID]
	if player:IsEverAlive() then    
		for unit in player:Units() do
			if unit:IsHasPromotion(unitPromotionSkaldID) then
				if unit:IsEmbarked() then
					local movementChange = math.floor(unit:GetMoves())
					unit:ChangeMoves(movementChange)
				end
			end
		end
	end
end
------------------------------------------------------------------------------------------------------------------------
-- JFD_ThingsteadHappiness
------------------------------------------------------------------------------------------------------------------------
function JFD_ThingsteadHappiness(playerID)
	local player = Players[playerID]
	if player:IsEverAlive() then
	     for city in player:Cities() do
			if city:IsHasBuilding(buildingThingsteadID) and (player:IsCapitalConnectedToCity(city) or city:IsCapital()) then
				if not city:IsHasBuilding(buildingIcelandHappinessID) then
					city:SetNumRealBuilding(buildingIcelandHappinessID, 1)
				end
			else
				if city:IsHasBuilding(buildingIcelandHappinessID) then
					city:SetNumRealBuilding(buildingIcelandHappinessID, 0)
				end
			end
		end
	end
end

function JFD_ThingsteadHappinessDirty()
	local playerID = Game.GetActivePlayer()
    local player = Players[playerID]
	if player:IsTurnActive() then
        JFD_ThingsteadHappiness(playerID)
    end
end

function JFD_ThingsteadHappinessPolicyTrigger(playerID, policyID)
    local player = Players[playerID]
    if player:GetCivilizationType() == civilisationID and policyID == GameInfoTypes["POLICY_LEGALISM"] then
		GameEvents.PlayerDoTurn.Add(JFD_ThingsteadHappiness)
		Events.SerialEventGameDataDirty.Add(JFD_ThingsteadHappinessDirty)
		GameEvents.PlayerAdoptPolicy.Add(JFD_ThingsteadHappiness)
		GameEvents.PlayerAdoptPolicy.Remove(JFD_ThingsteadHappinessPolicyTrigger)
		GameEvents.CityConstructed.Remove(JFD_ThingsteadHappinessInitialTrigger)
		save("GAME", "JFD_ThingsteadHappinessInitalised", true)
		JFD_ThingsteadHappiness(playerID)
    end
end

function JFD_ThingsteadHappinessInitialTrigger(playerID, cityID, buildingID)
	local player = Players[playerID]
	if player:GetCityByID(cityID):IsHasBuilding(buildingThingsteadID) then
		GameEvents.PlayerDoTurn.Add(JFD_ThingsteadHappiness)
		Events.SerialEventGameDataDirty.Add(JFD_ThingsteadHappinessDirty)
		GameEvents.PlayerAdoptPolicy.Add(JFD_ThingsteadHappiness)
		GameEvents.PlayerAdoptPolicy.Remove(JFD_ThingsteadHappinessPolicyTrigger)
		GameEvents.CityConstructed.Remove(JFD_ThingsteadHappinessInitialTrigger)
		save("GAME", "JFD_ThingsteadHappinessInitalised", true)
		JFD_ThingsteadHappiness(playerID)
	end
end

if isIcelandCivActive then
	GameEvents.UnitKilledInCombat.Add(JFD_GreatWriterFromNavalBattle)
	--GameEvents.TeamMeet.Add(JFD_GreatWriterFromCivilizations)
	GameEvents.PlayerDoTurn.Add(JFD_SkaldicMovement)
	if load("GAME", "JFD_ThingsteadHappinessInitalised") then
		GameEvents.PlayerDoTurn.Add(JFD_ThingsteadHappiness)
		Events.SerialEventGameDataDirty.Add(JFD_ThingsteadHappinessDirty)
		GameEvents.PlayerAdoptPolicy.Add(JFD_ThingsteadHappiness)
	else
		GameEvents.PlayerAdoptPolicy.Add(JFD_ThingsteadHappinessPolicyTrigger)
		GameEvents.CityConstructed.Add(JFD_ThingsteadHappinessInitialTrigger)
	end
end
--==========================================================================================================================
--==========================================================================================================================