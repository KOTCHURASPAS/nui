if (SERVER) then
    resource.AddWorkshop('2677605873')

    AddCSLuaFile('nui/config.lua')
    AddCSLuaFile('nui/modules/f4.lua')
    AddCSLuaFile('nui/modules/scoreboard.lua')
    AddCSLuaFile('nui/modules/functions.lua')
else
    NUI = NUI or {}
    NUI.F4 = {}
    NUI.Scoreboard = {}
    NUI.Functions = {}
    NUI.F4.SpecialJobs = {}

    hook.Add("loadCustomDarkRPItems", "nUISpecialJobs", function()
        include('nui/config.lua')
    end)

    include('nui/config.lua')
    include('nui/modules/f4.lua')
    include('nui/modules/scoreboard.lua')
    include('nui/modules/functions.lua')
end

MsgC(Color(183,0,255), '----------------\n')
MsgC(Color(183,0,255), '--nUI by no4ka--\n')
MsgC(Color(183,0,255), '----------------\n')