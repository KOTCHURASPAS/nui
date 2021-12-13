surface.CreateFont('nF4MenuButton', {
    font = 'Comfortaa',
    size = ScreenScale(10),
    weight = 300,
    extended = true,
})

local PANEL = {}

function PANEL:Init()
    self:SetContentAlignment(5)
    self:SetMouseInputEnabled(true)
    self:SetKeyboardInputEnabled(true)
    self:SetCursor('hand')
    self:SetFont('nF4MenuButton')
    self:SetText('')
end

function PANEL:IsDown()
    return self.Depressed
end

function PANEL:Paint(w, h)
    if self:IsHovered() then
        draw.RoundedBoxEx(3, 0, 0, w, h, Color(90, 90, 90), true, true)
    else
        draw.RoundedBoxEx(3, 0, 0, w, h, Color(80, 80, 80), true, true)
    end

    if self:IsDown() then
        draw.RoundedBoxEx(3, 0, 0, w, h, Color(70, 70, 70), true, true)
    end

    if self.text then
        NUI.Functions.shadowtext(self.text, 'nF4MenuButton', w * .5, h * .45, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end

    if self.icon then
        surface.SetDrawColor(255,255,255)
        if self.centericon then
            surface.SetMaterial(self.icon)
            surface.DrawTexturedRect(self:GetWide() * .15, self:GetTall() * .15, self:GetTall() * .7, self:GetTall() * .7)
        else
            surface.SetMaterial(self.icon)
            surface.DrawTexturedRect(self:GetWide() * .05, self:GetTall() * .15, self:GetTall() * .7, self:GetTall() * .7)
        end
    end

    draw.RoundedBoxEx(0, 0, h - h * .1, w, h * .1, color_white, true, true)
end

function PANEL:UpdateColours()
    if self:IsDown() then
        LocalPlayer():EmitSound('buttons/button15.wav', 25)
    end
end

local PANEL = derma.DefineControl('nF4Button', 'A standard Button', PANEL, 'DLabel')
PANEL = table.Copy(PANEL)