-- JFD_NriFunctions
-- Author: JFD
-- Heavily Edited By: F0S
--==========================================================================================================================
-- Includes
--==========================================================================================================================
WARN_NOT_SHARED = false; include( "Sukritact_SaveUtils.lua" ); MY_MOD_NAME = "JFD_NriFunctions";
include("FLuaVector.lua")
include("PlotIterators.lua")
--==========================================================================================================================
-- UTILITY FUNCTIONS
--==========================================================================================================================
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
--------------------------------------------------------------------------------------------------------------------------
-- JFD_GetRandom
--------------------------------------------------------------------------------------------------------------------------
function JFD_GetRandom(lower, upper)
    return Game.Rand((upper + 1) - lower, "") + lower
end
--------------------------------------------------------------------------------------------------------------------------
-- JFD_SetButtonSize
--------------------------------------------------------------------------------------------------------------------------
local WordWrapOffset = 19
local WordWrapAnimOffset = 3

function JFD_SetButtonSize(textControl, buttonControl, animControl, buttonHL)
	local sizeY = textControl:GetSizeY() + WordWrapOffset
	buttonControl:SetSizeY(sizeY)
	animControl:SetSizeY(sizeY + WordWrapAnimOffset)
	buttonHL:SetSizeY(sizeY + WordWrapAnimOffset)
end
--==========================================================================================================================
-- CORE FUNCTIONS
--==========================================================================================================================
--Globals
----------------------------------------------------------------------------------------------------------------------------
local activePlayerID = Game.GetActivePlayer()
local activePlayer = Players[activePlayerID]
local activeTeam = Teams[activePlayer:GetTeam()]
local civilisationID = GameInfoTypes["CIVILIZATION_JFD_NRI"]
local isNriCivActive = JFD_IsCivilisationActive(civilisationID)
local isNriActivePlayer = activePlayer:GetCivilizationType() == civilisationID
local unitMburichiID = GameInfoTypes["UNIT_JFD_MBURICHI"]
--------------------------------------------------------------------------------------------------------------------------
-- JFD_CanWarAgainstNri
--------------------------------------------------------------------------------------------------------------------------
local eraIndustrialID = GameInfoTypes["ERA_INDUSTRIAL"]

function JFD_CanWarAgainstNri(teamID, otherTeamID)
	for playerID = 0, GameDefines.MAX_MAJOR_CIVS - 1 do
		local player = Players[playerID]
		if player:IsEverAlive() and player:GetTeam() == teamID and not player:IsMinorCiv() then
			for otherPlayerID = 0, GameDefines.MAX_MAJOR_CIVS - 1 do
				local otherPlayer = Players[otherPlayerID]
				if otherPlayer:IsEverAlive() and otherPlayer:GetTeam() == otherTeamID and not otherPlayer:IsMinorCiv() then
					if player:GetCivilizationType() == civilisationID then
						if player:GetCurrentEra() < eraIndustrialID then
							local religionID = player:GetReligionCreatedByPlayer()
							if religionID > 0 then
								if otherPlayer:HasReligionInMostCities(religionID) then
									return false
								end
							end
						end
					elseif otherPlayer:GetCivilizationType() == civilisationID then
						if otherPlayer:GetCurrentEra() < eraIndustrialID then
							local religionID = otherPlayer:GetReligionCreatedByPlayer()
							if religionID > 0 then
								if player:HasReligionInMostCities(religionID) then
									return false
								end
							end
						end
					end
				end
			end
		end
	end
	return true
end
----------------------------------------------------------------------------------------------------------------------------
--JFD_StopCityStatesFromDoWNri
----------------------------------------------------------------------------------------------------------------------------
function JFD_StopCityStatesFromDoWNri(teamID, otherTeamID)
	for playerID = 0, GameDefines.MAX_MAJOR_CIVS - 1 do
		local player = Players[playerID]
		if player:IsEverAlive() and player:GetTeam() == teamID and player:IsMinorCiv() then
			for otherPlayerID = 0, GameDefines.MAX_MAJOR_CIVS - 1 do
				local otherPlayer = Players[otherPlayerID]
				if otherPlayer:IsEverAlive() and otherPlayer:GetTeam() == otherTeamID and otherPlayer:GetCivilizationType() == civilisationID then
					local religionID = otherPlayer:GetReligionCreatedByPlayer()
					if otherPlayer:GetCurrentEra() < eraIndustrialID and religionID > 0 then
						if player:GetCapitalCity():GetReligiousMajority() == religionID then
							Teams[otherTeamID]:MakePeace(teamID)
							player:ChangeMinorCivFriendshipWithMajor(otherPlayer:GetID(), 1)
							if otherPlayer:IsHuman() and otherPlayer:IsTurnActive() and otherPlayer:IsHasMet(teamID) then
								local shortDescription = Locale.ConvertTextKey("TXT_KEY_JFD_NRI_CITY_STATES_DECLARE_PEACE_NOTIFICATION_SHORT")
								local description = Locale.ConvertTextKey("TXT_KEY_JFD_NRI_CITY_STATES_DECLARE_PEACE_NOTIFICATION", player:GetName(), otherPlayer:GetCivilizationDescription())
								otherPlayer:AddNotification(NotificationTypes["NOTIFICATION_DIPLOMACY_DECLARATION"], description, shortDescription, -1, -1)
							end
						end
					end
				end
			end
		end
	end
end
--------------------------------------------------------------------------------------------------------------------------
-- JFD_MburichiOnPantheon
--------------------------------------------------------------------------------------------------------------------------
function JFD_MburichiOnPantheon(playerID)
	local player = Players[playerID]
	if player:IsEverAlive() and player:GetCivilizationType() == civilisationID then
		local capital = player:GetCapitalCity()
		if capital then player:InitUnit(unitMburichiID, capital:GetX(), capital:GetY(), UNITAI_MERCHANT) end
	end
end
--------------------------------------------------------------------------------------------------------------------------
-- JFD_BronzeCaster
--------------------------------------------------------------------------------------------------------------------------
local buildingBronzeID = GameInfoTypes["BUILDING_JFD_BRONZE_CASTER"]
local resourceCopperID = GameInfoTypes["RESOURCE_COPPER"]
local resourceIronID = GameInfoTypes["RESOURCE_IRON"]
local improvementMineID = GameInfoTypes["IMPROVEMENT_MINE"]

function JFD_BronzeCaster(playerID, cityID, buildingID)
	local player = Players[playerID]
	if player:IsEverAlive() and player:GetCivilizationType() == civilisationID then
		if buildingID == buildingBronzeID then
			local city = player:GetCityByID(cityID)
			if city then
				local plot = Map.GetPlot(city:GetX(), city:GetY())
				if plot and load(plot, "hasBronzeCasterEver") == nil then
					for spawnPlot in PlotAreaSpiralIterator(plot, 3, JFD_GetRandom(1,6), DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
						local spawnResource = resourceCopperID
						if JFD_GetRandom(0,1) == 1 then
							spawnResource = resourceIronID
						end
						if not spawnPlot:IsMountain() and spawnPlot:GetResourceType() == -1 and (spawnPlot:GetFeatureType() == FeatureTypes.NO_FEATURE or spawnPlot:GetFeatureType() == FeatureTypes.FEATURE_MARSH or spawnPlot:GetFeatureType() == FeatureTypes.FEATURE_JUNGLE or spawnPlot:GetFeatureType() == FeatureTypes.FEATURE_FOREST) and not spawnPlot:IsWater() and not spawnPlot:IsCity() and (spawnPlot:GetOwner() == -1 or spawnPlot:GetOwner() == playerID) and (spawnPlot:GetImprovementType() == improvementMineID or spawnPlot:GetImprovementType() == -1) then
							if spawnResource == resourceIronID then
								spawnPlot:SetResourceType(spawnResource, JFD_GetRandom(1,3))
							else
								spawnPlot:SetResourceType(spawnResource, 1)
							end
							spawnPlot:SetOwner(-1)
							spawnPlot:SetOwner(playerID, cityID)
							spawnPlot:SetRevealed(player:GetTeam(), true)
							spawnPlot:UpdateFog()
							break
						end
					end
					save(plot, "hasBronzeCasterEver", 1)
				end
			end
		end
	end
end

if isNriCivActive then
	GameEvents.CanDeclareWar.Add(JFD_CanWarAgainstNri)
	GameEvents.DeclareWar.Add(JFD_StopCityStatesFromDoWNri)
	GameEvents.PantheonFounded.Add(JFD_MburichiOnPantheon)
	GameEvents.CityConstructed.Add(JFD_BronzeCaster)
end
--------------------------------------------------------------------------------------------------------------------------
-- JFD_MburichiAIFaith
--------------------------------------------------------------------------------------------------------------------------
function JFD_MburichiAIFaith(playerID, greatPersonID)
	local player = Players[playerID]
	if player:IsEverAlive() and not player:IsHuman() then
		local unit = player:GetUnitByID(greatPersonID)
		if unit:GetUnitType() == unitMburichiID then
			local faithReward = JFD_GetRandom(10,100)
			player:ChangeFaith(faithReward)
		end
	end
end

if isNriCivActive and not isNriActivePlayer then
	GameEvents.GreatPersonExpended.Add(JFD_MburichiAIFaith)
end
--------------------------------------------------------------------------------------------------------------------------
-- JFD_MburichiBarbFaith
--------------------------------------------------------------------------------------------------------------------------
local direction_types = {
	DirectionTypes.DIRECTION_NORTHEAST,
	DirectionTypes.DIRECTION_NORTHWEST,
	DirectionTypes.DIRECTION_EAST,
	DirectionTypes.DIRECTION_SOUTHEAST,
	DirectionTypes.DIRECTION_SOUTHWEST,
	DirectionTypes.DIRECTION_WEST
}
local playerBarbarianID = 63

function JFD_MburichiBarbFaith(playerID, unitID)
	local player = Players[playerID]
	if player:IsEverAlive() then
		local unit = player:GetUnitByID(unitID)
		if unit and unit:GetUnitType() == unitMburichiID then
			local unitX = unit:GetX()
			local unitY = unit:GetY()
			for loop, direction in ipairs(direction_types) do
				local adjPlot = Map.PlotDirection(unitX, unitY, direction)
				if adjPlot and adjPlot:IsUnit() then
					for adjUnitID = 0, adjPlot:GetNumUnits() - 1, 1 do
						local adjUnit = adjPlot:GetUnit(adjUnitID)
						if adjUnit and adjUnit:GetOwner() == playerBarbarianID and adjUnit:GetBaseCombatStrength() > 0 then
							local faithReward = adjUnit:GetBaseCombatStrength()
							local adjUnitX = adjUnit:GetX()
							local adjUnitY = adjUnit:GetY()
							adjUnit:Kill(true, playerID)
							player:ChangeFaith(faithReward)
							unit:ChangeDamage(20)
							if player:IsHuman() and player:IsTurnActive() then
								local hex = ToHexFromGrid(Vector2(adjUnitX, adjUnitY))
								Events.AddPopupTextEvent(HexToWorld(hex), Locale.ConvertTextKey("[COLOR_WHITE]+{1_Num}[ENDCOLOR][ICON_PEACE]", faithReward), 1)
								Events.GameplayFX(hex.x, hex.y, -1)
							end
						end
					end
				end
			end
		elseif unit and unit:GetOwner() == playerBarbarianID then
			local unitX = unit:GetX()
			local unitY = unit:GetY()
			for loop, direction in ipairs(direction_types) do
				local adjPlot = Map.PlotDirection(unitX, unitY, direction)
				if adjPlot and adjPlot:IsUnit() then
					for adjUnitID = 0, adjPlot:GetNumUnits() - 1, 1 do
						local adjUnit = adjPlot:GetUnit(adjUnitID)
						if adjUnit and adjUnit:GetUnitType() == unitMburichiID and unit:GetBaseCombatStrength() > 0 then
							local adjPlayerID = adjUnit:GetOwner()
							local adjPlayer = Players[adjPlayerID]
							local faithReward = unit:GetBaseCombatStrength()
							unit:Kill(true, adjPlayerID)
							adjPlayer:ChangeFaith(faithReward)
							adjUnit:ChangeDamage(20)
							if adjPlayer:IsHuman() and adjPlayer:IsTurnActive() then
								local hex = ToHexFromGrid(Vector2(unitX, unitY))
								Events.AddPopupTextEvent(HexToWorld(hex), Locale.ConvertTextKey("[COLOR_WHITE]+{1_Num}[ENDCOLOR][ICON_PEACE]", faithReward), 1)
								Events.GameplayFX(hex.x, hex.y, -1)
							end
						end
					end
				end
			end
		end
	end
end

function JFD_MburichiBarbFaithInitialTrigger(playerID, unitID)
	local player = Players[playerID]
	local unit = player:GetUnitByID(unitID)
	if unit and unit:GetUnitType() == unitMburichiID then
		GameEvents.UnitSetXY.Add(JFD_MburichiBarbFaith)
		Events.SerialEventUnitCreated.Add(JFD_MburichiBarbFaith)
		Events.SerialEventUnitCreated.Remove(JFD_MburichiBarbFaithInitialTrigger)
		save("GAME", "JFD_MburichiBarbFaithInitalised", true)
		JFD_MburichiBarbFaith(playerID, unitID)
	end
end

if load("GAME", "JFD_MburichiBarbFaithInitalised") then
	GameEvents.UnitSetXY.Add(JFD_MburichiBarbFaith)
	Events.SerialEventUnitCreated.Add(JFD_MburichiBarbFaith)
else
	Events.SerialEventUnitCreated.Add(JFD_MburichiBarbFaithInitialTrigger)
end
--==========================================================================================================================
-- UI FUNCTIONS -- Thanks to Gedemon for the help!
--==========================================================================================================================
-- Globals
-------------------------------------------------
local minorCivID = -1
local minorCivTeamID = -1
local cityStatePopupInfo = nil
local goldGiftLarge = GameDefines["MINOR_GOLD_GIFT_LARGE"]
local goldGiftMedium = GameDefines["MINOR_GOLD_GIFT_MEDIUM"]
local goldGiftSmall = GameDefines["MINOR_GOLD_GIFT_SMALL"]
local faithGiftLarge = math.ceil(goldGiftLarge * 50 / 100)
local faithGiftMedium = math.ceil(goldGiftMedium * 50 / 100)
local faithGiftSmall = math.ceil(goldGiftSmall * 50 / 100)

Controls.JFDShowFaithGiftsButton:SetHide(true)
--------------------------------------------------------------------------------------------------------------------------
-- JFD_HideFaithPurchaseOptions
--------------------------------------------------------------------------------------------------------------------------
function JFD_HideFaithPurchaseOptions()
	Controls.JFDFaithGiftStack:SetHide(true)
end
--------------------------------------------------------------------------------------------------------------------------
-- JFD_InitButton
--------------------------------------------------------------------------------------------------------------------------
function JFD_InitButton()
	if not ContextPtr:LookUpControl("/InGame/CityStateDiploPopup/ButtonStack"):IsHidden() then
		Controls.JFDShowFaithGiftsButton:ChangeParent(ContextPtr:LookUpControl("/InGame/CityStateDiploPopup/ButtonStack"))
		ContextPtr:LookUpControl("/InGame/CityStateDiploPopup/ButtonStack"):ReprocessAnchoring()
		Controls.JFDFaithGiftStack:ChangeParent(ContextPtr:LookUpControl("/InGame/CityStateDiploPopup/ButtonScrollPanel"))
		ContextPtr:LookUpControl("/InGame/CityStateDiploPopup/ButtonScrollPanel"):ReprocessAnchoring()
	end
end
--------------------------------------------------------------------------------------------------------------------------
-- JFD_OnBack
--------------------------------------------------------------------------------------------------------------------------
function JFD_OnBack()
	Controls.JFDFaithGiftStack:SetHide(true)
	ContextPtr:LookUpControl("/InGame/CityStateDiploPopup/ButtonStack"):SetHide(false)
	ContextPtr:LookUpControl("/InGame/CityStateDiploPopup/ButtonStack"):ReprocessAnchoring()
end

Controls.JFDFaithGiftBackButton:RegisterCallback(Mouse.eLClick, JFD_OnBack)
--------------------------------------------------------------------------------------------------------------------------
-- JFD_OnCityStateDiploPopup
--------------------------------------------------------------------------------------------------------------------------
local buttonPopupCityStateDiplo = ButtonPopupTypes["BUTTONPOPUP_CITY_STATE_DIPLO"]
local buttonPopupCityStateGreeting = ButtonPopupTypes["BUTTONPOPUP_CITY_STATE_GREETING"]

function JFD_OnCityStateDiploPopup(popupInfo)
	if popupInfo.Type ~= buttonPopupCityStateDiplo and popupInfo.Type ~= buttonPopupCityStateGreeting then
		return
	end
	cityStatePopupInfo = popupInfo
	local playerID = popupInfo.Data1
    local player = Players[playerID]
	local playerTeamID = player:GetTeam()
	local playerTeam = Teams[playerTeamID]
	minorCivID = playerID
    minorCivTeamID = playerTeamID
	local forcePeace = false
	JFD_UpdateDeclareWarButon()
	JFD_UpdateFaithGiftsButton()
end
--------------------------------------------------------------------------------------------------------------------------
-- JFD_OnGameDirty
--------------------------------------------------------------------------------------------------------------------------
function JFD_OnGameDirty()
	if ContextPtr:LookUpControl("/InGame/CityStateDiploPopup"):IsHidden() then
		return
	end	
	JFD_UpdateFaithGiftsButton()
end
--------------------------------------------------------------------------------------------------------------------------
-- JFD_OnPurchaseInfluenceSmall
--------------------------------------------------------------------------------------------------------------------------
function JFD_OnPurchaseInfluenceSmall()
	local player = Players[minorCivID]
	local smallInfluenceReward = player:GetFriendshipFromGoldGift(activePlayerID, goldGiftSmall)
	activePlayer:ChangeFaith(-faithGiftSmall)
	player:ChangeMinorCivFriendshipWithMajor(activePlayerID, smallInfluenceReward)
	JFD_OnBack()
end
--------------------------------------------------------------------------------------------------------------------------
-- JFD_OnPurchaseInfluenceMedium
--------------------------------------------------------------------------------------------------------------------------
function JFD_OnPurchaseInfluenceMedium()
	local player = Players[minorCivID]
	local mediumInfluenceReward = player:GetFriendshipFromGoldGift(activePlayerID, goldGiftMedium)
	activePlayer:ChangeFaith(-faithGiftMedium)
	player:ChangeMinorCivFriendshipWithMajor(activePlayerID, mediumInfluenceReward)
	JFD_OnBack()
end
--------------------------------------------------------------------------------------------------------------------------
-- JFD_OnPurchaseInfluenceLarge
--------------------------------------------------------------------------------------------------------------------------
function JFD_OnPurchaseInfluenceLarge()
	local player = Players[minorCivID]
	local largeInfluenceReward = player:GetFriendshipFromGoldGift(activePlayerID, goldGiftLarge)
	activePlayer:ChangeFaith(-faithGiftLarge)
	player:ChangeMinorCivFriendshipWithMajor(activePlayerID, largeInfluenceReward)
	JFD_OnBack()
end
--------------------------------------------------------------------------------------------------------------------------
-- JFD_ShowFaithPurchaseOptions
--------------------------------------------------------------------------------------------------------------------------
function JFD_ShowFaithPurchaseOptions()
	Controls.JFDFaithGiftStack:SetHide(false)
	ContextPtr:LookUpControl("/InGame/CityStateDiploPopup/ButtonStack"):SetHide(true)
	JFD_UpdateFaithGiftsStack()
end
--------------------------------------------------------------------------------------------------------------------------
-- JFD_UpdateFaithGiftsButton
--------------------------------------------------------------------------------------------------------------------------
function JFD_UpdateFaithGiftsButton()
	local minor = Players[minorCivID]
	local religionID = activePlayer:GetReligionCreatedByPlayer()
	local minorCapital = minor:GetCapitalCity()
	local isFaithGiftingDisabled = true
	if minorCapital then
		local minorCapitalReligionID = minorCapital:GetReligiousMajority()
		if not activeTeam:IsAtWar(minor:GetTeam()) and religionID > 0 and minorCapitalReligionID == religionID then
			isFaithGiftingDisabled = false
		end
		if isFaithGiftingDisabled then
			local disabledText = "[COLOR_FADING_NEGATIVE_TEXT]" .. Locale.ConvertTextKey("TXT_KEY_JFD_SHOW_FAITH_GIFTS_BUTTON") .. "[ENDCOLOR]"
			Controls.JFDShowFaithGiftsButton:SetText(disabledText)
			Controls.JFDShowFaithGiftsButton:LocalizeAndSetToolTip("TXT_KEY_JFD_SHOW_FAITH_GIFTS_BUTTON_TT_DISABLED")
		else
			Controls.JFDShowFaithGiftsButton:LocalizeAndSetText("TXT_KEY_JFD_SHOW_FAITH_GIFTS_BUTTON")
			Controls.JFDShowFaithGiftsButton:LocalizeAndSetToolTip("TXT_KEY_JFD_SHOW_FAITH_GIFTS_BUTTON_TT")
		end
	end
	Controls.JFDShowFaithGiftsButton:SetDisabled(isFaithGiftingDisabled)
	Controls.JFDShowFaithGiftsButton:SetHide(false)
end
--------------------------------------------------------------------------------------------------------------------------
-- JFD_UpdateDeclareWarButon
--------------------------------------------------------------------------------------------------------------------------
function JFD_UpdateDeclareWarButon()
	local minor = Players[minorCivID]
	local warButton = ContextPtr:LookUpControl("/InGame/CityStateDiploPopup/WarButton")
	local religionID = activePlayer:GetReligionCreatedByPlayer()
	local minorCapital = minor:GetCapitalCity()
	local isFaithGiftingDisabled = true
	if minorCapital then
		local minorCapitalReligionID = minorCapital:GetReligiousMajority()
		if not activeTeam:IsAtWar(minor:GetTeam()) and religionID > 0 and minorCapitalReligionID == religionID and activePlayer:GetCurrentEra() < eraIndustrialID then
			local disabledText = "[COLOR_FADING_NEGATIVE_TEXT]" .. Locale.ConvertTextKey("TXT_KEY_POP_CSTATE_DECLARE_WAR") .. "[ENDCOLOR]"
			warButton:SetDisabled(true)
			warButton:LocalizeAndSetText(disabledText)
			warButton:LocalizeAndSetToolTip("TXT_KEY_JFD_NRI_WAR_BUTTON_TT_DISABLED")
		else
			warButton:SetDisabled(false)
			warButton:LocalizeAndSetText("TXT_KEY_POP_CSTATE_DECLARE_WAR")
			warButton:LocalizeAndSetToolTip(nil)
		end
	end
end
--------------------------------------------------------------------------------------------------------------------------
-- JFD_UpdateFaithGiftsStack
--------------------------------------------------------------------------------------------------------------------------
local friendsAmount = GameDefines["FRIENDSHIP_THRESHOLD_FRIENDS"]
local alliesAmount = GameDefines["FRIENDSHIP_THRESHOLD_ALLIES"]
   
function JFD_UpdateFaithGiftsStack()
	local player = Players[minorCivID]
	Controls.JFDFaithGift1:SetDisabled(false)
	Controls.JFDFaithGift2:SetDisabled(false)
	Controls.JFDFaithGift3:SetDisabled(false)
	local largeInfluenceReward = player:GetFriendshipFromGoldGift(activePlayerID, goldGiftLarge)
	local largeGiftText	= Locale.ConvertTextKey("TXT_KEY_JFD_FAITH_GIFT_LARGE", faithGiftLarge, largeInfluenceReward)
	local mediumInfluenceReward = player:GetFriendshipFromGoldGift(activePlayerID, goldGiftMedium)
	local mediumGiftText = Locale.ConvertTextKey("TXT_KEY_JFD_FAITH_GIFT_MEDIUM", faithGiftMedium, mediumInfluenceReward)
	local smallInfluenceReward = player:GetFriendshipFromGoldGift(activePlayerID, goldGiftSmall)
	local smallGiftText  = Locale.ConvertTextKey("TXT_KEY_JFD_FAITH_GIFT_SMALL", faithGiftSmall, smallInfluenceReward)
	local playerFaith = activePlayer:GetFaith()
	if playerFaith < faithGiftSmall then
		smallGiftText = "[COLOR_WARNING_TEXT]" .. smallGiftText .. "[ENDCOLOR]"
		Controls.JFDFaithGift1:SetDisabled(true)
		Controls.JFDFaithGift1Anim:SetHide(true)
	else	
		Controls.JFDFaithGift1Anim:SetHide(false)
	end
	Controls.JFDFaithGift1:SetText(smallGiftText)
	JFD_SetButtonSize(Controls.JFDFaithGift1, Controls.JFDFaithGift1Button, Controls.JFDFaithGift1Anim, Controls.JFDFaithGift1ButtonHL)
	if playerFaith < faithGiftMedium then
		mediumGiftText = "[COLOR_WARNING_TEXT]" .. mediumGiftText .. "[ENDCOLOR]"
		Controls.JFDFaithGift2:SetDisabled(true)
		Controls.JFDFaithGift2Anim:SetHide(true)
	else	
		Controls.JFDFaithGift2Anim:SetHide(false)
	end
	Controls.JFDFaithGift2:SetText(mediumGiftText)
	JFD_SetButtonSize(Controls.JFDFaithGift2, Controls.JFDFaithGift2Button, Controls.JFDFaithGift2Anim, Controls.JFDFaithGift2ButtonHL)
	if playerFaith < faithGiftLarge then
		largeGiftText = "[COLOR_WARNING_TEXT]" .. largeGiftText .. "[ENDCOLOR]"
		Controls.JFDFaithGift3:SetDisabled(true)
		Controls.JFDFaithGift3Anim:SetHide(true)
	else	
		Controls.JFDFaithGift3Anim:SetHide(false)
	end
	Controls.JFDFaithGift3:SetText(largeGiftText)
	JFD_SetButtonSize(Controls.JFDFaithGift3, Controls.JFDFaithGift3Button, Controls.JFDFaithGift3Anim, Controls.JFDFaithGift3ButtonHL)
	local currentFriendship = player:GetMinorCivFriendshipWithMajor(activePlayerID)
	local faithGiftTT = Locale.ConvertTextKey("TXT_KEY_JFD_FAITH_GIFT_STATUS_TT", friendsAmount, alliesAmount, currentFriendship) .. "[NEWLINE][NEWLINE]" .. Locale.ConvertTextKey("TXT_KEY_JFD_FAITH_GIFT_TT")
	Controls.JFDFaithGift1:LocalizeAndSetToolTip(faithGiftTT)
	Controls.JFDFaithGift2:LocalizeAndSetToolTip(faithGiftTT)
	Controls.JFDFaithGift3:LocalizeAndSetToolTip(faithGiftTT)
end

if isNriCivActive and isNriActivePlayer then
	Events.SerialEventGameMessagePopupProcessed.Add(JFD_HideFaithPurchaseOptions)
	Events.SerialEventGameMessagePopup.Add(JFD_InitButton)
	Events.SerialEventGameMessagePopup.Add(JFD_OnCityStateDiploPopup)
	Events.SerialEventGameDataDirty.Add(JFD_OnGameDirty)
	Controls.JFDFaithGift1Button:RegisterCallback(Mouse.eLClick, JFD_OnPurchaseInfluenceSmall)
	Controls.JFDFaithGift2Button:RegisterCallback(Mouse.eLClick, JFD_OnPurchaseInfluenceMedium)
	Controls.JFDFaithGift3Button:RegisterCallback(Mouse.eLClick, JFD_OnPurchaseInfluenceLarge)
	Controls.JFDShowFaithGiftsButton:RegisterCallback(Mouse.eLClick, JFD_ShowFaithPurchaseOptions)
end
--==========================================================================================================================
--==========================================================================================================================