util.AddNetworkString("PMUpper:SetModel")

net.Receive("PMUpper:SetModel", function(_, ply)
    ply.bAntiPMUpperSpam = ply.bAntiPMUpperSpam or 0
    if ply.bAntiPMUpperSpam > CurTime() then return end
    ply.bAntiPMUpperSpam = CurTime() + 1
    if PMUpper.tGroupAccess and not PMUpper.tGroupAccess[ply:GetUserGroup()] then return end
    local sModel = net.ReadString()

    if not util.IsValidModel(sModel) then return end
    if not PMUpper.iAllowProps and util.IsValidProp(sModel) then return end
    if not PMUpper.iAllowRagdoll and util.IsValidRagdoll(sModel) then return end

    if PMUpper.tMustContain then
        for sKeyword, _ in pairs(PMUpper.tMustContain) do
            if not string.find(sModel, sKeyword) then return end
        end
    end

    ply:SetModel(sModel)
end)