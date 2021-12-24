local w, h = ScrW(), ScrH()
local blur = Material("pp/blurscreen")

local function DrawBlur(panel, amount)
    local x, y = panel:LocalToScreen(0, 0)
    surface.SetDrawColor(255, 255, 255)
    surface.SetMaterial(blur)

    for i = 1, 3 do
        blur:SetFloat("$blur", (i / 3) * (amount or 6))
        blur:Recompute()
        render.UpdateScreenEffectTexture()
        surface.DrawTexturedRect(x * -1, y * -1, w, h)
    end
end

hook.Add("PlayerButtonDown", "PMUpper:Gui", function(ply, bKey)
    if IsFirstTimePredicted() and input.GetKeyName(bKey) == PMUpper.sKeyOpenGui then
        local sValue = ""
        local vPMUpperFrame = vgui.Create("DFrame")
        vPMUpperFrame:SetSize(w * .25, h * .2)
        vPMUpperFrame:Center()
        vPMUpperFrame:SetTitle("")
        vPMUpperFrame:MakePopup()
        vPMUpperFrame:ShowCloseButton(false)

        function vPMUpperFrame:Paint(ww, hh)
            DrawBlur(self, 2)
            draw.RoundedBox(8, 0, 0, ww, hh, Color(0, 0, 0, 230))
            draw.SimpleText("Sélection du modèle", "Trebuchet24", ww * .5, hh * .1, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            draw.SimpleText("Copier un model dans le clipboard dans le menu C", "Trebuchet20", ww * .5, hh * .3, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end

        local vSkinEntry = vgui.Create("DTextEntry", vPMUpperFrame)
        vSkinEntry:SetSize(w * .15, h * .025)
        vSkinEntry:Center()

        function vSkinEntry:OnTextChanged()
            -- Note : Uses of OnTextChanged and not OnValueChange because OnValueChange was not called 
            sValue = self:GetValue()
        end

        local vValidateBtn = vgui.Create("DButton", vPMUpperFrame)
        vValidateBtn:SetText("")
        vValidateBtn:SetSize(w * .1, h * .05)
        vValidateBtn:SetPos(w * .075, h * .13)

        function vValidateBtn:Paint(ww, hh)
            draw.RoundedBox(2, 0, 0, ww, hh, self:IsHovered() and Color(0, 0, 0, 100) or Color(0, 0, 0, 200))
            draw.SimpleText("Valider", "Trebuchet24", ww * .5, hh * .5, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end

        function vValidateBtn:DoClick()
            net.Start("PMUpper:SetModel")
            net.WriteString(sValue)
            net.SendToServer()
            vPMUpperFrame:Remove()
        end

        local vCloseButton = vgui.Create("DButton", vPMUpperFrame)
        vCloseButton:SetSize(w * .023, h * .025)
        vCloseButton:SetPos(w * .224, h * .008)
        vCloseButton:SetText("")

        function vCloseButton:DoClick()
            vPMUpperFrame:Remove()
        end

        function vCloseButton:Paint(ww, hh)
            draw.RoundedBox(6, 0, 0, ww, hh, Color(255, 0, 0))
        end
    end
end)
