local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local Lighting = game:GetService("Lighting")
local VirtualInputManager = game:GetService("VirtualInputManager")

local Settings = {
    ESP = {Enabled = false, Color = "White", Thickness = 2, Transparency = 0.8, BoxType = "Corner", Name = true, Distance = true, HealthBar = true},
    Chams = {Enabled = false, Color = "Red", FillTrans = 0.5, OutlineTrans = 0.3},
    Aimbot = {Enabled = false, FOV = 200, Smoothness = 3, TargetPart = "Head", UnlockFOV = false, AutoShoot = false, SilentAim = false},
    KillAura = {Enabled = false, Range = 50, TargetPart = "Head", Teleport = true, TeleportHeight = 15, AutoAttack = true},
    Misc = {Fly = false, FlySpeed = 50, NoClip = false, Speed = false, SpeedVal = 50, JumpPower = false, JumpVal = 100, InfJump = false, Gravity = false, GravVal = 50, Fullbright = false, NoRecoil = false, NoSpread = false, FOVChanger = false, FOVVal = 90}
}

local Colors = {
    White = Color3.fromRGB(255, 255, 255), Red = Color3.fromRGB(255, 50, 50),
    Green = Color3.fromRGB(50, 255, 50), Blue = Color3.fromRGB(50, 50, 255),
    LightBlue = Color3.fromRGB(100, 180, 255), Purple = Color3.fromRGB(200, 50, 255),
    Yellow = Color3.fromRGB(255, 255, 50), Orange = Color3.fromRGB(255, 150, 0),
    Pink = Color3.fromRGB(255, 100, 200), Cyan = Color3.fromRGB(0, 255, 255), Gray = Color3.fromRGB(160, 160, 160)
}

local ESPData = {}

-- Функция безопасного клика
local function clickMouse()
    pcall(function()
        VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 0)
        task.wait(0.05)
        VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 0)
    end)
end

-- GUI
local gui = Instance.new("ScreenGui", CoreGui)
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 310, 0, 530)
main.Position = UDim2.new(0.5, -155, 0.12, 0)
main.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.Visible = true

local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1, 0, 0, 38)
title.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
title.Text = "NOOBS COCO😈"
title.TextColor3 = Color3.fromRGB(255, 60, 60)
title.Font = Enum.Font.GothamBold
title.TextSize = 19

local scroll = Instance.new("ScrollingFrame", main)
scroll.Size = UDim2.new(1, 0, 1, -38)
scroll.Position = UDim2.new(0, 0, 0, 38)
scroll.BackgroundTransparency = 1
scroll.BorderSizePixel = 0
scroll.ScrollBarThickness = 4
scroll.CanvasSize = UDim2.new(0, 0, 0, 1400)

local content = Instance.new("Frame", scroll)
content.Size = UDim2.new(1, 0, 0, 1400)
content.BackgroundTransparency = 1

local yPos = 5

local function section(name)
    local s = Instance.new("Frame", content)
    s.Size = UDim2.new(1, -16, 0, 30)
    s.Position = UDim2.new(0, 8, 0, yPos)
    s.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    s.BorderSizePixel = 0
    local l = Instance.new("TextLabel", s)
    l.Size = UDim2.new(1, 0, 1, 0)
    l.BackgroundTransparency = 1
    l.Text = "  " .. name
    l.TextColor3 = Color3.fromRGB(255, 80, 80)
    l.Font = Enum.Font.GothamBold
    l.TextSize = 13
    l.TextXAlignment = Enum.TextXAlignment.Left
    yPos = yPos + 34
end

local function toggle(text, def, cb)
    local f = Instance.new("Frame", content)
    f.Size = UDim2.new(1, -16, 0, 30)
    f.Position = UDim2.new(0, 8, 0, yPos)
    f.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
    f.BorderSizePixel = 0
    local l = Instance.new("TextLabel", f)
    l.Size = UDim2.new(0.6, 0, 1, 0)
    l.BackgroundTransparency = 1
    l.Text = "  " .. text
    l.TextColor3 = Color3.fromRGB(200, 200, 200)
    l.Font = Enum.Font.Gotham
    l.TextSize = 12
    l.TextXAlignment = Enum.TextXAlignment.Left
    local b = Instance.new("TextButton", f)
    b.Size = UDim2.new(0, 55, 0, 22)
    b.Position = UDim2.new(1, -63, 0.5, -11)
    b.BackgroundColor3 = def and Color3.fromRGB(40, 200, 40) or Color3.fromRGB(70, 70, 75)
    b.BorderSizePixel = 0
    b.Text = def and "ON" or "OFF"
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.Font = Enum.Font.GothamBold
    b.TextSize = 10
    b.AutoButtonColor = false
    local state = def
    b.MouseButton1Click:Connect(function()
        state = not state
        b.Text = state and "ON" or "OFF"
        b.BackgroundColor3 = state and Color3.fromRGB(40, 200, 40) or Color3.fromRGB(70, 70, 75)
        cb(state)
    end)
    yPos = yPos + 33
end

local function dropdown(text, opts, defIdx, cb)
    local f = Instance.new("Frame", content)
    f.Size = UDim2.new(1, -16, 0, 60)
    f.Position = UDim2.new(0, 8, 0, yPos)
    f.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
    f.BorderSizePixel = 0
    local l = Instance.new("TextLabel", f)
    l.Size = UDim2.new(1, -16, 0, 20)
    l.Position = UDim2.new(0, 8, 0, 5)
    l.BackgroundTransparency = 1
    l.Text = text
    l.TextColor3 = Color3.fromRGB(170, 170, 170)
    l.Font = Enum.Font.Gotham
    l.TextSize = 11
    l.TextXAlignment = Enum.TextXAlignment.Left
    local b = Instance.new("TextButton", f)
    b.Size = UDim2.new(1, -16, 0, 26)
    b.Position = UDim2.new(0, 8, 0, 28)
    b.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
    b.BorderSizePixel = 0
    b.Text = opts[defIdx]
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.Font = Enum.Font.Gotham
    b.TextSize = 11
    b.AutoButtonColor = false
    local idx = defIdx
    b.MouseButton1Click:Connect(function()
        idx = idx % #opts + 1
        b.Text = opts[idx]
        cb(opts[idx])
    end)
    yPos = yPos + 63
end

local function slider(text, min, max, def, cb)
    local f = Instance.new("Frame", content)
    f.Size = UDim2.new(1, -16, 0, 55)
    f.Position = UDim2.new(0, 8, 0, yPos)
    f.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
    f.BorderSizePixel = 0
    local l = Instance.new("TextLabel", f)
    l.Size = UDim2.new(1, -16, 0, 20)
    l.Position = UDim2.new(0, 8, 0, 5)
    l.BackgroundTransparency = 1
    l.Text = text .. ": " .. string.format("%.1f", def)
    l.TextColor3 = Color3.fromRGB(170, 170, 170)
    l.Font = Enum.Font.Gotham
    l.TextSize = 11
    l.TextXAlignment = Enum.TextXAlignment.Left
    local bar = Instance.new("TextButton", f)
    bar.Size = UDim2.new(1, -16, 0, 16)
    bar.Position = UDim2.new(0, 8, 0, 30)
    bar.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
    bar.BorderSizePixel = 0
    bar.Text = ""
    bar.AutoButtonColor = false
    local fill = Instance.new("Frame", bar)
    fill.Size = UDim2.new((def - min) / (max - min), 0, 1, 0)
    fill.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
    fill.BorderSizePixel = 0
    local val = def
    local drag = false
    local function upd()
        local mp = UserInputService:GetMouseLocation()
        local rx = math.clamp((mp.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
        val = min + (max - min) * rx
        fill.Size = UDim2.new(rx, 0, 1, 0)
        l.Text = text .. ": " .. string.format("%.1f", val)
        cb(val)
    end
    bar.MouseButton1Down:Connect(function() drag = true upd() end)
    UserInputService.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement and drag then upd() end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then drag = false end
    end)
    yPos = yPos + 58
end

-- BUILD MENU
section("🔲 ESP")
toggle("Enabled", false, function(s) Settings.ESP.Enabled = s end)
dropdown("Box Type", {"Corner", "Full", "Corner+Full"}, 1, function(o) Settings.ESP.BoxType = o end)
dropdown("Color", {"White", "Red", "Green", "Blue", "LightBlue", "Purple", "Yellow", "Orange", "Pink", "Cyan", "Rainbow"}, 1, function(o) Settings.ESP.Color = o end)
slider("Thickness", 1, 6, 2, function(v) Settings.ESP.Thickness = v end)
slider("Transparency", 0, 1, 0.8, function(v) Settings.ESP.Transparency = v end)
toggle("Show Name", true, function(s) Settings.ESP.Name = s end)
toggle("Show Distance", true, function(s) Settings.ESP.Distance = s end)
toggle("Health Bar", true, function(s) Settings.ESP.HealthBar = s end)

section("🎨 CHAMS")
toggle("Enabled", false, function(s) Settings.Chams.Enabled = s
    for _, p in pairs(Players:GetPlayers()) do if p ~= LocalPlayer and p.Character then local hl = p.Character:FindFirstChild("EC") if hl then hl.Enabled = s elseif s then applyChams(p) end end end
end)
dropdown("Color", {"Red", "Green", "Blue", "Purple", "Yellow", "Orange", "Pink", "Cyan", "Rainbow"}, 1, function(o) Settings.Chams.Color = o end)
slider("Fill Trans", 0, 1, 0.5, function(v) Settings.Chams.FillTrans = v end)
slider("Outline Trans", 0, 1, 0.3, function(v) Settings.Chams.OutlineTrans = v end)

section("🎯 AIMBOT")
toggle("Enabled", false, function(s) Settings.Aimbot.Enabled = s end)
dropdown("Target", {"Head", "HumanoidRootPart", "UpperTorso"}, 1, function(o) Settings.Aimbot.TargetPart = o end)
toggle("Unlock FOV", false, function(s) Settings.Aimbot.UnlockFOV = s end)
toggle("Auto Shoot", false, function(s) Settings.Aimbot.AutoShoot = s end)
toggle("Silent Aim", false, function(s) Settings.Aimbot.SilentAim = s end)
slider("FOV", 50, 800, 200, function(v) Settings.Aimbot.FOV = v end)
slider("Smoothness", 1, 20, 3, function(v) Settings.Aimbot.Smoothness = v end)

section("💀 KILL AURA")
toggle("Enabled", false, function(s) Settings.KillAura.Enabled = s end)
dropdown("Target", {"Head", "HumanoidRootPart", "UpperTorso"}, 1, function(o) Settings.KillAura.TargetPart = o end)
slider("Range", 10, 200, 50, function(v) Settings.KillAura.Range = v end)
toggle("Teleport", true, function(s) Settings.KillAura.Teleport = s end)
slider("Height", 5, 50, 15, function(v) Settings.KillAura.TeleportHeight = v end)
toggle("Auto Attack", true, function(s) Settings.KillAura.AutoAttack = s end)

section("⚡ MISC")
toggle("Fly", false, function(s) Settings.Misc.Fly = s if s then startFly() else stopFly() end end)
slider("Fly Speed", 10, 200, 50, function(v) Settings.Misc.FlySpeed = v end)
toggle("NoClip", false, function(s) Settings.Misc.NoClip = s if s then enableNC() else disableNC() end end)
toggle("Speed", false, function(s) Settings.Misc.Speed = s updSpeed() end)
slider("Speed Val", 16, 200, 50, function(v) Settings.Misc.SpeedVal = v updSpeed() end)
toggle("Jump", false, function(s) Settings.Misc.JumpPower = s updJump() end)
slider("Jump Val", 50, 300, 100, function(v) Settings.Misc.JumpVal = v updJump() end)
toggle("Inf Jump", false, function(s) Settings.Misc.InfJump = s end)
toggle("Gravity", false, function(s) Settings.Misc.Gravity = s updGrav() end)
slider("Grav Val", 10, 196, 50, function(v) Settings.Misc.GravVal = v updGrav() end)
toggle("Fullbright", false, function(s) if s then Lighting.Brightness = 3 Lighting.ClockTime = 14 else Lighting.Brightness = 1 end end)
toggle("No Recoil", false, function(s) Settings.Misc.NoRecoil = s end)
toggle("No Spread", false, function(s) Settings.Misc.NoSpread = s end)
toggle("FOV Changer", false, function(s) Settings.Misc.FOVChanger = s if s then Camera.FieldOfView = Settings.Misc.FOVVal else Camera.FieldOfView = 70 end end)
slider("FOV Val", 30, 120, 90, function(v) Settings.Misc.FOVVal = v if Settings.Misc.FOVChanger then Camera.FieldOfView = v end end)

scroll.CanvasSize = UDim2.new(0, 0, 0, yPos + 30)

-- ESP
function createESP(player)
    if ESPData[player] then
        if ESPData[player].conn then ESPData[player].conn:Disconnect() end
        if ESPData[player].lines then for _, l in pairs(ESPData[player].lines) do l:Remove() end end
        if ESPData[player].texts then for _, t in pairs(ESPData[player].texts) do t:Remove() end end
        if ESPData[player].hp then ESPData[player].hp.bg:Remove() ESPData[player].hp.fill:Remove() end
    end
    ESPData[player] = {lines = {}, texts = {}}
    local lines = {} for i = 1, 12 do local l = Drawing.new("Line") l.Visible = false lines[i] = l end
    local nt = Drawing.new("Text") nt.Visible = false nt.Center = true nt.Size = 15 nt.Font = 3 nt.Outline = true nt.OutlineColor = Color3.fromRGB(0,0,0)
    local dt = Drawing.new("Text") dt.Visible = false dt.Center = true dt.Size = 13 dt.Font = 3 dt.Outline = true dt.OutlineColor = Color3.fromRGB(0,0,0)
    local hbg = Drawing.new("Square") hbg.Visible = false hbg.Filled = true hbg.Color = Color3.fromRGB(15,15,15) hbg.Transparency = 0.4
    local hf = Drawing.new("Square") hf.Visible = false hf.Filled = true
    ESPData[player].lines = lines ESPData[player].texts = {nt, dt} ESPData[player].hp = {bg = hbg, fill = hf}
    
    ESPData[player].conn = RunService.RenderStepped:Connect(function()
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
        if not tvis and not bvis then for _, l in pairs(lines) do l.Visible = false end return end
        
        local dist = (Camera.CFrame.Position - cp).Magnitude
        local bw = math.clamp((2.5 / dist) * 500, 20, 200)
        local cs = Camera:WorldToViewportPoint(cp)
        
        local lx = cs.X - bw/2 local rx = cs.X + bw/2
        local color = Settings.ESP.Color == "Rainbow" and Color3.fromHSV(tick()%5/5, 1, 1) or (Colors[Settings.ESP.Color] or Colors.White)
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
            local cs2 = math.min(bw * 0.3, 40)
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
            local health = hm.Health / hm.MaxHealth local barW = 3 local barH = by - ty local barX = lx - barW - 4
            hbg.Size = Vector2.new(barW, barH) hbg.Position = Vector2.new(barX, ty)
            hf.Size = Vector2.new(barW, barH * health) hf.Position = Vector2.new(barX, ty + barH * (1 - health))
            hf.Color = Color3.fromHSV(health * 0.33, 1, 1)
        end
    end)
end

function applyChams(player)
    if not player.Character then return end
    local c = player.Character
    local old = c:FindFirstChild("EC") if old then old:Destroy() end
    local hl = Instance.new("Highlight") hl.Name = "EC" hl.Enabled = Settings.Chams.Enabled
    hl.FillTransparency = Settings.Chams.FillTrans hl.OutlineTransparency = Settings.Chams.OutlineTrans
    hl.Adornee = c hl.Parent = c
    if Settings.Chams.Color ~= "Rainbow" then
        local col = Colors[Settings.Chams.Color] or Colors.Red hl.FillColor = col hl.OutlineColor = col
    end
end

-- Aimbot
local function getTarget()
    local best, bestDist = nil, Settings.Aimbot.FOV
    for _, p in pairs(Players:GetPlayers()) do
        if p == LocalPlayer or not p.Character then continue end
        local tp = p.Character:FindFirstChild(Settings.Aimbot.TargetPart)
        local hm = p.Character:FindFirstChildOfClass("Humanoid")
        if not tp or not hm or hm.Health <= 0 then continue end
        local sp, vis = Camera:WorldToViewportPoint(tp.Position)
        if not Settings.Aimbot.UnlockFOV and not vis then continue end
        local sc = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
        local d = (Vector2.new(sp.X, sp.Y) - sc).Magnitude
        if d < bestDist then bestDist = d best = tp end
    end
    return best, bestDist
end

-- Kill Aura
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
        if not tr then continue end
        if (r.Position - tr.Position).Magnitude <= Settings.KillAura.Range then
            local tp = p.Character:FindFirstChild(Settings.KillAura.TargetPart) or p.Character:FindFirstChild("Head")
            if tp then
                if Settings.KillAura.Teleport then r.CFrame = CFrame.new(tp.Position + Vector3.new(0, Settings.KillAura.TeleportHeight, 0)) end
                Camera.CFrame = CFrame.new(Camera.CFrame.Position, tp.Position)
                if Settings.KillAura.AutoAttack then clickMouse() end
            end
            break
        end
    end
end

RunService.RenderStepped:Connect(function()
    if Settings.Misc.InfJump then local c = LocalPlayer.Character if c then local h = c:FindFirstChildOfClass("Humanoid") if h then h.Jump = true end end end
    if Settings.Misc.NoRecoil then pcall(function() for _, v in pairs(LocalPlayer.Character:GetChildren()) do if v:IsA("Tool") then v.Recoil = 0 end end end) end
    if Settings.Misc.NoSpread then pcall(function() for _, v in pairs(LocalPlayer.Character:GetChildren()) do if v:IsA("Tool") then v.Spread = 0 end end end) end
    killAura()
    if Settings.Aimbot.Enabled then
        local bt, bd = getTarget()
        if bt then
            if Settings.Aimbot.SilentAim then Camera.CFrame = CFrame.new(Camera.CFrame.Position, bt.Position)
            else Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, bt.Position), 1/math.max(Settings.Aimbot.Smoothness, 1)) end
            if Settings.Aimbot.AutoShoot and bd < 100 then clickMouse() end
        end
    end
end)

-- Fly
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
function stopFly() if flyConn then flyConn:Disconnect() flyConn = nil end
    local c = LocalPlayer.Character if c then local h = c:FindFirstChildOfClass("Humanoid") if h then h.PlatformStand = false end end end
end

-- NoClip
local ncConn
function enableNC() ncConn = RunService.Stepped:Connect(function() if LocalPlayer.Character then for _, p in pairs(LocalPlayer.Character:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide = false end end end end) end
function disableNC() if ncConn then ncConn:Disconnect() ncConn = nil end end

function updSpeed() local c = LocalPlayer.Character if c then local h = c:FindFirstChildOfClass("Humanoid") if h then h.WalkSpeed = Settings.Misc.Speed and Settings.Misc.SpeedVal or 16 end end end
function updJump() local c = LocalPlayer.Character if c then local h = c:FindFirstChildOfClass("Humanoid") if h then h.UseJumpPower = true h.JumpPower = Settings.Misc.JumpPower and Settings.Misc.JumpVal or 50 end end end
function updGrav() workspace.Gravity = Settings.Misc.Gravity and Settings.Misc.GravVal or 196.2 end

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

UserInputService.InputBegan:Connect(function(input, gp) if not gp and input.KeyCode == Enum.KeyCode.V then main.Visible = not main.Visible end end)
print("✅ NOOBS COCO STARTED!")
print("Фикс версия")
