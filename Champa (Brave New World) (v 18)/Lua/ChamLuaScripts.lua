-- ChamLuaScripts
-- Original Author: Tomatekh
-- Lightly Edited By: F0S
--------------------------------------------------------------
local bPlusBlockGoldDummy = GameInfo.Buildings["BUILDING_CHAMPA_BLOCKADE_PLUS_DUMMY"].ID
local bPlusGoldenAgeDummy = GameInfo.Buildings["BUILDING_CHAMPA_GOLDEN_AGE_PLUS_DUMMY"].ID
local tOcean = GameInfoTypes.TERRAIN_OCEAN
local tCoast = GameInfoTypes.TERRAIN_COAST
local sWell = GameInfoTypes.IMPROVEMENT_CHAMPA_MOD_WELL
local uCargo = GameInfoTypes.UNIT_CARGO_SHIP
local civilisationID = GameInfoTypes["CIVILIZATION_CHAMPA_MOD"]

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

function ChampaTrigger(iPlayer)
	local pPlayer = Players[iPlayer]
	local pTeam = pPlayer:GetTeam()
	if pPlayer:IsEverAlive() and pPlayer:GetCivilizationType() == civilisationID then
		local GAWellBonus = 0
		for iOtherPlayer = 0, GameDefines.MAX_MAJOR_CIVS - 1 do
			local otherPlayer = Players[iOtherPlayer]
			local otherTeam = otherPlayer:GetTeam()
			if otherPlayer:IsEverAlive() and not otherPlayer:IsMinorCiv()  then
				local stealFromPlayer = true
				if otherPlayer ~= pPlayer then
					local tradedata = pPlayer:GetTradeRoutes()
					for i,v in ipairs(tradedata) do
						if v.FromCity:GetOwner() == iOtherPlayer then
							stealFromPlayer = false
							break
						end
					end
					if Teams[otherTeam]:IsAtWar(pTeam) then
						local BlockadeCount = 0
						local otherCapital = otherPlayer:GetCapitalCity()
						for otherCity in otherPlayer:Cities() do
							if otherCity:IsBlockaded() then
								local isChamBlockade = false
								local otherCityPlot = otherCity:Plot()
								local plotX = otherCityPlot:GetX()
								local plotY = otherCityPlot:GetY()
								local iRange = 2
								for iDX = -iRange, iRange do
									for iDY = -iRange, iRange do
										local pTargetPlot = Map.PlotXYWithRangeCheck(plotX, plotY, iDX, iDY, iRange)
										if pTargetPlot then
											if pTargetPlot:GetTerrainType() == tCoast or pTargetPlot:GetTerrainType() == tOcean then
												if pTargetPlot:IsUnit() then
													for unitID = 0, pTargetPlot:GetNumUnits() - 1, 1 do
														if pTargetPlot:GetUnit(unitID):GetOwner() == iPlayer then
															if not pTargetPlot:GetUnit(unitID):IsEmbarked() and pTargetPlot:GetUnit(unitID):GetDomainType() == DomainTypes.DOMAIN_SEA then
																isChamBlockade = true
																break
															end
														end
													end
												end
											end
										end
									end
								end
								if isChamBlockade then
									BlockadeCount = BlockadeCount + 1
								end
							end
						end
						-- Steal 10% of Gold Reserves and 25% of GPT (if positive) a turn. Each blockade increases the values by +5% and +25%.
						local otherGPT = otherPlayer:CalculateGoldRate()
						local GPTBonus = 0
						if otherGPT > 0 then
							GPTBonus = (otherGPT / 4)
						end
						local PirateGPT = 0
						if BlockadeCount >= 4 then
							BlockadeCount = 3
						end
						PirateGPT = GPTBonus * (BlockadeCount + 1)
						local otherReserves = otherPlayer:GetGold()
						local ReservesPirate = (((10 + (BlockadeCount * 5)) * otherReserves) / 100)
						local PirateCount = math.floor((PirateGPT + ReservesPirate))
						local title = "Pirates of the South Sea"
						if PirateCount > 0 then
							if BlockadeCount < 1 then
								if otherPlayer:IsHuman() and otherPlayer:IsTurnActive() then
									local descr = "You have lost " .. PirateCount .. " [ICON_GOLD] Gold to Cham Pirates!"
									otherPlayer:AddNotification(NotificationTypes.NOTIFICATION_WONDER_COMPLETED, descr, title, otherCapital:GetX(), otherCapital:GetY(), bPlusBlockGoldDummy, -1)
								end
								if pPlayer:IsHuman() and pPlayer:IsTurnActive() then
									local descr2 = "You have plundered " .. PirateCount .. " [ICON_GOLD] Gold from " .. Locale.ConvertTextKey(otherPlayer:GetCivilizationShortDescription()) .. "!"
									pPlayer:AddNotification(NotificationTypes.NOTIFICATION_WONDER_COMPLETED, descr2, title, otherCapital:GetX(), otherCapital:GetY(), bPlusBlockGoldDummy, -1)
								end
							elseif BlockadeCount == 1 then
								if otherPlayer:IsHuman() and otherPlayer:IsTurnActive() then
									local descr = "You have lost " .. PirateCount .. " [ICON_GOLD] Gold to Cham Pirates! " .. BlockadeCount .. " City is under Blockade, increasing the [ICON_GOLD] Gold lost when at war with Champa."
									otherPlayer:AddNotification(NotificationTypes.NOTIFICATION_WONDER_COMPLETED, descr, title, otherCapital:GetX(), otherCapital:GetY(), bPlusBlockGoldDummy, -1)
								end
								if pPlayer:IsHuman() and pPlayer:IsTurnActive() then
									local descr2 = "You have plundered " .. PirateCount .. " [ICON_GOLD] Gold from " .. Locale.ConvertTextKey(otherPlayer:GetCivilizationShortDescription()) .. " and have " .. BlockadeCount .. " of their Cities under Blockade!"
									pPlayer:AddNotification(NotificationTypes.NOTIFICATION_WONDER_COMPLETED, descr2, title, otherCapital:GetX(), otherCapital:GetY(), bPlusBlockGoldDummy, -1)
								end
							elseif BlockadeCount > 1 then
								if otherPlayer:IsHuman() and otherPlayer:IsTurnActive() then
									local descr = "You have lost " .. PirateCount .. " [ICON_GOLD] Gold to Cham Pirates! " .. BlockadeCount .. " Cities are under Blockade, increasing the [ICON_GOLD] Gold lost when at war with Champa."
									otherPlayer:AddNotification(NotificationTypes.NOTIFICATION_WONDER_COMPLETED, descr, title, otherCapital:GetX(), otherCapital:GetY(), bPlusBlockGoldDummy, -1)
								end
								if pPlayer:IsHuman() and pPlayer:IsTurnActive() then
									local descr2 = "You have plundered " .. PirateCount .. " [ICON_GOLD] Gold from " .. Locale.ConvertTextKey(otherPlayer:GetCivilizationShortDescription()) .. " and have " .. BlockadeCount .. " of their Cities under Blockade!"
									pPlayer:AddNotification(NotificationTypes.NOTIFICATION_WONDER_COMPLETED, descr2, title, otherCapital:GetX(), otherCapital:GetY(), bPlusBlockGoldDummy, -1)
								end
							end
						elseif PirateCount <= 0 then
							if otherPlayer:IsHuman() and otherPlayer:IsTurnActive() then
								local descr = "Cham Pirates have depleted your treasury!"
								otherPlayer:AddNotification(NotificationTypes.NOTIFICATION_WONDER_COMPLETED, descr, title, otherCapital:GetX(), otherCapital:GetY(), bPlusBlockGoldDummy, -1)
							end
							if pPlayer:IsHuman() and pPlayer:IsTurnActive() then
								local descr2 = "You have depleted the " .. Locale.ConvertTextKey(otherPlayer:GetCivilizationAdjective()) .. " treasury!"
								pPlayer:AddNotification(NotificationTypes.NOTIFICATION_WONDER_COMPLETED, descr2, title, otherCapital:GetX(), otherCapital:GetY(), bPlusBlockGoldDummy, -1)
							end
						end
						otherPlayer:ChangeGold(-PirateCount)
						pPlayer:ChangeGold(PirateCount)
					end
				else
					stealFromPlayer = false
				end
				for unit in otherPlayer:Units() do			
					if unit:GetUnitType() == uCargo then
						local uPlot = unit:GetPlot()
						if stealFromPlayer then
							if uPlot:GetOwner() ~= -1 then
								if Players[uPlot:GetOwner()] == pPlayer then
									local EraCount = ((Teams[otherTeam]:GetCurrentEra()) + 1)
									GoldStolen = EraCount + 3
									if otherPlayer:IsHuman() and otherPlayer:IsTurnActive() then
										local title = "Unfriendly Waters"
										local descr = "Your Cargo Ship lost " .. GoldStolen .. " [ICON_GOLD] Gold to Cham Pirates! Establish a trade route with Champa to avoid piracy in Cham waters."
										otherPlayer:AddNotification(NotificationTypes.NOTIFICATION_WONDER_COMPLETED, descr, title, uPlot:GetX(), uPlot:GetY(), bPlusBlockGoldDummy, -1)
									end
									if pPlayer:IsHuman() and pPlayer:IsTurnActive() then	
										local title2 = "Plundered Goods"
										local descr2 = "You have plundered " .. GoldStolen .. " [ICON_GOLD] Gold from a " .. Locale.ConvertTextKey(otherPlayer:GetCivilizationAdjective()) .. " Cargo Ship in your territory!"
										pPlayer:AddNotification(NotificationTypes.NOTIFICATION_WONDER_COMPLETED, descr2, title2, uPlot:GetX(), uPlot:GetY(), bPlusBlockGoldDummy, -1)
									end
									otherPlayer:ChangeGold(-GoldStolen)
									pPlayer:ChangeGold(GoldStolen)
								end
							end
						end
						local plotX = uPlot:GetX()
						local plotY = uPlot:GetY()
						local iRange = 2
						for iDX = -iRange, iRange do
							for iDY = -iRange, iRange do
								local pTargetPlot = Map.PlotXYWithRangeCheck(plotX, plotY, iDX, iDY, iRange)
								if pTargetPlot then
									if pTargetPlot:GetImprovementType() == sWell then
										GAWellBonus = GAWellBonus + 2
									end
								end
							end
						end
					end
				end
			end
		end
		if GAWellBonus > 0 and not pPlayer:IsGoldenAge() then
			pPlayer:ChangeGoldenAgeProgressMeter(GAWellBonus)
			if pPlayer:IsHuman() and pPlayer:IsTurnActive() and pPlayer:GetCapitalCity() then
				local title = "Cham Trade"
				local descr = "Square Wells have provided " .. GAWellBonus .. " points toward a [ICON_GOLDEN_AGE] Golden Age from nearby Cargo Ships."
				pPlayer:AddNotification(NotificationTypes.NOTIFICATION_WONDER_COMPLETED, descr, title, pPlayer:GetCapitalCity():GetX(), pPlayer:GetCapitalCity():GetY(), bPlusGoldenAgeDummy, -1)
			end
		end
	end
end

if JFD_IsCivilisationActive(civilisationID) then
	GameEvents.PlayerDoTurn.Add(ChampaTrigger)
end