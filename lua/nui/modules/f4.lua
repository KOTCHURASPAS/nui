surface.CreateFont('nF4FontHead', {
    font = 'Comfortaa',
    size = ScreenScale(10),
    weight = 300,
    extended = true,
})

surface.CreateFont('nF4Font', {
    font = 'Comfortaa',
    size = ScreenScale(8),
    weight = 300,
    extended = true,
})

local closebuticon = Material('nui/delete.png', 'smooth 1')
local modelselecticon = Material('nui/user.png', 'smooth 1')

local function ScrollPaint(svar, p, c)
    local svar = p:GetVBar()

    function svar:Paint()
        return
    end

    function svar.btnUp:Paint(w, h)
        draw.RoundedBox(10, 0, 0, w, h, Color(c, c, c))
    end

    function svar.btnDown:Paint(w, h)
        draw.RoundedBox(10, 0, 0, w, h, Color(c, c, c))
    end

    function svar.btnGrip:Paint(w, h)
        draw.RoundedBox(10, 0, 0, w, h, Color(c, c, c))
    end
end

local round = 3
local fr, ci

local function nF4Menu()
    fr = vgui.Create('EditablePanel')
    fr:SetSize(ScreenScale(400), ScreenScale(300))
    fr:MakePopup()
    fr:SetPos(ScrW() * .5 - fr:GetWide() * .5, ScrH())

    fr.Paint = function(s, w, h)
        draw.RoundedBox(round, 0, 0, w, h, Color(80, 80, 80))
    end

    fr:MoveTo(ScrW() * .5 - fr:GetWide() * .5, ScrH() * .5 - fr:GetTall() * .5, .6, 0, -1)
    local h = vgui.Create('EditablePanel', fr)
    h:SetSize(fr:GetWide(), fr:GetTall() * .05)
    h:SetPos(0, 0)

    h.Paint = function(s, w, h)
        draw.RoundedBoxEx(round, 0, 0, w, h, Color(50, 50, 50), true, true)
        draw.RoundedBox(0, 0, h - h * .08, w, h * .08, color_white)
        draw.SimpleText(GetHostName(), 'nF4FontHead', w * .01, h * .5, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    end

    local cls = vgui.Create('nF4Button', h)
    cls:SetSize(h:GetTall() * 1 - 10, h:GetTall() - 10)
    cls:SetPos(h:GetWide() - cls:GetWide() - 3, 3)
    cls:SetText('')
    cls.useicon = true
    cls.icon = closebuticon
    cls.centericon = true

    cls.DoClick = function()
        fr:Remove()
    end

    local bfr = vgui.Create('EditablePanel', fr)
    bfr:SetPos(0, h:GetTall())
    bfr:SetSize(fr:GetWide() * .2, fr:GetTall() - h:GetTall())

    bfr.Paint = function(s, w, h)
        draw.RoundedBoxEx(round, 0, 0, w, h, Color(50, 50, 50), false, false, true)
    end

    local function pnlfrf(i, t)
        pnlfr = vgui.Create('EditablePanel', fr)
        pnlfr:SetPos(bfr:GetWide(), h:GetTall())
        pnlfr:SetSize(fr:GetWide() - bfr:GetWide(), fr:GetTall() - h:GetTall())

        pnlfr.Paint = function(s, w, h)
            draw.RoundedBoxEx(round, 0, 0, w, h, Color(80, 80, 80), false, false, false, true)
        end

        ci = vgui.Create('EditablePanel', pnlfr)
        ci:SetSize(pnlfr:GetWide() * .4, pnlfr:GetTall())
        ci:SetPos(pnlfr:GetWide() - ci:GetWide(), 0)

        ci.Paint = function(s, w, h)
            draw.RoundedBoxEx(round, 0, 0, w, h, Color(50, 50, 50), false, false, false, true)
        end

        local wh = vgui.Create('EditablePanel', pnlfr)
        wh:SetSize(pnlfr:GetWide() - ci:GetWide() - 10, pnlfr:GetTall() * .05)
        wh:SetPos(5, 5)

        wh.Paint = function(s, w, h)
            draw.RoundedBoxEx(round, 0, 0, w, h, Color(50, 50, 50), true, true)
            draw.RoundedBox(0, 0, h - h * .08, w, h * .08, color_white)
            surface.SetDrawColor(color_white)
            surface.SetMaterial(i)
            surface.DrawTexturedRect(w * .03, h * .15, h * .7, h * .7)
            draw.SimpleText(t, 'nF4FontHead', w * .1, h * .5, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        end
    end

    local function jobpanel()
        pnlfrf(NUI.F4.Pages.jobs.icon, NUI.F4.Pages.jobs.name)
        local jl = vgui.Create('DScrollPanel', pnlfr)
        jl:SetPos(-5, 10 + h:GetTall())
        jl:SetSize(pnlfr:GetWide() - ci:GetWide(), pnlfr:GetTall() - h:GetTall() - 15)
        jl.VBar:SetWide(jl:GetWide() * .02)
        ScrollPaint(jlscroll, jl, 50)
        local ji
        local cat

        for jk, jv in pairs(DarkRP.getCategories().jobs) do
            local iic = 0
            for tnk, jobv in pairs(jv.members) do
                iic = iic + 1
            end
    
            if iic > 0 then
                cat = vgui.Create('DCollapsibleCategory', jl)
                cat:SetExpanded(true)
                cat:Dock(TOP)
                cat:DockMargin(10, 2, 5, 2)
                cat:SetLabel('')
                cat:DockPadding(0, 0, 0, 5)
                cat.Header:SetTall(pnlfr:GetTall() * .05)
    
                cat.Paint = function(s, w, h)
                    if s:OnToggle() then
                        draw.RoundedBoxEx(round, 0, 0, w, h, Color(50, 50, 50), true, true)
                    else
                        draw.RoundedBox(round, 0, 0, w, h, Color(50, 50, 50))
                    end
    
                    draw.SimpleText(jv.name, 'nF4FontHead', w * .03, 5, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
                end
            end

            for tn, job in pairs(jv.members) do
                local i = cat:Add('Panel')
                i:SetTall(pnlfr:GetTall() * .1)
                i:SetText('')
                i:Dock(TOP)
                i:DockMargin(5, 5, 5, 0)
                ji = vgui.Create('EditablePanel', ci)
                ji:SetSize(ci:GetWide(), ci:GetTall())
                ji:SetPos(0, 0)

                i.Paint = function(s, w, h)
                    if s:IsHovered() then
                        draw.RoundedBox(round, 0, 0, w, h, Color(90, 90, 90))
                    else
                        draw.RoundedBox(round, 0, 0, w, h, Color(80, 80, 80))
                    end

                    draw.SimpleText(job.name, 'nF4FontHead', h, h * .25, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
                    draw.SimpleText(DarkRP.formatMoney(job.salary), 'nF4Font', h, h * .5, Color(24, 163, 0), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
                    local text, color

                    if job.max == 0 then
                        text = team.NumPlayers(job.team) .. '/∞'
                    else
                        text = team.NumPlayers(job.team) .. '/' .. job.max
                    end

                    if job.max == team.NumPlayers(job.team) and job.max ~= 0 then
                        color = Color(255, 0, 0)
                    else
                        color = color_white
                    end

                    draw.SimpleText(text, 'nF4Font', h, h * .7, color, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
                end

                local jwt

                if not job_weapons then
                    jwt = {}

                    for wn, wn in pairs(job.weapons) do
                        if NUI.F4.DisabledWeapons[v] then
                            continue
                        else
                            table.insert(jwt, wn)
                        end
                    end
                end

                i.DoClick = function()
                    ji:Remove()
                    ji = vgui.Create('DScrollPanel', ci)
                    ji:SetSize(ci:GetWide(), ci:GetTall())
                    ji:SetPos(0, 0)

                    ji.Paint = function(s, w, h)
                        draw.SimpleText(job.name, 'nF4FontHead', w * .5, h * .02, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                        draw.SimpleText('Зарплата: ' .. DarkRP.formatMoney(job.salary), 'nF4FontHead', w * .1, h * .1, Color(24, 163, 0), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

                        if job.hasLicense then
                            draw.SimpleText('Лицензия: есть', 'nF4FontHead', w * .1, h * .14, Color(0, 100, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
                        else
                            draw.SimpleText('Лицензия: нет', 'nF4FontHead', w * .1, h * .14, Color(0, 100, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
                        end

                        if not table.IsEmpty(jwt) then
                            draw.SimpleText('Оружия: ', 'nF4FontHead', w * .1, h * .18, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
                        end

                        draw.SimpleText('Описание:', 'nF4FontHead', w * .1, h * .45, color, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
                    end

                    local m = vgui.Create('DModelPanel', ji)
                    m:SetSize(ji:GetWide(), ji:GetWide())
                    m:SetPos(ji:GetWide() - m:GetWide() * .7, 0)

                    if istable(job.model) then
                        m:SetModel(job.model[math.random(1, #job.model)])
                    else
                        m:SetModel(job.model)
                    end

                    if not table.IsEmpty(jwt) then
                        local wl = vgui.Create('DScrollPanel', ji)
                        wl:SetPos(ji:GetWide() * .1, ji:GetTall() * .21)
                        wl:SetSize(ji:GetWide() * .4, ji:GetTall() * .2)
                        wl.VBar:SetWide(10)
                        ScrollPaint(weaponlistscroll, wl, 50)

                        wl.Paint = function(s, w, h)
                            draw.RoundedBox(round, 0, 0, w, h, Color(80, 80, 80))
                        end

                        for wn, wn in pairs(jwt) do
                            local ws = vgui.Create('DLabel', wl)
                            ws:Dock(TOP)
                            ws:DockMargin(5, 5, 5, 0)
                            ws:SetFont('nF4Font')

                            if weapons.GetStored(wn) == nil then
                                ws:SetText('• ' .. wn)
                            else
                                ws:SetText('• ' .. weapons.GetStored(wn).PrintName)
                            end
                        end
                    end

                    local bb = vgui.Create('nF4Button', ji)

                    if job.vote then
                        bb:SetText('Начать голосование')
                    else
                        bb:SetText('Устроиться')
                    end

                    bb:SetSize(ji:GetWide() * .8, ji:GetTall() * .05)
                    bb:SetPos(ji:GetWide() * .1, ji:GetTall() * .9)

                    if job.max == team.NumPlayers(job.team) and job.max ~= 0 then
                        bb:SetDisabled(true)
                    else
                        bb:SetDisabled(false)
                    end

                    bb.DoClick = function()
                        if (istable(job.model) and #job.model > 1) then
                            local ms = vgui.Create('EditablePanel', fr)
                            ms:SetSize(fr:GetWide() * .4, fr:GetTall() * .6)
                            ms:Center()
                            ms.startTime = SysTime()

                            ms.Paint = function(s, w, h)
                                Derma_DrawBackgroundBlur(s, s.startTime)
                            end

                            local msh = vgui.Create('EditablePanel', ms)
                            msh:SetPos(0, 0)
                            msh:SetSize(ms:GetWide(), ms:GetTall() * .07)

                            msh.Paint = function(s, w, h)
                                draw.RoundedBoxEx(round, 0, 0, w, h, Color(50, 50, 50), 1, 1)
                                draw.RoundedBox(0, 0, h - h * .08, w, h * .08, color_white)
                                draw.SimpleText('Выберите модель:', 'nF4FontHead', w * .07, h * .44, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
                                surface.SetDrawColor(255, 255, 255)
                                surface.SetMaterial(modelselecticon)
                                surface.DrawTexturedRect(w * .01, h * .1, h * .8, h * .8)
                            end

                            local mscb = vgui.Create('nF4Button', msh)
                            mscb:SetSize(msh:GetTall() * .8, msh:GetTall() * .8)
                            mscb:SetPos(msh:GetWide() - mscb:GetWide() - msh:GetTall() * .1, msh:GetTall() * .1)
                            mscb:SetText('')
                            mscb.useicon = true
                            mscb.icon = closebuticon
                            mscb.centericon = true

                            mscb.DoClick = function()
                                ms:Remove()
                            end

                            local mdls = vgui.Create('EditablePanel', ms)
                            mdls:SetSize(ms:GetWide(), ms:GetTall() - msh:GetTall())
                            mdls:SetPos(0, msh:GetTall())

                            mdls.Paint = function(s, w, h)
                                draw.RoundedBoxEx(round, 0, 0, w, h, Color(50, 50, 50), false, false, true, true)
                            end

                            local mss = vgui.Create('DScrollPanel', mdls)
                            mss:SetPos(5, 5)
                            mss:SetSize(mdls:GetWide() - 10, mdls:GetTall() * .8)
                            mss:GetVBar():SetWide(10)
                            local ml = vgui.Create('DIconLayout', mss)
                            ml:Dock(FILL)
                            ml:SetSpaceY(1)
                            ml:SetSpaceX(1)
                            ScrollPaint(modelselectorscroll, mss, 80)

                            for jmk, jmv in pairs(job.model) do
                                mli = ml:Add('nF4ModelSelection')
                                mli:SetModel(jmv)
                                mli:SetSize(mli:GetWide() * 1.42, mli:GetWide() * 1.45)

                                mli.Paint = function(s, w, h)
                                    if s:IsHovered() then
                                        draw.RoundedBox(round, 0, 0, w, h, Color(90, 90, 90))
                                    elseif s:IsDown() then
                                        draw.RoundedBox(round, 0, 0, w, h, Color(60, 60, 60))
                                    else
                                        draw.RoundedBox(round, 0, 0, w, h, Color(80, 80, 80))
                                    end
                                end

                                mli.DoClick = function()
                                    DarkRP.setPreferredJobModel(jv.team, jmv)
                                end
                            end

                            local mbb = vgui.Create('nF4Button', mdls)

                            if job.vote then
                                mbb:SetText('Начать голосование')
                            else
                                mbb:SetText('Устроиться')
                            end

                            mbb:SetSize(mdls:GetWide() * .5, mdls:GetTall() * .07)
                            mbb:SetPos(mdls:GetWide() * .25, mdls:GetTall() * .9)

                            mbb.DoClick = function()
                                if job.vote then
                                    RunConsoleCommand('darkrp', 'vote' .. job.command)
                                else
                                    RunConsoleCommand('darkrp', job.command)
                                end

                                fr:Remove()
                            end
                        else
                            if job.vote then
                                RunConsoleCommand('darkrp', 'vote' .. job.command)
                            else
                                RunConsoleCommand('darkrp', job.command)
                            end

                            fr:Remove()
                        end
                    end

                    local desc = vgui.Create('RichText', ji)
                    desc:SetSize(ji:GetWide() * .8, ji:GetTall() * .4)
                    desc:SetPos(ji:GetWide() * .1, ji:GetTall() * .48)
                    desc:AppendText(job.description)

                    function desc:PerformLayout()
                        self:SetFontInternal('nF4Font')
                        self:SetFGColor(color_white)
                    end

                    desc.Paint = function(s, w, h)
                        draw.RoundedBox(round, 0, 0, w, h, Color(80, 80, 80))
                    end
                end

                local icon = vgui.Create('ModelImage', i)

                if istable(job.model) then
                    icon:SetModel(job.model[math.random(1, #job.model)])
                else
                    icon:SetModel(job.model)
                end

                icon:SetPos(5, 5)
                icon:SetSize(i:GetTall() - 10, i:GetTall() - 10)

                icon.Paint = function(s, w, h)
                    draw.RoundedBox(round, 0, 0, w, h, Color(0, 0, 0, 200))
                end
            end
        end
    end

    local function entitiespanel()
        pnlfrf(NUI.F4.Pages.entities.icon, NUI.F4.Pages.entities.name)
        local sc = vgui.Create('DScrollPanel', pnlfr)
        sc:SetPos(-5, 10 + h:GetTall())
        sc:SetSize(pnlfr:GetWide() - ci:GetWide(), pnlfr:GetTall() - h:GetTall() - 15)
        sc.VBar:SetWide(sc:GetWide() * .02)
        ScrollPaint(entitiesscroll, sc, 50)
        
        local cat -- Мур
        local ei

        for eck, ecv in pairs(DarkRP.getCategories().entities) do
            local iic = 0
            for emkc, emvc in pairs(ecv.members) do
                if emvc.allowed ~= nil then
                    for ak, av in pairs(emvc.allowed) do
                        if LocalPlayer():Team() == av then
                            iic = iic + 1
                        end
                    end
                end
            end

            if iic > 0 then
                cat = vgui.Create('DCollapsibleCategory', sc)
                cat:SetExpanded(true)
                cat:Dock(TOP)
                cat:DockMargin(10, 2, 5, 2)
                cat:SetLabel('')
                cat:DockPadding(0, 0, 0, 5)
                cat.Header:SetTall(pnlfr:GetTall() * .05)

                cat.Paint = function(s, w, h)
                    draw.RoundedBox(round, 0, 0, w, h, Color(50, 50, 50))
                    draw.SimpleText(ecv.name, 'nF4FontHead', w * .03, 5, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
                end
            end

            for emk, emv in pairs(ecv.members) do
                if emv.allowed ~= nil then
                    for ak, av in pairs(emv.allowed) do
                        PrintTable(emv.allowed)
                        if av == LocalPlayer():Team() then
                            local i = cat:Add('DButton')
                            i:SetTall(pnlfr:GetTall() * .1)
                            i:SetText('')
                            i:Dock(TOP)
                            i:DockMargin(5, 5, 5, 0)
                            ei = vgui.Create('EditablePanel', ci)
                            ei:SetSize(ci:GetWide(), ci:GetTall())
                            ei:SetPos(0, 0)

                            i.Paint = function(s, w, h)
                                if s:IsHovered() then
                                    draw.RoundedBox(round, 0, 0, w, h, Color(90, 90, 90))
                                else
                                    draw.RoundedBox(round, 0, 0, w, h, Color(80, 80, 80))
                                end

                                draw.SimpleText(emv.name, 'nF4FontHead', h, h * .25, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
                                draw.SimpleText(DarkRP.formatMoney(emv.price), 'nF4Font', h, h * .5, Color(24, 163, 0), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
                                draw.SimpleText('Максимум: ' .. emv.max, 'nF4Font', h, h * .7, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
                            end

                            local icon = vgui.Create('ModelImage', i)
                            icon:SetModel(emv.model)
                            icon:SetPos(5, 5)
                            icon:SetSize(i:GetTall() - 10, i:GetTall() - 10)

                            icon.Paint = function(s, w, h)
                                draw.RoundedBox(round, 0, 0, w, h, Color(0, 0, 0, 200))
                            end

                            i.DoClick = function()
                                LocalPlayer():EmitSound('buttons/button15.wav', 25)
                                ei:Remove()
                                ei = vgui.Create('EditablePanel', ci)
                                ei:SetSize(ci:GetWide(), ci:GetTall())
                                ei:SetPos(0, 0)

                                ei.Paint = function(s, w, h)
                                    draw.SimpleText(emv.name, 'nF4FontHead', w * .5, h * .02, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                                    draw.SimpleText('Цена: ' .. DarkRP.formatMoney(emv.price), 'nF4FontHead', w * .1, h * .4, Color(24, 163, 0), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
                                    draw.SimpleText('Максимум: ' .. emv.max, 'nF4FontHead', w * .1, h * .44, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
                                end

                                local bb = vgui.Create('nF4Button', ei)
                                bb:SetSize(ei:GetWide() * .8, ei:GetTall() * .05)
                                bb:SetPos(ei:GetWide() * .1, ei:GetTall() * .9)
                                bb:SetText('Купить')

                                bb.DoClick = function()
                                    RunConsoleCommand('darkrp', emv.cmd)
                                end

                                local m = vgui.Create('DModelPanel', ei)
                                m:SetSize(ei:GetWide(), ei:GetWide())
                                m:SetPos(0, -ei:GetTall() * .1)
                                m:SetModel(emv.model)
                            end
                        end
                    end
                end
            end
        end
    end

    local function foodpanel()
        pnlfrf(NUI.F4.Pages.food.icon, NUI.F4.Pages.food.name)
        local sc = vgui.Create('DScrollPanel', pnlfr)
        sc:SetPos(-5, 10 + h:GetTall())
        sc:SetSize(pnlfr:GetWide() - ci:GetWide(), pnlfr:GetTall() - h:GetTall() - 15)
        sc.VBar:SetWide(sc:GetWide() * .02)
        ScrollPaint(foodscroll, sc, 50)
        local ei

        for eck, ecv in pairs(DarkRP.getFoodItems()) do
            local i = vgui.Create('DButton', sc)
            i:SetTall(pnlfr:GetTall() * .1)
            i:SetText('')
            i:Dock(TOP)
            i:DockMargin(10, 5, 5, 0)
            ei = vgui.Create('EditablePanel', ci)
            ei:SetSize(ci:GetWide(), ci:GetTall())
            ei:SetPos(0, 0)

            i.Paint = function(s, w, h)
                if s:IsHovered() then
                    draw.RoundedBox(round, 0, 0, w, h, Color(60, 60, 60))
                else
                    draw.RoundedBox(round, 0, 0, w, h, Color(50, 50, 50))
                end

                draw.SimpleText(ecv.name, 'nF4FontHead', h, h * .25, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
                draw.SimpleText(DarkRP.formatMoney(ecv.price), 'nF4Font', h, h * .5, Color(24, 163, 0), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
                draw.SimpleText('Энергия: ' .. ecv.energy .. '%', 'nF4Font', h, h * .75, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
            end

            local icon = vgui.Create('ModelImage', i)
            icon:SetModel(ecv.model)
            icon:SetPos(5, 5)
            icon:SetSize(i:GetTall() - 10, i:GetTall() - 10)

            icon.Paint = function(s, w, h)
                draw.RoundedBox(round, 0, 0, w, h, Color(80, 80, 80))
            end

            i.DoClick = function()
                LocalPlayer():EmitSound('buttons/button15.wav', 25)
                ei:Remove()
                ei = vgui.Create('EditablePanel', ci)
                ei:SetSize(ci:GetWide(), ci:GetTall())
                ei:SetPos(0, 0)

                ei.Paint = function(s, w, h)
                    draw.SimpleText(ecv.name, 'nF4FontHead', w * .5, h * .02, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                    draw.SimpleText('Цена: ' .. DarkRP.formatMoney(ecv.price), 'nF4FontHead', w * .1, h * .4, Color(24, 163, 0), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
                    draw.SimpleText('Энергия: ' .. ecv.energy .. '%', 'nF4FontHead', w * .1, h * .44, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
                end

                local bb = vgui.Create('nF4Button', ei)
                bb:SetSize(ei:GetWide() * .8, ei:GetTall() * .05)
                bb:SetPos(ei:GetWide() * .1, ei:GetTall() * .9)
                bb:SetText('Купить')

                bb.DoClick = function()
                    RunConsoleCommand('darkrp', 'buyfood', ecv.name)
                end

                local m = vgui.Create('DModelPanel', ei)
                m:SetSize(ei:GetWide(), ei:GetWide())
                m:SetPos(0, -ei:GetTall() * .1)
                m:SetModel(ecv.model)
            end
        end
    end

    local function shipmentspanel()
        pnlfrf(NUI.F4.Pages.shipments.icon, NUI.F4.Pages.shipments.name)
        local sc = vgui.Create('DScrollPanel', pnlfr)
        sc:SetPos(-5, 10 + h:GetTall())
        sc:SetSize(pnlfr:GetWide() - ci:GetWide(), pnlfr:GetTall() - h:GetTall() - 15)
        sc.VBar:SetWide(sc:GetWide() * .02)
        ScrollPaint(shipmentsscroll, sc, 50)
        local cat -- Мур

        for eck, ecv in pairs(DarkRP.getCategories().shipments) do
            local ei
            local iic = 0

            for emkc, emvc in pairs(ecv.members) do
                if emvc.allowed ~= nil then
                    for ak, av in pairs(emvc.allowed) do
                        if LocalPlayer():Team() == av then
                            iic = iic + 1
                        end
                    end
                end
            end

            if iic > 0 then
                cat = vgui.Create('DCollapsibleCategory', sc)
                cat:SetExpanded(true)
                cat:Dock(TOP)
                cat:DockMargin(10, 2, 5, 2)
                cat:SetLabel('')
                cat:DockPadding(0, 0, 0, 5)
                cat.Header:SetTall(pnlfr:GetTall() * .05)

                cat.Paint = function(s, w, h)
                    draw.RoundedBox(round, 0, 0, w, h, Color(50, 50, 50))
                    draw.SimpleText(ecv.name, 'nF4FontHead', w * .03, 5, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
                end
            end

            for emk, emv in pairs(ecv.members) do
                if emv.allowed ~= nil then
                    for ak, av in pairs(emv.allowed) do
                        if LocalPlayer():Team() == av then
                            local i = cat:Add('DButton', ecv.name)
                            i:SetTall(pnlfr:GetTall() * .1)
                            i:SetText('')
                            i:Dock(TOP)
                            i:DockMargin(5, 5, 5, 0)
                            ei = vgui.Create('EditablePanel', ci)
                            ei:SetSize(ci:GetWide(), ci:GetTall())
                            ei:SetPos(0, 0)

                            i.Paint = function(s, w, h)
                                if s:IsHovered() then
                                    draw.RoundedBox(round, 0, 0, w, h, Color(90, 90, 90))
                                else
                                    draw.RoundedBox(round, 0, 0, w, h, Color(80, 80, 80))
                                end

                                draw.SimpleText(emv.name, 'nF4FontHead', h, h * .25, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
                                draw.SimpleText(DarkRP.formatMoney(emv.price), 'nF4Font', h, h * .5, Color(24, 163, 0), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
                                draw.SimpleText('Максимум: ' .. emv.amount, 'nF4Font', h, h * .7, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
                            end

                            local icon = vgui.Create('ModelImage', i)
                            icon:SetModel(emv.model)
                            icon:SetPos(5, 5)
                            icon:SetSize(i:GetTall() - 10, i:GetTall() - 10)

                            icon.Paint = function(s, w, h)
                                draw.RoundedBox(round, 0, 0, w, h, Color(0, 0, 0, 200))
                            end

                            i.DoClick = function()
                                LocalPlayer():EmitSound('buttons/button15.wav', 25)
                                ei:Remove()
                                ei = vgui.Create('EditablePanel', ci)
                                ei:SetSize(ci:GetWide(), ci:GetTall())
                                ei:SetPos(0, 0)

                                ei.Paint = function(s, w, h)
                                    draw.SimpleText(emv.name, 'nF4FontHead', w * .5, h * .02, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                                    draw.SimpleText('Цена: ' .. DarkRP.formatMoney(emv.price), 'nF4FontHead', w * .1, h * .4, Color(24, 163, 0), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
                                    draw.SimpleText('Максимум: ' .. emv.amount, 'nF4FontHead', w * .1, h * .44, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
                                end

                                local bb = vgui.Create('nF4Button', ei)
                                bb:SetSize(ei:GetWide() * .8, ei:GetTall() * .05)
                                bb:SetPos(ei:GetWide() * .1, ei:GetTall() * .9)
                                bb:SetText('Купить')

                                bb.DoClick = function()
                                    RunConsoleCommand('darkrp', 'buyshipment', emv.name)
                                end

                                local m = vgui.Create('DModelPanel', ei)
                                m:SetSize(ei:GetWide(), ei:GetWide())
                                m:SetPos(0, -ei:GetTall() * .1)
                                m:SetModel(emv.model)
                            end
                        end
                    end
                end
            end
        end
    end

    jobpanel()

    for bk, bv in pairs(NUI.F4.Pages) do
        local mb = vgui.Create('nF4Button', bfr)
        mb:SetText(bv.name)
        mb:SetTall(bfr:GetTall() * .05)
        mb:Dock(TOP)
        mb:DockMargin(5, 5, 5, 2)
        mb.useicon = true
        mb.icon = bv.icon

        mb.DoClick = function()
            pnlfr:Remove()

            if bk == 'jobs' then
                jobpanel()
            elseif bk == 'entities' then
                entitiespanel()
            elseif bk == 'food' then
                foodpanel()
            elseif bk == 'shipments' then
                shipmentspanel()
            end
        end
    end

    for lk, lv in pairs(NUI.F4.Links) do
        local lb = vgui.Create('nF4Button', bfr)
        lb:Dock(TOP)
        lb:DockMargin(5, 5, 5, 2)
        lb:SetTall(bfr:GetTall() * .05)
        lb:SetPos(5, 5 + 1000)
        lb.useicon = true
        lb.icon = lv.icon
        lb:SetText(lv.name)

        lb.DoClick = function()
            gui.OpenURL(lv.link)
        end
    end
end

return hook.Add('PlayerBindPress', 'DarkRPF4Bind', function(ply, bind, pressed)
    if string.find(bind, 'gm_showspare2', 1, true) then
        nF4Menu()
    end
end)