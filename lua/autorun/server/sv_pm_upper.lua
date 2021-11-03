util.AddNetworkString("PMUpper:SetModel")

local function Notify(ply, sMsg, iType)
    if DarkRP then
        DarkRP.notify(ply, iType, 2, sMsg)
    else
        ply:ChatPrint(sMsg)
    end
end

net.Receive("PMUpper:SetModel", function(_, ply)
    ply.bAntiPMUpperSpam = ply.bAntiPMUpperSpam or 0
    if ply.bAntiPMUpperSpam > CurTime() then return end
    ply.bAntiPMUpperSpam = CurTime() + 1

    if PMUpper.tGroupAccess and not PMUpper.tGroupAccess[ply:GetUserGroup()] then
        Notify(ply, PMUpper.tLang["NotAccess"], NOTIFY_ERROR)

        return
    end

    local sModel = net.ReadString()

    if not util.IsValidModel(sModel) then
        Notify(ply, PMUpper.tLang["NotModel"], NOTIFY_ERROR)

        return
    end

    if not PMUpper.iAllowProps and util.IsValidProp(sModel) then
        Notify(ply, PMUpper.tLang["PropsNotAllowed"], NOTIFY_ERROR)

        return
    end

    if not PMUpper.iAllowRagdoll and util.IsValidRagdoll(sModel) then
        Notify(ply, PMUpper.tLang["RagdollNotAllowed"], NOTIFY_ERROR)

        return
    end

    if PMUpper.tMustContain then
        for sKeyword, _ in pairs(PMUpper.tMustContain) do
            if not string.find(sModel, sKeyword) then
                Notify(ply, string.format(PMUpper.tLang["MustContain"], sKeyword), NOTIFY_ERROR)

                return
            end
        end
    end

    ply:SetModel(sModel)
end)