if CLIENT then
    NUI = {}
    NUI.F4 = {}
    NUI.Scoreboard = {}
end

local nuifiles = {
    {rep = 'nui/f4.lua'},
    {rep = 'nui/hud.lua'},
    {rep = 'nui/scoreboard.lua'},
    {rep = 'config.lua'},
}

for k, v in pairs(nuifiles) do
    if SERVER then
        AddCSLuaFile(v.rep)
    elseif CLIENT then
        include(v.rep)
    end
end