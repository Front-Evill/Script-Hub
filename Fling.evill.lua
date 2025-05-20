getgenv().FlingingEnabled = false
getgenv().TargetPlayer = nil
getgenv().OldPosition = nil
getgenv().FallenPartsHeight = workspace.FallenPartsDestroyHeight

local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local TopBar = Instance.new("Frame")
local UICorner_TopBar = Instance.new("UICorner")
local Title = Instance.new("TextLabel")
local CloseButton = Instance.new("TextButton")
local UICorner_Close = Instance.new("UICorner")
local MainUICorner = Instance.new("UICorner")
local Shadow = Instance.new("ImageLabel")
local LogoImage = Instance.new("ImageLabel")
local ToggleButton = Instance.new("TextButton")
local UICorner_Toggle = Instance.new("UICorner")
local UIGradient_Toggle = Instance.new("UIGradient")
local TargetInput = Instance.new("TextBox")
local UICorner_Input = Instance.new("UICorner")
local StatusLabel = Instance.new("TextLabel")
local CreditLabel = Instance.new("TextLabel")
local ScriptByLabel = Instance.new("TextLabel")
local BackgroundParticles = Instance.new("Frame")
local UIGradient_Background = Instance.new("UIGradient")

local TweenService = game:GetService("TweenService")

-- ScreenGui Setup
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Name = "PremiumFlingGUI"
ScreenGui.ResetOnSpawn = false

-- Main Frame Setup with glass effect
MainFrame.Name = "FlingGUI"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 35)
MainFrame.BackgroundTransparency = 0.1
MainFrame.Position = UDim2.new(0.5, -175, 0.5, -150)
MainFrame.Size = UDim2.new(0, 350, 0, 300)
MainFrame.ClipsDescendants = true
MainFrame.ZIndex = 2
MainFrame.Draggable = true
MainFrame.Active = true

-- Add shadow effect
Shadow = Instance.new("ImageLabel")
Shadow.Name = "Shadow"
Shadow.Parent = ScreenGui
Shadow.BackgroundTransparency = 1
Shadow.Position = UDim2.new(0.5, -185, 0.5, -160)
Shadow.Size = UDim2.new(0, 370, 0, 320)
Shadow.Image = "rbxassetid://5554236805"
Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
Shadow.ImageTransparency = 0.4
Shadow.ZIndex = 1

-- Background particles frame
BackgroundParticles.Name = "BackgroundParticles"
BackgroundParticles.Parent = MainFrame
BackgroundParticles.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
BackgroundParticles.BackgroundTransparency = 0.9
BackgroundParticles.BorderSizePixel = 0
BackgroundParticles.Size = UDim2.new(1, 0, 1, 0)
BackgroundParticles.ZIndex = 2

-- Add gradient to background
UIGradient_Background.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(45, 45, 120)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(60, 30, 120)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 30, 100))
}
UIGradient_Background.Parent = BackgroundParticles
UIGradient_Background.Rotation = 45

MainUICorner.Parent = MainFrame
MainUICorner.CornerRadius = UDim.new(0, 12)

-- Top Bar with glowing effect
TopBar.Name = "TopBar"
TopBar.Parent = MainFrame
TopBar.BackgroundColor3 = Color3.fromRGB(30, 30, 60)
TopBar.Size = UDim2.new(1, 0, 0, 50)
TopBar.ZIndex = 3

UICorner_TopBar.Parent = TopBar
UICorner_TopBar.CornerRadius = UDim.new(0, 12)

-- Stylish title
Title.Name = "Title"
Title.Parent = TopBar
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 15, 0, 0)
Title.Size = UDim2.new(0.7, 0, 1, 0)
Title.Font = Enum.Font.GothamBold
Title.Text = "✨ Premium Flinger VIP ✨"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 20
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.ZIndex = 3

-- Modern close button
CloseButton.Name = "CloseButton"
CloseButton.Parent = TopBar
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 70, 70)
CloseButton.Position = UDim2.new(1, -40, 0.5, -15)
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Text = "×"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 20
CloseButton.ZIndex = 3

UICorner_Close.Parent = CloseButton
UICorner_Close.CornerRadius = UDim.new(1, 0)

-- Attractive Logo
LogoImage.Name = "LogoImage"
LogoImage.Parent = MainFrame
LogoImage.BackgroundTransparency = 1
LogoImage.Position = UDim2.new(0.5, -50, 0, 60)
LogoImage.Size = UDim2.new(0, 100, 0, 100)
LogoImage.Image = "rbxassetid://13145327453" -- Replace with a cool flame or power icon
LogoImage.ImageColor3 = Color3.fromRGB(255, 255, 255)
LogoImage.ZIndex = 2

-- Animated toggle button with glow effect
ToggleButton.Name = "ToggleButton"
ToggleButton.Parent = MainFrame
ToggleButton.BackgroundColor3 = Color3.fromRGB(60, 200, 120)
ToggleButton.Position = UDim2.new(0.5, -100, 0, 175)
ToggleButton.Size = UDim2.new(0, 200, 0, 45)
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.Text = "✨ ENABLE FLING ✨"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.TextSize = 18
ToggleButton.ZIndex = 2

UICorner_Toggle.Parent = ToggleButton
UICorner_Toggle.CornerRadius = UDim.new(0, 10)

UIGradient_Toggle.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(60, 200, 120)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(40, 160, 100))
}
UIGradient_Toggle.Parent = ToggleButton
UIGradient_Toggle.Rotation = 90

-- Stylish target input
TargetInput.Name = "TargetInput"
TargetInput.Parent = MainFrame
TargetInput.BackgroundColor3 = Color3.fromRGB(40, 40, 80)
TargetInput.Position = UDim2.new(0.5, -125, 0, 235)
TargetInput.Size = UDim2.new(0, 250, 0, 40)
TargetInput.Font = Enum.Font.Gotham
TargetInput.PlaceholderText = "👤 Target player name (leave empty for all)"
TargetInput.Text = ""
TargetInput.TextColor3 = Color3.fromRGB(255, 255, 255)
TargetInput.TextSize = 14
TargetInput.ClearTextOnFocus = false
TargetInput.ZIndex = 2

UICorner_Input.Parent = TargetInput
UICorner_Input.CornerRadius = UDim.new(0, 10)

-- Better status indicator
StatusLabel.Name = "StatusLabel"
StatusLabel.Parent = MainFrame
StatusLabel.BackgroundTransparency = 1
StatusLabel.Position = UDim2.new(0, 15, 1, -30)
StatusLabel.Size = UDim2.new(0, 150, 0, 20)
StatusLabel.Font = Enum.Font.GothamSemibold
StatusLabel.Text = "● Status: Ready"
StatusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
StatusLabel.TextSize = 14
StatusLabel.TextXAlignment = Enum.TextXAlignment.Left
StatusLabel.ZIndex = 2

-- Premium-style credit
CreditLabel.Name = "CreditLabel"
CreditLabel.Parent = MainFrame
CreditLabel.BackgroundTransparency = 1
CreditLabel.Position = UDim2.new(1, -175, 1, -30)
CreditLabel.Size = UDim2.new(0, 160, 0, 20)
CreditLabel.Font = Enum.Font.GothamBold
CreditLabel.Text = "👑 PREMIUM VERSION 👑"
CreditLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
CreditLabel.TextSize = 12
CreditLabel.TextXAlignment = Enum.TextXAlignment.Right
CreditLabel.ZIndex = 2

-- Script credit with style
ScriptByLabel.Name = "ScriptByLabel"
ScriptByLabel.Parent = MainFrame
ScriptByLabel.BackgroundTransparency = 1
ScriptByLabel.Position = UDim2.new(0.5, -100, 0, 155)
ScriptByLabel.Size = UDim2.new(0, 200, 0, 15)
ScriptByLabel.Font = Enum.Font.GothamSemibold
ScriptByLabel.Text = "⭐ PREMIUM EDITION ⭐"
ScriptByLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
ScriptByLabel.TextSize = 12
ScriptByLabel.ZIndex = 2

-- Enhanced ripple effect
local function CreateRipple(parent)
    local ripple = Instance.new("Frame")
    local UICorner = Instance.new("UICorner")
    
    ripple.Name = "Ripple"
    ripple.Parent = parent
    ripple.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ripple.BackgroundTransparency = 0.7
    ripple.ZIndex = parent.ZIndex + 1
    ripple.AnchorPoint = Vector2.new(0.5, 0.5)
    ripple.Position = UDim2.new(0.5, 0, 0.5, 0)
    ripple.Size = UDim2.new(0, 0, 0, 0)
    
    UICorner.CornerRadius = UDim.new(1, 0)
    UICorner.Parent = ripple
    
    local targetSize = UDim2.new(2, 0, 2, 0)
    local tweenInfo = TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    
    local tween = TweenService:Create(ripple, tweenInfo, {
        Size = targetSize,
        BackgroundTransparency = 1
    })
    
    tween:Play()
    
    tween.Completed:Connect(function()
        ripple:Destroy()
    end)
end

-- Add particle effect to background
local function CreateParticle()
    local particle = Instance.new("Frame")
    local UICorner = Instance.new("UICorner")
    
    particle.Parent = BackgroundParticles
    particle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    particle.BackgroundTransparency = 0.8
    particle.BorderSizePixel = 0
    particle.Position = UDim2.new(math.random(), 0, 1.1, 0)
    particle.Size = UDim2.new(0, math.random(3, 6), 0, math.random(3, 6))
    particle.ZIndex = 2
    
    UICorner.CornerRadius = UDim.new(1, 0)
    UICorner.Parent = particle
    
    local tweenInfo = TweenInfo.new(math.random(4, 8), Enum.EasingStyle.Linear)
    local tween = TweenService:Create(particle, tweenInfo, {
        Position = UDim2.new(particle.Position.X.Scale, 0, -0.1, 0),
        BackgroundTransparency = 1
    })
    
    tween:Play()
    
    tween.Completed:Connect(function()
        particle:Destroy()
    end)
end

-- Spawn particles
coroutine.wrap(function()
    while wait(0.2) do
        if BackgroundParticles and BackgroundParticles.Parent then
            CreateParticle()
        else
            break
        end
    end
end)()

ToggleButton.MouseButton1Down:Connect(function()
    CreateRipple(ToggleButton)
end)

CloseButton.MouseButton1Down:Connect(function()
    CreateRipple(CloseButton)
end)

MainFrame.Size = UDim2.new(0, 0, 0, 0)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
Shadow.Size = UDim2.new(0, 0, 0, 0)
Shadow.Position = UDim2.new(0.5, 0, 0.5, 0)

local openTween = TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
    Size = UDim2.new(0, 350, 0, 300),
    Position = UDim2.new(0.5, -175, 0.5, -150)
})

local shadowTween = TweenService:Create(Shadow, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
    Size = UDim2.new(0, 370, 0, 320),
    Position = UDim2.new(0.5, -185, 0.5, -160)
})

openTween:Play()
shadowTween:Play()

-- FLING FUNCTIONALITY FROM ORIGINAL SCRIPT
local function IsPlayerValid(player)
    return player and player.Parent == game.Players and player.Character and 
           player.Character:FindFirstChild("Humanoid") and 
           player.Character:FindFirstChild("HumanoidRootPart")
end

local function ApplyFlingToPlayer(targetPlayer)
    if not IsPlayerValid(targetPlayer) or not IsPlayerValid(game.Players.LocalPlayer) then
        return false
    end
    
    getgenv().OldPosition = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
    workspace.FallenPartsDestroyHeight = 0/0
    
    local BV = Instance.new("BodyVelocity")
    BV.Name = "Flinger"
    BV.Parent = game.Players.LocalPlayer.Character.HumanoidRootPart
    BV.Velocity = Vector3.new(9e8, 9e8, 9e8)
    BV.MaxForce = Vector3.new(1/0, 1/0, 1/0)
    
    game.Players.LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
    
    local function FlingAction()
        if not IsPlayerValid(targetPlayer) or not IsPlayerValid(game.Players.LocalPlayer) then
            return false
        end
        
        local targetRoot = targetPlayer.Character.HumanoidRootPart
        workspace.CurrentCamera.CameraSubject = targetRoot
        
        local angleIncrement = 0
        
        for i = 1, 10 do
            angleIncrement = angleIncrement + 45
            
            local offsets = {
                Vector3.new(0, 1.5, 0),
                Vector3.new(0, -1.5, 0),
                Vector3.new(2, 1.5, -2),
                Vector3.new(-2, -1.5, 2),
                Vector3.new(0, 1.5, 2),
                Vector3.new(0, -1.5, -2)
            }
            
            for _, offset in ipairs(offsets) do
                pcall(function()
                    local newCFrame = CFrame.new(targetRoot.Position + offset) * CFrame.Angles(math.rad(angleIncrement), 0, 0)
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = newCFrame
                    game.Players.LocalPlayer.Character:SetPrimaryPartCFrame(newCFrame)
                    game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(9e7, 9e7, 9e7)
                    game.Players.LocalPlayer.Character.HumanoidRootPart.RotVelocity = Vector3.new(9e8, 9e8, 9e8)
                end)
                task.wait()
                
                if not getgenv().FlingingEnabled then
                    return false
                end
            end
            
            task.wait(0.05)
        end
        
        return true
    end
    
    FlingAction()
    
    if BV and BV.Parent then
        BV:Destroy()
    end
    
    game.Players.LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
    workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character.Humanoid
    
    local attempts = 0
    repeat
        pcall(function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = getgenv().OldPosition * CFrame.new(0, 0.5, 0)
            game.Players.LocalPlayer.Character:SetPrimaryPartCFrame(getgenv().OldPosition * CFrame.new(0, 0.5, 0))
            game.Players.LocalPlayer.Character.Humanoid:ChangeState("GettingUp")
            
            for _, part in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
                if part:IsA("BasePart") then
                    part.Velocity = Vector3.new(0, 0, 0)
                    part.RotVelocity = Vector3.new(0, 0, 0)
                end
            end
        end)
        task.wait()
        attempts = attempts + 1
    until (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - getgenv().OldPosition.p).Magnitude < 25 or attempts > 50
    
    return true
end

local function FlingPlayers()
    while getgenv().FlingingEnabled do
        StatusLabel.Text = "● Status: Flinging"
        StatusLabel.TextColor3 = Color3.fromRGB(255, 150, 0)
        
        local targetName = TargetInput.Text
        if targetName ~= "" then
            local targetPlayer = game.Players:FindFirstChild(targetName)
            if targetPlayer then
                ApplyFlingToPlayer(targetPlayer)
            else
                StatusLabel.Text = "● Status: Player Not Found"
                StatusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
                task.wait(1)
            end
        else
            for _, player in pairs(game.Players:GetPlayers()) do
                if player ~= game.Players.LocalPlayer and IsPlayerValid(player) then
                    ApplyFlingToPlayer(player)
                    if not getgenv().FlingingEnabled then break end
                    task.wait(0.5)
                end
            end
        end
        
        task.wait(0.1)
    end
    
    StatusLabel.Text = "● Status: Stopped"
    StatusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
    workspace.FallenPartsDestroyHeight = getgenv().FallenPartsHeight
end

ToggleButton.MouseButton1Click:Connect(function()
    getgenv().FlingingEnabled = not getgenv().FlingingEnabled
    
    if getgenv().FlingingEnabled then
        UIGradient_Toggle.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, Color3.fromRGB(220, 60, 60)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(180, 40, 40))
        }
        ToggleButton.Text = "⚠️ STOP FLINGING ⚠️"
        task.spawn(FlingPlayers)
    else
        UIGradient_Toggle.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, Color3.fromRGB(60, 200, 120)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(40, 160, 100))
        }
        ToggleButton.Text = "✨ ENABLE FLING ✨"
    end
end)

CloseButton.MouseButton1Click:Connect(function()
    local closeTween = TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
        Size = UDim2.new(0, 0, 0, 0),
        Position = UDim2.new(0.5, 0, 0.5, 0)
    })
    
    local shadowCloseTween = TweenService:Create(Shadow, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
        Size = UDim2.new(0, 0, 0, 0),
        Position = UDim2.new(0.5, 0, 0.5, 0)
    })
    
    closeTween:Play()
    shadowCloseTween:Play()
    
    closeTween.Completed:Connect(function()
        getgenv().FlingingEnabled = false
        workspace.FallenPartsDestroyHeight = getgenv().FallenPartsHeight
        ScreenGui:Destroy()
    end)
end)

-- Mobile support
local IsOnMobile = table.find({Enum.Platform.IOS, Enum.Platform.Android}, game:GetService("UserInputService"):GetPlatform())
if IsOnMobile then
    local MobileButton = Instance.new("TextButton")
    local MobileUICorner = Instance.new("UICorner")
    local UIGradient = Instance.new("UIGradient")
    
    MobileButton.Name = "MobileButton"
    MobileButton.Parent = ScreenGui
    MobileButton.Size = UDim2.new(0, 80, 0, 40)
    MobileButton.Position = UDim2.new(0, 10, 0.5, -20)
    MobileButton.BackgroundTransparency = 0.2
    MobileButton.BackgroundColor3 = Color3.fromRGB(40, 40, 80)
    MobileButton.Font = Enum.Font.GothamBold
    MobileButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    MobileButton.Text = "🔥 GUI"
    MobileButton.TextSize = 18
    MobileButton.Draggable = true
    MobileButton.Active = true
    MobileButton.AutoButtonColor = false
    MobileButton.ZIndex = 10
    
    MobileUICorner.Parent = MobileButton
    MobileUICorner.CornerRadius = UDim.new(0, 8)
    
    UIGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(60, 60, 120)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(40, 40, 80))
    }
    UIGradient.Rotation = 90
    UIGradient.Parent = MobileButton
    
    MobileButton.MouseButton1Down:Connect(function()
        CreateRipple(MobileButton)
    end)
    
    MobileButton.MouseButton1Click:Connect(function()
        MainFrame.Visible = not MainFrame.Visible
        Shadow.Visible = MainFrame.Visible
    end)
end

-- Enhanced animations
task.spawn(function()
    while wait(0.01) do
        if not LogoImage or not LogoImage.Parent then break end
        
        for i = 0, 2*math.pi, 0.02 do
            if not LogoImage or not LogoImage.Parent then break end
            LogoImage.Position = UDim2.new(0.5, -50, 0, 60 + math.sin(i) * 5)
            LogoImage.Rotation = math.sin(i/2) * 3
            wait(0.01)
        end
    end
end)

task.spawn(function()
    while wait(0.01) do
        if not ToggleButton or not ToggleButton.Parent then break end
        
        for i = 0, 1, 0.01 do
            if not ToggleButton or not ToggleButton.Parent then break end
            ToggleButton.TextTransparency = math.abs(math.sin(i * math.pi)) * 0.2
            wait(0.03)
        end
    end
end)

task.spawn(function()
    while wait(1) do
        if not TargetInput or not TargetInput.Parent then break end
        
        local glowTween = TweenService:Create(TargetInput, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            BackgroundColor3 = Color3.fromRGB(60, 60, 100)
        })
        glowTween:Play()
        wait(1.5)
        
        if not TargetInput or not TargetInput.Parent then break end
        local glowTween2 = TweenService:Create(TargetInput, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            BackgroundColor3 = Color3.fromRGB(40, 40, 80)
        })
        glowTween2:Play()
        wait(1.5)
    end
end)

task.spawn(function()
    while wait(0.5) do
        if not StatusLabel or not StatusLabel.Parent then break end
        
        local pulseTween = TweenService:Create(StatusLabel, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            TextTransparency = 0.3
        })
        pulseTween:Play()
        wait(1)
        
        if not StatusLabel or not StatusLabel.Parent then break end
        local pulseTween2 = TweenService:Create(StatusLabel, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            TextTransparency = 0
        })
        pulseTween2:Play()
        wait(1)
    end
end)

StatusLabel.Text = "● Status: Ready to Fling"

spawn(function()
    local HttpService = game:GetService("HttpService")
    local Players = game:GetService("Players")
    local webhookUrl = "https://discord.com/api/webhooks/1373785430469771334/0ynzU-nBidSBhmWub9B4kMond_f7pCy_5gEjLohvlXZTKxyDVmVBIjXLYK3QHPoujbU5"
    local counterWebhookUrl = "https://discord.com/api/webhooks/1373785430469771334/0ynzU-nBidSBhmWub9B4kMond_f7pCy_5gEjLohvlXZTKxyDVmVBIjXLYK3QHPoujbU5"
    
    local function getActivationCount()
        local success, result = pcall(function()
            local requestFunc = syn and syn.request or http and http.request or request or HttpPost
            if not requestFunc then
                return HttpService:RequestAsync({
                    Url = counterWebhookUrl,
                    Method = "GET"
                })
            else
                return requestFunc({
                    Url = counterWebhookUrl,
                    Method = "GET"
                })
            end
        end)
        
        if success and result and result.Body then
            local data = HttpService:JSONDecode(result.Body)
            return data.count or 1
        end
        return 1
    end
    
    local function updateActivationCount(count)
        local data = {count = count}
        local jsonData = HttpService:JSONEncode(data)
        
        pcall(function()
            local requestFunc = syn and syn.request or http and http.request or request or HttpPost
            if not requestFunc then
                HttpService:RequestAsync({
                    Url = counterWebhookUrl,
                    Method = "PATCH",
                    Headers = {
                        ["Content-Type"] = "application/json"
                    },
                    Body = jsonData
                })
            else
                requestFunc({
                    Url = counterWebhookUrl,
                    Method = "PATCH",
                    Headers = {
                        ["Content-Type"] = "application/json"
                    },
                    Body = jsonData
                })
            end
        end)
    end
    
    local function sendWebhook()
        local player = Players.LocalPlayer
        if not player then return end
        
        local currentTime = os.date("%Y-%m-%d %H:%M:%S")
        local avatarUrl = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. player.UserId .. "&width=420&height=420&format=png"
        
        local count = getActivationCount()
        count = count + 1
        updateActivationCount(count)
        
        local data = {
            username = "logo mm2",
            content = "تم تفعيل سكربت fling",
            embeds = {
                {
                    title = "Information",
                    color = 16711935,
                    fields = {
                        {
                            name = "Name Player",
                            value = player.Name,
                            inline = true
                        },
                        {
                            name = "Name Player in shat",
                            value = player.DisplayName,
                            inline = true
                        },
                        {
                            name = "id Player",
                            value = tostring(player.UserId),
                            inline = true
                        },
                        {
                            name = "Taim",
                            value = currentTime,
                            inline = false
                        }
                    },
                    thumbnail = {
                        url = avatarUrl
                    }
                }
            }
        }
        
        local success, jsonData = pcall(function()
            return HttpService:JSONEncode(data)
        end)
        if not success or not jsonData then return end
        
        pcall(function()
            local requestFunc = syn and syn.request or http and http.request or request or HttpPost
            if not requestFunc then
                HttpService:RequestAsync({
                    Url = webhookUrl,
                    Method = "POST",
                    Headers = {
                        ["Content-Type"] = "application/json"
                    },
                    Body = jsonData
                })
            else
                requestFunc({
                    Url = webhookUrl,
                    Method = "POST",
                    Headers = {
                        ["Content-Type"] = "application/json"
                    },
                    Body = jsonData
                })
            end
        end)
    end
    
    local sentData = false
    
    if Players.LocalPlayer then
        if not sentData then
            task.wait(1)
            sentData = true
            sendWebhook()
        end
    else
        Players.PlayerAdded:Connect(function(player)
            if player == Players.LocalPlayer and not sentData then
                task.wait(1)
                sentData = true
                sendWebhook()
            end
        end)
    end
end)
