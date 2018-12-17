-- GlobalNoConqueredAllies
-- Original Author: William Howard
-- Edited By: F0S
--------------------------------------------------------------
local iModifier = ((GameInfo.GameSpeeds[Game.GetGameSpeedType()].GoldPercent)/100)
local iCivMongol = GameInfoTypes.CIVILIZATION_MONGOL

function ResetCsFriendships(iPlayer)
	-- Only need to reset for major civs
	if iPlayer < GameDefines.MAX_MAJOR_CIVS then
		for iCs = GameDefines.MAX_MAJOR_CIVS, GameDefines.MAX_CIV_PLAYERS-2, 1 do
			local pCs = Players[iCs]
			if pCs:IsEverAlive() then
				pCs:ChangeMinorCivFriendshipWithMajor(iPlayer, -1 * pCs:GetMinorCivFriendshipWithMajor(iPlayer))
			end
		end
	end
end

-- The player may have opted for "complete kills"
function OnUnitKilledInCombat(iPlayer, iKilledPlayer)
	if not Players[iKilledPlayer]:IsEverAlive() then
		ResetCsFriendships(iKilledPlayer)
	end
end
GameEvents.UnitKilledInCombat.Add(OnUnitKilledInCombat) 

function OnCityCaptureComplete(iOldOwner, bIsCapital, iX, iY, iNewOwner)
	if not Players[iOldOwner]:IsEverAlive() then
		ResetCsFriendships(iOldOwner)
	end
	local city = Map.GetPlot(iX, iY):GetPlotCity()
	if city then
		if iNewOwner == city:GetOriginalOwner() then
			city:ChangeResistanceTurns(-1 * math.floor(city:GetResistanceTurns()))
		else
			local pPlayer = Players[iNewOwner]
			if pPlayer:IsEverAlive() and pPlayer:GetCivilizationType() == iCivMongol then
				city:ChangeResistanceTurns(-2 * math.floor(city:GetResistanceTurns() * (1 - iModifier)))
			else
				city:ChangeResistanceTurns(-1 * math.floor(city:GetResistanceTurns() * (1 - iModifier)))
			end
		end
	end
end
GameEvents.CityCaptureComplete.Add(OnCityCaptureComplete)