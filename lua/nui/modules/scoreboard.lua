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


local function st()
    surface.PlaySound('buttons/button15.wav')
end

local function sh()
    LocalPlayer():EmitSound('buttons/blip1.wav', 35)
end

local function ToggleScoreboard(toggle)
    if toggle then
        local x, y = ScreenScale(400), ScreenScale(300)
        playersfr = vgui.Create('EditablePanel')
        playersfr:SetSize(x, y)
        playersfr:Center()
        playersfr:MakePopup()

        playersfr.Paint = function(self, w, h)
            draw.RoundedBox(ScreenScale(3), 0, 0, w, h, Color(80, 80, 80))
        end

        local headfr = vgui.Create('EditablePanel', playersfr)
        headfr:SetSize(playersfr:GetWide(), playersfr:GetTall() * .1)
        headfr:SetPos(0, 0)

        headfr.Paint = function(self, w, h)
            draw.RoundedBoxEx(ScreenScale(3), 0, 0, w, h * .5, Color(50, 50, 50), true, true)
            draw.RoundedBox(0, 0, h * .48, w, h * .035, color_white)
            ShadowedText(GetHostName(), 'nScoreboardFontSmall', 10, headtitles:GetTall() * .5, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
            ShadowedText('Приятной игры!', 'nScoreboardFontSmall', w * .5, headtitles:GetTall() * .5, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            ShadowedText('Игроков: ' .. player.GetCount() .. '/' .. game.MaxPlayers(), 'nScoreboardFontSmall', w - 10, headtitles:GetTall() * .5, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
        end

        headtitles = vgui.Create('EditablePanel', playersfr)
        headtitles:SetSize(playersfr:GetWide() - 20, headfr:GetTall() / 2)
        headtitles:SetPos(10, 0 + headfr:GetTall() / 2 + 7)

        headtitles.Paint = function(s, w, h)
            draw.RoundedBox(ScreenScale(3), 0, 0, w, h, Color(50, 50, 50))
            ShadowedText('Имя', 'nScoreboardFontSmall', 10, headtitles:GetTall() * .5, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
            ShadowedText('Профессия', 'nScoreboardFontSmall', w * .5, headtitles:GetTall() * .5, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            ShadowedText('Привилегия', 'nScoreboardFontSmall', w - 10, headtitles:GetTall() * .5, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
        end

        local scroller = vgui.Create('DScrollPanel', playersfr)
        scroller:SetSize(playersfr:GetWide(), playersfr:GetTall() - headfr:GetTall() / 2 - 60)
        scroller:SetPos(0, 0 + headfr:GetTall() / 2 + 10 + headtitles:GetTall())
        -- scroller.VBar:SetWide(30)
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
            local cmdbutst = {
                ['1'] = {
                    typ = 'command',
                    admin = true,
                    name = 'ТП к',
                    cmd = 'sam goto ' .. v:Name(),
                },
                ['2'] = {
                    typ = 'command',
                    admin = true,
                    name = 'ТП к себе',
                    cmd = 'sam bring ' .. v:Name(),
                },
                ['3'] = {
                    typ = 'command',
                    admin = true,
                    name = 'Вернуть игрока',
                    cmd = 'sam return ' .. v:Name(),
                },
                ['4'] = {
                    typ = 'copy',
                    admin = false,
                    name = 'SteamID ' .. v:SteamID(),
                    text = v:SteamID(),
                },
                ['5'] = {
                    typ = 'copy',
                    admin = false,
                    name = 'Ник: ' .. v:Name(),
                    text = v:Name(),
                },
                ['6'] = {
                    typ = 'arg',
                    admin = true,
                    name = 'Кикнуть',
                    cmd = 'sam kick ' .. v:Name() .. ' ',
                },
            }

            local playerbuts = vgui.Create('DButton', playersfr)
            playerbuts:SetTall(playersfr:GetTall() * .05)
            playerbuts:SetText('')
            playerbuts:DockMargin(10, 2, 3, 2)
            playerbuts:Dock(TOP)
            local a = 200

            playerbuts.OnCursorEntered = function()
                sh()
                a = 150
            end

            playerbuts.OnCursorExited = function()
                a = 200
            end

            local openstatus = false
            local ytextpos = playerbuts:GetTall() * .5
            local icons = playerbuts:GetTall() * .5
            local iconypos = playerbuts:GetTall() * .25

            playerbuts.Paint = function(s, w, h)
                draw.RoundedBox(ScreenScale(3), 0, 0, w, h, team.GetColor(v:Team()))
                draw.RoundedBox(ScreenScale(3), 0, 0, w, h, Color(0, 0, 0, a))

                if v:GetNWString('orgName') ~= '' then
                    ShadowedText(v:Name() .. ' (' .. v:GetNWString('orgName') .. ')', 'nScoreboardFontSmall', 10 + avatar:GetWide(), ytextpos, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
                else
                    ShadowedText(v:Name(), 'nScoreboardFontSmall', 10 + avatar:GetWide(), ytextpos, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
                end

                ShadowedText(v:getDarkRPVar('job'), 'nScoreboardFontSmall', w * .5, ytextpos, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                surface.SetDrawColor(color_white)
                surface.SetMaterial(Material(NUI.Scoreboard.groups[v:GetUserGroup()].icon))
                surface.DrawTexturedRect(w * .97 - surface.GetTextSize(NUI.Scoreboard.groups[v:GetUserGroup()].name), iconypos, icons, icons)
                ShadowedText(NUI.Scoreboard.groups[v:GetUserGroup()].name or 'Неизвестно', 'nScoreboardFontSmall', w - 10, ytextpos, NUI.Scoreboard.groups[v:GetUserGroup()].color, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
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
                        -- butsscroll:SetPos(5, playersfr:GetTall() * .05)
                        -- butsscroll:SetSize(playerbuts:GetWide(), 50)
                        butslist = vgui.Create('DIconLayout', butsscroll)
                        butslist:Dock(FILL)
                        butslist:SetSpaceY(5)
                        butslist:SetSpaceX(5)
                        print(butslist:GetTall())

                        surface.SetFont('nScoreboardFontButs')
                        for c in pairs(cmdbutst) do
                            cmdbut = vgui.Create('DButton', butslist)
                            cmdbut:SetSize(10 + surface.GetTextSize(cmdbutst[c].name), butsscroll:GetTall())
                            cmdbut:SetText('')
                            butslist:Add(cmdbut)
                            local texta = 255

                            cmdbut.OnCursorEntered = function()
                                texta = 200
                                sh()
                            end

                            cmdbut.OnCursorExited = function()
                                texta = 255
                            end

                            cmdbut.Paint = function(s, w, h)
                                draw.RoundedBox(h * .2, 0, 0, w, h, Color(50, 50, 50, texta))
                                ShadowedText(cmdbutst[c].name, 'nScoreboardFontButs', w * .5, h * .5, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                            end

                            cmdbut.DoClick = function()
                                if cmdbutst[c].typ == 'copy' then
                                    SetClipboardText(cmdbutst[c].text)
                                    notification.AddLegacy('Успешно скопрированно: ' .. cmdbutst[c].text, NOTIFY_HINT, 2)
                                elseif cmdbutst[c].typ == 'command' then
                                    ply:ConCommand(cmdbutst[c].cmd)
                                elseif cmdbutst[c].typ == 'arg' then
                                    Derma_StringRequest('Введите причину', 'Введите причину', '', function(arg)
                                        if arg ~= '' then
                                            ply:ConCommand(cmdbutst[c].cmd .. arg)
                                        else
                                            notification.AddLegacy('Вы не указали причину', NOTIFY_ERROR, 2)
                                        end
                                    end, function(arg) return end)
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