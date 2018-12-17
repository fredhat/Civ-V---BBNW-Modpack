-- BeninCode
-- Original Author: Tomatekh
-- Heavily Edited By: F0S
--------------------------------------------------------------
WARN_NOT_SHARED = false; include( "Sukritact_SaveUtils.lua" ); MY_MOD_NAME = "BeninCode";
--include("FLuaVector.lua")

local civilisationID = GameInfoTypes["CIVILIZATION_BENIN_MOD"]
local uBeninUUPromotion = GameInfoTypes["PROMOTION_BENIN_MOVE_MOD"]
local pBeninDefense = GameInfoTypes["POLICY_WALLS_OF_BENIN"]
local iTechConstructrion = GameInfo.Technologies["TECH_CONSTRUCTION"].ID
local playerBarbarianID = 63
--local uBeninUI = GameInfoTypes["IMPROVEMENT_BENIN_MOD_IYA"]
--local iModifier = ((GameInfo.GameSpeeds[Game.GetGameSpeedType()].GoldPercent)/100)
--local iProduction = math.floor(15 * iModifier)

directions = {DirectionTypes.DIRECTION_NORTHEAST, DirectionTypes.DIRECTION_EAST, DirectionTypes.DIRECTION_SOUTHEAST,
              DirectionTypes.DIRECTION_SOUTHWEST, DirectionTypes.DIRECTION_WEST, DirectionTypes.DIRECTION_NORTHWEST}

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

function Benin_Isienmwenro_Moves(iPlayer)
	local pPlayer = Players[iPlayer]
	local pTeam = pPlayer:GetTeam()
	if pPlayer:IsEverAlive() then
		for pUnit in pPlayer:Units() do
			if pUnit:IsHasPromotion(uBeninUUPromotion) then
				local getMoves = false
				local uPlot = pUnit:GetPlot()
				for loop, direction in ipairs(directions) do
					local adjPlot = Map.PlotDirection(uPlot:GetX(), uPlot:GetY(), direction)
					if adjPlot:IsUnit() then
						local iNumUnits = adjPlot:GetNumUnits()
						for iVal = 0,(iNumUnits - 1) do
							local adjUnit = adjPlot:GetUnit(iVal)
							local adjPlayer = Players[adjUnit:GetOwner()]
							local adjTeam = adjPlayer:GetTeam()
							if adjUnit:GetDomainType() == DomainTypes.DOMAIN_LAND and not adjUnit:IsEmbarked() then 
								if Teams[pTeam]:IsAtWar(adjTeam) or adjUnit:GetOwner() == playerBarbarianID then
									getMoves = true
									break
								end
							end
						end
					end
				end
				if getMoves then
					local iMaxMoves = pUnit:MaxMoves()
					pUnit:SetMoves(iMaxMoves + 60)
				end
			end
		end
	end
end

function Benin_Isienmwenro_MovesInitialTrigger(iPlayer, iUnit)
	local pPlayer = Players[iPlayer]
	local pUnit = pPlayer:GetUnitByID(iUnit)
	if pUnit and pUnit:IsHasPromotion(uBeninUUPromotion) then
		GameEvents.PlayerDoTurn.Add(Benin_Isienmwenro_Moves)
		Events.SerialEventUnitCreated.Remove(Benin_Isienmwenro_MovesInitialTrigger)
		save("GAME", "Benin_Isienmwenro_MovesInitalised", true)
	end
end

if load("GAME", "Benin_Isienmwenro_MovesInitalised") then
	GameEvents.PlayerDoTurn.Add(Benin_Isienmwenro_Moves)
else
	Events.SerialEventUnitCreated.Add(Benin_Isienmwenro_MovesInitialTrigger)
end

function Benin_Unit_Heal(iPlayer)
	local pPlayer = Players[iPlayer]
	if pPlayer:IsEverAlive() and pPlayer:GetCivilizationType() == civilisationID then
		for pUnit in pPlayer:Units() do
			if pUnit:GetDomainType() == DomainTypes.DOMAIN_LAND then
				local uPlot = pUnit:GetPlot()
				if pUnit:GetOwner() == uPlot:GetOwner() then
					pUnit:ChangeDamage(-1 * math.min(pUnit:GetDamage(), 10))
				end
			end
		end
	end
end

function Benin_Dummy_Policy_City_Founded(iPlayer, iCityX, iCityY)
	local pPlayer = Players[iPlayer]
	if pPlayer:IsEverAlive() and pPlayer:GetCivilizationType() == civilisationID then
		local pPlot = Map.GetPlot(iCityX, iCityY)
		local pCity = pPlot:GetPlotCity()
		if pCity:IsCapital() then
			if not pPlayer:HasPolicy(pBeninDefense) then
				pPlayer:SetNumFreePolicies(pPlayer:GetNumFreePolicies() + 1)
				pPlayer:SetNumFreePolicies(pPlayer:GetNumFreePolicies() - 1)
				pPlayer:SetHasPolicy(pBeninDefense, true)
			end
		end
		-- AI Handicap Code
		-- Disabled for balance purposes and multiplayer stability
		--[[
		if not pPlayer:IsHuman() then
			local pTeam = pPlayer:GetTeam()
			if Teams[pTeam]:IsHasTech(iTechConstructrion) then
				for loop, direction in ipairs(directions) do
					local cAdjPlot = Map.PlotDirection(pPlot:GetX(), pPlot:GetY(), direction)
					if cAdjPlot:GetImprovementType() == -1 and cAdjPlot:GetFeatureType() == -1 and cAdjPlot:GetResourceType() == -1 and not cAdjPlot:IsMountain() and not cAdjPlot:IsImpassable() and not cAdjPlot:IsWater() then
						if cAdjPlot:GetTerrainType() == GameInfoTypes["TERRAIN_PLAINS"] or cAdjPlot:GetTerrainType() == GameInfoTypes["TERRAIN_GRASS"] or cAdjPlot:GetTerrainType() == GameInfoTypes["TERRAIN_TUNDRA"] or cAdjPlot:GetTerrainType() == GameInfoTypes["TERRAIN_DESERT"] or cAdjPlot:GetTerrainType() == GameInfoTypes["TERRAIN_SNOW"] then 
							cAdjPlot:SetImprovementType(uBeninUI)
						end
					end
				end
			end
		end
		--]]
	end
end

function Benin_Dummy_Policy(iPlayer)
	local pPlayer = Players[iPlayer]
	if pPlayer:IsEverAlive() and pPlayer:GetCivilizationType() == civilisationID then
		if not pPlayer:HasPolicy(pBeninDefense) then
			pPlayer:SetNumFreePolicies(pPlayer:GetNumFreePolicies() + 1)
			pPlayer:SetNumFreePolicies(pPlayer:GetNumFreePolicies() - 1)
			pPlayer:SetHasPolicy(pBeninDefense, true)
		end
	end
end

-- Iya Burst Production Code
-- Disabled for balance purposes
--[[
function Benin_Iya_Production(playerID, iX, iY, improvementID)
	local pPlayer = Players[playerID]
	if pPlayer:IsEverAlive() and pPlayer:GetCivilizationType() == civilisationID then
		if improvementID == uBeninUI then
			local iDistance = 999999
			local pNearestCity = nil
			for pCity in pPlayer:Cities() do
				if iDistance > Map.PlotDistance(iX, iY, pCity:GetX(), pCity:GetY()) then
					pNearestCity = pCity
					iDistance = Map.PlotDistance(iX, iY, pCity:GetX(), pCity:GetY())
				end
			end
			if pNearestCity ~= nil then
				pNearestCity:SetOverflowProduction(pNearestCity:GetOverflowProduction() + iProduction)
				if pPlayer:IsHuman() then
					local hex = ToHexFromGrid(Vector2(iX, iY))
					Events.AddPopupTextEvent(HexToWorld(hex), Locale.ConvertTextKey("[COLOR_POSITIVE_TEXT]+{1_Num}[ENDCOLOR] [ICON_PRODUCTION]", iProduction), 1)
					Events.GameplayFX(hex.x, hex.y, -1)
				end
			end
		end
	end
end
--]]

if JFD_IsCivilisationActive(civilisationID) then
	GameEvents.PlayerDoTurn.Add(Benin_Unit_Heal)
	GameEvents.PlayerDoTurn.Add(Benin_Dummy_Policy)
	GameEvents.PlayerCityFounded.Add(Benin_Dummy_Policy_City_Founded)
	--GameEvents.BuildFinished.Add(Benin_Iya_Production)
end