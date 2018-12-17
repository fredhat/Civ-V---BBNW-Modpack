-- Papal_States_Functions
-- Author: JFD
-- Heavily Edited By: F0S
--=======================================================================================================================
-- UTILITY FUNCTIONS	
--=======================================================================================================================
-- JFD_IsCivilisationActive
------------------------------------------------------------------------------------------------------------------------
WARN_NOT_SHARED = false; include( "Sukritact_SaveUtils.lua" ); MY_MOD_NAME = "JFD_PapalFunctions";
local civilisationID = GameInfoTypes["CIVILIZATION_JFD_PAPAL_STATES"]

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
-- CORE FUNCTIONS	
--=======================================================================================================================
-- JFD_InitPapalStates
--------------------------------------------------------------------------------------------------------------------------
local policyPapalStatesID = GameInfoTypes["POLICY_JFD_PAPAL_STATES"]

function JFD_InitPapalStates(player)
	for playerID, player in pairs(Players) do
		local player = Players[playerID]
		if player:IsEverAlive() and player:GetCivilizationType() == civilisationID then
			if not player:HasPolicy(policyPapalStatesID) then
				player:SetNumFreePolicies(player:GetNumFreePolicies() + 1)
				player:SetNumFreePolicies(player:GetNumFreePolicies() - 1)
				player:SetHasPolicy(policyPapalStatesID, true)	
			end
		end
	end 
end
--------------------------------------------------------------------------------------------------------------------------
-- JFD_PapalDisciples
--------------------------------------------------------------------------------------------------------------------------
local unitDiscipleID = GameInfoTypes["UNIT_JFD_DISCIPLE"]
local unitProphetID = GameInfoTypes["UNIT_PROPHET"]
local promotionPapalStatesID = GameInfoTypes["PROMOTION_JFD_PAPAL_STATES"]

function JFD_BlockDisciples(playerID, unitID)
	if unitID == unitDiscipleID then
		return
	end
	return true
end

GameEvents.PlayerCanTrain.Add(JFD_BlockDisciples)

function JFD_PapalDisciples(playerID, unitID)
    local player = Players[playerID]
    if player:IsEverAlive() and player:GetCivilizationType() == civilisationID then 
		local unit = player:GetUnitByID(unitID)
       	if unit and unit:GetUnitType() == unitProphetID and not unit:IsHasPromotion(promotionPapalStatesID) then 
			if unit:CanMove() then
				local newUnit = player:InitUnit(unitDiscipleID, unit:GetX(), unit:GetY(), UNITAI_WRITER)
				newUnit:JumpToNearestValidPlot()
				if player:IsHuman() and player:IsTurnActive() then
					local description = Locale.ConvertTextKey('TXT_KEY_JFD_DISCIPLE')
					local descriptionShort = Locale.ConvertTextKey("TXT_KEY_JFD_DISCIPLE_SHORT")
					player:AddNotification(NotificationTypes["NOTIFICATION_GREAT_PERSON_ACTIVE_PLAYER"], description, descriptionShort, newUnit:GetX(), newUnit:GetY(), unitDiscipleID, -1)
					Events.AudioPlay2DSound("AS2D_INTERFACE_FAITH_PURCHASE")
				end
			end
			unit:SetHasPromotion(promotionPapalStatesID, true)
		end
    end
end
--------------------------------------------------------------------------------------------------------------------------
-- JFD_BlockChapels
--------------------------------------------------------------------------------------------------------------------------
local buildingChapelWritingID = GameInfoTypes["BUILDING_JFD_CHAPEL_WRITING"]
local buildingChapelArtID = GameInfoTypes["BUILDING_JFD_CHAPEL_ART"]
local buildingChapelMusicID = GameInfoTypes["BUILDING_JFD_CHAPEL_MUSIC"]

function JFD_BlockChapels(playerID, cityID, buildingID)
	local player = Players[playerID]
	local city = player:GetCityByID(cityID)
	if city and buildingID == buildingChapelArtID then
		if not player:GetCivilizationType() == civilisationID then
			return
		else
			if not city:IsHasBuilding(buildingChapelWritingID) then return end
			local religionID = player:GetReligionCreatedByPlayer() or -1
			if religionID < 1 and player:GetCapitalCity() then
				religionID = player:GetCapitalCity():GetReligiousMajority()
			end
			if religionID < 1 or city:GetNumFollowers(religionID) < 5 then
				return
			end
		end
	end
	if city and buildingID == buildingChapelMusicID then
		if not player:GetCivilizationType() == civilisationID then
			return
		else
			if not city:IsHasBuilding(buildingChapelArtID) then return end
			local religionID = player:GetReligionCreatedByPlayer() or -1
			if religionID < 1 and player:GetCapitalCity() then
				religionID = player:GetCapitalCity():GetReligiousMajority()
			end
			if religionID < 1 or city:GetNumFollowers(religionID) < 10 then
				return
			end
		end
	end
	return true
end

GameEvents.CityCanConstruct.Add(JFD_BlockChapels)
--------------------------------------------------------------------------------------------------------------------------
-- JFD_ChapelFaith
--------------------------------------------------------------------------------------------------------------------------
local buildingClassTempleID = GameInfoTypes["BUILDINGCLASS_TEMPLE"]
local buildingClassChapelArtID = GameInfoTypes["BUILDINGCLASS_JFD_CHAPEL_ART"]
local buildingClassChapelMusicID = GameInfoTypes["BUILDINGCLASS_JFD_CHAPEL_MUSIC"]
local buildingChapelFaithID = GameInfoTypes["BUILDING_JFD_CHAPEL_FAITH"]

function JFD_GetNumChapelGreatWorksFilled(player, city)
	local numChapelGreatWorksFilled = 0
	if city and city:IsHasBuilding(buildingChapelWritingID) and city:GetNumGreatWorksInBuilding(GameInfoTypes["BUILDINGCLASS_TEMPLE"]) > 0 then
		numChapelGreatWorksFilled = numChapelGreatWorksFilled + 1
	end
	if city and city:GetNumGreatWorksInBuilding(buildingClassChapelArtID) > 0 then
		numChapelGreatWorksFilled = numChapelGreatWorksFilled + 1
	end
	if city and city:GetNumGreatWorksInBuilding(buildingClassChapelMusicID) > 0 then
		numChapelGreatWorksFilled = numChapelGreatWorksFilled + 1
	end
	return numChapelGreatWorksFilled
end

function JFD_ChapelFaith(playerID)
	 local player = Players[playerID]
	 if player:IsEverAlive() then
	 	for city in player:Cities() do
			if city then city:SetNumRealBuilding(buildingChapelFaithID, JFD_GetNumChapelGreatWorksFilled(player, city)) end
		end
	end
end

function JFD_ChapelFaithDirty()
	local playerID = Game.GetActivePlayer()
    local player = Players[playerID]
	if player:IsTurnActive() then
        JFD_ChapelFaith(playerID)
    end
end

function JFD_ChapelFaithInitialTrigger(playerID, cityID, buildingID)
	local player = Players[playerID]
	local city = player:GetCityByID(cityID)
	if city and (city:IsHasBuilding(buildingChapelWritingID) or city:IsHasBuilding(buildingChapelArtID) or city:IsHasBuilding(buildingChapelMusicID)) then
		GameEvents.PlayerDoTurn.Add(JFD_ChapelFaith)
		Events.SerialEventCityInfoDirty.Add(JFD_ChapelFaithDirty)
		GameEvents.CityConstructed.Remove(JFD_ChapelFaithInitialTrigger)
		save("GAME", "JFD_ChapelFaithInitalised", true)
	end
end

if JFD_IsCivilisationActive(civilisationID) then
	Events.SequenceGameInitComplete.Add(JFD_InitPapalStates)
	Events.SerialEventUnitCreated.Add(JFD_PapalDisciples)
	if load("GAME", "JFD_ChapelFaithInitalised") then
		GameEvents.PlayerDoTurn.Add(JFD_ChapelFaith)
		Events.SerialEventCityInfoDirty.Add(JFD_ChapelFaithDirty)
	else
		GameEvents.CityConstructed.Add(JFD_ChapelFaithInitialTrigger)
	end
end
--------------------------------------------------------------------------------------------------------------------------
-- JFD_SwissGuardTourism
--------------------------------------------------------------------------------------------------------------------------
local promotionSwissGuardTourismID = GameInfoTypes["PROMOTION_JFD_SWISS_GUARD_TOURISM"]
local buildingSwissGuardTourismID = GameInfoTypes["BUILDING_JFD_SWISS_GUARD_TOURISM"]

function JFD_SwissGuardTourismCityCheck(city, unit)
	if unit:IsHasPromotion(promotionSwissGuardTourismID) then
		if not city:IsHasBuilding(buildingSwissGuardTourismID) then
			city:SetNumRealBuilding(buildingSwissGuardTourismID, 1)
		end
	else
		if city:IsHasBuilding(buildingSwissGuardTourismID) then
			city:SetNumRealBuilding(buildingSwissGuardTourismID, 0)
		end
	end
end

function JFD_SwissGuardTourism(playerID)
	local player = Players[playerID]
	if player:IsEverAlive() then
		for city in player:Cities() do
			if city then
				local unit = city:GetGarrisonedUnit()
				if unit then JFD_SwissGuardTourismCityCheck(city, unit) end
			end
		end
	end
end

function JFD_SwissGuardTourismCreated(playerID, unitID)
	local player = Players[playerID]
	if player:IsEverAlive() then
		local unit = player:GetUnitByID(unitID)
		if unit then
			local plot = unit:GetPlot()
			if plot and plot:GetOwner() == playerID and plot:IsCity() then
				local city = plot:GetPlotCity()
				if city and unit == city:GetGarrisonedUnit() then JFD_SwissGuardTourismCityCheck(city, unit) end
			end
		end
	end
end
--------------------------------------------------------------------------------------------------------------------------
-- JFD_SwissGuardCapitalHealing
--------------------------------------------------------------------------------------------------------------------------
local promotionSwissGuardHealingInfoID = GameInfoTypes["PROMOTION_JFD_SWISS_GUARD_HEALING_INFO"]
local promotionSwissGuardHealingID = GameInfoTypes["PROMOTION_JFD_SWISS_GUARD_HEALING"]

function JFD_SwissGuardCapitalCheck(player, unit)
	if unit and (unit:IsHasPromotion(promotionSwissGuardHealingInfoID) or unit:IsHasPromotion(promotionSwissGuardHealingID)) then
		local nearCapital = false
		local capital = player:GetCapitalCity()
		if capital and Map.PlotDistance(unit:GetX(), unit:GetY(), capital:GetX(), capital:GetY()) < 3 then
			nearCapital = true
		end
		if nearCapital then
			if unit:IsHasPromotion(promotionSwissGuardHealingInfoID) then
				unit:SetHasPromotion(promotionSwissGuardHealingID, true)
				unit:SetHasPromotion(promotionSwissGuardHealingInfoID, false)
			end
		else
			if unit:IsHasPromotion(promotionSwissGuardHealingID) then
				unit:SetHasPromotion(promotionSwissGuardHealingID, false)
				unit:SetHasPromotion(promotionSwissGuardHealingInfoID, true)
			end
		end
	end
end

function JFD_SwissGuardCapitalHealing(playerID)
	local player = Players[playerID]
	if player:IsEverAlive() then
		for unit in player:Units() do
			JFD_SwissGuardCapitalCheck(player, unit)
		end
	end
end

function JFD_SwissGuardCapitalHealingCreated(playerID, unitID)
	local player = Players[playerID]
	if player:IsEverAlive() then
		local unit = player:GetUnitByID(unitID)
		JFD_SwissGuardCapitalCheck(player, unit)
	end
end

function JFD_SwissGuardInitialTrigger(playerID, unitID)
	local player = Players[playerID]
	local unit = player:GetUnitByID(unitID)
	if unit and (unit:IsHasPromotion(promotionSwissGuardTourismID) or unit:IsHasPromotion(promotionSwissGuardHealingInfoID)) then
		GameEvents.PlayerDoTurn.Add(JFD_SwissGuardTourism)
		GameEvents.UnitSetXY.Add(JFD_SwissGuardTourism)
		Events.SerialEventUnitCreated.Add(JFD_SwissGuardTourismCreated)
		GameEvents.PlayerDoTurn.Add(JFD_SwissGuardCapitalHealing)
		GameEvents.UnitSetXY.Add(JFD_SwissGuardCapitalHealing)
		Events.SerialEventUnitCreated.Add(JFD_SwissGuardCapitalHealingCreated)
		Events.SerialEventUnitCreated.Remove(JFD_SwissGuardInitialTrigger)
		save("GAME", "JFD_SwissGuardInitalised", true)
		JFD_SwissGuardTourismCreated(playerID, unitID)
		JFD_SwissGuardCapitalHealingCreated(playerID, unitID)
	end
end

if load("GAME", "JFD_SwissGuardInitalised") then
	GameEvents.PlayerDoTurn.Add(JFD_SwissGuardTourism)
	GameEvents.UnitSetXY.Add(JFD_SwissGuardTourism)
	Events.SerialEventUnitCreated.Add(JFD_SwissGuardTourismCreated)
	GameEvents.PlayerDoTurn.Add(JFD_SwissGuardCapitalHealing)
	GameEvents.UnitSetXY.Add(JFD_SwissGuardCapitalHealing)
	Events.SerialEventUnitCreated.Add(JFD_SwissGuardCapitalHealingCreated)
else
	Events.SerialEventUnitCreated.Add(JFD_SwissGuardInitialTrigger)
end
--=======================================================================================================================================================================================
--=======================================================================================================================================================================================