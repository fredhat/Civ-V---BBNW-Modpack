-- F0S_MotherlandFunctions
-- Author: F0S
--==========================================================================================================================
-- CORE MOTHERLAND FUNCTIONS
--==========================================================================================================================
-- F0S_MotherlandCalls
--------------------------------------------------------------
local buildingMotherlandID = GameInfoTypes["BUILDING_MOTHERLAND"]
local promotionMotherlandCallsID = GameInfoTypes["PROMOTION_F0S_MOTHERLAND_CALLS"]

function F0S_MotherlandCalls(playerID, cityID, unitID)
	local player = Players[playerID]
	if player:IsEverAlive() then
		local city = player:GetCityByID(cityID)
		if city and city:IsHasBuilding(buildingMotherlandID) then
			local unit = player:GetUnitByID(unitID)
			if unit and unit:GetCombatLimit() > 0 and unit:GetDomainType() == DomainTypes.DOMAIN_LAND and not unit:IsHasPromotion(promotionMotherlandCallsID) then
				local newUnit = player:InitUnit(unit:GetUnitType(), unit:GetX(), unit:GetY(), UNITAI_DEFENSE)
				newUnit:JumpToNearestValidPlot()
				newUnit:SetLevel(unit:GetLevel())
				newUnit:SetExperience(unit:GetExperience())
				for unitPromotion in GameInfo.UnitPromotions() do
					if unit:IsHasPromotion(unitPromotion.ID) and not newUnit:IsHasPromotion(unitPromotion.ID) then
						newUnit:SetHasPromotion(unitPromotion.ID, true)
					end
				end
				unit:SetHasPromotion(promotionMotherlandCallsID, true)
				newUnit:SetHasPromotion(promotionMotherlandCallsID, true)
			end
		end
	end
end

GameEvents.CityTrained.Add(F0S_MotherlandCalls)
--==========================================================================================================================
--==========================================================================================================================