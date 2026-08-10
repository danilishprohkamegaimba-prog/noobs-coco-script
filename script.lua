local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local HttpService = game:GetService("HttpService")
local Lighting = game:GetService("Lighting")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local Settings = {
    ESP = {Enabled = false, ColorPreset = "White", Thickness = 2, Transparency = 0.8, BoxType = "Corner", Name = true, Distance = true, HealthBar = true, Skeleton = false},
    Chams = {Enabled = false, ColorPreset = "Red", FillTransparency = 0.5, OutlineTransparency = 0.3},
    Aimbot = {Enabled = false, FOV = 200, Smoothness = 3, TargetPart = "Head", UnlockFOV = false, AutoShoot = false, SilentAim = false, FOVColor = Color3.fromRGB(255, 60, 60)},
    KillAura = {Enabled = false, Range = 50, TargetPart = "Head", Teleport = true, TeleportHeight = 15, AutoAttack = true},
    Misc = {Speed = false, SpeedVal = 50, JumpPower = false, JumpVal = 100, Gravity = false, GravVal = 50, Fly = false, FlySpeed = 50, NoClip = false, InfJump = false, FPBoost = false, NoFog = false, NoShadows = false, LowGraphics = false, Crosshair = false, CrosshairSize = 20, CrosshairThick = 2, CrosshairGap = 10, ZoomHack = false, FOVChanger = false, FOVVal = 90, ThirdPerson = false, TPdist = 10, Fullbright = false, NoRecoil = false, NoSpread = false},
    UI = {Color = "Red"}
}

local ESPData = {}
local ColorPresets = {
    White = Color3.fromRGB(255, 255, 255), Gray = Color3.fromRGB(160, 160, 160), Red = Color3.fromRGB(255, 50, 50),
    Green = Color3.fromRGB(50, 255, 50), Blue = Color3.fromRGB(50, 50, 255), LightBlue = Color3.fromRGB(100, 180, 255),
    Purple = Color3.fromRGB(200, 50, 255), Yellow = Color3.fromRGB(255, 255, 50), Orange = Color3.fromRGB(255, 150, 0),
    Pink = Color3.fromRGB(255, 100, 200), Cyan = Color3.fromRGB(0, 255, 255), Black = Color3.fromRGB(60, 60, 60)
}

local UIColorPresets = {
    Red = Color3.fromRGB(255, 60, 60), Blue = Color3.fromRGB(60, 100, 255), Cyan = Color3.fromRGB(0, 200, 200),
    Black = Color3.fromRGB(100, 100, 100), Purple = Color3.fromRGB(180, 60, 255), Green = Color3.fromRGB(60, 255, 100),
    Orange = Color3.fromRGB(255, 150, 50), Pink = Color3.fromRGB(255, 100, 200)
}

local function GetUIColor()
    return UIColorPresets[Settings.UI.Color] or UIColorPresets.Red
end

local function SaveSettings()
    pcall(function() writefile("NOOBS_COCO_Settings.json", HttpService:JSONEncode(Settings)) end)
end

local function LoadSettings()
    pcall(function()
        if isfile("NOOBS_COCO_Settings.json") then
            local data = HttpService:JSONDecode(readfile("NOOBS_COCO_Settings.json"))
            for k, v in pairs(data) do
                if Settings[k] then for k2, v2 in pairs(v) do if Settings[k][k2] ~= nil then Settings[k][k2] = v2 end end end
            end
        end
    end)
end
LoadSettings()

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "NOOBS_COCO_GUI"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 440, 0, 610)
MainFrame.Position = UDim2.new(0.5, -220, 0.15, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Visible = true
MainFrame.ZIndex = 10
MainFrame.Parent = ScreenGui

local OuterGlow = Instance.new("Frame")
OuterGlow.Size = UDim2.new(1, 10, 1, 10)
OuterGlow.Position = UDim2.new(0, -5, 0, -5)
OuterGlow.BackgroundTransparency = 0.8
OuterGlow.BorderSizePixel = 0
OuterGlow.ZIndex = 9
OuterGlow.Parent = MainFrame
Instance.new("UICorner", OuterGlow).CornerRadius = UDim.new(0, 10)
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)

local uiColor = GetUIColor()
OuterGlow.BackgroundColor3 = uiColor

local TabBar = Instance.new("Frame")
TabBar.Size = UDim2.new(1, 0, 0, 55)
TabBar.BackgroundColor3 = Color3.fromRGB(12, 12, 16)
TabBar.BorderSizePixel = 0
TabBar.ZIndex = 11
TabBar.Parent = MainFrame
Instance.new("UICorner", TabBar).CornerRadius = UDim.new(0, 8)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0, 210, 0, 30)
Title.Position = UDim2.new(0, 15, 0, 6)
Title.BackgroundTransparency = 1
Title.Text = "NOOBS COCO😈"
Title.TextColor3 = uiColor
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 22
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.ZIndex = 12
Title.Parent = TabBar

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 60, 0, 24)
CloseBtn.Position = UDim2.new(1, -70, 0.5, -12)
CloseBtn.BackgroundColor3 = uiColor
CloseBtn.BorderSizePixel = 0
CloseBtn.Text = "[V]"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 11
CloseBtn.AutoButtonColor = false
CloseBtn.ZIndex = 12
CloseBtn.Parent = TabBar
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 4)

local Tabs = {}
local TabContents = {}
local tabNames = {"ESP", "Chams", "Aimbot", "KillAura", "Misc"}
local currentTab = "ESP"

local TabHolder = Instance.new("Frame")
TabHolder.Size = UDim2.new(1, 0, 0, 40)
TabHolder.Position = UDim2.new(0, 0, 0, 55)
TabHolder.BackgroundColor3 = Color3.fromRGB(22, 22, 26)
TabHolder.BorderSizePixel = 0
TabHolder.ZIndex = 11
TabHolder.Parent = MainFrame

for i, name in ipairs(tabNames) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1/#tabNames, -12, 0, 34)
    btn.Position = UDim2.new((i-1)/#tabNames, 6, 0, 3)
    btn.BackgroundColor3 = name == currentTab and uiColor or Color3.fromRGB(35, 35, 40)
    btn.BorderSizePixel = 0
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 10
    btn.AutoButtonColor = false
    btn.ZIndex = 12
    btn.Parent = TabHolder
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)
    Tabs[name] = btn
    
    local content = Instance.new("ScrollingFrame")
    content.Size = UDim2.new(1, 0, 1, -95)
    content.Position = UDim2.new(0, 0, 0, 95)
    content.BackgroundTransparency = 1
    content.BorderSizePixel = 0
    content.ScrollBarThickness = 3
    content.ScrollBarImageColor3 = uiColor
    content.CanvasSize = UDim2.new(0, 0, 0, 2000)
    content.ZIndex = 10
    content.Visible = name == currentTab
    content.Parent = MainFrame
    local inner = Instance.new("Frame")
    inner.Size = UDim2.new(1, 0, 0, 2000)
    inner.BackgroundTransparency = 1
    inner.ZIndex = 10
    inner.Parent = content
    TabContents[name] = {scroll = content, inner = inner}
    
    btn.MouseButton1Click:Connect(function()
        currentTab = name
        for n, b in pairs(Tabs) do
            b.BackgroundColor3 = n == name and GetUIColor() or Color3.fromRGB(35, 35, 40)
        end
        for n, c in pairs(TabContents) do
            c.scroll.Visible = n == name
        end
    end)
end

CloseBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

local function CreateSection(parent, name, yPos)
    local s = Instance.new("Frame")
    s.Size = UDim2.new(1, -20, 0, 34)
    s.Position = UDim2.new(0, 10, 0, yPos)
    s.BackgroundColor3 = Color3.fromRGB(28, 28, 33)
    s.BorderSizePixel = 0
    s.ZIndex = 11
    Instance.new("UICorner", s).CornerRadius = UDim.new(0, 5)
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1, 0, 1, 0)
    l.BackgroundTransparency = 1
    l.Text = "  " .. name
    l.TextColor3 = GetUIColor()
    l.Font = Enum.Font.GothamBold
    l.TextSize = 13
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.ZIndex = 12
    l.Parent = s
    s.Parent = parent
    return yPos + 38
end

local function CreateToggle(parent, text, yPos, defaultState, callback)
    local f = Instance.new("Frame")
    f.Size = UDim2.new(1, -20, 0, 34)
    f.Position = UDim2.new(0, 10, 0, yPos)
    f.BackgroundColor3 = Color3.fromRGB(33, 33, 38)
    f.BorderSizePixel = 0
    f.ZIndex = 11
    Instance.new("UICorner", f).CornerRadius = UDim.new(0, 5)
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(0.5, 0, 1, 0)
    l.BackgroundTransparency = 1
    l.Text = "  " .. text
    l.TextColor3 = Color3.fromRGB(200, 200, 200)
    l.Font = Enum.Font.Gotham
    l.TextSize = 12
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.ZIndex = 12
    l.Parent = f
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(0, 65, 0, 26)
    b.Position = UDim2.new(1, -75, 0.5, -13)
    b.BorderSizePixel = 0
    b.BackgroundColor3 = defaultState and Color3.fromRGB(40, 200, 40) or Color3.fromRGB(70, 70, 75)
    b.Text = defaultState and "ON" or "OFF"
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.Font = Enum.Font.GothamBold
    b.TextSize = 11
    b.AutoButtonColor = false
    b.ZIndex = 12
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 4)
    b.Parent = f
    f.Parent = parent
    local state = defaultState
    b.MouseButton1Click:Connect(function()
        state = not state
        b.Text = state and "ON" or "OFF"
        b.BackgroundColor3 = state and Color3.fromRGB(40, 200, 40) or Color3.fromRGB(70, 70, 75)
        callback(state)
        SaveSettings()
    end)
    return yPos + 37
end

local function CreateDropdown(parent, text, options, yPos, defaultIndex, callback)
    local f = Instance.new("Frame")
    f.Size = UDim2.new(1, -20, 0, 68)
    f.Position = UDim2.new(0, 10, 0, yPos)
    f.BackgroundColor3 = Color3.fromRGB(33, 33, 38)
    f.BorderSizePixel = 0
    f.ZIndex = 11
    Instance.new("UICorner", f).CornerRadius = UDim.new(0, 5)
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1, -20, 0, 22)
    l.Position = UDim2.new(0, 10, 0, 5)
    l.BackgroundTransparency = 1
    l.Text = text
    l.TextColor3 = Color3.fromRGB(170, 170, 170)
    l.Font = Enum.Font.Gotham
    l.TextSize = 11
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.ZIndex = 12
    l.Parent = f
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, -20, 0, 30)
    b.Position = UDim2.new(0, 10, 0, 30)
    b.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
    b.BorderSizePixel = 0
    b.Text = options[defaultIndex]
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.Font = Enum.Font.Gotham
    b.TextSize = 12
    b.AutoButtonColor = false
    b.ZIndex = 12
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 4)
    b.Parent = f
    f.Parent = parent
    local index = defaultIndex
    b.MouseButton1Click:Connect(function()
        index = index % #options + 1
        b.Text = options[index]
        callback(options[index], index)
        SaveSettings()
    end)
    return yPos + 71
end

local function CreateSlider(parent, text, min, max, default, yPos, callback)
    local f = Instance.new("Frame")
    f.Size = UDim2.new(1, -20, 0, 60)
    f.Position = UDim2.new(0, 10, 0, yPos)
    f.BackgroundColor3 = Color3.fromRGB(33, 33, 38)
    f.BorderSizePixel = 0
    f.ZIndex = 11
    Instance.new("UICorner", f).CornerRadius = UDim.new(0, 5)
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1, -20, 0, 22)
    l.Position = UDim2.new(0, 10, 0, 5)
    l.BackgroundTransparency = 1
    l.Text = text .. ": " .. string.format("%.1f", default)
    l.TextColor3 = Color3.fromRGB(170, 170, 170)
    l.Font = Enum.Font.Gotham
    l.TextSize = 11
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.ZIndex = 12
    l.Parent = f
    local bar = Instance.new("TextButton")
    bar.Size = UDim2.new(1, -20, 0, 20)
    bar.Position = UDim2.new(0, 10, 0, 32)
    bar.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
    bar.BorderSizePixel = 0
    bar.Text = ""
    bar.AutoButtonColor = false
    bar.ZIndex = 12
    Instance.new("UICorner", bar).CornerRadius = UDim.new(0, 10)
    local fill = Instance.new("Frame")
    local range = max - min
    fill.Size = UDim2.new((default - min) / range, 0, 1, 0)
    fill.BackgroundColor3 = GetUIColor()
    fill.BorderSizePixel = 0
    fill.ZIndex = 13
    Instance.new("UICorner", fill).CornerRadius = UDim.new(0, 10)
    fill.Parent = bar
    bar.Parent = f
    f.Parent = parent
    local value = default
    local isDragging = false
    local function update()
        local mp = UserInputService:GetMouseLocation()
        local bp = bar.AbsolutePosition
        local bs = bar.AbsoluteSize
        local rx = math.clamp((mp.X - bp.X) / bs.X, 0, 1)
        value = min + range * rx
        fill.Size = UDim2.new(rx, 0, 1, 0)
        l.Text = text .. ": " .. string.format("%.1f", value)
        callback(value)
    end
    bar.MouseButton1Down:Connect(function()
        isDragging = true
        update()
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement and isDragging then
            update()
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            isDragging = false
            SaveSettings()
        end
    end)
    return yPos + 63
end

-- Построение UI
local y = 8
local inner = TabContents["ESP"].inner
y = CreateSection(inner, "ESP", y)
CreateToggle(inner, "Enabled", y, Settings.ESP.Enabled, function(s) Settings.ESP.Enabled = s end)
y = y + 37
CreateDropdown(inner, "Box Type", {"Corner", "Full", "Corner+Full"}, y, 1, function(o) Settings.ESP.BoxType = o end)
y = y + 71
CreateDropdown(inner, "Color", {"White", "Gray", "LightBlue", "Purple", "Yellow", "Orange", "Pink", "Cyan", "Rainbow"}, y, 1, function(o) Settings.ESP.ColorPreset = o end)
y = y + 71
y = CreateSlider(inner, "Thickness", 1, 6, Settings.ESP.Thickness, y, function(v) Settings.ESP.Thickness = v end)
y = CreateSlider(inner, "Transparency", 0, 1, Settings.ESP.Transparency, y, function(v) Settings.ESP.Transparency = v end)
CreateToggle(inner, "Show Name", y, Settings.ESP.Name, function(s) Settings.ESP.Name = s end)
y = y + 37
CreateToggle(inner, "Show Distance", y, Settings.ESP.Distance, function(s) Settings.ESP.Distance = s end)
y = y + 37
CreateToggle(inner, "Health Bar", y, Settings.ESP.HealthBar, function(s) Settings.ESP.HealthBar = s end)
y = y + 37
CreateToggle(inner, "Skeleton", y, Settings.ESP.Skeleton, function(s) Settings.ESP.Skeleton = s end)
y = y + 37
TabContents["ESP"].scroll.CanvasSize = UDim2.new(0, 0, 0, y + 20)

y = 8
inner = TabContents["Chams"].inner
y = CreateSection(inner, "CHAMS", y)
CreateToggle(inner, "Enabled", y, Settings.Chams.Enabled, function(s)
    Settings.Chams.Enabled = s
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local hl = p.Character:FindFirstChild("ESP_Chams")
            if hl then hl.Enabled = s elseif s then ApplyChams(p) end
        end
    end
end)
y = y + 37
CreateDropdown(inner, "Color", {"Red", "Green", "Blue", "Purple", "Yellow", "Orange", "Pink", "Cyan", "Rainbow"}, y, 1, function(o) Settings.Chams.ColorPreset = o end)
y = y + 71
y = CreateSlider(inner, "Fill Transparency", 0, 1, Settings.Chams.FillTransparency, y, function(v) Settings.Chams.FillTransparency = v end)
y = CreateSlider(inner, "Outline Transparency", 0, 1, Settings.Chams.OutlineTransparency, y, function(v) Settings.Chams.OutlineTransparency = v end)
TabContents["Chams"].scroll.CanvasSize = UDim2.new(0, 0, 0, y + 20)

y = 8
inner = TabContents["Aimbot"].inner
y = CreateSection(inner, "AIMBOT", y)
CreateToggle(inner, "Enabled", y, Settings.Aimbot.Enabled, function(s) Settings.Aimbot.Enabled = s end)
y = y + 37
CreateDropdown(inner, "Target", {"Head", "HumanoidRootPart", "UpperTorso"}, y, 1, function(o) Settings.Aimbot.TargetPart = o end)
y = y + 71
CreateToggle(inner, "Unlock FOV", y, Settings.Aimbot.UnlockFOV, function(s) Settings.Aimbot.UnlockFOV = s end)
y = y + 37
CreateToggle(inner, "Auto Shoot", y, Settings.Aimbot.AutoShoot, function(s) Settings.Aimbot.AutoShoot = s end)
y = y + 37
CreateToggle(inner, "Silent Aim", y, Settings.Aimbot.SilentAim, function(s) Settings.Aimbot.SilentAim = s end)
y = y + 37
y = CreateSlider(inner, "FOV", 50, 800, Settings.Aimbot.FOV, y, function(v) Settings.Aimbot.FOV = v end)
y = CreateSlider(inner, "Smoothness", 1, 20, Settings.Aimbot.Smoothness, y, function(v) Settings.Aimbot.Smoothness = v end)
CreateDropdown(inner, "FOV Color", {"Red", "Green", "Blue", "White", "Yellow", "Purple", "Cyan"}, y, 1, function(o) Settings.Aimbot.FOVColor = ColorPresets[o] or Color3.fromRGB(255, 60, 60) end)
y = y + 71
TabContents["Aimbot"].scroll.CanvasSize = UDim2.new(0, 0, 0, y + 20)

y = 8
inner = TabContents["KillAura"].inner
y = CreateSection(inner, "KILL AURA", y)
CreateToggle(inner, "Enabled", y, Settings.KillAura.Enabled, function(s) Settings.KillAura.Enabled = s end)
y = y + 37
CreateDropdown(inner, "Target", {"Head", "HumanoidRootPart", "UpperTorso"}, y, 1, function(o) Settings.KillAura.TargetPart = o end)
y = y + 71
y = CreateSlider(inner, "Range", 10, 200, Settings.KillAura.Range, y, function(v) Settings.KillAura.Range = v end)
CreateToggle(inner, "Teleport", y, Settings.KillAura.Teleport, function(s) Settings.KillAura.Teleport = s end)
y = y + 37
y = CreateSlider(inner, "Teleport Height", 5, 50, Settings.KillAura.TeleportHeight, y, function(v) Settings.KillAura.TeleportHeight = v end)
CreateToggle(inner, "Auto Attack", y, Settings.KillAura.AutoAttack, function(s) Settings.KillAura.AutoAttack = s end)
y = y + 37
TabContents["KillAura"].scroll.CanvasSize = UDim2.new(0, 0, 0, y + 20)

y = 8
inner = TabContents["Misc"].inner
y = CreateSection(inner, "MOVEMENT", y)
CreateToggle(inner, "Fly", y, Settings.Misc.Fly, function(s) Settings.Misc.Fly = s if s then StartFly() else StopFly() end end)
y = y + 37
y = CreateSlider(inner, "Fly Speed", 10, 200, Settings.Misc.FlySpeed, y, function(v) Settings.Misc.FlySpeed = v end)
CreateToggle(inner, "NoClip", y, Settings.Misc.NoClip, function(s) Settings.Misc.NoClip = s if s then EnableNoClip() else DisableNoClip() end end)
y = y + 37
CreateToggle(inner, "Speed Boost", y, Settings.Misc.Speed, function(s) Settings.Misc.Speed = s UpdateSpeed() end)
y = y + 37
y = CreateSlider(inner, "Speed Value", 16, 200, Settings.Misc.SpeedVal, y, function(v) Settings.Misc.SpeedVal = v UpdateSpeed() end)
CreateToggle(inner, "Jump Power", y, Settings.Misc.JumpPower, function(s) Settings.Misc.JumpPower = s UpdateJump() end)
y = y + 37
y = CreateSlider(inner, "Jump Value", 50, 300, Settings.Misc.JumpVal, y, function(v) Settings.Misc.JumpVal = v UpdateJump() end)
CreateToggle(inner, "Infinite Jump", y, Settings.Misc.InfJump, function(s) Settings.Misc.InfJump = s end)
y = y + 37
CreateToggle(inner, "Gravity", y, Settings.Misc.Gravity, function(s) Settings.Misc.Gravity = s UpdateGravity() end)
y = y + 37
y = CreateSlider(inner, "Gravity Value", 10, 196, Settings.Misc.GravVal, y, function(v) Settings.Misc.GravVal = v UpdateGravity() end)

y = CreateSection(inner, "PERFORMANCE", y + 3)
CreateToggle(inner, "FPS Boost", y, Settings.Misc.FPBoost, function(s) Settings.Misc.FPBoost = s end)
y = y + 37
CreateToggle(inner, "No Fog", y, Settings.Misc.NoFog, function(s) Settings.Misc.NoFog = s Lighting.FogEnd = s and 9999999 or 10000 end)
y = y + 37
CreateToggle(inner, "No Shadows", y, Settings.Misc.NoShadows, function(s) Settings.Misc.NoShadows = s Lighting.GlobalShadows = not s end)
y = y + 37
CreateToggle(inner, "Low Graphics", y, Settings.Misc.LowGraphics, function(s) Settings.Misc.LowGraphics = s end)
y = y + 37

y = CreateSection(inner, "VISUAL", y + 3)
CreateToggle(inner, "Crosshair", y, Settings.Misc.Crosshair, function(s) Settings.Misc.Crosshair = s end)
y = y + 37
y = CreateSlider(inner, "Crosshair Size", 5, 40, Settings.Misc.CrosshairSize, y, function(v) Settings.Misc.CrosshairSize = v end)
CreateToggle(inner, "Fullbright", y, Settings.Misc.Fullbright, function(s) Settings.Misc.Fullbright = s if s then Lighting.Brightness = 3 Lighting.ClockTime = 14 else Lighting.Brightness = 1 end end)
y = y + 37
CreateToggle(inner, "No Recoil", y, Settings.Misc.NoRecoil, function(s) Settings.Misc.NoRecoil = s end)
y = y + 37
CreateToggle(inner, "No Spread", y, Settings.Misc.NoSpread, function(s) Settings.Misc.NoSpread = s end)
y = y + 37
CreateToggle(inner, "FOV Changer", y, Settings.Misc.FOVChanger, function(s) Settings.Misc.FOVChanger = s if s then Camera.FieldOfView = Settings.Misc.FOVVal else Camera.FieldOfView = 70 end end)
y = y + 37
y = CreateSlider(inner, "FOV Value", 30, 120, Settings.Misc.FOVVal, y, function(v) Settings.Misc.FOVVal = v if Settings.Misc.FOVChanger then Camera.FieldOfView = v end end)
CreateDropdown(inner, "UI Color", {"Red", "Blue", "Cyan", "Black", "Purple", "Green", "Orange", "Pink"}, y, 1, function(o)
    Settings.UI.Color = o
    local newColor = GetUIColor()
    Title.TextColor3 = newColor
    OuterGlow.BackgroundColor3 = newColor
    CloseBtn.BackgroundColor3 = newColor
    for n, b in pairs(Tabs) do
        b.BackgroundColor3 = n == currentTab and newColor or Color3.fromRGB(35, 35, 40)
    end
    SaveSettings()
end)
y = y + 71
TabContents["Misc"].scroll.CanvasSize = UDim2.new(0, 0, 0, y + 20)

-- ESP
function CreateESP(player)
    if ESPData[player] then
        if ESPData[player].Conn then ESPData[player].Conn:Disconnect() end
        if ESPData[player].Lines then for _, l in pairs(ESPData[player].Lines) do if l.Remove then l:Remove() end end end
        if ESPData[player].Texts then for _, t in pairs(ESPData[player].Texts) do if t.Remove then t:Remove() end end end
        if ESPData[player].HB then ESPData[player].HB.bg:Remove() ESPData[player].HB.fill:Remove() end
    end
    ESPData[player] = {Lines = {}, Texts = {}}
    local lines = {} for i = 1, 12 do local l = Drawing.new("Line") l.Visible = false lines[i] = l end
    local nt = Drawing.new("Text") nt.Visible = false nt.Center = true nt.Size = 15 nt.Font = 3 nt.Outline = true nt.OutlineColor = Color3.fromRGB(0,0,0)
    local dt = Drawing.new("Text") dt.Visible = false dt.Center = true dt.Size = 13 dt.Font = 3 dt.Outline = true dt.OutlineColor = Color3.fromRGB(0,0,0)
    local hbg = Drawing.new("Square") hbg.Visible = false hbg.Filled = true hbg.Color = Color3.fromRGB(15,15,15) hbg.Transparency = 0.35
    local hf = Drawing.new("Square") hf.Visible = false hf.Filled = true
    ESPData[player].Lines = lines ESPData[player].Texts = {nt, dt} ESPData[player].HB = {bg = hbg, fill = hf}
    
    ESPData[player].Conn = RunService.RenderStepped:Connect(function()
        local c = player.Character
        if not c then for _, l in pairs(lines) do l.Visible = false end nt.Visible = false dt.Visible = false hbg.Visible = false hf.Visible = false return end
        local h = c:FindFirstChild("Head") local r = c:FindFirstChild("HumanoidRootPart") local hm = c:FindFirstChildOfClass("Humanoid")
        if not h or not r or not hm or hm.Health <= 0 then for _, l in pairs(lines) do l.Visible = false end nt.Visible = false dt.Visible = false hbg.Visible = false hf.Visible = false return end
        if not Settings.ESP.Enabled then for _, l in pairs(lines) do l.Visible = false end nt.Visible = false dt.Visible = false hbg.Visible = false hf.Visible = false return end
        
        local hp, rp = h.Position, r.Position
        local height = math.abs(hp.Y - rp.Y) * 2.2
        local cp = rp + Vector3.new(0, height/2 - 1.5, 0)
        local tp = hp + Vector3.new(0, 0.5, 0) local bp = rp - Vector3.new(0, 2, 0)
        local ts, tvis = Camera:WorldToViewportPoint(tp) local bs, bvis = Camera:WorldToViewportPoint(bp)
        if not tvis and not bvis then for _, l in pairs(lines) do l.Visible = false end nt.Visible = false dt.Visible = false hbg.Visible = false hf.Visible = false return end
        
        local dist = (Camera.CFrame.Position - cp).Magnitude local bw = (2.5 / dist) * 500 local bh = math.abs(ts.Y - bs.Y)
        local cs, cvis = Camera:WorldToViewportPoint(cp)
        if not cvis then for _, l in pairs(lines) do l.Visible = false end return end
        
        local lx = cs.X - bw/2 local rx = cs.X + bw/2
        local color = Settings.ESP.ColorPreset == "Rainbow" and Color3.fromHSV(tick()%5/5, 1, 1) or (ColorPresets[Settings.ESP.ColorPreset] or ColorPresets.White)
        local ty, by = ts.Y, bs.Y
        
        for i=1,12 do lines[i].Visible = false end
        
        if Settings.ESP.BoxType == "Full" or Settings.ESP.BoxType == "Corner+Full" then
            lines[1].From = Vector2.new(lx, ty) lines[1].To = Vector2.new(rx, ty) lines[1].Visible = true
            lines[2].From = Vector2.new(rx, ty) lines[2].To = Vector2.new(rx, by) lines[2].Visible = true
            lines[3].From = Vector2.new(rx, by) lines[3].To = Vector2.new(lx, by) lines[3].Visible = true
            lines[4].From = Vector2.new(lx, by) lines[4].To = Vector2.new(lx, ty) lines[4].Visible = true
            for i=1,4 do lines[i].Color = color lines[i].Thickness = Settings.ESP.Thickness lines[i].Transparency = Settings.ESP.Transparency end
        end
        
        if Settings.ESP.BoxType == "Corner" or Settings.ESP.BoxType == "Corner+Full" then
            local cs2 = math.min(bw * 0.3, bw * 0.4)
            lines[5].From = Vector2.new(lx, ty) lines[5].To = Vector2.new(lx+cs2, ty) lines[5].Visible = true
            lines[6].From = Vector2.new(lx, ty) lines[6].To = Vector2.new(lx, ty+cs2) lines[6].Visible = true
            lines[7].From = Vector2.new(rx, ty) lines[7].To = Vector2.new(rx-cs2, ty) lines[7].Visible = true
            lines[8].From = Vector2.new(rx, ty) lines[8].To = Vector2.new(rx, ty+cs2) lines[8].Visible = true
            lines[9].From = Vector2.new(rx, by) lines[9].To = Vector2.new(rx-cs2, by) lines[9].Visible = true
            lines[10].From = Vector2.new(rx, by) lines[10].To = Vector2.new(rx, by-cs2) lines[10].Visible = true
            lines[11].From = Vector2.new(lx, by) lines[11].To = Vector2.new(lx+cs2, by) lines[11].Visible = true
            lines[12].From = Vector2.new(lx, by) lines[12].To = Vector2.new(lx, by-cs2) lines[12].Visible = true
            for i=5,12 do lines[i].Color = color lines[i].Thickness = Settings.ESP.Thickness + 1 lines[i].Transparency = Settings.ESP.Transparency end
        end
        
        nt.Visible = Settings.ESP.Name
        if Settings.ESP.Name then nt.Text = player.Name nt.Position = Vector2.new(cs.X, ty - 22) nt.Color = Color3.fromRGB(255,255,255) end
        dt.Visible = Settings.ESP.Distance
        if Settings.ESP.Distance then dt.Text = math.floor(dist) .. "m" dt.Position = Vector2.new(cs.X, by + 7) dt.Color = Color3.fromRGB(255,255,255) end
        hbg.Visible = Settings.ESP.HealthBar hf.Visible = Settings.ESP.HealthBar
        if Settings.ESP.HealthBar then
            local health = hm.Health / hm.MaxHealth local barW = 3 local barH = bh local barX = lx - barW - 4
            hbg.Size = Vector2.new(barW, barH) hbg.Position = Vector2.new(barX, ty)
            hf.Size = Vector2.new(barW, barH * health) hf.Position = Vector2.new(barX, ty + barH * (1 - health))
            hf.Color = Color3.fromHSV(health * 0.33, 1, 1)
        end
    end)
end

function ApplyChams(player)
    if not player.Character then return end
    local c = player.Character
    local old = c:FindFirstChild("ESP_Chams") if old then old:Destroy() end
    local hl = Instance.new("Highlight") hl.Name = "ESP_Chams" hl.Enabled = Settings.Chams.Enabled
    hl.FillTransparency = Settings.Chams.FillTransparency hl.OutlineTransparency = Settings.Chams.OutlineTransparency
    hl.Adornee = c hl.Parent = c
    if Settings.Chams.ColorPreset ~= "Rainbow" then
        local col = ColorPresets[Settings.Chams.ColorPreset] or ColorPresets.Red hl.FillColor = col hl.OutlineColor = col
    end
end

-- Aimbot
local function GetBestTarget()
    local bestTarget, bestDist = nil, Settings.Aimbot.FOV
    for _, p in pairs(Players:GetPlayers()) do
        if p == LocalPlayer or not p.Character then continue end
        local tp = p.Character:FindFirstChild(Settings.Aimbot.TargetPart) local hum = p.Character:FindFirstChildOfClass("Humanoid")
        if not tp or not hum or hum.Health <= 0 then continue end
        local sp, vis = Camera:WorldToViewportPoint(tp.Position)
        if not Settings.Aimbot.UnlockFOV and not vis then continue end
        local sc = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
        local d = (Vector2.new(sp.X, sp.Y) - sc).Magnitude
        if d < bestDist then
            local ro = Camera.CFrame.Position local rd = (tp.Position - ro).Unit * 1000
            local rp = RaycastParams.new() rp.FilterType = Enum.RaycastFilterType.Blacklist rp.FilterDescendantsInstances = {LocalPlayer.Character}
            local rr = workspace:Raycast(ro, rd, rp)
            if rr and rr.Instance:IsDescendantOf(p.Character) then bestDist = d bestTarget = tp end
        end
    end
    return bestTarget, bestDist
end

-- Kill Aura
local function ProcessKillAura()
    if not Settings.KillAura.Enabled then return end
    local char = LocalPlayer.Character if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart") local hum = char:FindFirstChildOfClass("Humanoid")
    if not root or not hum or hum.Health <= 0 then return end
    local bestP, bestD = nil, Settings.KillAura.Range
    for _, p in pairs(Players:GetPlayers()) do
        if p == LocalPlayer or not p.Character then continue end
        local th = p.Character:FindFirstChildOfClass("Humanoid")
        if not th or th.Health <= 0 then continue end
        local tr = p.Character:FindFirstChild("HumanoidRootPart")
        if tr and (root.Position - tr.Position).Magnitude < bestD then bestD = (root.Position - tr.Position).Magnitude bestP = p end
    end
    if bestP and bestP.Character then
        local tp = bestP.Character:FindFirstChild(Settings.KillAura.TargetPart) or bestP.Character:FindFirstChild("Head")
        if tp then
            if Settings.KillAura.Teleport then root.CFrame = CFrame.new(tp.Position + Vector3.new(0, Settings.KillAura.TeleportHeight, 0)) end
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, tp.Position)
            if Settings.KillAura.AutoAttack then task.spawn(function() mouse1click() end) end
        end
    end
end

-- Главный цикл
RunService.RenderStepped:Connect(function()
    if Settings.Misc.InfJump then local c = LocalPlayer.Character if c then local h = c:FindFirstChildOfClass("Humanoid") if h then h.Jump = true end end end
    if Settings.Misc.NoRecoil then pcall(function() for _, v in pairs(LocalPlayer.Character:GetChildren()) do if v:IsA("Tool") then v.Recoil = 0 end end end) end
    if Settings.Misc.NoSpread then pcall(function() for _, v in pairs(LocalPlayer.Character:GetChildren()) do if v:IsA("Tool") then v.Spread = 0 end end end) end
    
    ProcessKillAura()
    
    if Settings.Aimbot.Enabled then
        local bt, bd = GetBestTarget()
        if bt then
            if Settings.Aimbot.SilentAim then Camera.CFrame = CFrame.new(Camera.CFrame.Position, bt.Position)
            else Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, bt.Position), 1/math.max(Settings.Aimbot.Smoothness, 1)) end
            if Settings.Aimbot.AutoShoot and bd < 100 then task.spawn(function() mouse1click() end) end
        end
    end
end)

-- FOV Circle
local FC = Drawing.new("Circle") FC.Visible = false FC.Thickness = 1.5 FC.NumSides = 100 FC.Transparency = 0.7
RunService.RenderStepped:Connect(function()
    FC.Visible = Settings.Aimbot.Enabled and not Settings.Aimbot.UnlockFOV
    FC.Color = Settings.Aimbot.FOVColor FC.Radius = Settings.Aimbot.FOV FC.Position = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
end)

-- Fly
local FlyConn
function StartFly()
    local c = LocalPlayer.Character if not c then return end
    local r = c:FindFirstChild("HumanoidRootPart") local h = c:FindFirstChildOfClass("Humanoid")
    if not r or not h then return end h.PlatformStand = true
    FlyConn = RunService.RenderStepped:Connect(function()
        if not Settings.Misc.Fly then StopFly() return end
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
function StopFly() if FlyConn then FlyConn:Disconnect() FlyConn = nil end
    local c = LocalPlayer.Character if c then local h = c:FindFirstChildOfClass("Humanoid") if h then h.PlatformStand = false end end end
end

-- NoClip
local NCConn
function EnableNoClip()
    NCConn = RunService.Stepped:Connect(function()
        if LocalPlayer.Character then for _, p in pairs(LocalPlayer.Character:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide = false end end end
    end)
end
function DisableNoClip() if NCConn then NCConn:Disconnect() NCConn = nil end end

-- Speed/Jump/Gravity
function UpdateSpeed()
    local c = LocalPlayer.Character if not c then return end local h = c:FindFirstChildOfClass("Humanoid") if h then h.WalkSpeed = Settings.Misc.Speed and Settings.Misc.SpeedVal or 16 end
end
function UpdateJump()
    local c = LocalPlayer.Character if not c then return end local h = c:FindFirstChildOfClass("Humanoid") if h then h.UseJumpPower = true h.JumpPower = Settings.Misc.JumpPower and Settings.Misc.JumpVal or 50 end
end
function UpdateGravity() workspace.Gravity = Settings.Misc.Gravity and Settings.Misc.GravVal or 196.2 end

-- Players
local function OnPlayerAdded(player)
    if player == LocalPlayer then return end
    player.CharacterAdded:Connect(function() task.wait(0.3) CreateESP(player) ApplyChams(player) end)
    if player.Character then CreateESP(player) ApplyChams(player) end
end
for _, p in pairs(Players:GetPlayers()) do if p ~= LocalPlayer then OnPlayerAdded(p) end end
Players.PlayerAdded:Connect(OnPlayerAdded)

UserInputService.InputBegan:Connect(function(input, gp)
    if not gp and input.KeyCode == Enum.KeyCode.V then MainFrame.Visible = not MainFrame.Visible end
end)

LocalPlayer.CharacterAdded:Connect(function() task.wait(0.5) UpdateSpeed() UpdateJump() UpdateGravity() end)
if LocalPlayer.Character then UpdateSpeed() UpdateJump() UpdateGravity() end
