-- JFD_EgyptAkhenaten_Functions
-- Author: JFD
-- Edited By: F0S
--==========================================================================================================================
-- INCLUDES
--==========================================================================================================================
include("FLuaVector.lua")
include("JFD_EgyptAkhenaten_Utils.lua")
WARN_NOT_SHARED = false; include("Sukritact_SaveUtils.lua"); MY_MOD_NAME = "JFD_EgyptAkhenaten";
include("NewSaveUtils.lua")
include("PlotIterators.lua")
include("UniqueDiplomacyUtilsV2.lua")
--==========================================================================================================================
-- UTILITY FUNCTIONS
--==========================================================================================================================
-- MOD CHECKS
--------------------------------------------------------------------------------------------------------------------------
-- JFD_IsCivilisationActive
function JFD_IsCivilisationActive(civilizationID)
	for iSlot = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
		local slotStatus = PreGame.GetSlotStatus(iSlot)
		if slotStatus == SlotStatus["SS_TAKEN"] or slotStatus == SlotStatus["SS_COMPUTER"] then
			if PreGame.GetCivilization(iSlot) == civilizationID then
				return true
			end
		end
	end
	return false
end
--------------------------------------------------------------------------------------------------------------------------
-- UTILITIES
--------------------------------------------------------------------------------------------------------------------------
-- JFD_GetRandom
function JFD_GetRandom(lower, upper)
    return Game.Rand((upper + 1) - lower, "") + lower
end
--==========================================================================================================================
-- GLOBALS
--==========================================================================================================================
-- Globals
----------------------------------------------------------------------------------------------------------------------------
local activePlayerID				= Game.GetActivePlayer()
local activePlayer					= Players[activePlayerID]
local civilizationID 				= GameInfoTypes["CIVILIZATION_JFD_EGYPT_AKHENATEN"]
local isEgyptAkhenatenCivActive		= JFD_IsCivilisationActive(civilizationID)
local isEgyptAkhenatenActivePlayer	= activePlayer:GetCivilizationType() == civilizationID
--==========================================================================================================================
-- DIPLOMACY FUNCTIONS
--==========================================================================================================================
-- DIPLOMACY
----------------------------------------------------------------------------------------------------------------------------
local civilizationNubiaID = GameInfoTypes["CIVILIZATION_MC_LITE_NUBIA"]
local leaderRamessesID = GameInfoTypes["LEADER_RAMESSES"]

function JFD_Akhenaten_UniqueResponses()
	-- If the player is Ramesses
	if leaderRamessesID and activePlayer:GetLeaderType() == leaderRamessesID then
		ChangeDiplomacyResponse("LEADER_JFD_AKHENATEN", "RESPONSE_FIRST_GREETING", "TXT_KEY_LEADER_JFD_AKHENATEN_FIRSTGREETING%", "TXT_KEY_LEADER_JFD_AKHENATEN_FIRSTGREETING_RAMESSES_1", 500)
	-- If the player is MC's Nubia
	elseif civilizationNubiaID and activePlayer:GetCivilizationType() == civilizationNubiaID then
		ChangeDiplomacyResponse("LEADER_JFD_AKHENATEN", "RESPONSE_FIRST_GREETING", "TXT_KEY_LEADER_JFD_AKHENATEN_FIRSTGREETING%", "TXT_KEY_LEADER_JFD_AKHENATEN_FIRSTGREETING_NUBIA_1", 500)
	end
end

for playerID = 0, GameDefines.MAX_MAJOR_CIVS - 1, 1 do
	local player = Players[playerID]
	if player and player:IsEverAlive() and not player:IsHuman() and player:GetCivilizationType() == civilizationID then
		Events.SequenceGameInitComplete.Add(JFD_Akhenaten_UniqueResponses)
		break
	end
end
--==========================================================================================================================
-- UNIQUE FUNCTIONS
--==========================================================================================================================
-- GREAT HYMN TO THE ATEN
----------------------------------------------------------------------------------------------------------------------------
local unitGreatProphetID = GameInfoTypes["UNIT_PROPHET"]
local promotionGreatProphetID = GameInfoTypes["PROMOTION_JFD_ATEN"]

-- JFD_EgyptAkhenaten_OnGreatProphetCreated
function JFD_EgyptAkhenaten_OnGreatProphetCreated(playerID, unitID)
    local player = Players[playerID]
    if player:IsEverAlive() and player:GetCivilizationType() == civilizationID then
		local currentNumAtenVersesAvailable = JFD_GetNumVersesAvailable()
		if currentNumAtenVersesAvailable < 4 then
			local unit = player:GetUnitByID(unitID)
			if unit:GetUnitType() == unitGreatProphetID and not unit:IsHasPromotion(promotionGreatProphetID) then
				unit:SetHasPromotion(promotionGreatProphetID, true)
				JFD_ChangeNumVersesAvailable(playerID)
			end
		end
    end
end
----------------
-- UI
----------------
local addVerseToSlot = true
local currentCity = nil
local verseSlotIndex = 1

-- JFD_UpdateCitySizeValY
function JFD_UpdateCitySizeValY()
	if not citySizeY then
		if ContextPtr:LookUpControl("/InGame/CityView/CityInfoBG") then
			local cityInfoBG = ContextPtr:LookUpControl("/InGame/CityView/CityInfoBG")
			local cityInfoBGsizeY = cityInfoBG:GetSizeY()
			local newSizeY = cityInfoBGsizeY + 28
			SetPersistentProperty("JFD_CitySizeY", newSizeY)
		else
			local topLeftPanel = ContextPtr:LookUpControl("/InGame/CityView/TopLeft")
			local topLeftPanelSizeY = topLeftPanel:GetSizeY()
			local newSizeY = topLeftPanelSizeY + 34
			SetPersistentProperty("JFD_CitySizeY", newSizeY)
		end
	end
end

-- JFD_UpdateCapitalHymnBox
function JFD_UpdateCapitalHymnBox()
	local city = UI.GetHeadSelectedCity()
	if city then
		currentCity = city
		if Controls.VerseBox:IsHidden() then
			local cultureBox = ContextPtr:LookUpControl("/InGame/CityView/CultureBox")
			Controls.VerseBox:ChangeParent(cultureBox)
			Controls.VerseBox:SetHide(false)
			if ContextPtr:LookUpControl("/InGame/CityView/CityInfoBG") then
				local cityInfoBG = ContextPtr:LookUpControl("/InGame/CityView/CityInfoBG")
				local cityInfoBGSizeY = cityInfoBG:GetSizeY()
				local cityInfoBGNewSizeY = GetPersistentProperty("JFD_CitySizeY")
				if cityInfoBGSizeY < cityInfoBGNewSizeY then
					cityInfoBG:SetSizeY(cityInfoBGNewSizeY) 
				end
			else
				local topLeftPanel = ContextPtr:LookUpControl("/InGame/CityView/TopLeft")
				local topLeftPanelSizeY = topLeftPanel:GetSizeY()
				local topLeftPanelNewSizeY = GetPersistentProperty("JFD_CitySizeY")
				if topLeftPanelSizeY < topLeftPanelNewSizeY then
					topLeftPanel:SetSizeY(topLeftPanelNewSizeY) 
				end
			end
			if not OptionsManager.GetSmallUIAssets() then
				Controls.VerseBox:SetSizeVal(240,32)
				Controls.VerseLine:SetSizeVal(240,32)
			end
		end
		local numVersesAvailable = JFD_GetNumVersesAvailable()
		local numVersesUsed = JFD_GetNumAtenVersesUsed(activePlayerID)
		local numVersesUsedThisCity = JFD_GetNumAtenVersesUsedThisCity(activePlayerID, city)
		local numVersesUnassigned = numVersesAvailable - numVersesUsed
		Controls.VerseCount:LocalizeAndSetText("TXT_KEY_JFD_EGYPT_AKHEANTEN_VERSE_COUNT", numVersesUsedThisCity, numVersesUnassigned)
		Controls.VerseCount:LocalizeAndSetToolTip("TXT_KEY_JFD_EGYPT_AKHEANTEN_VERSE_COUNT_TT", numVersesUsedThisCity, numVersesUnassigned)
		for verseNum = 1, 4 do
			local numString = tostring(verseNum)
			local controlName = "VerseGreatWork"..numString
			local thisVerse = Controls[controlName]
			local hasVerse = JFD_HasVerse(activePlayerID, city, verseNum)
			if hasVerse then
				thisVerse:SetTexture("GreatWorks_Hymn.dds")
				thisVerse:LocalizeAndSetToolTip("TXT_KEY_JFD_EGYPT_AKHEANTEN_VERSE_FILLED_TT")
				if verseNum == 1 then
					thisVerse:RegisterCallback(Mouse.eRClick, JFD_ShowVersePopup1)
					thisVerse:RegisterCallback(Mouse.eLClick, JFD_RemoveVerse1)
					thisVerse:SetDisabled(false)
				elseif verseNum == 2 then
					thisVerse:RegisterCallback(Mouse.eRClick, JFD_ShowVersePopup2)
					thisVerse:RegisterCallback(Mouse.eLClick, JFD_RemoveVerse2)
					thisVerse:SetDisabled(false)
				elseif verseNum == 3 then
					thisVerse:RegisterCallback(Mouse.eRClick, JFD_ShowVersePopup3)
					thisVerse:RegisterCallback(Mouse.eLClick, JFD_RemoveVerse3)
					thisVerse:SetDisabled(false)
				elseif verseNum == 4 then
					thisVerse:RegisterCallback(Mouse.eRClick, JFD_ShowVersePopup4)
					thisVerse:RegisterCallback(Mouse.eLClick, JFD_RemoveVerse4)
					thisVerse:SetDisabled(false)
				end
			else
				thisVerse:SetTexture("GreatWorks_Hymn_Empty.dds")
				thisVerse:SetDisabled(true)
				thisVerse:LocalizeAndSetToolTip("TXT_KEY_JFD_EGYPT_AKHEANTEN_VERSE_DISABLED_TT_".. verseNum)
				local verseLocation = JFD_FindVerseLocation(activePlayerID, verseNum)
				if not verseLocation then
					if numVersesAvailable >= verseNum then
						thisVerse:LocalizeAndSetToolTip("TXT_KEY_JFD_EGYPT_AKHEANTEN_VERSE_UNFILLED_TT_".. verseNum)
						thisVerse:SetDisabled(false)
					end
				else
					local cityName = verseLocation:GetName()
					thisVerse:LocalizeAndSetToolTip("TXT_KEY_JFD_EGYPT_AKHEANTEN_VERSE_UNFILLED_OTHER_CITY_TT_".. verseNum, cityName)
				end
				if numVersesUnassigned > 0 then
					if verseNum == 1 then
						thisVerse:RegisterCallback(Mouse.eLClick, JFD_AddVerse1)
						thisVerse:ClearCallback(Mouse.eRClick)
					elseif verseNum == 2 then
						thisVerse:RegisterCallback(Mouse.eLClick, JFD_AddVerse2)
						thisVerse:ClearCallback(Mouse.eRClick)
					elseif verseNum == 3 then
						thisVerse:RegisterCallback(Mouse.eLClick, JFD_AddVerse3)
						thisVerse:ClearCallback(Mouse.eRClick)
					elseif verseNum == 4 then
						thisVerse:RegisterCallback(Mouse.eLClick, JFD_AddVerse4)
						thisVerse:ClearCallback(Mouse.eRClick)
					end
					if numVersesAvailable >= verseNum then
						thisVerse:SetDisabled(false)
					end
				end
			end
			local hasCompleteHymn = JFD_HasCompleteHymn(playerID, city)
			if hasCompleteHymn then
				Controls.VerseGreatWorkHL1:SetHide(false)
				Controls.VerseGreatWorkHL2:SetHide(false)
				Controls.VerseGreatWorkHL3:SetHide(false)
				Controls.VerseGreatWorkHL4:SetHide(false)
				Controls.VerseCount:LocalizeAndSetToolTip("TXT_KEY_JFD_EGYPT_AKHEANTEN_VERSE_COUNT_COMPLETE_TT")
				JFD_PlaceCompleteObelisk(city)
			else
				Controls.VerseGreatWorkHL1:SetHide(true)
				Controls.VerseGreatWorkHL2:SetHide(true)
				Controls.VerseGreatWorkHL3:SetHide(true)
				Controls.VerseGreatWorkHL4:SetHide(true)
				JFD_RemoveCompleteObelisk(city)
			end
		end
	else
		Controls.VerseBox:SetHide(true)
	end
end

if isEgyptAkhenatenActivePlayer then
	Events.LoadScreenClose.Add(JFD_UpdateCitySizeValY)
	Events.SerialEventEnterCityScreen.Add(JFD_UpdateCapitalHymnBox)
	Events.SerialEventCityScreenDirty.Add(JFD_UpdateCapitalHymnBox)
end
----------------
-- ASSIGN VERSE
----------------
-- JFD_AddVerse1
function JFD_AddVerse1()
	addVerseToSlot = true
	verseSlotIndex = 1
	Controls.ChooseConfirm:SetHide(false)
	Controls.ConfirmText:LocalizeAndSetText("TXT_KEY_JFD_EGYPT_AKHEANTEN_CONFIRM_TEXT_ADD")
end

-- JFD_AddVerse2
function JFD_AddVerse2()
	addVerseToSlot = true
	verseSlotIndex = 2
	Controls.ChooseConfirm:SetHide(false)
	Controls.ConfirmText:LocalizeAndSetText("TXT_KEY_JFD_EGYPT_AKHEANTEN_CONFIRM_TEXT_ADD")
end

-- JFD_AddVerse3
function JFD_AddVerse3()
	addVerseToSlot = true
	verseSlotIndex = 3
	Controls.ChooseConfirm:SetHide(false)
	Controls.ConfirmText:LocalizeAndSetText("TXT_KEY_JFD_EGYPT_AKHEANTEN_CONFIRM_TEXT_ADD")
end

-- JFD_AddVerse4
function JFD_AddVerse4()
	addVerseToSlot = true
	verseSlotIndex = 4
	Controls.ChooseConfirm:SetHide(false)
	Controls.ConfirmText:LocalizeAndSetText("TXT_KEY_JFD_EGYPT_AKHEANTEN_CONFIRM_TEXT_ADD")
end

-- JFD_RemoveVerse1
function JFD_RemoveVerse1()
	addVerseToSlot = false
	verseSlotIndex = 1
	Controls.ChooseConfirm:SetHide(false)
	Controls.ConfirmText:LocalizeAndSetText("TXT_KEY_JFD_EGYPT_AKHEANTEN_CONFIRM_TEXT_REMOVE")
end

-- JFD_RemoveVerse2
function JFD_RemoveVerse2()
	addVerseToSlot = false
	verseSlotIndex = 2
	Controls.ChooseConfirm:SetHide(false)
	Controls.ConfirmText:LocalizeAndSetText("TXT_KEY_JFD_EGYPT_AKHEANTEN_CONFIRM_TEXT_REMOVE")
end

-- JFD_RemoveVerse3
function JFD_RemoveVerse3()
	addVerseToSlot = false
	verseSlotIndex = 3
	Controls.ChooseConfirm:SetHide(false)
	Controls.ConfirmText:LocalizeAndSetText("TXT_KEY_JFD_EGYPT_AKHEANTEN_CONFIRM_TEXT_REMOVE")
end

-- JFD_RemoveVerse4
function JFD_RemoveVerse4()
	addVerseToSlot = false
	verseSlotIndex = 4
	Controls.ChooseConfirm:SetHide(false)
	Controls.ConfirmText:LocalizeAndSetText("TXT_KEY_JFD_EGYPT_AKHEANTEN_CONFIRM_TEXT_REMOVE")
end

-- JFD_ShowVersePopup1
function JFD_ShowVersePopup1()
	LuaEvents.JFD_ShowVersePopup(1)
end
-- JFD_ShowVersePopup2
function JFD_ShowVersePopup2()
	LuaEvents.JFD_ShowVersePopup(2)
end
-- JFD_ShowVersePopup3
function JFD_ShowVersePopup3()
	LuaEvents.JFD_ShowVersePopup(3)
end
-- JFD_ShowVersePopup4
function JFD_ShowVersePopup4()
	LuaEvents.JFD_ShowVersePopup(4)
end
----------------
-- CONFIRMATION
----------------
-- JFD_OnConfirmYes
function JFD_OnConfirmYes()
	local city = currentCity
	if addVerseToSlot then
		JFD_SetHasVerse(activePlayerID, city, verseSlotIndex, 1)
		local hex = ToHexFromGrid(Vector2(city:GetX(), city:GetY()))
		Events.GameplayFX(hex.x, hex.y, -1)
	else
		JFD_SetHasVerse(activePlayerID, city, verseSlotIndex, 0)
	end
	Controls.ChooseConfirm:SetHide(true)
	JFD_UpdateCapitalHymnBox()
end
Controls.ConfirmYes:RegisterCallback(Mouse.eLClick, JFD_OnConfirmYes)

-- JFD_OnConfirmNo
function JFD_OnConfirmNo()
	Controls.ChooseConfirm:SetHide(true)
end
Controls.ConfirmNo:RegisterCallback(Mouse.eLClick, JFD_OnConfirmNo)
----------------------------------------------------------------------------------------------------------------------------
-- OBELISK
----------------------------------------------------------------------------------------------------------------------------
local improvementObeliskID = GameInfoTypes["IMPROVEMENT_JFD_OBELISK"]
local improvementCompleteObeliskID = GameInfoTypes["IMPROVEMENT_JFD_COMPLETE_OBELISK"]
local resourceWheatID = GameInfoTypes["RESOURCE_JFD_WHEAT"]

-- JFD_EgyptAkhenaten_OnObeliskConstructed
function JFD_EgyptAkhenaten_OnObeliskConstructed(playerID, plotX, plotY, improvementID)
	local player = Players[playerID]
	if player:IsEverAlive() and player:GetCivilizationType() == civilizationID then 
		local plot = Map.GetPlot(plotX, plotY)
		if plot:GetOwner() == playerID then
			for city in player:Cities() do
				for i = 0, city:GetNumCityPlots() - 1, 1 do
					local uPlot = city:GetCityIndexPlot(i)
					if uPlot and uPlot == plot then
						if improvementID == improvementObeliskID then
							local chanceWheat = 10 + (10 * JFD_GetNumVersesAvailable())
							if JFD_HasCompleteHymn(playerID,city) then
								uPlot:SetImprovementType(improvementCompleteObeliskID)
							end
							if JFD_GetRandom(0,99) < chanceWheat then
								JFD_PlaceObeliskWheat(playerID, uPlot)
							end
						end 
					end
				end
			end
		end	
	end
end

-- JFD_EgyptAkhenaten_CityCaptured
function JFD_EgyptAkhenaten_CityCaptured(oldOwnerID, capital, plotX, plotY, newOwnerID)
	local player = Players[oldOwnerID]
	if player:GetCivilizationType() == civilizationID then
		local capturedCity = Map.GetPlot(plotX, plotY):GetPlotCity()
		JFD_RemoveCompleteObelisk(capturedCity)
	end
end

-- JFD_UpgradeObelisksDirty
function JFD_UpgradeObelisksDirty()
	if activePlayer:IsEverAlive() and isEgyptAkhenatenActivePlayer then
		for city in activePlayer:Cities() do
			if city then
				if JFD_HasCompleteHymn(activePlayerID, city) then
					JFD_PlaceCompleteObelisk(city)
				else
					JFD_RemoveCompleteObelisk(city)
				end
			end
		end
	end
end
----------------------------------------------------------------------------------------------------------------------------
-- KOPESH
----------------------------------------------------------------------------------------------------------------------------
local unitPromotionKhopeshID = GameInfoTypes["PROMOTION_JFD_KHOPESH"] 
local unitPromotionKhopeshDoubleID = GameInfoTypes["PROMOTION_JFD_KHOPESH_DOUBLE"]
local unitPromotionKhopeshMountedID = GameInfoTypes["PROMOTION_JFD_KHOPESH_MOUNTED"] 
local unitPromotionKhopeshMountedDoubleID = GameInfoTypes["PROMOTION_JFD_KHOPESH_MOUNTED_DOUBLE"] 

-- JFD_EgyptAkhenaten_Khopesh
function JFD_EgyptAkhenaten_Khopesh(unit)
	if unit:IsHasPromotion(unitPromotionKhopeshID) or unit:IsHasPromotion(unitPromotionKhopeshDoubleID) then
		local isUnitNearToObelisk = false
		local unitPlot = unit:GetPlot()
		for adjacentPlot in PlotAreaSweepIterator(unitPlot, 2, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_INCLUDE) do
			if adjacentPlot:GetImprovementType() == improvementObeliskID or adjacentPlot:GetImprovementType() == improvementCompleteObeliskID then 
				isUnitNearToObelisk = true
				break
			end
		end
		if isUnitNearToObelisk then
			if unit:IsHasPromotion(unitPromotionKhopeshID) then
				unit:SetHasPromotion(unitPromotionKhopeshID, false)
				unit:SetHasPromotion(unitPromotionKhopeshDoubleID, true)
			end
			if unit:IsHasPromotion(unitPromotionKhopeshMountedID) then
				unit:SetHasPromotion(unitPromotionKhopeshMountedID, false)
				unit:SetHasPromotion(unitPromotionKhopeshMountedDoubleID, true)
			end
		else
			if unit:IsHasPromotion(unitPromotionKhopeshDoubleID) then
				unit:SetHasPromotion(unitPromotionKhopeshID, true)
				unit:SetHasPromotion(unitPromotionKhopeshDoubleID, false)
			end
			if unit:IsHasPromotion(unitPromotionKhopeshMountedDoubleID) then
				unit:SetHasPromotion(unitPromotionKhopeshMountedID, true)
				unit:SetHasPromotion(unitPromotionKhopeshMountedDoubleID, false)
			end
		end
	end
end

-- JFD_EgyptAkhenaten_KhopeshTurn
function JFD_EgyptAkhenaten_KhopeshTurn(playerID)
	local player = Players[playerID]
	if player:IsEverAlive() then
		for unit in player:Units() do
			JFD_EgyptAkhenaten_Khopesh(unit)
		end
	end
end

-- JFD_EgyptAkhenaten_KhopeshXY
function JFD_EgyptAkhenaten_KhopeshXY(playerID, unitID, plotX, plotY)
	local player = Players[playerID]
	if player:IsEverAlive() then
		local unit = player:GetUnitByID(unitID)
		if unit then
			JFD_EgyptAkhenaten_Khopesh(unit)
		end
	end
end

-- JFD_KhopeshInitialTrigger
function JFD_KhopeshInitialTrigger(playerID, unitID)
	local player = Players[playerID]
	local unit = player:GetUnitByID(unitID)
	if unit and unit:IsHasPromotion(unitPromotionKhopeshID) then
		GameEvents.PlayerDoTurn.Add(JFD_EgyptAkhenaten_KhopeshTurn)
		GameEvents.UnitSetXY.Add(JFD_EgyptAkhenaten_KhopeshXY)
		Events.SerialEventUnitCreated.Add(JFD_EgyptAkhenaten_KhopeshXY)
		GameEvents.BuildFinished.Add(JFD_EgyptAkhenaten_KhopeshTurn)
		Events.SerialEventUnitCreated.Remove(JFD_KhopeshInitialTrigger)
		save("GAME", "JFD_KhopeshInitalised", true)
		JFD_EgyptAkhenaten_Khopesh(unit)
	end
end

if isEgyptAkhenatenCivActive then
	Events.SerialEventUnitCreated.Add(JFD_EgyptAkhenaten_OnGreatProphetCreated)
	GameEvents.BuildFinished.Add(JFD_EgyptAkhenaten_OnObeliskConstructed)
	GameEvents.CityCaptureComplete.Add(JFD_EgyptAkhenaten_CityCaptured)
	Events.SerialEventCityInfoDirty.Add(JFD_UpgradeObelisksDirty)
	if load("GAME", "JFD_KhopeshInitalised") then
		GameEvents.PlayerDoTurn.Add(JFD_EgyptAkhenaten_KhopeshTurn)
		GameEvents.UnitSetXY.Add(JFD_EgyptAkhenaten_KhopeshXY)
		Events.SerialEventUnitCreated.Add(JFD_EgyptAkhenaten_KhopeshXY)
		GameEvents.BuildFinished.Add(JFD_EgyptAkhenaten_KhopeshTurn)
	else
		Events.SerialEventUnitCreated.Add(JFD_KhopeshInitialTrigger)
	end
end
--==========================================================================================================================
--==========================================================================================================================