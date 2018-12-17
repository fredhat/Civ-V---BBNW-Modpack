-- KaiKaiGPScript
-- Author: JFD
-- Heavily Edited By: F0S
--=======================================================================================================================
WARN_NOT_SHARED = false; include( "Sukritact_SaveUtils.lua" ); MY_MOD_NAME = "KaiKaiGPScript";
include("FLuaVector.lua")
--=======================================================================================================================
-- Utility Functions
--=======================================================================================================================
-- JFD_IsCivilisationActive
-------------------------------------------------------------------------------------------------------------------------
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
-------------------------------------------------------------------------------------------------------------------------
-- JFD_GetRandom
-------------------------------------------------------------------------------------------------------------------------
function JFD_GetRandom(lower, upper)
	return Game.Rand((upper + 1) - lower, "") + lower
end
--=======================================================================================================================
-- JFD_KaiKaiLore
--=======================================================================================================================
local specialistArtistID = GameInfoTypes["SPECIALIST_ARTIST"]
local specialistMusicianID = GameInfoTypes["SPECIALIST_MUSICIAN"]
local specialistWriterID = GameInfoTypes["SPECIALIST_WRITER"]
local civilisationID = GameInfoTypes["CIVILIZATION_MC_RAPA_NUI"]
local iModifier = ((GameInfo.GameSpeeds[Game.GetGameSpeedType()].GoldPercent)/100)
local iProduction = math.ceil(12 * iModifier)
local iGPP = math.ceil(3 * iModifier) * 100

function JFD_KaiKaiLoreFounded(playerID, iX, iY)
	local player = Players[playerID]
	if player:IsEverAlive() and player:GetCivilizationType() == civilisationID then
		local city = Map.GetPlot(iX, iY):GetPlotCity()
		if city then
			local rand = JFD_GetRandom(1, 3)
			if rand == 1 then
				city:ChangeSpecialistGreatPersonProgressTimes100(specialistArtistID, iGPP)
				if player:IsHuman() and player:IsTurnActive() then
					local hex = ToHexFromGrid(Vector2(city:GetX(), city:GetY()))
					Events.AddPopupTextEvent(HexToWorld(hex), Locale.ConvertTextKey("[COLOR_POSITIVE_TEXT]+{1_Num}[ENDCOLOR] [ICON_GREAT_ARTIST]", (iGPP / 100)), 1)
					Events.GameplayFX(hex.x, hex.y, -1)
				end
			elseif rand == 2 then
				city:ChangeSpecialistGreatPersonProgressTimes100(specialistMusicianID, iGPP)
				if player:IsHuman() and player:IsTurnActive() then
					local hex = ToHexFromGrid(Vector2(city:GetX(), city:GetY()))
					Events.AddPopupTextEvent(HexToWorld(hex), Locale.ConvertTextKey("[COLOR_POSITIVE_TEXT]+{1_Num}[ENDCOLOR] [ICON_GREAT_MUSICIAN]", (iGPP / 100)), 1)
					Events.GameplayFX(hex.x, hex.y, -1)
				end
			else 
				city:ChangeSpecialistGreatPersonProgressTimes100(specialistWriterID, iGPP)
				if player:IsHuman() and player:IsTurnActive() then
					local hex = ToHexFromGrid(Vector2(city:GetX(), city:GetY()))
					Events.AddPopupTextEvent(HexToWorld(hex), Locale.ConvertTextKey("[COLOR_POSITIVE_TEXT]+{1_Num}[ENDCOLOR] [ICON_GREAT_WRITER]", (iGPP / 100)), 1)
					Events.GameplayFX(hex.x, hex.y, -1)
				end
			end
		end
	end
end

function JFD_KaiKaiLorePopulation(iX, iY, oldPopulation, newPopulation)
	local city = Map.GetPlot(iX, iY):GetPlotCity()
	if city then
		local player = Players[city:GetOwner()]
		if player:IsEverAlive() and player:GetCivilizationType() == civilisationID then
			local CultureGPBoost = newPopulation * iGPP
			if CultureGPBoost > iGPP then
				local rand = JFD_GetRandom(1, 3)
				if rand == 1 then
					city:ChangeSpecialistGreatPersonProgressTimes100(specialistArtistID, CultureGPBoost)
					if player:IsHuman() and player:IsTurnActive() then
						local hex = ToHexFromGrid(Vector2(city:GetX(), city:GetY()))
						Events.AddPopupTextEvent(HexToWorld(hex), Locale.ConvertTextKey("[COLOR_POSITIVE_TEXT]+{1_Num}[ENDCOLOR] [ICON_GREAT_ARTIST]", (CultureGPBoost / 100)), 1)
						Events.GameplayFX(hex.x, hex.y, -1)
					end
				elseif rand == 2 then
					city:ChangeSpecialistGreatPersonProgressTimes100(specialistMusicianID, CultureGPBoost)
					if player:IsHuman() and player:IsTurnActive() then
						local hex = ToHexFromGrid(Vector2(city:GetX(), city:GetY()))
						Events.AddPopupTextEvent(HexToWorld(hex), Locale.ConvertTextKey("[COLOR_POSITIVE_TEXT]+{1_Num}[ENDCOLOR] [ICON_GREAT_MUSICIAN]", (CultureGPBoost / 100)), 1)
						Events.GameplayFX(hex.x, hex.y, -1)
					end
				else 
					city:ChangeSpecialistGreatPersonProgressTimes100(specialistWriterID, CultureGPBoost)
					if player:IsHuman() and player:IsTurnActive() then
						local hex = ToHexFromGrid(Vector2(city:GetX(), city:GetY()))
						Events.AddPopupTextEvent(HexToWorld(hex), Locale.ConvertTextKey("[COLOR_POSITIVE_TEXT]+{1_Num}[ENDCOLOR] [ICON_GREAT_WRITER]", (CultureGPBoost / 100)), 1)
						Events.GameplayFX(hex.x, hex.y, -1)
					end
				end
			end
		end
	end
end
--=======================================================================================================================
-- JFD_KaiKaiProduction
--=======================================================================================================================
function JFD_KaiKaiProduction(playerID, iX, iY, improvementID)
	local player = Players[playerID]
	if player:IsEverAlive() and improvementID == -1 then
		local plot = Map.GetPlot(iX, iY)
		if plot and load(plot, "isForest") ~= nil and plot:GetFeatureType() ~= FeatureTypes.FEATURE_FOREST then
			if plot:GetOwner() == playerID and player:GetCivilizationType() == civilisationID then
				for city in player:Cities() do
					if city then
						for cityPlotID = 0, city:GetNumCityPlots() - 1, 1 do
							local cityPlot = city:GetCityIndexPlot(cityPlotID)
							if cityPlot and cityPlot == plot then
								city:SetOverflowProduction(city:GetOverflowProduction() + iProduction)
								if player:IsHuman() and player:IsTurnActive() then
									local hex = ToHexFromGrid(Vector2(iX, iY))
									Events.AddPopupTextEvent(HexToWorld(hex), Locale.ConvertTextKey("[COLOR_POSITIVE_TEXT]+{1_Num}[ENDCOLOR] [ICON_PRODUCTION]", iProduction), 1)
									Events.GameplayFX(hex.x, hex.y, -1)
								end
							end
						end
					end
				end
			end	
			save(plot, "isForest", nil)
		end
	end
end

if JFD_IsCivilisationActive(civilisationID) then
	for plotID = 0, Map.GetNumPlots() - 1, 1 do
		local plot = Map.GetPlotByIndex(plotID)
		if plot and plot:GetFeatureType() == FeatureTypes.FEATURE_FOREST then
			save(plot, "isForest", true)
		end
	end
	GameEvents.PlayerCityFounded.Add(JFD_KaiKaiLoreFounded)
	GameEvents.SetPopulation.Add(JFD_KaiKaiLorePopulation)
	GameEvents.BuildFinished.Add(JFD_KaiKaiProduction)
end
--=======================================================================================================================
--=======================================================================================================================