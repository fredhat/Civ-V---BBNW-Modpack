-- HawaiiExtraXP
-- Author: Leugi
-- Edited By: F0S
----------------------------
local promotionKoaXPID = GameInfoTypes["PROMOTION_MC_KOA_XP"]
local promotionKoaXPConsumedID = GameInfoTypes["PROMOTION_MC_KOA_XP_CONSUMED"]

function HawaiiExtraXP(playerID, unitID)
    local player = Players[playerID]
    if player:IsEverAlive() then
        for unit in player:Units() do
            if unit and unit:IsHasPromotion(promotionKoaXPID) then
                unit:SetExperience(unit:GetExperience() + 10)
                unit:SetHasPromotion(promotionKoaXPConsumedID,true)
                unit:SetHasPromotion(promotionKoaXPID,false)
            end
        end
    end
end

Events.SerialEventUnitCreated.Add(HawaiiExtraXP)
----------------------------