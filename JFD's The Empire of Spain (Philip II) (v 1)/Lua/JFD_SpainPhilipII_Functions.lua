-- JFD_SpainPhilipII_Functions
-- Author: JFD
-- Edited By: F0S
--==========================================================================================================================
-- INCLUDES
--==========================================================================================================================
include("FLuaVector.lua")
include("PlotIterators")
include("UniqueDiplomacyUtilsV2.lua")
--==========================================================================================================================
-- UTILITIES
--==========================================================================================================================
-- GLOBALS
----------------------------------------------------------------------------------------------------------------------------
local civilisationID = GameInfoTypes["CIVILIZATION_SPAIN"]

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
-- UNIQUE FUNCTIONS
--==========================================================================================================================
-- GLOBAL
----------------------------------------------------------------------------------------------------------------------------
local activePlayerID = Game.GetActivePlayer()
local activePlayer = Players[activePlayerID]
----------------------------------------------------------------------------------------------------------------------------
-- DIPLOMACY
----------------------------------------------------------------------------------------------------------------------------
local leaderCharlesVID = GameInfoTypes["LEADER_JFD_CHARLES_V"]
local leaderElizabethID = GameInfoTypes["LEADER_ELIZABETH"]
local leaderIsabellaID = GameInfoTypes["LEADER_ISABELLA"]
local leaderWilliamID = GameInfoTypes["LEADER_WILLIAM"]

function JFD_SpainPhilipII_UniqueResponses()
	-- If the player is JFD's Charles V.
	if leaderCharlesVID and activePlayer:GetLeaderType() == leaderCharlesVID then
		ChangeDiplomacyResponse("LEADER_JFD_PHILIP_II",	"RESPONSE_FIRST_GREETING",	"TXT_KEY_LEADER_JFD_PHILIP_II_FIRSTGREETING%", 	"TXT_KEY_LEADER_JFD_PHILIP_II_CHARLES_V_GREETING_1",	500)
		ChangeDiplomacyResponse("LEADER_JFD_PHILIP_II",	"RESPONSE_DEFEATED,",		"TXT_KEY_LEADER_JFD_PHILIP_II_DEFEATED%", 	 	"TXT_KEY_LEADER_JFD_PHILIP_II_CHARLES_V_DEFEATED_1",	500)
	-- If the player is Elizabeth.
	elseif leaderElizabethID and activePlayer:GetLeaderType() == leaderElizabethID then
		ChangeDiplomacyResponse("LEADER_JFD_PHILIP_II",	"RESPONSE_FIRST_GREETING",	"TXT_KEY_LEADER_JFD_PHILIP_II_FIRSTGREETING%", 	"TXT_KEY_LEADER_JFD_PHILIP_II_ELIZABETH_GREETING_1",	500)
		ChangeDiplomacyResponse("LEADER_JFD_PHILIP_II",	"RESPONSE_DEFEATED,",		"TXT_KEY_LEADER_JFD_PHILIP_II_DEFEATED%", 	 	"TXT_KEY_LEADER_JFD_PHILIP_II_ELIZABETH_DEFEATED_1",	500)
	-- If the player is Isabella.
	elseif leaderIsabellaID and activePlayer:GetLeaderType() == leaderIsabellaID then
		ChangeDiplomacyResponse("LEADER_JFD_PHILIP_II",	"RESPONSE_FIRST_GREETING",	"TXT_KEY_LEADER_JFD_PHILIP_II_FIRSTGREETING%", 	"TXT_KEY_LEADER_JFD_PHILIP_II_ISABELLA_GREETING_1",		500)
		ChangeDiplomacyResponse("LEADER_JFD_PHILIP_II",	"RESPONSE_DEFEATED,",		"TXT_KEY_LEADER_JFD_PHILIP_II_DEFEATED%", 	 	"TXT_KEY_LEADER_JFD_PHILIP_II_ISABELLA_DEFEATED_1",		500)
	-- If the player is William I.
	elseif leaderWilliamID and activePlayer:GetLeaderType() == leaderWilliamID then
		ChangeDiplomacyResponse("LEADER_JFD_PHILIP_II",	"RESPONSE_FIRST_GREETING",	"TXT_KEY_LEADER_JFD_PHILIP_II_FIRSTGREETING%", 	"TXT_KEY_LEADER_JFD_PHILIP_II_WILLIAM_GREETING_1",		500)
		ChangeDiplomacyResponse("LEADER_JFD_PHILIP_II",	"RESPONSE_DEFEATED,",		"TXT_KEY_LEADER_JFD_PHILIP_II_DEFEATED%", 	 	"TXT_KEY_LEADER_JFD_PHILIP_II_WILLIAM_DEFEATED_1",		500)
	end
end

for playerID = 0, GameDefines.MAX_MAJOR_CIVS - 1, 1 do
	local player = Players[playerID]
	if player and player:IsEverAlive() and not player:IsHuman() and player:GetCivilizationType() == civilisationID then
		Events.SequenceGameInitComplete.Add(JFD_SpainPhilipII_UniqueResponses)
		break
	end
end
----------------------------------------------------------------------------------------------------------------------------
-- PLUS ULTRA
----------------------------------------------------------------------------------------------------------------------------
local buildingSpainPhilipII	= GameInfoTypes["BUILDING_JFD_SPAIN_PHILIP_II"]

function JFD_SpainPhilipII_SunNeverSets(player, isTurn)
	if player:IsEverAlive() and player:GetCivilizationType() == civilisationID then
		local isGoldenAge = player:IsGoldenAge()
		for city in player:Cities() do
			if isGoldenAge then
				if not city:IsHasBuilding(buildingSpainPhilipII) then
					city:SetNumRealBuilding(buildingSpainPhilipII, 1)
				end
			else
				if city:IsHasBuilding(buildingSpainPhilipII) then
					city:SetNumRealBuilding(buildingSpainPhilipII, 0)
				end
			end
		end
		if isGoldenAge and isTurn then 
			for unit in player:Units() do
				if unit:GetUnitCombatType() == -1 then
					unit:ChangeMoves(120)
				end
			end
		end
	end
end

function JFD_SpainPhilipII_SunNeverSets_DoTurn(playerID)
	local player = Players[playerID]
	JFD_SpainPhilipII_SunNeverSets(player, true)
end

function JFD_SpainPhilipII_SunNeverSets_Dirty()
	local playerID = Game.GetActivePlayer()
    local player = Players[playerID]
	if player:IsTurnActive() then
        JFD_SpainPhilipII_SunNeverSets(player, false)
    end
end

function JFD_SpainPhilipII_SunNeverSets_CityFounded(playerID, plotX, plotY)
	local player = Players[playerID]
	if player:IsEverAlive() and player:GetCivilizationType() == civilisationID then
		local plot = Map.GetPlot(plotX, plotY)
		local city = plot:GetPlotCity()
		if city and player:IsGoldenAge() then
			for adjacentPlot in PlotAreaSweepIterator(plot, 2, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
				if adjacentPlot:GetOwner() == -1 then
					adjacentPlot:SetOwner(playerID, city:GetID())
					adjacentPlot:SetRevealed(player:GetTeam(), true)
					adjacentPlot:UpdateFog()
				end
			end
		end
		local religionID = player:GetReligionCreatedByPlayer()
		if religionID <= 0 then religionID = player:GetCapitalCity():GetReligiousMajority() end
		if religionID <= 0 then return end
		for religion in GameInfo.Religions("ID <> '" .. religionID .. "'") do
			city:ConvertPercentFollowers(religionID, religion.ID, 100)
		end
		city:AdoptReligionFully(religionID)
		city:ConvertPercentFollowers(religionID, -1, 100)
	end
end
----------------------------------------------------------------------------------------------------------------------------
-- SEMINARY
----------------------------------------------------------------------------------------------------------------------------
local buildingSeminaryID = GameInfoTypes["BUILDING_JFD_SEMINARY"]
local promotionSeminaryID = GameInfoTypes["PROMOTION_JFD_SEMINARY"]
local unitMissionaryID = GameInfoTypes["UNIT_MISSIONARY"]

function JFD_SpainPhilipII_Seminary_UnitTrained(playerID, cityID, unitID)
	local player = Players[playerID]
	if player:IsEverAlive() and player:GetCivilizationType() == civilisationID then
		local city = player:GetCityByID(cityID)
		if city and city:IsHasBuilding(buildingSeminaryID) then
			local unit = player:GetUnitByID(unitID)
			if unit and unit:GetUnitType() == unitMissionaryID then
				unit:SetHasPromotion(promotionSeminaryID, true)
			end
		end
	end
end

function JFD_SpainPhilipII_Seminary(playerID, unitID, unitType, plotX, plotY, isDelay, otherPlayerID)
	local player = Players[playerID]
	if isDelay then return end
	if player:IsEverAlive() and playerID ~= otherPlayerID then
		local capital = player:GetCapitalCity() 
		if capital then
			local unit = player:GetUnitByID(unitID)
			if unit:GetUnitType() == unitMissionaryID and unit:IsHasPromotion(promotionSeminaryID) then
				if unit:GetSpreadsLeft() > 1 then return end
				local goldenAgeReward = player:GetTotalFaithPerTurn()*3
				if not player:IsGoldenAge() then
					player:ChangeGoldenAgeProgressMeter(goldenAgeReward)
					if player:IsHuman() and player:IsTurnActive() then
						local hex = ToHexFromGrid(Vector2(plotX, plotY))
						Events.AddPopupTextEvent(HexToWorld(hex), Locale.ConvertTextKey("[COLOR_POSITIVE_TEXT]+{1_Num}[ENDCOLOR][ICON_GOLDEN_AGE]", goldenAgeReward), 1)
						Events.GameplayFX(hex.x, hex.y, -1)
					end
				end
			end
		end
	end
end

if JFD_IsCivilisationActive(civilisationID) then
	GameEvents.PlayerDoTurn.Add(JFD_SpainPhilipII_SunNeverSets_DoTurn)
	Events.SerialEventCityInfoDirty.Add(JFD_SpainPhilipII_SunNeverSets_Dirty)
	GameEvents.PlayerCityFounded.Add(JFD_SpainPhilipII_SunNeverSets_CityFounded)
	GameEvents.CityTrained.Add(JFD_SpainPhilipII_Seminary_UnitTrained)
	GameEvents.UnitPrekill.Add(JFD_SpainPhilipII_Seminary)
end
--==========================================================================================================================
--==========================================================================================================================