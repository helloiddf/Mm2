local Camera = workspace.CurrentCamera
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

local AimbotKey = Enum.UserInputType.MouseButton2 -- 우클릭으로 작동
local Aiming = false
local Target = nil

-- 화면 중앙(마우스)에서 가장 가까운 플레이어 찾기
local function GetNearestPlayer()
    local Nearest = nil
    local ShortestDistance = math.huge

    for _, Player in pairs(Players:GetPlayers()) do
        if Player ~= LocalPlayer and Player.Character and Player.Character:FindFirstChild("Humanoid") and Player.Character.Humanoid.Health > 0 and Player.Character:FindFirstChild("Head") then
            local Character = Player.Character
            local TargetPos, OnScreen = Camera:WorldToViewportPoint(Character.Head.Position)

            if OnScreen then
                local MousePos = UserInputService:GetMouseLocation()
                local Distance = (Vector2.new(TargetPos.X, TargetPos.Y) - MousePos).Magnitude

                if Distance < ShortestDistance then
                    ShortestDistance = Distance
                    Nearest = Player
                end
            end
        end
    end
    return Nearest
end

-- 키 입력 감지
UserInputService.InputBegan:Connect(function(input)
    if input.UserInputType == AimbotKey then
        Aiming = true
        Target = GetNearestPlayer()
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == AimbotKey then
        Aiming = false
        Target = nil
    end
end)

-- 에임 고정 (카메라 시점 변경)
RunService.RenderStepped:Connect(function()
    if Aiming and Target and Target.Character and Target.Character:FindFirstChild("Head") and Target.Character.Humanoid.Health > 0 then
        Camera.CFrame = CFrame.new(Camera.CFrame.Position, Target.Character.Head.Position)
    else
        Aiming = false
        Target = nil
    end
end)
