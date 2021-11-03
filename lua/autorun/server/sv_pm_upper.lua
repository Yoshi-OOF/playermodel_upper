util.AddNetworkString("PMUpper:SetModel")

local function PMUpperNotify(ply, sMsg, iType)
    --if DarkRP then
        DarkRP.notify(ply, iType, 2, sMsg)
    --else
        ply:ChatPrint(sMsg)
    ---end
end

net.Receive("PMUpper:SetModel", function(_, ply)
    ply.bAntiPMUpperSpam = ply.bAntiPMUpperSpam or 0
    if ply.bAntiPMUpperSpam > CurTime() then return end
    ply.bAntiPMUpperSpam = CurTime() + 1

    if not table.IsEmpty(PMUpper.tGroupAccess) and not PMUpper.tGroupAccess[ply:GetUserGroup()] then
        PMUpperNotify(ply, PMUpper.tLang["NotAccess"], NOTIFY_ERROR)

        return
    end

    local sModel = net.ReadString()

    if not util.IsValidModel(sModel) then
        PMUpperNotify(ply, PMUpper.tLang["NotModel"], NOTIFY_ERROR)

        return
    end

    if not PMUpper.iAllowProps and util.IsValidProp(sModel) then
        PMUpperNotify(ply, PMUpper.tLang["PropsNotAllowed"], NOTIFY_ERROR)

        return
    end

    if not PMUpper.iAllowRagdoll and util.IsValidRagdoll(sModel) then
        PMUpperNotify(ply, PMUpper.tLang["RagdollNotAllowed"], NOTIFY_ERROR)

        return
    end

    if not table.IsEmpty(PMUpper.tMustContain) then
        for sKeyword, _ in pairs(PMUpper.tMustContain) do
            if not string.find(sModel, sKeyword) then
                PMUpperNotify(ply, string.format(PMUpper.tLang["MustContain"], sKeyword), NOTIFY_ERROR)

                return
            end
        end
    end

    if not table.IsEmpty(PMUpper.tJobRestrictions) and PMUpper.tJobRestrictions[sModel] and PMUpper.tJobRestrictions[sModel] ~= team.GetName(ply:Team()) then
        PMUpperNotify(ply, PMUpper.tLang["NotAccesToModel"], NOTIFY_ERROR)

        return
    end

    ply:SetModel(sModel)
end)