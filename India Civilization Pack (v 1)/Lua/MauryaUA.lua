-- MauryaUA
-- Author: Sukritact
-- Edited By: F0S
--------------------------------------------------------------
WARN_NOT_SHARED = false; include( "SaveUtils" ); MY_MOD_NAME = "MauryaUA";

local iCivType = GameInfoTypes["CIVILIZATION_MAURYA"]
local iNumBase = 4

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

-- Main Code

function MauryaUA (pPlayer,isTurn)	
	--Grab the appropriate religion, return if no religion founded
	local iReligion = pPlayer:GetReligionCreatedByPlayer()
	if iReligion == GameInfo.Religions.RELIGION_PANTHEON.ID or iReligion == -1 then
		return
	end
	local iDelta = 0
	local iDeltaGA = 0
    if load(pPlayer, "bBonusEnabled") == true then
        local iNumCaptured = load(pPlayer, "iNumCaptured")
        if iNumCaptured == nil then
            iNumCaptured = 0
        end
        local iPopPerCult = iNumBase - iNumCaptured
        if iPopPerCult <= 0 then
            iPopPerCult = 1
        end
        for pCity in pPlayer:Cities() do
            local iCity = pCity:GetID()
            iDelta = iDelta + (pCity:GetNumFollowers(iReligion)/iPopPerCult) + (pCity:GetNumFollowers(iReligion)/4)
            if pCity:IsCapital() then
                iDelta = iDelta + (GetNumForeignFollowers(iReligion)/(iPopPerCult + 3)) + (GetNumForeignFollowers(iReligion)/4)
            end
        end
	else
        for pCity in pPlayer:Cities() do
            local iCity = pCity:GetID()
            iDelta = iDelta + (pCity:GetNumFollowers(iReligion)/4)
			if pCity:IsCapital() then
				iDelta = iDelta + (GetNumForeignFollowers(iReligion)/4)
            end
        end
    end
	iDelta = math.floor(iDelta)
	if pPlayer:IsGoldenAge() then
		iDeltaGA = math.ceil(iDelta * 0.2)
	end
	if isTurn then
		pPlayer:ChangeFaith(iDelta)
		pPlayer:ChangeJONSCulture(iDelta + iDeltaGA)
	end
	local pCapital = pPlayer:GetCapitalCity()
	if pCapital then
		pCapital:SetNumRealBuilding(GameInfoTypes["BUILDING_CULTUREFAITH_BONUS"], iDelta)
		pCapital:SetNumRealBuilding(GameInfoTypes["BUILDING_CULTUREFAITH_BONUS_GA"], iDeltaGA)
	end
    if load(pPlayer, "bSendMessage") == true then
        MauryaNotification(pPlayer)
        save(pPlayer, "bSendMessage", false)
    end
end

-- End of Main Code

function GetNumForeignFollowers (iReligion)
    iFounder = Game.GetFounder(iReligion, -1)
    iNumFollowers = 0
    for iPlayer, pPlayer in pairs(Players) do
        if pPlayer:IsEverAlive() and iPlayer ~= iFounder then
            for pCity in pPlayer:Cities() do
                iNumFollowers = iNumFollowers + pCity:GetNumFollowers(iReligion)
            end
        end
    end
    return iNumFollowers
end

function MauryaUATrigger1(iPlayer)
    local pPlayer = Players[iPlayer]
    if pPlayer:GetCivilizationType() == iCivType then
        MauryaUA(pPlayer,true)
    end
end

function MauryaUATrigger2()
    local iPlayer = Game.GetActivePlayer()
    local pPlayer = Players[iPlayer]
    if pPlayer:IsTurnActive() then
        if pPlayer:GetCivilizationType() == iCivType then
            MauryaUA(pPlayer,false)
        end
    end
end
----------------------------------------------------------------        
-- The following is used to keep track of Maurya's War States
---------------------------------------------------------------- 
local iTeam = -1

function MauryaWarMonitor (iAttacker, iDefender, bWar)
    -- Gets the attacker
    if iTeam ~= -1 then
        iTeam = -1
        return
    else
        iTeam = iAttacker
    end
    
    --War declared
    if bWar then
        local pTeam = Teams[iTeam]
        for iPlayer = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
            local pPlayer = Players[iPlayer]
            if pTeam:GetAtWarCount() == 0 and pPlayer:GetCivilizationType() == iCivType then
                save(pPlayer, "bBonusEnabled", true)
            elseif pPlayer:GetTeam() == iTeam and pPlayer:GetCivilizationType() == iCivType then
                if load(pPlayer, "bBonusEnabled") == true then
                    save(pPlayer, "iNumCaptured", 0)
                end
                save(pPlayer, "bBonusEnabled", false)
            end
        end
        
    --Peace Made
    else
        for iPlayer = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
            local pPlayer = Players[iPlayer]
            local iPlayerTeam = pPlayer:GetTeam()
            if (iPlayerTeam == iAttacker or iPlayerTeam == iDefender) and pPlayer:GetCivilizationType() == iCivType then
                local pTeam = Teams[iPlayerTeam]
                if not (pTeam:GetAtWarCount() > 0) then
                    save(pPlayer, "bBonusEnabled", true)
                    MauryaNotification(pPlayer)
                end
            end        
        end    
    end    
end

function MauryaCityCaptureMonitor(iOldOwner, bIsCapital, iCityX, iCityY, iNewOwner, iPop, bConquest)
    local pPlayer = Players[iNewOwner]
    if bConquest and pPlayer:IsEverAlive() and pPlayer:GetCivilizationType() == iCivType then
        if load(pPlayer, "bBonusEnabled") == true then
            save(pPlayer, "iNumCaptured", 1)
            save(pPlayer, "bWarDeclaredviaCapture", true)
        else
            local iNumCaptured = load(pPlayer, "iNumCaptured")
            if iNumCaptured == nil then
                iNumCaptured = 0
            end
            iNumCaptured = iNumCaptured + 1
            save(pPlayer, "iNumCaptured", iNumCaptured)
        end
        local iPlayerTeam = pPlayer:GetTeam()
        local pTeam = Teams[iPlayerTeam]
        if pTeam:GetAtWarCount() == 0 then
            save(pPlayer, "bBonusEnabled", true)
        end
        MauryaNotification(pPlayer)
    end
end
----------------------------------------------------------------        
-- The following is used to construct the notification
---------------------------------------------------------------- 

function MauryaNotification(pPlayer)
	--Break if not the right time for notifications
    if not pPlayer:IsHuman() then return end
    if not pPlayer:IsTurnActive() then
        save(pPlayer, "bSendMessage", true)
        return
    end
    
	--Calculate Followers Per Yield
    local iNumCaptured = load(pPlayer, "iNumCaptured")
    local bBonusEnabled = load(pPlayer, "bBonusEnabled")
    local iPopPerCult = iNumBase - iNumCaptured
    if iPopPerCult <= 0 then
        iPopPerCult = 1
    end
    local StrPop = tostring(iPopPerCult .. " followers of")
    
    --Define Verb
    if iPopPerCult == 5 or iPopPerCult == 4 then
        strVerb = "long"
    elseif iPopPerCult == 3 or iPopPerCult == 2 then
        strVerb = "call"    
    else 
        strVerb = "beg"
    end
    
    --Define Religion
    local iReligion = pPlayer:GetReligionCreatedByPlayer()
    if iReligion == GameInfo.Religions.RELIGION_PANTHEON.ID or iReligion == -1 then
        bReligion = false
        strReligion = " your Religion"
    else
        bReligion = true
        strReligion = tostring(" " .. Locale.ConvertTextKey(Game.GetReligionName(iReligion)))
    end
    
    --Define sentence
    if bBonusEnabled and bReligion then
        strToolTip = ("The people rejoice at the end of the war! You now receive +1 [ICON_CULTURE] Culture and +1 [ICON_PEACE] Faith for every " .. StrPop .. strReligion .. " in your empire and +1 [ICON_CULTURE] Culture and +1 [ICON_PEACE] Faith for every " .. iPopPerCult + 3 .. " followers elsewhere.")
    elseif not bBonusEnabled and bReligion then
        strToolTip = ("The people " .. strVerb .. " for peace: if you make peace now, you will receive +1 [ICON_CULTURE] Culture and +1 [ICON_PEACE] Faith for every " .. StrPop .. strReligion .. " in your empire and +1 [ICON_CULTURE] Culture and +1 [ICON_PEACE] Faith for every " .. iPopPerCult + 3 .. " followers elsewhere.")
    elseif bBonusEnabled and not bReligion then
        strToolTip = ("The people rejoice at the end of the war! As soon as you found a Religion, you will receive +1 [ICON_CULTURE] Culture and +1 [ICON_PEACE] Faith for every " .. StrPop .. strReligion .. " in your empire and +1 [ICON_CULTURE] Culture and +1 [ICON_PEACE] Faith for every " .. iPopPerCult + 3 .. " followers elsewhere.")
    elseif not bBonusEnabled and not bReligion then
        strToolTip = ("The people " .. strVerb .. " for peace. As soon as you make peace and found a Religion, you will receive +1 [ICON_CULTURE] Culture and +1 [ICON_PEACE] Faith for every " .. StrPop .. strReligion .. " in your empire and +1 [ICON_CULTURE] Culture and +1 [ICON_PEACE] Faith for every " .. iPopPerCult + 3 .. " followers elsewhere.")
    end
    
    pPlayer:AddNotification(NotificationTypes.NOTIFICATION_GENERIC, strToolTip, "Chakravartin", -1, -1, -1, -1)
end

if JFD_IsCivilisationActive(iCivType) then
	Events.WarStateChanged.Add(MauryaWarMonitor)
	GameEvents.CityCaptureComplete.Add(MauryaCityCaptureMonitor)
	GameEvents.PlayerDoTurn.Add(MauryaUATrigger1)
	Events.SerialEventCityInfoDirty.Add(MauryaUATrigger2)
end