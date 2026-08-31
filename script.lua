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
    ESP = {Enabled = false, Color = "White", Thickness = 2, Transparency = 0.8, BoxType = "Corner", Name = true, Distance = true, HealthBar = true},
    Chams = {Enabled = false, Color = "Red", FillTrans = 0.5, OutlineTrans = 0.3},
    Aimbot = {Enabled = false, FOV = 200, Smoothness = 3, TargetPart = "Head", UnlockFOV = false, SilentAim = false, FOVColor = "Red", TriggerBot = false, TargetLock = false, VisibleCheck = true},
    KillAura = {Enabled = false, Range = 50, Teleport = true, TeleportHeight = 15, Spin = false, SpinSpeed = 5, SpinDistance = 5},
    AutoClicker = {Enabled = false, CPS = 10},
    Misc = {Fly = false, FlySpeed = 50, NoClip = false, Speed = false, SpeedVal = 50, JumpPower = false, JumpVal = 100, Fullbright = false, NoRecoil = false, NoSpread = false, FOVChanger = false, FOVVal = 90, AutoBunnyhop = false, Spinbot = false, UIOpacity = 100},
    UI = {Theme = "Red"}
}

local Colors = {
    White = Color3.fromRGB(255, 255, 255), Red = Color3.fromRGB(255, 50, 50), Green = Color3.fromRGB(50, 255, 50),
    Blue = Color3.fromRGB(50, 50, 255), LightBlue = Color3.fromRGB(100, 180, 255), Purple = Color3.fromRGB(200, 50, 255),
    Yellow = Color3.fromRGB(255, 255, 50), Orange = Color3.fromRGB(255, 150, 0), Pink = Color3.fromRGB(255, 100, 200),
    Cyan = Color3.fromRGB(0, 255, 255), Gray = Color3.fromRGB(160, 160, 160)
}

local Themes = {
    Red = {Accent = Color3.fromRGB(255, 60, 60), Bg = Color3.fromRGB(12, 12, 16), Tab = Color3.fromRGB(10, 10, 15), Elem = Color3.fromRGB(25, 25, 30), Btn = Color3.fromRGB(35, 35, 40), Text = Color3.fromRGB(210, 210, 210), Glow1 = Color3.fromRGB(255, 60, 60), Glow2 = Color3.fromRGB(255, 120, 120)},
    Dark = {Accent = Color3.fromRGB(100, 100, 100), Bg = Color3.fromRGB(15, 15, 18), Tab = Color3.fromRGB(12, 12, 15), Elem = Color3.fromRGB(25, 25, 28), Btn = Color3.fromRGB(35, 35, 38), Text = Color3.fromRGB(180, 180, 180), Glow1 = Color3.fromRGB(100, 100, 100), Glow2 = Color3.fromRGB(150, 150, 150)},
    Blue = {Accent = Color3.fromRGB(60, 100, 255), Bg = Color3.fromRGB(12, 14, 22), Tab = Color3.fromRGB(10, 12, 18), Elem = Color3.fromRGB(22, 25, 38), Btn = Color3.fromRGB(32, 35, 48), Text = Color3.fromRGB(200, 210, 255), Glow1 = Color3.fromRGB(60, 100, 255), Glow2 = Color3.fromRGB(120, 150, 255)},
    Green = {Accent = Color3.fromRGB(60, 255, 100), Bg = Color3.fromRGB(10, 18, 12), Tab = Color3.fromRGB(8, 15, 10), Elem = Color3.fromRGB(20, 30, 22), Btn = Color3.fromRGB(30, 40, 32), Text = Color3.fromRGB(200, 255, 210), Glow1 = Color3.fromRGB(60, 255, 100), Glow2 = Color3.fromRGB(120, 255, 150)},
    Purple = {Accent = Color3.fromRGB(180, 60, 255), Bg = Color3.fromRGB(16, 10, 24), Tab = Color3.fromRGB(14, 8, 20), Elem = Color3.fromRGB(28, 20, 38), Btn = Color3.fromRGB(38, 30, 48), Text = Color3.fromRGB(220, 200, 255), Glow1 = Color3.fromRGB(180, 60, 255), Glow2 = Color3.fromRGB(220, 120, 255)},
    Cyan = {Accent = Color3.fromRGB(0, 200, 200), Bg = Color3.fromRGB(10, 18, 20), Tab = Color3.fromRGB(8, 15, 17), Elem = Color3.fromRGB(20, 30, 32), Btn = Color3.fromRGB(30, 40, 42), Text = Color3.fromRGB(200, 255, 255), Glow1 = Color3.fromRGB(0, 200, 200), Glow2 = Color3.fromRGB(100, 255, 255)},
    Orange = {Accent = Color3.fromRGB(255, 150, 50), Bg = Color3.fromRGB(22, 15, 8), Tab = Color3.fromRGB(18, 12, 6), Elem = Color3.fromRGB(35, 25, 15), Btn = Color3.fromRGB(45, 35, 25), Text = Color3.fromRGB(255, 230, 200), Glow1 = Color3.fromRGB(255, 150, 50), Glow2 = Color3.fromRGB(255, 200, 100)},
    Pink = {Accent = Color3.fromRGB(255, 100, 200), Bg = Color3.fromRGB(22, 10, 16), Tab = Color3.fromRGB(18, 8, 14), Elem = Color3.fromRGB(32, 20, 26), Btn = Color3.fromRGB(42, 30, 36), Text = Color3.fromRGB(255, 200, 230), Glow1 = Color3.fromRGB(255, 100, 200), Glow2 = Color3.fromRGB(255, 150, 220)},
    White = {Accent = Color3.fromRGB(255, 255, 255), Bg = Color3.fromRGB(18, 18, 20), Tab = Color3.fromRGB(15, 15, 17), Elem = Color3.fromRGB(28, 28, 32), Btn = Color3.fromRGB(38, 38, 42), Text = Color3.fromRGB(240, 240, 240), Glow1 = Color3.fromRGB(255, 255, 255), Glow2 = Color3.fromRGB(220, 220, 220)},
    Yellow = {Accent = Color3.fromRGB(255, 255, 50), Bg = Color3.fromRGB(20, 20, 8), Tab = Color3.fromRGB(16, 16, 6), Elem = Color3.fromRGB(32, 32, 18), Btn = Color3.fromRGB(42, 42, 28), Text = Color3.fromRGB(255, 255, 200), Glow1 = Color3.fromRGB(255, 255, 50), Glow2 = Color3.fromRGB(255, 255, 150)},
    Lime = {Accent = Color3.fromRGB(150, 255, 50), Bg = Color3.fromRGB(10, 20, 8), Tab = Color3.fromRGB(8, 16, 6), Elem = Color3.fromRGB(20, 32, 18), Btn = Color3.fromRGB(30, 42, 28), Text = Color3.fromRGB(200, 255, 180), Glow1 = Color3.fromRGB(150, 255, 50), Glow2 = Color3.fromRGB(200, 255, 120)}
}

local ESPData = {}
local lockedTarget = nil
local spinAngle = 0
local uiHovered = false

local function getTheme() return Themes[Settings.UI.Theme] or Themes.Red end

local function saveSettings()
    pcall(function() writefile("NOOBS_COCO_Settings.json", HttpService:JSONEncode(Settings)) end)
end

local function loadSettings()
    pcall(function()
        if isfile("NOOBS_COCO_Settings.json") then
            local data = HttpService:JSONDecode(readfile("NOOBS_COCO_Settings.json"))
            for k, v in pairs(data) do
                if Settings[k] then
                    for k2, v2 in pairs(v) do
                        if Settings[k][k2] ~= nil then
                            Settings[k][k2] = v2
                        end
                    end
                end
            end
        end
    end)
end
loadSettings()

local function safeClick()
    if uiHovered then return end
    pcall(function()
        local mousePos = UserInputService:GetMouseLocation()
        VIM:SendMouseButtonEvent(mousePos.X, mousePos.Y, 0, true, game, 0)
        task.wait(0.01)
        VIM:SendMouseButtonEvent(mousePos.X, mousePos.Y, 0, false, game, 0)
    end)
end

local function isAlive(p)
    if not p or not p.Character then return false end
    local hum = p.Character:FindFirstChildOfClass("Humanoid")
    return hum and hum.Health > 0 or false
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

local function cleanESP()
    for player, data in pairs(ESPData) do
        if not player or not player.Parent or not player.Character or not isAlive(player) then
            if data then
                if data.conn then data.conn:Disconnect() end
                if data.lines then for _, l in pairs(data.lines) do if l.Remove then l:Remove() end end end
                if data.nt then data.nt:Remove() end
                if data.dt then data.dt:Remove() end
                if data.hbg then data.hbg:Remove() end
                if data.hf then data.hf:Remove() end
            end
            ESPData[player] = nil
        end
    end
end

-- GUI
local gui = Instance.new("ScreenGui", CoreGui)
gui.Name = "NCGUI"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local theme = getTheme()

local mainFrame = Instance.new("Frame", gui)
mainFrame.Size = UDim2.new(0, 380, 0, 550)
mainFrame.Position = UDim2.new(0.5, -190, 0.08, 0)
mainFrame.BackgroundColor3 = theme.Bg
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Visible = true
mainFrame.ZIndex = 10
mainFrame.ClipsDescendants = true
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 14)

local mainStroke = Instance.new("UIStroke", mainFrame)
mainStroke.Thickness = 1.5
mainStroke.Color = theme.Accent
mainStroke.Transparency = 0.5

local mainGradient = Instance.new("UIGradient", mainFrame)
mainGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, theme.Bg),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(theme.Bg.R * 0.7, theme.Bg.G * 0.7, theme.Bg.B * 0.7))
}
mainGradient.Rotation = 135

mainFrame.MouseEnter:Connect(function() uiHovered = true end)
mainFrame.MouseLeave:Connect(function() uiHovered = false end)

local function updateUIOpacity()
    mainFrame.BackgroundTransparency = 1 - (Settings.Misc.UIOpacity / 100)
end
updateUIOpacity()

local titleBar = Instance.new("Frame", mainFrame)
titleBar.Size = UDim2.new(1, 0, 0, 48)
titleBar.BackgroundColor3 = theme.Tab
titleBar.BorderSizePixel = 0
titleBar.ZIndex = 11
Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0, 14)

local titleGradient = Instance.new("UIGradient", titleBar)
titleGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, theme.Glow1),
    ColorSequenceKeypoint.new(1, theme.Glow2)
}
titleGradient.Rotation = 90

local titleIcon = Instance.new("Frame", titleBar)
titleIcon.Size = UDim2.new(0, 28, 0, 28)
titleIcon.Position = UDim2.new(0, 10, 0.5, -14)
titleIcon.BackgroundColor3 = theme.Accent
titleIcon.BackgroundTransparency = 0.7
titleIcon.BorderSizePixel = 0
titleIcon.ZIndex = 12
Instance.new("UICorner", titleIcon).CornerRadius = UDim.new(0, 8)

local titleIconText = Instance.new("TextLabel", titleIcon)
titleIconText.Size = UDim2.new(1, 0, 1, 0)
titleIconText.BackgroundTransparency = 1
titleIconText.Text = "😈"
titleIconText.Font = Enum.Font.Gotham
titleIconText.TextSize = 14
titleIconText.ZIndex = 13

local titleLabel = Instance.new("TextLabel", titleBar)
titleLabel.Size = UDim2.new(0, 150, 0, 22)
titleLabel.Position = UDim2.new(0, 45, 0.5, -11)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "NOOBS COCO"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.Font = Enum.Font.GothamBlack
titleLabel.TextSize = 16
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.ZIndex = 12

local titleSub = Instance.new("TextLabel", titleBar)
titleSub.Size = UDim2.new(0, 100, 0, 14)
titleSub.Position = UDim2.new(0, 45, 0.5, 12)
titleSub.BackgroundTransparency = 1
titleSub.Text = "ULTIMATE+"
titleSub.TextColor3 = Color3.fromRGB(255, 255, 255)
titleSub.TextTransparency = 0.5
titleSub.Font = Enum.Font.Gotham
titleSub.TextSize = 8
titleSub.TextXAlignment = Enum.TextXAlignment.Left
titleSub.ZIndex = 12

local closeBtn = Instance.new("TextButton", titleBar)
closeBtn.Size = UDim2.new(0, 28, 0, 28)
closeBtn.Position = UDim2.new(1, -36, 0.5, -14)
closeBtn.BackgroundColor3 = theme.Accent
closeBtn.BackgroundTransparency = 0.3
closeBtn.BorderSizePixel = 0
closeBtn.Text = "×"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 16
closeBtn.AutoButtonColor = false
closeBtn.ZIndex = 12
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 8)

local tabHolder = Instance.new("Frame", mainFrame)
tabHolder.Size = UDim2.new(1, 0, 0, 40)
tabHolder.Position = UDim2.new(0, 0, 0, 48)
tabHolder.BackgroundColor3 = theme.Tab
tabHolder.BorderSizePixel = 0
tabHolder.ZIndex = 11
Instance.new("UICorner", tabHolder).CornerRadius = UDim.new(0, 12)

local tabStroke = Instance.new("UIStroke", tabHolder)
tabStroke.Thickness = 1
tabStroke.Color = theme.Accent
tabStroke.Transparency = 0.6

local Tabs = {}
local TabContents = {}
local tabNames = {"ESP", "Chams", "Aimbot", "KillAura", "AutoClick", "Misc"}
local currentTab = "ESP"

for i, name in ipairs(tabNames) do
    local btn = Instance.new("TextButton", tabHolder)
    btn.Size = UDim2.new(1/#tabNames, -8, 0, 32)
    btn.Position = UDim2.new((i-1)/#tabNames, 4, 0, 4)
    btn.BackgroundColor3 = name == currentTab and theme.Accent or theme.Elem
    btn.BorderSizePixel = 0
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 7
    btn.AutoButtonColor = false
    btn.ZIndex = 12
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 10)
    
    local btnGrad = Instance.new("UIGradient", btn)
    if name == currentTab then
        btnGrad.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, theme.Glow1),
            ColorSequenceKeypoint.new(1, theme.Glow2)
        }
        btnGrad.Rotation = 90
    end
    
    Tabs[name] = btn
    
    local sc = Instance.new("ScrollingFrame", mainFrame)
    sc.Size = UDim2.new(1, 0, 1, -88)
    sc.Position = UDim2.new(0, 0, 0, 88)
    sc.BackgroundTransparency = 1
    sc.BorderSizePixel = 0
    sc.ScrollBarThickness = 2
    sc.ScrollBarImageColor3 = theme.Accent
    sc.CanvasSize = UDim2.new(0, 0, 0, 600)
    sc.Visible = name == currentTab
    sc.ZIndex = 10
    
    local inner = Instance.new("Frame", sc)
    inner.Size = UDim2.new(1, 0, 0, 600)
    inner.BackgroundTransparency = 1
    inner.ZIndex = 10
    TabContents[name] = {scroll = sc, inner = inner}
    
    btn.MouseButton1Click:Connect(function()
        currentTab = name
        local t = getTheme()
        for n, b in pairs(Tabs) do
            b.BackgroundColor3 = n == name and t.Accent or t.Elem
        end
        for n, c in pairs(TabContents) do c.scroll.Visible = n == name end
    end)
end

closeBtn.MouseButton1Click:Connect(function() mainFrame.Visible = false end)

local function section(parent, name, y)
    local t = getTheme()
    local s = Instance.new("Frame", parent)
    s.Size = UDim2.new(1, -16, 0, 30)
    s.Position = UDim2.new(0, 8, 0, y)
    s.BackgroundColor3 = t.Elem
    s.BorderSizePixel = 0
    s.ZIndex = 11
    Instance.new("UICorner", s).CornerRadius = UDim.new(0, 10)
    
    local sStroke = Instance.new("UIStroke", s)
    sStroke.Thickness = 1
    sStroke.Color = t.Accent
    sStroke.Transparency = 0.7
    
    local dot = Instance.new("Frame", s)
    dot.Size = UDim2.new(0, 6, 0, 6)
    dot.Position = UDim2.new(0, 10, 0.5, -3)
    dot.BackgroundColor3 = t.Accent
    dot.BorderSizePixel = 0
    Instance.new("UICorner", dot).CornerRadius = UDim.new(0, 3)
    
    local l = Instance.new("TextLabel", s)
    l.Size = UDim2.new(1, -24, 1, 0)
    l.Position = UDim2.new(0, 22, 0, 0)
    l.BackgroundTransparency = 1
    l.Text = name
    l.TextColor3 = Color3.fromRGB(255, 255, 255)
    l.Font = Enum.Font.GothamBold
    l.TextSize = 11
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.ZIndex = 12
    return y + 34
end

local function toggle(parent, text, y, def, cb)
    local t = getTheme()
    local f = Instance.new("Frame", parent)
    f.Size = UDim2.new(1, -16, 0, 34)
    f.Position = UDim2.new(0, 8, 0, y)
    f.BackgroundColor3 = t.Elem
    f.BorderSizePixel = 0
    f.ZIndex = 11
    Instance.new("UICorner", f).CornerRadius = UDim.new(0, 10)
    
    local fStroke = Instance.new("UIStroke", f)
    fStroke.Thickness = 1
    fStroke.Color = t.Accent
    fStroke.Transparency = 0.8
    
    local l = Instance.new("TextLabel", f)
    l.Size = UDim2.new(0.5, 0, 1, 0)
    l.Position = UDim2.new(0, 10, 0, 0)
    l.BackgroundTransparency = 1
    l.Text = text
    l.TextColor3 = t.Text
    l.Font = Enum.Font.Gotham
    l.TextSize = 10
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.ZIndex = 12
    
    local b = Instance.new("TextButton", f)
    b.Size = UDim2.new(0, 48, 0, 24)
    b.Position = UDim2.new(1, -54, 0.5, -12)
    b.BorderSizePixel = 0
    b.BackgroundColor3 = def and Color3.fromRGB(40, 200, 40) or t.Btn
    b.Text = def and "ON" or "OFF"
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.Font = Enum.Font.GothamBold
    b.TextSize = 9
    b.AutoButtonColor = false
    b.ZIndex = 12
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 8)
    
    local bStroke = Instance.new("UIStroke", b)
    bStroke.Thickness = 1
    bStroke.Color = def and Color3.fromRGB(60, 255, 60) or t.Accent
    bStroke.Transparency = 0.5
    
    local state = def
    b.MouseButton1Click:Connect(function()
        state = not state
        b.Text = state and "ON" or "OFF"
        b.BackgroundColor3 = state and Color3.fromRGB(40, 200, 40) or t.Btn
        bStroke.Color = state and Color3.fromRGB(60, 255, 60) or t.Accent
        cb(state) saveSettings()
    end)
    return y + 37
end

local function dropdown(parent, text, y, opts, defIdx, cb)
    local t = getTheme()
    local f = Instance.new("Frame", parent)
    f.Size = UDim2.new(1, -16, 0, 58)
    f.Position = UDim2.new(0, 8, 0, y)
    f.BackgroundColor3 = t.Elem
    f.BorderSizePixel = 0
    f.ZIndex = 11
    Instance.new("UICorner", f).CornerRadius = UDim.new(0, 10)
    
    local fStroke = Instance.new("UIStroke", f)
    fStroke.Thickness = 1
    fStroke.Color = t.Accent
    fStroke.Transparency = 0.8
    
    local l = Instance.new("TextLabel", f)
    l.Size = UDim2.new(1, -16, 0, 18)
    l.Position = UDim2.new(0, 8, 0, 4)
    l.BackgroundTransparency = 1
    l.Text = text
    l.TextColor3 = t.Text
    l.Font = Enum.Font.Gotham
    l.TextSize = 9
    l.ZIndex = 12
    
    local b = Instance.new("TextButton", f)
    b.Size = UDim2.new(1, -16, 0, 28)
    b.Position = UDim2.new(0, 8, 0, 26)
    b.BackgroundColor3 = t.Btn
    b.BorderSizePixel = 0
    b.Text = opts[defIdx]
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.Font = Enum.Font.Gotham
    b.TextSize = 10
    b.AutoButtonColor = false
    b.ZIndex = 12
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 8)
    
    local bStroke = Instance.new("UIStroke", b)
    bStroke.Thickness = 1
    bStroke.Color = t.Accent
    bStroke.Transparency = 0.5
    
    local idx = defIdx
    b.MouseButton1Click:Connect(function()
        idx = idx % #opts + 1
        b.Text = opts[idx]
        cb(opts[idx]) saveSettings()
    end)
    return y + 61
end

local function slider(parent, text, y, min, max, def, cb)
    local t = getTheme()
    local f = Instance.new("Frame", parent)
    f.Size = UDim2.new(1, -16, 0, 52)
    f.Position = UDim2.new(0, 8, 0, y)
    f.BackgroundColor3 = t.Elem
    f.BorderSizePixel = 0
    f.ZIndex = 11
    Instance.new("UICorner", f).CornerRadius = UDim.new(0, 10)
    
    local fStroke = Instance.new("UIStroke", f)
    fStroke.Thickness = 1
    fStroke.Color = t.Accent
    fStroke.Transparency = 0.8
    
    local l = Instance.new("TextLabel", f)
    l.Size = UDim2.new(1, -16, 0, 18)
    l.Position = UDim2.new(0, 8, 0, 4)
    l.BackgroundTransparency = 1
    l.Text = text .. ": " .. string.format("%.0f", def)
    l.TextColor3 = t.Text
    l.Font = Enum.Font.Gotham
    l.TextSize = 9
    l.ZIndex = 12
    
    local bar = Instance.new("TextButton", f)
    bar.Size = UDim2.new(1, -16, 0, 18)
    bar.Position = UDim2.new(0, 8, 0, 28)
    bar.BackgroundColor3 = t.Btn
    bar.BorderSizePixel = 0
    bar.Text = "" bar.AutoButtonColor = false bar.ZIndex = 12
    Instance.new("UICorner", bar).CornerRadius = UDim.new(0, 9)
    
    local fill = Instance.new("Frame", bar)
    fill.Size = UDim2.new((def - min) / (max - min), 0, 1, 0)
    fill.BackgroundColor3 = t.Accent
    fill.BorderSizePixel = 0
    fill.ZIndex = 13
    Instance.new("UICorner", fill).CornerRadius = UDim.new(0, 9)
    
    local fillGrad = Instance.new("UIGradient", fill)
    fillGrad.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, t.Glow1),
        ColorSequenceKeypoint.new(1, t.Glow2)
    }
    fillGrad.Rotation = 90
    
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
    return y + 55
end

-- ESP Tab
local y = 6 local inner = TabContents["ESP"].inner
y = section(inner, "ESP", y)
y = toggle(inner, "Enabled", y, Settings.ESP.Enabled, function(s) Settings.ESP.Enabled = s end)
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
y = toggle(inner, "Enabled", y, Settings.Chams.Enabled, function(s)
    Settings.Chams.Enabled = s
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local hl = p.Character:FindFirstChild("CH")
            if hl then hl.Enabled = s elseif s then applyChams(p) end
        end
    end
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

-- AutoClick Tab
y = 6 inner = TabContents["AutoClick"].inner
y = section(inner, "AUTO CLICKER", y)
y = toggle(inner, "Enabled", y, Settings.AutoClicker.Enabled, function(s) Settings.AutoClicker.Enabled = s if s then startClicker() else stopClicker() end end)
y = slider(inner, "CPS", y, 1, 30, Settings.AutoClicker.CPS, function(v) Settings.AutoClicker.CPS = v end)
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
y = toggle(inner, "Bunnyhop", y, Settings.Misc.AutoBunnyhop, function(s) Settings.Misc.AutoBunnyhop = s end)
y = toggle(inner, "Spinbot", y, Settings.Misc.Spinbot, function(s) Settings.Misc.Spinbot = s end)

y = section(inner, "VISUAL", y + 3)
y = toggle(inner, "Fullbright", y, Settings.Misc.Fullbright, function(s) if s then Lighting.Brightness = 3 else Lighting.Brightness = 1 end end)
y = toggle(inner, "No Recoil", y, Settings.Misc.NoRecoil, function(s) Settings.Misc.NoRecoil = s end)
y = toggle(inner, "No Spread", y, Settings.Misc.NoSpread, function(s) Settings.Misc.NoSpread = s end)
y = toggle(inner, "FOV Changer", y, Settings.Misc.FOVChanger, function(s) Settings.Misc.FOVChanger = s if s then Camera.FieldOfView = Settings.Misc.FOVVal else Camera.FieldOfView = 70 end end)
y = slider(inner, "FOV Val", y, 30, 120, Settings.Misc.FOVVal, function(v) Settings.Misc.FOVVal = v if Settings.Misc.FOVChanger then Camera.FieldOfView = v end end)

y = section(inner, "UI", y + 3)
y = dropdown(inner, "Theme", y, {"Red", "Dark", "Blue", "Green", "Purple", "Cyan", "Orange", "Pink", "White", "Yellow", "Lime"}, 1, function(o)
    Settings.UI.Theme = o
    local t = getTheme()
    mainFrame.BackgroundColor3 = t.Bg
    mainStroke.Color = t.Accent
    titleGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0, t.Glow1), ColorSequenceKeypoint.new(1, t.Glow2)}
    tabStroke.Color = t.Accent
    titleIcon.BackgroundColor3 = t.Accent
    closeBtn.BackgroundColor3 = t.Accent
    for n, b in pairs(Tabs) do b.BackgroundColor3 = n == currentTab and t.Accent or t.Elem end
    saveSettings()
end)
y = slider(inner, "UI Opacity", y, 15, 100, Settings.Misc.UIOpacity, function(v)
    Settings.Misc.UIOpacity = v
    updateUIOpacity()
end)
TabContents["Misc"].scroll.CanvasSize = UDim2.new(0, 0, 0, y + 20)

function applyChams(player)
    if not player.Character then return end
    local c = player.Character
    local old = c:FindFirstChild("CH")
    if old then old:Destroy() end
    
    if not Settings.Chams.Enabled then return end
    
    local hl = Instance.new("Highlight")
    hl.Name = "CH"
    hl.Enabled = true
    hl.FillTransparency = Settings.Chams.FillTrans
    hl.OutlineTransparency = Settings.Chams.OutlineTrans
    hl.Adornee = c
    hl.Parent = c
    
    if Settings.Chams.Color ~= "Rainbow" then
        local col = Colors[Settings.Chams.Color] or Colors.Red
        hl.FillColor = col
        hl.OutlineColor = col
    end
end

function createESP(player)
    if ESPData[player] then
        if ESPData[player].conn then ESPData[player].conn:Disconnect() end
        if ESPData[player].lines then for _, l in pairs(ESPData[player].lines) do l:Remove() end end
        if ESPData[player].nt then ESPData[player].nt:Remove() end
        if ESPData[player].dt then ESPData[player].dt:Remove() end
        if ESPData[player].hbg then ESPData[player].hbg:Remove() end
        if ESPData[player].hf then ESPData[player].hf:Remove() end
    end
    ESPData[player] = {}
    
    local lines = {} for i = 1, 8 do local l = Drawing.new("Line") l.Visible = false lines[i] = l end
    local nt = Drawing.new("Text") nt.Visible = false nt.Center = true nt.Size = 14 nt.Font = 3 nt.Outline = true
    local dt = Drawing.new("Text") dt.Visible = false dt.Center = true dt.Size = 12 dt.Font = 3 dt.Outline = true
    local hbg = Drawing.new("Square") hbg.Visible = false hbg.Filled = true hbg.Color = Color3.fromRGB(15,15,15) hbg.Transparency = 0.4
    local hf = Drawing.new("Square") hf.Visible = false hf.Filled = true
    ESPData[player].lines = lines ESPData[player].nt = nt ESPData[player].dt = dt ESPData[player].hbg = hbg ESPData[player].hf = hf
    
    ESPData[player].conn = RunService.RenderStepped:Connect(function()
        local c = player.Character
        if not c or not isAlive(player) or not Settings.ESP.Enabled then
            for _, l in pairs(lines) do l.Visible = false end
            nt.Visible = false dt.Visible = false hbg.Visible = false hf.Visible = false
            return
        end
        
        local h = c:FindFirstChild("Head") local r = c:FindFirstChild("HumanoidRootPart")
        if not h or not r then return end
        
        local hp = h.Position + Vector3.new(0, 0.5, 0) local rp = r.Position - Vector3.new(0, 2, 0)
        local cp = r.Position + Vector3.new(0, math.abs(h.Position.Y - r.Position.Y), 0)
        local ts = Camera:WorldToViewportPoint(hp) local bs = Camera:WorldToViewportPoint(rp)
        if ts.Z <= 0 then for _, l in pairs(lines) do l.Visible = false end return end
        
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
            local hum = c:FindFirstChildOfClass("Humanoid")
            if hum then
                local health = hum.Health / hum.MaxHealth local bh = by - ty local bx = lx - 7
                hbg.Visible = true hbg.Size = Vector2.new(3, bh) hbg.Position = Vector2.new(bx, ty)
                hf.Visible = true hf.Size = Vector2.new(3, bh*health) hf.Position = Vector2.new(bx, ty + bh*(1-health)) hf.Color = Color3.fromHSV(health*0.33, 1, 1)
            end
        else hbg.Visible = false hf.Visible = false end
    end)
end

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
            safeClick()
        end
    end
end

local clickerConn
function startClicker()
    if clickerConn then clickerConn:Disconnect() end
    clickerConn = RunService.RenderStepped:Connect(function()
        if not Settings.AutoClicker.Enabled then stopClicker() return end
        task.wait(1 / Settings.AutoClicker.CPS)
        safeClick()
    end)
end
function stopClicker() if clickerConn then clickerConn:Disconnect() clickerConn = nil end end

local fovCircle = Drawing.new("Circle") fovCircle.Visible = false fovCircle.Thickness = 1.5 fovCircle.NumSides = 64 fovCircle.Transparency = 0.7

RunService.RenderStepped:Connect(function()
    if Settings.Misc.AutoBunnyhop then local c = LocalPlayer.Character if c then local h = c:FindFirstChildOfClass("Humanoid") if h and h.MoveDirection.Magnitude > 0 and h.FloorMaterial ~= Enum.Material.Air then h.Jump = true end end end
    if Settings.Misc.Spinbot then local c = LocalPlayer.Character if c and c:FindFirstChild("HumanoidRootPart") then c.HumanoidRootPart.CFrame = c.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(15), 0) end end
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
            if Settings.Aimbot.TriggerBot and bd < 50 then safeClick() end
        end
    end
    
    if tick() % 10 < 0.03 then cleanESP() end
end)

local flyConn
function startFly()
    local c = LocalPlayer.Character if not c then return end
    local r = c:FindFirstChild("HumanoidRootPart") local h = c:FindFirstChildOfClass("Humanoid")
    if not r or not h then return end
    h.PlatformStand = true
    flyConn = RunService.RenderStepped:Connect(function()
        if not Settings.Misc.Fly then stopFly() return end
        local vel = Vector3.zero
        
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then vel += Camera.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then vel -= Camera.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then vel -= Camera.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then vel += Camera.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then vel += Vector3.new(0, 1, 0) end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then vel -= Vector3.new(0, 1, 0) end
        
        if vel.Magnitude > 0 then
            vel = vel.Unit * Settings.Misc.FlySpeed
        end
        
        r.Velocity = vel
    end)
end
function stopFly()
    if flyConn then flyConn:Disconnect() flyConn = nil end
    local c = LocalPlayer.Character
    if c then
        local h = c:FindFirstChildOfClass("Humanoid")
        if h then h.PlatformStand = false end
        local r = c:FindFirstChild("HumanoidRootPart")
        if r then r.Velocity = Vector3.zero end
    end
end

local ncConn
function enableNC() ncConn = RunService.Stepped:Connect(function() if LocalPlayer.Character then for _, p in pairs(LocalPlayer.Character:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide = false end end end end) end
function disableNC() if ncConn then ncConn:Disconnect() end end

function updSpeed() local c = LocalPlayer.Character if c then local h = c:FindFirstChildOfClass("Humanoid") if h then h.WalkSpeed = Settings.Misc.Speed and Settings.Misc.SpeedVal or 16 end end end
function updJump() local c = LocalPlayer.Character if c then local h = c:FindFirstChildOfClass("Humanoid") if h then h.UseJumpPower = true h.JumpPower = Settings.Misc.JumpPower and Settings.Misc.JumpVal or 50 end end end

for _, p in pairs(Players:GetPlayers()) do
    if p ~= LocalPlayer then
        p.CharacterAdded:Connect(function() task.wait(0.3) createESP(p) applyChams(p) end)
        if p.Character then createESP(p) applyChams(p) end
    end
end
Players.PlayerAdded:Connect(function(p)
    if p ~= LocalPlayer then
        p.CharacterAdded:Connect(function() task.wait(0.3) createESP(p) applyChams(p) end)
        if p.Character then createESP(p) applyChams(p) end
    end
end)
Players.PlayerRemoving:Connect(function(p)
    if lockedTarget == p then lockedTarget = nil end
    if ESPData[p] then
        if ESPData[p].conn then ESPData[p].conn:Disconnect() end
        if ESPData[p].lines then for _, l in pairs(ESPData[p].lines) do l:Remove() end end
        ESPData[p] = nil
    end
end)

UserInputService.InputBegan:Connect(function(input, gp)
    if not gp and input.KeyCode == Enum.KeyCode.V then
        mainFrame.Visible = not mainFrame.Visible
    end
end)

LocalPlayer.CharacterAdded:Connect(function()
    task.wait(0.5)
    updSpeed() updJump()
    if Settings.Chams.Enabled then
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer then applyChams(p) end
        end
    end
end)
if LocalPlayer.Character then updSpeed() updJump() end
