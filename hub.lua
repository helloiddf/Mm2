local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local VirtualUser = game:GetService("VirtualUser")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

for _, v in pairs(CoreGui:GetChildren()) do
    if v.Name == "MobileMM2Hub" or v.Name == "SpinCrosshairGui" or v.Name == "GunEspFolder" or v.Name == "ValoStyle_Min" or v.Name == "TeleportGunGui" then 
        v:Destroy() 
    end
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MobileMM2Hub"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.DisplayOrder = 999999
screenGui.Parent = CoreGui

local MainFrame = Instance.new("Frame", screenGui)
MainFrame.Size = UDim2.new(0, 520, 0, 360)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(13, 11, 20)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)
Instance.new("UIStroke", MainFrame).Color = Color3.fromRGB(138, 43, 226)

local TopBar = Instance.new("Frame", MainFrame)
TopBar.Size = UDim2.new(1, 0, 0, 30)
TopBar.BackgroundColor3 = Color3.fromRGB(18, 15, 28)
TopBar.BorderSizePixel = 0

local Title = Instance.new("TextLabel", TopBar)
Title.Size = UDim2.new(1, -100, 1, 0)
Title.Position = UDim2.new(0, 12, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "⚡ MOBILE GOD-TIER MM2 ULTIMATE PRO ⚡"
Title.TextColor3 = Color3.fromRGB(160, 100, 255)
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 11
Title.TextXAlignment = Enum.TextXAlignment.Left

-- 닫기 버튼 (창 끄기)
local CloseBtn = Instance.new("TextButton", TopBar)
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -30, 0, 0)
CloseBtn.BackgroundTransparency = 1
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(200, 100, 100)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 12
CloseBtn.MouseButton1Click:Connect(function() screenGui:Destroy() end)

-- 최소화(창 끄고 켜기용 'S' 미니 아이콘) 버튼
local MinBtn = Instance.new("TextButton", TopBar)
MinBtn.Size = UDim2.new(0, 30, 0, 30)
MinBtn.Position = UDim2.new(1, -60, 0, 0)
MinBtn.BackgroundTransparency = 1
MinBtn.Text = "—"
MinBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
MinBtn.Font = Enum.Font.GothamBold
MinBtn.TextSize = 12

local MinGui = Instance.new("ScreenGui", CoreGui)
MinGui.Name = "ValoStyle_Min"
MinGui.ResetOnSpawn = false
MinGui.DisplayOrder = 999999

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
ContentArea.BackgroundTransparency = 1

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
    for _, item in ipairs(player.Character:GetChildren()) do
        if item:IsA("Tool") and (item.Name:lower():find("knife") or item:FindFirstChild("KnifeServer")) then return "Murderer", Color3.fromRGB(255, 50, 50) end
        if item:IsA("Tool") and (item.Name:lower():find("gun") or item:FindFirstChild("GunServer")) then return "Sheriff", Color3.fromRGB(50, 150, 255) end
    end
    if player:FindFirstChild("Backpack") then
        for _, item in ipairs(player.Backpack:GetChildren()) do
            if item:IsA("Tool") and (item.Name:lower():find("knife") or item:FindFirstChild("KnifeServer")) then return "Murderer", Color3.fromRGB(255, 50, 50) end
            if item:IsA("Tool") and (item.Name:lower():find("gun") or item:FindFirstChild("GunServer")) then return "Sheriff", Color3.fromRGB(50, 150, 255) end
        end
    end
    return "Innocent", Color3.fromRGB(50, 255, 100)
end

local Config = {
    MurderAim = false, CurveBullets = false, PredictionEnabled = false, Prediction = 0.15,
    TriggerBot = false, TriggerBotFOV = 50, Wallbang = false, AutoTeleportGun = false,
    ESP_Box = false, ESP_Name = false, ESP_Skeleton = false, ESP_GunDrop = false,
    DrawFOV = false, FOVSize = 120, RainbowFOV = false, SpinCrosshair = false, Crosshair = false,
    RainbowBullet = false, BulletColor = "Normal", Speed = false, Jump = false, Noclip = false, KillAllTP = false
}

-- FOV 원
local fovCircle = Drawing.new("Circle")
fovCircle.Visible = false
fovCircle.Thickness = 1.5
fovCircle.Radius = 120
fovCircle.Color = Color3.fromRGB(255, 255, 255)

RunService.RenderStepped:Connect(function()
    if Config.DrawFOV then
        fovCircle.Visible = true
        fovCircle.Radius = Config.FOVSize
        fovCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
        if Config.RainbowFOV then
            fovCircle.Color = Color3.fromHSV(tick() % 5 / 5, 1, 1)
        else
            fovCircle.Color = Color3.fromRGB(255, 255, 255)
        end
    else
        fovCircle.Visible = false
    end
end)

-- 조준점 및 스핀 조준점 GUI
local crosshairGui = Instance.new("ScreenGui", CoreGui)
crosshairGui.Name = "SpinCrosshairGui"
local crosshairHolder = Instance.new("Frame", crosshairGui)
crosshairHolder.Size = UDim2.new(0, 100, 0, 100)
crosshairHolder.AnchorPoint = Vector2.new(0.5, 0.5)
crosshairHolder.Position = UDim2.new(0.5, 0, 0.5, 0)
crosshairHolder.BackgroundTransparency = 1

local cLines = {}
for i = 1, 4 do
    local line = Instance.new("Frame", crosshairHolder)
    line.BackgroundColor3 = Color3.fromRGB(0, 255, 150)
    line.BorderSizePixel = 0
    table.insert(cLines, line)
end

RunService.RenderStepped:Connect(function()
    local isAiming = Config.Crosshair or UserInputService:IsKeyDown(Enum.KeyCode.LeftShift)
    if isAiming then
        crosshairHolder.Visible = true
        local t = tick() * 12
        for idx, line in ipairs(cLines) do
            if Config.SpinCrosshair then
                local angle = (idx * math.pi / 2) + t
                local dist = 15 + math.sin(tick() * 5) * 5
                line.Size = UDim2.new(0, 8, 0, 3)
                line.Position = UDim2.new(0.5, math.cos(angle) * dist - 4, 0.5, math.sin(angle) * dist - 1.5)
            else
                if idx == 1 then line.Size = UDim2.new(0, 2, 0, 10); line.Position = UDim2.new(0.5, -1, 0, 0)
                elseif idx == 2 then line.Size = UDim2.new(0, 2, 0, 10); line.Position = UDim2.new(0.5, -1, 0.5, 5)
                elseif idx == 3 then line.Size = UDim2.new(0, 10, 0, 2); line.Position = UDim2.new(0, 0, 0.5, -1)
                elseif idx == 4 then line.Size = UDim2.new(0, 10, 0, 2); line.Position = UDim2.new(0.5, 5, 0.5, -1)
                end
            end
        end
    else
        crosshairHolder.Visible = false
    end
end)

-- 에임락 및 곡선 유도
RunService.RenderStepped:Connect(function()
    if Config.MurderAim or Config.CurveBullets then
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Head") and p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.Health > 0 then
                if GetPlayerRole(p) == "Murderer" then
                    local targetPos = p.Character.Head.Position
                    if Config.PredictionEnabled and p.Character:FindFirstChild("HumanoidRootPart") then
                        targetPos = targetPos + (p.Character.HumanoidRootPart.AssemblyLinearVelocity * Config.Prediction)
                    end
                    Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, targetPos), 0.35)
                    break
                end
            end
        end
    end
end)

-- 트리거봇
local trigDebounce = false
RunService.RenderStepped:Connect(function()
    if Config.TriggerBot and not trigDebounce then
        local tool = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Tool")
        if tool and (tool.Name:lower():find("gun") or tool.Name:lower():find("revolver")) then
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Head") and p.Character.Humanoid.Health > 0 then
                    if GetPlayerRole(p) == "Murderer" then
                        local headPos, onScreen = Camera:WorldToViewportPoint(p.Character.Head.Position)
                        if onScreen then
                            local center = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
                            if (center - Vector2.new(headPos.X, headPos.Y)).Magnitude <= Config.TriggerBotFOV then
                                trigDebounce = true
                                if mouse1click then mouse1click() else VirtualUser:Button1Down(Vector2.new(0,0)) end
                                task.wait(0.15)
                                trigDebounce = false
                            end
                        end
                    end
                end
            end
        end
    end
end)

-- 벽뚫샷
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

-- 📌 화면 위에 네모나게 뜨는 '총 텔포 버튼' 생성 (드랍된 총이 없을 시 텔포 불가 기능 포함)
local tpButtonGui = Instance.new("ScreenGui", CoreGui)
tpButtonGui.Name = "TeleportGunGui"
tpButtonGui.ResetOnSpawn = false

local tpBtn = Instance.new("TextButton", tpButtonGui)
tpBtn.Size = UDim2.new(0, 130, 0, 45)
tpBtn.Position = UDim2.new(0, 20, 0.7, 0) -- 화면 왼쪽에 배치
tpBtn.BackgroundColor3 = Color3.fromRGB(35, 25, 55)
tpBtn.Text = "🔫 총 텔포하기"
tpBtn.TextColor3 = Color3.fromRGB(180, 0, 255)
tpBtn.Font = Enum.Font.GothamBold
tpBtn.TextSize = 13
Instance.new("UICorner", tpBtn).CornerRadius = UDim.new(0, 8)
Instance.new("UIStroke", tpBtn).Color = Color3.fromRGB(138, 43, 226)

local function FindDroppedGun()
    for _, v in ipairs(workspace:GetDescendants()) do
        if (v:IsA("Model") or v:IsA("BasePart")) and (v.Name:lower():find("gun") or v.Name:lower():find("revolver") or v.Name == "GunDrop") then
            local part = v:IsA("BasePart") and v or v.PrimaryPart or v:FindFirstChildWhichIsA("BasePart")
            if part then return part end
        end
    end
    return nil
end

tpBtn.MouseButton1Click:Connect(function()
    local gunPart = FindDroppedGun()
    if gunPart and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = LocalPlayer.Character.HumanoidRootPart
        local origPos = hrp.CFrame
        hrp.CFrame = gunPart.CFrame + Vector3.new(0, 2, 0)
        task.wait(0.1)
        hrp.CFrame = origPos
    else
        -- 드랍된 총이 없을 때 알림 텍스트 효과
        tpBtn.Text = "❌ 총 없음!"
        task.wait(1)
        tpBtn.Text = "🔫 총 텔포하기"
    end
end)

-- 보라색 총 ESP 및 자동 텔포 줍기 옵션 처리
local gunEspFolder = Instance.new("Folder", screenGui)
gunEspFolder.Name = "GunEspFolder"
local isTeleportingGun = false

RunService.Heartbeat:Connect(function()
    gunEspFolder:ClearAllChildren()
    for _, v in ipairs(workspace:GetDescendants()) do
        if (v:IsA("Model") or v:IsA("BasePart")) and (v.Name:lower():find("gun") or v.Name:lower():find("revolver") or v.Name == "GunDrop") then
            local part = v:IsA("BasePart") and v or v.PrimaryPart or v:FindFirstChildWhichIsA("BasePart")
            if part then
                local pos, onScreen = Camera:WorldToViewportPoint(part.Position)
                if onScreen and Config.ESP_GunDrop then
                    local lbl = Instance.new("TextLabel", gunEspFolder)
                    lbl.Size = UDim2.new(0, 110, 0, 20)
                    lbl.Position = UDim2.new(0, pos.X - 55, 0, pos.Y - 10)
                    lbl.BackgroundTransparency = 1
                    lbl.Text = "🔫 [DROPPED GUN]"
                    lbl.TextColor3 = Color3.fromRGB(180, 0, 255)
                    lbl.Font = Enum.Font.GothamBold
                    lbl.TextSize = 11
                end

                if Config.AutoTeleportGun and not isTeleportingGun and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    isTeleportingGun = true
                    local hrp = LocalPlayer.Character.HumanoidRootPart
                    local origPos = hrp.CFrame
                    hrp.CFrame = part.CFrame + Vector3.new(0, 2, 0)
                    task.wait(0.1)
                    hrp.CFrame = origPos
                    task.wait(0.5)
                    isTeleportingGun = false
                end
            end
        end
    end
end)

-- 플레이어 ESP (Box, Name, Skeleton)
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
                    local neckW = Camera:WorldToViewportPoint((torso.CFrame * CFrame.new(0, 1, 0)).Position)
                    local pelvisW = Camera:WorldToViewportPoint((torso.CFrame * CFrame.new(0, -1, 0)).Position)
                    local headW = Camera:WorldToViewportPoint(head.Position)
                    DrawLine(Vector2.new(headW.X, headW.Y), Vector2.new(neckW.X, neckW.Y), espFolder, roleColor, 1.5)
                    DrawLine(Vector2.new(neckW.X, neckW.Y), Vector2.new(pelvisW.X, pelvisW.Y), espFolder, roleColor, 1.5)
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

-- 이동 기능
RunService.Heartbeat:Connect(function()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") and char:FindFirstChild("Humanoid") then
        if Config.Speed then char.Humanoid.WalkSpeed = 32 else char.Humanoid.WalkSpeed = 16 end
        if Config.Noclip then
            for _, v in pairs(char:GetDescendants()) do if v:IsA("BasePart") then v.CanCollide = false end end
        end
        if Config.KillAllTP then
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character.Humanoid.Health > 0 then
                    p.Character.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame * CFrame.new(0, 0, -3)
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

-- 탭 구성 (조절 슬라이더 및 기능들)
local left1, right1 = CreateTab("🎯")
AddHeader(left1, "Combat & Aim")
AddToggle(left1, "🔴 Aim Lock On Murderer", function(v) Config.MurderAim = v end)
AddToggle(left1, "🧲 Curve Bullets (총알 유도)", function(v) Config.CurveBullets = v end)
AddToggle(left1, "🎯 Prediction (예측샷)", function(v) Config.PredictionEnabled = v end)
AddSlider(left1, "   ↳ 예측 강도", 0, 100, 15, function(val) Config.Prediction = val / 100 end)

AddHeader(left1, "TriggerBot")
AddToggle(left1, "🔫 TriggerBot (자동 발사)", function(v) Config.TriggerBot = v end)
AddSlider(left1, "   ↳ Trigger 범위", 5, 100, 50, function(val) Config.TriggerBotFOV = val end)

AddHeader(right1, "Misc Tools")
AddToggle(right1, "🧱 Wallbang (벽뚫샷)", function(v) Config.Wallbang = v end)
AddToggle(right1, "⚡ Auto Teleport Gun (자동 총 줍기)", function(v) Config.AutoTeleportGun = v end)

local left2, right2 = CreateTab("👁")
AddHeader(left2, "Visuals & ESP")
AddToggle(left2, "ESP Box", function(v) Config.ESP_Box = v end)
AddToggle(left2, "ESP Name", function(v) Config.ESP_Name = v end)
AddToggle(left2, "💀 R6 Detailed Skeleton", function(v) Config.ESP_Skeleton = v end)
AddToggle(left2, "🟣 ESP Dropped Gun", function(v) Config.ESP_GunDrop = v end)

AddHeader(right2, "FOV & Crosshair")
AddToggle(right2, "⭕ Draw FOV Circle", function(v) Config.DrawFOV = v end)
AddSlider(right2, "   ↳ FOV 크기", 1, 300, 120, function(val) Config.FOVSize = val end)
AddToggle(right2, "➕ Draw Crosshair (조준점)", function(v) Config.Crosshair = v end)
AddToggle(right2, "🌀 Spin Crosshair (스핀 조준점)", function(v) Config.SpinCrosshair = v end)

local left3, right3 = CreateTab("✨")
AddHeader(left3, "Custom Bullet FX")
AddToggle(left3, "🌈 Rainbow Bullets", function(v) Config.RainbowBullet = v end)

local left4, right4 = CreateTab("🏃")
AddHeader(left4, "Movement & Misc")
AddToggle(left4, "Safe Speed Boost (스핵)", function(v) Config.Speed = v end)
AddToggle(left4, "Infinite Jump (무한점프)", function(v) Config.Jump = v end)
AddToggle(left4, "Noclip (녹클립)", function(v) Config.Noclip = v end)
AddToggle(right4, "Kill All (TP All)", function(v) Config.KillAllTP = v end)

Tabs[1].Btn.TextColor3 = Color3.fromRGB(160, 100, 255)
Tabs[1].Ind.Visible = true
Tabs[1].Container.Visible = true
currentTab = Tabs[1]
