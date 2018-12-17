-- Hungary_Functions
-- Author: JFD
-- Heavily Edited By: F0S
--==========================================================================================================================
-- UTILITY FUNCTIONS
--==========================================================================================================================
WARN_NOT_SHARED = false; include( "Sukritact_SaveUtils.lua" ); MY_MOD_NAME = "JFD_HungaryFunctions";
--------------------------------------------------------------
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
--=======================================================================================================================
-- CORE HUNGARY FUNCTIONS	
--=======================================================================================================================
-- Globals
-------------------------------------------------------------------------------------------------------------------------
local activePlayerID				= Game.GetActivePlayer()
local activePlayer					= Players[activePlayerID]
local buildingVegvarID 				= GameInfoTypes["BUILDING_JFD_VEGVAR"]
local buildingVegvarFaithID 		= GameInfoTypes["BUILDING_JFD_VEGVAR_FAITH"]
local buildingVegvarPressureID 		= GameInfoTypes["BUILDING_JFD_VEGVAR_PRESSURE"]
local buildingHungaryDummyID 		= GameInfoTypes["BUILDING_JFD_HUNGARY_DUMMY"]
local civilisationID 				= GameInfoTypes["CIVILIZATION_JFD_HUNGARY"]
local isHungaryCivActive 			= JFD_IsCivilisationActive(civilisationID)
local isHungaryActivePlayer			= activePlayer:GetCivilizationType() == civilizationID
-------------------------------------------------------------------------------------------------------------------------
-- JFD_FaithtoGoldenAgePoints
-------------------------------------------------------------------------------------------------------------------------
function JFD_FaithtoGoldenAgePoints(player, isTurn)
	local capital = player:GetCapitalCity()
	if capital and capital:GetReligiousMajority() > 0 then
		local religionID = player:GetReligionCreatedByPlayer() or -1
		if religionID < 1 then
			religionID = player:GetCapitalCity():GetReligiousMajority()
		end
		if religionID > 0 then
			local isReligious = true
			for city in player:Cities() do
				if city:GetReligiousMajority() ~= religionID then
					isReligious = false
				end
			end
			if isReligious then
				local goldenAgeBonusPerTurn = math.floor(player:GetTotalFaithPerTurn() / 2)
				if isTurn and not player:IsGoldenAge() then player:ChangeGoldenAgeProgressMeter(goldenAgeBonusPerTurn) end
				capital:SetNumRealBuilding(buildingHungaryDummyID, goldenAgeBonusPerTurn)
			else
				capital:SetNumRealBuilding(buildingHungaryDummyID, 0)
			end
		end
	end
end

function JFD_FaithtoGoldenAgePointsTurn(playerID)
	local player = Players[playerID]
	if player:IsEverAlive() and player:GetCivilizationType() == civilisationID then
		JFD_FaithtoGoldenAgePoints(player, true)
	end
end

function JFD_FaithtoGoldenAgePointsDirty()
	local playerID = Game.GetActivePlayer()
    local player = Players[playerID]
	if player:IsEverAlive() and player:GetCivilizationType() == civilisationID then
		JFD_FaithtoGoldenAgePoints(player, false)
	end
end
-------------------------------------------------------------------------------------------------------------------------
-- UI
-------------------------------------------------------------------------------------------------------------------------
local isCityViewOpen = false

function JFD_UpdateHungaryFaithHurry()
	Controls.MilitaryFaithHurryBox:SetHide(true)
	Controls.MilitaryFaithHurryImage:SetHide(true)
	Controls.MilitaryFaithHurryButton:SetDisabled(true)
	Controls.MilitaryFaithHurryButton:LocalizeAndSetToolTip(nil)
	local city = UI.GetHeadSelectedCity()
	if city then
		local player = Players[city:GetOwner()]
		local religionID = player:GetReligionCreatedByPlayer() or -1
		if religionID < 1 and player:GetCapitalCity() then
			religionID = player:GetCapitalCity():GetReligiousMajority()
		end
		local currentFaith = player:GetFaith() or 0
		local currentProduction = city:GetProductionUnit()
		local currentProductionNeeded = city:GetProductionNeeded()
		local currentProductionTurnsLeft = city:GetProductionTurnsLeft()
		local militaryReserveButtonText = Locale.ConvertTextKey("TXT_KEY_JFD_HUNGARY_FAITH_HURRY", currentFaith)
		local militaryReserveButtonTT = Locale.ConvertTextKey("TXT_KEY_JFD_HUNGARY_FAITH_HURRY_DISABLED_TT")
		if currentProduction == -1 or city:IsResistance() or currentFaith <= 0 or currentProductionTurnsLeft <= 1 or religionID < 1 or city:GetReligiousMajority() ~= religionID then
			Controls.MilitaryFaithHurryButton:SetDisabled(true)
		else
			local currentProductionUnitCombat = GameInfo.Units[currentProduction].Combat
			if currentProductionUnitCombat == 0 then
				Controls.MilitaryFaithHurryButton:SetDisabled(true)
			else
				militaryReserveButtonTT = Locale.ConvertTextKey("TXT_KEY_JFD_HUNGARY_FAITH_HURRY_TT", currentFaith)
				if currentFaith > currentProductionNeeded then
					militaryReserveButtonTT = Locale.ConvertTextKey("TXT_KEY_JFD_HUNGARY_FAITH_HURRY_TT", currentProductionNeeded)
				end
				Controls.MilitaryFaithHurryButton:LocalizeAndSetToolTip(militaryReserveButtonTT)
				Controls.MilitaryFaithHurryButton:SetDisabled(false)
			end
		end
		IconHookup(0, 64, "JFD_HUNGARY_RESERVE_ATLAS", Controls.MilitaryFaithHurryImage)
		Controls.MilitaryFaithHurryBox:SetHide(false)
		Controls.MilitaryFaithHurryImage:SetHide(false)
		Controls.MilitaryFaithHurryButton:SetText(militaryReserveButtonText)
		Controls.MilitaryFaithHurryButton:LocalizeAndSetToolTip(militaryReserveButtonTT)
	end
end

function JFD_HungaryFaithHurrySpent()
	local city = UI.GetHeadSelectedCity()
	if city then
		local player = Players[city:GetOwner()]
		local currentFaith = player:GetFaith() or 0
		local currentProductionNeeded = city:GetProductionNeeded()
		local productionBoost = currentFaith
		if currentFaith > currentProductionNeeded then
			productionBoost = currentProductionNeeded
		end
		player:ChangeFaith(-productionBoost)
		city:ChangeProduction(productionBoost)
		Events.AudioPlay2DSound("AS2D_SELECT_MUSKETMAN")
		JFD_OnEnterCityScreen()
	end
end

function JFD_OnEnterCityScreen()
	isCityViewOpen = true
	JFD_UpdateHungaryFaithHurry()
end

function JFD_OnExitCityScreen()
	isCityViewOpen = false
	JFD_UpdateHungaryFaithHurry()
end

function JFD_OnNextCityScreen()
	if isCityViewOpen then
		JFD_UpdateHungaryFaithHurry()
	end
end

if isHungaryCivActive and isHungaryActivePlayer then
	Controls.MilitaryFaithHurryButton:RegisterCallback(Mouse.eLClick, JFD_HungaryFaithHurrySpent)
	Events.SerialEventEnterCityScreen.Add(JFD_OnEnterCityScreen)
	Events.SerialEventExitCityScreen.Add(JFD_OnExitCityScreen)
	Events.SerialEventCityScreenDirty.Add(JFD_OnNextCityScreen)
	Events.SerialEventCityInfoDirty.Add(JFD_OnEnterCityScreen)
end
--------------------------------------------------------------------------------------------------------------------------
-- JFD_HungarianVegvar
--------------------------------------------------------------------------------------------------------------------------
function JFD_GetNumDefensiveBuildings(city)
	local numDefensiveBuildings = 0
	for row in GameInfo.Buildings("Defense > 0 AND Cost > 0") do
		if city:IsHasBuilding(row.ID) then
			numDefensiveBuildings = numDefensiveBuildings + 1
		end
	end
	return numDefensiveBuildings
end
		
function JFD_HungarianVegvar(playerID)
	local player = Players[playerID]
	if player:IsEverAlive() then
		for city in player:Cities() do
			if city:IsHasBuilding(buildingVegvarID) then
				local myCity = load(city:GetCityIndexPlot(0), "VegvarOwner")
				if myCity == nil then
					myCity = playerID
					save(city:GetCityIndexPlot(0), "VegvarOwner", playerID)
				end
				if myCity == playerID then
					local numDefenseBuildings = JFD_GetNumDefensiveBuildings(city)
					local religionID = player:GetReligionCreatedByPlayer() or -1
					if religionID < 1 and player:GetCapitalCity() then
						religionID = player:GetCapitalCity():GetReligiousMajority()
					end
					if religionID > 0 and city:GetReligiousMajority() == religionID then
						city:SetNumRealBuilding(buildingVegvarPressureID, numDefenseBuildings)
					else
						city:SetNumRealBuilding(buildingVegvarPressureID, 0)
					end
					city:SetNumRealBuilding(buildingVegvarFaithID, numDefenseBuildings)
				else
					local originalPlayer = Players[myCity]
					if originalPlayer:IsEverAlive() and Teams[originalPlayer:GetTeam()]:IsAtWar(player:GetTeam()) then
						local religionID = originalPlayer:GetReligionCreatedByPlayer()
						if religionID < 1 and originalPlayer:GetCapitalCity() then
							religionID = originalPlayer:GetCapitalCity():GetReligiousMajority()
						end
						if religionID > 0 and city:GetReligiousMajority() == religionID then
							city:ChangeDamage(30)
						end
					end
				end
			else
				if load(city:GetCityIndexPlot(0), "VegvarOwner") then
					save(city:GetCityIndexPlot(0), "VegvarOwner",nil)
				end
				city:SetNumRealBuilding(buildingVegvarPressureID, 0)
				city:SetNumRealBuilding(buildingVegvarFaithID, 0)
			end
		end
	end
end

function JFD_HungarianVegvarDirty()
	if activePlayer:IsTurnActive() then
		if activePlayer:IsEverAlive() and activePlayer:GetCivilizationType() == civilisationID then
			for city in activePlayer:Cities() do
				if city:IsHasBuilding(buildingVegvarID) then
					local myCity = load(city:GetCityIndexPlot(0), "VegvarOwner")
					if myCity == nil then
						myCity = activePlayerID
						save(city:GetCityIndexPlot(0), "VegvarOwner", activePlayerID)
					end
					if Players[myCity] == activePlayer then
						local numDefenseBuildings = JFD_GetNumDefensiveBuildings(city)
						local religionID = activePlayer:GetReligionCreatedByPlayer() or -1
						if religionID < 1 and activePlayer:GetCapitalCity() then
							religionID = activePlayer:GetCapitalCity():GetReligiousMajority()
						end
						if religionID > 0 and city:GetReligiousMajority() == religionID then
							city:SetNumRealBuilding(buildingVegvarPressureID, numDefenseBuildings)
						else
							city:SetNumRealBuilding(buildingVegvarPressureID, 0)
						end
						city:SetNumRealBuilding(buildingVegvarFaithID, numDefenseBuildings)
					end
				else
					if load(city:GetCityIndexPlot(0), "VegvarOwner") then
						save(city:GetCityIndexPlot(0), "VegvarOwner", nil)
					end
					city:SetNumRealBuilding(buildingVegvarPressureID, 0)
					city:SetNumRealBuilding(buildingVegvarFaithID, 0)
				end
			end
		end
	end
end

function JFD_HungarianVegvarBuildTrigger(playerID, cityID, buildingID)
	local player = Players[playerID]
	local city = player:GetCityByID(cityID)
	if player:IsEverAlive() and player:GetCivilizationType() == civilisationID then
		if city and city:IsHasBuilding(buildingVegvarID) then
			local religionID = player:GetReligionCreatedByPlayer() or -1
			if religionID < 1 and player:GetCapitalCity() then
				religionID = player:GetCapitalCity():GetReligiousMajority()
			end
			local numDefenseBuildings = JFD_GetNumDefensiveBuildings(city)
			if religionID > 0 and city:GetReligiousMajority() == religionID then
				city:SetNumRealBuilding(buildingVegvarPressureID, numDefenseBuildings)
			else
				city:SetNumRealBuilding(buildingVegvarPressureID, 0)
			end
			city:SetNumRealBuilding(buildingVegvarFaithID, numDefenseBuildings)
			if load(city:GetCityIndexPlot(0), "VegvarOwner") == nil then
				save(city:GetCityIndexPlot(0), "VegvarOwner", playerID)
			end
		end
	end
end

function JFD_HungarianVegvarInitialTrigger(playerID, cityID, buildingID)
	local player = Players[playerID]
	local city = player:GetCityByID(cityID)
	if city and city:IsHasBuilding(buildingVegvarID) then
		GameEvents.PlayerDoTurn.Add(JFD_HungarianVegvar)
		Events.SerialEventGameDataDirty.Add(JFD_HungarianVegvarDirty)
		GameEvents.CityConstructed.Add(JFD_HungarianVegvarBuildTrigger)
		GameEvents.CityConstructed.Remove(JFD_HungarianVegvarInitialTrigger)
		save("GAME", "JFD_HungarianVegvarInitalised", true)
		JFD_HungarianVegvarBuildTrigger(playerID, cityID, buildingID)
	end
end

if isHungaryCivActive then
	GameEvents.PlayerDoTurn.Add(JFD_FaithtoGoldenAgePointsTurn)
	Events.SerialEventGameDataDirty.Add(JFD_FaithtoGoldenAgePointsDirty)
	if load("GAME", "JFD_HungarianVegvarInitalised") then
		GameEvents.PlayerDoTurn.Add(JFD_HungarianVegvar)
		Events.SerialEventGameDataDirty.Add(JFD_HungarianVegvarDirty)
		GameEvents.CityConstructed.Add(JFD_HungarianVegvarBuildTrigger)
	else
		GameEvents.CityConstructed.Add(JFD_HungarianVegvarInitialTrigger)
	end
end
--==========================================================================================================================
-- CORE AUSTRIA FUNCTIONS
--==========================================================================================================================
-- Globals
-------------------------------------------------------------------------------------------------------------------------
local civilisationAustriaID 	= GameInfoTypes["CIVILIZATION_AUSTRIA"]
local isAustriaCivActive 		= JFD_IsCivilisationActive(civilisationAustriaID)
local buildingAustrianGPGID 	= GameInfoTypes["BUILDING_JFD_AUSTRIAN_GREAT_PEOPLE_GEN"]
local buildingCoffeeHouseID 	= GameInfoTypes["BUILDING_COFFEE_HOUSE"]
local unitSettlerID 			= GameInfoTypes["UNIT_SETTLER"]
local unitWorkerID 				= GameInfoTypes["UNIT_WORKER"]
local tableSpecialistBuildings 	= {
	[GameInfoTypes.BUILDING_JFD_AUSTRIAN_ARTIST] = 1,
	[GameInfoTypes.BUILDING_JFD_AUSTRIAN_MUSICIAN] = 2
}
local unitPromotionDragoonID	= GameInfoTypes["PROMOTION_JFD_CEREMONIAL_DRAGOONS"]
local tableTourismBuildings 	= {
	[GameInfoTypes.BUILDING_JFD_AUSTRIAN_DRAGOON_TOURISM] = 1,
	[GameInfoTypes.BUILDING_JFD_AUSTRIAN_DRAGOON_TOURISM_2] = 2,
	[GameInfoTypes.BUILDING_JFD_AUSTRIAN_DRAGOON_TOURISM_3] = 3,
	[GameInfoTypes.BUILDING_JFD_AUSTRIAN_DRAGOON_TOURISM_4] = 4,
	[GameInfoTypes.BUILDING_JFD_AUSTRIAN_DRAGOON_TOURISM_5] = 5
}
--------------------------------------------------------------------------------------------------------------------------
-- JFD_AustrianSettlers
--------------------------------------------------------------------------------------------------------------------------
function JFD_AustrianSettlers(playerID, unitID)
    local player = Players[playerID]
	if player:IsEverAlive() and player:GetCivilizationType() == civilisationAustriaID then 
	  	 local unit = player:GetUnitByID(unitID)
		 if unit and unit:GetUnitType() == unitSettlerID then
			if player:GetCapitalCity() then
				local newUnit = player:InitUnit(unitWorkerID, unit:GetX(), unit:GetY(), UNITAI_WORKER)
				newUnit:Convert(unit)
			end
	    end
	end
end
--------------------------------------------------------------------------------------------------------------------------
-- JFD_AustriaGreatPeople
--------------------------------------------------------------------------------------------------------------------------
function JFD_AustriaGreatPeople(playerID)
	local player = Players[playerID]
    if player:IsEverAlive() and player:GetCivilizationType() == civilisationAustriaID then
		local capital = player:GetCapitalCity()
		if capital then 
			local excessHappiness = math.min(player:GetExcessHappiness(), 50)
			if excessHappiness < 0 then excessHappiness = 0 end
			if capital:GetNumBuilding(buildingAustrianGPGID) ~= excessHappiness then
				capital:SetNumRealBuilding(buildingAustrianGPGID, excessHappiness)
			end
		end
	end
end

function JFD_AustriaGreatPeopleDirty()
	local playerID = Game.GetActivePlayer()
    local player = Players[playerID]
	if player:IsEverAlive() and player:GetCivilizationType() == civilisationAustriaID then
		local capital = player:GetCapitalCity()
		if capital then 
			local excessHappiness = math.min(player:GetExcessHappiness(), 50)
			if excessHappiness < 0 then excessHappiness = 0 end
			if capital:GetNumBuilding(buildingAustrianGPGID) ~= excessHappiness then
				capital:SetNumRealBuilding(buildingAustrianGPGID, excessHappiness)
			end
		end
	end
end
--------------------------------------------------------------------------------------------------------------------------
-- JFD_CoffeeHouseSpecialists
--------------------------------------------------------------------------------------------------------------------------
function JFD_BlockCoffeeHouseSell(playerID, buildingID)
	if buildingID == buildingCoffeeHouseID then
		return
	end
	return true
end

function JFD_CoffeeHouseSpecialistsBuildTrigger(playerID, cityID, buildingID)
	local player = Players[playerID]
	local city = player:GetCityByID(cityID)
	if player:IsEverAlive() and player:GetCivilizationType() == civilisationAustriaID then
		if city and city:IsHasBuilding(buildingCoffeeHouseID) then
			for buildingID, buildingIndex in pairs(tableSpecialistBuildings) do
				if not city:IsHasBuilding(buildingID) then
					city:SetNumRealBuilding(buildingID, 1)
				end
			end
		end
	end
end

function JFD_CoffeeHouseSpecialistsCaptureTrigger(oldOwnerID, bIsCapital, cityX, cityY, newOwnerID)
	local player = Players[newOwnerID]
	if player:IsEverAlive() and player:GetCivilizationType() == civilisationAustriaID then
		local city = Map.GetPlot(cityX, cityY):GetPlotCity()
		if city and city:IsHasBuilding(buildingCoffeeHouseID)then
			for buildingID, buildingIndex in pairs(tableSpecialistBuildings) do
				if not city:IsHasBuilding(buildingID) then
					city:SetNumRealBuilding(buildingID, 1)
				end
			end
		end
	end
end

function JFD_CoffeeHouseSpecialistsInitialTrigger(playerID, cityID, buildingID)
	local player = Players[playerID]
	local city = player:GetCityByID(cityID)
	if city and city:IsHasBuilding(buildingCoffeeHouseID) then
		GameEvents.CityConstructed.Add(JFD_CoffeeHouseSpecialistsBuildTrigger)
		GameEvents.CityCaptureComplete.Add(JFD_CoffeeHouseSpecialistsCaptureTrigger)
		GameEvents.CityConstructed.Remove(JFD_CoffeeHouseSpecialistsInitialTrigger)
		save("GAME", "JFD_AustrianCoffeeHouseInitalised", true)
		JFD_CoffeeHouseSpecialistsBuildTrigger(playerID, cityID, buildingID)
	end
end

if isAustriaCivActive then
	Events.SerialEventUnitCreated.Add(JFD_AustrianSettlers)
	GameEvents.PlayerDoTurn.Add(JFD_AustriaGreatPeople)
	Events.SerialEventGameDataDirty.Add(JFD_AustriaGreatPeopleDirty)
	GameEvents.CityBuildingsIsBuildingSellable.Add(JFD_BlockCoffeeHouseSell)
	if load("GAME", "JFD_AustrianCoffeeHouseInitalised") then
		GameEvents.CityConstructed.Add(JFD_CoffeeHouseSpecialistsBuildTrigger)
		GameEvents.CityCaptureComplete.Add(JFD_CoffeeHouseSpecialistsCaptureTrigger)
	else
		GameEvents.CityConstructed.Add(JFD_CoffeeHouseSpecialistsInitialTrigger)
	end
end
--------------------------------------------------------------------------------------------------------------------------
-- JFD_DragoonCulture
--------------------------------------------------------------------------------------------------------------------------
function JFD_DragoonTourism(playerID)
	local player = Players[playerID]
	if player:IsEverAlive() then
		for city in player:Cities() do
			local unit = city:GetGarrisonedUnit()
			if unit and unit:IsHasPromotion(unitPromotionDragoonID) then
				local tablePromotions = {0, 0, 0, 0, 0}
				local unitLevel = unit:GetLevel()
				if unitLevel > 0 then
					tablePromotions[math.min(unitLevel, 5)] = 1
				end
				for buildingID, buildingIndex in pairs(tableTourismBuildings) do
					city:SetNumRealBuilding(buildingID, tablePromotions[buildingIndex])
				end
			else
				for buildingID, buildingIndex in pairs(tableTourismBuildings) do
					city:SetNumRealBuilding(buildingID, 0)
				end
			end
		end
	end
end

function JFD_DragoonTourismFounded(playerID, cityX, cityY)
	local player = Players[playerID]
	if player:IsEverAlive() then
		local plot = Map.GetPlot(cityX, cityY)
		local city = plot:GetPlotCity()
		if city then
			local unit = city:GetGarrisonedUnit()
			if unit and unit:IsHasPromotion(unitPromotionDragoonID) then
				local tablePromotions = {0, 0, 0, 0, 0}
				local unitLevel = unit:GetLevel()
				if unitLevel > 0 then
					tablePromotions[math.min(unitLevel, 5)] = 1
				end
				for buildingID, buildingIndex in pairs(tableTourismBuildings) do
					city:SetNumRealBuilding(buildingID, tablePromotions[buildingIndex])
				end
			end
		end
	end
end

function JFD_DragoonTourismInitialTrigger(playerID, unitID)
	local player = Players[playerID]
	local unit = player:GetUnitByID(unitID)
	if unit and unit:IsHasPromotion(unitPromotionDragoonID) then
		GameEvents.PlayerDoTurn.Add(JFD_DragoonTourism)
		GameEvents.UnitSetXY.Add(JFD_DragoonTourism)
		Events.SerialEventUnitCreated.Add(JFD_DragoonTourism)
		GameEvents.PlayerCityFounded.Add(JFD_DragoonTourismFounded)
		Events.SerialEventUnitCreated.Remove(JFD_DragoonTourismInitialTrigger)
		save("GAME", "JFD_DragoonTourismInitalised", true)
		JFD_DragoonTourism(playerID)
	end
end

if load("GAME", "JFD_DragoonTourismInitalised") then
	GameEvents.PlayerDoTurn.Add(JFD_DragoonTourism)
	GameEvents.UnitSetXY.Add(JFD_DragoonTourism)
	Events.SerialEventUnitCreated.Add(JFD_DragoonTourism)
	GameEvents.PlayerCityFounded.Add(JFD_DragoonTourismFounded)
else
	Events.SerialEventUnitCreated.Add(JFD_DragoonTourismInitialTrigger)
end
--==========================================================================================================================
--==========================================================================================================================