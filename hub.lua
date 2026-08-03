local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local VirtualUser = game:GetService("VirtualUser")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- 🔥 [FPS 부스트 및 프레임 제한 완전 해제]
pcall(function()
    local Lighting = game:GetService("Lighting")
    Lighting.GlobalShadows = false
    Lighting.FogEnd = 9e9
    Lighting.ShadowSoftness = 0
    settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
    
    -- PC 및 모바일 60FPS 제한 아예 없애버리기
    if setfpscap then
        setfpscap(9999)
    end
end)

-- 🔥 [Anti-AFK] 잠수 튕김 방지
LocalPlayer.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)

local UI_Parent = LocalPlayer:WaitForChild("PlayerGui")
pcall(function()
    local hui = (gethui and gethui()) or game:GetService("CoreGui")
    if hui then UI_Parent = hui end
end)

for _, v in pairs(UI_Parent:GetChildren()) do
    if v.Name == "Launcher_Hub" or v.Name == "ValoStyle_Hub" or v.Name == "TeleportGunGui" or v.Name == "AutoShootGui" or v.Name == "AimlockGui" or v.Name == "GunDropNotify" then
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

local LauncherFrame = Instance.new("Frame", launcherGui)
LauncherFrame.Size = UDim2.new(0, 300, 0, 130)
LauncherFrame.AnchorPoint = Vector2.new(0.5, 0.5)
LauncherFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
LauncherFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
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
-- 🔪 2. 메인 로직 
--------------------------------------------------------------------
local Config = {
    MurderAim = false, MurderKillAll = false, SilentAim = false,
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
        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character.Humanoid.Health > 0 then
            if GetPlayerRole(p) == "Murderer" then return p end
        end
    end
    return nil
end

local function LoadMurderMystery()
    local screenGui = Instance.new("ScreenGui", UI_Parent)
    screenGui.Name = "ValoStyle_Hub"
    screenGui.ResetOnSpawn = false
    screenGui.IgnoreGuiInset = true

    local MainFrame = Instance.new("Frame", screenGui)
    MainFrame.Size = UDim2.new(0, 520, 0, 360)
    MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    MainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
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

    local dragStart, startPos
    TopBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragStart = input.Position; startPos = MainFrame.Position
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragStart and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if dragStart and (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
            dragStart = nil
        end
    end)

    local Sidebar = Instance.new("Frame", MainFrame)
    Sidebar.Size = UDim2.new(0, 40, 1, -60)
    Sidebar.Position = UDim2.new(0, 0, 0, 30)
    Sidebar.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Sidebar.BackgroundTransparency = 0.6
    local SidebarLayout = Instance.new("UIListLayout", Sidebar)
    SidebarLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    SidebarLayout.Padding = UDim.new(0, 8)
    Instance.new("UIPadding", Sidebar).PaddingTop = UDim.new(0, 12)

    local ContentArea = Instance.new("Frame", MainFrame)
    ContentArea.Size = UDim2.new(1, -40, 1, -60)
    ContentArea.Position = UDim2.new(0, 40, 0, 30)
    ContentArea.BackgroundTransparency = 1

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
    AddToggle(left1, "🎯 Magic Bullet (에임정확도 상승+투명화)", function(v) Config.SilentAim = v end)
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
    
    AddHeader(left2, "Gun ESP & Settings")
    AddToggle(left2, "🟣 ESP Gun & 보안관 데스 알람", function(v) Config.ESP_GunDrop = v end)
    AddToggle(left2, "🔓 FPS 제한 해제 (프레임 한계 돌파)", function(v) 
        pcall(function()
            if setfpscap then
                setfpscap(v and 9999 or 60)
            end
        end)
    end)

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
    -- ⚙️ 기능 구현부 (드래그 버튼)
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

        local dStart, sPos
        btn.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dStart = input.Position; sPos = btn.Position
            end
        end)
        btn.InputChanged:Connect(function(input)
            if dStart and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                local delta = input.Position - dStart
                btn.Position = UDim2.new(sPos.X.Scale, sPos.X.Offset + delta.X, sPos.Y.Scale, sPos.Y.Offset + delta.Y)
            end
        end)
        btn.InputEnded:Connect(function(input)
            if dStart and (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
                dStart = nil
            end
        end)
        return btn, btn.InputEnded
    end

    -- 📌 에임락(Aimlock)
    local aimBtn, aimEnded = createDraggableBtn("AimlockGui", "🎯 AIMLOCK (OFF)", Color3.fromRGB(100, 255, 100), 20, -55)
    aimEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            Config.MurderAim = not Config.MurderAim
            aimBtn.Text = Config.MurderAim and "🎯 AIMLOCK (ON)" or "🎯 AIMLOCK (OFF)"
            aimBtn.TextColor3 = Config.MurderAim and Color3.fromRGB(255, 50, 50) or Color3.fromRGB(100, 255, 100)
        end
    end)

    -- 📌 총 텔포(TP to Gun)
    local tpBtn, tpEnded = createDraggableBtn("TeleportGunGui", "🔫 총에 텔포하기", Color3.fromRGB(255, 100, 100), 20, 0)
    tpEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            local gunPart = workspace:FindFirstChild("GunDrop")
            if gunPart and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                local hrp = LocalPlayer.Character.HumanoidRootPart
                local originalCFrame = hrp.CFrame
                hrp.CFrame = gunPart.CFrame
                task.wait(0.4)
                hrp.CFrame = originalCFrame
            else
                tpBtn.Text = "❌ 총 없음!"
                task.wait(1)
                tpBtn.Text = "🔫 총에 텔포하기"
            end
        end
    end)

    -- 📌 오토 샷 (Auto Shoot)
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
                local origCF = myHrp.CFrame
                
                myHrp.CFrame = tHrp.CFrame * CFrame.new(0, 0, 3.5)
                task.wait(0.15) 
                
                Camera.CFrame = CFrame.lookAt(Camera.CFrame.Position, tHrp.Position)
                myGun:Activate()
                if mouse1click then pcall(mouse1click) end
                
                task.wait(0.15)
                myHrp.CFrame = origCF

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

    -- 🔥 [프레임 방어] 최적화된 루프
    task.spawn(function()
        while task.wait(0.5) do
            local murd = GetMurderer()
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character then
                    local hrp = p.Character:FindFirstChild("HumanoidRootPart")
                    if Config.SilentAim and p == murd and hrp then
                        hrp.Size = Vector3.new(120, 120, 120)
                        hrp.Transparency = 0.8
                        hrp.CanCollide = false
                    elseif not Config.SilentAim and hrp and hrp.Size.X > 5 then
                        hrp.Size = Vector3.new(2, 2, 1)
                        hrp.Transparency = 1
                    end
                    
                    if p ~= murd then
                        for _, part in ipairs(p.Character:GetChildren()) do
                            if Config.SilentAim then
                                if part:IsA("BasePart") or part:IsA("Decal") then part.Transparency = 1 end
                            else
                                if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then part.Transparency = 0 end
                                if part:IsA("Decal") then part.Transparency = 0 end
                            end
                        end
                    end
                end
            end
        end
    end)

    -- 🔥 ESP 및 알람
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
    
    local espFolder = Instance.new("Folder", screenGui)
    espFolder.Name = "Valo_ESP"
    local singleGunLabel = Instance.new("TextLabel", espFolder)
    singleGunLabel.Size = UDim2.new(0, 110, 0, 20)
    singleGunLabel.BackgroundTransparency = 1
    singleGunLabel.Text = "🟣 [떨어진 총]"
    singleGunLabel.TextColor3 = Color3.fromRGB(180, 50, 255)
    singleGunLabel.Font = Enum.Font.GothamBold
    singleGunLabel.TextSize = 12
    singleGunLabel.Visible = false

    local wasGunDropped = false
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
        
        local murd = GetMurderer()
        if Config.MurderAim and murd and murd.Character and murd.Character:FindFirstChild("HumanoidRootPart") then
            Camera.CFrame = CFrame.lookAt(Camera.CFrame.Position, murd.Character.HumanoidRootPart.Position)
        end
        
        if Config.ESP_GunDrop then
            local gunPart = workspace:FindFirstChild("GunDrop")
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

        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character.Humanoid.Health > 0 then
                local hrp = p.Character.HumanoidRootPart
                local head = p.Character:FindFirstChild("Head")
                local hrpPos, onScreen = Camera:WorldToViewportPoint(hrp.Position)
                
                if onScreen then
                    local roleName, roleColor = GetPlayerRole(p)
                    
                    if Config.ESP_Skeleton and head then
                        local torso = p.Character:FindFirstChild("Torso") or p.Character:FindFirstChild("UpperTorso")
                        if torso then
                            local neckW = Camera:WorldToViewportPoint((torso.CFrame * CFrame.new(0, 1, 0)).Position)
                            DrawLine(Vector2.new(Camera:WorldToViewportPoint(head.Position).X, Camera:WorldToViewportPoint(head.Position).Y), Vector2.new(neckW.X, neckW.Y), espFolder, roleColor)
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

    -- 🔥 [오토 코인 파밍] 
    task.spawn(function()
        while task.wait(0.1) do
            if Config.AutoCoin and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                local myHrp = LocalPlayer.Character.HumanoidRootPart
                local eco = workspace:FindFirstChild("NormalEconomy")
                local coinContainer = eco and eco:FindFirstChild("CoinContainer")
                
                if coinContainer then
                    for _, coin in ipairs(coinContainer:GetChildren()) do
                        if not Config.AutoCoin then break end
                        if coin.Name == "Coin_Server" then
                            local part = coin:IsA("Model") and coin.PrimaryPart or coin
                            if part and part.Transparency < 1 then
                                myHrp.CFrame = part.CFrame
                                task.wait(0.35)
                            end
                        end
                    end
                end
            end
        end
    end)

    -- 🔥 [킬 올] 
    task.spawn(function()
        while task.wait(0.05) do
            if Config.MurderKillAll and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                local role = GetPlayerRole(LocalPlayer)
                if role == "Murderer" then
                    local myChar = LocalPlayer.Character
                    local myHrp = myChar:FindFirstChild("HumanoidRootPart")
                    local myKnife = myChar:FindFirstChild("Knife") or (LocalPlayer:FindFirstChild("Backpack") and LocalPlayer.Backpack:FindFirstChild("Knife"))

                    if myKnife and myHrp then
                        if myKnife.Parent ~= myChar then myChar.Humanoid:EquipTool(myKnife) task.wait(0.1) end
                        for _, p in ipairs(Players:GetPlayers()) do
                            if not Config.MurderKillAll then break end 
                            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character.Humanoid.Health > 0 then
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
