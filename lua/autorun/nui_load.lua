if CLIENT then
    NUI = {}
    NUI.F4 = {}
    NUI.Scoreboard = {}
end

local nuifiles = {
    {rep = 'nui/modules/f4.lua'},
    {rep = 'nui/modules/hud.lua'},
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

if NUI.Workshop then
    resource.AddWorkshop('2677605873')
else
    resource.AddFile('materials/nui/vote.png')
    resource.AddFile('materials/nui/vk.png')
    resource.AddFile('materials/nui/internet.png')
    resource.AddFile('materials/nui/food.png')
    resource.AddFile('materials/nui/discord.png')
    resource.AddFile('materials/nui/cube.png')
    resource.AddFile('materials/nui/bulb.png')
    resource.AddFile('materials/nui/build.png')
    resource.AddFile('materials/nui/bring.png')
end