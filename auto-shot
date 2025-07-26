local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local function isSheriff()
    local backpack = player:FindFirstChild("Backpack")
    local character = player.Character
    
    if backpack and backpack:FindFirstChild("Gun") then
        return true
    end
    if character and character:FindFirstChild("Gun") then
        return true
    end
    return false
end

local function getMurderer()
    for _, otherPlayer in pairs(Players:GetPlayers()) do
        if otherPlayer ~= player then
            local backpack = otherPlayer:FindFirstChild("Backpack")
            local character = otherPlayer.Character
            
            if backpack and backpack:FindFirstChild("Knife") then
                return otherPlayer
            end
            if character and character:FindFirstChild("Knife") then
                return otherPlayer
            end
        end
    end
    return nil
end

local function shootAtMurderer()
    if not isSheriff() then
        return false
    end
    
    local murderer = getMurderer()
    if not murderer or not murderer.Character or not murderer.Character:FindFirstChild("HumanoidRootPart") then
        return false
    end
    
    local gun = player.Character:FindFirstChild("Gun") or player.Backpack:FindFirstChild("Gun")
    if not gun then
        return false
    end
    
    if gun.Parent == player.Backpack then
        player.Character.Humanoid:EquipTool(gun)
        wait(0.1)
    end
    
    local targetPosition = murderer.Character.HumanoidRootPart.Position
    local camera = workspace.CurrentCamera
    
    local direction = (targetPosition - camera.CFrame.Position).Unit
    local raycast = workspace:Raycast(camera.CFrame.Position, direction * 1000)
    
    if raycast and raycast.Instance then
        local hitPosition = raycast.Position
        
        if gun:FindFirstChild("Fire") then
            gun.Fire:FireServer(hitPosition, murderer.Character.Head)
        elseif gun:FindFirstChild("RemoteEvent") then
            gun.RemoteEvent:FireServer(hitPosition, murderer.Character.Head)
        end
        
        return true
    end
    
    return false
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MM2AdvancedGUI"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = playerGui

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 280, 0, 200)
mainFrame.Position = UDim2.new(0.5, -140, 0.3, -100)
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
mainFrame.BorderSizePixel = 0
mainFrame.ZIndex = 10
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 25)
mainCorner.Parent = mainFrame

local mainStroke = Instance.new("UIStroke")
mainStroke.Color = Color3.fromRGB(50, 150, 255)
mainStroke.Thickness = 2
mainStroke.Transparency = 0.3
mainStroke.Parent = mainFrame

local mainGradient = Instance.new("UIGradient")
mainGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(25, 25, 35)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(10, 10, 15)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 20, 30))
}
mainGradient.Rotation = 135
mainGradient.Parent = mainFrame

local glowFrame = Instance.new("Frame")
glowFrame.Name = "Glow"
glowFrame.Size = UDim2.new(1, 15, 1, 15)
glowFrame.Position = UDim2.new(0, -7.5, 0, -7.5)
glowFrame.BackgroundColor3 = Color3.fromRGB(50, 150, 255)
glowFrame.BackgroundTransparency = 0.85
glowFrame.ZIndex = 9
glowFrame.Parent = mainFrame

local glowCorner = Instance.new("UICorner")
glowCorner.CornerRadius = UDim.new(0, 30)
glowCorner.Parent = glowFrame

local titleBar = Instance.new("Frame")
titleBar.Name = "TitleBar"
titleBar.Size = UDim2.new(1, 0, 0, 40)
titleBar.Position = UDim2.new(0, 0, 0, 0)
titleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
titleBar.BorderSizePixel = 0
titleBar.ZIndex = 11
titleBar.Parent = mainFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 25)
titleCorner.Parent = titleBar

local titleGradient = Instance.new("UIGradient")
titleGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(45, 45, 60)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(25, 25, 35))
}
titleGradient.Rotation = 90
titleGradient.Parent = titleBar

local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "Title"
titleLabel.Size = UDim2.new(1, -80, 1, 0)
titleLabel.Position = UDim2.new(0, 15, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "MM2 Assistant"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextSize = 14
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.ZIndex = 12
titleLabel.Parent = titleBar

local imageContainer = Instance.new("Frame")
imageContainer.Name = "ImageContainer"
imageContainer.Size = UDim2.new(1, -20, 1, -60)
imageContainer.Position = UDim2.new(0, 10, 0, 50)
imageContainer.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
imageContainer.BorderSizePixel = 0
imageContainer.ZIndex = 11
imageContainer.Parent = mainFrame

local imageCorner = Instance.new("UICorner")
imageCorner.CornerRadius = UDim.new(0, 20)
imageCorner.Parent = imageContainer

local imageStroke = Instance.new("UIStroke")
imageStroke.Color = Color3.fromRGB(80, 80, 120)
imageStroke.Thickness = 1
imageStroke.Transparency = 0.5
imageStroke.Parent = imageContainer

local imageLabel = Instance.new("ImageLabel")
imageLabel.Name = "MainImage"
imageLabel.Size = UDim2.new(1, -10, 1, -10)
imageLabel.Position = UDim2.new(0, 5, 0, 5)
imageLabel.BackgroundTransparency = 1
imageLabel.Image = "rbxasset://textures/face.png"
imageLabel.ScaleType = Enum.ScaleType.Fit
imageLabel.ZIndex = 12
imageLabel.Parent = imageContainer

local imageBorder = Instance.new("UICorner")
imageBorder.CornerRadius = UDim.new(0, 15)
imageBorder.Parent = imageLabel

local statusFrame = Instance.new("Frame")
statusFrame.Name = "StatusFrame"
statusFrame.Size = UDim2.new(0, 280, 0, 120)
statusFrame.Position = UDim2.new(0, 0, 1, 15)
statusFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
statusFrame.BorderSizePixel = 0
statusFrame.ZIndex = 10
statusFrame.Parent = mainFrame

local statusCorner = Instance.new("UICorner")
statusCorner.CornerRadius = UDim.new(0, 22)
statusCorner.Parent = statusFrame

local statusStroke = Instance.new("UIStroke")
statusStroke.Color = Color3.fromRGB(100, 100, 150)
statusStroke.Thickness = 2
statusStroke.Transparency = 0.4
statusStroke.Parent = statusFrame

local statusGradient = Instance.new("UIGradient")
statusGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 20, 28)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(8, 8, 12))
}
statusGradient.Rotation = 45
statusGradient.Parent = statusFrame

local statusGlow = Instance.new("Frame")
statusGlow.Name = "StatusGlow"
statusGlow.Size = UDim2.new(1, 12, 1, 12)
statusGlow.Position = UDim2.new(0, -6, 0, -6)
statusGlow.BackgroundColor3 = Color3.fromRGB(100, 100, 150)
statusGlow.BackgroundTransparency = 0.9
statusGlow.ZIndex = 9
statusGlow.Parent = statusFrame

local statusGlowCorner = Instance.new("UICorner")
statusGlowCorner.CornerRadius = UDim.new(0, 28)
statusGlowCorner.Parent = statusGlow

local roleLabel = Instance.new("TextLabel")
roleLabel.Name = "RoleLabel"
roleLabel.Size = UDim2.new(1, -20, 0, 25)
roleLabel.Position = UDim2.new(0, 10, 0, 15)
roleLabel.BackgroundTransparency = 1
roleLabel.Text = "Role: Checking..."
roleLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
roleLabel.TextSize = 13
roleLabel.Font = Enum.Font.GothamBold
roleLabel.TextXAlignment = Enum.TextXAlignment.Left
roleLabel.ZIndex = 12
roleLabel.Parent = statusFrame

local murdererLabel = Instance.new("TextLabel")
murdererLabel.Name = "MurdererLabel"
murdererLabel.Size = UDim2.new(1, -20, 0, 25)
murdererLabel.Position = UDim2.new(0, 10, 0, 45)
murdererLabel.BackgroundTransparency = 1
murdererLabel.Text = "Murderer: Scanning..."
murdererLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
murdererLabel.TextSize = 12
murdererLabel.Font = Enum.Font.Gotham
murdererLabel.TextXAlignment = Enum.TextXAlignment.Left
murdererLabel.ZIndex = 12
murdererLabel.Parent = statusFrame

local shootButton = Instance.new("TextButton")
shootButton.Name = "ShootButton"
shootButton.Size = UDim2.new(1, -20, 0, 35)
shootButton.Position = UDim2.new(0, 10, 0, 75)
shootButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
shootButton.BorderSizePixel = 0
shootButton.Text = "SHOOT TARGET"
shootButton.TextColor3 = Color3.fromRGB(255, 255, 255)
shootButton.TextSize = 14
shootButton.Font = Enum.Font.GothamBold
shootButton.ZIndex = 12
shootButton.Visible = false
shootButton.Parent = statusFrame

local shootCorner = Instance.new("UICorner")
shootCorner.CornerRadius = UDim.new(0, 18)
shootCorner.Parent = shootButton

local shootStroke = Instance.new("UIStroke")
shootStroke.Color = Color3.fromRGB(255, 100, 100)
shootStroke.Thickness = 2
shootStroke.Transparency = 0.6
shootStroke.Parent = shootButton

local shootGradient = Instance.new("UIGradient")
shootGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(220, 70, 70)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(180, 30, 30))
}
shootGradient.Rotation = 45
shootGradient.Parent = shootButton

local closeButton = Instance.new("TextButton")
closeButton.Name = "Close"
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -40, 0, 5)
closeButton.BackgroundColor3 = Color3.fromRGB(220, 60, 60)
closeButton.BorderSizePixel = 0
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.TextSize = 14
closeButton.Font = Enum.Font.GothamBold
closeButton.ZIndex = 13
closeButton.Parent = titleBar

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(1, 0)
closeCorner.Parent = closeButton

local minimizeButton = Instance.new("TextButton")
minimizeButton.Name = "Minimize"
minimizeButton.Size = UDim2.new(0, 30, 0, 30)
minimizeButton.Position = UDim2.new(1, -75, 0, 5)
minimizeButton.BackgroundColor3 = Color3.fromRGB(200, 150, 50)
minimizeButton.BorderSizePixel = 0
minimizeButton.Text = "-"
minimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
minimizeButton.TextSize = 16
minimizeButton.Font = Enum.Font.GothamBold
minimizeButton.ZIndex = 13
minimizeButton.Parent = titleBar

local minCorner = Instance.new("UICorner")
minCorner.CornerRadius = UDim.new(1, 0)
minCorner.Parent = minimizeButton

local dragging = false
local dragStart = nil
local startPos = nil
local dragConnection = nil
local isMinimized = false

local function smoothDrag()
    if dragging and dragStart and startPos then
        local mouse = player:GetMouse()
        local delta = Vector2.new(mouse.X - dragStart.X, mouse.Y - dragStart.Y)
        local viewport = workspace.CurrentCamera.ViewportSize
        
        local newX = math.clamp(startPos.X.Offset + delta.X, 0, viewport.X - mainFrame.AbsoluteSize.X)
        local newY = math.clamp(startPos.Y.Offset + delta.Y, 0, viewport.Y - (mainFrame.AbsoluteSize.Y + statusFrame.AbsoluteSize.Y + 15))
        
        mainFrame.Position = UDim2.new(0, newX, 0, newY)
    end
end

local function updateRoleStatus()
    local sheriff = isSheriff()
    local murderer = getMurderer()
    
    if sheriff then
        roleLabel.Text = "Role: Sheriff"
        roleLabel.TextColor3 = Color3.fromRGB(50, 255, 100)
        mainStroke.Color = Color3.fromRGB(50, 255, 100)
        statusStroke.Color = Color3.fromRGB(50, 255, 100)
        glowFrame.BackgroundColor3 = Color3.fromRGB(50, 255, 100)
        statusGlow.BackgroundColor3 = Color3.fromRGB(50, 255, 100)
        
        if murderer then
            murdererLabel.Text = "Murderer: " .. murderer.Name
            murdererLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
            shootButton.Visible = true
            shootButton.Text = "SHOOT " .. murderer.Name:upper()
        else
            murdererLabel.Text = "Murderer: Not Found"
            murdererLabel.TextColor3 = Color3.fromRGB(255, 200, 100)
            shootButton.Visible = false
        end
    else
        roleLabel.Text = "Role: Innocent"
        roleLabel.TextColor3 = Color3.fromRGB(100, 180, 255)
        mainStroke.Color = Color3.fromRGB(100, 180, 255)
        statusStroke.Color = Color3.fromRGB(100, 180, 255)
        glowFrame.BackgroundColor3 = Color3.fromRGB(100, 180, 255)
        statusGlow.BackgroundColor3 = Color3.fromRGB(100, 180, 255)
        shootButton.Visible = false
        
        if murderer then
            murdererLabel.Text = "Murderer: " .. murderer.Name
            murdererLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
        else
            murdererLabel.Text = "Murderer: Unknown"
            murdererLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
        end
    end
end

imageLabel.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 and isSheriff() then
        local success = shootAtMurderer()
        
        local tweenInfo = TweenInfo.new(0.15, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out)
        
        if success then
            TweenService:Create(imageLabel, tweenInfo, {
                Size = UDim2.new(0.85, -10, 0.85, -10),
                Position = UDim2.new(0.075, 5, 0.075, 5)
            }):Play()
            
            TweenService:Create(imageStroke, tweenInfo, {
                Color = Color3.fromRGB(50, 255, 100),
                Thickness = 3
            }):Play()
            
            wait(0.3)
            
            TweenService:Create(imageLabel, tweenInfo, {
                Size = UDim2.new(1, -10, 1, -10),
                Position = UDim2.new(0, 5, 0, 5)
            }):Play()
            
            TweenService:Create(imageStroke, tweenInfo, {
                Color = Color3.fromRGB(80, 80, 120),
                Thickness = 1
            }):Play()
        else
            TweenService:Create(imageStroke, tweenInfo, {
                Color = Color3.fromRGB(255, 50, 50),
                Thickness = 3
            }):Play()
            
            wait(0.5)
            
            TweenService:Create(imageStroke, tweenInfo, {
                Color = Color3.fromRGB(80, 80, 120),
                Thickness = 1
            }):Play()
        end
    end
end)

shootButton.MouseButton1Click:Connect(function()
    if isSheriff() then
        local success = shootAtMurderer()
        
        if success then
            local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            TweenService:Create(shootButton, tweenInfo, {
                BackgroundColor3 = Color3.fromRGB(50, 200, 50)
            }):Play()
            
            shootButton.Text = "SHOT FIRED"
            
            wait(1.5)
            updateRoleStatus()
        else
            local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            TweenService:Create(shootButton, tweenInfo, {
                BackgroundColor3 = Color3.fromRGB(120, 120, 120)
            }):Play()
            
            shootButton.Text = "SHOT FAILED"
            
            wait(1.5)
            updateRoleStatus()
        end
    end
end)

titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        local mouse = player:GetMouse()
        dragStart = Vector2.new(mouse.X, mouse.Y)
        startPos = mainFrame.Position
        
        local tweenInfo = TweenInfo.new(0.12, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
        TweenService:Create(mainFrame, tweenInfo, {
            Size = UDim2.new(0, 290, 0, 210)
        }):Play()
        TweenService:Create(glowFrame, tweenInfo, {
            BackgroundTransparency = 0.7
        }):Play()
        TweenService:Create(statusGlow, tweenInfo, {
            BackgroundTransparency = 0.8
        }):Play()
        
        dragConnection = RunService.Heartbeat:Connect(smoothDrag)
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
                if dragConnection then
                    dragConnection:Disconnect()
                    dragConnection = nil
                end
                
                local resetTween = TweenService:Create(mainFrame, tweenInfo, {
                    Size = UDim2.new(0, 280, 0, 200)
                })
                resetTween:Play()
                TweenService:Create(glowFrame, tweenInfo, {
                    BackgroundTransparency = 0.85
                }):Play()
                TweenService:Create(statusGlow, tweenInfo, {
                    BackgroundTransparency = 0.9
                }):Play()
            end
        end)
    end
end)

closeButton.MouseButton1Click:Connect(function()
    local tweenInfo = TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.In)
    local closeTween = TweenService:Create(mainFrame, tweenInfo, {
        Size = UDim2.new(0, 0, 0, 0),
        Position = UDim2.new(0.5, 0, 0.5, 0)
    })
    closeTween:Play()
    
    TweenService:Create(statusFrame, tweenInfo, {
        Size = UDim2.new(0, 0, 0, 0),
        Position = UDim2.new(0.5, 0, 0.5, 0)
    }):Play()
    
    closeTween.Completed:Connect(function()
        screenGui:Destroy()
    end)
end)

minimizeButton.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    local tweenInfo = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    
    if isMinimized then
        TweenService:Create(mainFrame, tweenInfo, {
            Size = UDim2.new(0, 280, 0, 40)
        }):Play()
        TweenService:Create(statusFrame, tweenInfo, {
            BackgroundTransparency = 1
        }):Play()
        TweenService:Create(statusGlow, tweenInfo, {
            BackgroundTransparency = 1
        }):Play()
        minimizeButton.Text = "+"
    else
        TweenService:Create(mainFrame, tweenInfo, {
            Size = UDim2.new(0, 280, 0, 200)
        }):Play()
        TweenService:Create(statusFrame, tweenInfo, {
            BackgroundTransparency = 0
        }):Play()
        TweenService:Create(statusGlow, tweenInfo, {
            BackgroundTransparency = 0.9
        }):Play()
        minimizeButton.Text = "-"
    end
end)

shootButton.MouseEnter:Connect(function()
    if shootButton.Visible then
        local tweenInfo = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        TweenService:Create(shootButton, tweenInfo, {
            Size = UDim2.new(1, -15, 0, 40),
            BackgroundColor3 = Color3.fromRGB(230, 70, 70)
        }):Play()
    end
end)

shootButton.MouseLeave:Connect(function()
    if shootButton.Visible then
        local tweenInfo = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        TweenService:Create(shootButton, tweenInfo, {
            Size = UDim2.new(1, -20, 0, 35),
            BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        }):Play()
    end
end)

closeButton.MouseEnter:Connect(function()
    local tweenInfo = TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    TweenService:Create(closeButton, tweenInfo, {
        Size = UDim2.new(0, 35, 0, 35),
        BackgroundColor3 = Color3.fromRGB(255, 80, 80)
    }):Play()
end)

closeButton.MouseLeave:Connect(function()
    local tweenInfo = TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    TweenService:Create(closeButton, tweenInfo, {
        Size = UDim2.new(0, 30, 0, 30),
        BackgroundColor3 = Color3.fromRGB(220, 60, 60)
    }):Play()
end)

minimizeButton.MouseEnter:Connect(function()
    local tweenInfo = TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    TweenService:Create(minimizeButton, tweenInfo, {
        Size = UDim2.new(0, 35, 0, 35),
        BackgroundColor3 = Color3.fromRGB(230, 180, 70)
    }):Play()
end)

minimizeButton.MouseLeave:Connect(function()
    local tweenInfo = TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    TweenService:Create(minimizeButton, tweenInfo, {
        Size = UDim2.new(0, 30, 0, 30),
        BackgroundColor3 = Color3.fromRGB(200, 150, 50)
    }):Play()
end)

spawn(function()
    while mainFrame.Parent do
        updateRoleStatus()
        wait(0.8)
    end
end)

spawn(function()
    local rotation = 0
    while mainFrame.Parent do
        rotation = rotation + 1
        mainGradient.Rotation = 135 + math.sin(rotation * 0.015) * 12
        titleGradient.Rotation = 90 + math.sin(rotation * 0.012) * 8
        statusGradient.Rotation = 45 + math.sin(rotation * 0.018) * 10
        shootGradient.Rotation = 45 + math.sin(rotation * 0.02) * 15
        wait(0.08)
    end
end)

local glowTween = TweenService:Create(glowFrame, TweenInfo.new(1.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
    BackgroundTransparency = 0.95
})
glowTween:Play()

local statusGlowTween = TweenService:Create(statusGlow, TweenInfo.new(2.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
    BackgroundTransparency = 0.95
})
statusGlowTween:Play()
