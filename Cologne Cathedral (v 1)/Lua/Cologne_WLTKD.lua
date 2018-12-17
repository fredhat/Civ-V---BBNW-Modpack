-- Cologne_WLTKD
-- Original Author: Pouakai, Janboruta
--------------------------------------------------------------
function Cologne_WLTKD(playerID, cityID, buildingID)
	local player = Players[playerID]
	if player:IsEverAlive() and not player:IsBarbarian() and not player:IsMinorCiv() then
		if buildingID == GameInfoTypes["BUILDING_COLOGNE"] then
			local city = player:GetCityByID(cityID)
			if city and not city:IsHasBuilding(GameInfoTypes["BUILDING_COLOGNE_FAKE"]) then
				for altCity in player:Cities() do
					altCity:ChangeWeLoveTheKingDayCounter(20)
				end
				city:SetNumRealBuilding(GameInfoTypes["BUILDING_COLOGNE_FAKE"], 1)
			end
		end
	end
end
GameEvents.CityConstructed.Add(Cologne_WLTKD)