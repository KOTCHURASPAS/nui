local x, y = ScrW(), ScrH()

surface.CreateFont('nHudFont', {
    font = 'Comfortaa',
    size = y * .025,
    weight = x * 1,
    shadow = true,
    extended = true,
})

surface.CreateFont('nHudFontBig', {
    font = 'Comfortaa',
    size = y * .03,
    weight = x * .1,
    shadow = false,
    extended = true,
})

surface.CreateFont('nHudHeadName', {
    font = 'Comfortaa',
    size = y * .1,
    weight = x * .1,
    shadow = true,
    extended = true,
})

surface.CreateFont('nHudHeadNameJob', {
    font = 'Comfortaa',
    size = y * .07,
    weight = x * .1,
    shadow = true,
    extended = true,
})

surface.CreateFont('nHudFontAmmo', {
    font = 'Comfortaa',
    size = y * .03,
    weight = x * .1,
    shadow = true,
    extended = true,
})

local warning_icon = Material('darkhub_ui/handbrake.png')
local logo_icon = Material('darkhub/logo.png')
local heart_icon = Material('darkhub_ui/heart.png')
local armor_icon = Material('darkhub_ui/vest.png')
local hunger_icon = Material('darkhub_ui/food.png')
local money_icon = Material('darkhub_ui/money.png')
local job_icon = Material('darkhub_ui/build.png')
local license_icon = Material('darkhub_ui/pistol.png')
local user_icon = Material('darkhub_ui/user.png')

local function nHud()
    local x, y = ScrW(), ScrH()
    local ply = LocalPlayer()
    local health = math.Clamp( ply:Health(), 0, ply:GetMaxHealth())
    local armor = ply:Armor()
    local hunger = math.Round(ply:getDarkRPVar('Energy') or 0)
    local money = ply:getDarkRPVar('money')
    local salary = ply:getDarkRPVar('salary')
    local job = ply:getDarkRPVar('job')
    -- local rpname = ply:getDarkRPVar('rpname')
    local licenze = ply:getDarkRPVar('HasGunlicense')
    local arrested = ply:getDarkRPVar('Arrested')
    local wanted = ply:getDarkRPVar('wanted')
    local wantedr = ply:getDarkRPVar('wantedReason')
    local plyweapon = ply:GetActiveWeapon()
    local otstup = y * .005
    local otstup_a
    local icon_o = y * .025

    surface.SetFont('nHudFont')

    -- Комендантский час
    if GetGlobalBool('DarkRP_LockDown') then
        surface.SetMaterial(warning_icon)
        surface.SetDrawColor(255, 0, 0)
        surface.DrawTexturedRect(x * .56, y * -.002, x * .02, x * .02)
        surface.SetDrawColor(0, 0, 255)
        surface.DrawTexturedRect(x * .42, y * -.002, x * .02, x * .02)
        draw.SimpleTextOutlined('Комендантский час!', 'nHudFontBig', x * .5, y * .015, HSVToColor(math.sin(RealTime()) > 0 and 0 or 240, math.abs(math.sin(RealTime())), 1), 1, 1, .8, Color(0, 0, 0, 255))
        draw.SimpleText('Причина: ' .. GetGlobalString('lockdown_reason'), 'nHudFontBig', x * .5, y * .039, color_white, 1, 1)
    end

    -- Розыск
    if wanted then
        surface.SetMaterial(warning_icon)
        surface.SetDrawColor(255, 0, 0)
        surface.DrawTexturedRect(x * .54, y * .055, x * .02, x * .02)
        surface.SetDrawColor(0, 0, 255)
        surface.DrawTexturedRect(x * .44, y * .055, x * .02, x * .02)
        draw.SimpleTextOutlined('Вы в розыске!', 'nHudFontBig', x * .5, y * .07, HSVToColor(math.sin(RealTime()) > 0 and 0 or 240, math.abs(math.sin(RealTime())), 1), 1, 1, .8, Color(0, 0, 0, 255))
        draw.SimpleText('Причина: ' .. wantedr, 'nHudFontBig', x * .5, y * .095, color_white, 1, 1)
    end

    -- Аррест
    if arrested == true then
        draw.SimpleText('Вы аррестованы!', 'nHudFontBig', y * .5, x * .2, color_white, 1, 1)
        draw.SimpleText('До освобождения: ', 'nHudFontBig', y * .5, x * .24, color_white, 1, 1)
    end

    -- Время + Логотип + Название сервера
    surface.SetDrawColor(255, 255, 255)
    surface.SetMaterial(logo_icon)
    surface.DrawTexturedRectRotated(x * 0.015, y * 0.025, y * .04, y * .04, math.sin(RealTime() * 1) * 300)
    draw.SimpleText(os.date('%H:%M:%S'), 'nHudFontBig', x * 0.03, y * 0.017, color_white, 0, 3)
    draw.SimpleText('DarkHub #2', 'nHudFontBig', x * 0.03, y * 0, color_white, 0, 3)

    -- Здоровье
    surface.SetDrawColor(255, 0, 0)
    surface.SetMaterial(heart_icon)
    surface.DrawTexturedRect(x * .01, y * .96, y * .03, y * .03)
    draw.SimpleText(health, 'nHudFont', x * .01 + icon_o + otstup, y * .96, color_white, 0, 0)
    -- Броня
    local armor_o = icon_o + otstup + surface.GetTextSize(health)

    if armor > 0 then
        surface.SetDrawColor(0, 0, 255)
        surface.SetMaterial(armor_icon)
        surface.DrawTexturedRect(x * .01 + armor_o, y * .96, y * .03, y * .03)
        draw.SimpleText(armor, 'nHudFont', x * .01 + armor_o + icon_o + otstup, y * .96, color_white, 0, 0)
        otstup_a = icon_o + otstup + surface.GetTextSize(armor)
    else
        otstup_a = 0
    end

    -- Голод
    local hunger_o = icon_o + surface.GetTextSize(health) + otstup + otstup_a
    surface.SetDrawColor(255, 90, 0)
    surface.SetMaterial(hunger_icon)
    surface.DrawTexturedRect(x * .01 + hunger_o, y * .96, y * .03, y * .03)
    draw.SimpleText(hunger, 'nHudFont', x * .01 + hunger_o + icon_o + otstup, y * .96, color_white, 0, 0)
    -- Деньги + Зарплата
    -- CBLib.Helper.CommaFormatNumber(BATM.GetPersonalAccount().balance)
    local money_o = icon_o + hunger_o + surface.GetTextSize(hunger) + otstup * 1.5
    surface.SetDrawColor(30, 200, 0)
    surface.SetMaterial(money_icon)
    surface.DrawTexturedRect(x * .01 + money_o, y * .96, y * .03, y * .03)
    draw.SimpleText('Деньги:', 'nHudFont', x * .01 + money_o + icon_o + otstup, y * .96, Color(255, 255, 255, 255), 0)
    draw.SimpleText(DarkRP.formatMoney(money) .. ' + ' .. DarkRP.formatMoney(salary), 'nHudFont', x * .01 + money_o + icon_o + otstup + surface.GetTextSize('Деньги:') + otstup, y * .96, Color(30, 200, 0, 255), 0)
    -- Работа
    local job_o = money_o + icon_o + otstup * 3 + surface.GetTextSize('Деньги:' .. DarkRP.formatMoney(money) .. ' + ' .. DarkRP.formatMoney(salary))
    surface.SetDrawColor(team.GetColor(ply:Team()))
    surface.SetMaterial(job_icon)
    surface.DrawTexturedRect(x * .01 + job_o, y * .96, y * .03, y * .03)
    draw.SimpleText('Профессия:', 'nHudFont', x * .01 + job_o + icon_o + otstup, y * .96, Color(255, 255, 255, 255), 0)
    draw.SimpleText(job, 'nHudFont', x * .01 + job_o + icon_o + otstup + surface.GetTextSize('Профессия:') + otstup, y * .96, team.GetColor(ply:Team()), 0)
    -- Лицензия
    local lic_o = job_o + icon_o + otstup * 3 + surface.GetTextSize('Профессия:' .. job)

    if licenze == true then
        surface.SetDrawColor(0, 100, 255)
        surface.SetMaterial(license_icon)
        surface.DrawTexturedRect(x * .01 + lic_o, y * .96, y * .03, y * .03)
        -- draw.SimpleText('Лицензия', 'nHudFont', x*.13 + lic_o, y*.54, Color( 0, 255, 0, 255 ), 0)
    end

    -- Оружие
    local DisabledWeapons = {}
    DisabledWeapons['itemstore_pickup'] = 'itemstore_pickup'
    DisabledWeapons['itemstore_checker'] = 'itemstore_checker'
    DisabledWeapons[''] = ''

    if ply:Alive() == true and plyweapon ~= NULL and plyweapon:GetMaxClip1() >= 1 and plyweapon:GetClass() ~= DisabledWeapons[plyweapon:GetClass()] then
        draw.SimpleText(plyweapon:GetPrintName(), 'nHudFontAmmo', x * .99, y * .91, Color(255, 255, 255, 255), 2, 2)
        draw.SimpleText(plyweapon:Clip1() .. '/' .. plyweapon:GetMaxClip1(), 'nHudFontAmmo', x * .99, y * .935, Color(255, 255, 255, 255), 2, 2)
        draw.SimpleText('Запас: ' .. ply:GetAmmoCount(plyweapon:GetPrimaryAmmoType()), 'nHudFontAmmo', x * .99, y * .96, Color(255, 255, 255, 255), 2, 2)
    end
end

hook.Add('HUDPaint', 'nHud', function()
    if LocalPlayer():IsValid() then
        nHud()
    else
        return
    end
end)

-- Худ над головой
local eyepos

hook.Add('RenderScene', '3D2DNicksPosAng', function(pos)
    eyepos = pos
end)

local hideHUDElements = {
    ['DarkRP_LocalPlayerHUD'] = false,
}

--[[
local function PersonalHead(ply, steamid, text)
    if ply:SteamID() == steamid then
        surface.SetFont('nHudHeadName')
        local x, y = 0
        -- local dist = ply:GetPos():Distance(eyepos)
        -- local boxwidth = 0
        local shirina = surface.GetTextSize(text) + 50
        draw.RoundedBox(40, y - shirina / 2, x - 300, shirina, 120, Color(50, 50, 50))
        draw.SimpleTextOutlined(text, 'nHudHeadName', y, x - 300, Color(math.sin(RealTime() * 6) * 500, 63, 220 + (math.sin(RealTime() * 6) * 2), 255), 1, 3, .8, Color(0, 0, 0, 255))
    end
end
]]
local function NicknameOverHead(ply)
    local job = ply:getDarkRPVar('job')
    -- local rpname = ply:getDarkRPVar('rpname')
    -- local licenze = ply:getDarkRPVar('HasGunlicense')
    -- local wented = ply:getDarkRPVar('wanted')
    -- local wentedr = ply:getDarkRPVar('wantedReason')
    if ply:InVehicle() or not IsValid(ply) then return end -- or LocalPlayer():GetNWBool('thirdper')
    surface.SetFont('nHudHeadName')
    local x = 0
    local y = 0
    local dist = ply:GetPos():Distance(eyepos)

    -- local boxwidth = 0
    if dist < 350 and ply:Alive() then
        cam.Start3D2D(ply:GetPos() + Vector(0, 0, 86), Angle(0, RenderAngles().y - 90, 90), .04)
        local name

        if ply:GetNWString('orgName') ~= '' then
            name = ply:GetName() .. ' (' .. ply:GetNWString('orgName') .. ')'
        else
            name = ply:GetName()
        end

        surface.SetMaterial(user_icon)
        surface.SetDrawColor(color_white)
        surface.DrawTexturedRect(x - 50 - surface.GetTextSize(name) / 2, y, 100, 100)
        draw.SimpleText(name, 'nHudHeadName', x + 50, y, color_white, 1, 3)
        draw.SimpleText(job, 'nHudHeadNameJob', x, y + 100, team.GetColor(ply:Team()), 1, 3)

        -- PersonalHead(LocalPlayer(),'STEAM_0:1:488464006', 'Недо кодер :D')
        if wanted and wantedr then
            draw.SimpleTextOutlined('Розыск: ' .. tostring(wantedr), 'nHudHeadName', y, x + 270, HSVToColor(math.sin(RealTime() * 6) > 0 and 0 or 240, math.abs(math.sin(RealTime() * 6)), 1), 1, 3, .8, Color(0, 0, 0, 255))
        end

        if ply:IsSpeaking() then
            draw.SimpleText('•Говорит•', 'nHudHeadNameJob', x, y + 170, Color(math.sin(RealTime() * 4) * 500, 40, 110 + (math.sin(RealTime() * 4) * 2), 255), 1, 3)
        end

        if ply:IsTyping() then
            draw.SimpleText('•Пишет•', 'nHudHeadNameJob', x, y + 170, Color(math.sin(RealTime() * 4) * 500, 40, 110 + (math.sin(RealTime() * 4) * 2), 255), 1, 3)
        end

        cam.End3D2D()
    end
end

hook.Add('PostPlayerDraw', 'NicknameOverHead', NicknameOverHead)

-- Уведомления
surface.CreateFont('nHudNotify', {
    font = 'Comfortaa',
    extended = true,
    size = 20,
})

local ScreenPos = ScrH() - 200
local Colors = {}
Colors[NOTIFY_GENERIC] = Color(0, 145, 255)
Colors[NOTIFY_ERROR] = Color(200, 0, 0)
Colors[NOTIFY_UNDO] = Color(0, 145, 255)
Colors[NOTIFY_HINT] = Color(0, 145, 255)
Colors[NOTIFY_CLEANUP] = Color(0, 145, 255)
local LoadingColor = Color(22, 160, 133)
local Icons = {}
Icons[NOTIFY_GENERIC] = Material('darkhub_ui/bulb.png')
Icons[NOTIFY_ERROR] = Material('darkhub_ui/warning.png')
Icons[NOTIFY_UNDO] = Material('darkhub_ui/undo.png')
Icons[NOTIFY_HINT] = Material('darkhub_ui/help.png')
Icons[NOTIFY_CLEANUP] = Material('darkhub_ui/scissors.png')
local LoadingIcon = Material('darkhub_ui/loading.png')
local Notifications = {}

local function DrawNotification(x, y, w, h, text, icon, col, progress)
    draw.RoundedBoxEx(10, x, y, h, h, Color(80, 80, 80), true)
    draw.RoundedBoxEx(10, x + h, y, w - h, h, Color(50, 50, 50), false, true)
    draw.RoundedBox(0, x, y + h, w, 2, color_white)
    draw.RoundedBox(0, x + h - 1, y, 2, h, color_white)
    draw.SimpleText(text, 'nHudNotify', x + 32 + 10, y + h / 2, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    surface.SetDrawColor(col)
    surface.SetMaterial(icon)

    if progress then
        surface.DrawTexturedRectRotated(x + 2, y + 2, 28, 28, -CurTime() * 360 % 360)
    else
        surface.DrawTexturedRect(x + 2, y + 2, 28, 28)
    end
end

function notification.AddLegacy(text, type, time)
    surface.SetFont('nHudNotify')
    local w = surface.GetTextSize(text) + 20 + 32
    local h = 32
    local x = ScrW()
    local y = ScreenPos

    table.insert(Notifications, 1, {
        x = x,
        y = y,
        w = w,
        h = h,
        text = text,
        col = Colors[type],
        icon = Icons[type],
        time = CurTime() + time,
        progress = false,
    })
end

function notification.AddProgress(id, text)
    surface.SetFont('nHudNotify')
    local w = surface.GetTextSize(text) + 20 + 32
    local h = 32
    local x = ScrW()
    local y = ScreenPos

    table.insert(Notifications, 1, {
        x = x,
        y = y,
        w = w,
        h = h,
        id = id,
        text = text,
        col = LoadingColor,
        icon = LoadingIcon,
        time = math.huge,
        progress = true,
    })
end

function notification.Kill(id)
    for k, v in ipairs(Notifications) do
        if v.id == id then
            v.time = 0
        end
    end
end

hook.Add('HUDPaint', 'DrawNotifications', function()
    for k, v in ipairs(Notifications) do
        DrawNotification(math.floor(v.x), math.floor(v.y), v.w, v.h, v.text, v.icon, v.col, v.progress)
        v.x = Lerp(FrameTime() * 10, v.x, v.time > CurTime() and ScrW() - v.w - 10 or ScrW() + 1)
        v.y = Lerp(FrameTime() * 10, v.y, ScreenPos - (k - 1) * (v.h + 5))
    end

    for k, v in ipairs(Notifications) do
        if v.x >= ScrW() and v.time < CurTime() then
            table.remove(Notifications, k)
        end
    end
end)

-- Прочие параметры.
local hideHUDElements = {
    ['DarkRP_HUD'] = true,
    ['DarkRP_EntityDisplay'] = true,
    ['DarkRP_LocalPlayerHUD'] = true,
    ['DarkRP_Hungermod'] = true,
    ['DarkRP_Agenda'] = true,
    ['DarkRP_Scoreboard'] = true,
    ['CHudAmmo'] = true,
    ['CHudHealth'] = true,
    ['CHudBattery'] = true,
    ['CHudSuitPower'] = true,
    ['CHudAmmo'] = true,
    ['CHudSecondaryAmmo'] = true,
}

hook.Add('HUDShouldDraw', 'aHUDHideHUD', function(name)
    if hideHUDElements[name] then return false end
end)

hook.Add('HUDDrawTargetID', 'HideDrawTarget', function() return false end)

local function DisplayNotify(msg)
    local txt = msg:ReadString()
    GAMEMODE:AddNotify(txt, msg:ReadShort(), msg:ReadLong())
    surface.PlaySound('buttons/lightswitch2.wav')
end

usermessage.Hook('_Notify', DisplayNotify)