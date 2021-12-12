local function ShadowedText(text, font, x, y, color, alignx, aligny)
    draw.SimpleText(text, font, x - 1, y - 1, Color(0, 0, 0, 200), alignx, aligny)
    draw.SimpleText(text, font, x + 1, y + 1, Color(0, 0, 0, 200), alignx, aligny)
    draw.SimpleText(text, font, x, y, color, alignx, aligny)
end

surface.CreateFont('nScoreboardFont', {
    font = 'Comfortaa',
    size = ScreenScale(10),
    weight = 300,
    extended = true,
})

surface.CreateFont('nScoreboardFontSmall', {
    font = 'Comfortaa',
    size = ScreenScale(10),
    weight = 300,
    extended = true,
})

surface.CreateFont('nScoreboardFontButs', {
    font = 'Comfortaa',
    size = ScreenScale(8),
    weight = 300,
    extended = true,
})

local function PlayedTime(time)
    local t = {}
    local w = math.floor(time / (86400 * 7))

    if (w > 0) then
        table.insert(t, w .. 'н')
        time = time - w * (86400 * 7)
    end

    local d = math.floor(time / 86400)

    if (d > 0) then
        table.insert(t, d .. 'д')
        time = time - d * 86400
    end

    local h = math.floor(time / 3600)

    if (h > 0) then
        table.insert(t, h .. 'ч')
        time = time - h * 3600
    end

    local m = math.floor(time / 60)

    if (m > 0) then
        table.insert(t, m .. 'м')
        time = time - m * 60
    end

    return table.concat(t, ' ')
end

local function st()
    LocalPlayer():EmitSound('buttons/button15.wav', 25)
end

local deficon = Material('icon16/user.png')

local function ToggleScoreboard(toggle)
    if toggle then
        local x, y = ScreenScale(400), ScreenScale(300)
        playersfr = vgui.Create('EditablePanel')
        playersfr:SetSize(x, y)
        playersfr:Center()
        playersfr:MakePopup()

        playersfr.Paint = function(self, w, h)
            draw.RoundedBox(3, 0, 0, w, h, Color(80, 80, 80))
        end

        local headfr = vgui.Create('EditablePanel', playersfr)
        headfr:SetSize(playersfr:GetWide(), playersfr:GetTall() * .1)
        headfr:SetPos(0, 0)

        headfr.Paint = function(self, w, h)
            draw.RoundedBoxEx(3, 0, 0, w, h * .5, Color(50, 50, 50), true, true)
            draw.RoundedBox(0, 0, h * .48, w, h * .035, color_white)
            ShadowedText(GetHostName(), 'nScoreboardFontSmall', 10, headtitles:GetTall() * .5, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
            ShadowedText('Приятной игры!', 'nScoreboardFontSmall', w * .5, headtitles:GetTall() * .5, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            ShadowedText('Игроков: ' .. player.GetCount() .. '/' .. game.MaxPlayers(), 'nScoreboardFontSmall', w - 10, headtitles:GetTall() * .5, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
        end

        headtitles = vgui.Create('EditablePanel', playersfr)
        headtitles:SetSize(playersfr:GetWide() - 20, headfr:GetTall() / 2)
        headtitles:SetPos(10, 0 + headfr:GetTall() / 2 + 7)

        headtitles.Paint = function(s, w, h)
            draw.RoundedBox(3, 0, 0, w, h, Color(50, 50, 50))
            ShadowedText('Имя', 'nScoreboardFontSmall', 10, headtitles:GetTall() * .5, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
            ShadowedText('Профессия', 'nScoreboardFontSmall', w * .4, headtitles:GetTall() * .5, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            ShadowedText('Сыграно', 'nScoreboardFontSmall', w * .7, headtitles:GetTall() * .5, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            ShadowedText('Привилегия', 'nScoreboardFontSmall', w - 10, headtitles:GetTall() * .5, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
        end

        local scroller = vgui.Create('DScrollPanel', playersfr)
        scroller:SetSize(playersfr:GetWide(), playersfr:GetTall() - headfr:GetTall() / 2 - 60)
        scroller:SetPos(0, 0 + headfr:GetTall() / 2 + 10 + headtitles:GetTall())
        scroller:DockPadding(5,5,5,5)
        scroller.VBar:SetWide(playersfr:GetWide() * .01)
        local scrollerp = scroller:GetVBar()

        function scrollerp:Paint()
            return
        end

        function scrollerp.btnUp:Paint(w, h)
            draw.RoundedBox(10, 0, 0, w, h, Color(50, 50, 50))
        end

        function scrollerp.btnDown:Paint(w, h)
            draw.RoundedBox(10, 0, 0, w, h, Color(50, 50, 50))
        end

        function scrollerp.btnGrip:Paint(w, h)
            draw.RoundedBox(10, 0, 0, w, h, Color(50, 50, 50))
        end

        local players = player.GetAll()
        table.sort(players, function(a, b) return a:Team() > b:Team() end)

        for k, v in pairs(players) do
            local playerbuts = vgui.Create('DButton', playersfr)
            playerbuts:SetTall(playersfr:GetTall() * .05)
            playerbuts:SetText('')
            playerbuts:DockMargin(10,5,10,0)
            playerbuts:Dock(TOP)

            local openstatus = false
            local ytextpos = playerbuts:GetTall() * .5
            local icons = playerbuts:GetTall() * .5
            local iconypos = playerbuts:GetTall() * .25

            playerbuts.Paint = function(s, w, h)
                draw.RoundedBox(3, 0, 0, w, h, team.GetColor(v:Team()))
                if s:IsHovered() then
                    draw.RoundedBox(3, 0, 0, w, h, Color(0, 0, 0, 150))
                else
                    draw.RoundedBox(3, 0, 0, w, h, Color(0, 0, 0, 200))
                end
                
                if NUI.Scoreboard.orgs then
                    if v:GetNWString('orgName') ~= '' then
                        ShadowedText(v:Name() .. ' (' .. v:GetNWString('orgName') .. ')', 'nScoreboardFontSmall', 10 + avatar:GetWide(), ytextpos, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
                    else
                        ShadowedText(v:Name(), 'nScoreboardFontSmall', 10 + avatar:GetWide(), ytextpos, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
                    end
                else
                    ShadowedText(v:Name(), 'nScoreboardFontSmall', 10 + avatar:GetWide(), ytextpos, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
                end

                ShadowedText(v:getDarkRPVar('job'), 'nScoreboardFontSmall', w * .4, ytextpos, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                ShadowedText(PlayedTime(v:GetUTime() + CurTime() - v:GetUTimeStart()), 'nScoreboardFontSmall', w * .7, ytextpos, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                if not (NUI.Scoreboard.groups[v:GetUserGroup()]) then
                    surface.SetDrawColor(color_white)
                    surface.SetMaterial(deficon)
                    surface.DrawTexturedRect(w * .97 - surface.GetTextSize('Неизвестно'), iconypos, icons, icons)
                    ShadowedText('Неизвестно', 'nScoreboardFontSmall', w - 10, ytextpos, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
                else
                    surface.SetDrawColor(color_white)
                    surface.SetMaterial(NUI.Scoreboard.groups[v:GetUserGroup()].icon)
                    surface.DrawTexturedRect(w * .97 - surface.GetTextSize(NUI.Scoreboard.groups[v:GetUserGroup()].name), iconypos, icons, icons)
                    ShadowedText(NUI.Scoreboard.groups[v:GetUserGroup()].name, 'nScoreboardFontSmall', w - 10, ytextpos, NUI.Scoreboard.groups[v:GetUserGroup()].color, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
                end
            end

            avatar = vgui.Create('CircleAvatarImage', playerbuts)
            avatar:SetPlayer(v, 128)
            avatar:SetSize(playerbuts:GetTall() / 1.4, playerbuts:GetTall() / 1.4)
            avatar:SetMaskSize(avatar:GetTall() / 1.6)
            avatar:SetPos(playerbuts:GetWide() * .1, playerbuts:GetTall() * .15)
            local butsscroll
            local ply = LocalPlayer()
            local plybuth = playerbuts:GetTall()

            playerbuts.DoClick = function(self)
                if openstatus then
                    openstatus = false
                    self:SizeTo(self:GetWide(), plybuth, 0.2, 0, -1)
                    butsscroll:Remove()
                    st()
                else
                    openstatus = true

                    timer.Simple(0.2, function()
                        butsscroll = vgui.Create('DHorizontalScroller', playerbuts)
                        butsscroll:Dock(BOTTOM)
                        butsscroll:DockMargin(5, 0, 0, 5)
                        butslist = vgui.Create('DIconLayout', butsscroll)
                        butslist:Dock(FILL)
                        butslist:SetSpaceY(5)
                        butslist:SetSpaceX(5)

                        for ck, cv in pairs(NUI.Scoreboard.cmdbuts) do
                            
                            surface.SetFont('nScoreboardFontButs')
                            cmdbut = vgui.Create('DButton', butslist)
                            cmdbut:SetPos(0, 0)
                            cmdbut:SetSize(10 + surface.GetTextSize(cv.name), butsscroll:GetTall() * .9)
                            cmdbut:SetText('')
                            butslist:Add(cmdbut)

                            cmdbut.Paint = function(s, w, h)
                                if s:IsHovered() then
                                    draw.RoundedBox(h * .2, 0, 0, w, h, Color(50, 50, 50, 200))
                                else
                                    draw.RoundedBox(h * .2, 0, 0, w, h, Color(50, 50, 50, 255))
                                end
                                ShadowedText(cv.name, 'nScoreboardFontButs', w * .5, h * .5, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                            end

                            cmdbut.DoClick = function()
                                if cv.type == 'cmd' then
                                    RunConsoleCommand(NUI.Scoreboard.adminprefix, cv.cmd, v:Name())
                                elseif cv.type == 'arg' then
                                    Derma_StringRequest('Введите причину', 'Введите причину', '', function(arg)
                                        if arg ~= '' then
                                            RunConsoleCommand(NUI.Scoreboard.adminprefix, cv.cmd, v:Name(), arg)
                                        else
                                            notification.AddLegacy('Вы не указали причину', NOTIFY_ERROR, 2)
                                        end
                                    end, function(arg) return end)
                                elseif cv.type == 'copy' then
                                    local wc
                                    if cv.str == 'name' then
                                        SetClipboardText(v:Name())
                                        wc = v:Name()
                                    elseif cv.str == 'steamid' then
                                        SetClipboardText(v:SteamID())
                                        wc = v:SteamID()
                                    elseif cv.str == 'steamid64' then
                                        SetClipboardText(v:SteamID64())
                                        wc = v:SteamID64()
                                    elseif cv.str == 'job' then
                                        SetClipboardText(v:getDarkRPVar('job'))
                                        wc = v:getDarkRPVar('job')
                                    elseif cv.str == 'group' then
                                        SetClipboardText(v:GetUserGroup())
                                        wc = v:GetUserGroup()
                                    end
                                    notification.AddLegacy('Успешно скопированно: ' .. wc, NOTIFY_ERROR, 2)
                                end
                                st()
                            end
                        end
                    end)

                    self:SizeTo(self:GetWide(), plybuth * 1.6, 0.2, 0, -1)
                    st()
                end
            end

            scroller:Add(playerbuts)
        end
    else
        if IsValid(playersfr) then
            playersfr:Remove()
        end
    end
end

hook.Add('ScoreboardShow', 'nScoreboardOpen', function()
    ToggleScoreboard(true)

    return false
end)

hook.Add('ScoreboardHide', 'nScoreboardClose', function()
    ToggleScoreboard(false)
end)