local nuifiles = {
    'nui/modules/f4.lua',
    'nui/modules/scoreboard.lua',
    'nui/modules/functions.lua',
    'nui/config.lua',
}

for k, v in pairs(nuifiles) do
    if SERVER then
        AddCSLuaFile(v)
    elseif CLIENT then
        include(v)
    end
end

if CLIENT then
    NUI = {}
    NUI.F4 = {}
    NUI.Scoreboard = {}
    NUI.Functions = {}
end

if SERVER then
    resource.AddWorkshop('2677605873')
end

MsgC(Color(183,0,255), '----------------\n')
MsgC(Color(183,0,255), '--nUI by no4ka--\n')
MsgC(Color(183,0,255), '----------------\n')