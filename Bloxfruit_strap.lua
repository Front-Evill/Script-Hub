
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- إعدادات السكربت المتقدمة (تفعيل تلقائي)
local config = {
    aimPrecision = 1.0, -- دقة كاملة 100%
    smoothValue = 0.05, -- قيمة منخفضة للحركة أكثر دقة
    fovRadius = 250, -- نطاق رؤية أوسع للعمل التلقائي
    predictionStrength = 1.2,
    targetPart = "HumanoidRootPart" -- HumanoidRootPart, Head
}

-- المتغيرات الرئيسية
local player = Players.LocalPlayer
local mouse = player:GetMouse()
local camera = workspace.CurrentCamera

-- وظيفة الحصول على أقرب هدف
local function getClosestTarget()
    local closest = nil
    local maxDistance = config.fovRadius
    
    for _, otherPlayer in pairs(Players:GetPlayers()) do
        if otherPlayer ~= player and 
           otherPlayer.Character and 
           otherPlayer.Character:FindFirstChild(config.targetPart) and
           otherPlayer.Character:FindFirstChild("Humanoid") and
           otherPlayer.Character.Humanoid.Health > 0 then
            
            local targetPos = otherPlayer.Character[config.targetPart].Position
            local screenPos, onScreen = camera:WorldToScreenPoint(targetPos)
            
            if onScreen then
                local screenDistance = (Vector2.new(mouse.X, mouse.Y) - Vector2.new(screenPos.X, screenPos.Y)).Magnitude
                
                if screenDistance < maxDistance then
                    maxDistance = screenDistance
                    closest = otherPlayer.Character
                end
            end
        end
    end
    
    return closest
end

-- وظيفة التنبؤ بحركة الهدف
local function predictTargetPosition(target)
    if not target or not target:FindFirstChild(config.targetPart) or not target:FindFirstChild("Humanoid") then
        return nil
    end
    
    local targetHRP = target[config.targetPart]
    local velocity = targetHRP.Velocity
    local predictionOffset = velocity * config.predictionStrength
    
    return targetHRP.Position + predictionOffset
end

-- وظيفة التصويب عالية الدقة (تعمل تلقائياً)
local function autoPrecisionAiming()
    RunService:BindToRenderStep("AutoBloxStrapAimbot", Enum.RenderPriority.Camera.Value + 1, function()
        local target = getClosestTarget()
        
        if target then
            local predictedPosition = predictTargetPosition(target)
            
            if predictedPosition then
                local cameraPosition = camera.CFrame.Position
                local targetDirection = (predictedPosition - cameraPosition).Unit
                
                local currentCameraCFrame = camera.CFrame
                local targetCameraCFrame = CFrame.new(cameraPosition, cameraPosition + targetDirection)
                
                -- تطبيق تسويه مع دقة عالية جداً
                camera.CFrame = currentCameraCFrame:Lerp(targetCameraCFrame, config.smoothValue * config.aimPrecision)
            end
        end
    end)
end

-- منع اكتشاف السكربت
local mt = getrawmetatable(game)
local old = mt.__namecall
setreadonly(mt, false)
mt.__namecall = newcclosure(function(...)
    local args = {...}
    local method = getnamecallmethod()
    
    if method == "FireServer" and args[1].Name:find("Security") then
        return nil
    end
    
    return old(...)
end)
setreadonly(mt, true)

-- تشغيل السكربت
autoPrecisionAiming()
print(" FRONT EVill ")

-- إضافة إشعار لتأكيد عمل السكربت
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player.PlayerGui

local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(0, 200, 0, 50)
statusLabel.Position = UDim2.new(0.8, 0, 0.1, 0)
statusLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
statusLabel.BackgroundTransparency = 0.7
statusLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
statusLabel.Text = "True the script ☺️"
statusLabel.Parent = screenGui

wait(3)
statusLabel.Visible = false
