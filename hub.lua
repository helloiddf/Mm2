local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local VirtualInputManager = game:GetService("VirtualInputManager")

local player = Players.LocalPlayer

-- [Цветовая палитра]
local COLORS = {
    MainBG = Color3.fromRGB(15, 15, 17),
    Sidebar = Color3.fromRGB(10, 10, 12),
    SectionBG = Color3.fromRGB(18, 18, 20),
    Border = Color3.fromRGB(28, 28, 30),
    Accent = Color3.fromRGB(138, 43, 226),
    TextLight = Color3.fromRGB(220, 220, 220),
    TextDark = Color3.fromRGB(100, 100, 105)
}

-- [Очистка старого GUI]
if CoreGui:FindFirstChild("Dohyun_Private") then
    CoreGui.Dohyun_Private:Destroy()
end
if player:WaitForChild("PlayerGui"):FindFirstChild("Dohyun_Private") then
    player.PlayerGui.Dohyun_Private:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "Dohyun_Private"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
pcall(function() ScreenGui.Parent = CoreGui end)
if not ScreenGui.Parent then ScreenGui.Parent = player.PlayerGui end

-- ==========================================
-- 1. Динамический прицел (С кастомными настройками)
-- ==========================================
local CrosshairSettings = {
    Gap = 10,
    Length = 8,
    Thickness = 1
}

local CrosshairCenter = Instance.new("Frame")
CrosshairCenter.Size = UDim2.new(0, 100, 0, 100)
CrosshairCenter.Position = UDim2.new(0.5, 0, 0.5, 0)
CrosshairCenter.AnchorPoint = Vector2.new(0.5, 0.5)
CrosshairCenter.BackgroundTransparency = 1
CrosshairCenter.Parent = ScreenGui

local CrosshairContainer = Instance.new("Frame")
CrosshairContainer.Size = UDim2.new(0, 40, 0, 40)
CrosshairContainer.Position = UDim2.new(0.5, 0, 0.5, 0)
CrosshairContainer.AnchorPoint = Vector2.new(0.5, 0.5)
CrosshairContainer.BackgroundTransparency = 1
CrosshairContainer.Parent = CrosshairCenter

local lines = {}
local function createCrossLine(pos, size)
    local line = Instance.new("Frame")
    line.Size = size
    line.Position = pos
    line.BorderSizePixel = 0
    line.Parent = CrosshairContainer
    table.insert(lines, line)
    return line
end

local TopLine = createCrossLine(UDim2.new(), UDim2.new())
local BottomLine = createCrossLine(UDim2.new(), UDim2.new())
local LeftLine = createCrossLine(UDim2.new(), UDim2.new())
local RightLine = createCrossLine(UDim2.new(), UDim2.new())

local CrosshairText = Instance.new("TextLabel")
CrosshairText.Size = UDim2.new(0, 150, 0, 15)
CrosshairText.Position = UDim2.new(0.5, 0, 0.5, 25)
CrosshairText.AnchorPoint = Vector2.new(0.5, 0)
CrosshairText.BackgroundTransparency = 1
CrosshairText.Text = "Dohyun.Win"
CrosshairText.Font = Enum.Font.Arcade
CrosshairText.TextSize = 12
CrosshairText.TextStrokeTransparency = 0.5
CrosshairText.Parent = CrosshairCenter

-- ==========================================
-- 2. Главное меню
-- ==========================================
local OpenBtn = Instance.new("TextButton")
OpenBtn.Size = UDim2.new(0, 40, 0, 40)
OpenBtn.Position = UDim2.new(0.5, -20, 0, 10) 
OpenBtn.BackgroundColor3 = COLORS.Sidebar
OpenBtn.BorderColor3 = COLORS.Accent
OpenBtn.Text = "D"
OpenBtn.TextColor3 = COLORS.Accent
OpenBtn.Font = Enum.Font.GothamBold
OpenBtn.TextSize = 18
OpenBtn.Visible = false
OpenBtn.Parent = ScreenGui
Instance.new("UICorner", OpenBtn).CornerRadius = UDim.new(0, 8)
Instance.new("UIStroke", OpenBtn).Color = COLORS.Accent

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 480, 0, 350)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundColor3 = COLORS.MainBG
MainFrame.BorderColor3 = COLORS.Border
MainFrame.BorderSizePixel = 1
MainFrame.Active = true
MainFrame.Draggable = true 
MainFrame.Parent = ScreenGui

local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 25)
TopBar.BackgroundColor3 = COLORS.Sidebar
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0, 150, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "Dohyun Private"
Title.TextColor3 = COLORS.TextLight
Title.Font = Enum.Font.GothamBold
Title.TextSize = 12
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TopBar

local MinBtn = Instance.new("TextButton")
MinBtn.Size = UDim2.new(0, 30, 1, 0)
MinBtn.Position = UDim2.new(1, -30, 0, 0)
MinBtn.BackgroundTransparency = 1
MinBtn.Text = "−"
MinBtn.TextColor3 = COLORS.TextLight
MinBtn.TextSize = 18
MinBtn.Parent = TopBar
MinBtn.MouseButton1Click:Connect(function() MainFrame.Visible = false OpenBtn.Visible = true end)
OpenBtn.MouseButton1Click:Connect(function() MainFrame.Visible = true OpenBtn.Visible = false end)

-- ==========================================
-- 3. UI Компоненты
-- ==========================================
local ContentFrame = Instance.new("ScrollingFrame")
ContentFrame.Size = UDim2.new(1, -10, 1, -30)
ContentFrame.Position = UDim2.new(0, 5, 0, 30)
ContentFrame.BackgroundTransparency = 1
ContentFrame.ScrollBarThickness = 3
ContentFrame.CanvasSize = UDim2.new(0, 0, 0, 1050) -- Увеличено для новых ползунков
ContentFrame.Parent = MainFrame

local LeftCol = Instance.new("Frame")
LeftCol.Size = UDim2.new(0.48, 0, 1, 0)
LeftCol.BackgroundTransparency = 1
LeftCol.Parent = ContentFrame
Instance.new("UIListLayout", LeftCol).Padding = UDim.new(0, 8)

local RightCol = Instance.new("Frame")
RightCol.Size = UDim2.new(0.48, 0, 1, 0)
RightCol.Position = UDim2.new(0.52, 0, 0, 0)
RightCol.BackgroundTransparency = 1
RightCol.Parent = ContentFrame
Instance.new("UIListLayout", RightCol).Padding = UDim.new(0, 8)

local function CreateSection(parent, title)
    local Section = Instance.new("Frame")
    Section.Size = UDim2.new(1, 0, 0, 0)
    Section.AutomaticSize = Enum.AutomaticSize.Y
    Section.BackgroundColor3 = COLORS.SectionBG
    Section.BorderSizePixel = 1
    Section.BorderColor3 = COLORS.Border
    Section.Parent = parent
    
    local Pad = Instance.new("UIPadding", Section)
    Pad.PaddingTop = UDim.new(0, 5) Pad.PaddingBottom = UDim.new(0, 5)
    Pad.PaddingLeft = UDim.new(0, 5) Pad.PaddingRight = UDim.new(0, 5)
    
    local List = Instance.new("UIListLayout", Section)
    List.Padding = UDim.new(0, 5)
    
    local TitleLbl = Instance.new("TextLabel")
    TitleLbl.Size = UDim2.new(1, 0, 0, 14)
    TitleLbl.BackgroundTransparency = 1
    TitleLbl.Text = string.upper(title)
    TitleLbl.TextColor3 = COLORS.TextDark
    TitleLbl.Font = Enum.Font.GothamBold
    TitleLbl.TextSize = 10
    TitleLbl.TextXAlignment = Enum.TextXAlignment.Left
    TitleLbl.Parent = Section
    
    return Section
end

local function CreateToggle(section, text, defaultState, callback)
    local state = defaultState
    local TglBtn = Instance.new("TextButton")
    TglBtn.Size = UDim2.new(1, 0, 0, 22)
    TglBtn.BackgroundTransparency = 1
    TglBtn.Text = ""
    TglBtn.Parent = section
    
    local Lbl = Instance.new("TextLabel")
    Lbl.Size = UDim2.new(1, -25, 1, 0)
    Lbl.BackgroundTransparency = 1
    Lbl.Text = text
    Lbl.TextColor3 = state and COLORS.TextLight or COLORS.TextDark
    Lbl.Font = Enum.Font.Gotham
    Lbl.TextSize = 11
    Lbl.TextXAlignment = Enum.TextXAlignment.Left
    Lbl.TextWrapped = true
    Lbl.Parent = TglBtn
    
    local Box = Instance.new("Frame")
    Box.Size = UDim2.new(0, 14, 0, 14)
    Box.Position = UDim2.new(1, -14, 0.5, -7)
    Box.BackgroundColor3 = COLORS.MainBG
    Box.BorderColor3 = state and COLORS.Accent or COLORS.Border
    Box.BorderSizePixel = 1
    Box.Parent = TglBtn
    
    local Fill = Instance.new("Frame")
    Fill.Size = UDim2.new(1, -4, 1, -4)
    Fill.Position = UDim2.new(0.5, 0, 0.5, 0)
    Fill.AnchorPoint = Vector2.new(0.5, 0.5)
    Fill.BackgroundColor3 = COLORS.Accent
    Fill.BorderSizePixel = 0
    Fill.Visible = state
    Fill.Parent = Box

    TglBtn.MouseButton1Click:Connect(function()
        state = not state
        Fill.Visible = state
        Box.BorderColor3 = state and COLORS.Accent or COLORS.Border
        Lbl.TextColor3 = state and COLORS.TextLight or COLORS.TextDark
        if callback then callback(state) end
    end)
end

local function CreateButton(section, text, callback)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, 0, 0, 24)
    Btn.BackgroundColor3 = COLORS.MainBG
    Btn.BorderColor3 = COLORS.Border
    Btn.BorderSizePixel = 1
    Btn.Text = text
    Btn.TextColor3 = COLORS.TextLight
    Btn.Font = Enum.Font.GothamBold
    Btn.TextSize = 10
    Btn.Parent = section
    Btn.MouseButton1Click:Connect(callback)
end

local function CreateSlider(section, text, min, max, default, callback)
    local value = default
    local SliderFrame = Instance.new("Frame")
    SliderFrame.Size = UDim2.new(1, 0, 0, 35)
    SliderFrame.BackgroundTransparency = 1
    SliderFrame.Parent = section
    
    local Lbl = Instance.new("TextLabel")
    Lbl.Size = UDim2.new(1, 0, 0, 15)
    Lbl.BackgroundTransparency = 1
    Lbl.Text = text .. ": " .. value
    Lbl.TextColor3 = COLORS.TextLight
    Lbl.Font = Enum.Font.Gotham
    Lbl.TextSize = 11
    Lbl.TextXAlignment = Enum.TextXAlignment.Left
    Lbl.Parent = SliderFrame
    
    local BG = Instance.new("TextButton")
    BG.Size = UDim2.new(1, 0, 0, 10)
    BG.Position = UDim2.new(0, 0, 0, 20)
    BG.BackgroundColor3 = COLORS.MainBG
    BG.BorderColor3 = COLORS.Border
    BG.Text = ""
    BG.Parent = SliderFrame
    
    local Fill = Instance.new("Frame")
    Fill.Size = UDim2.new((value - min) / (max - min), 0, 1, 0)
    Fill.BackgroundColor3 = COLORS.Accent
    Fill.BorderSizePixel = 0
    Fill.Parent = BG
    
    local dragging = false
    local function update(input)
        local pos = math.clamp((input.Position.X - BG.AbsolutePosition.X) / BG.AbsoluteSize.X, 0, 1)
        value = math.floor(min + ((max - min) * pos))
        Fill.Size = UDim2.new(pos, 0, 1, 0)
        Lbl.Text = text .. ": " .. value
        callback(value)
    end
    
    BG.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            update(input)
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            update(input)
        end
    end)
    
    callback(value)
end

local function CreateTextBox(section, placeholder, callback)
    local Box = Instance.new("TextBox")
    Box.Size = UDim2.new(1, 0, 0, 25)
    Box.BackgroundColor3 = COLORS.MainBG
    Box.BorderColor3 = COLORS.Border
    Box.TextColor3 = COLORS.TextLight
    Box.Font = Enum.Font.Gotham
    Box.TextSize = 11
    Box.PlaceholderText = placeholder
    Box.Text = ""
    Box.Parent = section
    Box.FocusLost:Connect(function(enterPressed)
        if enterPressed then
            callback(Box.Text)
            Box.Text = "" 
        end
    end)
end

local function CreateCycler(section, text, options, callback)
    local currentIndex = 1
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, 0, 0, 22)
    Btn.BackgroundTransparency = 1
    Btn.Text = ""
    Btn.Parent = section
    
    local Lbl = Instance.new("TextLabel")
    Lbl.Size = UDim2.new(1, -45, 1, 0)
    Lbl.BackgroundTransparency = 1
    Lbl.Text = text .. ": " .. options[currentIndex].Name
    Lbl.TextColor3 = COLORS.TextLight
    Lbl.Font = Enum.Font.Gotham
    Lbl.TextSize = 11
    Lbl.TextXAlignment = Enum.TextXAlignment.Left
    Lbl.Parent = Btn
    
    local Box = Instance.new("Frame")
    Box.Size = UDim2.new(0, 40, 0, 16)
    Box.Position = UDim2.new(1, -40, 0.5, -8)
    Box.BackgroundColor3 = COLORS.MainBG
    Box.BorderColor3 = COLORS.Border
    Box.BorderSizePixel = 1
    Box.Parent = Btn

    local BoxTxt = Instance.new("TextLabel")
    BoxTxt.Size = UDim2.new(1, 0, 1, 0)
    BoxTxt.BackgroundTransparency = 1
    BoxTxt.Text = "NEXT"
    BoxTxt.TextColor3 = COLORS.TextDark
    BoxTxt.Font = Enum.Font.GothamBold
    BoxTxt.TextSize = 9
    BoxTxt.Parent = Box

    Btn.MouseButton1Click:Connect(function()
        currentIndex = currentIndex + 1
        if currentIndex > #options then currentIndex = 1 end
        Lbl.Text = text .. ": " .. options[currentIndex].Name
        callback(options[currentIndex].Value)
    end)
    callback(options[currentIndex].Value)
end

-- ==========================================
-- 4. Настройки & Вспомогательные функции
-- ==========================================
local Config = {
    Aimbot = false,
    HitboxExpander = false,
    SkeletonESP = false,
    Box3D = false,
    HeadESP = false,
    Snapline = false,
    ESPColor = COLORS.Accent,
    SpeedHack = false,
    WalkSpeedValue = 35,
    JumpHack = false,
    JumpPowerValue = 70,
    Noclip = false,
    Fly = false,
    MM2AutoCoin = false
}

local function getClosestPlayerToCenter()
    local cam = workspace.CurrentCamera
    local center = Vector2.new(cam.ViewportSize.X / 2, cam.ViewportSize.Y / 2)
    local closestDist = math.huge
    local closestPlr = nil
    
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") and plr.Character:FindFirstChild("Humanoid") and plr.Character.Humanoid.Health > 0 then
            local pos, onScreen = cam:WorldToViewportPoint(plr.Character.HumanoidRootPart.Position)
            if onScreen then
                local dist = (Vector2.new(pos.X, pos.Y) - center).Magnitude
                if dist < closestDist then
                    closestDist = dist
                    closestPlr = plr
                end
            end
        end
    end
    return closestPlr
end

local function GetMM2RoleColor(plr)
    local char = plr.Character
    local bp = plr:FindFirstChild("Backpack")
    
    local function hasItem(name)
        if bp and bp:FindFirstChild(name) then return true end
        if char and char:FindFirstChild(name) then return true end
        return false
    end

    if hasItem("Knife") then
        return Color3.fromRGB(255, 0, 0) 
    elseif hasItem("Gun") then
        return Color3.fromRGB(0, 100, 255) 
    else
        return Color3.fromRGB(0, 255, 0) 
    end
end

local function GetTargetByRole(roleName)
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= player and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character.Humanoid.Health > 0 then
            local bp = p:FindFirstChild("Backpack")
            local hasGun = (bp and bp:FindFirstChild("Gun")) or p.Character:FindFirstChild("Gun")
            local hasKnife = (bp and bp:FindFirstChild("Knife")) or p.Character:FindFirstChild("Knife")
            
            if roleName == "Sheriff" and hasGun then return p end
            if roleName == "Murderer" and hasKnife then return p end
        end
    end
    return nil
end

local function AutoClick()
    local cam = workspace.CurrentCamera
    local centerX = cam.ViewportSize.X / 2
    local centerY = cam.ViewportSize.Y / 2
    
    VirtualInputManager:SendMouseButtonEvent(centerX, centerY, 0, true, game, 1)
    task.wait(0.05)
    VirtualInputManager:SendMouseButtonEvent(centerX, centerY, 0, false, game, 1)
end

local autoFarmTween = nil
local function GlideTo(targetPos)
    local char = player.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    
    local dist = (hrp.Position - targetPos).Magnitude
    local speed = 35 
    local timeToTravel = dist / speed
    
    local tweenInfo = TweenInfo.new(timeToTravel, Enum.EasingStyle.Linear)
    -- Y + 3.5 гарантирует, что мы не коснемся kill brick под картой
    autoFarmTween = TweenService:Create(hrp, tweenInfo, {CFrame = CFrame.new(targetPos + Vector3.new(0, 3.5, 0))})
    autoFarmTween:Play()
    autoFarmTween.Completed:Wait()
end

-- ==========================================
-- 5. Заполнение UI
-- ==========================================
local AimbotSec = CreateSection(LeftCol, "COMBAT (AIMBOT)")
CreateToggle(AimbotSec, "Auto-Lock Aimbot", false, function(s) Config.Aimbot = s end)
CreateToggle(AimbotSec, "Hitbox Expander (DISABLE FOR AUTO-KILL)", false, function(s) Config.HitboxExpander = s end)

CreateSlider(AimbotSec, "Crosshair Gap", 0, 50, 10, function(val) CrosshairSettings.Gap = val end)
CreateSlider(AimbotSec, "Crosshair Length", 1, 50, 8, function(val) CrosshairSettings.Length = val end)
CreateSlider(AimbotSec, "Crosshair Thickness", 1, 10, 1, function(val) CrosshairSettings.Thickness = val end)

local VisualSec = CreateSection(LeftCol, "VISUALS (ESP)")
CreateToggle(VisualSec, "Skeleton (MM2 Role Colors)", false, function(s) Config.SkeletonESP = s end)
CreateToggle(VisualSec, "3D Box", false, function(s) Config.Box3D = s end)
CreateToggle(VisualSec, "Head Dot", false, function(s) Config.HeadESP = s end)
CreateToggle(VisualSec, "Snaplines", false, function(s) Config.Snapline = s end)

local SkyboxOptions = {
    {Name = "Galaxy", Value = "1045964490"},
    {Name = "Vaporwave", Value = "1417494030"},
    {Name = "Purple Nebula", Value = "159454299"},
    {Name = "Sunset", Value = "141744530"},
    {Name = "Blood Moon", Value = "1137021669"}
}

local currentSkybox = Instance.new("Sky")
CreateCycler(VisualSec, "Skybox Theme", SkyboxOptions, function(id) 
    currentSkybox.SkyboxBk = "rbxassetid://"..id
    currentSkybox.SkyboxDn = "rbxassetid://"..id
    currentSkybox.SkyboxFt = "rbxassetid://"..id
    currentSkybox.SkyboxLf = "rbxassetid://"..id
    currentSkybox.SkyboxRt = "rbxassetid://"..id
    currentSkybox.SkyboxUp = "rbxassetid://"..id
end)

CreateToggle(VisualSec, "Enable Custom Skybox", false, function(s)
    if s then
        if Lighting:FindFirstChildOfClass("Sky") then Lighting:FindFirstChildOfClass("Sky").Parent = nil end
        currentSkybox.Parent = Lighting
    else
        currentSkybox.Parent = nil
    end
end)

local PlayerSec = CreateSection(RightCol, "LOCAL PLAYER")
CreateTextBox(PlayerSec, "Enter ID to change Avatar", function(txt)
    local id = tonumber(txt)
    if id and player.Character and player.Character:FindFirstChild("Humanoid") then
        pcall(function()
            player.Character.Humanoid:ApplyDescription(Players:GetHumanoidDescriptionFromUserId(id))
        end)
    end
end)

CreateToggle(PlayerSec, "Speed Hack", false, function(s) Config.SpeedHack = s end)
CreateSlider(PlayerSec, "Speed Amount", 16, 150, 35, function(val) Config.WalkSpeedValue = val end)
CreateToggle(PlayerSec, "Jump Hack", false, function(s) Config.JumpHack = s end)
CreateSlider(PlayerSec, "Jump Amount", 50, 300, 70, function(val) Config.JumpPowerValue = val end)
CreateToggle(PlayerSec, "Noclip", false, function(s) Config.Noclip = s end)

local flyBv, flyBg
CreateToggle(PlayerSec, "Fly (Mobile Fixed)", false, function(s) 
    Config.Fly = s 
    local char = player.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hrp or not hum then return end

    if s then
        hrp.CFrame = hrp.CFrame + Vector3.new(0, 5, 0)
        hum.PlatformStand = true
        flyBv = Instance.new("BodyVelocity", hrp)
        flyBv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        flyBv.Velocity = Vector3.new(0, 0, 0)
        
        flyBg = Instance.new("BodyGyro", hrp)
        flyBg.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
        flyBg.CFrame = hrp.CFrame
    else
        hum.PlatformStand = false
        if flyBv then flyBv:Destroy() end
        if flyBg then flyBg:Destroy() end
    end
end)

local MM2Sec = CreateSection(RightCol, "MURDER MYSTERY 2")

CreateToggle(MM2Sec, "Safe Coin Farm (Anti-Void)", false, function(s) 
    Config.MM2AutoCoin = s 
    local char = player.Character
    local hum = char and char:FindFirstChild("Humanoid")
    
    if Config.MM2AutoCoin then
        task.spawn(function()
            while Config.MM2AutoCoin do
                task.wait(0.1)
                pcall(function()
                    local char = player.Character
                    local hrp = char and char:FindFirstChild("HumanoidRootPart")
                    local hum = char and char:FindFirstChild("Humanoid")
                    
                    if hrp and hum then
                        hum.PlatformStand = true
                        
                        for _, part in pairs(char:GetDescendants()) do
                            if part:IsA("BasePart") then part.CanCollide = false end
                        end
                        
                        local targetCoin = nil
                        for _, obj in pairs(workspace:GetDescendants()) do
                            if obj:IsA("BasePart") and (obj.Name == "Coin_Server" or string.find(obj.Name, "Coin")) then
                                targetCoin = obj
                                break
                            end
                        end
                        
                        if targetCoin then
                            GlideTo(targetCoin.Position)
                            task.wait(0.1) 
                        end
                    end
                end)
            end
            if hum then hum.PlatformStand = false end
            if autoFarmTween then autoFarmTween:Cancel() end
        end)
    else
        if hum then hum.PlatformStand = false end
        if autoFarmTween then autoFarmTween:Cancel() end
    end
end)

CreateButton(MM2Sec, "Glue-Kill Sheriff (No Stuck)", function()
    local char = player.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    
    local target = GetTargetByRole("Sheriff")
    if target then
        if player:FindFirstChild("Backpack") and player.Backpack:FindFirstChild("Knife") then
            player.Backpack.Knife.Parent = char
        end
        
        local startTime = tick()
        local glueConn
        
        glueConn = RunService.Heartbeat:Connect(function()
            if tick() - startTime > 3 or not target.Character or not target.Character:FindFirstChild("HumanoidRootPart") or target.Character.Humanoid.Health <= 0 or char.Humanoid.Health <= 0 then
                glueConn:Disconnect()
                return
            end
            -- Блокируем коллизию, чтобы не застрять в невинных
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") then part.CanCollide = false end
            end
            
            hrp.CFrame = target.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 2)
            workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, target.Character.HumanoidRootPart.Position)
            AutoClick()
        end)
    end
end)

CreateButton(MM2Sec, "Glue-Kill Murderer (No Stuck)", function()
    local char = player.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    
    local target = GetTargetByRole("Murderer")
    if target then
        if player:FindFirstChild("Backpack") and player.Backpack:FindFirstChild("Gun") then
            player.Backpack.Gun.Parent = char
        end
        
        local startTime = tick()
        local glueConn
        
        glueConn = RunService.Heartbeat:Connect(function()
            if tick() - startTime > 3 or not target.Character or not target.Character:FindFirstChild("HumanoidRootPart") or target.Character.Humanoid.Health <= 0 or char.Humanoid.Health <= 0 then
                glueConn:Disconnect()
                return
            end
            
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") then part.CanCollide = false end
            end
            
            hrp.CFrame = target.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 2)
            workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, target.Character.HumanoidRootPart.Position)
            AutoClick()
        end)
    end
end)

CreateButton(MM2Sec, "Grab Dropped Gun", function()
    local char = player.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if hrp then
        local gunDrop = workspace:FindFirstChild("GunDrop")
        if gunDrop then
            GlideTo(gunDrop.Position)
        end
    end
end)

-- ==========================================
-- 6. ESP Drawing Logic
-- ==========================================
local espEntities = {}
local R15_BONES = {
    {"Head", "UpperTorso"}, {"UpperTorso", "LowerTorso"},
    {"UpperTorso", "LeftUpperArm"}, {"LeftUpperArm", "LeftLowerArm"}, {"LeftLowerArm", "LeftHand"},
    {"UpperTorso", "RightUpperArm"}, {"RightUpperArm", "RightLowerArm"}, {"RightLowerArm", "RightHand"},
    {"LowerTorso", "LeftUpperLeg"}, {"LeftUpperLeg", "LeftLowerLeg"}, {"LeftLowerLeg", "LeftFoot"},
    {"LowerTorso", "RightUpperLeg"}, {"RightUpperLeg", "RightLowerLeg"}, {"RightLowerLeg", "RightFoot"}
}
local BOX3D_EDGES = {
    {1,2}, {2,3}, {3,4}, {4,1},
    {5,6}, {6,7}, {7,8}, {8,5},
    {1,5}, {2,6}, {3,7}, {4,8}
}

local function getDrawLine()
    local line = Drawing.new("Line")
    line.Visible = false
    line.Thickness = 1.5
    line.Transparency = 0.8
    return line
end

local function getDrawCircle()
    local c = Drawing.new("Circle")
    c.Visible = false
    c.Thickness = 1.5
    c.Filled = true
    c.Transparency = 0.8
    return c
end

local rotationAngle = 0
local hue = 0

RunService.Stepped:Connect(function()
    if Config.Noclip and player.Character then
        for _, part in pairs(player.Character:GetDescendants()) do
            if part:IsA("BasePart") and part.CanCollide then
                part.CanCollide = false
            end
        end
    end
end)

RunService.RenderStepped:Connect(function(deltaTime)
    if not ScreenGui or not ScreenGui.Parent then return end

    local cam = workspace.CurrentCamera
    local char = player.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    
    if hum then
        if Config.SpeedHack then hum.WalkSpeed = Config.WalkSpeedValue else hum.WalkSpeed = 16 end
        if Config.JumpHack then hum.UseJumpPower = true hum.JumpPower = Config.JumpPowerValue else hum.JumpPower = 50 end
    end

    if Config.Fly and flyBv and flyBg and hum then
        local moveDir = hum.MoveDirection
        if moveDir.Magnitude > 0 then
            local relativeMove = cam.CFrame:VectorToObjectSpace(moveDir)
            flyBv.Velocity = cam.CFrame:VectorToWorldSpace(Vector3.new(relativeMove.X, relativeMove.Y, relativeMove.Z)) * 80
        else
            flyBv.Velocity = Vector3.new(0, 0, 0)
        end
        flyBg.CFrame = cam.CFrame
    end

    if Config.Aimbot then
        local target = getClosestPlayerToCenter()
        if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
            cam.CFrame = CFrame.new(cam.CFrame.Position, target.Character.HumanoidRootPart.Position)
        end
    end

    rotationAngle = (rotationAngle + (120 * deltaTime)) % 360
    CrosshairContainer.Rotation = rotationAngle
    
    local pulse = math.sin(tick() * 5) * 3 
    local currentLen = CrosshairSettings.Length + pulse
    local gap = CrosshairSettings.Gap
    local thick = CrosshairSettings.Thickness

    TopLine.Size = UDim2.new(0, thick, 0, currentLen)
    TopLine.Position = UDim2.new(0.5, -thick/2, 0.5, -gap - currentLen)
    BottomLine.Size = UDim2.new(0, thick, 0, currentLen)
    BottomLine.Position = UDim2.new(0.5, -thick/2, 0.5, gap)
    LeftLine.Size = UDim2.new(0, currentLen, 0, thick)
    LeftLine.Position = UDim2.new(0.5, -gap - currentLen, 0.5, -thick/2)
    RightLine.Size = UDim2.new(0, currentLen, 0, thick)
    RightLine.Position = UDim2.new(0.5, gap, 0.5, -thick/2)

    hue = (hue + (0.4 * deltaTime)) % 1
    local rainbowColor = Color3.fromHSV(hue, 1, 1)
    TopLine.BackgroundColor3 = rainbowColor
    BottomLine.BackgroundColor3 = rainbowColor
    LeftLine.BackgroundColor3 = rainbowColor
    RightLine.BackgroundColor3 = rainbowColor
    CrosshairText.TextColor3 = rainbowColor

    if type(Drawing) ~= "nil" then
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= player then
                if not espEntities[plr] then
                    espEntities[plr] = {
                        Skeleton = {}, Box3D = {},
                        Head = getDrawCircle(), Snapline = getDrawLine()
                    }
                    for i = 1, #R15_BONES do espEntities[plr].Skeleton[i] = getDrawLine() end
                    for i = 1, 12 do espEntities[plr].Box3D[i] = getDrawLine() end
                end

                local esp = espEntities[plr]
                local c = plr.Character
                local isVisible = false

                if c and c:FindFirstChild("Humanoid") and c.Humanoid.Health > 0 and c:FindFirstChild("HumanoidRootPart") and c:FindFirstChild("Head") then
                    local hrp = c.HumanoidRootPart
                    local head = c.Head
                    local rootPos, onScreen = cam:WorldToViewportPoint(hrp.Position)
                    
                    if onScreen then
                        isVisible = true
                        local roleColor = GetMM2RoleColor(plr)
                        
                        if Config.HitboxExpander then
                            head.Size = Vector3.new(7, 7, 7)
                            head.Transparency = 0.6
                            head.CanCollide = false
                        else
                            if head.Size.X == 7 then head.Size = Vector3.new(1.2, 1.2, 1.2) head.Transparency = 0 head.CanCollide = true end
                        end

                        local headPos = cam:WorldToViewportPoint(head.Position + Vector3.new(0, 0.5, 0))

                        if Config.SkeletonESP then
                            for i, bonePair in ipairs(R15_BONES) do
                                local p1, p2 = c:FindFirstChild(bonePair[1]), c:FindFirstChild(bonePair[2])
                                local line = esp.Skeleton[i]
                                if p1 and p2 then
                                    local pos1, vis1 = cam:WorldToViewportPoint(p1.Position)
                                    local pos2, vis2 = cam:WorldToViewportPoint(p2.Position)
                                    if vis1 or vis2 then
                                        line.From = Vector2.new(pos1.X, pos1.Y)
                                        line.To = Vector2.new(pos2.X, pos2.Y)
                                        line.Color = roleColor
                                        line.Visible = true
                                    else
                                        line.Visible = false
                                    end
                                else line.Visible = false end
                            end
                        else
                            for _, line in ipairs(esp.Skeleton) do line.Visible = false end
                        end

                        if Config.HeadESP then
                            esp.Head.Visible = true
                            esp.Head.Position = Vector2.new(headPos.X, headPos.Y)
                            esp.Head.Radius = math.clamp(500 / headPos.Z, 2, 20)
                            esp.Head.Color = Config.ESPColor
                        else esp.Head.Visible = false end

                        if Config.Snapline then
                            esp.Snapline.Visible = true
                            esp.Snapline.From = Vector2.new(cam.ViewportSize.X / 2, cam.ViewportSize.Y)
                            esp.Snapline.To = Vector2.new(rootPos.X, rootPos.Y)
                            esp.Snapline.Color = roleColor 
                        else esp.Snapline.Visible = false end

                        if Config.Box3D then
                            local cf, size = c:GetBoundingBox()
                            local corners = {
                                (cf * CFrame.new(size.X/2, size.Y/2, size.Z/2)).Position,
                                (cf * CFrame.new(-size.X/2, size.Y/2, size.Z/2)).Position,
                                (cf * CFrame.new(-size.X/2, -size.Y/2, size.Z/2)).Position,
                                (cf * CFrame.new(size.X/2, -size.Y/2, size.Z/2)).Position,
                                (cf * CFrame.new(size.X/2, size.Y/2, -size.Z/2)).Position,
                                (cf * CFrame.new(-size.X/2, size.Y/2, -size.Z/2)).Position,
                                (cf * CFrame.new(-size.X/2, -size.Y/2, -size.Z/2)).Position,
                                (cf * CFrame.new(size.X/2, -size.Y/2, -size.Z/2)).Position,
                            }
                            for i, edge in ipairs(BOX3D_EDGES) do
                                local pos1, vis1 = cam:WorldToViewportPoint(corners[edge[1]])
                                local pos2, vis2 = cam:WorldToViewportPoint(corners[edge[2]])
                                if vis1 or vis2 then
                                    esp.Box3D[i].Visible = true
                                    esp.Box3D[i].From = Vector2.new(pos1.X, pos1.Y)
                                    esp.Box3D[i].To = Vector2.new(pos2.X, pos2.Y)
                                    esp.Box3D[i].Color = Config.ESPColor
                                else
                                    esp.Box3D[i].Visible = false
                                end
                            end
                        else
                            for _, line in ipairs(esp.Box3D) do line.Visible = false end
                        end
                    end
                end

                if not isVisible then
                    for _, line in ipairs(esp.Skeleton) do line.Visible = false end
                    for _, line in ipairs(esp.Box3D) do line.Visible = false end
                    esp.Head.Visible = false
                    esp.Snapline.Visible = false
                end
            end
        end
    end
end)

Players.PlayerRemoving:Connect(function(plr)
    if espEntities[plr] then
        for _, obj in pairs(espEntities[plr].Skeleton) do pcall(function() obj:Remove() end) end
        for _, obj in pairs(espEntities[plr].Box3D) do pcall(function() obj:Remove() end) end
        pcall(function() espEntities[plr].Head:Remove() end)
        pcall(function() espEntities[plr].Snapline:Remove() end)
        espEntities[plr] = nil
    end
end)
