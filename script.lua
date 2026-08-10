local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local Mouse = LocalPlayer:GetMouse()

local Lang = {
    Current = "RU",
    RU = {
        ESP = "🔲 ESP", Chams = "🎨 CHAMS", Aimbot = "🎯 АИМБОТ", Misc = "⚡ ФУНКЦИИ", Settings = "⚙️ НАСТРОЙКИ",
        Enabled = "Включить", BoxType = "Тип бокса", Color = "Цвет", Thickness = "Толщина", Transparency = "Прозрачность",
        ShowName = "Показывать имя", ShowDist = "Показывать дистанцию", HealthBar = "Полоска здоровья",
        Skeleton = "Скелет", FillTrans = "Прозрачность заливки", OutlineTrans = "Прозрачность обводки",
        TargetPart = "Часть тела", UnlockFOV = "Разблокировать FOV", AutoShoot = "Авто-выстрел",
        FOVSize = "Размер FOV", FOVColor = "Цвет FOV", Smoothness = "Плавность", SilentAim = "Silent Aim",
        Speed = "Скорость", JumpPower = "Сила прыжка", Gravity = "Гравитация", Fly = "Полёт",
        NoClip = "Ноуклип", SpeedVal = "Скорость", JumpVal = "Сила прыжка", GravVal = "Гравитация",
        FlySpeed = "Скорость полёта", Toggle = "Переключить", Language = "Язык",
        FPBoost = "FPS Boost", PingBoost = "Пинг оптимизация", NoFog = "Убрать туман", NoShadows = "Убрать тени",
        LowGraphics = "Низкая графика", Crosshair = "Прицел", CrosshairSize = "Размер прицела",
        CrosshairThick = "Толщина", CrosshairGap = "Зазор", ZoomHack = "Zoom Hack", FOVChanger = "Изменение FOV",
        ThirdPerson = "3-е лицо", TPdist = "Дистанция", Fullbright = "Fullbright", NoRecoil = "Без отдачи",
        NoSpread = "Без разброса", InfJump = "Беск. прыжки",
        KillAura = "KILL AURA", KARange = "Радиус", KATarget = "Цель", KATeleport = "Телепорт"
    },
    EN = {
        ESP = "🔲 ESP", Chams = "🎨 CHAMS", Aimbot = "🎯 AIMBOT", Misc = "⚡ MISC", Settings = "⚙️ SETTINGS",
        Enabled = "Enabled", BoxType = "Box Type", Color = "Color", Thickness = "Thickness", Transparency = "Transparency",
        ShowName = "Show Name", ShowDist = "Show Distance", HealthBar = "Health Bar",
        Skeleton = "Skeleton", FillTrans = "Fill Transparency", OutlineTrans = "Outline Transparency",
        TargetPart = "Target Part", UnlockFOV = "Unlock FOV", AutoShoot = "Auto Shoot",
        FOVSize = "FOV Size", FOVColor = "FOV Color", Smoothness = "Smoothness", SilentAim = "Silent Aim",
        Speed = "Speed", JumpPower = "Jump Power", Gravity = "Gravity", Fly = "Fly",
        NoClip = "NoClip", SpeedVal = "Speed", JumpVal = "Jump Power", GravVal = "Gravity",
        FlySpeed = "Fly Speed", Toggle = "Toggle", Language = "Language",
        FPBoost = "FPS Boost", PingBoost = "Ping Optimizer", NoFog = "No Fog", NoShadows = "No Shadows",
        LowGraphics = "Low Graphics", Crosshair = "Crosshair", CrosshairSize = "Crosshair Size",
        CrosshairThick = "Thickness", CrosshairGap = "Gap", ZoomHack = "Zoom Hack", FOVChanger = "FOV Changer",
        ThirdPerson = "3rd Person", TPdist = "Distance", Fullbright = "Fullbright", NoRecoil = "No Recoil",
        NoSpread = "No Spread", InfJump = "Inf Jumps",
        KillAura = "KILL AURA", KARange = "Range", KATarget = "Target", KATeleport = "Teleport"
    },
    UA = {
        ESP = "🔲 ESP", Chams = "🎨 CHAMS", Aimbot = "🎯 АІМБОТ", Misc = "⚡ ФУНКЦІЇ", Settings = "⚙️ НАЛАШТУВАННЯ",
        Enabled = "Увімкнути", BoxType = "Тип боксу", Color = "Колір", Thickness = "Товщина", Transparency = "Прозорість",
        ShowName = "Показувати ім'я", ShowDist = "Показувати дистанцію", HealthBar = "Смуга здоров'я",
        Skeleton = "Скелет", FillTrans = "Прозорість заливки", OutlineTrans = "Прозорість обведення",
        TargetPart = "Частина тіла", UnlockFOV = "Розблокувати FOV", AutoShoot = "Авто-постріл",
        FOVSize = "Розмір FOV", FOVColor = "Колір FOV", Smoothness = "Плавність", SilentAim = "Silent Aim",
        Speed = "Швидкість", JumpPower = "Сила стрибка", Gravity = "Гравітація", Fly = "Політ",
        NoClip = "Ноукліп", SpeedVal = "Швидкість", JumpVal = "Сила стрибка", GravVal = "Гравітація",
        FlySpeed = "Швидкість польоту", Toggle = "Перемкнути", Language = "Мова",
        FPBoost = "FPS Boost", PingBoost = "Пінг оптимізація", NoFog = "Прибрати туман", NoShadows = "Прибрати тіні",
        LowGraphics = "Низька графіка", Crosshair = "Приціл", CrosshairSize = "Розмір прицілу",
        CrosshairThick = "Товщина", CrosshairGap = "Зазор", ZoomHack = "Zoom Hack", FOVChanger = "Зміна FOV",
        ThirdPerson = "3-є обличчя", TPdist = "Дистанція", Fullbright = "Fullbright", NoRecoil = "Без віддачі",
        NoSpread = "Без розкиду", InfJump = "Неск. стрибки",
        KillAura = "KILL AURA", KARange = "Радіус", KATarget = "Ціль", KATeleport = "Телепорт"
    }
}

local L = Lang[Lang.Current]

local Settings = {
    ESP = {Enabled = false, ColorPreset = "White", Thickness = 2, Transparency = 0.8, BoxType = "Corner", Name = true, Distance = true, HealthBar = true, Skeleton = false},
    Chams = {Enabled = false, ColorPreset = "Red", FillTransparency = 0.5, OutlineTransparency = 0.3},
    Aimbot = {Enabled = false, FOV = 200, Smoothness = 1, TargetPart = "Head", UnlockFOV = false, AutoShoot = false, SilentAim = false, FOVColor = Color3.fromRGB(255, 60, 60)},
    KillAura = {Enabled = false, Range = 50, TargetPart = "Head", Teleport = true, TeleportHeight = 15, AimFirst = true, AutoAttack = true},
    Misc = {
        Speed = false, SpeedVal = 50, JumpPower = false, JumpVal = 100, Gravity = false, GravVal = 50,
        Fly = false, FlySpeed = 50, NoClip = false, InfJump = false,
        FPBoost = false, PingBoost = false, NoFog = false, NoShadows = false, LowGraphics = false,
        Crosshair = false, CrosshairSize = 20, CrosshairThick = 2, CrosshairGap = 10,
        ZoomHack = false, FOVChanger = false, FOVVal = 90, ThirdPerson = false, TPdist = 10,
        Fullbright = false, NoRecoil = false, NoSpread = false
    }
}

local ESPData = {}
local ColorPresets = {
    White = Color3.fromRGB(255, 255, 255), Gray = Color3.fromRGB(160, 160, 160), Red = Color3.fromRGB(255, 50, 50),
    Green = Color3.fromRGB(50, 255, 50), Blue = Color3.fromRGB(50, 50, 255), LightBlue = Color3.fromRGB(100, 180, 255),
    Purple = Color3.fromRGB(200, 50, 255), Yellow = Color3.fromRGB(255, 255, 50), Orange = Color3.fromRGB(255, 150, 0),
    Pink = Color3.fromRGB(255, 100, 200), Cyan = Color3.fromRGB(0, 255, 255)
}

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

local function GetLang() return Lang[Lang.Current] end

local ScreenGui = Instance.new("ScreenGui") ScreenGui.Name = "NOOBS_COCO_GUI" ScreenGui.Parent = CoreGui ScreenGui.ResetOnSpawn = false ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local MainFrame = Instance.new("Frame") MainFrame.Size = UDim2.new(0, 450, 0, 620) MainFrame.Position = UDim2.new(0.5, -225, 0.15, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 22) MainFrame.BorderSizePixel = 0 MainFrame.ClipsDescendants = true
MainFrame.Active = true MainFrame.Draggable = true MainFrame.Visible = true MainFrame.ZIndex = 10 MainFrame.Parent = ScreenGui

local OuterGlow = Instance.new("Frame") OuterGlow.Size = UDim2.new(1, 10, 1, 10) OuterGlow.Position = UDim2.new(0, -5, 0, -5)
OuterGlow.BackgroundColor3 = Color3.fromRGB(255, 60, 60) OuterGlow.BackgroundTransparency = 0.8 OuterGlow.BorderSizePixel = 0 OuterGlow.ZIndex = 9 OuterGlow.Parent = MainFrame
Instance.new("UICorner", OuterGlow).CornerRadius = UDim.new(0, 10)
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)

local TabBar = Instance.new("Frame") TabBar.Size = UDim2.new(1, 0, 0, 55) TabBar.BackgroundColor3 = Color3.fromRGB(12, 12, 16)
TabBar.BorderSizePixel = 0 TabBar.ZIndex = 11 TabBar.Parent = MainFrame
Instance.new("UICorner", TabBar).CornerRadius = UDim.new(0, 8)

local Title = Instance.new("TextLabel") Title.Size = UDim2.new(0, 210, 0, 30) Title.Position = UDim2.new(0, 15, 0, 6)
Title.BackgroundTransparency = 1 Title.Text = "NOOBS COCO😈" Title.TextColor3 = Color3.fromRGB(255, 60, 60)
Title.Font = Enum.Font.GothamBlack Title.TextSize = 22 Title.TextXAlignment = Enum.TextXAlignment.Left Title.ZIndex = 12 Title.Parent = TabBar

local LangBtn = Instance.new("TextButton") LangBtn.Size = UDim2.new(0, 45, 0, 24) LangBtn.Position = UDim2.new(1, -125, 0.5, -12)
LangBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 35) LangBtn.BorderSizePixel = 0 LangBtn.Text = Lang.Current LangBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
LangBtn.Font = Enum.Font.GothamBold LangBtn.TextSize = 10 LangBtn.AutoButtonColor = false LangBtn.ZIndex = 12 LangBtn.Parent = TabBar
Instance.new("UICorner", LangBtn).CornerRadius = UDim.new(0, 4)

local CloseBtn = Instance.new("TextButton") CloseBtn.Size = UDim2.new(0, 60, 0, 24) CloseBtn.Position = UDim2.new(1, -70, 0.5, -12)
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 60) CloseBtn.BorderSizePixel = 0 CloseBtn.Text = "[V]" CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Font = Enum.Font.GothamBold CloseBtn.TextSize = 11 CloseBtn.AutoButtonColor = false CloseBtn.ZIndex = 12 CloseBtn.Parent = TabBar
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 4)

local Tabs = {}
local TabContents = {}
local tabNames = {"ESP", "Chams", "Aimbot", "KillAura", "Misc", "Settings"}
local currentTab = "ESP"

local TabHolder = Instance.new("Frame") TabHolder.Size = UDim2.new(1, 0, 0, 40) TabHolder.Position = UDim2.new(0, 0, 0, 55)
TabHolder.BackgroundColor3 = Color3.fromRGB(22, 22, 26) TabHolder.BorderSizePixel = 0 TabHolder.ZIndex = 11 TabHolder.Parent = MainFrame

for i, name in ipairs(tabNames) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1/#tabNames, -12, 0, 34) btn.Position = UDim2.new((i-1)/#tabNames, 6, 0, 3)
    btn.BackgroundColor3 = name == currentTab and Color3.fromRGB(255, 60, 60) or Color3.fromRGB(35, 35, 40)
    btn.BorderSizePixel = 0 btn.Text = L[name] or name btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold btn.TextSize = 10 btn.AutoButtonColor = false btn.ZIndex = 12 btn.Parent = TabHolder
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)
    Tabs[name] = btn
    
    local content = Instance.new("ScrollingFrame") content.Size = UDim2.new(1, 0, 1, -95) content.Position = UDim2.new(0, 0, 0, 95)
    content.BackgroundTransparency = 1 content.BorderSizePixel = 0 content.ScrollBarThickness = 3
    content.ScrollBarImageColor3 = Color3.fromRGB(255, 60, 60) content.CanvasSize = UDim2.new(0, 0, 0, 2500)
    content.ZIndex = 10 content.Visible = name == currentTab content.Parent = MainFrame
    local inner = Instance.new("Frame") inner.Size = UDim2.new(1, 0, 0, 2500) inner.BackgroundTransparency = 1 inner.ZIndex = 10 inner.Parent = content
    TabContents[name] = {scroll = content, inner = inner}
    
    btn.MouseButton1Click:Connect(function()
        currentTab = name
        for n, b in pairs(Tabs) do b.BackgroundColor3 = n == name and Color3.fromRGB(255, 60, 60) or Color3.fromRGB(35, 35, 40) end
        for n, c in pairs(TabContents) do c.scroll.Visible = n == name end
    end)
end

LangBtn.MouseButton1Click:Connect(function()
    local langs = {"RU", "EN", "UA"}
    local idx = table.find(langs, Lang.Current) or 1
    Lang.Current = langs[idx % #langs + 1]
    L = GetLang()
    LangBtn.Text = Lang.Current
end)

CloseBtn.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)

local function CreateSection(parent, name, yPos)
    local s = Instance.new("Frame") s.Size = UDim2.new(1, -20, 0, 34) s.Position = UDim2.new(0, 10, 0, yPos)
    s.BackgroundColor3 = Color3.fromRGB(28, 28, 33) s.BorderSizePixel = 0 s.ZIndex = 11
    Instance.new("UICorner", s).CornerRadius = UDim.new(0, 5)
    local grad = Instance.new("UIGradient") grad.Color = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(255,60,60)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255,100,100))} grad.Rotation = 90 grad.Parent = s
    local l = Instance.new("TextLabel") l.Size = UDim2.new(1, 0, 1, 0) l.BackgroundTransparency = 1 l.Text = "  " .. name
    l.TextColor3 = Color3.fromRGB(255, 255, 255) l.Font = Enum.Font.GothamBold l.TextSize = 13 l.TextXAlignment = Enum.TextXAlignment.Left l.ZIndex = 12 l.Parent = s
    s.Parent = parent return yPos + 38
end

local function CreateToggle(parent, text, yPos, defaultState, callback)
    local f = Instance.new("Frame") f.Size = UDim2.new(1, -20, 0, 34) f.Position = UDim2.new(0, 10, 0, yPos)
    f.BackgroundColor3 = Color3.fromRGB(33, 33, 38) f.BorderSizePixel = 0 f.ZIndex = 11
    Instance.new("UICorner", f).CornerRadius = UDim.new(0, 5)
    local l = Instance.new("TextLabel") l.Size = UDim2.new(0.5, 0, 1, 0) l.BackgroundTransparency = 1 l.Text = "  " .. text
    l.TextColor3 = Color3.fromRGB(200, 200, 200) l.Font = Enum.Font.Gotham l.TextSize = 12 l.TextXAlignment = Enum.TextXAlignment.Left l.ZIndex = 12 l.Parent = f
    local b = Instance.new("TextButton") b.Size = UDim2.new(0, 65, 0, 26) b.Position = UDim2.new(1, -75, 0.5, -13) b.BorderSizePixel = 0
    b.BackgroundColor3 = defaultState and Color3.fromRGB(40, 200, 40) or Color3.fromRGB(70, 70, 75) b.Text = defaultState and "ON" or "OFF"
    b.TextColor3 = Color3.fromRGB(255, 255, 255) b.Font = Enum.Font.GothamBold b.TextSize = 11 b.AutoButtonColor = false b.ZIndex = 12
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 4) b.Parent = f f.Parent = parent
    local state = defaultState
    b.MouseButton1Click:Connect(function() state = not state b.Text = state and "ON" or "OFF" b.BackgroundColor3 = state and Color3.fromRGB(40, 200, 40) or Color3.fromRGB(70, 70, 75) callback(state) SaveSettings() end)
    return yPos + 37
end

local function CreateDropdown(parent, text, options, yPos, defaultIndex, callback)
    local f = Instance.new("Frame") f.Size = UDim2.new(1, -20, 0, 68) f.Position = UDim2.new(0, 10, 0, yPos)
    f.BackgroundColor3 = Color3.fromRGB(33, 33, 38) f.BorderSizePixel = 0 f.ZIndex = 11
    Instance.new("UICorner", f).CornerRadius = UDim.new(0, 5)
    local l = Instance.new("TextLabel") l.Size = UDim2.new(1, -20, 0, 22) l.Position = UDim2.new(0, 10, 0, 5)
    l.BackgroundTransparency = 1 l.Text = text l.TextColor3 = Color3.fromRGB(170, 170, 170) l.Font = Enum.Font.Gotham l.TextSize = 11
    l.TextXAlignment = Enum.TextXAlignment.Left l.ZIndex = 12 l.Parent = f
    local b = Instance.new("TextButton") b.Size = UDim2.new(1, -20, 0, 30) b.Position = UDim2.new(0, 10, 0, 30)
    b.BackgroundColor3 = Color3.fromRGB(45, 45, 50) b.BorderSizePixel = 0 b.Text = options[defaultIndex] b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.Font = Enum.Font.Gotham b.TextSize = 12 b.AutoButtonColor = false b.ZIndex = 12
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 4) b.Parent = f f.Parent = parent
    local index = defaultIndex
    b.MouseButton1Click:Connect(function() index = index % #options + 1 b.Text = options[index] callback(options[index], index) SaveSettings() end)
    return yPos + 71
end

local function CreateSlider(parent, text, min, max, default, yPos, callback)
    local f = Instance.new("Frame") f.Size = UDim2.new(1, -20, 0, 60) f.Position = UDim2.new(0, 10, 0, yPos)
    f.BackgroundColor3 = Color3.fromRGB(33, 33, 38) f.BorderSizePixel = 0 f.ZIndex = 11
    Instance.new("UICorner", f).CornerRadius = UDim.new(0, 5)
    local l = Instance.new("TextLabel") l.Size = UDim2.new(1, -20, 0, 22) l.Position = UDim2.new(0, 10, 0, 5)
    l.BackgroundTransparency = 1 l.Text = text .. ": " .. string.format("%.1f", default) l.TextColor3 = Color3.fromRGB(170, 170, 170)
    l.Font = Enum.Font.Gotham l.TextSize = 11 l.TextXAlignment = Enum.TextXAlignment.Left l.ZIndex = 12 l.Parent = f
    local bar = Instance.new("TextButton") bar.Size = UDim2.new(1, -20, 0, 20) bar.Position = UDim2.new(0, 10, 0, 32)
    bar.BackgroundColor3 = Color3.fromRGB(45, 45, 50) bar.BorderSizePixel = 0 bar.Text = "" bar.AutoButtonColor = false bar.ZIndex = 12
    Instance.new("UICorner", bar).CornerRadius = UDim.new(0, 10)
    local fill = Instance.new("Frame") local range = max - min fill.Size = UDim2.new((default - min) / range, 0, 1, 0)
    fill.BorderSizePixel = 0 fill.ZIndex = 13
    local grad = Instance.new("UIGradient") grad.Color = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(255,60,60)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255,140,140))} grad.Rotation = 90 grad.Parent = fill
    Instance.new("UICorner", fill).CornerRadius = UDim.new(0, 10) fill.Parent = bar bar.Parent = f f.Parent = parent
    local value = default local isDragging = false
    local function update()
        local mp = UserInputService:GetMouseLocation() local bp = bar.AbsolutePosition local bs = bar.AbsoluteSize
        local rx = math.clamp((mp.X - bp.X) / bs.X, 0, 1) value = min + range * rx
        fill.Size = UDim2.new(rx, 0, 1, 0) l.Text = text .. ": " .. string.format("%.1f", value) callback(value)
    end
    bar.MouseButton1Down:Connect(function() isDragging = true update() end)
    UserInputService.InputChanged:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseMovement and isDragging then update() end end)
    UserInputService.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then isDragging = false SaveSettings() end end)
    return yPos + 63
end

local y = 10
local inner = TabContents["ESP"].inner
y = CreateSection(inner, L.ESP, y)
y, _ = CreateToggle(inner, L.Enabled, y, Settings.ESP.Enabled, function(s) Settings.ESP.Enabled = s end)
y, _ = CreateDropdown(inner, L.BoxType, {"Corner", "Full", "Corner+Full"}, y, 1, function(o) Settings.ESP.BoxType = o end)
y, _ = CreateDropdown(inner, L.Color, {"White", "Gray", "LightBlue", "Purple", "Yellow", "Orange", "Pink", "Cyan", "Rainbow"}, y, 1, function(o) Settings.ESP.ColorPreset = o end)
y = CreateSlider(inner, L.Thickness, 1, 6, Settings.ESP.Thickness, y, function(v) Settings.ESP.Thickness = v end)
y = CreateSlider(inner, L.Transparency, 0, 1, Settings.ESP.Transparency, y, function(v) Settings.ESP.Transparency = v end)
y, _ = CreateToggle(inner, L.ShowName, y, Settings.ESP.Name, function(s) Settings.ESP.Name = s end)
y, _ = CreateToggle(inner, L.ShowDist, y, Settings.ESP.Distance, function(s) Settings.ESP.Distance = s end)
y, _ = CreateToggle(inner, L.HealthBar, y, Settings.ESP.HealthBar, function(s) Settings.ESP.HealthBar = s end)
y, _ = CreateToggle(inner, L.Skeleton, y, Settings.ESP.Skeleton, function(s) Settings.ESP.Skeleton = s end)
TabContents["ESP"].scroll.CanvasSize = UDim2.new(0, 0, 0, y + 20)

y = 10
inner = TabContents["Chams"].inner
y = CreateSection(inner, L.Chams, y)
y, _ = CreateToggle(inner, L.Enabled, y, Settings.Chams.Enabled, function(s)
    Settings.Chams.Enabled = s
    for _, p in pairs(Players:GetPlayers()) do if p ~= LocalPlayer and p.Character then local hl = p.Character:FindFirstChild("ESP_Chams") if hl then hl.Enabled = s elseif s then ApplyChams(p) end end end
end)
y, _ = CreateDropdown(inner, L.Color, {"Red", "Green", "Blue", "Purple", "Yellow", "Orange", "Pink", "Cyan", "Rainbow"}, y, 1, function(o)
    Settings.Chams.ColorPreset = o
    for _, p in pairs(Players:GetPlayers()) do if p ~= LocalPlayer and p.Character then local hl = p.Character:FindFirstChild("ESP_Chams") if hl and o ~= "Rainbow" then local col = ColorPresets[o] or ColorPresets.Red hl.FillColor = col hl.OutlineColor = col end end end
end)
y = CreateSlider(inner, L.FillTrans, 0, 1, Settings.Chams.FillTransparency, y, function(v) Settings.Chams.FillTransparency = v for _, p in pairs(Players:GetPlayers()) do if p ~= LocalPlayer and p.Character then local hl = p.Character:FindFirstChild("ESP_Chams") if hl then hl.FillTransparency = v end end end end)
y = CreateSlider(inner, L.OutlineTrans, 0, 1, Settings.Chams.OutlineTransparency, y, function(v) Settings.Chams.OutlineTransparency = v for _, p in pairs(Players:GetPlayers()) do if p ~= LocalPlayer and p.Character then local hl = p.Character:FindFirstChild("ESP_Chams") if hl then hl.OutlineTransparency = v end end end end)
TabContents["Chams"].scroll.CanvasSize = UDim2.new(0, 0, 0, y + 20)

y = 10
inner = TabContents["Aimbot"].inner
y = CreateSection(inner, L.Aimbot, y)
y, _ = CreateToggle(inner, L.Enabled, y, Settings.Aimbot.Enabled, function(s) Settings.Aimbot.Enabled = s end)
y, _ = CreateDropdown(inner, L.TargetPart, {"Head", "HumanoidRootPart", "UpperTorso"}, y, 1, function(o) Settings.Aimbot.TargetPart = o end)
y, _ = CreateToggle(inner, L.UnlockFOV, y, Settings.Aimbot.UnlockFOV, function(s) Settings.Aimbot.UnlockFOV = s end)
y, _ = CreateToggle(inner, L.AutoShoot, y, Settings.Aimbot.AutoShoot, function(s) Settings.Aimbot.AutoShoot = s end)
y, _ = CreateToggle(inner, L.SilentAim, y, Settings.Aimbot.SilentAim, function(s) Settings.Aimbot.SilentAim = s end)
y = CreateSlider(inner, L.FOVSize, 50, 800, Settings.Aimbot.FOV, y, function(v) Settings.Aimbot.FOV = v end)
y = CreateSlider(inner, L.Smoothness, 1, 20, Settings.Aimbot.Smoothness, y, function(v) Settings.Aimbot.Smoothness = v end)
y, _ = CreateDropdown(inner, L.FOVColor, {"Red", "Green", "Blue", "White", "Yellow", "Purple", "Cyan"}, y, 1, function(o) Settings.Aimbot.FOVColor = ColorPresets[o] or Color3.fromRGB(255, 60, 60) end)
TabContents["Aimbot"].scroll.CanvasSize = UDim2.new(0, 0, 0, y + 20)

y = 10
inner = TabContents["KillAura"].inner
y = CreateSection(inner, L.KillAura, y)
y, _ = CreateToggle(inner, L.Enabled, y, Settings.KillAura.Enabled, function(s) Settings.KillAura.Enabled = s end)
y, _ = CreateDropdown(inner, L.KATarget, {"Head", "HumanoidRootPart", "UpperTorso"}, y, 1, function(o) Settings.KillAura.TargetPart = o end)
y = CreateSlider(inner, L.KARange, 10, 200, Settings.KillAura.Range, y, function(v) Settings.KillAura.Range = v end)
y, _ = CreateToggle(inner, L.KATeleport, y, Settings.KillAura.Teleport, function(s) Settings.KillAura.Teleport = s end)
y = CreateSlider(inner, "Teleport Height", 5, 50, Settings.KillAura.TeleportHeight, y, function(v) Settings.KillAura.TeleportHeight = v end)
y, _ = CreateToggle(inner, "Aim First", y, Settings.KillAura.AimFirst, function(s) Settings.KillAura.AimFirst = s end)
y, _ = CreateToggle(inner, "Auto Attack", y, Settings.KillAura.AutoAttack, function(s) Settings.KillAura.AutoAttack = s end)
TabContents["KillAura"].scroll.CanvasSize = UDim2.new(0, 0, 0, y + 20)

y = 10
inner = TabContents["Misc"].inner
y = CreateSection(inner, L.Misc .. " - Movement", y)
y, _ = CreateToggle(inner, L.Fly, y, Settings.Misc.Fly, function(s) Settings.Misc.Fly = s if s then StartFly() else StopFly() end end)
y = CreateSlider(inner, L.FlySpeed, 10, 200, Settings.Misc.FlySpeed, y, function(v) Settings.Misc.FlySpeed = v end)
y, _ = CreateToggle(inner, L.NoClip, y, Settings.Misc.NoClip, function(s) Settings.Misc.NoClip = s if s then EnableNoClip() else DisableNoClip() end end)
y, _ = CreateToggle(inner, L.Speed, y, Settings.Misc.Speed, function(s) Settings.Misc.Speed = s UpdateSpeed() end)
y = CreateSlider(inner, L.SpeedVal, 16, 200, Settings.Misc.SpeedVal, y, function(v) Settings.Misc.SpeedVal = v UpdateSpeed() end)
y, _ = CreateToggle(inner, L.JumpPower, y, Settings.Misc.JumpPower, function(s) Settings.Misc.JumpPower = s UpdateJump() end)
y = CreateSlider(inner, L.JumpVal, 50, 300, Settings.Misc.JumpVal, y, function(v) Settings.Misc.JumpVal = v UpdateJump() end)
y, _ = CreateToggle(inner, L.InfJump, y, Settings.Misc.InfJump, function(s) Settings.Misc.InfJump = s end)
y, _ = CreateToggle(inner, L.Gravity, y, Settings.Misc.Gravity, function(s) Settings.Misc.Gravity = s UpdateGravity() end)
y = CreateSlider(inner, L.GravVal, 10, 196, Settings.Misc.GravVal, y, function(v) Settings.Misc.GravVal = v UpdateGravity() end)

y = CreateSection(inner, L.Misc .. " - Performance", y + 5)
y, _ = CreateToggle(inner, L.FPBoost, y, Settings.Misc.FPBoost, function(s) Settings.Misc.FPBoost = s ApplyPerformance() end)
y, _ = CreateToggle(inner, L.PingBoost, y, Settings.Misc.PingBoost, function(s) Settings.Misc.PingBoost = s ApplyPerformance() end)
y, _ = CreateToggle(inner, L.NoFog, y, Settings.Misc.NoFog, function(s) Settings.Misc.NoFog = s Lighting.FogEnd = s and 9999999 or 10000 end)
y, _ = CreateToggle(inner, L.NoShadows, y, Settings.Misc.NoShadows, function(s) Settings.Misc.NoShadows = s Lighting.GlobalShadows = not s end)
y, _ = CreateToggle(inner, L.LowGraphics, y, Settings.Misc.LowGraphics, function(s) Settings.Misc.LowGraphics = s ApplyPerformance() end)

y = CreateSection(inner, L.Misc .. " - Visual", y + 5)
y, _ = CreateToggle(inner, L.Crosshair, y, Settings.Misc.Crosshair, function(s) Settings.Misc.Crosshair = s end)
y = CreateSlider(inner, L.CrosshairSize, 5, 40, Settings.Misc.CrosshairSize, y, function(v) Settings.Misc.CrosshairSize = v end)
y = CreateSlider(inner, L.CrosshairThick, 1, 5, Settings.Misc.CrosshairThick, y, function(v) Settings.Misc.CrosshairThick = v end)
y = CreateSlider(inner, L.CrosshairGap, 5, 30, Settings.Misc.CrosshairGap, y, function(v) Settings.Misc.CrosshairGap = v end)
y, _ = CreateToggle(inner, L.ZoomHack, y, Settings.Misc.ZoomHack, function(s) Settings.Misc.ZoomHack = s end)
y, _ = CreateToggle(inner, L.FOVChanger, y, Settings.Misc.FOVChanger, function(s) Settings.Misc.FOVChanger = s if s then Camera.FieldOfView = Settings.Misc.FOVVal else Camera.FieldOfView = 70 end end)
y = CreateSlider(inner, "FOV Value", 30, 120, Settings.Misc.FOVVal, y, function(v) Settings.Misc.FOVVal = v if Settings.Misc.FOVChanger then Camera.FieldOfView = v end end)
y, _ = CreateToggle(inner, L.ThirdPerson, y, Settings.Misc.ThirdPerson, function(s)
    Settings.Misc.ThirdPerson = s
    if LocalPlayer.Character then local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid") if hum then hum.CameraOffset = s and Vector3.new(0, 2, Settings.Misc.TPdist) or Vector3.new(0, 0, 0) end end
end)
y = CreateSlider(inner, L.TPdist, 2, 20, Settings.Misc.TPdist, y, function(v) Settings.Misc.TPdist = v if Settings.Misc.ThirdPerson and LocalPlayer.Character then local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid") if hum then hum.CameraOffset = Vector3.new(0, 2, v) end end end)
y, _ = CreateToggle(inner, L.Fullbright, y, Settings.Misc.Fullbright, function(s) Settings.Misc.Fullbright = s if s then Lighting.Brightness = 3 Lighting.ClockTime = 14 else Lighting.Brightness = 1 end end)
y, _ = CreateToggle(inner, L.NoRecoil, y, Settings.Misc.NoRecoil, function(s) Settings.Misc.NoRecoil = s end)
y, _ = CreateToggle(inner, L.NoSpread, y, Settings.Misc.NoSpread, function(s) Settings.Misc.NoSpread = s end)
TabContents["Misc"].scroll.CanvasSize = UDim2.new(0, 0, 0, y + 20)

y = 10
inner = TabContents["Settings"].inner
y = CreateSection(inner, L.Settings, y)
y, _ = CreateDropdown(inner, L.Language, {"RU", "EN", "UA"}, y, 1, function(o) Lang.Current = o L = GetLang() LangBtn.Text = o end)
TabContents["Settings"].scroll.CanvasSize = UDim2.new(0, 0, 0, y + 20)

local Watermark = Instance.new("TextLabel") Watermark.Size = UDim2.new(0, 250, 0, 32) Watermark.Position = UDim2.new(1, -260, 0, 10)
Watermark.BackgroundColor3 = Color3.fromRGB(0, 0, 0) Watermark.BackgroundTransparency = 0.5 Watermark.BorderSizePixel = 0
Watermark.Text = "NOOBS COCO😈 | ULTIMATE+++" Watermark.TextColor3 = Color3.fromRGB(255, 70, 70)
Watermark.Font = Enum.Font.GothamBold Watermark.TextSize = 14 Watermark.ZIndex = 20 Watermark.Parent = ScreenGui
Instance.new("UICorner", Watermark).CornerRadius = UDim.new(0, 6)

function ApplyPerformance()
    if Settings.Misc.FPBoost or Settings.Misc.PingBoost then
        pcall(function() settings().Rendering.QualityLevel = Settings.Misc.LowGraphics and 1 or 7 settings().Rendering.EnableFRM = Settings.Misc.FPBoost end)
    end
    if Settings.Misc.LowGraphics then
        pcall(function() for _, v in pairs(workspace:GetDescendants()) do if v:IsA("BasePart") and v.Material == Enum.Material.Grass then v.Material = Enum.Material.SmoothPlastic end end end)
    end
    Lighting.GlobalShadows = not Settings.Misc.NoShadows
end

function CreateESP(player)
    if ESPData[player] then
        if ESPData[player].Conn then ESPData[player].Conn:Disconnect() end
        if ESPData[player].Lines then for _, l in pairs(ESPData[player].Lines) do if l.Remove then l:Remove() end end end
        if ESPData[player].Texts then for _, t in pairs(ESPData[player].Texts) do if t.Remove then t:Remove() end end end
        if ESPData[player].HealthBar then ESPData[player].HealthBar.bg:Remove() ESPData[player].HealthBar.fill:Remove() end
        if ESPData[player].SkeletonLines then for _, l in pairs(ESPData[player].SkeletonLines) do if l.Remove then l:Remove() end end end
    end
    ESPData[player] = {Lines = {}, Texts = {}, SkeletonLines = {}}
    local lines = {} for i = 1, 12 do local l = Drawing.new("Line") l.Visible = false lines[i] = l end
    local skLines = {} for i = 1, 14 do local l = Drawing.new("Line") l.Visible = false l.Thickness = 1.5 skLines[i] = l end
    local nameText = Drawing.new("Text") nameText.Visible = false nameText.Center = true nameText.Size = 15 nameText.Font = 3 nameText.Outline = true nameText.OutlineColor = Color3.fromRGB(0,0,0)
    local distText = Drawing.new("Text") distText.Visible = false distText.Center = true distText.Size = 13 distText.Font = 3 distText.Outline = true distText.OutlineColor = Color3.fromRGB(0,0,0)
    local hbg = Drawing.new("Square") hbg.Visible = false hbg.Filled = true hbg.Color = Color3.fromRGB(15,15,15) hbg.Transparency = 0.35
    local hfill = Drawing.new("Square") hfill.Visible = false hfill.Filled = true
    ESPData[player].Lines = lines ESPData[player].SkeletonLines = skLines ESPData[player].Texts = {nameText, distText} ESPData[player].HealthBar = {bg = hbg, fill = hfill}
    
    ESPData[player].Conn = RunService.RenderStepped:Connect(function()
        local char = player.Character
        if not char then for _, l in pairs(lines) do l.Visible = false end for _, l in pairs(skLines) do l.Visible = false end nameText.Visible = false distText.Visible = false hbg.Visible = false hfill.Visible = false return end
        local head = char:FindFirstChild("Head") local root = char:FindFirstChild("HumanoidRootPart") local hum = char:FindFirstChildOfClass("Humanoid")
        if not head or not root or not hum or hum.Health <= 0 then for _, l in pairs(lines) do l.Visible = false end for _, l in pairs(skLines) do l.Visible = false end nameText.Visible = false distText.Visible = false hbg.Visible = false hfill.Visible = false return end
        if not Settings.ESP.Enabled then for _, l in pairs(lines) do l.Visible = false end for _, l in pairs(skLines) do l.Visible = false end nameText.Visible = false distText.Visible = false hbg.Visible = false hfill.Visible = false return end
        
        local headPos, rootPos = head.Position, root.Position
        local height = math.abs(headPos.Y - rootPos.Y) * 2.2
        local centerPos = rootPos + Vector3.new(0, height/2 - 1.5, 0)
        local topPoint = headPos + Vector3.new(0, 0.5, 0) local bottomPoint = rootPos - Vector3.new(0, 2, 0)
        local topScreen, topVis = Camera:WorldToViewportPoint(topPoint) local bottomScreen, bottomVis = Camera:WorldToViewportPoint(bottomPoint)
        if not topVis and not bottomVis then for _, l in pairs(lines) do l.Visible = false end nameText.Visible = false distText.Visible = false hbg.Visible = false hfill.Visible = false return end
        
        local dist = (Camera.CFrame.Position - centerPos).Magnitude local boxWidth = (2.5 / dist) * 500 local boxHeight = math.abs(topScreen.Y - bottomScreen.Y)
        local centerScreen, centerVis = Camera:WorldToViewportPoint(centerPos)
        if not centerVis then for _, l in pairs(lines) do l.Visible = false end nameText.Visible = false distText.Visible = false hbg.Visible = false hfill.Visible = false return end
        
        local leftX = centerScreen.X - boxWidth/2 local rightX = centerScreen.X + boxWidth/2
        local color = Settings.ESP.ColorPreset == "Rainbow" and Color3.fromHSV(tick() % 5 / 5, 1, 1) or (ColorPresets[Settings.ESP.ColorPreset] or ColorPresets.White)
        local topY, bottomY = topScreen.Y, bottomScreen.Y
        
        for i=1,12 do lines[i].Visible = false end
        for i=1,14 do skLines[i].Visible = false end
        
        if Settings.ESP.BoxType == "Full" or Settings.ESP.BoxType == "Corner+Full" then
            lines[1].From = Vector2.new(leftX, topY) lines[1].To = Vector2.new(rightX, topY) lines[1].Visible = true
            lines[2].From = Vector2.new(rightX, topY) lines[2].To = Vector2.new(rightX, bottomY) lines[2].Visible = true
            lines[3].From = Vector2.new(rightX, bottomY) lines[3].To = Vector2.new(leftX, bottomY) lines[3].Visible = true
            lines[4].From = Vector2.new(leftX, bottomY) lines[4].To = Vector2.new(leftX, topY) lines[4].Visible = true
            for i=1,4 do lines[i].Color = color lines[i].Thickness = Settings.ESP.Thickness lines[i].Transparency = Settings.ESP.Transparency end
        end
        
        if Settings.ESP.BoxType == "Corner" or Settings.ESP.BoxType == "Corner+Full" then
            local cs = math.min(boxWidth * 0.3, boxWidth * 0.4)
            lines[5].From = Vector2.new(leftX, topY) lines[5].To = Vector2.new(leftX + cs, topY) lines[5].Visible = true
            lines[6].From = Vector2.new(leftX, topY) lines[6].To = Vector2.new(leftX, topY + cs) lines[6].Visible = true
            lines[7].From = Vector2.new(rightX, topY) lines[7].To = Vector2.new(rightX - cs, topY) lines[7].Visible = true
            lines[8].From = Vector2.new(rightX, topY) lines[8].To = Vector2.new(rightX, topY + cs) lines[8].Visible = true
            lines[9].From = Vector2.new(rightX, bottomY) lines[9].To = Vector2.new(rightX - cs, bottomY) lines[9].Visible = true
            lines[10].From = Vector2.new(rightX, bottomY) lines[10].To = Vector2.new(rightX, bottomY - cs) lines[10].Visible = true
            lines[11].From = Vector2.new(leftX, bottomY) lines[11].To = Vector2.new(leftX + cs, bottomY) lines[11].Visible = true
            lines[12].From = Vector2.new(leftX, bottomY) lines[12].To = Vector2.new(leftX, bottomY - cs) lines[12].Visible = true
            for i=5,12 do lines[i].Color = color lines[i].Thickness = Settings.ESP.Thickness + 1 lines[i].Transparency = Settings.ESP.Transparency end
        end
        
        if Settings.ESP.Skeleton then
            local parts = {
                {head, char:FindFirstChild("UpperTorso") or char:FindFirstChild("Torso")},
                {char:FindFirstChild("UpperTorso") or char:FindFirstChild("Torso"), char:FindFirstChild("RightUpperArm") or char:FindFirstChild("Right Arm")},
                {char:FindFirstChild("RightUpperArm") or char:FindFirstChild("Right Arm"), char:FindFirstChild("RightHand") or char:FindFirstChild("RightHand")},
                {char:FindFirstChild("UpperTorso") or char:FindFirstChild("Torso"), char:FindFirstChild("LeftUpperArm") or char:FindFirstChild("Left Arm")},
                {char:FindFirstChild("LeftUpperArm") or char:FindFirstChild("Left Arm"), char:FindFirstChild("LeftHand") or char:FindFirstChild("LeftHand")},
                {char:FindFirstChild("UpperTorso") or char:FindFirstChild("Torso"), char:FindFirstChild("RightUpperLeg") or char:FindFirstChild("Right Leg")},
                {char:FindFirstChild("RightUpperLeg") or char:FindFirstChild("Right Leg"), char:FindFirstChild("RightFoot") or char:FindFirstChild("RightFoot")},
                {char:FindFirstChild("UpperTorso") or char:FindFirstChild("Torso"), char:FindFirstChild("LeftUpperLeg") or char:FindFirstChild("Left Leg")},
                {char:FindFirstChild("LeftUpperLeg") or char:FindFirstChild("Left Leg"), char:FindFirstChild("LeftFoot") or char:FindFirstChild("LeftFoot")}
            }
            for i, pair in ipairs(parts) do
                if pair[1] and pair[2] then
                    local p1, v1 = Camera:WorldToViewportPoint(pair[1].Position) local p2, v2 = Camera:WorldToViewportPoint(pair[2].Position)
                    if v1 and v2 then skLines[i].From = Vector2.new(p1.X, p1.Y) skLines[i].To = Vector2.new(p2.X, p2.Y) skLines[i].Color = color skLines[i].Visible = true skLines[i].Transparency = Settings.ESP.Transparency end
                end
            end
        end
        
        nameText.Visible = Settings.ESP.Name
        if Settings.ESP.Name then nameText.Text = player.Name nameText.Position = Vector2.new(centerScreen.X, topY - 22) nameText.Color = Color3.fromRGB(255,255,255) end
        distText.Visible = Settings.ESP.Distance
        if Settings.ESP.Distance then distText.Text = math.floor(dist) .. "m" distText.Position = Vector2.new(centerScreen.X, bottomY + 7) distText.Color = Color3.fromRGB(255,255,255) end
        hbg.Visible = Settings.ESP.HealthBar hfill.Visible = Settings.ESP.HealthBar
        if Settings.ESP.HealthBar then
            local health = hum.Health / hum.MaxHealth local barW = 3 local barH = boxHeight local barX = leftX - barW - 4
            hbg.Size = Vector2.new(barW, barH) hbg.Position = Vector2.new(barX, topY)
            hfill.Size = Vector2.new(barW, barH * health) hfill.Position = Vector2.new(barX, topY + barH * (1 - health)) hfill.Color = Color3.fromHSV(health * 0.33, 1, 1)
        end
    end)
end

function ApplyChams(player)
    if not player.Character then return end
    local char = player.Character local old = char:FindFirstChild("ESP_Chams") if old then old:Destroy() end
    if ESPData[player] and ESPData[player].RC then ESPData[player].RC:Disconnect() end
    local hl = Instance.new("Highlight") hl.Name = "ESP_Chams" hl.Enabled = Settings.Chams.Enabled hl.FillTransparency = Settings.Chams.FillTransparency hl.OutlineTransparency = Settings.Chams.OutlineTransparency hl.Adornee = char hl.Parent = char
    if Settings.Chams.ColorPreset ~= "Rainbow" then local col = ColorPresets[Settings.Chams.ColorPreset] or ColorPresets.Red hl.FillColor = col hl.OutlineColor = col
    else hl.FillColor = Color3.new(1,1,1) hl.OutlineColor = Color3.new(1,1,1)
        ESPData[player] = ESPData[player] or {}
        ESPData[player].RC = RunService.RenderStepped:Connect(function()
            if not hl or not hl.Parent then ESPData[player].RC:Disconnect() return end
            if Settings.Chams.Enabled and Settings.Chams.ColorPreset == "Rainbow" then local rc = Color3.fromHSV(tick() % 5 / 5, 1, 1) hl.FillColor = rc hl.OutlineColor = rc end end)
    end
end

-- УЛУЧШЕННЫЙ АИМБОТ С SILENT AIM
local function GetClosestPlayerToCenter()
    local closest, minDist = nil, Settings.Aimbot.FOV
    for _, p in pairs(Players:GetPlayers()) do
        if p == LocalPlayer or not p.Character then continue end
        local tp = p.Character:FindFirstChild(Settings.Aimbot.TargetPart) local hum = p.Character:FindFirstChildOfClass("Humanoid")
        if not tp or not hum or hum.Health <= 0 then continue end
        local sp, vis = Camera:WorldToViewportPoint(tp.Position)
        if not Settings.Aimbot.UnlockFOV and not vis then continue end
        local sc = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
        local d = (Vector2.new(sp.X, sp.Y) - sc).Magnitude
        if d < minDist then
            local ro = Camera.CFrame.Position local rd = (tp.Position - ro).Unit * 1000
            local rp = RaycastParams.new() rp.FilterType = Enum.RaycastFilterType.Blacklist rp.FilterDescendantsInstances = {LocalPlayer.Character}
            local rr = workspace:Raycast(ro, rd, rp)
            if rr and rr.Instance:IsDescendantOf(p.Character) then minDist = d closest = p end
        end
    end
    return closest
end

-- KILL AURA - преследование и убийство
local function ProcessKillAura()
    if not Settings.KillAura.Enabled then return end
    local char = LocalPlayer.Character if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart") local hum = char:FindFirstChildOfClass("Humanoid")
    if not root or not hum or hum.Health <= 0 then return end
    
    local bestTarget, shortestDist = nil, Settings.KillAura.Range
    for _, p in pairs(Players:GetPlayers()) do
        if p == LocalPlayer or not p.Character then continue end
        local targetHum = p.Character:FindFirstChildOfClass("Humanoid")
        if not targetHum or targetHum.Health <= 0 then continue end
        local targetRoot = p.Character:FindFirstChild("HumanoidRootPart")
        if not targetRoot then continue end
        local dist = (root.Position - targetRoot.Position).Magnitude
        if dist < shortestDist then
            -- Проверка видимости
            local ro = root.Position local rd = (targetRoot.Position - ro).Unit * dist
            local rp = RaycastParams.new() rp.FilterType = Enum.RaycastFilterType.Blacklist rp.FilterDescendantsInstances = {char}
            local rr = workspace:Raycast(ro, rd, rp)
            if not rr or rr.Instance:IsDescendantOf(p.Character) then
                shortestDist = dist bestTarget = p
            end
        end
    end
    
    if bestTarget and bestTarget.Character then
        local targetChar = bestTarget.Character
        local targetPart = targetChar:FindFirstChild(Settings.KillAura.TargetPart) or targetChar:FindFirstChild("Head")
        local targetHum = targetChar:FindFirstChildOfClass("Humanoid")
        
        if targetPart and targetHum and targetHum.Health > 0 then
            -- Телепорт сверху если включен
            if Settings.KillAura.Teleport then
                local teleportPos = targetPart.Position + Vector3.new(0, Settings.KillAura.TeleportHeight, 0)
                root.CFrame = CFrame.new(teleportPos)
                task.wait(0.05)
            end
            
            -- Прицеливание
            if Settings.KillAura.AimFirst then
                Camera.CFrame = CFrame.new(Camera.CFrame.Position, targetPart.Position)
            end
            
            -- Атака
            if Settings.KillAura.AutoAttack then
                local tool = char:FindFirstChildOfClass("Tool")
                if tool then
                    tool:Activate()
                    task.wait(0.1)
                    if tool.Parent then tool:Deactivate() end
                else
                    -- Если нет инструмента, используем mouse1click
                    task.spawn(function() mouse1click() end)
                end
            end
        end
    end
end

-- Главный цикл
RunService.RenderStepped:Connect(function()
    if Settings.Misc.InfJump then
        local char = LocalPlayer.Character if char then local hum = char:FindFirstChildOfClass("Humanoid") if hum then hum.Jump = true end end
    end
    
    if Settings.Misc.NoRecoil then pcall(function() for _, v in pairs(LocalPlayer.Character:GetChildren()) do if v:IsA("Tool") then v.Recoil = 0 end end end) end
    if Settings.Misc.NoSpread then pcall(function() for _, v in pairs(LocalPlayer.Character:GetChildren()) do if v:IsA("Tool") then v.Spread = 0 end end end) end
    
    -- Kill Aura
    ProcessKillAura()
    
    -- Aimbot
    if Settings.Aimbot.Enabled then
        local t = GetClosestPlayerToCenter()
        if t and t.Character then
            local tp = t.Character:FindFirstChild(Settings.Aimbot.TargetPart)
            if tp then
                if Settings.Aimbot.SilentAim then
                    -- Silent Aim через raycast (мгновенно)
                    local ray = Ray.new(Camera.CFrame.Position, (tp.Position - Camera.CFrame.Position).Unit * 1000)
                    -- Мгновенное наведение без движения камеры
                    Camera.CFrame = CFrame.new(Camera.CFrame.Position, tp.Position)
                else
                    local look = CFrame.new(Camera.CFrame.Position, tp.Position)
                    Camera.CFrame = Settings.Aimbot.Smoothness <= 1 and look or Camera.CFrame:Lerp(look, 1/Settings.Aimbot.Smoothness)
                end
                if Settings.Aimbot.AutoShoot then task.spawn(function() mouse1press() end) end
            end
        end
    end
end)

-- Второй цикл для Kill Aura (чаще обновляется)
task.spawn(function()
    while true do
        if Settings.KillAura.Enabled then ProcessKillAura() end
        task.wait(0.05) -- Быстрое обновление для Kill Aura
    end
end)

local CrosshairLines = {}
for i = 1, 4 do local l = Drawing.new("Line") l.Visible = false l.Color = Color3.fromRGB(255, 60, 60) l.Thickness = 2 l.Transparency = 0.5 CrosshairLines[i] = l end

RunService.RenderStepped:Connect(function()
    for _, l in pairs(CrosshairLines) do l.Visible = Settings.Misc.Crosshair end
    if Settings.Misc.Crosshair then
        local cx = Camera.ViewportSize.X / 2 local cy = Camera.ViewportSize.Y / 2
        local s = Settings.Misc.CrosshairSize local g = Settings.Misc.CrosshairGap local t = Settings.Misc.CrosshairThick
        CrosshairLines[1].From = Vector2.new(cx - g, cy) CrosshairLines[1].To = Vector2.new(cx - g - s, cy)
        CrosshairLines[2].From = Vector2.new(cx + g, cy) CrosshairLines[2].To = Vector2.new(cx + g + s, cy)
        CrosshairLines[3].From = Vector2.new(cx, cy - g) CrosshairLines[3].To = Vector2.new(cx, cy - g - s)
        CrosshairLines[4].From = Vector2.new(cx, cy + g) CrosshairLines[4].To = Vector2.new(cx, cy + g + s)
        for _, l in pairs(CrosshairLines) do l.Thickness = t end
    end
end)

local FC = Drawing.new("Circle") FC.Visible = false FC.Thickness = 1.5 FC.NumSides = 100 FC.Transparency = 0.7
RunService.RenderStepped:Connect(function()
    FC.Visible = Settings.Aimbot.Enabled and not Settings.Aimbot.UnlockFOV
    FC.Color = Settings.Aimbot.FOVColor FC.Radius = Settings.Aimbot.FOV FC.Position = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
end)

local FlyConnection, NoClipConnection
function StartFly()
    local char = LocalPlayer.Character if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart") local hum = char:FindFirstChildOfClass("Humanoid")
    if not root or not hum then return end hum.PlatformStand = true
    FlyConnection = RunService.RenderStepped:Connect(function()
        if not Settings.Misc.Fly then StopFly() return end
        local vel = Vector3.new()
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then vel += Camera.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then vel -= Camera.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then vel -= Camera.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then vel += Camera.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then vel += Vector3.new(0, 1, 0) end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then vel -= Vector3.new(0, 1, 0) end
        root.Velocity = vel * Settings.Misc.FlySpeed * 0.5
    end)
end
function StopFly() if FlyConnection then FlyConnection:Disconnect() FlyConnection = nil end
    local char = LocalPlayer.Character if char then local hum = char:FindFirstChildOfClass("Humanoid") if hum then hum.PlatformStand = false end end end
end

function EnableNoClip()
    NoClipConnection = RunService.Stepped:Connect(function()
        if LocalPlayer.Character then for _, part in pairs(LocalPlayer.Character:GetDescendants()) do if part:IsA("BasePart") and part.CanCollide then part.CanCollide = false end end end
    end)
end
function DisableNoClip() if NoClipConnection then NoClipConnection:Disconnect() NoClipConnection = nil end
    if LocalPlayer.Character then for _, part in pairs(LocalPlayer.Character:GetDescendants()) do if part:IsA("BasePart") then part.CanCollide = true end end end
end

function UpdateSpeed()
    local char = LocalPlayer.Character if not char then return end local hum = char:FindFirstChildOfClass("Humanoid") if not hum then return end
    hum.WalkSpeed = Settings.Misc.Speed and Settings.Misc.SpeedVal or 16
end
function UpdateJump()
    local char = LocalPlayer.Character if not char then return end local hum = char:FindFirstChildOfClass("Humanoid") if not hum then return end
    hum.UseJumpPower = true hum.JumpPower = Settings.Misc.JumpPower and Settings.Misc.JumpVal or 50
end
function UpdateGravity() workspace.Gravity = Settings.Misc.Gravity and Settings.Misc.GravVal / 196.2 * 196.2 or 196.2 end

local function OnPlayerAdded(player)
    if player == LocalPlayer then return end
    player.CharacterAdded:Connect(function() task.wait(0.3) CreateESP(player) ApplyChams(player) end)
    if player.Character then CreateESP(player) ApplyChams(player) end
end
for _, p in pairs(Players:GetPlayers()) do if p ~= LocalPlayer then OnPlayerAdded(p) end end
Players.PlayerAdded:Connect(OnPlayerAdded)
Players.PlayerRemoving:Connect(function(p)
    if ESPData[p] then
        if ESPData[p].Conn then ESPData[p].Conn:Disconnect() end
        if ESPData[p].RC then ESPData[p].RC:Disconnect() end
        if ESPData[p].Lines then for _, l in pairs(ESPData[p].Lines) do if l.Remove then l:Remove() end end end
        if ESPData[p].SkeletonLines then for _, l in pairs(ESPData[p].SkeletonLines) do if l.Remove then l:Remove() end end end
        if ESPData[p].Texts then for _, t in pairs(ESPData[p].Texts) do if t.Remove then t:Remove() end end end
        if ESPData[p].HealthBar then ESPData[p].HealthBar.bg:Remove() ESPData[p].HealthBar.fill:Remove() end
        ESPData[p] = nil
    end
end)

UserInputService.InputBegan:Connect(function(input, gp)
    if not gp and input.KeyCode == Enum.KeyCode.V then MainFrame.Visible = not MainFrame.Visible end
    if Settings.Misc.ZoomHack and input.UserInputType == Enum.UserInputType.MouseButton2 then Camera.FieldOfView = 20
        input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then Camera.FieldOfView = Settings.Misc.FOVChanger and Settings.Misc.FOVVal or 70 end end)
    end
end)

LocalPlayer.CharacterAdded:Connect(function() task.wait(0.5) UpdateSpeed() UpdateJump() UpdateGravity() ApplyPerformance() end)
if LocalPlayer.Character then UpdateSpeed() UpdateJump() UpdateGravity() ApplyPerformance() end

print("✅ NOOBS COCO😈 ULTIMATE+++ loaded!")
print("🔥 ESP | Chams | Aimbot | Silent Aim | KILL AURA | Fly | NoClip | FPS Boost")
