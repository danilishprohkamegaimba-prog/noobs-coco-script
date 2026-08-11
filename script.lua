local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local Lighting = game:GetService("Lighting")
local VIM = game:GetService("VirtualInputManager")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local Mouse = LocalPlayer:GetMouse()

local Settings = {
    ESP = {Enabled = false, Color = "White", Thickness = 2, Transparency = 0.8, BoxType = "Corner", Name = true, Distance = true, HealthBar = true, Skeleton = false, HeadDot = false, Tracers = false, Glow = false, Radar = false, Weapon = false, Pulse = false},
    Chams = {Enabled = false, Color = "Red", FillTrans = 0.5, OutlineTrans = 0.3, Xray = false},
    Aimbot = {Enabled = false, FOV = 200, Smoothness = 3, TargetPart = "Head", UnlockFOV = false, SilentAim = false, FOVColor = "Red", TriggerBot = false, HitChance = 100, TargetLock = false, VisibleCheck = true},
    KillAura = {Enabled = false, Range = 50, Teleport = true, TeleportHeight = 15},
    Teleport = {ClickTP = false, PlayerTP = false, ItemTP = false},
    AutoClicker = {Enabled = false, CPS = 10, MouseButton = "Left"},
    Misc = {Fly = false, FlySpeed = 50, NoClip = false, Speed = false, SpeedVal = 50, InfJump = false, JumpPower = false, JumpVal = 100, Gravity = false, GravVal = 50, Fullbright = false, NoRecoil = false, NoSpread = false, FOVChanger = false, FOVVal = 90, ThirdPerson = false, TPdist = 10, ZoomHack = false, Crosshair = false, CrosshairSize = 20, CrosshairThick = 2, CrosshairGap = 10, AutoBunnyhop = false, FakeLag = false, Spinbot = false, NameStealer = false},
    UI = {Theme = "Red", Notifications = true, Watermark = true, Animations = true}
}

local Colors = {
    White = Color3.fromRGB(255, 255, 255), Red = Color3.fromRGB(255, 50, 50), Green = Color3.fromRGB(50, 255, 50),
    Blue = Color3.fromRGB(50, 50, 255), LightBlue = Color3.fromRGB(100, 180, 255), Purple = Color3.fromRGB(200, 50, 255),
    Yellow = Color3.fromRGB(255, 255, 50), Orange = Color3.fromRGB(255, 150, 0), Pink = Color3.fromRGB(255, 100, 200),
    Cyan = Color3.fromRGB(0, 255, 255), Gray = Color3.fromRGB(160, 160, 160)
}

local Themes = {
    Red = {Main = Color3.fromRGB(18, 18, 22), Accent = Color3.fromRGB(255, 60, 60)},
    Dark = {Main = Color3.fromRGB(12, 12, 16), Accent = Color3.fromRGB(100, 100, 100)},
    Blue = {Main = Color3.fromRGB(15, 15, 25), Accent = Color3.fromRGB(60, 100, 255)},
    Green = {Main = Color3.fromRGB(12, 22, 16), Accent = Color3.fromRGB(60, 255, 100)},
    Purple = {Main = Color3.fromRGB(20, 15, 30), Accent = Color3.fromRGB(180, 60, 255)},
    Cyan = {Main = Color3.fromRGB(12, 22, 24), Accent = Color3.fromRGB(0, 200, 200)},
    Orange = {Main = Color3.fromRGB(24, 18, 12), Accent = Color3.fromRGB(255, 150, 50)}
}

local ESPData = {}
local lockedTarget = nil

local function getTheme() return Themes[Settings.UI.Theme] or Themes.Red end

local function saveSettings()
    pcall(function() writefile("NOOBS_COCO_Settings.json", HttpService:JSONEncode(Settings)) end)
end

local function loadSettings()
    pcall(function()
        if isfile("NOOBS_COCO_Settings.json") then
            local data = HttpService:JSONDecode(readfile("NOOBS_COCO_Settings.json"))
            for k, v in pairs(data) do
                if Settings[k] then for k2, v2 in pairs(v) do if Settings[k][k2] ~= nil then Settings[k][k2] = v2 end end end
            end
        end
    end)
end
loadSettings()

local function clickMouse()
    pcall(function() VIM:SendMouseButtonEvent(0, 0, 0, true, game, 0) task.wait(0.01) VIM:SendMouseButtonEvent(0, 0, 0, false, game, 0) end)
end

local function isVisible(targetPart)
    local rayOrigin = Camera.CFrame.Position
    local rayDirection = (targetPart.Position - rayOrigin).Unit * 1000
    local raycastParams = RaycastParams.new()
    raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
    raycastParams.FilterDescendantsInstances = {LocalPlayer.Character}
    local rayResult = workspace:Raycast(rayOrigin, rayDirection, raycastParams)
    return rayResult and rayResult.Instance:IsDescendantOf(targetPart.Parent) or false
end

local gui = Instance.new("ScreenGui", CoreGui)
gui.Name = "NCGUI"

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 460, 0, 620)
main.Position = UDim2.new(0.5, -230, 0.06, 0)
main.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.Visible = true
main.ClipsDescendants = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 10)

local titleBar = Instance.new("Frame", main)
titleBar.Size = UDim2.new(1, 0, 0, 50)
titleBar.BackgroundColor3 = Color3.fromRGB(10, 10, 14)
titleBar.BorderSizePixel = 0
Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0, 10)

local title = Instance.new("TextLabel", titleBar)
title.Size = UDim2.new(0, 250, 0, 32)
title.Position = UDim2.new(0, 20, 0, 8)
title.BackgroundTransparency = 1
title.Text = "NOOBS COCO"
title.TextColor3 = Color3.fromRGB(255, 60, 60)
title.Font = Enum.Font.GothamBlack
title.TextSize = 22
title.TextXAlignment = Enum.TextXAlignment.Left

local closeBtn = Instance.new("TextButton", titleBar)
closeBtn.Size = UDim2.new(0, 35, 0, 35)
closeBtn.Position = UDim2.new(1, -42, 0.5, -17)
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
closeBtn.BorderSizePixel = 0
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 16
closeBtn.AutoButtonColor = false
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 6)

local tabHolder = Instance.new("Frame", main)
tabHolder.Size = UDim2.new(1, 0, 0, 44)
tabHolder.Position = UDim2.new(0, 0, 0, 50)
tabHolder.BackgroundColor3 = Color3.fromRGB(16, 16, 20)
tabHolder.BorderSizePixel = 0

local Tabs = {}
local TabContents = {}
local tabNames = {"ESP", "Chams", "Aimbot", "KillAura", "Teleport", "AutoClick", "Misc"}
local currentTab = "ESP"

for i, name in ipairs(tabNames) do
    local btn = Instance.new("TextButton", tabHolder)
    btn.Size = UDim2.new(1/#tabNames, -8, 0, 36)
    btn.Position = UDim2.new((i-1)/#tabNames, 4, 0, 4)
    btn.BackgroundColor3 = name == currentTab and Color3.fromRGB(255, 60, 60) or Color3.fromRGB(30, 30, 35)
    btn.BorderSizePixel = 0
    btn.Text = name == "AutoClick" and "A.Click" or name
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 8
    btn.AutoButtonColor = false
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)
    Tabs[name] = btn
    
    local sc = Instance.new("ScrollingFrame", main)
    sc.Size = UDim2.new(1, 0, 1, -94)
    sc.Position = UDim2.new(0, 0, 0, 94)
    sc.BackgroundTransparency = 1
    sc.BorderSizePixel = 0
    sc.ScrollBarThickness = 2
    sc.ScrollBarImageColor3 = Color3.fromRGB(255, 60, 60)
    sc.CanvasSize = UDim2.new(0, 0, 0, 1000)
    sc.Visible = name == currentTab
    
    local inner = Instance.new("Frame", sc)
    inner.Size = UDim2.new(1, 0, 0, 1000)
    inner.BackgroundTransparency = 1
    TabContents[name] = {scroll = sc, inner = inner}
    
    btn.MouseButton1Click:Connect(function()
        currentTab = name
        for n, b in pairs(Tabs) do b.BackgroundColor3 = n == name and Color3.fromRGB(255, 60, 60) or Color3.fromRGB(30, 30, 35) end
        for n, c in pairs(TabContents) do c.scroll.Visible = n == name end
    end)
end

closeBtn.MouseButton1Click:Connect(function()
    if Settings.UI.Animations then
        main.Visible = false
        main.Size = UDim2.new(0, 460, 0, 620)
        main.Position = UDim2.new(0.5, -230, 0.06, 0)
    else
        main.Visible = false
    end
end)

local function section(parent, name, y)
    local s = Instance.new("Frame", parent)
    s.Size = UDim2.new(1, -20, 0, 32)
    s.Position = UDim2.new(0, 10, 0, y)
    s.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    s.BorderSizePixel = 0
    Instance.new("UICorner", s).CornerRadius = UDim.new(0, 5)
    local l = Instance.new("TextLabel", s)
    l.Size = UDim2.new(1, -16, 1, 0)
    l.Position = UDim2.new(0, 14, 0, 0)
    l.BackgroundTransparency = 1
    l.Text = name
    l.TextColor3 = Color3.fromRGB(255, 255, 255)
    l.Font = Enum.Font.GothamBold
    l.TextSize = 12
    l.TextXAlignment = Enum.TextXAlignment.Left
    return y + 36
end

local function toggle(parent, text, y, def, cb)
    local f = Instance.new("Frame", parent)
    f.Size = UDim2.new(1, -20, 0, 32)
    f.Position = UDim2.new(0, 10, 0, y)
    f.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    f.BorderSizePixel = 0
    Instance.new("UICorner", f).CornerRadius = UDim.new(0, 5)
    local l = Instance.new("TextLabel", f)
    l.Size = UDim2.new(0.5, 0, 1, 0)
    l.Position = UDim2.new(0, 10, 0, 0)
    l.BackgroundTransparency = 1
    l.Text = text
    l.TextColor3 = Color3.fromRGB(200, 200, 200)
    l.Font = Enum.Font.Gotham
    l.TextSize = 11
    l.TextXAlignment = Enum.TextXAlignment.Left
    local b = Instance.new("TextButton", f)
    b.Size = UDim2.new(0, 50, 0, 24)
    b.Position = UDim2.new(1, -58, 0.5, -12)
    b.BorderSizePixel = 0
    b.BackgroundColor3 = def and Color3.fromRGB(40, 200, 40) or Color3.fromRGB(60, 60, 65)
    b.Text = def and "ON" or "OFF"
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.Font = Enum.Font.GothamBold
    b.TextSize = 10
    b.AutoButtonColor = false
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 4)
    local state = def
    b.MouseButton1Click:Connect(function()
        state = not state
        b.Text = state and "ON" or "OFF"
        b.BackgroundColor3 = state and Color3.fromRGB(40, 200, 40) or Color3.fromRGB(60, 60, 65)
        cb(state)
        saveSettings()
    end)
    return y + 35
end

local function dropdown(parent, text, y, opts, defIdx, cb)
    local f = Instance.new("Frame", parent)
    f.Size = UDim2.new(1, -20, 0, 62)
    f.Position = UDim2.new(0, 10, 0, y)
    f.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    f.BorderSizePixel = 0
    Instance.new("UICorner", f).CornerRadius = UDim.new(0, 5)
    local l = Instance.new("TextLabel", f)
    l.Size = UDim2.new(1, -16, 0, 20)
    l.Position = UDim2.new(0, 8, 0, 5)
    l.BackgroundTransparency = 1
    l.Text = text
    l.TextColor3 = Color3.fromRGB(170, 170, 170)
    l.Font = Enum.Font.Gotham
    l.TextSize = 10
    local b = Instance.new("TextButton", f)
    b.Size = UDim2.new(1, -16, 0, 28)
    b.Position = UDim2.new(0, 8, 0, 28)
    b.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    b.BorderSizePixel = 0
    b.Text = opts[defIdx]
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.Font = Enum.Font.Gotham
    b.TextSize = 11
    b.AutoButtonColor = false
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 4)
    local idx = defIdx
    b.MouseButton1Click:Connect(function()
        idx = idx % #opts + 1
        b.Text = opts[idx]
        cb(opts[idx])
        saveSettings()
    end)
    return y + 65
end

local function slider(parent, text, y, min, max, def, cb)
    local f = Instance.new("Frame", parent)
    f.Size = UDim2.new(1, -20, 0, 54)
    f.Position = UDim2.new(0, 10, 0, y)
    f.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    f.BorderSizePixel = 0
    Instance.new("UICorner", f).CornerRadius = UDim.new(0, 5)
    local l = Instance.new("TextLabel", f)
    l.Size = UDim2.new(1, -16, 0, 20)
    l.Position = UDim2.new(0, 8, 0, 5)
    l.BackgroundTransparency = 1
    l.Text = text .. ": " .. string.format("%.0f", def)
    l.TextColor3 = Color3.fromRGB(170, 170, 170)
    l.Font = Enum.Font.Gotham
    l.TextSize = 10
    local bar = Instance.new("TextButton", f)
    bar.Size = UDim2.new(1, -16, 0, 18)
    bar.Position = UDim2.new(0, 8, 0, 30)
    bar.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    bar.BorderSizePixel = 0
    bar.Text = ""
    bar.AutoButtonColor = false
    Instance.new("UICorner", bar).CornerRadius = UDim.new(0, 9)
    local fill = Instance.new("Frame", bar)
    fill.Size = UDim2.new((def - min) / (max - min), 0, 1, 0)
    fill.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
    fill.BorderSizePixel = 0
    Instance.new("UICorner", fill).CornerRadius = UDim.new(0, 9)
    local val, drag = def, false
    local function upd()
        local mp = UserInputService:GetMouseLocation()
        local rx = math.clamp((mp.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
        val = min + (max - min) * rx
        fill.Size = UDim2.new(rx, 0, 1, 0)
        l.Text = text .. ": " .. string.format("%.0f", val)
        cb(val)
    end
    bar.MouseButton1Down:Connect(function() drag = true upd() end)
    UserInputService.InputChanged:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseMovement and drag then upd() end end)
    UserInputService.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then drag = false saveSettings() end end)
    return y + 57
end

local y = 6
local inner = TabContents["ESP"].inner
y = section(inner, "ESP", y)
y = toggle(inner, "Enabled", y, Settings.ESP.Enabled, function(s) Settings.ESP.Enabled = s end)
y = dropdown(inner, "Box Type", y, {"Corner", "Full", "Corner+Full"}, 1, function(o) Settings.ESP.BoxType = o end)
y = dropdown(inner, "Color", y, {"White", "Red", "Green", "Blue", "Purple", "Yellow", "Cyan", "Rainbow"}, 1, function(o) Settings.ESP.Color = o end)
y = slider(inner, "Thickness", y, 1, 5, Settings.ESP.Thickness, function(v) Settings.ESP.Thickness = v end)
y = slider(inner, "Transparency", y, 0, 1, Settings.ESP.Transparency, function(v) Settings.ESP.Transparency = v end)
y = toggle(inner, "Name", y, Settings.ESP.Name, function(s) Settings.ESP.Name = s end)
y = toggle(inner, "Distance", y, Settings.ESP.Distance, function(s) Settings.ESP.Distance = s end)
y = toggle(inner, "HP Bar", y, Settings.ESP.HealthBar, function(s) Settings.ESP.HealthBar = s end)
y = toggle(inner, "Skeleton", y, Settings.ESP.Skeleton, function(s) Settings.ESP.Skeleton = s end)
y = toggle(inner, "Head Dot", y, Settings.ESP.HeadDot, function(s) Settings.ESP.HeadDot = s end)
y = toggle(inner, "Tracers", y, Settings.ESP.Tracers, function(s) Settings.ESP.Tracers = s end)
y = toggle(inner, "Glow", y, Settings.ESP.Glow, function(s) Settings.ESP.Glow = s end)
y = toggle(inner, "Radar", y, Settings.ESP.Radar, function(s) Settings.ESP.Radar = s end)
y = toggle(inner, "Weapon", y, Settings.ESP.Weapon, function(s) Settings.ESP.Weapon = s end)
y = toggle(inner, "Pulse", y, Settings.ESP.Pulse, function(s) Settings.ESP.Pulse = s end)
TabContents["ESP"].scroll.CanvasSize = UDim2.new(0, 0, 0, y + 20)

y = 6
inner = TabContents["Chams"].inner
y = section(inner, "CHAMS", y)
y = toggle(inner, "Enabled", y, Settings.Chams.Enabled, function(s) Settings.Chams.Enabled = s
    for _, p in pairs(Players:GetPlayers()) do if p ~= LocalPlayer and p.Character then local hl = p.Character:FindFirstChild("CH") if hl then hl.Enabled = s elseif s then applyChams(p) end end end
end)
y = dropdown(inner, "Color", y, {"Red", "Green", "Blue", "Purple", "Yellow", "Orange", "Pink", "Cyan"}, 1, function(o) Settings.Chams.Color = o end)
y = slider(inner, "Fill Trans", y, 0, 1, Settings.Chams.FillTrans, function(v) Settings.Chams.FillTrans = v end)
y = slider(inner, "Outline Trans", y, 0, 1, Settings.Chams.OutlineTrans, function(v) Settings.Chams.OutlineTrans = v end)
TabContents["Chams"].scroll.CanvasSize = UDim2.new(0, 0, 0, y + 20)

y = 6
inner = TabContents["Aimbot"].inner
y = section(inner, "AIMBOT", y)
y = toggle(inner, "Enabled", y, Settings.Aimbot.Enabled, function(s) Settings.Aimbot.Enabled = s end)
y = dropdown(inner, "Target", y, {"Head", "HumanoidRootPart", "UpperTorso"}, 1, function(o) Settings.Aimbot.TargetPart = o end)
y = toggle(inner, "Unlock FOV", y, Settings.Aimbot.UnlockFOV, function(s) Settings.Aimbot.UnlockFOV = s end)
y = toggle(inner, "Silent Aim", y, Settings.Aimbot.SilentAim, function(s) Settings.Aimbot.SilentAim = s end)
y = slider(inner, "FOV", y, 50, 500, Settings.Aimbot.FOV, function(v) Settings.Aimbot.FOV = v end)
y = slider(inner, "Smoothness", y, 1, 15, Settings.Aimbot.Smoothness, function(v) Settings.Aimbot.Smoothness = v end)
y = dropdown(inner, "FOV Color", y, {"Red", "Green", "Blue", "White", "Yellow", "Purple", "Cyan"}, 1, function(o) Settings.Aimbot.FOVColor = o end)
y = toggle(inner, "Visible Check", y, Settings.Aimbot.VisibleCheck, function(s) Settings.Aimbot.VisibleCheck = s end)
y = toggle(inner, "Trigger Bot", y, Settings.Aimbot.TriggerBot, function(s) Settings.Aimbot.TriggerBot = s end)
y = toggle(inner, "Target Lock", y, Settings.Aimbot.TargetLock, function(s) Settings.Aimbot.TargetLock = s end)
TabContents["Aimbot"].scroll.CanvasSize = UDim2.new(0, 0, 0, y + 20)

y = 6
inner = TabContents["KillAura"].inner
y = section(inner, "KILL AURA", y)
y = toggle(inner, "Enabled", y, Settings.KillAura.Enabled, function(s) Settings.KillAura.Enabled = s end)
y = slider(inner, "Range", y, 10, 200, Settings.KillAura.Range, function(v) Settings.KillAura.Range = v end)
y = toggle(inner, "Teleport", y, Settings.KillAura.Teleport, function(s) Settings.KillAura.Teleport = s end)
y = slider(inner, "Height", y, 5, 50, Settings.KillAura.TeleportHeight, function(v) Settings.KillAura.TeleportHeight = v end)
TabContents["KillAura"].scroll.CanvasSize = UDim2.new(0, 0, 0, y + 20)

y = 6
inner = TabContents["Teleport"].inner
y = section(inner, "TELEPORT", y)
y = toggle(inner, "Click TP", y, Settings.Teleport.ClickTP, function(s) Settings.Teleport.ClickTP = s end)
y = toggle(inner, "Player TP", y, Settings.Teleport.PlayerTP, function(s) Settings.Teleport.PlayerTP = s end)
y = toggle(inner, "Item TP", y, Settings.Teleport.ItemTP, function(s) Settings.Teleport.ItemTP = s end)
TabContents["Teleport"].scroll.CanvasSize = UDim2.new(0, 0, 0, y + 20)

y = 6
inner = TabContents["AutoClick"].inner
y = section(inner, "AUTO CLICKER", y)
y = toggle(inner, "Enabled", y, Settings.AutoClicker.Enabled, function(s) Settings.AutoClicker.Enabled = s if s then startClicker() else stopClicker() end end)
y = slider(inner, "CPS", y, 1, 30, Settings.AutoClicker.CPS, function(v) Settings.AutoClicker.CPS = v end)
y = dropdown(inner, "Button", y, {"Left", "Right"}, 1, function(o) Settings.AutoClicker.MouseButton = o end)
TabContents["AutoClick"].scroll.CanvasSize = UDim2.new(0, 0, 0, y + 20)

y = 6
inner = TabContents["Misc"].inner
y = section(inner, "MOVEMENT", y)
y = toggle(inner, "Fly", y, Settings.Misc.Fly, function(s) Settings.Misc.Fly = s if s then startFly() else stopFly() end end)
y = slider(inner, "Fly Speed", y, 10, 200, Settings.Misc.FlySpeed, function(v) Settings.Misc.FlySpeed = v end)
y = toggle(inner, "NoClip", y, Settings.Misc.NoClip, function(s) Settings.Misc.NoClip = s if s then enableNC() else disableNC() end end)
y = toggle(inner, "Speed", y, Settings.Misc.Speed, function(s) Settings.Misc.Speed = s updSpeed() end)
y = slider(inner, "Speed Val", y, 16, 200, Settings.Misc.SpeedVal, function(v) Settings.Misc.SpeedVal = v updSpeed() end)
y = toggle(inner, "Jump", y, Settings.Misc.JumpPower, function(s) Settings.Misc.JumpPower = s updJump() end)
y = slider(inner, "Jump Val", y, 50, 300, Settings.Misc.JumpVal, function(v) Settings.Misc.JumpVal = v updJump() end)
y = toggle(inner, "Inf Jump", y, Settings.Misc.InfJump, function(s) Settings.Misc.InfJump = s end)
y = toggle(inner, "Gravity", y, Settings.Misc.Gravity, function(s) Settings.Misc.Gravity = s updGrav() end)
y = slider(inner, "Grav Val", y, 10, 196, Settings.Misc.GravVal, function(v) Settings.Misc.GravVal = v updGrav() end)
y = toggle(inner, "Bunnyhop", y, Settings.Misc.AutoBunnyhop, function(s) Settings.Misc.AutoBunnyhop = s end)

y = section(inner, "VISUAL", y + 3)
y = toggle(inner, "Fullbright", y, Settings.Misc.Fullbright, function(s) if s then Lighting.Brightness = 3 else Lighting.Brightness = 1 end end)
y = toggle(inner, "No Recoil", y, Settings.Misc.NoRecoil, function(s) Settings.Misc.NoRecoil = s end)
y = toggle(inner, "No Spread", y, Settings.Misc.NoSpread, function(s) Settings.Misc.NoSpread = s end)
y = toggle(inner, "FOV Changer", y, Settings.Misc.FOVChanger, function(s) Settings.Misc.FOVChanger = s if s then Camera.FieldOfView = Settings.Misc.FOVVal else Camera.FieldOfView = 70 end end)
y = slider(inner, "FOV Val", y, 30, 120, Settings.Misc.FOVVal, function(v) Settings.Misc.FOVVal = v if Settings.Misc.FOVChanger then Camera.FieldOfView = v end end)
y = toggle(inner, "3rd Person", y, Settings.Misc.ThirdPerson, function(s) Settings.Misc.ThirdPerson = s
    local c = LocalPlayer.Character if c then local h = c:FindFirstChildOfClass("Humanoid") if h then h.CameraOffset = s and Vector3.new(0, 2, Settings.Misc.TPdist) or Vector3.zero end end
end)
y = slider(inner, "3P Dist", y, 2, 20, Settings.Misc.TPdist, function(v) Settings.Misc.TPdist = v if Settings.Misc.ThirdPerson then local c = LocalPlayer.Character if c then local h = c:FindFirstChildOfClass("Humanoid") if h then h.CameraOffset = Vector3.new(0, 2, v) end end end end)
y = toggle(inner, "Zoom Hack", y, Settings.Misc.ZoomHack, function(s) Settings.Misc.ZoomHack = s end)
y = toggle(inner, "Crosshair", y, Settings.Misc.Crosshair, function(s) Settings.Misc.Crosshair = s end)
y = slider(inner, "CH Size", y, 5, 40, Settings.Misc.CrosshairSize, function(v) Settings.Misc.CrosshairSize = v end)
y = slider(inner, "CH Thick", y, 1, 5, Settings.Misc.CrosshairThick, function(v) Settings.Misc.CrosshairThick = v end)
y = slider(inner, "CH Gap", y, 5, 30, Settings.Misc.CrosshairGap, function(v) Settings.Misc.CrosshairGap = v end)

y = section(inner, "FUN", y + 3)
y = toggle(inner, "Fake Lag", y, Settings.Misc.FakeLag, function(s) Settings.Misc.FakeLag = s end)
y = toggle(inner, "Spinbot", y, Settings.Misc.Spinbot, function(s) Settings.Misc.Spinbot = s end)
y = toggle(inner, "Name Stealer", y, Settings.Misc.NameStealer, function(s) Settings.Misc.NameStealer = s end)

y = section(inner, "UI", y + 3)
y = dropdown(inner, "Theme", y, {"Red", "Dark", "Blue", "Green", "Purple", "Cyan", "Orange"}, 1, function(o) Settings.UI.Theme = o
    local t = getTheme() main.BackgroundColor3 = t.Main title.TextColor3 = t.Accent
    for n, b in pairs(Tabs) do b.BackgroundColor3 = n == currentTab and t.Accent or Color3.fromRGB(30, 30, 35) end
end)
y = toggle(inner, "Notifications", y, Settings.UI.Notifications, function(s) Settings.UI.Notifications = s end)
y = toggle(inner, "Watermark", y, Settings.UI.Watermark, function(s) Settings.UI.Watermark = s end)
y = toggle(inner, "Animations", y, Settings.UI.Animations, function(s) Settings.UI.Animations = s end)
TabContents["Misc"].scroll.CanvasSize = UDim2.new(0, 0, 0, y + 20)

function applyChams(player)
    if not player.Character then return end
    local c = player.Character local old = c:FindFirstChild("CH") if old then old:Destroy() end
    local hl = Instance.new("Highlight") hl.Name = "CH" hl.Enabled = Settings.Chams.Enabled
    hl.FillTransparency = Settings.Chams.FillTrans hl.OutlineTransparency = Settings.Chams.OutlineTrans
    hl.Adornee = c hl.Parent = c
    if Settings.Chams.Color ~= "Rainbow" then local col = Colors[Settings.Chams.Color] or Colors.Red hl.FillColor = col hl.OutlineColor = col end
end

function createESP(player)
    if ESPData[player] then
        if ESPData[player].conn then ESPData[player].conn:Disconnect() end
        if ESPData[player].lines then for _, l in pairs(ESPData[player].lines) do l:Remove() end end
        if ESPData[player].skLines then for _, l in pairs(ESPData[player].skLines) do l:Remove() end end
        if ESPData[player].texts then for _, t in pairs(ESPData[player].texts) do t:Remove() end end
        if ESPData[player].hp then ESPData[player].hp.bg:Remove() ESPData[player].hp.fill:Remove() end
        if ESPData[player].dot then ESPData[player].dot:Remove() end
        if ESPData[player].tracer then ESPData[player].tracer:Remove() end
        if ESPData[player].wt then ESPData[player].wt:Remove() end
    end
    ESPData[player] = {lines = {}, skLines = {}, texts = {}}
    local lines = {} for i = 1, 12 do local l = Drawing.new("Line") l.Visible = false lines[i] = l end
    local skLines = {} for i = 1, 12 do local l = Drawing.new("Line") l.Visible = false l.Thickness = 1 skLines[i] = l end
    local nt = Drawing.new("Text") nt.Visible = false nt.Center = true nt.Size = 14 nt.Font = 3 nt.Outline = true nt.OutlineColor = Color3.fromRGB(0,0,0)
    local dt = Drawing.new("Text") dt.Visible = false dt.Center = true dt.Size = 12 dt.Font = 3 dt.Outline = true dt.OutlineColor = Color3.fromRGB(0,0,0)
    local hbg = Drawing.new("Square") hbg.Visible = false hbg.Filled = true hbg.Color = Color3.fromRGB(15,15,15) hbg.Transparency = 0.4
    local hf = Drawing.new("Square") hf.Visible = false hf.Filled = true
    local dot = Drawing.new("Circle") dot.Visible = false dot.Radius = 4 dot.Filled = true dot.NumSides = 16
    local tracer = Drawing.new("Line") tracer.Visible = false tracer.Thickness = 1
    local wt = Drawing.new("Text") wt.Visible = false wt.Center = true wt.Size = 12 wt.Font = 3 wt.Outline = true wt.OutlineColor = Color3.fromRGB(0,0,0)
    ESPData[player].lines = lines ESPData[player].skLines = skLines ESPData[player].texts = {nt, dt} ESPData[player].hp = {bg = hbg, fill = hf} ESPData[player].dot = dot ESPData[player].tracer = tracer ESPData[player].wt = wt
    
    ESPData[player].conn = RunService.RenderStepped:Connect(function()
        local c = player.Character
        if not c then for _, l in pairs(lines) do l.Visible = false end for _, l in pairs(skLines) do l.Visible = false end nt.Visible = false dt.Visible = false hbg.Visible = false hf.Visible = false dot.Visible = false tracer.Visible = false wt.Visible = false return end
        local h = c:FindFirstChild("Head") local r = c:FindFirstChild("HumanoidRootPart") local hm = c:FindFirstChildOfClass("Humanoid")
        if not h or not r or not hm or hm.Health <= 0 then for _, l in pairs(lines) do l.Visible = false end dot.Visible = false tracer.Visible = false wt.Visible = false return end
        if not Settings.ESP.Enabled then for _, l in pairs(lines) do l.Visible = false end dot.Visible = false tracer.Visible = false wt.Visible = false nt.Visible = false dt.Visible = false hbg.Visible = false hf.Visible = false return end
        
        local hp = h.Position + Vector3.new(0, 0.5, 0) local rp = r.Position - Vector3.new(0, 2, 0)
        local cp = r.Position + Vector3.new(0, math.abs(h.Position.Y - r.Position.Y), 0)
        local ts = Camera:WorldToViewportPoint(hp) local bs = Camera:WorldToViewportPoint(rp) local headScreen = Camera:WorldToViewportPoint(h.Position)
        if ts.Z <= 0 then return end
        
        local dist = (Camera.CFrame.Position - cp).Magnitude
        local pulseScale = Settings.ESP.Pulse and (1 + math.sin(tick() * 5) * 0.05) or 1
        local bw = math.clamp((2.5 / dist) * 500 * pulseScale, 20, 200)
        local cs = Camera:WorldToViewportPoint(cp)
        local lx, rx = cs.X - bw/2, cs.X + bw/2
        local ty, by = ts.Y, bs.Y
        local color = Settings.ESP.Color == "Rainbow" and Color3.fromHSV(tick()%5/5, 1, 1) or (Colors[Settings.ESP.Color] or Colors.White)
        
        for i = 1, 12 do lines[i].Visible = false end
        for i = 1, 12 do skLines[i].Visible = false end
        
        if Settings.ESP.BoxType ~= "Corner" then
            lines[1].From = Vector2.new(lx, ty) lines[1].To = Vector2.new(rx, ty) lines[1].Visible = true
            lines[2].From = Vector2.new(rx, ty) lines[2].To = Vector2.new(rx, by) lines[2].Visible = true
            lines[3].From = Vector2.new(rx, by) lines[3].To = Vector2.new(lx, by) lines[3].Visible = true
            lines[4].From = Vector2.new(lx, by) lines[4].To = Vector2.new(lx, ty) lines[4].Visible = true
            for i = 1, 4 do lines[i].Color = color lines[i].Thickness = Settings.ESP.Thickness lines[i].Transparency = Settings.ESP.Transparency end
        end
        
        if Settings.ESP.BoxType ~= "Full" then
            local cs2 = math.min(bw * 0.3, 40)
            lines[5].From = Vector2.new(lx, ty) lines[5].To = Vector2.new(lx + cs2, ty) lines[5].Visible = true
            lines[6].From = Vector2.new(lx, ty) lines[6].To = Vector2.new(lx, ty + cs2) lines[6].Visible = true
            lines[7].From = Vector2.new(rx, ty) lines[7].To = Vector2.new(rx - cs2, ty) lines[7].Visible = true
            lines[8].From = Vector2.new(rx, ty) lines[8].To = Vector2.new(rx, ty + cs2) lines[8].Visible = true
            lines[9].From = Vector2.new(rx, by) lines[9].To = Vector2.new(rx - cs2, by) lines[9].Visible = true
            lines[10].From = Vector2.new(rx, by) lines[10].To = Vector2.new(rx, by - cs2) lines[10].Visible = true
            lines[11].From = Vector2.new(lx, by) lines[11].To = Vector2.new(lx + cs2, by) lines[11].Visible = true
            lines[12].From = Vector2.new(lx, by) lines[12].To = Vector2.new(lx, by - cs2) lines[12].Visible = true
            for i = 5, 12 do lines[i].Color = color lines[i].Thickness = Settings.ESP.Thickness + 1 lines[i].Transparency = Settings.ESP.Transparency end
        end
        
        if Settings.ESP.Skeleton then
            local torso = c:FindFirstChild("UpperTorso") or c:FindFirstChild("Torso")
            local rArm = c:FindFirstChild("RightUpperArm") or c:FindFirstChild("Right Arm")
            local lArm = c:FindFirstChild("LeftUpperArm") or c:FindFirstChild("Left Arm")
            local rLeg = c:FindFirstChild("RightUpperLeg") or c:FindFirstChild("Right Leg")
            local lLeg = c:FindFirstChild("LeftUpperLeg") or c:FindFirstChild("Left Leg")
            local parts = {{h, torso}, {torso, rArm}, {torso, lArm}, {torso, rLeg}, {torso, lLeg}}
            for i, pair in ipairs(parts) do
                if pair[1] and pair[2] then
                    local p1, v1 = Camera:WorldToViewportPoint(pair[1].Position) local p2, v2 = Camera:WorldToViewportPoint(pair[2].Position)
                    if v1 and v2 then skLines[i].From = Vector2.new(p1.X, p1.Y) skLines[i].To = Vector2.new(p2.X, p2.Y) skLines[i].Visible = true skLines[i].Color = color skLines[i].Transparency = Settings.ESP.Transparency end
                end
            end
        end
        
        if Settings.ESP.HeadDot then dot.Visible = true dot.Position = Vector2.new(headScreen.X, headScreen.Y) dot.Color = color else dot.Visible = false end
        if Settings.ESP.Tracers then tracer.Visible = true tracer.From = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y) tracer.To = Vector2.new(headScreen.X, headScreen.Y) tracer.Color = color else tracer.Visible = false end
        if Settings.ESP.Weapon then local tool = c:FindFirstChildOfClass("Tool") if tool then wt.Visible = true wt.Text = tool.Name wt.Position = Vector2.new(cs.X, by + 18) wt.Color = Color3.fromRGB(255,255,255) else wt.Visible = false end else wt.Visible = false end
        if Settings.ESP.Name then nt.Visible = true nt.Text = player.Name nt.Position = Vector2.new(cs.X, ty - 20) nt.Color = Color3.fromRGB(255,255,255) else nt.Visible = false end
        if Settings.ESP.Distance then dt.Visible = true dt.Text = math.floor(dist).."m" dt.Position = Vector2.new(cs.X, by + 5) dt.Color = Color3.fromRGB(255,255,255) else dt.Visible = false end
        if Settings.ESP.HealthBar then
            local health = hm.Health / hm.MaxHealth local bh = by - ty local bx = lx - 7
            hbg.Visible = true hbg.Size = Vector2.new(3, bh) hbg.Position = Vector2.new(bx, ty)
            hf.Visible = true hf.Size = Vector2.new(3, bh*health) hf.Position = Vector2.new(bx, ty + bh*(1-health)) hf.Color = Color3.fromHSV(health*0.33, 1, 1)
        else hbg.Visible = false hf.Visible = false end
    end)
end

local function getTarget()
    if Settings.Aimbot.TargetLock and lockedTarget then
        local char = lockedTarget.Character
        if char then
            local tp = char:FindFirstChild(Settings.Aimbot.TargetPart) local hm = char:FindFirstChildOfClass("Humanoid")
            if tp and hm and hm.Health > 0 and (not Settings.Aimbot.VisibleCheck or isVisible(tp)) then return tp, 0 end
        end
        lockedTarget = nil
    end
    
    local best, bestDist = nil, Settings.Aimbot.FOV
    for _, p in pairs(Players:GetPlayers()) do
        if p == LocalPlayer or not p.Character then continue end
        local tp = p.Character:FindFirstChild(Settings.Aimbot.TargetPart) local hm = p.Character:FindFirstChildOfClass("Humanoid")
        if not tp or not hm or hm.Health <= 0 then continue end
        local sp, vis = Camera:WorldToViewportPoint(tp.Position)
        if not Settings.Aimbot.UnlockFOV and not vis then continue end
        if Settings.Aimbot.VisibleCheck and not isVisible(tp) then continue end
        local d = (Vector2.new(sp.X, sp.Y) - Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)).Magnitude
        if d < bestDist then bestDist = d best = tp lockedTarget = p end
    end
    return best, bestDist
end

local function killAura()
    if not Settings.KillAura.Enabled then return end
    local c = LocalPlayer.Character if not c then return end
    local r = c:FindFirstChild("HumanoidRootPart") local h = c:FindFirstChildOfClass("Humanoid")
    if not r or not h or h.Health <= 0 then return end
    for _, p in pairs(Players:GetPlayers()) do
        if p == LocalPlayer or not p.Character then continue end
        local th = p.Character:FindFirstChildOfClass("Humanoid")
        if not th or th.Health <= 0 then continue end
        local tr = p.Character:FindFirstChild("HumanoidRootPart")
        if tr and (r.Position - tr.Position).Magnitude <= Settings.KillAura.Range then
            local tp = p.Character:FindFirstChild("Head")
            if tp then
                if Settings.KillAura.Teleport then r.CFrame = CFrame.new(tp.Position + Vector3.new(0, Settings.KillAura.TeleportHeight, 0)) end
                Camera.CFrame = CFrame.new(Camera.CFrame.Position, tp.Position) clickMouse()
            end
            break
        end
    end
end

local clickerConn
function startClicker()
    if clickerConn then clickerConn:Disconnect() end
    clickerConn = RunService.RenderStepped:Connect(function()
        if not Settings.AutoClicker.Enabled then stopClicker() return end
        task.wait(1 / Settings.AutoClicker.CPS)
        if Settings.AutoClicker.MouseButton == "Left" then clickMouse() else VIM:SendMouseButtonEvent(0, 0, 1, true, game, 0) VIM:SendMouseButtonEvent(0, 0, 1, false, game, 0) end
    end)
end
function stopClicker() if clickerConn then clickerConn:Disconnect() clickerConn = nil end end

local fovCircle = Drawing.new("Circle") fovCircle.Visible = false fovCircle.Thickness = 1.5 fovCircle.NumSides = 100 fovCircle.Transparency = 0.7
local chLines = {} for i = 1, 4 do local l = Drawing.new("Line") l.Visible = false l.Color = Color3.fromRGB(255, 60, 60) l.Thickness = 2 l.Transparency = 0.6 chLines[i] = l end
local radarLines = {} for i = 1, 32 do local l = Drawing.new("Line") l.Visible = false l.Color = Color3.fromRGB(255, 60, 60) l.Thickness = 1 radarLines[i] = l end
local radarBg = Drawing.new("Square") radarBg.Visible = false radarBg.Filled = true radarBg.Color = Color3.fromRGB(0,0,0) radarBg.Transparency = 0.6
local radarSize = 120

Mouse.Button1Down:Connect(function()
    if Settings.Teleport.ClickTP then
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then char.HumanoidRootPart.CFrame = CFrame.new(Mouse.Hit.Position + Vector3.new(0, 3, 0)) end
    end
    if Settings.Teleport.ItemTP then
        local char = LocalPlayer.Character
        if char then
            local tool = char:FindFirstChildOfClass("Tool")
            if tool and tool:FindFirstChild("Handle") then tool.Handle.CFrame = CFrame.new(Mouse.Hit.Position + Vector3.new(0, 3, 0)) end
        end
    end
end)

local wm
if Settings.UI.Watermark then
    wm = Instance.new("TextLabel", CoreGui)
    wm.Size = UDim2.new(0, 240, 0, 32)
    wm.Position = UDim2.new(1, -250, 0, 10)
    wm.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    wm.BackgroundTransparency = 0.45
    wm.BorderSizePixel = 0
    wm.Text = "NOOBS COCO | ULTIMATE+"
    wm.TextColor3 = Color3.fromRGB(255, 60, 60)
    wm.Font = Enum.Font.GothamBold
    wm.TextSize = 14
    wm.ZIndex = 999
    Instance.new("UICorner", wm).CornerRadius = UDim.new(0, 6)
    spawn(function()
        local fps = 0 local last = tick()
        while wm and wm.Parent do
            fps = fps + 1
            if tick() - last >= 1 then
                pcall(function() wm.Text = "NOOBS COCO | FPS: " .. fps .. " | " .. os.date("%H:%M:%S") end)
                fps = 0 last = tick()
            end
            task.wait()
        end
    end)
end

RunService.RenderStepped:Connect(function()
    if Settings.Misc.InfJump then local c = LocalPlayer.Character if c then local h = c:FindFirstChildOfClass("Humanoid") if h then h.Jump = true end end end
    if Settings.Misc.AutoBunnyhop then local c = LocalPlayer.Character if c then local h = c:FindFirstChildOfClass("Humanoid") local r = c:FindFirstChild("HumanoidRootPart") if h and r and h.MoveDirection.Magnitude > 0 and h.FloorMaterial ~= Enum.Material.Air then h.Jump = true end end end
    if Settings.Misc.NoRecoil then pcall(function() for _, v in pairs(LocalPlayer.Character:GetChildren()) do if v:IsA("Tool") then v.Recoil = 0 end end end) end
    if Settings.Misc.NoSpread then pcall(function() for _, v in pairs(LocalPlayer.Character:GetChildren()) do if v:IsA("Tool") then v.Spread = 0 end end end) end
    if Settings.Misc.FakeLag then pcall(function() local c = LocalPlayer.Character if c then for _, p in pairs(c:GetDescendants()) do if p:IsA("BasePart") then p.Velocity = Vector3.zero end end end end) end
    if Settings.Misc.Spinbot then local c = LocalPlayer.Character if c and c:FindFirstChild("HumanoidRootPart") then c.HumanoidRootPart.CFrame = c.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(15), 0) end end
    if Settings.Misc.NameStealer then
        local best = nil
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character then
                if not best or (p.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and (LocalPlayer.Character.HumanoidRootPart.Position - p.Character.HumanoidRootPart.Position).Magnitude < (LocalPlayer.Character.HumanoidRootPart.Position - best.Character.HumanoidRootPart.Position).Magnitude) then best = p end
            end
        end
        if best then pcall(function() LocalPlayer.Name = best.Name end) end
    end
    
    fovCircle.Visible = Settings.Aimbot.Enabled and not Settings.Aimbot.UnlockFOV
    if fovCircle.Visible then fovCircle.Radius = Settings.Aimbot.FOV fovCircle.Position = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2) fovCircle.Color = Colors[Settings.Aimbot.FOVColor] or Colors.Red end
    
    if Settings.Misc.Crosshair then
        local cx = Camera.ViewportSize.X/2 local cy = Camera.ViewportSize.Y/2 local s = Settings.Misc.CrosshairSize local g = Settings.Misc.CrosshairGap local t = Settings.Misc.CrosshairThick
        chLines[1].From = Vector2.new(cx - g, cy) chLines[1].To = Vector2.new(cx - g - s, cy) chLines[1].Visible = true chLines[1].Thickness = t
        chLines[2].From = Vector2.new(cx + g, cy) chLines[2].To = Vector2.new(cx + g + s, cy) chLines[2].Visible = true chLines[2].Thickness = t
        chLines[3].From = Vector2.new(cx, cy - g) chLines[3].To = Vector2.new(cx, cy - g - s) chLines[3].Visible = true chLines[3].Thickness = t
        chLines[4].From = Vector2.new(cx, cy + g) chLines[4].To = Vector2.new(cx, cy + g + s) chLines[4].Visible = true chLines[4].Thickness = t
    else for _, l in pairs(chLines) do l.Visible = false end end
    
    if Settings.ESP.Radar then
        local rx = Camera.ViewportSize.X - radarSize - 20 local ry = Camera.ViewportSize.Y - radarSize - 20
        radarBg.Visible = true radarBg.Size = Vector2.new(radarSize, radarSize) radarBg.Position = Vector2.new(rx, ry)
        for i, p in pairs(Players:GetPlayers()) do
            if i > 32 then break end
            if p == LocalPlayer or not p.Character then radarLines[i].Visible = false continue end
            local r = p.Character:FindFirstChild("HumanoidRootPart") if not r then continue end
            local rel = r.Position - Camera.CFrame.Position
            local dotX = rx + radarSize/2 + (rel.X / 100) * (radarSize/2)
            local dotY = ry + radarSize/2 + (rel.Z / 100) * (radarSize/2)
            if math.abs(rel.X) < 100 and math.abs(rel.Z) < 100 then
                radarLines[i].Visible = true radarLines[i].From = Vector2.new(dotX - 2, dotY - 2) radarLines[i].To = Vector2.new(dotX + 2, dotY + 2) radarLines[i].Color = Colors[Settings.ESP.Color] or Colors.White
            else radarLines[i].Visible = false end
        end
    else radarBg.Visible = false for _, l in pairs(radarLines) do l.Visible = false end end
    
    killAura()
    
    if Settings.Aimbot.Enabled then
        local bt, bd = getTarget()
        if bt then
            if Settings.Aimbot.SilentAim then Camera.CFrame = CFrame.new(Camera.CFrame.Position, bt.Position)
            else Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, bt.Position), 1/math.max(Settings.Aimbot.Smoothness, 1)) end
            if Settings.Aimbot.TriggerBot and bd < 50 then clickMouse() end
        end
    end
end)

local flyConn
function startFly()
    local c = LocalPlayer.Character if not c then return end
    local r = c:FindFirstChild("HumanoidRootPart") local h = c:FindFirstChildOfClass("Humanoid")
    if not r or not h then return end h.PlatformStand = true
    flyConn = RunService.RenderStepped:Connect(function()
        if not Settings.Misc.Fly then stopFly() return end
        local vel = Vector3.new()
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then vel += Camera.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then vel -= Camera.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then vel -= Camera.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then vel += Camera.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then vel += Vector3.new(0,1,0) end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then vel -= Vector3.new(0,1,0) end
        r.Velocity = vel * Settings.Misc.FlySpeed * 0.5
    end)
end
function stopFly() if flyConn then flyConn:Disconnect() end local c = LocalPlayer.Character if c then local h = c:FindFirstChildOfClass("Humanoid") if h then h.PlatformStand = false end end end

local ncConn
function enableNC() ncConn = RunService.Stepped:Connect(function() if LocalPlayer.Character then for _, p in pairs(LocalPlayer.Character:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide = false end end end end) end
function disableNC() if ncConn then ncConn:Disconnect() end end

function updSpeed() local c = LocalPlayer.Character if c then local h = c:FindFirstChildOfClass("Humanoid") if h then h.WalkSpeed = Settings.Misc.Speed and Settings.Misc.SpeedVal or 16 end end end
function updJump() local c = LocalPlayer.Character if c then local h = c:FindFirstChildOfClass("Humanoid") if h then h.UseJumpPower = true h.JumpPower = Settings.Misc.JumpPower and Settings.Misc.JumpVal or 50 end end end
function updGrav() workspace.Gravity = Settings.Misc.Gravity and Settings.Misc.GravVal or 196.2 end

for _, p in pairs(Players:GetPlayers()) do
    if p ~= LocalPlayer then
        p.CharacterAdded:Connect(function() task.wait(0.3) createESP(p) applyChams(p) end)
        if p.Character then createESP(p) applyChams(p) end
    end
end
Players.PlayerAdded:Connect(function(p) if p ~= LocalPlayer then p.CharacterAdded:Connect(function() task.wait(0.3) createESP(p) applyChams(p) end) if p.Character then createESP(p) applyChams(p) end end end)
Players.PlayerRemoving:Connect(function(p) if lockedTarget == p then lockedTarget = nil end end)

UserInputService.InputBegan:Connect(function(input, gp)
    if not gp and input.KeyCode == Enum.KeyCode.V then
        if main.Visible then
            if Settings.UI.Animations then
                main.Size = UDim2.new(0, 460, 0, 620)
                main.Position = UDim2.new(0.5, -230, 0.06, 0)
            end
            main.Visible = false
        else
            main.Visible = true
        end
    end
    if Settings.Misc.ZoomHack and input.UserInputType == Enum.UserInputType.MouseButton2 then
        Camera.FieldOfView = 20
        input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then Camera.FieldOfView = Settings.Misc.FOVChanger and Settings.Misc.FOVVal or 70 end end)
    end
end)

LocalPlayer.CharacterAdded:Connect(function() task.wait(0.5) updSpeed() updJump() updGrav() end)
if LocalPlayer.Character then updSpeed() updJump() updGrav() end
