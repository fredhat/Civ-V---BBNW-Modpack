-- FishingVillageFunctions
-- Original Author: F0S
--------------------------------------------------------------
function CanBuildFishingVillage(playerID, unitID, plotX, plotY, buildID)
	local player = Players[playerID]
	if player:IsEverAlive() then
		if buildID == GameInfoTypes["BUILD_CL_KAMPUNG"] then
			local plot = Map.GetPlot(plotX, plotY)
			if plot and plot:IsLake() then
				return false
			end
		end
	end
	return true
end
GameEvents.PlayerCanBuild.Add(CanBuildFishingVillage)