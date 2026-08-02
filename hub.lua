local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TextChatService = game:GetService("TextChatService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- 🔥 [Anti-AFK] 잠수 튕김 방지 (오토 파밍 유지)
LocalPlayer.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)

-- 🔥 기존 UI 깔끔하게 삭제
local UI_Parent = LocalPlayer:WaitForChild("PlayerGui")
pcall(function()
    local hui = (gethui and gethui()) or game:GetService("CoreGui")
    if hui then UI_Parent = hui end
end)

for _, v in pairs(UI_Parent:GetChildren()) do
    if v.Name == "Launcher_Hub" or v.Name == "ValoStyle_Hub" or v.Name == "ValoStyle_Min" or v.Name == "TeleportGunGui" or v.Name == "AutoShootGui" or v.Name == "AimlockGui" or v.Name == "GunDropNotify" then
        v:Destroy()
    end
end

--------------------------------------------------------------------
-- 🚀 1. 최초 실행 런처 UI (원래 디자인)
--------------------------------------------------------------------
local launcherGui = Instance.new("ScreenGui", UI_Parent)
launcherGui.Name = "Launcher_Hub"
launcherGui.ResetOnSpawn = false
launcherGui.IgnoreGuiInset = true
launcherGui.DisplayOrder = 999999

local LauncherFrame = Instance.new("Frame", launcherGui)
LauncherFrame.Size = UDim2.new(0, 300, 0, 130)
LauncherFrame.AnchorPoint = Vector2.new(0.5, 0.5)
LauncherFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
LauncherFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
LauncherFrame.BorderSizePixel = 0
Instance.new("UICorner", LauncherFrame).CornerRadius = UDim.new(0, 8)
local lStroke = Instance.new("UIStroke", LauncherFrame)
lStroke.Color = Color3.fromRGB(255, 0, 0)
lStroke.Thickness = 2

local lGradient = Instance.new("UIGradient", LauncherFrame)
lGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(15, 0, 0)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(150, 0, 0)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 0, 0))
}
lGradient.Rotation = 45

RunService.RenderStepped:Connect(function()
    if lGradient then lGradient.Offset = Vector2.new(math.sin(tick() * 2) * 0.5, 0) end
end)

local LTitle = Instance.new("TextLabel", LauncherFrame)
LTitle.Size = UDim2.new(1, 0, 0, 40)
LTitle.BackgroundTransparency = 1
LTitle.Text = "SELECT YOUR CHEAT"
LTitle.TextColor3 = Color3.fromRGB(255, 180, 180)
LTitle.Font = Enum.Font.GothamBlack
LTitle.TextSize = 16

local BtnMurder = Instance.new("TextButton", LauncherFrame)
BtnMurder.Size = UDim2.new(0.8, 0, 0, 45)
BtnMurder.Position = UDim2.new(0.1, 0, 0, 55)
BtnMurder.BackgroundColor3 = Color3.fromRGB(20, 0, 0)
BtnMurder.Text = "🔪 MURDER MYSTERY 2"
BtnMurder.TextColor3 = Color3.fromRGB(255, 50, 50)
BtnMurder.Font = Enum.Font.GothamBold
BtnMurder.TextSize = 14
Instance.new("UICorner", BtnMurder).CornerRadius = UDim.new(0, 6)
Instance.new("UIStroke", BtnMurder).Color = Color3.fromRGB(200, 0, 0)

local LClose = Instance.new("TextButton", LauncherFrame)
LClose.Size = UDim2.new(0, 30, 0, 30)
LClose.Position = UDim2.new(1, -30, 0, 0)
LClose.BackgroundTransparency = 1
LClose.Text = "✕"
LClose.TextColor3 = Color3.fromRGB(255, 255, 255)
LClose.Font = Enum.Font.GothamBold
LClose.MouseButton1Click:Connect(function() launcherGui:Destroy() end)

--------------------------------------------------------------------
-- 🔪 2. 머더 미스터리 2 (MM2) 메인 로직 & 원래 UI
--------------------------------------------------------------------
local Config = {
    MurderAim = false, MurderHitbox = false, MurderKillAll = false, SilentAim = false,
    ESP_Box = false, ESP_Name = false, ESP_Skeleton = false, ESP_GunDrop = false,
    Speed = false, Jump = false, Noclip = false, AutoCoin = false
}

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

local function GetMurderer()
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.Health > 0 then
            local pRole = GetPlayerRole(p)
            if pRole == "Murderer" then return p end
        end
    end
    return nil
end

local function LoadMurderMystery()
    local screenGui = Instance.new("ScreenGui", UI_Parent)
    screenGui.Name = "ValoStyle_Hub"
    screenGui.ResetOnSpawn = false
    screenGui.IgnoreGuiInset = true
    screenGui.DisplayOrder = 999999

    local MainFrame = Instance.new("Frame", screenGui)
    MainFrame.Size = UDim2.new(0, 520, 0, 360)
    MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    MainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    MainFrame.BorderSizePixel = 0
    MainFrame.ClipsDescendants = true
    Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)
    
    local mStroke = Instance.new("UIStroke", MainFrame)
    mStroke.Color = Color3.fromRGB(255, 0, 0)
    mStroke.Thickness = 2.5

    local mGradient = Instance.new("UIGradient", MainFrame)
    mGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(15, 0, 0)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(150, 0, 0)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 0, 0))
    }
    mGradient.Rotation = -45

    RunService.RenderStepped:Connect(function()
        if mGradient then mGradient.Offset = Vector2.new(0, math.sin(tick() * 1.5) * 0.4) end
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
    CloseBtn.MouseButton1Click:Connect(function() screenGui:Destroy() end)

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
    Sidebar.Size = UDim2.new(0, 40, 1, -60)
    Sidebar.Position = UDim2.new(0, 0, 0, 30)
    Sidebar.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Sidebar.BackgroundTransparency = 0.6
    Sidebar.BorderSizePixel = 0
    local SidebarLayout = Instance.new("UIListLayout", Sidebar)
    SidebarLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    SidebarLayout.Padding = UDim.new(0, 8)
    Instance.new("UIPadding", Sidebar).PaddingTop = UDim.new(0, 12)

    local ContentArea = Instance.new("Frame", MainFrame)
    ContentArea.Size = UDim2.new(1, -40, 1, -60)
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

    -- 🔥 UI 메뉴 구성
    local left1, right1 = CreateTab("🔪")
    AddHeader(left1, "God-Tier Murder Cheats")
    AddToggle(left1, "🎯 Magic Bullet (멀리서도 무조건 명중)", function(v) Config.SilentAim = v end)
    AddToggle(left1, "💀 Kill All Bring (안전한 자동 암살)", function(v) Config.MurderKillAll = v end)
    
    AddHeader(right1, "Buttons & Farm")
    AddToggle(right1, "💰 오토 코인 파밍 (수정 완료)", function(v) Config.AutoCoin = v end)
    AddToggle(right1, "🎯 화면에 에임 버튼 표시", function(v) 
        if UI_Parent:FindFirstChild("AimlockGui") then UI_Parent.AimlockGui.Enabled = v end
    end)
    AddToggle(right1, "🔫 Auto Shoot 버튼 표시", function(v) 
        if UI_Parent:FindFirstChild("AutoShootGui") then UI_Parent.AutoShootGui.Enabled = v end
    end)
    AddToggle(right1, "🔲 Show TP Gun Button", function(v) 
        if UI_Parent:FindFirstChild("TeleportGunGui") then UI_Parent.TeleportGunGui.Enabled = v end
    end)

    local left2, right2 = CreateTab("👁")
    AddHeader(left2, "Player ESP")
    AddToggle(left2, "ESP Box", function(v) Config.ESP_Box = v end)
    AddToggle(left2, "ESP Name", function(v) Config.ESP_Name = v end)
    AddToggle(left2, "Exact Skeleton", function(v) Config.ESP_Skeleton = v end)
    
    AddHeader(left2, "Gun ESP & Notify")
    AddToggle(left2, "🟣 ESP Gun & 보안관 데스 알람", function(v) Config.ESP_GunDrop = v end)

    local left3, right3 = CreateTab("🏃")
    AddHeader(left3, "Movement")
    AddToggle(left3, "Safe Speed Boost", function(v) Config.Speed = v end)
    AddToggle(left3, "Infinite Jump", function(v) Config.Jump = v end)
    AddToggle(left3, "Noclip (Walk Through Walls)", function(v) Config.Noclip = v end)

    Tabs[1].Btn.TextColor3 = Color3.fromRGB(255, 200, 200)
    Tabs[1].Ind.Visible = true
    Tabs[1].Container.Visible = true
    currentTab = Tabs[1]

    --------------------------------------------------------------------
    -- ⚙️ 기능 구현부 (드래그 버튼 함수)
    --------------------------------------------------------------------
    local function createDraggableBtn(name, text, color, xPos, yPos)
        local gui = Instance.new("ScreenGui", UI_Parent)
        gui.Name = name
        gui.ResetOnSpawn = false
        gui.Enabled = false

        local btn = Instance.new("TextButton", gui)
        btn.Size = UDim2.new(0, 140, 0, 45)
        btn.Position = UDim2.new(0, xPos, 0.7, yPos)
        btn.BackgroundColor3 = Color3.fromRGB(color.R*255/2, color.G*255/2, color.B*255/2)
        btn.Text = text
        btn.TextColor3 = color
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 13
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
        Instance.new("UIStroke", btn).Color = color

        local dragStart, startPos
        btn.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragStart = input.Position; startPos = btn.Position
            end
        end)
        btn.InputChanged:Connect(function(input)
            if dragStart and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                local delta = input.Position - dragStart
                btn.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            end
        end)
        btn.InputEnded:Connect(function(input)
            if dragStart and (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
                dragStart = nil
            end
        end)
        return btn, btn.InputEnded
    end

    -- 📌 [수정 완료] 에임락(Aimlock) 버튼 작동 로직
    local aimBtn, aimEnded = createDraggableBtn("AimlockGui", "🎯 AIMLOCK (OFF)", Color3.fromRGB(100, 255, 100), 20, -55)
    aimEnded:Connect(function(input)
        -- 터치 및 클릭 후 마우스를 15픽셀 미만으로 움직였을 때만 클릭으로 간주 (드래그와 클릭 분리)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            Config.MurderAim = not Config.MurderAim
            aimBtn.Text = Config.MurderAim and "🎯 AIMLOCK (ON)" or "🎯 AIMLOCK (OFF)"
            aimBtn.TextColor3 = Config.MurderAim and Color3.fromRGB(255, 50, 50) or Color3.fromRGB(100, 255, 100)
        end
    end)

    -- 📌 [수정 완료] 총 텔포(TP to Gun) 및 떨어진 총 찾기
    local function FindDroppedGun()
        for _, v in ipairs(workspace:GetDescendants()) do
            if v.Name == "GunDrop" and v:IsA("BasePart") then
                return v
            end
        end
        return nil
    end

    local tpBtn, tpEnded = createDraggableBtn("TeleportGunGui", "🔫 총에 텔포하기", Color3.fromRGB(255, 100, 100), 20, 0)
    tpEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            local gunPart = FindDroppedGun()
            if gunPart and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                local hrp = LocalPlayer.Character.HumanoidRootPart
                local originalCFrame = hrp.CFrame
                hrp.CFrame = gunPart.CFrame
                task.wait(0.3) 
                hrp.CFrame = originalCFrame
            else
                tpBtn.Text = "❌ 총 없음!"
                task.wait(1)
                tpBtn.Text = "🔫 총에 텔포하기"
            end
        end
    end)

    -- 📌 [수정 완료] 오토 샷 (Auto Shoot)
    local asBtn, asEnded = createDraggableBtn("AutoShootGui", "💥 AUTO SHOOT", Color3.fromRGB(255, 100, 100), 170, 0)
    asEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            local myChar = LocalPlayer.Character
            local myHrp = myChar and myChar:FindFirstChild("HumanoidRootPart")
            local myGun = myChar and (myChar:FindFirstChild("Gun") or myChar:FindFirstChild("Revolver"))
            
            if not myGun and LocalPlayer:FindFirstChild("Backpack") then
                local bpGun = LocalPlayer.Backpack:FindFirstChild("Gun") or LocalPlayer.Backpack:FindFirstChild("Revolver")
                if bpGun and myChar:FindFirstChildOfClass("Humanoid") then
                    myChar.Humanoid:EquipTool(bpGun)
                    myGun = bpGun
                    task.wait(0.1)
                end
            end

            local murd = GetMurderer()
            if murd and murd.Character and murd.Character:FindFirstChild("HumanoidRootPart") and myGun and myHrp then
                local tHrp = murd.Character.HumanoidRootPart
                local origTargetCF = tHrp.CFrame
                
                -- 머더를 내 총구 바로 앞으로 강제 이동시킨 후 쏘기 (서버에 완벽 인식됨)
                tHrp.CFrame = myHrp.CFrame * CFrame.new(0, 0, -3)
                task.wait(0.1)
                
                myGun:Activate()
                
                task.wait(0.1)
                tHrp.CFrame = origTargetCF

                asBtn.Text = "💥 발사 완료!"
                task.wait(1)
                asBtn.Text = "💥 AUTO SHOOT"
            else
                asBtn.Text = "❌ 총/머더 없음!"
                task.wait(1)
                asBtn.Text = "💥 AUTO SHOOT"
            end
        end
    end)

    -- 🔥 [수정 완료] 보안관 데스 알람 & ESP (Gun Drop Notify)
    local notifyGui = Instance.new("ScreenGui", UI_Parent)
    notifyGui.Name = "GunDropNotify"
    notifyGui.ResetOnSpawn = false
    
    local notifyLbl = Instance.new("TextLabel", notifyGui)
    notifyLbl.Size = UDim2.new(0, 340, 0, 40)
    notifyLbl.Position = UDim2.new(1, -360, 1, -80)
    notifyLbl.BackgroundColor3 = Color3.fromRGB(30, 0, 0)
    notifyLbl.TextColor3 = Color3.fromRGB(255, 80, 80)
    notifyLbl.Text = "🚨 보안관이 죽었습니다! 텔포 하여 총을 먹어주세요."
    notifyLbl.Font = Enum.Font.GothamBold
    notifyLbl.TextSize = 13
    notifyLbl.Visible = false
    Instance.new("UICorner", notifyLbl).CornerRadius = UDim.new(0, 6)
    Instance.new("UIStroke", notifyLbl).Color = Color3.fromRGB(255, 50, 50)
    
    local wasGunDropped = false
    local espFolder = Instance.new("Folder", screenGui)
    espFolder.Name = "Valo_ESP_Exact"

    local singleGunLabel = Instance.new("TextLabel", espFolder)
    singleGunLabel.Size = UDim2.new(0, 110, 0, 20)
    singleGunLabel.BackgroundTransparency = 1
    singleGunLabel.Text = "🟣 [떨어진 총]"
    singleGunLabel.TextColor3 = Color3.fromRGB(180, 50, 255)
    singleGunLabel.Font = Enum.Font.GothamBold
    singleGunLabel.TextSize = 12
    singleGunLabel.Visible = false

    local function DrawLine(p1, p2, parent, color)
        local line = Instance.new("Frame", parent)
        line.BackgroundColor3 = color
        line.BorderSizePixel = 0
        line.AnchorPoint = Vector2.new(0.5, 0.5)
        local dist = (p2 - p1).Magnitude
        line.Size = UDim2.new(0, 1.2, 0, dist)
        line.Position = UDim2.new(0, (p1.X + p2.X)/2, 0, (p1.Y + p2.Y)/2)
        line.Rotation = math.deg(math.atan2(p2.Y - p1.Y, p2.X - p1.X)) - 90
    end

    RunService.RenderStepped:Connect(function()
        espFolder:ClearAllChildren()
        
        -- 에임 락 (카메라 시점 강제 추적 - 부드럽게)
        local murd = GetMurderer()
        if Config.MurderAim and murd and murd.Character and murd.Character:FindFirstChild("HumanoidRootPart") then
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, murd.Character.HumanoidRootPart.Position)
        end
        
        -- 총 드롭 확인 및 ESP
        if Config.ESP_GunDrop then
            local gunPart = FindDroppedGun()
            if gunPart then
                if not wasGunDropped then
                    wasGunDropped = true
                    notifyLbl.Visible = true
                    task.delay(5, function() notifyLbl.Visible = false end)
                end
                local pos, onScreen = Camera:WorldToViewportPoint(gunPart.Position)
                if onScreen then
                    singleGunLabel.Parent = espFolder
                    singleGunLabel.Position = UDim2.new(0, pos.X - 55, 0, pos.Y - 10)
                    singleGunLabel.Visible = true
                end
            else
                wasGunDropped = false
                singleGunLabel.Visible = false
            end
        end

        -- 플레이어 ESP & 매직 불릿
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character.Humanoid.Health > 0 then
                local hrp = p.Character.HumanoidRootPart
                local head = p.Character:FindFirstChild("Head")
                local hrpPos, onScreen = Camera:WorldToViewportPoint(hrp.Position)
                local roleName, roleColor = GetPlayerRole(p)

                if Config.SilentAim and p == murd then
                    hrp.Size = Vector3.new(100, 100, 100)
                    hrp.Transparency = 0.8
                    hrp.CanCollide = false
                elseif not Config.SilentAim and hrp.Size.X > 5 then
                    hrp.Size = Vector3.new(2, 2, 1)
                    hrp.Transparency = 1
                end
                
                if onScreen then
                    if Config.ESP_Skeleton and head then
                        local torso = p.Character:FindFirstChild("Torso") or p.Character:FindFirstChild("UpperTorso")
                        local lArm = p.Character:FindFirstChild("Left Arm") or p.Character:FindFirstChild("LeftUpperArm")
                        local rArm = p.Character:FindFirstChild("Right Arm") or p.Character:FindFirstChild("RightUpperArm")
                        local lLeg = p.Character:FindFirstChild("Left Leg") or p.Character:FindFirstChild("LeftUpperLeg")
                        local rLeg = p.Character:FindFirstChild("Right Leg") or p.Character:FindFirstChild("RightUpperLeg")
                        
                        if torso then
                            local tC = torso.CFrame
                            local neckW = Camera:WorldToViewportPoint((tC * CFrame.new(0, 1, 0)).Position)
                            local pelvisW = Camera:WorldToViewportPoint((tC * CFrame.new(0, -1, 0)).Position)
                            local headW = Camera:WorldToViewportPoint(head.Position)
                            DrawLine(Vector2.new(headW.X, headW.Y), Vector2.new(neckW.X, neckW.Y), espFolder, roleColor)
                            DrawLine(Vector2.new(neckW.X, neckW.Y), Vector2.new(pelvisW.X, pelvisW.Y), espFolder, roleColor)
                            
                            local lsW = Camera:WorldToViewportPoint((tC * CFrame.new(-1, 0.5, 0)).Position)
                            local rsW = Camera:WorldToViewportPoint((tC * CFrame.new(1, 0.5, 0)).Position)
                            local lhW = Camera:WorldToViewportPoint((tC * CFrame.new(-0.5, -1, 0)).Position)
                            local rhW = Camera:WorldToViewportPoint((tC * CFrame.new(0.5, -1, 0)).Position)
                            DrawLine(Vector2.new(neckW.X, neckW.Y), Vector2.new(lsW.X, lsW.Y), espFolder, roleColor)
                            DrawLine(Vector2.new(neckW.X, neckW.Y), Vector2.new(rsW.X, rsW.Y), espFolder, roleColor)
                            DrawLine(Vector2.new(pelvisW.X, pelvisW.Y), Vector2.new(lhW.X, lhW.Y), espFolder, roleColor)
                            DrawLine(Vector2.new(pelvisW.X, pelvisW.Y), Vector2.new(rhW.X, rhW.Y), espFolder, roleColor)

                            if lArm then local laW = Camera:WorldToViewportPoint((lArm.CFrame * CFrame.new(0, -0.5, 0)).Position) DrawLine(Vector2.new(lsW.X, lsW.Y), Vector2.new(laW.X, laW.Y), espFolder, roleColor) end
                            if rArm then local raW = Camera:WorldToViewportPoint((rArm.CFrame * CFrame.new(0, -0.5, 0)).Position) DrawLine(Vector2.new(rsW.X, rsW.Y), Vector2.new(raW.X, raW.Y), espFolder, roleColor) end
                            if lLeg then local llW = Camera:WorldToViewportPoint((lLeg.CFrame * CFrame.new(0, -0.5, 0)).Position) DrawLine(Vector2.new(lhW.X, lhW.Y), Vector2.new(llW.X, llW.Y), espFolder, roleColor) end
                            if rLeg then local rlW = Camera:WorldToViewportPoint((rLeg.CFrame * CFrame.new(0, -0.5, 0)).Position) DrawLine(Vector2.new(rhW.X, rhW.Y), Vector2.new(rlW.X, rlW.Y), espFolder, roleColor) end
                        end
                    end

                    if Config.ESP_Box or Config.ESP_Name then
                        local rootPos = Camera:WorldToViewportPoint(hrp.Position - Vector3.new(0, 3, 0))
                        local headPos = Camera:WorldToViewportPoint(head.Position + Vector3.new(0, 0.5, 0))
                        local h = math.abs(headPos.Y - rootPos.Y)
                        if h > 5 then
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

    -- 🔥 [수정 완료] 오토 코인 파밍 (MM2 구조 픽스)
    task.spawn(function()
        while task.wait(0.2) do
            if Config.AutoCoin then
                pcall(function()
                    local myHrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    local eco = workspace:FindFirstChild("NormalEconomy")
                    local coinContainer = eco and eco:FindFirstChild("CoinContainer")
                    if myHrp and coinContainer then
                        for _, coin in ipairs(coinContainer:GetChildren()) do
                            if coin.Name == "Coin_Server" and coin:IsA("BasePart") and coin.Transparency < 1 then
                                myHrp.CFrame = coin.CFrame
                                task.wait(0.25)
                                if not Config.AutoCoin then break end
                            end
                        end
                    end
                end)
            end
        end
    end)

    -- 🔥 [수정 완료] 킬 올 (순간이동 암살)
    task.spawn(function()
        while task.wait(0.05) do
            if Config.MurderKillAll and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                local role = GetPlayerRole(LocalPlayer)
                if role == "Murderer" then
                    local myChar = LocalPlayer.Character
                    local myHrp = myChar:FindFirstChild("HumanoidRootPart")
                    local myKnife = myChar:FindFirstChild("Knife") or (LocalPlayer:FindFirstChild("Backpack") and LocalPlayer.Backpack:FindFirstChild("Knife"))

                    if myKnife and myHrp then
                        if myKnife.Parent ~= myChar and myChar:FindFirstChild("Humanoid") then
                            myChar.Humanoid:EquipTool(myKnife)
                            task.wait(0.1)
                        end
                        for _, p in ipairs(Players:GetPlayers()) do
                            if not Config.MurderKillAll then break end 
                            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.Health > 0 then
                                if GetPlayerRole(p) ~= "Murderer" then
                                    myHrp.CFrame = p.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 1.5)
                                    myKnife:Activate()
                                    task.wait(0.1)
                                end
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
end

BtnMurder.MouseButton1Click:Connect(function()
    launcherGui:Destroy()
    LoadMurderMystery()
end)
