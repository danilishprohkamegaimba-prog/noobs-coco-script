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
    ESP = {Enabled = false, Color = "White", Thickness = 2, Transparency = 0.8, BoxType = "Corner", Name = true, Distance = true, HealthBar = true, CheckHealth = true},
    Chams = {Enabled = false, Color = "Red", FillTrans = 0.5, OutlineTrans = 0.3},
    Aimbot = {Enabled = false, FOV = 200, Smoothness = 3, TargetPart = "Head", UnlockFOV = false, SilentAim = false, FOVColor = "Red", TriggerBot = false, TargetLock = false, VisibleCheck = true},
    KillAura = {Enabled = false, Range = 50, Teleport = true, TeleportHeight = 15, Spin = false, SpinSpeed = 5, SpinDistance = 5},
    Teleport = {ClickTP = false, TeleportItem = false},
    AutoClicker = {Enabled = false, CPS = 10, MouseButton = "Left"},
    Misc = {Fly = false, FlySpeed = 50, NoClip = false, Speed = false, SpeedVal = 50, InfJump = false, JumpPower = false, JumpVal = 100, Gravity = false, GravVal = 50, Fullbright = false, NoRecoil = false, NoSpread = false, FOVChanger = false, FOVVal = 90, Crosshair = false, CrosshairSize = 20, CrosshairThick = 2, CrosshairGap = 10, AutoBunnyhop = false},
    UI = {Theme = "Red"}
}

local Colors = {
    White = Color3.fromRGB(255, 255, 255), Red = Color3.fromRGB(255, 50, 50), Green = Color3.fromRGB(50, 255, 50),
    Blue = Color3.fromRGB(50, 50, 255), LightBlue = Color3.fromRGB(100, 180, 255), Purple = Color3.fromRGB(200, 50, 255),
    Yellow = Color3.fromRGB(255, 255, 50), Orange = Color3.fromRGB(255, 150, 0), Pink = Color3.fromRGB(255, 100, 200),
    Cyan = Color3.fromRGB(0, 255, 255), Gray = Color3.fromRGB(160, 160, 160)
}

local Themes = {
    Red = Color3.fromRGB(255, 60, 60), Dark = Color3.fromRGB(100, 100, 100), Blue = Color3.fromRGB(60, 100, 255),
    Green = Color3.fromRGB(60, 255, 100), Purple = Color3.fromRGB(180, 60, 255), Cyan = Color3.fromRGB(0, 200, 200),
    Orange = Color3.fromRGB(255, 150, 50), Pink = Color3.fromRGB(255, 100, 200), White = Color3.fromRGB(255, 255, 255),
    Yellow2 = Color3.fromRGB(255, 255, 50), Lime = Color3.fromRGB(150, 255, 50)
}

local ESPCache = {}
local PlayerCache = {}
local function getTheme() return Themes[Settings.UI.Theme] or Themes.Red end

local function saveSettings()
    pcall(function() writefile("NOOBS_COCO_Settings.json", HttpService:JSONEncode(Settings)) end)
end

local function loadSettings()
    pcall(function()
        if isfile("NOOBS_COCO_Settings.json") then
            local data = HttpService:JSONDecode(readfile("NOOBS_COCO_Settings.json"))
            for k, v in pairs(data) do for k2, v2 in pairs(v) do if Settings[k] and Settings[k][k2] ~= nil then Settings[k][k2] = v2 end end end
        end
    end)
end
loadSettings()

local function clickMouse()
    pcall(function() VIM:SendMouseButtonEvent(0, 0, 0, true, game, 0) task.wait(0.01) VIM:SendMouseButtonEvent(0, 0, 0, false, game, 0) end)
end

local function isAlive(p)
    if not p then return false end
    if PlayerCache[p] and PlayerCache[p].lastCheck and tick() - PlayerCache[p].lastCheck < 0.5 then
        return PlayerCache[p].alive
    end
    local char = p.Character
    if not char then
        if PlayerCache[p] then PlayerCache[p].alive = false PlayerCache[p].lastCheck = tick() end
        return false
    end
    local hum = char:FindFirstChildOfClass("Humanoid")
    local alive = hum and hum.Health > 0 or false
    if not PlayerCache[p] then PlayerCache[p] = {} end
    PlayerCache[p].alive = alive
    PlayerCache[p].lastCheck = tick()
    return alive
end

local gui = Instance.new("ScreenGui", CoreGui)
gui.Name = "NCGUI"

local mainFrame = Instance.new("Frame", gui)
mainFrame.Size = UDim2.new(0, 400, 0, 550)
mainFrame.Position = UDim2.new(0.5, -200, 0.1, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 16)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Visible = true
mainFrame.ZIndex = 10
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 10)

local titleBar = Instance.new("Frame", mainFrame)
titleBar.Size = UDim2.new(1, 0, 0, 45)
titleBar.BackgroundColor3 = Color3.fromRGB(8, 8, 12)
titleBar.BorderSizePixel = 0
titleBar.ZIndex = 11
Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0, 10)

local titleGradient = Instance.new("UIGradient", titleBar)
titleGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0, getTheme()), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 120, 120))}
titleGradient.Rotation = 90

local titleLabel = Instance.new("TextLabel", titleBar)
titleLabel.Size = UDim2.new(0, 200, 0, 28)
titleLabel.Position = UDim2.new(0, 15, 0.5, -14)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "NOOBS COCO"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.Font = Enum.Font.GothamBlack
titleLabel.TextSize = 18
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.ZIndex = 12

local closeBtn = Instance.new("TextButton", titleBar)
closeBtn.Size = UDim2.new(0, 28, 0, 28)
closeBtn.Position = UDim2.new(1, -36, 0.5, -14)
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
closeBtn.BackgroundTransparency = 0.8
closeBtn.BorderSizePixel = 0
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 14
closeBtn.AutoButtonColor = false
closeBtn.ZIndex = 12
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 6)

local tabHolder = Instance.new("Frame", mainFrame)
tabHolder.Size = UDim2.new(1, 0, 0, 38)
tabHolder.Position = UDim2.new(0, 0, 0, 45)
tabHolder.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
tabHolder.BorderSizePixel = 0
tabHolder.ZIndex = 11

local Tabs = {}
local TabContents = {}
local tabNames = {"ESP", "Chams", "Aimbot", "KillAura", "Teleport", "AutoClick", "Misc"}
local currentTab = "ESP"

for i, name in ipairs(tabNames) do
    local btn = Instance.new("TextButton", tabHolder)
    btn.Size = UDim2.new(1/#tabNames, -8, 0, 30)
    btn.Position = UDim2.new((i-1)/#tabNames, 4, 0, 4)
    btn.BackgroundColor3 = name == currentTab and getTheme() or Color3.fromRGB(20, 20, 25)
    btn.BorderSizePixel = 0
    btn.Text = name == "AutoClick" and "A.Click" or name
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 7
    btn.AutoButtonColor = false
    btn.ZIndex = 12
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)
    Tabs[name] = btn
    
    local sc = Instance.new("ScrollingFrame", mainFrame)
    sc.Size = UDim2.new(1, 0, 1, -83)
    sc.Position = UDim2.new(0, 0, 0, 83)
    sc.BackgroundTransparency = 1
    sc.BorderSizePixel = 0
    sc.ScrollBarThickness = 2
    sc.ScrollBarImageColor3 = getTheme()
    sc.CanvasSize = UDim2.new(0, 0, 0, 700)
    sc.Visible = name == currentTab
    sc.ZIndex = 10
    
    local inner = Instance.new("Frame", sc)
    inner.Size = UDim2.new(1, 0, 0, 700)
    inner.BackgroundTransparency = 1
    inner.ZIndex = 10
    TabContents[name] = {scroll = sc, inner = inner}
    
    btn.MouseButton1Click:Connect(function()
        currentTab = name
        local t = getTheme()
        for n, b in pairs(Tabs) do b.BackgroundColor3 = n == name and t or Color3.fromRGB(20, 20, 25) end
        for n, c in pairs(TabContents) do c.scroll.Visible = n == name end
    end)
end

closeBtn.MouseButton1Click:Connect(function() mainFrame.Visible = false end)

local function section(parent, name, y)
    local s = Instance.new("Frame", parent)
    s.Size = UDim2.new(1, -16, 0, 28)
    s.Position = UDim2.new(0, 8, 0, y)
    s.BackgroundColor3 = Color3.fromRGB(20, 20, 26)
    s.BorderSizePixel = 0
    s.ZIndex = 11
    Instance.new("UICorner", s).CornerRadius = UDim.new(0, 4)
    local l = Instance.new("TextLabel", s)
    l.Size = UDim2.new(1, -16, 1, 0)
    l.Position = UDim2.new(0, 14, 0, 0)
    l.BackgroundTransparency = 1
    l.Text = name
    l.TextColor3 = Color3.fromRGB(255, 255, 255)
    l.Font = Enum.Font.GothamBold
    l.TextSize = 11
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.ZIndex = 12
    return y + 31
end

local function toggle(parent, text, y, def, cb)
    local f = Instance.new("Frame", parent)
    f.Size = UDim2.new(1, -16, 0, 30)
    f.Position = UDim2.new(0, 8, 0, y)
    f.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    f.BorderSizePixel = 0
    f.ZIndex = 11
    Instance.new("UICorner", f).CornerRadius = UDim.new(0, 4)
    local l = Instance.new("TextLabel", f)
    l.Size = UDim2.new(0.5, 0, 1, 0)
    l.Position = UDim2.new(0, 8, 0, 0)
    l.BackgroundTransparency = 1
    l.Text = text
    l.TextColor3 = Color3.fromRGB(210, 210, 210)
    l.Font = Enum.Font.Gotham
    l.TextSize = 10
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.ZIndex = 12
    local b = Instance.new("TextButton", f)
    b.Size = UDim2.new(0, 46, 0, 22)
    b.Position = UDim2.new(1, -52, 0.5, -11)
    b.BorderSizePixel = 0
    b.BackgroundColor3 = def and Color3.fromRGB(40, 200, 40) or Color3.fromRGB(55, 55, 60)
    b.Text = def and "ON" or "OFF"
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.Font = Enum.Font.GothamBold
    b.TextSize = 9
    b.AutoButtonColor = false
    b.ZIndex = 12
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 4)
    local state = def
    b.MouseButton1Click:Connect(function()
        state = not state
        b.Text = state and "ON" or "OFF"
        b.BackgroundColor3 = state and Color3.fromRGB(40, 200, 40) or Color3.fromRGB(55, 55, 60)
        cb(state) saveSettings()
    end)
    return y + 33
end

local function dropdown(parent, text, y, opts, defIdx, cb)
    local f = Instance.new("Frame", parent)
    f.Size = UDim2.new(1, -16, 0, 56)
    f.Position = UDim2.new(0, 8, 0, y)
    f.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    f.BorderSizePixel = 0
    f.ZIndex = 11
    Instance.new("UICorner", f).CornerRadius = UDim.new(0, 4)
    local l = Instance.new("TextLabel", f)
    l.Size = UDim2.new(1, -16, 0, 18)
    l.Position = UDim2.new(0, 8, 0, 4)
    l.BackgroundTransparency = 1
    l.Text = text
    l.TextColor3 = Color3.fromRGB(170, 170, 170)
    l.Font = Enum.Font.Gotham
    l.TextSize = 9
    l.ZIndex = 12
    local b = Instance.new("TextButton", f)
    b.Size = UDim2.new(1, -16, 0, 26)
    b.Position = UDim2.new(0, 8, 0, 26)
    b.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
    b.BorderSizePixel = 0
    b.Text = opts[defIdx]
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.Font = Enum.Font.Gotham
    b.TextSize = 10
    b.AutoButtonColor = false
    b.ZIndex = 12
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 4)
    local idx = defIdx
    b.MouseButton1Click:Connect(function() idx = idx % #opts + 1 b.Text = opts[idx] cb(opts[idx]) saveSettings() end)
    return y + 59
end

local function slider(parent, text, y, min, max, def, cb)
    local f = Instance.new("Frame", parent)
    f.Size = UDim2.new(1, -16, 0, 50)
    f.Position = UDim2.new(0, 8, 0, y)
    f.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    f.BorderSizePixel = 0
    f.ZIndex = 11
    Instance.new("UICorner", f).CornerRadius = UDim.new(0, 4)
    local l = Instance.new("TextLabel", f)
    l.Size = UDim2.new(1, -16, 0, 18)
    l.Position = UDim2.new(0, 8, 0, 4)
    l.BackgroundTransparency = 1
    l.Text = text .. ": " .. string.format("%.0f", def)
    l.TextColor3 = Color3.fromRGB(170, 170, 170)
    l.Font = Enum.Font.Gotham
    l.TextSize = 9
    l.ZIndex = 12
    local bar = Instance.new("TextButton", f)
    bar.Size = UDim2.new(1, -16, 0, 16)
    bar.Position = UDim2.new(0, 8, 0, 28)
    bar.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
    bar.BorderSizePixel = 0
    bar.Text = "" bar.AutoButtonColor = false bar.ZIndex = 12
    Instance.new("UICorner", bar).CornerRadius = UDim.new(0, 8)
    local fill = Instance.new("Frame", bar)
    fill.Size = UDim2.new((def - min) / (max - min), 0, 1, 0)
    fill.BackgroundColor3 = getTheme() fill.BorderSizePixel = 0 fill.ZIndex = 13
    Instance.new("UICorner", fill).CornerRadius = UDim.new(0, 8)
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
    return y + 53
end

-- ESP Tab
local y = 6 local inner = TabContents["ESP"].inner
y = section(inner, "ESP", y)
y = toggle(inner, "Enabled", y, Settings.ESP.Enabled, function(s) Settings.ESP.Enabled = s end)
y = toggle(inner, "Check Health", y, Settings.ESP.CheckHealth, function(s) Settings.ESP.CheckHealth = s end)
y = dropdown(inner, "Box Type", y, {"Corner", "Full", "Corner+Full"}, 1, function(o) Settings.ESP.BoxType = o end)
y = dropdown(inner, "Color", y, {"White", "Red", "Green", "Blue", "Purple", "Yellow", "Cyan", "Rainbow"}, 1, function(o) Settings.ESP.Color = o end)
y = slider(inner, "Thickness", y, 1, 5, Settings.ESP.Thickness, function(v) Settings.ESP.Thickness = v end)
y = slider(inner, "Transparency", y, 0, 1, Settings.ESP.Transparency, function(v) Settings.ESP.Transparency = v end)
y = toggle(inner, "Name", y, Settings.ESP.Name, function(s) Settings.ESP.Name = s end)
y = toggle(inner, "Distance", y, Settings.ESP.Distance, function(s) Settings.ESP.Distance = s end)
y = toggle(inner, "HP Bar", y, Settings.ESP.HealthBar, function(s) Settings.ESP.HealthBar = s end)
TabContents["ESP"].scroll.CanvasSize = UDim2.new(0, 0, 0, y + 20)

-- Chams Tab
y = 6 inner = TabContents["Chams"].inner
y = section(inner, "CHAMS", y)
y = toggle(inner, "Enabled", y, Settings.Chams.Enabled, function(s) Settings.Chams.Enabled = s
    for _, p in pairs(Players:GetPlayers()) do if p ~= LocalPlayer and p.Character then local hl = p.Character:FindFirstChild("CH") if hl then hl.Enabled = s elseif s then applyChams(p) end end end
end)
y = dropdown(inner, "Color", y, {"Red", "Green", "Blue", "Purple", "Yellow", "Orange", "Pink", "Cyan"}, 1, function(o) Settings.Chams.Color = o end)
y = slider(inner, "Fill Trans", y, 0, 1, Settings.Chams.FillTrans, function(v) Settings.Chams.FillTrans = v end)
y = slider(inner, "Outline Trans", y, 0, 1, Settings.Chams.OutlineTrans, function(v) Settings.Chams.OutlineTrans = v end)
TabContents["Chams"].scroll.CanvasSize = UDim2.new(0, 0, 0, y + 20)

-- Aimbot Tab
y = 6 inner = TabContents["Aimbot"].inner
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

-- KillAura Tab
y = 6 inner = TabContents["KillAura"].inner
y = section(inner, "KILL AURA", y)
y = toggle(inner, "Enabled", y, Settings.KillAura.Enabled, function(s) Settings.KillAura.Enabled = s end)
y = slider(inner, "Range", y, 10, 200, Settings.KillAura.Range, function(v) Settings.KillAura.Range = v end)
y = toggle(inner, "Teleport", y, Settings.KillAura.Teleport, function(s) Settings.KillAura.Teleport = s end)
y = slider(inner, "Height", y, 5, 50, Settings.KillAura.TeleportHeight, function(v) Settings.KillAura.TeleportHeight = v end)
y = toggle(inner, "Spin Around", y, Settings.KillAura.Spin, function(s) Settings.KillAura.Spin = s end)
y = slider(inner, "Spin Speed", y, 1, 20, Settings.KillAura.SpinSpeed, function(v) Settings.KillAura.SpinSpeed = v end)
y = slider(inner, "Spin Dist", y, 2, 15, Settings.KillAura.SpinDistance, function(v) Settings.KillAura.SpinDistance = v end)
TabContents["KillAura"].scroll.CanvasSize = UDim2.new(0, 0, 0, y + 20)

-- Teleport Tab
y = 6 inner = TabContents["Teleport"].inner
y = section(inner, "TELEPORT", y)
y = toggle(inner, "Click TP", y, Settings.Teleport.ClickTP, function(s) Settings.Teleport.ClickTP = s end)
y = toggle(inner, "Teleport Item", y, Settings.Teleport.TeleportItem, function(s) Settings.Teleport.TeleportItem = s end)
TabContents["Teleport"].scroll.CanvasSize = UDim2.new(0, 0, 0, y + 20)

-- AutoClick Tab
y = 6 inner = TabContents["AutoClick"].inner
y = section(inner, "AUTO CLICKER", y)
y = toggle(inner, "Enabled", y, Settings.AutoClicker.Enabled, function(s) Settings.AutoClicker.Enabled = s if s then startClicker() else stopClicker() end end)
y = slider(inner, "CPS", y, 1, 30, Settings.AutoClicker.CPS, function(v) Settings.AutoClicker.CPS = v end)
y = dropdown(inner, "Button", y, {"Left", "Right"}, 1, function(o) Settings.AutoClicker.MouseButton = o end)
TabContents["AutoClick"].scroll.CanvasSize = UDim2.new(0, 0, 0, y + 20)

-- Misc Tab
y = 6 inner = TabContents["Misc"].inner
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

y = section(inner, "VISUAL", y + 3)
y = toggle(inner, "Fullbright", y, Settings.Misc.Fullbright, function(s) if s then Lighting.Brightness = 3 else Lighting.Brightness = 1 end end)
y = toggle(inner, "No Recoil", y, Settings.Misc.NoRecoil, function(s) Settings.Misc.NoRecoil = s end)
y = toggle(inner, "No Spread", y, Settings.Misc.NoSpread, function(s) Settings.Misc.NoSpread = s end)
y = toggle(inner, "FOV Changer", y, Settings.Misc.FOVChanger, function(s) Settings.Misc.FOVChanger = s if s then Camera.FieldOfView = Settings.Misc.FOVVal else Camera.FieldOfView = 70 end end)
y = slider(inner, "FOV Val", y, 30, 120, Settings.Misc.FOVVal, function(v) Settings.Misc.FOVVal = v if Settings.Misc.FOVChanger then Camera.FieldOfView = v end end)
y = toggle(inner, "Crosshair", y, Settings.Misc.Crosshair, function(s) Settings.Misc.Crosshair = s end)
y = slider(inner, "CH Size", y, 5, 40, Settings.Misc.CrosshairSize, function(v) Settings.Misc.CrosshairSize = v end)

y = section(inner, "UI", y + 3)
y = dropdown(inner, "Theme", y, {"Red", "Dark", "Blue", "Green", "Purple", "Cyan", "Orange", "Pink", "White", "Yellow2", "Lime"}, 1, function(o)
    Settings.UI.Theme = o
    local t = getTheme()
    titleGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0, t), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 120, 120))}
    for n, b in pairs(Tabs) do b.BackgroundColor3 = n == currentTab and t or Color3.fromRGB(20, 20, 25) end
end)
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
    if ESPCache[player] and ESPCache[player].conn then ESPCache[player].conn:Disconnect() end
    if not ESPCache[player] then ESPCache[player] = {} end
    
    local lines = {} for i = 1, 8 do local l = Drawing.new("Line") l.Visible = false lines[i] = l end
    local nt = Drawing.new("Text") nt.Visible = false nt.Center = true nt.Size = 14 nt.Font = 3 nt.Outline = true
    local dt = Drawing.new("Text") dt.Visible = false dt.Center = true dt.Size = 12 dt.Font = 3 dt.Outline = true
    local hbg = Drawing.new("Square") hbg.Visible = false hbg.Filled = true hbg.Color = Color3.fromRGB(15,15,15) hbg.Transparency = 0.4
    local hf = Drawing.new("Square") hf.Visible = false hf.Filled = true
    ESPCache[player].lines = lines ESPCache[player].nt = nt ESPCache[player].dt = dt ESPCache[player].hbg = hbg ESPCache[player].hf = hf
    
    ESPCache[player].conn = RunService.RenderStepped:Connect(function()
        local c = player.Character
        if not c then for _, l in pairs(lines) do l.Visible = false end nt.Visible = false dt.Visible = false hbg.Visible = false hf.Visible = false return end
        
        if Settings.ESP.CheckHealth and not isAlive(player) then
            for _, l in pairs(lines) do l.Visible = false end nt.Visible = false dt.Visible = false hbg.Visible = false hf.Visible = false return
        end
        
        local h = c:FindFirstChild("Head") local r = c:FindFirstChild("HumanoidRootPart") local hm = c:FindFirstChildOfClass("Humanoid")
        if not h or not r or not hm or hm.Health <= 0 then for _, l in pairs(lines) do l.Visible = false end return end
        if not Settings.ESP.Enabled then for _, l in pairs(lines) do l.Visible = false end nt.Visible = false dt.Visible = false hbg.Visible = false hf.Visible = false return end
        
        local hp = h.Position + Vector3.new(0, 0.5, 0) local rp = r.Position - Vector3.new(0, 2, 0)
        local cp = r.Position + Vector3.new(0, math.abs(h.Position.Y - r.Position.Y), 0)
        local ts = Camera:WorldToViewportPoint(hp) local bs = Camera:WorldToViewportPoint(rp)
        if ts.Z <= 0 then return end
        
        local dist = (Camera.CFrame.Position - cp).Magnitude
        local bw = math.clamp((2.5 / dist) * 500, 20, 200)
        local cs = Camera:WorldToViewportPoint(cp)
        local lx, rx = cs.X - bw/2, cs.X + bw/2
        local ty, by = ts.Y, bs.Y
        local color = Settings.ESP.Color == "Rainbow" and Color3.fromHSV(tick()%5/5, 1, 1) or (Colors[Settings.ESP.Color] or Colors.White)
        
        for i = 1, 8 do lines[i].Visible = false end
        
        if Settings.ESP.BoxType == "Full" or Settings.ESP.BoxType == "Corner+Full" then
            for i = 1, 4 do lines[i].Visible = true lines[i].Color = color lines[i].Thickness = Settings.ESP.Thickness lines[i].Transparency = Settings.ESP.Transparency end
            lines[1].From = Vector2.new(lx, ty) lines[1].To = Vector2.new(rx, ty)
            lines[2].From = Vector2.new(rx, ty) lines[2].To = Vector2.new(rx, by)
            lines[3].From = Vector2.new(rx, by) lines[3].To = Vector2.new(lx, by)
            lines[4].From = Vector2.new(lx, by) lines[4].To = Vector2.new(lx, ty)
        end
        
        if Settings.ESP.BoxType == "Corner" or Settings.ESP.BoxType == "Corner+Full" then
            local cs2 = math.min(bw * 0.3, 30)
            for i = 5, 8 do lines[i].Visible = true lines[i].Color = color lines[i].Thickness = Settings.ESP.Thickness + 1 lines[i].Transparency = Settings.ESP.Transparency end
            lines[5].From = Vector2.new(lx, ty) lines[5].To = Vector2.new(lx+cs2, ty)
            lines[6].From = Vector2.new(rx, ty) lines[6].To = Vector2.new(rx-cs2, ty)
            lines[7].From = Vector2.new(rx, by) lines[7].To = Vector2.new(rx-cs2, by)
            lines[8].From = Vector2.new(lx, by) lines[8].To = Vector2.new(lx+cs2, by)
        end
        
        if Settings.ESP.Name then nt.Visible = true nt.Text = player.Name nt.Position = Vector2.new(cs.X, ty - 20) nt.Color = Color3.fromRGB(255,255,255) else nt.Visible = false end
        if Settings.ESP.Distance then dt.Visible = true dt.Text = math.floor(dist).."m" dt.Position = Vector2.new(cs.X, by + 5) dt.Color = Color3.fromRGB(255,255,255) else dt.Visible = false end
        if Settings.ESP.HealthBar then
            local health = hm.Health / hm.MaxHealth local bh = by - ty local bx = lx - 7
            hbg.Visible = true hbg.Size = Vector2.new(3, bh) hbg.Position = Vector2.new(bx, ty)
            hf.Visible = true hf.Size = Vector2.new(3, bh*health) hf.Position = Vector2.new(bx, ty + bh*(1-health)) hf.Color = Color3.fromHSV(health*0.33, 1, 1)
        else hbg.Visible = false hf.Visible = false end
    end)
end

local lockedTarget = nil

local function getTarget()
    if Settings.Aimbot.TargetLock and lockedTarget then
        local char = lockedTarget.Character
        if char and isAlive(lockedTarget) then
            local tp = char:FindFirstChild(Settings.Aimbot.TargetPart)
            if tp and char:FindFirstChildOfClass("Humanoid").Health > 0 then return tp, 0 end
        end
        lockedTarget = nil
    end
    
    local best, bestDist = nil, Settings.Aimbot.FOV
    for _, p in pairs(Players:GetPlayers()) do
        if p == LocalPlayer or not isAlive(p) then continue end
        local tp = p.Character:FindFirstChild(Settings.Aimbot.TargetPart)
        if not tp then continue end
        local sp = Camera:WorldToViewportPoint(tp.Position)
        if not Settings.Aimbot.UnlockFOV and sp.Z <= 0 then continue end
        local d = (Vector2.new(sp.X, sp.Y) - Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)).Magnitude
        if d < bestDist then bestDist = d best = tp lockedTarget = p end
    end
    return best, bestDist
end

local spinAngle = 0

local function killAura()
    if not Settings.KillAura.Enabled then return end
    local c = LocalPlayer.Character if not c then return end
    local r = c:FindFirstChild("HumanoidRootPart") local h = c:FindFirstChildOfClass("Humanoid")
    if not r or not h or h.Health <= 0 then return end
    
    local bestP, bestD = nil, Settings.KillAura.Range
    for _, p in pairs(Players:GetPlayers()) do
        if p == LocalPlayer or not isAlive(p) then continue end
        local tr = p.Character and p.Character:FindFirstChild("HumanoidRootPart")
        if tr then
            local d = (r.Position - tr.Position).Magnitude
            if d < bestD then bestD = d bestP = p end
        end
    end
    
    if bestP and bestP.Character then
        local tp = bestP.Character:FindFirstChild("Head") or bestP.Character:FindFirstChild("HumanoidRootPart")
        if tp then
            if Settings.KillAura.Spin then
                spinAngle = (spinAngle + Settings.KillAura.SpinSpeed) % 360
                local rad = math.rad(spinAngle)
                local offset = Vector3.new(math.cos(rad) * Settings.KillAura.SpinDistance, 0, math.sin(rad) * Settings.KillAura.SpinDistance)
                r.CFrame = CFrame.new(tp.Position + offset + Vector3.new(0, Settings.KillAura.TeleportHeight, 0))
            elseif Settings.KillAura.Teleport then
                r.CFrame = CFrame.new(tp.Position + Vector3.new(0, Settings.KillAura.TeleportHeight, 0))
            end
            
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, tp.Position)
            clickMouse()
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

local fovCircle = Drawing.new("Circle") fovCircle.Visible = false fovCircle.Thickness = 1.5 fovCircle.NumSides = 64 fovCircle.Transparency = 0.7

RunService.RenderStepped:Connect(function()
    if Settings.Misc.InfJump then local c = LocalPlayer.Character if c then local h = c:FindFirstChildOfClass("Humanoid") if h then h.Jump = true end end end
    if Settings.Misc.AutoBunnyhop then local c = LocalPlayer.Character if c then local h = c:FindFirstChildOfClass("Humanoid") if h and h.MoveDirection.Magnitude > 0 and h.FloorMaterial ~= Enum.Material.Air then h.Jump = true end end end
    if Settings.Misc.NoRecoil then pcall(function() for _, v in pairs(LocalPlayer.Character:GetChildren()) do if v:IsA("Tool") then v.Recoil = 0 end end end) end
    if Settings.Misc.NoSpread then pcall(function() for _, v in pairs(LocalPlayer.Character:GetChildren()) do if v:IsA("Tool") then v.Spread = 0 end end end) end
    
    fovCircle.Visible = Settings.Aimbot.Enabled and not Settings.Aimbot.UnlockFOV
    if fovCircle.Visible then
        fovCircle.Radius = Settings.Aimbot.FOV
        fovCircle.Position = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
        fovCircle.Color = Colors[Settings.Aimbot.FOVColor] or Colors.Red
    end
    
    killAura()
    
    if Settings.Aimbot.Enabled then
        local bt, bd = getTarget()
        if bt then
            if Settings.Aimbot.SilentAim then
                Camera.CFrame = CFrame.new(Camera.CFrame.Position, bt.Position)
            else
                Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, bt.Position), 1/math.max(Settings.Aimbot.Smoothness, 1))
            end
            if Settings.Aimbot.TriggerBot and bd < 50 then clickMouse() end
        end
    end
end)

-- Teleport Item функция
local teleportTool = nil

local function giveTeleportItem()
    if not LocalPlayer.Character then return end
    if teleportTool and teleportTool.Parent then teleportTool:Destroy() end
    
    local tool = Instance.new("Tool")
    tool.Name = "TeleportItem"
    tool.RequiresHandle = false
    tool.CanBeDropped = false
    tool.Parent = LocalPlayer.Backpack
    teleportTool = tool
    
    tool.Activated:Connect(function()
        if not Settings.Teleport.TeleportItem then return end
        local char = LocalPlayer.Character
        if not char or not char:FindFirstChild("HumanoidRootPart") then return end
        
        local mousePos = Mouse.Hit.Position
        char.HumanoidRootPart.CFrame = CFrame.new(mousePos + Vector3.new(0, 3, 0))
    end)
end

Mouse.Button1Down:Connect(function()
    if Settings.Teleport.ClickTP then
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            char.HumanoidRootPart.CFrame = CFrame.new(Mouse.Hit.Position + Vector3.new(0, 3, 0))
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
Players.PlayerRemoving:Connect(function(p) if lockedTarget == p then lockedTarget = nil end if ESPCache[p] then if ESPCache[p].conn then ESPCache[p].conn:Disconnect() end ESPCache[p] = nil end if PlayerCache[p] then PlayerCache[p] = nil end end)

-- Включаем/выключаем Teleport Item
local oldTeleportItemToggle = nil
UserInputService.InputBegan:Connect(function(input, gp)
    if not gp and input.KeyCode == Enum.KeyCode.V then
        mainFrame.Visible = not mainFrame.Visible
    end
    if Settings.Misc.ZoomHack and input.UserInputType == Enum.UserInputType.MouseButton2 then
        Camera.FieldOfView = 20
        input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then Camera.FieldOfView = Settings.Misc.FOVChanger and Settings.Misc.FOVVal or 70 end end)
    end
end)

-- Отслеживаем включение Teleport Item
task.spawn(function()
    while true do
        if Settings.Teleport.TeleportItem then
            if not teleportTool or not teleportTool.Parent then
                giveTeleportItem()
            end
        else
            if teleportTool and teleportTool.Parent then
                teleportTool:Destroy()
                teleportTool = nil
            end
        end
        task.wait(1)
    end
end)

LocalPlayer.CharacterAdded:Connect(function()
    task.wait(0.5)
    updSpeed() updJump() updGrav()
    if Settings.Teleport.TeleportItem then giveTeleportItem() end
end)
if LocalPlayer.Character then updSpeed() updJump() updGrav() end
