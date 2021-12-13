if CLIENT then
    NUI = {}
    NUI.F4 = {}
    NUI.Scoreboard = {}
    NUI.Functions = {}
    
    include('nui/modules/f4.lua')
    include('nui/modules/scoreboard.lua')
    include('nui/modules/functions.lua')
    include('nui/config.lua')
end

if SERVER then
    resource.AddWorkshop('2677605873')
    
    AddCSLuaFile('nui/modules/f4.lua')
    AddCSLuaFile('nui/modules/scoreboard.lua')
    AddCSLuaFile('nui/modules/functions.lua')
    AddCSLuaFile('nui/config.lua')
end

MsgC(Color(183,0,255), '----------------\n')
MsgC(Color(183,0,255), '--nUI by no4ka--\n')
MsgC(Color(183,0,255), '----------------\n')