-- Hawaii_UA
-- Author: Sukritact
-- Heavily Edited By: F0S
--=======================================================================================================================
-- Utility Functions
--=======================================================================================================================
include("FLuaVector.lua")
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
-- GetRandom
-------------------------------------------------------------------------------------------------------------------------
function GetRandom(lower, upper)
    return (Game.Rand((upper + 1) - lower, "")) + lower
end
--=======================================================================================================================
-- HawaiiUA: Kahuna Mastery
--=======================================================================================================================
-- Kahuna Mastery: Main Code
-------------------------------------------------------------------------------------------------------------------------
local specialistArtistID = GameInfoTypes["SPECIALIST_ARTIST"]
local specialistEngineerID = GameInfoTypes["SPECIALIST_ENGINEER"]
local specialistMerchantID = GameInfoTypes["SPECIALIST_MERCHANT"]
local specialistMusicianID = GameInfoTypes["SPECIALIST_MUSICIAN"]
local specialistScientistID = GameInfoTypes["SPECIALIST_SCIENTIST"]
local specialistWriterID = GameInfoTypes["SPECIALIST_WRITER"]
local tableSpecialists = {
	specialistArtistID,
	specialistEngineerID,
	specialistMerchantID,
	specialistMusicianID,
	specialistScientistID,
	specialistWriterID
}
local buildingWritersGuildID = GameInfoTypes["BUILDING_WRITERS_GUILD"]
local buildingArtistsGuildID = GameInfoTypes["BUILDING_ARTISTS_GUILD"]
local buildingMusiciansGuildID = GameInfoTypes["BUILDING_MUSICIANS_GUILD"]
local modifier = 50
local civilisationID = GameInfoTypes["CIVILIZATION_POLYNESIA"]

function GetTargetCity(player, specialistID)
	local targetCity = player:GetCapitalCity()
	if not targetCity then return end
	local progress = targetCity:GetSpecialistGreatPersonProgress(specialistID)
	local guildID = nil
	if specialistID == specialistWriterID then
		guildID = buildingWritersGuildID
	elseif specialistID == specialistArtistID then
		guildID = buildingArtistsGuildID
	elseif specialistID == specialistMusicianID then
		guildID = buildingMusiciansGuildID
	end
	for city in player:Cities() do
		if city then
			if guildID then
				if city:IsHasBuilding(guildID) then
					targetCity = city
				end
			else
				local cityProgress = city:GetSpecialistGreatPersonProgress(specialistID)
				if progress < cityProgress then
					progress = cityProgress
					targetCity = city
				end
			end
		end
	end
	return targetCity
end

function HawaiiUA(playerID, killedID, unitID)
	local player = Players[playerID]
	if player:IsEverAlive() and player:GetCivilizationType() == civilisationID then
		local specialistID = tableSpecialists[GetRandom(1, #tableSpecialists)]
		local city = GetTargetCity(player, specialistID)
		if city then
			local unitCombat = GameInfo.Units[unitID].Combat
			local gpReward = unitCombat * modifier
			if gpReward > 0 then
				city:ChangeSpecialistGreatPersonProgressTimes100(specialistID, gpReward)
				if player:IsHuman() and player:IsTurnActive() then
					local hex = ToHexFromGrid(Vector2(city:GetX(), city:GetY()))
					if specialistID == specialistWriterID then
						Events.AddPopupTextEvent(HexToWorld(hex), Locale.ConvertTextKey("[COLOR_POSITIVE_TEXT]+{1_Num}[ENDCOLOR] [ICON_GREAT_WRITER]", (gpReward / 100)), 1)
					elseif specialistID == specialistArtistID then
						Events.AddPopupTextEvent(HexToWorld(hex), Locale.ConvertTextKey("[COLOR_POSITIVE_TEXT]+{1_Num}[ENDCOLOR] [ICON_GREAT_ARTIST]", (gpReward / 100)), 1)
					elseif specialistID == specialistMusicianID then
						Events.AddPopupTextEvent(HexToWorld(hex), Locale.ConvertTextKey("[COLOR_POSITIVE_TEXT]+{1_Num}[ENDCOLOR] [ICON_GREAT_MUSICIAN]", (gpReward / 100)), 1)
					elseif specialistID == specialistMerchantID then
						Events.AddPopupTextEvent(HexToWorld(hex), Locale.ConvertTextKey("[COLOR_POSITIVE_TEXT]+{1_Num}[ENDCOLOR] [ICON_GREAT_MERCHANT]", (gpReward / 100)), 1)
					elseif specialistID == specialistEngineerID then
						Events.AddPopupTextEvent(HexToWorld(hex), Locale.ConvertTextKey("[COLOR_POSITIVE_TEXT]+{1_Num}[ENDCOLOR] [ICON_GREAT_ENGINEER]", (gpReward / 100)), 1)
					else
						Events.AddPopupTextEvent(HexToWorld(hex), Locale.ConvertTextKey("[COLOR_POSITIVE_TEXT]+{1_Num}[ENDCOLOR] [ICON_GREAT_SCIENTIST]", (gpReward / 100)), 1)
					end
					Events.GameplayFX(hex.x, hex.y, -1)
				end
			end
		end
	end
end

if JFD_IsCivilisationActive(civilisationID) then
	GameEvents.UnitKilledInCombat.Add(HawaiiUA)
end
--=======================================================================================================================
--=======================================================================================================================