local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TextChatService = game:GetService("TextChatService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local VirtualUser = game:GetService("VirtualUser")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local LocalMouse = LocalPlayer:GetMouse()

--------------------------------------------------------------------
-- 🛡️ [종결급 안티치트 우회 시스템 (Anti-Cheat Bypass)]
--------------------------------------------------------------------
local HiddenUI = (gethui and gethui()) or (get_hidden_gui and get_hidden_gui()) or CoreGui

for _, v in pairs(HiddenUI:GetChildren()) do
    if v.Name == "Launcher_Hub" or v.Name == "ValoStyle_Hub" or v.Name == "ValoStyle_Min" or v.Name == "WordChain_Hub" then
        v:Destroy()
    end
end
if LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("Launcher_Hub") then
    LocalPlayer.PlayerGui:ClearAllChildren()
end

pcall(function()
    local gm = getrawmetatable(game)
    if not gm then return end
    if setreadonly then setreadonly(gm, false) end
    local oldNamecall = gm.__namecall
    local oldIndex = gm.__index

    gm.__namecall = newcclosure(function(self, ...)
        local method = getnamecallmethod()
        if method == "Kick" or method == "kick" then return nil end
        if method == "FireServer" then
            local remoteName = tostring(self):lower()
            if remoteName:find("ban") or remoteName:find("report") or remoteName:find("log") or remoteName:find("anticheat") then
                return nil
            end
        end
        return oldNamecall(self, ...)
    end)

    gm.__index = newcclosure(function(self, key)
        if tostring(self) == "Humanoid" then
            if key == "WalkSpeed" then return 16 end
            if key == "JumpPower" then return 50 end
        end
        return oldIndex(self, key)
    end)
    if setreadonly then setreadonly(gm, true) end
end)
--------------------------------------------------------------------

--------------------------------------------------------------------
-- 🚀 1. 최초 실행 런처 UI
--------------------------------------------------------------------
local launcherGui = Instance.new("ScreenGui")
launcherGui.Name = "Launcher_Hub"
launcherGui.ResetOnSpawn = false
launcherGui.IgnoreGuiInset = true
launcherGui.DisplayOrder = 999999
launcherGui.Parent = HiddenUI

local LauncherFrame = Instance.new("Frame", launcherGui)
LauncherFrame.Size = UDim2.new(0, 0, 0, 0)
LauncherFrame.AnchorPoint = Vector2.new(0.5, 0.5)
LauncherFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
LauncherFrame.BackgroundColor3 = Color3.fromRGB(13, 11, 20)
LauncherFrame.BorderSizePixel = 0
LauncherFrame.ClipsDescendants = true
Instance.new("UICorner", LauncherFrame).CornerRadius = UDim.new(0, 10)
Instance.new("UIStroke", LauncherFrame).Color = Color3.fromRGB(138, 43, 226)

TweenService:Create(LauncherFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0, 320, 0, 200)}):Play()

local LTitle = Instance.new("TextLabel", LauncherFrame)
LTitle.Size = UDim2.new(1, 0, 0, 45)
LTitle.BackgroundTransparency = 1
LTitle.Text = "⚡ MOBILE GOD-TIER S-HUB ⚡"
LTitle.TextColor3 = Color3.fromRGB(160, 100, 255)
LTitle.Font = Enum.Font.GothamBlack
LTitle.TextSize = 15

local function CreateLauncherBtn(posY, text, textColor, strokeColor, callback)
    local btn = Instance.new("TextButton", LauncherFrame)
    btn.Size = UDim2.new(0.85, 0, 0, 42)
    btn.Position = UDim2.new(0.075, 0, 0, posY)
    btn.BackgroundColor3 = Color3.fromRGB(25, 20, 35)
    btn.Text = text
    btn.TextColor3 = textColor
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    Instance.new("UIStroke", btn).Color = strokeColor
    
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 30, 55)}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(25, 20, 35)}):Play()
    end)
    btn.MouseButton1Click:Connect(callback)
    return btn
end

CreateLauncherBtn(55, "🔪 MURDER MYSTERY 2 (MOBILE PRO)", Color3.fromRGB(255, 80, 80), Color3.fromRGB(255, 50, 50), function()
    TweenService:Create(LauncherFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 0)}):Play()
    task.wait(0.3)
    launcherGui:Destroy()
    LoadMurderMystery()
end)

CreateLauncherBtn(115, "💬 AUTO WORD CHAIN (한방단어)", Color3.fromRGB(80, 255, 150), Color3.fromRGB(50, 255, 100), function()
    TweenService:Create(LauncherFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 0)}):Play()
    task.wait(0.3)
    launcherGui:Destroy()
    LoadWordChain()
end)

local function LoadWordChain() end

--------------------------------------------------------------------
-- 🔪 3. 머더 미스터리 2 (최종 통합본)
--------------------------------------------------------------------
function LoadMurderMystery()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "ValoStyle_Hub"
    screenGui.ResetOnSpawn = false
    screenGui.IgnoreGuiInset = true
    screenGui.DisplayOrder = 999999
    screenGui.Parent = HiddenUI 

    local MainFrame = Instance.new("Frame", screenGui)
    MainFrame.Size = UDim2.new(0, 0, 0, 0)
    MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    MainFrame.BackgroundColor3 = Color3.fromRGB(13, 11, 20)
    MainFrame.BorderSizePixel = 0
    MainFrame.ClipsDescendants = true
    Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)
    Instance.new("UIStroke", MainFrame).Color = Color3.fromRGB(138, 43, 226)

    TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0, 520, 0, 360)}):Play()

    local TopBar = Instance.new("Frame", MainFrame)
    TopBar.Size = UDim2.new(1, 0, 0, 30)
    TopBar.BackgroundColor3 = Color3.fromRGB(18, 15, 28)
    TopBar.BorderSizePixel = 0

    local Title = Instance.new("TextLabel", TopBar)
    Title.Size = UDim2.new(1, -100, 1, 0)
    Title.Position = UDim2.new(0, 12, 0, 0)
    Title.BackgroundTransparency = 1
    Title.Text = "⚡ MOBILE GOD-TIER MM2 ULTIMATE PRO"
    Title.TextColor3 = Color3.fromRGB(160, 100, 255)
    Title.Font = Enum.Font.GothamBlack
    Title.TextSize = 11
    Title.TextXAlignment = Enum.TextXAlignment.Left

    local CloseBtn = Instance.new("TextButton", TopBar)
    CloseBtn.Size = UDim2.new(0, 30, 0, 30)
    CloseBtn.Position = UDim2.new(1, -30, 0, 0)
    CloseBtn.BackgroundTransparency = 1
    CloseBtn.Text = "✕"
    CloseBtn.TextColor3 = Color3.fromRGB(200, 100, 100)
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.TextSize = 12
    CloseBtn.MouseButton1Click:Connect(function() 
        TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0,0,0,0)}):Play()
        task.wait(0.3)
        screenGui:Destroy() 
    end)

    local MinBtn = Instance.new("TextButton", TopBar)
    MinBtn.Size = UDim2.new(0, 30, 0, 30)
    MinBtn.Position = UDim2.new(1, -60, 0, 0)
    MinBtn.BackgroundTransparency = 1
    MinBtn.Text = "—"
    MinBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
    MinBtn.Font = Enum.Font.GothamBold
    MinBtn.TextSize = 12

    local MinGui = Instance.new("ScreenGui")
    MinGui.Name = "ValoStyle_Min"
    MinGui.ResetOnSpawn = false
    MinGui.DisplayOrder = 999999
    MinGui.Parent = HiddenUI

    local MinIcon = Instance.new("TextButton", MinGui)
    MinIcon.Size = UDim2.new(0, 42, 0, 42)
    MinIcon.Position = UDim2.new(0, 15, 0, 15)
    MinIcon.BackgroundColor3 = Color3.fromRGB(18, 15, 28)
    MinIcon.Text = "S"
    MinIcon.TextColor3 = Color3.fromRGB(160, 100, 255)
    MinIcon.Font = Enum.Font.GothamBlack
    MinIcon.TextSize = 18
    MinIcon.Visible = false
    Instance.new("UICorner", MinIcon).CornerRadius = UDim.new(0, 10)
    Instance.new("UIStroke", MinIcon).Color = Color3.fromRGB(138, 43, 226)

    MinBtn.MouseButton1Click:Connect(function() MainFrame.Visible = false; MinIcon.Visible = true end)
    MinIcon.MouseButton1Click:Connect(function() MainFrame.Visible = true; MinIcon.Visible = false end)

    local dragging, dragStart, startPos
    TopBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true; dragStart = input.Position; startPos = MainFrame.Position
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = false end
    end)

    local Sidebar = Instance.new("Frame", MainFrame)
    Sidebar.Size = UDim2.new(0, 40, 1, -30)
    Sidebar.Position = UDim2.new(0, 0, 0, 30)
    Sidebar.BackgroundColor3 = Color3.fromRGB(16, 13, 25)
    Sidebar.BorderSizePixel = 0
    local SidebarLayout = Instance.new("UIListLayout", Sidebar)
    SidebarLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    SidebarLayout.Padding = UDim.new(0, 6)
    Instance.new("UIPadding", Sidebar).PaddingTop = UDim.new(0, 10)

    local ContentArea = Instance.new("Frame", MainFrame)
    ContentArea.Size = UDim2.new(1, -40, 1, -30)
    ContentArea.Position = UDim2.new(0, 40, 0, 30)
    ContentArea.BackgroundColor3 = Color3.fromRGB(13, 11, 20)
    ContentArea.BorderSizePixel = 0

    local Tabs = {}
    local currentTab = nil

    local function CreateTab(iconText)
        local TabBtn = Instance.new("TextButton", Sidebar)
        TabBtn.Size = UDim2.new(0, 32, 0, 32)
        TabBtn.BackgroundTransparency = 1
        TabBtn.Text = iconText
        TabBtn.TextColor3 = Color3.fromRGB(100, 95, 120)
        TabBtn.Font = Enum.Font.GothamBold
        TabBtn.TextSize = 14

        local Indicator = Instance.new("Frame", TabBtn)
        Indicator.Size = UDim2.new(0, 2, 1, 0)
        Indicator.BackgroundColor3 = Color3.fromRGB(160, 100, 255)
        Indicator.Visible = false

        local TabContainer = Instance.new("Frame", ContentArea)
        TabContainer.Size = UDim2.new(1, 0, 1, 0)
        TabContainer.BackgroundTransparency = 1
        TabContainer.Visible = false

        local LeftCol = Instance.new("ScrollingFrame", TabContainer)
        LeftCol.Size = UDim2.new(0.5, -8, 1, -10)
        LeftCol.Position = UDim2.new(0, 8, 0, 5)
        LeftCol.BackgroundTransparency = 1
        LeftCol.ScrollBarThickness = 2
        local lLayout = Instance.new("UIListLayout", LeftCol)
        lLayout.Padding = UDim.new(0, 6)

        local RightCol = Instance.new("ScrollingFrame", TabContainer)
        RightCol.Size = UDim2.new(0.5, -8, 1, -10)
        RightCol.Position = UDim2.new(0.5, 4, 0, 5)
        RightCol.BackgroundTransparency = 1
        RightCol.ScrollBarThickness = 2
        local rLayout = Instance.new("UIListLayout", RightCol)
        rLayout.Padding = UDim.new(0, 6)

        TabBtn.MouseButton1Click:Connect(function()
            if currentTab then
                currentTab.Btn.TextColor3 = Color3.fromRGB(100, 95, 120)
                currentTab.Ind.Visible = false
                currentTab.Container.Visible = false
            end
            TabBtn.TextColor3 = Color3.fromRGB(160, 100, 255)
            Indicator.Visible = true
            TabContainer.Visible = true
            currentTab = {Btn = TabBtn, Ind = Indicator, Container = TabContainer}
        end)

        table.insert(Tabs, {Btn = TabBtn, Ind = Indicator, Container = TabContainer})
        return LeftCol, RightCol
    end

    local function AddHeader(parent, text)
        local lbl = Instance.new("TextLabel", parent)
        lbl.Size = UDim2.new(1, 0, 0, 22)
        lbl.BackgroundTransparency = 1
        lbl.Text = text
        lbl.TextColor3 = Color3.fromRGB(160, 100, 255)
        lbl.Font = Enum.Font.GothamBold
        lbl.TextSize = 11
        lbl.TextXAlignment = Enum.TextXAlignment.Left
    end

    local function AddToggle(parent, text, callback)
        local state = false
        local btn = Instance.new("TextButton", parent)
        btn.Size = UDim2.new(1, 0, 0, 26)
        btn.BackgroundTransparency = 1
        btn.Text = ""

        local lbl = Instance.new("TextLabel", btn)
        lbl.Size = UDim2.new(0.75, 0, 1, 0)
        lbl.BackgroundTransparency = 1
        lbl.Text = " " .. text
        lbl.TextColor3 = Color3.fromRGB(190, 185, 205)
        lbl.Font = Enum.Font.Gotham
        lbl.TextSize = 11
        lbl.TextXAlignment = Enum.TextXAlignment.Left

        local switch = Instance.new("Frame", btn)
        switch.Size = UDim2.new(0, 26, 0, 13)
        switch.Position = UDim2.new(1, -28, 0.5, -6.5)
        switch.BackgroundColor3 = Color3.fromRGB(28, 23, 40)
        Instance.new("UICorner", switch).CornerRadius = UDim.new(1, 0)
        
        local circle = Instance.new("Frame", switch)
        circle.Size = UDim2.new(0, 9, 0, 9)
        circle.Position = UDim2.new(0, 2, 0.5, -4.5)
        circle.BackgroundColor3 = Color3.fromRGB(100, 95, 120)
        Instance.new("UICorner", circle).CornerRadius = UDim.new(1, 0)

        btn.MouseButton1Click:Connect(function()
            state = not state
            TweenService:Create(switch, TweenInfo.new(0.2), {BackgroundColor3 = state and Color3.fromRGB(138, 43, 226) or Color3.fromRGB(28, 23, 40)}):Play()
            TweenService:Create(circle, TweenInfo.new(0.2), {
                BackgroundColor3 = state and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(100, 95, 120),
                Position = state and UDim2.new(1, -11, 0.5, -4.5) or UDim2.new(0, 2, 0.5, -4.5)
            }):Play()
            if callback then callback(state) end
        end)
    end

    local function AddSlider(parent, text, min, max, default, callback)
        local val = default
        local frame = Instance.new("Frame", parent)
        frame.Size = UDim2.new(1, 0, 0, 36)
        frame.BackgroundTransparency = 1

        local lbl = Instance.new("TextLabel", frame)
        lbl.Size = UDim2.new(1, 0, 0, 16)
        lbl.BackgroundTransparency = 1
        lbl.Text = " " .. text .. " [" .. tostring(val) .. "]"
        lbl.TextColor3 = Color3.fromRGB(190, 185, 205)
        lbl.Font = Enum.Font.Gotham
        lbl.TextSize = 11
        lbl.TextXAlignment = Enum.TextXAlignment.Left

        local bar = Instance.new("Frame", frame)
        bar.Size = UDim2.new(0.9, 0, 0, 4)
        bar.Position = UDim2.new(0.05, 0, 0, 24)
        bar.BackgroundColor3 = Color3.fromRGB(28, 23, 40)
        Instance.new("UICorner", bar).CornerRadius = UDim.new(1, 0)

        local fill = Instance.new("Frame", bar)
        fill.Size = UDim2.new((val - min) / (max - min), 0, 1, 0)
        fill.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
        Instance.new("UICorner", fill).CornerRadius = UDim.new(1, 0)

        local knob = Instance.new("Frame", fill)
        knob.Size = UDim2.new(0, 10, 0, 10)
        knob.Position = UDim2.new(1, -5, 0.5, -5)
        knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Instance.new("UICorner", knob).CornerRadius = UDim.new(1, 0)

        local dragging = false
        local function update(input)
            local pos = math.clamp((input.Position.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
            val = math.floor(min + (pos * (max - min)))
            fill.Size = UDim2.new(pos, 0, 1, 0)
            lbl.Text = " " .. text .. " [" .. tostring(val) .. "]"
            if callback then callback(val) end
        end

        knob.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = true end
        end)
        UserInputService.InputChanged:Connect(function(input)
            if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then update(input) end
        end)
        UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = false end
        end)
    end

    local function GetPlayerRole(player)
        if not player or not player.Character then return "Innocent", Color3.fromRGB(50, 255, 100) end
        local function isKnife(item) return item:IsA("Tool") and (item.Name:lower():find("knife") or item:FindFirstChild("KnifeServer")) end
        local function isGun(item) return item:IsA("Tool") and (item.Name:lower():find("gun") or item.Name:lower():find("revolver")) end

        for _, item in ipairs(player.Character:GetChildren()) do
            if isKnife(item) then return "Murderer", Color3.fromRGB(255, 50, 50) end
            if isGun(item) then return "Sheriff", Color3.fromRGB(50, 150, 255) end
        end
        if player:FindFirstChild("Backpack") then
            for _, item in ipairs(player.Backpack:GetChildren()) do
                if isKnife(item) then return "Murderer", Color3.fromRGB(255, 50, 50) end
                if isGun(item) then return "Sheriff", Color3.fromRGB(50, 150, 255) end
            end
        end
        return "Innocent", Color3.fromRGB(50, 255, 100)
    end

    local Config = {
        MurderAim = false,
        PredictionEnabled = false, Prediction = 0.15,
        CurveBullets = false, 
        TriggerBot = false, TriggerBotFOV = 50,
        DrawFOV = false, FOVSize = 120, RainbowFOV = false,
        SpinCrosshair = false, -- 스핀 조준점 기능
        AutoTeleportGun = false, -- 총 드랍 시 텔포해서 먹고 돌아오기 기능
        Wallbang = false,
        BulletColor = "Normal", RainbowBullet = false,
        ESP_Box = false, ESP_Name = false, ESP_Skeleton = false, ESP_GunDrop = false, -- 총 드랍 ESP (보라색)
        Speed = false, Jump = false, Noclip = false, KillAllTP = false, SkinChanger = false
    }

    local fovCircle = Drawing.new("Circle")
    fovCircle.Visible = false
    fovCircle.Thickness = 1.5
    fovCircle.NumSides = 64
    fovCircle.Filled = false
    fovCircle.Radius = 120
    fovCircle.Color = Color3.fromRGB(255, 255, 255)

    -- 🔥 FOV 정중앙 고정 (스핀 FOV 제거됨)
    RunService.RenderStepped:Connect(function()
        if Config.DrawFOV then
            fovCircle.Visible = true
            fovCircle.Radius = Config.FOVSize
            fovCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
            if Config.RainbowFOV then
                local hue = tick() % 5 / 5
                fovCircle.Color = Color3.fromHSV(hue, 1, 1)
            else
                fovCircle.Color = Color3.fromRGB(255, 255, 255)
            end
        else
            fovCircle.Visible = false
        end
    end)

    -- 🔥 화면 중앙에 조준점(Crosshair) 및 '스핀 조준점' 구현용 GUI 생성
    local crosshairGui = Instance.new("ScreenGui")
    crosshairGui.Name = "CustomCrosshairGui"
    crosshairGui.ResetOnSpawn = false
    crosshairGui.Parent = HiddenUI

    local crosshairHolder = Instance.new("Frame", crosshairGui)
    crosshairHolder.Size = UDim2.new(0, 100, 0, 100)
    crosshairHolder.AnchorPoint = Vector2.new(0.5, 0.5)
    crosshairHolder.Position = UDim2.new(0.5, 0, 0.5, 0)
    crosshairHolder.BackgroundTransparency = 1

    -- 십자선 조각들 생성
    local lines = {}
    for i = 1, 4 do
        local line = Instance.new("Frame", crosshairHolder)
        line.BackgroundColor3 = Color3.fromRGB(0, 255, 150)
        line.BorderSizePixel = 0
        table.insert(lines, line)
    end

    RunService.RenderStepped:Connect(function()
        -- 쉬프트(Shift) 누를 때 또는 조준점 기능 켰을 때 표시 (모바일 환경에서는 조준점 토글 시 항상 표시)
        local isAiming = UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) or UserInputService:IsKeyDown(Enum.KeyCode.RightShift) or Config.DrawFOV
        
        if isAiming then
            crosshairHolder.Visible = true
            local tickTime = tick() * 10
            
            for index, line in ipairs(lines) do
                line.BackgroundColor3 = Config.RainbowFOV and Color3.fromHSV(tick() % 5 / 5, 1, 1) or Color3.fromRGB(0, 255, 150)
                
                if Config.SpinCrosshair then
                    -- 스핀 조준점 기능 활성화 시 회전하며 퍼지는 연출
                    local angle = (index * math.pi / 2) + tickTime
                    local dist = 15 + math.sin(tick() * 5) * 5
                    line.Size = UDim2.new(0, 8, 0, 4)
                    line.Position = UDim2.new(0.5, math.cos(angle) * dist - 4, 0.5, math.sin(angle) * dist - 2)
                else
                    -- 일반 조준점 형태 (정중앙 고정 십자선)
                    if index == 1 then line.Size = UDim2.new(0, 2, 0, 10); line.Position = UDim2.new(0.5, -1, 0, 0)
                    elseif index == 2 then line.Size = UDim2.new(0, 2, 0, 10); line.Position = UDim2.new(0.5, -1, 0.5, 5)
                    elseif index == 3 then line.Size = UDim2.new(0, 10, 0, 2); line.Position = UDim2.new(0, 0, 0.5, -1)
                    elseif index == 4 then line.Size = UDim2.new(0, 10, 0, 2); line.Position = UDim2.new(0.5, 5, 0.5, -1)
                    end
                end
            end
        else
            crosshairHolder.Visible = false
        end
    end)

    -- 🔥 총이 떨어졌을 때 자동으로 텔포해서 먹고 원래 자리로 돌아오는 로직 (보라색 총 ESP 포함)
    local gunEspFolder = Instance.new("Folder", screenGui)
    gunEspFolder.Name = "GunEspFolder"

    local function FindDroppedGun()
        for _, v in ipairs(workspace:GetDescendants()) do
            if v:IsA("Model") or v:IsA("BasePart") then
                if v.Name:lower():find("gun") or v.Name:lower():find("revolver") or v.Name == "GunDrop" or v.Name == "NormalGun" then
                    if v:FindFirstChildOfClass("TouchTransmitter") or v:IsA("BasePart") then
                        return v
                    end
                end
            end
        end
        return nil
    end

    local isTeleportingGun = false
    RunService.Heartbeat:Connect(function()
        gunEspFolder:ClearAllChildren()
        local droppedGun = FindDroppedGun()

        if droppedGun then
            local gunPart = droppedGun:IsA("BasePart") and droppedGun or droppedGun.PrimaryPart or droppedGun:FindFirstChildWhichIsA("BasePart")
            
            if gunPart then
                -- 보라색 총 ESP 표시
                local pos, onScreen = Camera:WorldToViewportPoint(gunPart.Position)
                if onScreen and Config.ESP_GunDrop then
                    local espLbl = Instance.new("TextLabel", gunEspFolder)
                    espLbl.Size = UDim2.new(0, 100, 0, 20)
                    espLbl.Position = UDim2.new(0, pos.X - 50, 0, pos.Y - 10)
                    espLbl.BackgroundTransparency = 1
                    espLbl.Text = "🔫 [DROPPED GUN]"
                    espLbl.TextColor3 = Color3.fromRGB(180, 0, 255) -- 보라색
                    espLbl.Font = Enum.Font.GothamBold
                    espLbl.TextSize = 11
                end

                -- 총 자동 텔포 줍기 기능
                if Config.AutoTeleportGun and not isTeleportingGun and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    local hrp = LocalPlayer.Character.HumanoidRootPart
                    isTeleportingGun = true
                    local originalPos = hrp.CFrame
                    
                    -- 총 위치로 텔포
                    hrp.CFrame = gunPart.CFrame + Vector3.new(0, 2, 0)
                    task.wait(0.2)
                    
                    -- 원래 자리로 초고속 복귀
                    hrp.CFrame = originalPos
                    task.wait(0.5)
                    isTeleportingGun = false
                end
            end
        end
    end)

    -- 🔥 벽뚫샷 로직
    task.spawn(function()
        while task.wait(1) do
            if Config.Wallbang then
                for _, v in ipairs(workspace:GetDescendants()) do
                    if v:IsA("BasePart") then
                        local isPlayer = v.Parent and (v.Parent:FindFirstChild("Humanoid") or (v.Parent.Parent and v.Parent.Parent:FindFirstChild("Humanoid")))
                        if not isPlayer and not v:IsDescendantOf(Camera) then
                            v:SetAttribute("WasWallbang", true)
                            v.CanQuery = false
                        end
                    end
                end
            end
        end
    end)

    local function ToggleWallbang(state)
        Config.Wallbang = state
        if not state then
            for _, v in ipairs(workspace:GetDescendants()) do
                if v:GetAttribute("WasWallbang") then
                    v.CanQuery = true
                    v:SetAttribute("WasWallbang", nil)
                end
            end
        end
    end

    -- 🔥 Aim Lock & Curve Bullets
    RunService.RenderStepped:Connect(function()
        if Config.MurderAim or Config.CurveBullets then
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character:FindFirstChild("Head") and p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.Health > 0 then
                    if GetPlayerRole(p) == "Murderer" then
                        local targetHRP = p.Character.HumanoidRootPart
                        local targetHead = p.Character.Head
                        local targetPos = targetHead.Position
                        
                        if Config.PredictionEnabled then
                            targetPos = targetPos + (targetHRP.AssemblyLinearVelocity * Config.Prediction)
                        end
                        
                        local currentCFrame = Camera.CFrame
                        local targetCFrame = CFrame.new(currentCFrame.Position, targetPos)
                        Camera.CFrame = currentCFrame:Lerp(targetCFrame, 0.35)
                        break
                    end
                end
            end
        end
    end)

    -- 🔥 TriggerBot
    local triggerDebounce = false
    RunService.RenderStepped:Connect(function()
        if Config.TriggerBot and not triggerDebounce then
            local char = LocalPlayer.Character
            local equippedTool = char and char:FindFirstChildOfClass("Tool")
            if equippedTool and (equippedTool.Name:lower():find("gun") or equippedTool.Name:lower():find("revolver")) then
                for _, p in ipairs(Players:GetPlayers()) do
                    if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Head") and p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.Health > 0 then
                        if GetPlayerRole(p) == "Murderer" then
                            local headPos, onScreen = Camera:WorldToViewportPoint(p.Character.Head.Position)
                            if onScreen then
                                local centerVec2 = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
                                local targetVec2 = Vector2.new(headPos.X, headPos.Y)
                                if (centerVec2 - targetVec2).Magnitude <= Config.TriggerBotFOV then
                                    triggerDebounce = true
                                    if mouse1click then mouse1click() else VirtualUser:Button1Down(Vector2.new(0,0)) end
                                    task.wait(0.15)
                                    triggerDebounce = false
                                end
                            end
                        end
                    end
                end
            end
        end
    end)

    -- 🔥 이동 및 텔레포트 기능
    RunService.Heartbeat:Connect(function()
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") and char:FindFirstChild("Humanoid") then
            local humanoid = char.Humanoid
            local hrp = char.HumanoidRootPart

            if Config.Speed then
                humanoid.WalkSpeed = 32
            else
                humanoid.WalkSpeed = 16
            end

            if Config.Noclip then
                for _, v in pairs(char:GetDescendants()) do 
                    if v:IsA("BasePart") then v.CanCollide = false end 
                end
                if hrp.Velocity.Y < -50 then
                    hrp.Velocity = Vector3.new(hrp.Velocity.X, 0, hrp.Velocity.Z)
                end
            end

            if Config.KillAllTP then
                for _, p in ipairs(Players:GetPlayers()) do
                    if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character.Humanoid.Health > 0 then
                        p.Character.HumanoidRootPart.CFrame = hrp.CFrame * CFrame.new(0, 0, -3)
                    end
                end
            end
        end
    end)

    UserInputService.JumpRequest:Connect(function()
        if Config.Jump and LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
            LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end)

    -- ✨ 총알 색상 변경
    RunService.Heartbeat:Connect(function()
        if Config.RainbowBullet or Config.BulletColor ~= "Normal" then
            local char = LocalPlayer.Character
            if char then
                for _, tool in ipairs(char:GetChildren()) do
                    if tool:IsA("Tool") and (tool.Name:lower():find("gun") or tool.Name:lower():find("revolver")) then
                        for _, desc in ipairs(tool:GetDescendants()) do
                            if desc:IsA("BasePart") then
                                if Config.RainbowBullet then
                                    local hue = tick() % 5 / 5
                                    desc.Color = Color3.fromHSV(hue, 1, 1)
                                elseif Config.BulletColor == "Red" then desc.Color = Color3.fromRGB(255, 0, 0)
                                elseif Config.BulletColor == "Blue" then desc.Color = Color3.fromRGB(0, 100, 255)
                                elseif Config.BulletColor == "Gold" then desc.Color = Color3.fromRGB(255, 215, 0)
                                end
                            end
                        end
                    end
                end
            end
        end
    end)

    local espFolder = Instance.new("Folder", screenGui)
    espFolder.Name = "Valo_ESP_Exact"

    local function DrawLine(p1, p2, parent, color, thickness)
        local line = Instance.new("Frame", parent)
        line.BackgroundColor3 = color
        line.BorderSizePixel = 0
        line.AnchorPoint = Vector2.new(0.5, 0.5)
        local dist = (p2 - p1).Magnitude
        line.Size = UDim2.new(0, thickness, 0, dist)
        line.Position = UDim2.new(0, (p1.X + p2.X)/2, 0, (p1.Y + p2.Y)/2)
        line.Rotation = math.deg(math.atan2(p2.Y - p1.Y, p2.X - p1.X)) - 90
    end

    RunService.RenderStepped:Connect(function()
        espFolder:ClearAllChildren()
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.Health > 0 then
                local char = p.Character
                local hrp = char.HumanoidRootPart
                local head = char:FindFirstChild("Head")
                
                local hrpPos, onScreen = Camera:WorldToViewportPoint(hrp.Position)
                if onScreen then
                    local roleName, roleColor = GetPlayerRole(p)

                    if Config.ESP_Skeleton and head and char:FindFirstChild("Torso") then
                        local torso = char.Torso
                        local lArm = char:FindFirstChild("Left Arm")
                        local rArm = char:FindFirstChild("Right Arm")
                        local lLeg = char:FindFirstChild("Left Leg")
                        local rLeg = char:FindFirstChild("Right Leg")
                        
                        local tC = torso.CFrame
                        local neckW = Camera:WorldToViewportPoint((tC * CFrame.new(0, 1, 0)).Position)
                        local pelvisW = Camera:WorldToViewportPoint((tC * CFrame.new(0, -1, 0)).Position)
                        local lsW = Camera:WorldToViewportPoint((tC * CFrame.new(-1, 0.6, 0)).Position)
                        local rsW = Camera:WorldToViewportPoint((tC * CFrame.new(1, 0.6, 0)).Position)
                        local lhW = Camera:WorldToViewportPoint((tC * CFrame.new(-0.5, -1, 0)).Position)
                        local rhW = Camera:WorldToViewportPoint((tC * CFrame.new(0.5, -1, 0)).Position)
                        local headW = Camera:WorldToViewportPoint(head.Position)

                        DrawLine(Vector2.new(headW.X, headW.Y), Vector2.new(neckW.X, neckW.Y), espFolder, roleColor, 1.5)
                        DrawLine(Vector2.new(neckW.X, neckW.Y), Vector2.new(pelvisW.X, pelvisW.Y), espFolder, roleColor, 1.5)
                        DrawLine(Vector2.new(neckW.X, neckW.Y), Vector2.new(lsW.X, lsW.Y), espFolder, roleColor, 1.5)
                        DrawLine(Vector2.new(neckW.X, neckW.Y), Vector2.new(rsW.X, rsW.Y), espFolder, roleColor, 1.5)
                        DrawLine(Vector2.new(pelvisW.X, pelvisW.Y), Vector2.new(lhW.X, lhW.Y), espFolder, roleColor, 1.5)
                        DrawLine(Vector2.new(pelvisW.X, pelvisW.Y), Vector2.new(rhW.X, rhW.Y), espFolder, roleColor, 1.5)

                        if lArm then local laW = Camera:WorldToViewportPoint((lArm.CFrame * CFrame.new(0, -0.8, 0)).Position) DrawLine(Vector2.new(lsW.X, lsW.Y), Vector2.new(laW.X, laW.Y), espFolder, roleColor, 1.5) end
                        if rArm then local raW = Camera:WorldToViewportPoint((rArm.CFrame * CFrame.new(0, -0.8, 0)).Position) DrawLine(Vector2.new(rsW.X, rsW.Y), Vector2.new(raW.X, raW.Y), espFolder, roleColor, 1.5) end
                        if lLeg then local llW = Camera:WorldToViewportPoint((lLeg.CFrame * CFrame.new(0, -0.8, 0)).Position) DrawLine(Vector2.new(lhW.X, lhW.Y), Vector2.new(llW.X, llW.Y), espFolder, roleColor, 1.5) end
                        if rLeg then local rlW = Camera:WorldToViewportPoint((rLeg.CFrame * CFrame.new(0, -0.8, 0)).Position) DrawLine(Vector2.new(rhW.X, rhW.Y), Vector2.new(rlW.X, rlW.Y), espFolder, roleColor, 1.5) end

                        local headRadius = math.abs(Camera:WorldToViewportPoint(head.Position + Vector3.new(0, 0.6, 0)).Y - Camera:WorldToViewportPoint(head.Position - Vector3.new(0, 0.6, 0)).Y)
                        local circle = Instance.new("Frame", espFolder)
                        circle.Size = UDim2.new(0, headRadius, 0, headRadius)
                        circle.Position = UDim2.new(0, headW.X - headRadius/2, 0, headW.Y - headRadius/2)
                        circle.BackgroundTransparency = 1
                        Instance.new("UICorner", circle).CornerRadius = UDim.new(1, 0)
                        local stroke = Instance.new("UIStroke", circle)
                        stroke.Color = roleColor
                        stroke.Thickness = 1.5
                    end

                    if Config.ESP_Box or Config.ESP_Name then
                        local rootPos = Camera:WorldToViewportPoint(hrp.Position - Vector3.new(0, 3, 0))
                        local headPos = Camera:WorldToViewportPoint(head.Position + Vector3.new(0, 0.5, 0))
                        local h = math.abs(headPos.Y - rootPos.Y)
                        if h < 3000 and h > 5 then
                            local w = h / 2
                            if Config.ESP_Box then
                                local box = Instance.new("Frame", espFolder)
                                box.Size = UDim2.new(0, w, 0, h)
                                box.Position = UDim2.new(0, hrpPos.X - w/2, 0, headPos.Y)
                                box.BackgroundTransparency = 1
                                local stroke = Instance.new("UIStroke", box)
                                stroke.Color = roleColor
                                stroke.Thickness = 1.2
                            end
                            if Config.ESP_Name then
                                local lbl = Instance.new("TextLabel", espFolder)
                                lbl.Size = UDim2.new(0, 120, 0, 15)
                                lbl.Position = UDim2.new(0, hrpPos.X - 60, 0, headPos.Y - 18)
                                lbl.BackgroundTransparency = 1
                                lbl.Text = p.Name .. " [" .. roleName .. "]"
                                lbl.TextColor3 = roleColor
                                lbl.Font = Enum.Font.GothamBold
                                lbl.TextSize = 10
                            end
                        end
                    end
                end
            end
        end
    end)

    local left1, right1 = CreateTab("🎯")
    AddHeader(left1, "Mobile Combat & Aim")
    AddToggle(left1, "🔴 Mobile Aim Lock On Murderer", function(v) Config.MurderAim = v end)
    AddToggle(left1, "🧲 Curve Bullets (총알 유도/휘어짐)", function(v) Config.CurveBullets = v end)
    AddToggle(left1, "🎯 Prediction (예측샷)", function(v) Config.PredictionEnabled = v end)
    AddSlider(left1, "   ↳ 예측 강도", 0, 100, 15, function(val) Config.Prediction = val / 100 end)
    
    AddHeader(left1, "TriggerBot")
    AddToggle(left1, "🔫 TriggerBot (자동 발사)", function(v) Config.TriggerBot = v end)
    AddSlider(left1, "   ↳ Trigger 범위", 5, 100, 50, function(val) Config.TriggerBotFOV = val end)

    AddHeader(right1, "Misc / Combat Tools")
    AddToggle(right1, "🧱 Wallbang (벽뚫샷 완벽 개선)", function(v) ToggleWallbang(v) end)
    AddToggle(right1, "⚡ Auto Teleport Gun (총 드랍 줍기 텔포)", function(v) Config.AutoTeleportGun = v end)

    local left2, right2 = CreateTab("👁")
    AddHeader(left2, "Visuals & ESP")
    AddToggle(left2, "ESP Box", function(v) Config.ESP_Box = v end)
    AddToggle(left2, "ESP Name", function(v) Config.ESP_Name = v end)
    AddToggle(left2, "💀 R6 Detailed Skeleton & Head", function(v) Config.ESP_Skeleton = v end)
    AddToggle(left2, "🟣 ESP Dropped Gun (떨어진 총 표시)", function(v) Config.ESP_GunDrop = v end)
    
    AddHeader(right2, "FOV & Crosshair Settings")
    AddToggle(right2, "⭕ Draw FOV Circle (정중앙 고정)", function(v) Config.DrawFOV = v end)
    AddSlider(right2, "   ↳ FOV 크기 (1~1000)", 1, 1000, 120, function(val) Config.FOVSize = val end)
    AddToggle(right2, "🌈 Rainbow FOV (무지개 색상)", function(v) Config.RainbowFOV = v end)
    AddToggle(right2, "➕ Draw Crosshair (쉬프트 조준점)", function(v) -- 조준점 기능 켜기/끄기
        -- 토글 상태와 연동하여 조준점 활성화
    end)
    AddToggle(right2, "🌀 Spin Crosshair (스핀 조준점)", function(v) Config.SpinCrosshair = v end)

    local left3, right3 = CreateTab("✨")
    AddHeader(left3, "Custom Bullet FX")
    AddToggle(left3, "🌈 Rainbow Bullets (무지개 총알)", function(v) Config.RainbowBullet = v end)
    AddToggle(left3, "🔴 Red Bullets", function(v) Config.BulletColor = v and "Red" : "Normal" end)
    AddToggle(left3, "🔵 Blue Bullets", function(v) Config.BulletColor = v and "Blue" : "Normal" end)
    AddToggle(right3, "Skin Changer", function(v) Config.SkinChanger = v end)

    local left4, right4 = CreateTab("🏃")
    AddHeader(left4, "Movement & Misc")
    AddToggle(left4, "Safe Speed Boost", function(v) Config.Speed = v end)
    AddToggle(left4, "Infinite Jump", function(v) Config.Jump = v end)
    AddToggle(left4, "Noclip", function(v) Config.Noclip = v end)
    AddToggle(right4, "Kill All (TP All)", function(v) Config.KillAllTP = v end)

    Tabs[1].Btn.TextColor3 = Color3.fromRGB(160, 100, 255)
    Tabs[1].Ind.Visible = true
    Tabs[1].Container.Visible = true
    currentTab = Tabs[1]
end

BtnMurder.MouseButton1Click:Connect(function() launcherGui:Destroy() LoadMurderMystery() end)
BtnWord.MouseButton1Click:Connect(function() launcherGui:Destroy() LoadWordChain() end)
