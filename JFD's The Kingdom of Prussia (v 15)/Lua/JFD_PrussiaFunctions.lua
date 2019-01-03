-- Prussia Functions
-- Author: JFD
-- Heavily Edited By: F0S
--=======================================================================================================================
-- UTILITY FUNCTIONS
--=======================================================================================================================
-- JFD_GetRandom
--------------------------------------------------------------------------------------------------------------------------
function JFD_GetRandom(lower, upper)
    return Game.Rand((upper + 1) - lower, "") + lower
end
--------------------------------------------------------------
-- JFD_IsCivilisationActive
--------------------------------------------------------------
local civilisationID = GameInfoTypes["CIVILIZATION_JFD_PRUSSIA"]

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
-- JFD_PrussianGeneralPointsTurn
--------------------------------------------------------------------------------------------------------------------------
local buildingPrussianBarracksID = GameInfoTypes["BUILDING_JFD_PRUSSIAN_BARRACKS"]
local buildingPrussianArmoryID = GameInfoTypes["BUILDING_JFD_PRUSSIAN_ARMORY"]
local buildingPrussianMilitaryAcademyID = GameInfoTypes["BUILDING_JFD_PRUSSIAN_MILITARY_ACADEMY"]

function JFD_PrussianGenerals(playerID)
	local player = Players[playerID]
	if player:IsEverAlive() and player:GetCivilizationType() == civilisationID then
		local greatGeneralPoints = 0
		for city in player:Cities() do
			if city:IsHasBuilding(buildingPrussianBarracksID) then
				greatGeneralPoints = greatGeneralPoints + 3*(city:GetNumSpecialistsInBuilding(buildingPrussianBarracksID))
			end
			if city:IsHasBuilding(buildingPrussianArmoryID) then
				greatGeneralPoints = greatGeneralPoints + 3*(city:GetNumSpecialistsInBuilding(buildingPrussianArmoryID))
			end
			if city:IsHasBuilding(buildingPrussianMilitaryAcademyID) then
				greatGeneralPoints = greatGeneralPoints + 3*(city:GetNumSpecialistsInBuilding(buildingPrussianMilitaryAcademyID))
			end
		end
		player:ChangeCombatExperience(greatGeneralPoints)
	end
end
--------------------------------------------------------------------------------------------------------------------------
-- JFD_PrussianVeterans
--------------------------------------------------------------------------------------------------------------------------
local tableVeteranPromotions = {
	[GameInfoTypes.PROMOTION_JFD_PRUSSIAN_VETERAN_0] = 1,
	[GameInfoTypes.PROMOTION_JFD_PRUSSIAN_VETERAN_1] = 2,
	[GameInfoTypes.PROMOTION_JFD_PRUSSIAN_VETERAN_2] = 3,
	[GameInfoTypes.PROMOTION_JFD_PRUSSIAN_VETERAN_3] = 4,
	[GameInfoTypes.PROMOTION_JFD_PRUSSIAN_VETERAN_4] = 5
}

function JFD_PrussianVeterans(playerID)
	local player = Players[playerID]
	if player:IsEverAlive() and player:GetCivilizationType() == civilisationID then
		for unit in player:Units() do
			if unit and unit:GetCombatLimit() > 0 and unit:GetDomainType() == DomainTypes.DOMAIN_LAND then
				local unitLevel = unit:GetLevel()
				if unitLevel > 2 then
					local tablePromotions = {false, false, false, false, false}
					tablePromotions[math.min((unitLevel - 1), 5)] = true
					for promotionID, promotionIndex in pairs(tableVeteranPromotions) do
						unit:SetHasPromotion(promotionID, tablePromotions[promotionIndex])
					end
				end
			end
		end
	end
end

function JFD_PrussianVeteransXY(playerID, unitID)
	local player = Players[playerID]
	if player:IsEverAlive() and player:GetCivilizationType() == civilisationID then
		local unit = player:GetUnitByID(unitID)
		if unit and unit:GetCombatLimit() > 0 and unit:GetDomainType() == DomainTypes.DOMAIN_LAND then
			local unitLevel = unit:GetLevel()
			if unitLevel > 2 then
				local tablePromotions = {false, false, false, false, false}
				tablePromotions[math.min((unitLevel - 1), 5)] = true
				for promotionID, promotionIndex in pairs(tableVeteranPromotions) do
					unit:SetHasPromotion(promotionID, tablePromotions[promotionIndex])
				end
			end
		end
	end
end

if JFD_IsCivilisationActive(civilisationID) then
	GameEvents.PlayerDoTurn.Add(JFD_PrussianGenerals)
	GameEvents.PlayerDoTurn.Add(JFD_PrussianVeterans)
	GameEvents.UnitSetXY.Add(JFD_PrussianVeteransXY)
	Events.SerialEventUnitCreated.Add(JFD_PrussianVeteransXY)
end
--------------------------------------------------------------------------------------------------------------------------
-- JFD_DeathsHeadHussar
--------------------------------------------------------------------------------------------------------------------------
local promotionDeathsHeadID = GameInfoTypes["PROMOTION_JFD_DEATHS_HEAD_1"]
local direction_types = {
	DirectionTypes.DIRECTION_NORTHEAST,
	DirectionTypes.DIRECTION_NORTHWEST,
	DirectionTypes.DIRECTION_EAST,
	DirectionTypes.DIRECTION_SOUTHEAST,
	DirectionTypes.DIRECTION_SOUTHWEST,
	DirectionTypes.DIRECTION_WEST,
}
	
function JFD_DeathsHeadHussar(playerID, unitID, unitX, unitY)
	local player = Players[playerID]
	if player:IsEverAlive() then
		local unit = player:GetUnitByID(unitID)
		if unit and unit:IsHasPromotion(promotionDeathsHeadID) then
			local plot = unit:GetPlot()
			if plot then
				for loop, direction in ipairs(direction_types) do
					local adjPlot = Map.PlotDirection(plot:GetX(), plot:GetY(), direction)
					if adjPlot and adjPlot:IsUnit() then
						for i = 0,(adjPlot:GetNumUnits() - 1) do
							local adjUnit = adjPlot:GetUnit(i)
							if adjUnit and adjUnit:GetCombatLimit() > 0 and adjUnit:GetDomainType() == DomainTypes.DOMAIN_LAND then
								local adjUnitPlayer = Players[adjUnit:GetOwner()]
								if Teams[adjUnitPlayer:GetTeam()]:IsAtWar(player:GetTeam()) then
									if JFD_GetRandom(1,100) <= 50 then
										adjUnit:ChangeDamage(math.min(10, math.max(0, 100 - adjUnit:GetDamage())), playerID)
									end
								end
							end
						end
					end
				end
			end
		end
	end
end

GameEvents.UnitSetXY.Add(JFD_DeathsHeadHussar) 
--=======================================================================================================================
--=======================================================================================================================