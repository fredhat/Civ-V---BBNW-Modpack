-- MarathaTrait
-- Original Author: JFD
-- Edited By: F0S
--------------------------------------------------------------
include("IconSupport")
include("FLuaVector.lua")
--=======================================================================================================================
-- UTILITIES
--=======================================================================================================================
-- JFD_IsCivilisationActive
------------------------------------------------------------------------------------------------------------------------
WARN_NOT_SHARED = false; include( "SaveUtils.lua" ); MY_MOD_NAME = "MarathaTrait";

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
-- Globals
--------------------------------------------------------------------------------------------------------------------------
local activePlayerID 			= Game.GetActivePlayer()
local activePlayer 				= Players[activePlayerID]
local civilisationID 			= GameInfoTypes["CIVILIZATION_MARATHA"]
local isMarathaCivActive 		= JFD_IsCivilisationActive(civilisationID)
local isMarathaActivePlayer 	= activePlayer:GetCivilizationType() == civilisationID
local buildingHeroicEpicID 		= GameInfoTypes["BUILDING_HEROIC_EPIC"]
local unitPromotionMilitiaID 	= GameInfoTypes["PROMOTION_JFD_MARATHA_MILITIA"]
local unitPromotionMoraleID 	= GameInfoTypes["PROMOTION_MORALE"]
----------------------------------------------------------------------------------------------------------------------------
-- JFD_AIMilitia
----------------------------------------------------------------------------------------------------------------------------	
local MilitiaUnits = { 
	GameInfo.Units.UNIT_MECHANIZED_INFANTRY.ID, 
	GameInfo.Units.UNIT_INFANTRY.ID, 
	GameInfo.Units.UNIT_GREAT_WAR_INFANTRY.ID, 
	GameInfo.Units.UNIT_RIFLEMAN.ID, 
	GameInfo.Units.UNIT_MARATHA_SEPOY.ID, 
	GameInfo.Units.UNIT_PIKEMAN.ID, 
	GameInfo.Units.UNIT_SPEARMAN.ID, 
	GameInfo.Units.UNIT_WARRIOR.ID
}

function JFD_GetConscriptionSpeed(gameSpeed)
	if gameSpeed == GameInfoTypes["GAMESPEED_QUICK"] then
		return 5
	elseif gameSpeed == GameInfoTypes["GAMESPEED_STANDARD"] then
		return 8
	elseif gameSpeed == GameInfoTypes["GAMESPEED_EPIC"] then
		return 12
	else
		return 20
	end
end

function JFD_GetStrongestMilitaryUnit(pPlayer)
	local tUnit = GameInfo.Units.UNIT_WARRIOR.ID
	for _, iUnit in pairs(MilitiaUnits) do
		if pPlayer:CanTrain(iUnit) then
			tUnit = iUnit
			break
		end
	end
	return tUnit
end

function JFD_AIMilitia(teamID, otherTeamID)
	local player = Players[Teams[teamID]:GetLeaderID()]
	local otherPlayer = Players[Teams[otherTeamID]:GetLeaderID()]
	if otherPlayer:IsEverAlive() and otherPlayer:GetCivilizationType() == civilisationID and player:IsEverAlive() and not player:IsMinorCiv() and not otherPlayer:IsHuman() then
		for city in otherPlayer:Cities() do
			if city:CanTrain(JFD_GetStrongestMilitaryUnit(otherPlayer)) and city:GetPopulation() > 3 then
				local newUnit = otherPlayer:InitUnit(JFD_GetStrongestMilitaryUnit(otherPlayer), city:GetX(), city:GetY(), UNITAI_DEFENSE)
				newUnit:SetExperience(city:GetProductionExperience(newUnit:GetUnitType()))
				if city:IsHasBuilding(buildingHeroicEpicID) then
					newUnit:SetHasPromotion(unitPromotionMoraleID, true)
				end
				newUnit:SetHasPromotion(unitPromotionMilitiaID, true)
				newUnit:SetMoves(0)
				--local numCitizens = city:GetPopulation()
				--city:SetPopulation(numCitizens - 1, true)
				city:ChangePopulation(-1, true)
				Network.SendUpdateCityCitizens(city:GetID())
			end
		end
	end
end

if isMarathaCivActive and not isMarathaActivePlayer then
	GameEvents.DeclareWar.Add(JFD_AIMilitia)
end
--==========================================================================================================================
-- UI FUNCTIONS
--==========================================================================================================================
--Globals
----------------------------------------------------------------------------------------------------------------------------
local isCityViewOpen = false
----------------------------------------------------------------------------------------------------------------------------
-- JFD_UpdateMilitiaRecruitment
----------------------------------------------------------------------------------------------------------------------------
function JFD_UpdateMilitiaRecruitment()
	Controls.UnitBackground:SetHide(true)
	Controls.UnitImage:SetHide(true)
	Controls.UnitButton:SetDisabled(true)
	Controls.UnitButton:LocalizeAndSetToolTip(nil)
	local unitMilitiaID = JFD_GetStrongestMilitaryUnit(activePlayer)
	local militia = GameInfo.Units[unitMilitiaID]
	local city = UI.GetHeadSelectedCity()
	if city and not city:IsOccupied() and not city:IsPuppet() then
		local isDisabled = true
		local garrisonedUnit = city:GetGarrisonedUnit()
		local buttonText = "TXT_KEY_JFD_RECRUIT_MILITIA"
		local buttonToolTip = "TXT_KEY_JFD_RECRUIT_MILITIA_TT"
		local cityTurns = load(city:Plot(),"CityTurns")
		if garrisonedUnit then
			if garrisonedUnit:IsHasPromotion(unitPromotionMilitiaID) then
				isDisabled = false
				buttonText = "TXT_KEY_JFD_RETURN_MILITIA"
				buttonToolTip = "TXT_KEY_JFD_RETURN_MILITIA_TT"
			end
		else
			if city:CanTrain(militia.ID) and city:GetPopulation() > 3 and (cityTurns == nil or cityTurns == 0) then
				isDisabled = false
			end
		end
		if isDisabled then
			if cityTurns ~= nil and cityTurns ~= 0 then
				buttonToolTip = Locale.ConvertTextKey("TXT_KEY_JFD_RECRUIT_MILITIA_TT_DISABLED_TURNS", cityTurns)
			else
				buttonToolTip = "TXT_KEY_JFD_RECRUIT_MILITIA_TT_DISABLED"
			end
		end
		IconHookup(militia.PortraitIndex, 64, militia.IconAtlas, Controls.UnitImage)
		Controls.UnitBackground:SetHide(false)
		Controls.UnitImage:SetHide(false)
		Controls.UnitButton:LocalizeAndSetText(buttonText)
		--Controls.UnitButton:LocalizeAndSetToolTip(buttonToolTipDisabled)
		Controls.UnitButton:SetDisabled(isDisabled)
		Controls.UnitButton:LocalizeAndSetToolTip(buttonToolTip)		
	end
end
----------------------------------------------------------------------------------------------------------------------------
-- JFD_OnHireMilitia
----------------------------------------------------------------------------------------------------------------------------
function JFD_OnHireMilitia()
	local city = UI.GetHeadSelectedCity()
	if city then
		local cityX = city:GetX()
		local cityY = city:GetY()
		local garrisonedUnit = city:GetGarrisonedUnit()
		local unitMilitiaID = JFD_GetStrongestMilitaryUnit(activePlayer)
		local militia = GameInfo.Units[unitMilitiaID]
		if garrisonedUnit then
			if garrisonedUnit:IsHasPromotion(unitPromotionMilitiaID) then
				garrisonedUnit:Kill(false, -1)
				--local numCitizens = city:GetPopulation()
				--city:SetPopulation(numCitizens + 1, true)
				city:ChangePopulation(1, true)
				Network.SendUpdateCityCitizens(city:GetID())
				local hex = ToHexFromGrid(Vector2(cityX, cityY))
				Events.AddPopupTextEvent(HexToWorld(hex), Locale.ConvertTextKey("[COLOR_POSITIVE_TEXT]+{1_Num}[ENDCOLOR][ICON_CITIZEN]", 1), 1)
				Events.GameplayFX(hex.x, hex.y, -1)
			end
		else
			local newUnit = activePlayer:InitUnit(unitMilitiaID, cityX, cityY, UNITAI_ATTACK)
			newUnit:SetExperience(city:GetProductionExperience(newUnit:GetUnitType()))
			if city:IsHasBuilding(buildingHeroicEpicID) then
				newUnit:SetHasPromotion(unitPromotionMoraleID, true)
			end
			newUnit:SetHasPromotion(unitPromotionMilitiaID, true)
			newUnit:SetMoves(0)
			--local numCitizens = city:GetPopulation()
			--city:SetPopulation(numCitizens - 1, true)
			city:ChangePopulation(-1, true)
			Network.SendUpdateCityCitizens(city:GetID())
			save(city:Plot(),"CityTurns",JFD_GetConscriptionSpeed(Game.GetGameSpeedType()))
		end
	end
	JFD_UpdateMilitiaRecruitment()
end
Controls.UnitButton:RegisterCallback(Mouse.eLClick, JFD_OnHireMilitia)
----------------------------------------------------------------------------------------------------------------------------
-- JFD_OnEnterCityScreen
----------------------------------------------------------------------------------------------------------------------------
function JFD_OnEnterCityScreen()
	isCityViewOpen = true
	JFD_UpdateMilitiaRecruitment()
end
----------------------------------------------------------------------------------------------------------------------------
-- JFD_OnExitCityScreen
----------------------------------------------------------------------------------------------------------------------------
function JFD_OnExitCityScreen()
	isCityViewOpen = false
	JFD_UpdateMilitiaRecruitment()
end
----------------------------------------------------------------------------------------------------------------------------
-- JFD_OnNextCityScren
----------------------------------------------------------------------------------------------------------------------------
function JFD_OnNextCityScren()
	if isCityViewOpen then
		JFD_UpdateMilitiaRecruitment()
	end
end
----------------------------------------------------------------------------------------------------------------------------
-- JFD_MarathaTraitTurn
----------------------------------------------------------------------------------------------------------------------------
function JFD_MarathaTraitTurn(playerID)
	local player = Players[playerID]
	if player:IsEverAlive() and player:GetCivilizationType() == civilisationID and player:IsHuman() then
		for city in player:Cities() do
			local cityTurns = load(city:Plot(),"CityTurns")
			if cityTurns and cityTurns > 0 then
				save(city:Plot(),"CityTurns",cityTurns - 1)
			else
				save(city:Plot(),"CityTurns",0)
			end
		end
	end
end

if isMarathaCivActive and isMarathaActivePlayer then
	GameEvents.PlayerDoTurn.Add(JFD_MarathaTraitTurn)
	Events.SerialEventEnterCityScreen.Add(JFD_OnEnterCityScreen)
	Events.SerialEventExitCityScreen.Add(JFD_OnExitCityScreen)
	Events.SerialEventCityScreenDirty.Add(JFD_OnNextCityScren)
end
--==========================================================================================================================
--==========================================================================================================================