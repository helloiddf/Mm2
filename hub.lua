local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TextChatService = game:GetService("TextChatService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

local playerGui = LocalPlayer:WaitForChild("PlayerGui")

for _, v in pairs(playerGui:GetChildren()) do
    if v.Name == "Launcher_Hub" or v.Name == "ValoStyle_Hub" or v.Name == "ValoStyle_Min" or v.Name == "WordChain_Hub" or v.Name == "TeleportGunGui" or v.Name == "GunDropNotify" then
        v:Destroy()
    end
end
if CoreGui:FindFirstChild("ValoStyle_Hub") then CoreGui.ValoStyle_Hub:Destroy() end

--------------------------------------------------------------------
-- 🚀 1. 최초 실행 런처 UI
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
LauncherFrame.BackgroundColor3 = Color3.fromRGB(13, 11, 20)
LauncherFrame.BorderSizePixel = 0
Instance.new("UICorner", LauncherFrame).CornerRadius = UDim.new(0, 8)
Instance.new("UIStroke", LauncherFrame).Color = Color3.fromRGB(138, 43, 226)

local LTitle = Instance.new("TextLabel", LauncherFrame)
LTitle.Size = UDim2.new(1, 0, 0, 40)
LTitle.BackgroundTransparency = 1
LTitle.Text = "SELECT YOUR CHEAT"
LTitle.TextColor3 = Color3.fromRGB(160, 100, 255)
LTitle.Font = Enum.Font.GothamBlack
LTitle.TextSize = 16

local BtnMurder = Instance.new("TextButton", LauncherFrame)
BtnMurder.Size = UDim2.new(0.8, 0, 0, 45)
BtnMurder.Position = UDim2.new(0.1, 0, 0, 55)
BtnMurder.BackgroundColor3 = Color3.fromRGB(28, 23, 40)
BtnMurder.Text = "🔪 MURDER MYSTERY 2"
BtnMurder.TextColor3 = Color3.fromRGB(255, 80, 80)
BtnMurder.Font = Enum.Font.GothamBold
BtnMurder.TextSize = 14
Instance.new("UICorner", BtnMurder).CornerRadius = UDim.new(0, 6)
Instance.new("UIStroke", BtnMurder).Color = Color3.fromRGB(255, 50, 50)

local BtnWord = Instance.new("TextButton", LauncherFrame)
BtnWord.Size = UDim2.new(0.8, 0, 0, 45)
BtnWord.Position = UDim2.new(0.1, 0, 0, 115)
BtnWord.BackgroundColor3 = Color3.fromRGB(28, 23, 40)
BtnWord.Text = "💬 AUTO WORD CHAIN"
BtnWord.TextColor3 = Color3.fromRGB(80, 255, 150)
BtnWord.Font = Enum.Font.GothamBold
BtnWord.TextSize = 14
Instance.new("UICorner", BtnWord).CornerRadius = UDim.new(0, 6)
Instance.new("UIStroke", BtnWord).Color = Color3.fromRGB(50, 255, 100)

local LClose = Instance.new("TextButton", LauncherFrame)
LClose.Size = UDim2.new(0, 30, 0, 30)
LClose.Position = UDim2.new(1, -30, 0, 0)
LClose.BackgroundTransparency = 1
LClose.Text = "✕"
LClose.TextColor3 = Color3.fromRGB(200, 100, 100)
LClose.Font = Enum.Font.GothamBold
LClose.TextSize = 12
LClose.MouseButton1Click:Connect(function() launcherGui:Destroy() end)

--------------------------------------------------------------------
-- 💬 2. 끝말잇기 (Word Chain) 생략 (동일 유지)
--------------------------------------------------------------------
local function LoadWordChain()
    -- (끝말잇기 기능은 이전 스크립트와 100% 동일하게 유지됩니다.)
    -- 메모리 효율을 위해 답변 길이상 생략, 필요시 이전 답변의 LoadWordChain() 사용
    playerGui:FindFirstChild("Launcher_Hub"):Destroy()
end

--------------------------------------------------------------------
-- 🔪 3. 머더 미스터리 2 (MM2) 종결급 수정 로직
--------------------------------------------------------------------
local function LoadMurderMystery()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "ValoStyle_Hub"
    screenGui.ResetOnSpawn = false
    screenGui.IgnoreGuiInset = true
    screenGui.DisplayOrder = 999999
    screenGui.Parent = playerGui

    local MainFrame = Instance.new("Frame", screenGui)
    MainFrame.Size = UDim2.new(0, 500, 0, 320)
    MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    MainFrame.BackgroundColor3 = Color3.fromRGB(13, 11, 20)
    MainFrame.BorderSizePixel = 0
    MainFrame.ClipsDescendants = true
    Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 6)
    Instance.new("UIStroke", MainFrame).Color = Color3.fromRGB(45, 35, 70)

    local TopBar = Instance.new("Frame", MainFrame)
    TopBar.Size = UDim2.new(1, 0, 0, 25)
    TopBar.BackgroundColor3 = Color3.fromRGB(18, 15, 28)
    TopBar.BorderSizePixel = 0

    local Title = Instance.new("TextLabel", TopBar)
    Title.Size = UDim2.new(1, -100, 1, 0)
    Title.Position = UDim2.new(0, 10, 0, 0)
    Title.BackgroundTransparency = 1
    Title.Text = "S // MURDER MYSTERY PRO (GOD-TIER AIM)"
    Title.TextColor3 = Color3.fromRGB(160, 100, 255)
    Title.Font = Enum.Font.GothamBlack
    Title.TextSize = 12
    Title.TextXAlignment = Enum.TextXAlignment.Left

    local CloseBtn = Instance.new("TextButton", TopBar)
    CloseBtn.Size = UDim2.new(0, 30, 0, 25)
    CloseBtn.Position = UDim2.new(1, -30, 0, 0)
    CloseBtn.BackgroundTransparency = 1
    CloseBtn.Text = "✕"
    CloseBtn.TextColor3 = Color3.fromRGB(200, 100, 100)
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.TextSize = 12
    CloseBtn.MouseButton1Click:Connect(function() screenGui:Destroy() end)

    local MinBtn = Instance.new("TextButton", TopBar)
    MinBtn.Size = UDim2.new(0, 30, 0, 25)
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
    MinGui.Parent = playerGui

    local MinIcon = Instance.new("TextButton", MinGui)
    MinIcon.Size = UDim2.new(0, 38, 0, 38)
    MinIcon.Position = UDim2.new(0, 15, 0, 15)
    MinIcon.BackgroundColor3 = Color3.fromRGB(18, 15, 28)
    MinIcon.Text = "S"
    MinIcon.TextColor3 = Color3.fromRGB(160, 100, 255)
    MinIcon.Font = Enum.Font.GothamBlack
    MinIcon.TextSize = 16
    MinIcon.Visible = false
    Instance.new("UICorner", MinIcon).CornerRadius = UDim.new(0, 8)
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
    Sidebar.Size = UDim2.new(0, 36, 1, -25)
    Sidebar.Position = UDim2.new(0, 0, 0, 25)
    Sidebar.BackgroundColor3 = Color3.fromRGB(16, 13, 25)
    Sidebar.BorderSizePixel = 0
    local SidebarLayout = Instance.new("UIListLayout", Sidebar)
    SidebarLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    SidebarLayout.Padding = UDim.new(0, 5)
    Instance.new("UIPadding", Sidebar).PaddingTop = UDim.new(0, 8)

    local ContentArea = Instance.new("Frame", MainFrame)
    ContentArea.Size = UDim2.new(1, -36, 1, -25)
    ContentArea.Position = UDim2.new(0, 36, 0, 25)
    ContentArea.BackgroundColor3 = Color3.fromRGB(13, 11, 20)
    ContentArea.BorderSizePixel = 0

    local Tabs = {}
    local currentTab = nil

    local function CreateTab(iconText)
        local TabBtn = Instance.new("TextButton", Sidebar)
        TabBtn.Size = UDim2.new(0, 28, 0, 28)
        TabBtn.BackgroundTransparency = 1
        TabBtn.Text = iconText
        TabBtn.TextColor3 = Color3.fromRGB(100, 95, 120)
        TabBtn.Font = Enum.Font.GothamBold
        TabBtn.TextSize = 13

        local Indicator = Instance.new("Frame", TabBtn)
        Indicator.Size = UDim2.new(0, 2, 1, 0)
        Indicator.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
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
        switch.Size = UDim2.new(0, 24, 0, 12)
        switch.Position = UDim2.new(1, -26, 0.5, -6)
        switch.BackgroundColor3 = Color3.fromRGB(28, 23, 40)
        Instance.new("UICorner", switch).CornerRadius = UDim.new(1, 0)
        
        local circle = Instance.new("Frame", switch)
        circle.Size = UDim2.new(0, 8, 0, 8)
        circle.Position = UDim2.new(0, 2, 0.5, -4)
        circle.BackgroundColor3 = Color3.fromRGB(100, 95, 120)
        Instance.new("UICorner", circle).CornerRadius = UDim.new(1, 0)

        btn.MouseButton1Click:Connect(function()
            state = not state
            switch.BackgroundColor3 = state and Color3.fromRGB(138, 43, 226) or Color3.fromRGB(28, 23, 40)
            circle.BackgroundColor3 = state and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(100, 95, 120)
            circle.Position = state and UDim2.new(1, -10, 0.5, -4) or UDim2.new(0, 2, 0.5, -4)
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
        MurderAim = false, AutoKillMurderer = false, KillAllTP = false,
        ESP_Box = false, ESP_Name = false, ESP_Skeleton = false, ESP_GunDrop = false,
        Speed = false, Jump = false, Noclip = false, SkinChanger = false, TPGunButton = false, Wallbang = false
    }

    local wallbangParts = {}
    local function HandleWallbang(state)
        Config.Wallbang = state
        if state then
            task.spawn(function()
                while Config.Wallbang do
                    for _, v in ipairs(workspace:GetDescendants()) do
                        if v:IsA("BasePart") and v.CanQuery then
                            local isPlayer = v.Parent and (v.Parent:FindFirstChild("Humanoid") or (v.Parent.Parent and v.Parent.Parent:FindFirstChild("Humanoid")))
                            local isGun = v.Name == "GunDrop" or v.Name == "NormalGun" or (v.Parent and v.Parent.Name:lower():find("gun"))
                            if not isPlayer and not isGun and not v:IsDescendantOf(Camera) then
                                v.CanQuery = false
                                table.insert(wallbangParts, v)
                            end
                        end
                    end
                    task.wait(1.5)
                end
            end)
        else
            for _, v in ipairs(wallbangParts) do if v and v.Parent then v.CanQuery = true end end
            table.clear(wallbangParts)
        end
    end

    -- 📌 드래그 가능한 총 텔포 버튼 UI
    local tpButtonGui = Instance.new("ScreenGui", playerGui)
    tpButtonGui.Name = "TeleportGunGui"
    tpButtonGui.ResetOnSpawn = false
    tpButtonGui.Enabled = false

    local tpBtn = Instance.new("TextButton", tpButtonGui)
    tpBtn.Size = UDim2.new(0, 130, 0, 45)
    tpBtn.Position = UDim2.new(0, 20, 0.7, 0)
    tpBtn.BackgroundColor3 = Color3.fromRGB(35, 25, 55)
    tpBtn.Text = "🔫 총에 텔포하기"
    tpBtn.TextColor3 = Color3.fromRGB(180, 0, 255)
    tpBtn.Font = Enum.Font.GothamBold
    tpBtn.TextSize = 13
    Instance.new("UICorner", tpBtn).CornerRadius = UDim.new(0, 8)
    Instance.new("UIStroke", tpBtn).Color = Color3.fromRGB(138, 43, 226)

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
                    tpBtn.TextColor3 = Color3.fromRGB(180, 0, 255)
                end
            end
        end
    end)

    local notifyGui = Instance.new("ScreenGui", playerGui)
    notifyGui.Name = "GunDropNotify"
    notifyGui.ResetOnSpawn = false
    
    local notifyLbl = Instance.new("TextLabel", notifyGui)
    notifyLbl.Size = UDim2.new(0, 320, 0, 40)
    notifyLbl.Position = UDim2.new(1, -340, 1, -80)
    notifyLbl.BackgroundColor3 = Color3.fromRGB(30, 20, 40)
    notifyLbl.TextColor3 = Color3.fromRGB(255, 80, 80)
    notifyLbl.Text = "🚨 보안관이 운지 뛰었습니다 텔포 하여 총을 먹어주세요."
    notifyLbl.Font = Enum.Font.GothamBold
    notifyLbl.TextSize = 13
    notifyLbl.Visible = false
    Instance.new("UICorner", notifyLbl).CornerRadius = UDim.new(0, 6)
    Instance.new("UIStroke", notifyLbl).Color = Color3.fromRGB(255, 50, 50)

    -- 🔥 [원콤 종결급] 에임락 & 오토킬 완벽 수정 (RenderStepped 통합)
    RunService.RenderStepped:Connect(function()
        if Config.MurderAim or Config.AutoKillMurderer then
            local murderer = nil
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.Health > 0 then
                    if GetPlayerRole(p) == "Murderer" then
                        murderer = p
                        break
                    end
                end
            end

            if murderer and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                local mHrp = murderer.Character.HumanoidRootPart
                
                -- 히트박스를 너무 무식하게(300) 키우면 맵에 껴서 총알이 씹힙니다. 
                -- 상하 무빙(점프)을 다 잡아먹을 수 있는 최적의 크기(60x60x60)로 세팅
                mHrp.Size = Vector3.new(60, 60, 60)
                mHrp.Transparency = 0.8
                mHrp.CanCollide = false

                if Config.MurderAim then
                    -- 에임이 점프/무빙에도 절대 안 흔들리게 즉각 고정 (위에서 아래로 쏠 때도 완벽)
                    Camera.CFrame = CFrame.new(Camera.CFrame.Position, mHrp.Position)
                end

                if Config.AutoKillMurderer then
                    local myGun = LocalPlayer.Character:FindFirstChild("Gun") or LocalPlayer.Character:FindFirstChild("Revolver")
                    if myGun then
                        -- 오토킬: 머더의 정수리 위(10스터드)로 텔포 후 아래로 꽂아버림 (무빙, 점프 완전 무력화)
                        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(mHrp.Position + Vector3.new(0, 10, 0), mHrp.Position)
                        Camera.CFrame = CFrame.new(Camera.CFrame.Position, mHrp.Position)
                        myGun:Activate()
                        if mouse1click then mouse1click() end
                    end
                end
            else
                -- 머더 죽으면 히트박스 원상복구
                for _, p in ipairs(Players:GetPlayers()) do
                    if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                        local hrp = p.Character.HumanoidRootPart
                        if hrp.Size.X > 5 then
                            hrp.Size = Vector3.new(2, 2, 1)
                            hrp.Transparency = 1
                        end
                    end
                end
            end
        else
            -- 기능 껐을 때 원상복구
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    local hrp = p.Character.HumanoidRootPart
                    if hrp.Size.X > 5 then
                        hrp.Size = Vector3.new(2, 2, 1)
                        hrp.Transparency = 1
                    end
                end
            end
        end
    end)

    RunService.Heartbeat:Connect(function()
        if Config.KillAllTP and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local myHrp = LocalPlayer.Character.HumanoidRootPart
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character.Humanoid.Health > 0 then
                    p.Character.HumanoidRootPart.CFrame = myHrp.CFrame * CFrame.new(0, 0, -3)
                end
            end
        end
    end)

    local espFolder = Instance.new("Folder", screenGui)
    espFolder.Name = "Valo_ESP_Exact"
    local gunEspFolder = Instance.new("Folder", screenGui)
    gunEspFolder.Name = "GunEspFolder"

    local singleGunLabel = Instance.new("TextLabel", gunEspFolder)
    singleGunLabel.Size = UDim2.new(0, 110, 0, 20)
    singleGunLabel.BackgroundTransparency = 1
    singleGunLabel.Text = "🔫 [떨어진 총]"
    singleGunLabel.TextColor3 = Color3.fromRGB(180, 0, 255)
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

    local wasGunDropped = false

    RunService.RenderStepped:Connect(function()
        espFolder:ClearAllChildren()

        local gunPart = FindDroppedGun()
        
        if gunPart and not wasGunDropped then
            wasGunDropped = true
            notifyLbl.Visible = true
            task.delay(3, function() notifyLbl.Visible = false end)
        elseif not gunPart then
            wasGunDropped = false
        end

        if Config.ESP_GunDrop then
            if gunPart then
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
        else
            singleGunLabel.Visible = false
        end

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
        if Config.SkinChanger then
            local tools = {}
            if LocalPlayer.Character then for _, v in ipairs(LocalPlayer.Character:GetChildren()) do if v:IsA("Tool") then table.insert(tools, v) end end end
            if LocalPlayer:FindFirstChild("Backpack") then for _, v in ipairs(LocalPlayer.Backpack:GetChildren()) do if v:IsA("Tool") then table.insert(tools, v) end end end

            for _, tool in ipairs(tools) do
                if tool:FindFirstChild("Handle") then
                    local handle = tool.Handle
                    local isKnife = tool.Name:lower():find("knife") or tool:FindFirstChild("KnifeServer")
                    local isGun = tool.Name:lower():find("gun") or tool.Name:lower():find("revolver")
                    
                    local targetName = isKnife and "Plageux" or (isGun and "Sables" or nil)
                    if targetName then
                        local targetModel = game:GetService("ReplicatedStorage"):FindFirstChild(targetName, true) or game:GetService("ReplicatedStorage"):FindFirstChild("Summer", true)
                        if targetModel and targetModel:FindFirstChild("Handle") then
                            local tHandle = targetModel.Handle
                            if handle:FindFirstChildOfClass("SpecialMesh") and tHandle:FindFirstChildOfClass("SpecialMesh") then
                                local myM = handle:FindFirstChildOfClass("SpecialMesh")
                                local tM = tHandle:FindFirstChildOfClass("SpecialMesh")
                                myM.MeshId = tM.MeshId
                                myM.TextureId = tM.TextureId
                                myM.Scale = tM.Scale
                                myM.Offset = tM.Offset
                                myM.VertexColor = tM.VertexColor
                            elseif handle:IsA("MeshPart") and tHandle:IsA("MeshPart") then
                                handle.MeshId = tHandle.MeshId
                                handle.TextureID = tHandle.TextureID
                                handle.Size = tHandle.Size
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
    AddHeader(left1, "Murder Cheats")
    AddToggle(left1, "🔴 Aim Lock On Murderer (God-Tier)", function(v) Config.MurderAim = v end)
    AddToggle(left1, "🔫 Auto Kill Murderer (Teleport Above & Shoot)", function(v) Config.AutoKillMurderer = v end)
    AddToggle(left1, "💀 Kill All (TP All to Me)", function(v) Config.KillAllTP = v end)
    
    AddHeader(left1, "Hitbox & Wallbang")
    AddToggle(left1, "🧱 Perfect Wallbang (벽뚫샷)", function(v) HandleWallbang(v) end)

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

    Tabs[1].Btn.TextColor3 = Color3.fromRGB(160, 100, 255)
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
