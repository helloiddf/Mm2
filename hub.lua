local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TextChatService = game:GetService("TextChatService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

local playerGui = LocalPlayer:WaitForChild("PlayerGui")

for _, v in pairs(playerGui:GetChildren()) do
    if v.Name == "Launcher_Hub" or v.Name == "ValoStyle_Hub" or v.Name == "ValoStyle_Min" or v.Name == "WordChain_Hub" or v.Name == "TeleportGunGui" or v.Name == "GunDropNotify" then
        v:Destroy()
    end
end
if CoreGui:FindFirstChild("ValoStyle_Hub") then CoreGui.ValoStyle_Hub:Destroy() end

--------------------------------------------------------------------
-- 🚀 1. 최초 실행 런처 UI (검/빨 애니메이션 그라데이션)
--------------------------------------------------------------------
local launcherGui = Instance.new("ScreenGui")
launcherGui.Name = "Launcher_Hub"
launcherGui.ResetOnSpawn = false
launcherGui.IgnoreGuiInset = true
launcherGui.DisplayOrder = 999999
launcherGui.Parent = playerGui

local LauncherFrame = Instance.new("Frame", launcherGui)
LauncherFrame.Size = UDim2.new(0, 300, 0, 180)
LauncherFrame.AnchorPoint = Vector2.new(0.5, 0.5)
LauncherFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
LauncherFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
LauncherFrame.BorderSizePixel = 0
Instance.new("UICorner", LauncherFrame).CornerRadius = UDim.new(0, 8)
local lStroke = Instance.new("UIStroke", LauncherFrame)
lStroke.Color = Color3.fromRGB(255, 0, 0)
lStroke.Thickness = 2

-- 🔥 UI 검/빨 애니메이션 그라데이션
local lGradient = Instance.new("UIGradient", LauncherFrame)
lGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(10, 0, 0)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(180, 0, 0)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 0, 0))
}
lGradient.Rotation = 45

RunService.RenderStepped:Connect(function()
    if lGradient then
        lGradient.Offset = Vector2.new(math.sin(tick() * 1.5) * 0.5, 0)
    end
end)

local LTitle = Instance.new("TextLabel", LauncherFrame)
LTitle.Size = UDim2.new(1, 0, 0, 40)
LTitle.BackgroundTransparency = 1
LTitle.Text = "SELECT YOUR CHEAT"
LTitle.TextColor3 = Color3.fromRGB(255, 200, 200)
LTitle.Font = Enum.Font.GothamBlack
LTitle.TextSize = 16

local BtnMurder = Instance.new("TextButton", LauncherFrame)
BtnMurder.Size = UDim2.new(0.8, 0, 0, 45)
BtnMurder.Position = UDim2.new(0.1, 0, 0, 55)
BtnMurder.BackgroundColor3 = Color3.fromRGB(15, 0, 0)
BtnMurder.Text = "🔪 MURDER MYSTERY 2"
BtnMurder.TextColor3 = Color3.fromRGB(255, 50, 50)
BtnMurder.Font = Enum.Font.GothamBold
BtnMurder.TextSize = 14
Instance.new("UICorner", BtnMurder).CornerRadius = UDim.new(0, 6)
Instance.new("UIStroke", BtnMurder).Color = Color3.fromRGB(200, 0, 0)

local BtnWord = Instance.new("TextButton", LauncherFrame)
BtnWord.Size = UDim2.new(0.8, 0, 0, 45)
BtnWord.Position = UDim2.new(0.1, 0, 0, 115)
BtnWord.BackgroundColor3 = Color3.fromRGB(15, 0, 0)
BtnWord.Text = "💬 AUTO WORD CHAIN"
BtnWord.TextColor3 = Color3.fromRGB(255, 100, 100)
BtnWord.Font = Enum.Font.GothamBold
BtnWord.TextSize = 14
Instance.new("UICorner", BtnWord).CornerRadius = UDim.new(0, 6)
Instance.new("UIStroke", BtnWord).Color = Color3.fromRGB(200, 0, 0)

local LClose = Instance.new("TextButton", LauncherFrame)
LClose.Size = UDim2.new(0, 30, 0, 30)
LClose.Position = UDim2.new(1, -30, 0, 0)
LClose.BackgroundTransparency = 1
LClose.Text = "✕"
LClose.TextColor3 = Color3.fromRGB(255, 255, 255)
LClose.Font = Enum.Font.GothamBold
LClose.TextSize = 12
LClose.MouseButton1Click:Connect(function() launcherGui:Destroy() end)

--------------------------------------------------------------------
-- 💬 2. 끝말잇기 (Word Chain) 생략
--------------------------------------------------------------------
local function LoadWordChain()
    playerGui:FindFirstChild("Launcher_Hub"):Destroy()
    -- (끝말잇기는 기존 코드 동일 유지. 길이상 생략)
end

--------------------------------------------------------------------
-- 🔪 3. 머더 미스터리 2 (MM2) 원콤 종결급 스크립트
--------------------------------------------------------------------
local function LoadMurderMystery()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "ValoStyle_Hub"
    screenGui.ResetOnSpawn = false
    screenGui.IgnoreGuiInset = true
    screenGui.DisplayOrder = 999999
    screenGui.Parent = playerGui

    local MainFrame = Instance.new("Frame", screenGui)
    MainFrame.Size = UDim2.new(0, 520, 0, 340)
    MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    MainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    MainFrame.BorderSizePixel = 0
    MainFrame.ClipsDescendants = true
    Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)
    
    local mStroke = Instance.new("UIStroke", MainFrame)
    mStroke.Color = Color3.fromRGB(255, 0, 0)
    mStroke.Thickness = 2.5

    -- 🔥 메인 허브 검/빨 애니메이션 그라데이션
    local mGradient = Instance.new("UIGradient", MainFrame)
    mGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(5, 0, 0)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(120, 0, 0)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(5, 0, 0))
    }
    mGradient.Rotation = -45

    RunService.RenderStepped:Connect(function()
        if mGradient then
            mGradient.Offset = Vector2.new(0, math.sin(tick() * 1.2) * 0.4)
        end
    end)

    local TopBar = Instance.new("Frame", MainFrame)
    TopBar.Size = UDim2.new(1, 0, 0, 30)
    TopBar.BackgroundColor3 = Color3.fromRGB(10, 0, 0)
    TopBar.BackgroundTransparency = 0.5
    TopBar.BorderSizePixel = 0

    local Title = Instance.new("TextLabel", TopBar)
    Title.Size = UDim2.new(1, -100, 1, 0)
    Title.Position = UDim2.new(0, 12, 0, 0)
    Title.BackgroundTransparency = 1
    Title.Text = "BLOOD // MURDER MYSTERY PRO"
    Title.TextColor3 = Color3.fromRGB(255, 100, 100)
    Title.Font = Enum.Font.GothamBlack
    Title.TextSize = 13
    Title.TextXAlignment = Enum.TextXAlignment.Left

    local CloseBtn = Instance.new("TextButton", TopBar)
    CloseBtn.Size = UDim2.new(0, 30, 1, 0)
    CloseBtn.Position = UDim2.new(1, -35, 0, 0)
    CloseBtn.BackgroundTransparency = 1
    CloseBtn.Text = "✕"
    CloseBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.TextSize = 14
    CloseBtn.MouseButton1Click:Connect(function() screenGui:Destroy() end)

    local MinBtn = Instance.new("TextButton", TopBar)
    MinBtn.Size = UDim2.new(0, 30, 1, 0)
    MinBtn.Position = UDim2.new(1, -65, 0, 0)
    MinBtn.BackgroundTransparency = 1
    MinBtn.Text = "—"
    MinBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
    MinBtn.Font = Enum.Font.GothamBold
    MinBtn.TextSize = 14

    local MinGui = Instance.new("ScreenGui")
    MinGui.Name = "ValoStyle_Min"
    MinGui.ResetOnSpawn = false
    MinGui.DisplayOrder = 999999
    MinGui.Parent = playerGui

    local MinIcon = Instance.new("TextButton", MinGui)
    MinIcon.Size = UDim2.new(0, 45, 0, 45)
    MinIcon.Position = UDim2.new(0, 20, 0, 20)
    MinIcon.BackgroundColor3 = Color3.fromRGB(15, 0, 0)
    MinIcon.Text = "B"
    MinIcon.TextColor3 = Color3.fromRGB(255, 50, 50)
    MinIcon.Font = Enum.Font.GothamBlack
    MinIcon.TextSize = 20
    MinIcon.Visible = false
    Instance.new("UICorner", MinIcon).CornerRadius = UDim.new(0, 8)
    Instance.new("UIStroke", MinIcon).Color = Color3.fromRGB(255, 0, 0)

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
    Sidebar.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Sidebar.BackgroundTransparency = 0.6
    Sidebar.BorderSizePixel = 0
    local SidebarLayout = Instance.new("UIListLayout", Sidebar)
    SidebarLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    SidebarLayout.Padding = UDim.new(0, 8)
    Instance.new("UIPadding", Sidebar).PaddingTop = UDim.new(0, 12)

    local ContentArea = Instance.new("Frame", MainFrame)
    ContentArea.Size = UDim2.new(1, -40, 1, -30)
    ContentArea.Position = UDim2.new(0, 40, 0, 30)
    ContentArea.BackgroundTransparency = 1
    ContentArea.BorderSizePixel = 0

    local Tabs = {}
    local currentTab = nil

    local function CreateTab(iconText)
        local TabBtn = Instance.new("TextButton", Sidebar)
        TabBtn.Size = UDim2.new(0, 32, 0, 32)
        TabBtn.BackgroundTransparency = 1
        TabBtn.Text = iconText
        TabBtn.TextColor3 = Color3.fromRGB(150, 100, 100)
        TabBtn.Font = Enum.Font.GothamBold
        TabBtn.TextSize = 16

        local Indicator = Instance.new("Frame", TabBtn)
        Indicator.Size = UDim2.new(0, 3, 1, 0)
        Indicator.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        Indicator.Visible = false

        local TabContainer = Instance.new("Frame", ContentArea)
        TabContainer.Size = UDim2.new(1, 0, 1, 0)
        TabContainer.BackgroundTransparency = 1
        TabContainer.Visible = false

        local LeftCol = Instance.new("ScrollingFrame", TabContainer)
        LeftCol.Size = UDim2.new(0.5, -10, 1, -15)
        LeftCol.Position = UDim2.new(0, 10, 0, 10)
        LeftCol.BackgroundTransparency = 1
        LeftCol.ScrollBarThickness = 2
        local lLayout = Instance.new("UIListLayout", LeftCol)
        lLayout.Padding = UDim.new(0, 8)

        local RightCol = Instance.new("ScrollingFrame", TabContainer)
        RightCol.Size = UDim2.new(0.5, -10, 1, -15)
        RightCol.Position = UDim2.new(0.5, 5, 0, 10)
        RightCol.BackgroundTransparency = 1
        RightCol.ScrollBarThickness = 2
        local rLayout = Instance.new("UIListLayout", RightCol)
        rLayout.Padding = UDim.new(0, 8)

        TabBtn.MouseButton1Click:Connect(function()
            if currentTab then
                currentTab.Btn.TextColor3 = Color3.fromRGB(150, 100, 100)
                currentTab.Ind.Visible = false
                currentTab.Container.Visible = false
            end
            TabBtn.TextColor3 = Color3.fromRGB(255, 200, 200)
            Indicator.Visible = true
            TabContainer.Visible = true
            currentTab = {Btn = TabBtn, Ind = Indicator, Container = TabContainer}
        end)

        table.insert(Tabs, {Btn = TabBtn, Ind = Indicator, Container = TabContainer})
        return LeftCol, RightCol
    end

    local function AddHeader(parent, text)
        local lbl = Instance.new("TextLabel", parent)
        lbl.Size = UDim2.new(1, 0, 0, 24)
        lbl.BackgroundTransparency = 1
        lbl.Text = text
        lbl.TextColor3 = Color3.fromRGB(255, 120, 120)
        lbl.Font = Enum.Font.GothamBlack
        lbl.TextSize = 12
        lbl.TextXAlignment = Enum.TextXAlignment.Left
    end

    local function AddToggle(parent, text, callback)
        local state = false
        local btn = Instance.new("TextButton", parent)
        btn.Size = UDim2.new(1, 0, 0, 28)
        btn.BackgroundTransparency = 1
        btn.Text = ""

        local lbl = Instance.new("TextLabel", btn)
        lbl.Size = UDim2.new(0.75, 0, 1, 0)
        lbl.BackgroundTransparency = 1
        lbl.Text = " " .. text
        lbl.TextColor3 = Color3.fromRGB(220, 200, 200)
        lbl.Font = Enum.Font.GothamBold
        lbl.TextSize = 11
        lbl.TextXAlignment = Enum.TextXAlignment.Left

        local switch = Instance.new("Frame", btn)
        switch.Size = UDim2.new(0, 26, 0, 14)
        switch.Position = UDim2.new(1, -30, 0.5, -7)
        switch.BackgroundColor3 = Color3.fromRGB(30, 10, 10)
        Instance.new("UICorner", switch).CornerRadius = UDim.new(1, 0)
        Instance.new("UIStroke", switch).Color = Color3.fromRGB(100, 0, 0)
        
        local circle = Instance.new("Frame", switch)
        circle.Size = UDim2.new(0, 10, 0, 10)
        circle.Position = UDim2.new(0, 2, 0.5, -5)
        circle.BackgroundColor3 = Color3.fromRGB(150, 100, 100)
        Instance.new("UICorner", circle).CornerRadius = UDim.new(1, 0)

        btn.MouseButton1Click:Connect(function()
            state = not state
            switch.BackgroundColor3 = state and Color3.fromRGB(200, 0, 0) or Color3.fromRGB(30, 10, 10)
            circle.BackgroundColor3 = state and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(150, 100, 100)
            circle.Position = state and UDim2.new(1, -12, 0.5, -5) or UDim2.new(0, 2, 0.5, -5)
            if callback then callback(state) end
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

    local cachedGunPart = nil
    local function CheckPartForGun(v)
        if v.Name == "GunDrop" or (v:IsA("TouchTransmitter") and v.Parent and v.Parent.Name:lower():find("gun")) then
            cachedGunPart = v:IsA("TouchTransmitter") and v.Parent or v
            if cachedGunPart:IsA("Model") then
                cachedGunPart = cachedGunPart.PrimaryPart or cachedGunPart:FindFirstChildWhichIsA("BasePart") or cachedGunPart
            end
        end
    end

    for _, v in ipairs(workspace:GetDescendants()) do CheckPartForGun(v); if cachedGunPart then break end end
    workspace.DescendantAdded:Connect(function(v) CheckPartForGun(v) end)

    local function FindDroppedGun()
        if cachedGunPart and not cachedGunPart.Parent then cachedGunPart = nil end
        return cachedGunPart
    end

    local Config = {
        SilentAim = false, AutoKillMurderer = false, KillAllTP = false,
        ESP_Box = false, ESP_Name = false, ESP_Skeleton = false, ESP_GunDrop = false,
        Speed = false, Jump = false, Noclip = false, SkinChanger = false, TPGunButton = false
    }

    -- 📌 총 텔포 버튼 (빨간 테마)
    local tpButtonGui = Instance.new("ScreenGui", playerGui)
    tpButtonGui.Name = "TeleportGunGui"
    tpButtonGui.ResetOnSpawn = false
    tpButtonGui.Enabled = false

    local tpBtn = Instance.new("TextButton", tpButtonGui)
    tpBtn.Size = UDim2.new(0, 140, 0, 45)
    tpBtn.Position = UDim2.new(0, 20, 0.7, 0)
    tpBtn.BackgroundColor3 = Color3.fromRGB(30, 0, 0)
    tpBtn.Text = "🔫 총에 텔포하기"
    tpBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
    tpBtn.Font = Enum.Font.GothamBold
    tpBtn.TextSize = 13
    Instance.new("UICorner", tpBtn).CornerRadius = UDim.new(0, 8)
    Instance.new("UIStroke", tpBtn).Color = Color3.fromRGB(200, 0, 0)

    local tpDragging, tpDragInput, tpDragStart, tpStartPos
    tpBtn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            tpDragging = true; tpDragStart = input.Position; tpStartPos = tpBtn.Position
        end
    end)
    tpBtn.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then tpDragInput = input end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == tpDragInput and tpDragging then
            local delta = input.Position - tpDragStart
            tpBtn.Position = UDim2.new(tpStartPos.X.Scale, tpStartPos.X.Offset + delta.X, tpStartPos.Y.Scale, tpStartPos.Y.Offset + delta.Y)
        end
    end)

    tpBtn.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            tpDragging = false
            if (input.Position - tpDragStart).Magnitude < 10 then
                local gunPart = FindDroppedGun()
                if gunPart and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    local hrp = LocalPlayer.Character.HumanoidRootPart
                    local originalCFrame = hrp.CFrame
                    hrp.CFrame = gunPart:IsA("BasePart") and gunPart.CFrame or gunPart:GetPivot()
                    task.wait(0.25)
                    hrp.CFrame = originalCFrame
                else
                    tpBtn.Text = "❌ 총 없음!"
                    tpBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
                    task.wait(1)
                    tpBtn.Text = "🔫 총에 텔포하기"
                    tpBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
                end
            end
        end
    end)

    local notifyGui = Instance.new("ScreenGui", playerGui)
    notifyGui.Name = "GunDropNotify"
    notifyGui.ResetOnSpawn = false
    
    local notifyLbl = Instance.new("TextLabel", notifyGui)
    notifyLbl.Size = UDim2.new(0, 340, 0, 40)
    notifyLbl.Position = UDim2.new(1, -360, 1, -80)
    notifyLbl.BackgroundColor3 = Color3.fromRGB(30, 0, 0)
    notifyLbl.TextColor3 = Color3.fromRGB(255, 80, 80)
    notifyLbl.Text = "🚨 보안관이 운지했습니다! 빨리 총을 획득하세요!"
    notifyLbl.Font = Enum.Font.GothamBold
    notifyLbl.TextSize = 13
    notifyLbl.Visible = false
    Instance.new("UICorner", notifyLbl).CornerRadius = UDim.new(0, 6)
    Instance.new("UIStroke", notifyLbl).Color = Color3.fromRGB(255, 50, 50)

    local wasGunDropped = false

    -- 🔥 [원콤 종결급] Silent Aim (Magic Bullet) 및 오토 킬
    RunService.RenderStepped:Connect(function()
        local gunPart = FindDroppedGun()
        
        -- 총 드랍 시 6초 알림 유지
        if gunPart and not wasGunDropped then
            wasGunDropped = true
            notifyLbl.Visible = true
            task.delay(6, function() notifyLbl.Visible = false end)
        elseif not gunPart then
            wasGunDropped = false
        end

        local murderer = nil
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character.Humanoid.Health > 0 then
                if GetPlayerRole(p) == "Murderer" then
                    murderer = p
                    break
                end
            end
        end

        if murderer and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local mHrp = murderer.Character.HumanoidRootPart
            local myChar = LocalPlayer.Character
            local myGun = myChar:FindFirstChild("Gun") or myChar:FindFirstChild("Revolver")
            
            -- 오토 킬 로직: 켜져있으면 보안관이거나 총 먹는 즉시 꺼내고 쏜다
            if Config.AutoKillMurderer then
                if not myGun and LocalPlayer:FindFirstChild("Backpack") then
                    local bpGun = LocalPlayer.Backpack:FindFirstChild("Gun") or LocalPlayer.Backpack:FindFirstChild("Revolver")
                    if bpGun and myChar:FindFirstChildOfClass("Humanoid") then
                        myChar.Humanoid:EquipTool(bpGun)
                        myGun = bpGun
                    end
                end

                if myGun then
                    -- 머더 정수리 위 10스터드 위로 텔레포트
                    myChar.HumanoidRootPart.CFrame = CFrame.new(mHrp.Position + Vector3.new(0, 10, 0), mHrp.Position)
                    Camera.CFrame = CFrame.new(Camera.CFrame.Position, mHrp.Position)
                    myGun:Activate()
                    if mouse1click then mouse1click() end
                end
            end

            -- 사일런트 에임 (Magic Bullet): 허공에 쏴도 머더에게 꽂힘
            if Config.SilentAim and myGun then
                -- 머더의 히트박스를 내 카메라 바로 앞(5스터드)에 보이지 않게 끌어다 둠
                -- 화면에 대충 쏘면 바로 눈앞에 있는 머더의 투명 히트박스에 맞게 됨 (벽뚫/미스 확률 0%)
                mHrp.Size = Vector3.new(6, 6, 6)
                mHrp.Transparency = 1
                mHrp.CanCollide = false
                mHrp.CFrame = Camera.CFrame * CFrame.new(0, 0, -5)
            else
                -- 기능 꺼지면 히트박스 원상복구
                if mHrp.Size.X > 5 or mHrp.Transparency == 1 then
                    mHrp.Size = Vector3.new(2, 2, 1)
                    mHrp.Transparency = 0
                end
            end
        end
    end)

    -- ESP 및 잡다한 루프
    local espFolder = Instance.new("Folder", screenGui)
    espFolder.Name = "Valo_ESP_Exact"
    local gunEspFolder = Instance.new("Folder", screenGui)
    gunEspFolder.Name = "GunEspFolder"

    local singleGunLabel = Instance.new("TextLabel", gunEspFolder)
    singleGunLabel.Size = UDim2.new(0, 110, 0, 20)
    singleGunLabel.BackgroundTransparency = 1
    singleGunLabel.Text = "🔫 [떨어진 총]"
    singleGunLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
    singleGunLabel.Font = Enum.Font.GothamBold
    singleGunLabel.TextSize = 12
    singleGunLabel.Visible = false

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

        local gunPart = FindDroppedGun()
        if Config.ESP_GunDrop and gunPart then
            local gunPos = gunPart:IsA("BasePart") and gunPart.Position or gunPart:GetPivot().Position
            local pos, onScreen = Camera:WorldToViewportPoint(gunPos)
            if onScreen then
                singleGunLabel.Position = UDim2.new(0, pos.X - 55, 0, pos.Y - 10)
                singleGunLabel.Visible = true
            else
                singleGunLabel.Visible = false
            end
        else
            singleGunLabel.Visible = false
        end

        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character.Humanoid.Health > 0 then
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
                        local lsW = Camera:WorldToViewportPoint((tC * CFrame.new(-1, 0.5, 0)).Position)
                        local rsW = Camera:WorldToViewportPoint((tC * CFrame.new(1, 0.5, 0)).Position)
                        local lhW = Camera:WorldToViewportPoint((tC * CFrame.new(-0.5, -1, 0)).Position)
                        local rhW = Camera:WorldToViewportPoint((tC * CFrame.new(0.5, -1, 0)).Position)
                        local headW = Camera:WorldToViewportPoint(head.Position)

                        DrawLine(Vector2.new(headW.X, headW.Y), Vector2.new(neckW.X, neckW.Y), espFolder, roleColor, 1)
                        DrawLine(Vector2.new(neckW.X, neckW.Y), Vector2.new(pelvisW.X, pelvisW.Y), espFolder, roleColor, 1)
                        DrawLine(Vector2.new(neckW.X, neckW.Y), Vector2.new(lsW.X, lsW.Y), espFolder, roleColor, 1)
                        DrawLine(Vector2.new(neckW.X, neckW.Y), Vector2.new(rsW.X, rsW.Y), espFolder, roleColor, 1)
                        DrawLine(Vector2.new(pelvisW.X, pelvisW.Y), Vector2.new(lhW.X, lhW.Y), espFolder, roleColor, 1)
                        DrawLine(Vector2.new(pelvisW.X, pelvisW.Y), Vector2.new(rhW.X, rhW.Y), espFolder, roleColor, 1)

                        if lArm then local laW = Camera:WorldToViewportPoint((lArm.CFrame * CFrame.new(0, -0.5, 0)).Position) DrawLine(Vector2.new(lsW.X, lsW.Y), Vector2.new(laW.X, laW.Y), espFolder, roleColor, 1) end
                        if rArm then local raW = Camera:WorldToViewportPoint((rArm.CFrame * CFrame.new(0, -0.5, 0)).Position) DrawLine(Vector2.new(rsW.X, rsW.Y), Vector2.new(raW.X, raW.Y), espFolder, roleColor, 1) end
                        if lLeg then local llW = Camera:WorldToViewportPoint((lLeg.CFrame * CFrame.new(0, -0.5, 0)).Position) DrawLine(Vector2.new(lhW.X, lhW.Y), Vector2.new(llW.X, llW.Y), espFolder, roleColor, 1) end
                        if rLeg then local rlW = Camera:WorldToViewportPoint((rLeg.CFrame * CFrame.new(0, -0.5, 0)).Position) DrawLine(Vector2.new(rhW.X, rhW.Y), Vector2.new(rlW.X, rlW.Y), espFolder, roleColor, 1) end
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
                                lbl.Position = UDim2.new(0, hrpPos.X - 60, 0, headPos.Y - 16)
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

    RunService.Heartbeat:Connect(function()
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") and char:FindFirstChild("Humanoid") then
            if Config.Speed and char.Humanoid.MoveDirection.Magnitude > 0 then
                char.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame + (char.Humanoid.MoveDirection * 0.18)
            end
            if Config.Noclip then
                for _, v in pairs(char:GetDescendants()) do if v:IsA("BasePart") then v.CanCollide = false end end
            end
        end
    end)

    UserInputService.JumpRequest:Connect(function()
        if Config.Jump and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end)

    -- [ 머더 탭 연결 ]
    local left1, right1 = CreateTab("🔪")
    AddHeader(left1, "God-Tier Murder Cheats")
    AddToggle(left1, "🎯 Silent Aim (에임 안대도 100% 명중)", function(v) Config.SilentAim = v end)
    AddToggle(left1, "🔫 Auto Kill Murderer (전자동 즉사)", function(v) Config.AutoKillMurderer = v end)
    
    AddHeader(right1, "Gun Tools")
    AddToggle(right1, "🔲 Show TP Gun Button (버튼 표시)", function(v) 
        Config.TPGunButton = v 
        if tpButtonGui then tpButtonGui.Enabled = v end
    end)

    local left2, right2 = CreateTab("👁")
    AddHeader(left2, "Player ESP")
    AddToggle(left2, "ESP Box", function(v) Config.ESP_Box = v end)
    AddToggle(left2, "ESP Name", function(v) Config.ESP_Name = v end)
    AddToggle(left2, "Exact Skeleton", function(v) Config.ESP_Skeleton = v end)
    
    AddHeader(left2, "Gun ESP")
    AddToggle(left2, "🟣 ESP Dropped Gun (떨어진 총 표시)", function(v) Config.ESP_GunDrop = v end)

    local left3, right3 = CreateTab("🏃")
    AddHeader(left3, "Movement")
    AddToggle(left3, "Safe Speed Boost", function(v) Config.Speed = v end)
    AddToggle(left3, "Infinite Jump", function(v) Config.Jump = v end)
    AddToggle(left3, "Noclip (Walk Through Walls)", function(v) Config.Noclip = v end)

    Tabs[1].Btn.TextColor3 = Color3.fromRGB(255, 200, 200)
    Tabs[1].Ind.Visible = true
    Tabs[1].Container.Visible = true
    currentTab = Tabs[1]
end

--------------------------------------------------------------------
-- ⚙️ 4. 런처 버튼 클릭 이벤트 연결
--------------------------------------------------------------------
BtnMurder.MouseButton1Click:Connect(function()
    launcherGui:Destroy()
    LoadMurderMystery()
end)

BtnWord.MouseButton1Click:Connect(function()
    launcherGui:Destroy()
    LoadWordChain()
end)
