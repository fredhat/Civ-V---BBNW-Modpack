-- PhoenicianFunctions
-- Author: Sukritact
-- Heavily Edited By: F0S
--=======================================================================================================================
WARN_NOT_SHARED = false; include("Sukritact_SaveUtils.lua"); MY_MOD_NAME = "PhoenicianFunctions";
include("FLuaVector.lua")
--=======================================================================================================================
-- Utility Functions
--=======================================================================================================================
local iCiv = GameInfoTypes.CIVILIZATION_MC_PHOENICIA

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
-- Phoenician Alphabet
--=======================================================================================================================
local iGold = GameInfoTypes.YIELD_GOLD
local iMod = 0.03
local iBuildingGoldDummy = GameInfoTypes["BUILDING_PHOENICIA_GOLD"]

function PhoenicianUA (iPlayer, bIsTurnStart)
	local pPlayer = Players[iPlayer]
	if pPlayer:IsEverAlive() and pPlayer:GetCivilizationType() == iCiv then
		local iScienceExport = 0
		-- Trade routes from you
		local tTradeRoutes = pPlayer:GetTradeRoutes()
		for i,v in ipairs(tTradeRoutes) do
			iScienceExport = iScienceExport + v.ToScience
		end
		-- Trade routes to you
		local tTradeRoutes = pPlayer:GetTradeRoutesToYou()
		for i,v in ipairs(tTradeRoutes) do
			iScienceExport = iScienceExport + v.FromScience
		end
		local iDeltaGold = math.ceil(iScienceExport * iMod)
		if bIsTurnStart then pPlayer:ChangeGold(iDeltaGold) end
		local pCapital = pPlayer:GetCapitalCity()
		if pCapital then
			if pCapital:GetNumBuilding(iBuildingGoldDummy) ~= iDeltaGold then
				pCapital:SetNumRealBuilding(iBuildingGoldDummy, iDeltaGold)
			end
		end
	end
end

function PhoenicianUATrigger1(iPlayer)
	PhoenicianUA(iPlayer, true)
end

function PhoenicianUATrigger2()
	local iPlayer = Game.GetActivePlayer()
	local pPlayer = Players[iPlayer]
	if pPlayer:IsTurnActive() then
		PhoenicianUA(iPlayer, false)
	end
end
--=======================================================================================================================
-- Cedars of Lebanon
--=======================================================================================================================
local iCedarsOfLebanon = GameInfoTypes.PROMOTION_CEDARS_OF_LEBANON
local iMerchant = GameInfoTypes.SPECIALIST_MERCHANT

function GetMerchantCity(pPlayer)
	local pTargetCity = pPlayer:GetCapitalCity()
	if pTargetCity == nil then return end
	local iTargetProgress = pTargetCity:GetSpecialistGreatPersonProgress(iMerchant)
	for pCity in pPlayer:Cities() do
		local iProgress = pCity:GetSpecialistGreatPersonProgress(iMerchant)
		if iProgress > iTargetProgress then
			pTargetCity = pCity
			iTargetProgress = iProgress
		end
	end
	return pTargetCity
end

function CedarsofLebanonCode(iPlayer)
	local pPlayer = Players[iPlayer]
	if pPlayer:IsEverAlive() then
		for pUnit in pPlayer:Units() do
			if pUnit and pUnit:IsHasPromotion(iCedarsOfLebanon) then
				local iMovement = pUnit:GetMoves()
				local pPlot = pUnit:GetPlot()
				if pPlot then
					for iVal = 0, pPlot:GetNumUnits() - 1 do
						local pPlotUnit = pPlot:GetUnit(iVal)
						if pPlotUnit and pPlotUnit:IsEmbarked() and pPlotUnit:GetMoves() < iMovement then
							pPlotUnit:SetMoves(iMovement)
						end
					end
				end
				local iXP = pUnit:GetExperience()
				save(pPlayer, pUnit:GetID(), iXP)
			end
		end
	end
end

function CedarsofLebanonCodeXY(iPlayer)
	local pPlayer = Players[iPlayer]
	if pPlayer:IsEverAlive() then
		local isDeathTrigger = load(pPlayer, "DeathTrigger")
		if isDeathTrigger then
			for pUnit in pPlayer:Units() do
				if pUnit and pUnit:IsHasPromotion(iCedarsOfLebanon) then
					local iUnit = pUnit:GetID()
					local iOldXP = load(pPlayer, iUnit) or 0
					local iXP = pUnit:GetExperience()
					save(pPlayer, iUnit, iXP)
					if (iXP - iOldXP) > 0 then
						local iMod = 100
						local pTargetCity = GetMerchantCity(pPlayer)
						if pTargetCity then
							iMod = iMod * math.floor(GameInfo.Units[isDeathTrigger].Combat)
							if iMod > 0 then
								pTargetCity:ChangeSpecialistGreatPersonProgressTimes100(iMerchant, iMod)
								if pPlayer:IsHuman() and pPlayer:IsTurnActive() then
									local hex = ToHexFromGrid(Vector2(pUnit:GetX(), pUnit:GetY()))
									Events.AddPopupTextEvent(HexToWorld(hex), Locale.ConvertTextKey("[COLOR_POSITIVE_TEXT]+{1_Num}[ENDCOLOR] [ICON_GREAT_MERCHANT]", (iMod / 100)), 1)
									Events.GameplayFX(hex.x, hex.y, -1)
								end
							end
						end
						save(pPlayer, "DeathTrigger", nil)
					end
				end
			end
			save(pPlayer, "DeathTrigger", nil)
		else
			for pUnit in pPlayer:Units() do
				if pUnit and pUnit:IsHasPromotion(iCedarsOfLebanon) then
					local iXP = pUnit:GetExperience()
					save(pPlayer, pUnit:GetID(), iXP)
				end
			end
		end
	end
end

function CedarsofLebanonUnitDestroyed(iKiller, iKilled, iKilledUnitType)
	local pPlayer = Players[iKiller]
	if pPlayer:IsEverAlive() then
		local iKilledCombatClass = GameInfo.Units[iKilledUnitType].CombatClass
		if iKilledCombatClass == "UNITCOMBAT_NAVALRANGED" or iKilledCombatClass == "UNITCOMBAT_NAVALMELEE" or iKilledCombatClass == "UNITCOMBAT_SUBMARINE" or iKilledCombatClass == "UNITCOMBAT_CARRIER" then
			save(pPlayer, "DeathTrigger", iKilledUnitType)
		end
	end
end

function CedarsofLebanonInitialTrigger(iPlayer, iUnit)
	local pPlayer = Players[iPlayer]
	local pUnit = pPlayer:GetUnitByID(iUnit)
	if pUnit and pUnit:IsHasPromotion(iCedarsOfLebanon) then
		GameEvents.PlayerDoTurn.Add(CedarsofLebanonCode)
		GameEvents.UnitSetXY.Add(CedarsofLebanonCodeXY)
		GameEvents.UnitKilledInCombat.Add(CedarsofLebanonUnitDestroyed)
		Events.SerialEventUnitCreated.Remove(CedarsofLebanonInitialTrigger)
		save("GAME", "CedarsofLebanonInitalised", true)
		CedarsofLebanonCode(iPlayer)
	end
end

if JFD_IsCivilisationActive(iCiv) then
	GameEvents.PlayerDoTurn.Add(PhoenicianUATrigger1)
	Events.SerialEventGameDataDirty.Add(PhoenicianUATrigger2)
	Events.SerialEventTurnTimerDirty.Add(PhoenicianUATrigger2)
	Events.SerialEventCityInfoDirty.Add(PhoenicianUATrigger2)
	if load("GAME", "CedarsofLebanonInitalised") then
		GameEvents.PlayerDoTurn.Add(CedarsofLebanonCode)
		GameEvents.UnitSetXY.Add(CedarsofLebanonCodeXY)
		GameEvents.UnitKilledInCombat.Add(CedarsofLebanonUnitDestroyed)
	else
		Events.SerialEventUnitCreated.Add(CedarsofLebanonInitialTrigger)
	end
end
--=======================================================================================================================
-- Tyrian Merchant Commercial Outposts
--=======================================================================================================================
local iMissionCommercialOutpost = GameInfo.Missions["MISSION_MC_COMMERCIAL_OUTPOST"].ID
local iTyrianMerchant = GameInfoTypes.UNIT_MC_TYRIAN_MERCHANT
local iTyrianDye = GameInfoTypes.RESOURCE_MC_TYRIAN_DYES
local iModifier = ((GameInfo.GameSpeeds[Game.GetGameSpeedType()].GoldPercent)/100)

function CommercialOutpostMissionPossible(iPlayer, iUnit, iMission, data1, data2, _, _, iX, iY, bTestVisible)
	local pPlayer = Players[iPlayer]
	if iMission == iMissionCommercialOutpost then
		if pPlayer:IsEverAlive() then
			local pUnit = pPlayer:GetUnitByID(iUnit)
			if pUnit and pUnit:GetUnitType() == iTyrianMerchant then
				local pPlot = pUnit:GetPlot()
				if pPlot then
					local iOtherPlayer = pPlot:GetOwner()
					if iOtherPlayer and iOtherPlayer ~= -1 then
						local pOtherPlayer = Players[iOtherPlayer]
						if pOtherPlayer and pOtherPlayer:IsEverAlive() and pOtherPlayer:IsMinorCiv() then
							if not Teams[pPlayer:GetTeam()]:IsAtWar(pOtherPlayer:GetTeam()) then
								if load(pPlayer, "C_" .. iOtherPlayer) == nil then
									return pPlayer:GetCurrentResearch() > 0
								end
							end
						end
					end
				end
			end
		end
	end
	return false
end

GameEvents.CustomMissionPossible.Add(CommercialOutpostMissionPossible)

local CUSTOM_MISSION_NO_ACTION = 0
local CUSTOM_MISSION_ACTION = 1
local CUSTOM_MISSION_DONE = 2
local CUSTOM_MISSION_ACTION_AND_DONE = 3
function CommercialOutpostMissionStart(iPlayer, iUnit, iMission, data1, data2, flags, bTurn)
	local pPlayer = Players[iPlayer]
	if iMission == iMissionCommercialOutpost then
		if pPlayer:IsEverAlive() then
			local pUnit = pPlayer:GetUnitByID(iUnit)
			if pUnit then
				local pPlot = pUnit:GetPlot()
				if pPlot then
					local iOtherPlayer = pPlot:GetOwner()
					if iOtherPlayer and iOtherPlayer ~= -1 then
						local pOtherPlayer = Players[iOtherPlayer]
						if pOtherPlayer and pOtherPlayer:IsEverAlive() and pOtherPlayer:IsMinorCiv() then
							if not Teams[pPlayer:GetTeam()]:IsAtWar(pOtherPlayer:GetTeam()) then
								local iTyrianGift = 1
								if load(pPlayer, "FirstTyrianDyes") == nil then iTyrianGift = 2 end
								local iScienceGift = math.ceil((pOtherPlayer:GetScience() * 16) * (pPlayer:GetCurrentEra() + 1) * iModifier)
								if iScienceGift > 0 and pPlayer:GetCurrentResearch() > 0 then
									Teams[pPlayer:GetTeam()]:GetTeamTechs():ChangeResearchProgress(pPlayer:GetCurrentResearch(), iScienceGift, iPlayer)
									pPlayer:ChangeNumResourceTotal(iTyrianDye, iTyrianGift)
									save(pPlayer, "C_" .. iOtherPlayer, true)
									save(pPlayer, "FirstTyrianDyes", true)
									if pPlayer:IsHuman() and pPlayer:IsTurnActive() then
										local sTooltip = Locale.ConvertTextKey("TXT_KEY_MISSION_MC_COMMERCIAL_OUTPOST_NOTIFICATION", pOtherPlayer:GetName(), iScienceGift)
										if iTyrianGift > 1 then
											sTooltip = Locale.ConvertTextKey("TXT_KEY_MISSION_MC_COMMERCIAL_OUTPOST_NOTIFICATION_FIRST", pOtherPlayer:GetName(), iScienceGift)
										end
										pPlayer:AddNotification(NotificationTypes.NOTIFICATION_DISCOVERED_LUXURY_RESOURCE, sTooltip, Locale.ConvertTextKey("TXT_KEY_MISSION_MC_COMMERCIAL_OUTPOST_NOTIFICATION_SUMMARY"), pUnit:GetX(), pUnit:GetY(), iTyrianDye, -1)
									end
									return CUSTOM_MISSION_ACTION
								end
							end
						end
					end
				end
			end
		end
	end
	return CUSTOM_MISSION_NO_ACTION
end

GameEvents.CustomMissionStart.Add(CommercialOutpostMissionStart)

function CommercialOutpostTradeMissionCompleted(iPlayer, iUnit, iMission, data1, data2, flags, bTurn)
	local pPlayer = Players[iPlayer]
	if iMission == iMissionCommercialOutpost then
		if pPlayer:IsEverAlive() then
			local pUnit = pPlayer:GetUnitByID(iUnit)
			if pUnit then
				pUnit:Kill(true, -1)
				return true
			end
		end
	end
	return false
end

GameEvents.CustomMissionCompleted.Add(CommercialOutpostTradeMissionCompleted)
--=======================================================================================================================
--=======================================================================================================================