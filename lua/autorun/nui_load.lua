if CLIENT then
    NUI = {}
    NUI.F4 = {}
    NUI.Scoreboard = {}
end

if SERVER then
    resource.AddWorkshop('2677605873')
end

local nuifiles = {
    {rep = 'nui/modules/f4.lua'},
    {rep = 'nui/modules/scoreboard.lua'},
    {rep = 'nui/config.lua'},
}

for k, v in pairs(nuifiles) do
    if SERVER then
        AddCSLuaFile(v.rep)
    elseif CLIENT then
        include(v.rep)
    end
end