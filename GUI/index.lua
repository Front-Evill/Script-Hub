-- Enhanced Farm GUI for Roblox (Black & Transparent with Advanced Features)
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local FarmingStatus = Instance.new("TextLabel")
local StartButton = Instance.new("TextButton")
local StopButton = Instance.new("TextButton")
local SettingsButton = Instance.new("TextButton")
local StatsFrame = Instance.new("Frame")
local ResourceCount = Instance.new("TextLabel")
local TimeElapsed = Instance.new("TextLabel")
local CloseButton = Instance.new("TextButton")
local UpgradesButton = Instance.new("TextButton")
local SpeedMultiplier = Instance.new("TextLabel")
local ProgressBar = Instance.new("Frame")
local ProgressFill = Instance.new("Frame")
local SettingsFrame = Instance.new("Frame")
local AutoFarmToggle = Instance.new("TextButton")
local NotificationsToggle = Instance.new("TextButton")
local AudioToggle = Instance.new("TextButton")
local BackButton = Instance.new("TextButton")
local UpgradesFrame = Instance.new("Frame")
local SpeedUpgrade = Instance.new("TextButton")
local CapacityUpgrade = Instance.new("TextButton")
local EfficiencyUpgrade = Instance.new("TextButton")
local UpgradesBackButton = Instance.new("TextButton")

-- Parent the GUI to the player
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

-- Main Frame with gradient and corner radius
MainFrame.Name = "FarmGUI"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
MainFrame.BackgroundTransparency = 0.25
MainFrame.BorderColor3 = Color3.fromRGB(85, 170, 255)
MainFrame.Position = UDim2.new(0.5, -175, 0.5, -150)
MainFrame.Size = UDim2.new(0, 350, 0, 300)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ClipsDescendants = true

-- Add corner radius
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame

-- Add gradient
local UIGradient = Instance.new("UIGradient")
UIGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(15, 15, 25)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 30, 45))
})
UIGradient.Rotation = 45
UIGradient.Parent = MainFrame

-- Title with glow effect
Title.Name = "Title"
Title.Parent = MainFrame
Title.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Title.BackgroundTransparency = 0.7
Title.BorderColor3 = Color3.fromRGB(85, 170, 255)
Title.Size = UDim2.new(1, 0, 0, 35)
Title.Font = Enum.Font.GothamBold
Title.Text = "🌾 ADVANCED FARM SYSTEM 🌾"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 18.0

-- Add corner radius to title
local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 6)
TitleCorner.Parent = Title

-- Farming Status with animation
FarmingStatus.Name = "Status"
FarmingStatus.Parent = MainFrame
FarmingStatus.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
FarmingStatus.BackgroundTransparency = 0.85
FarmingStatus.BorderSizePixel = 0
FarmingStatus.Position = UDim2.new(0, 15, 0, 45)
FarmingStatus.Size = UDim2.new(1, -30, 0, 25)
FarmingStatus.Font = Enum.Font.GothamSemibold
FarmingStatus.Text = "Status: Inactive"
FarmingStatus.TextColor3 = Color3.fromRGB(255, 75, 75)
FarmingStatus.TextSize = 14.0
FarmingStatus.TextXAlignment = Enum.TextXAlignment.Left

-- Progress Bar Background
ProgressBar.Name = "ProgressBar"
ProgressBar.Parent = MainFrame
ProgressBar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
ProgressBar.BackgroundTransparency = 0.5
ProgressBar.BorderSizePixel = 0
ProgressBar.Position = UDim2.new(0.1, 0, 0.28, 0)
ProgressBar.Size = UDim2.new(0.8, 0, 0, 12)

-- Progress Bar Corner
local ProgressBarCorner = Instance.new("UICorner")
ProgressBarCorner.CornerRadius = UDim.new(0, 6)
ProgressBarCorner.Parent = ProgressBar

-- Progress Fill
ProgressFill.Name = "Fill"
ProgressFill.Parent = ProgressBar
ProgressFill.BackgroundColor3 = Color3.fromRGB(85, 170, 255)
ProgressFill.BorderSizePixel = 0
ProgressFill.Size = UDim2.new(0, 0, 1, 0)

-- Progress Fill Corner
local ProgressFillCorner = Instance.new("UICorner")
ProgressFillCorner.CornerRadius = UDim.new(0, 6)
ProgressFillCorner.Parent = ProgressFill

-- Progress Fill Gradient
local ProgressGradient = Instance.new("UIGradient")
ProgressGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(55, 155, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 215, 255))
})
ProgressGradient.Parent = ProgressFill

-- Start Button with glow
StartButton.Name = "StartButton"
StartButton.Parent = MainFrame
StartButton.BackgroundColor3 = Color3.fromRGB(25, 150, 50)
StartButton.BackgroundTransparency = 0.3
StartButton.BorderColor3 = Color3.fromRGB(0, 255, 100)
StartButton.Position = UDim2.new(0.1, 0, 0.35, 0)
StartButton.Size = UDim2.new(0.35, 0, 0, 45)
StartButton.Font = Enum.Font.GothamBold
StartButton.Text = "▶ START"
StartButton.TextColor3 = Color3.fromRGB(255, 255, 255)
StartButton.TextSize = 16.0

-- Start Button Corner
local StartButtonCorner = Instance.new("UICorner")
StartButtonCorner.CornerRadius = UDim.new(0, 6)
StartButtonCorner.Parent = StartButton

-- Stop Button with glow
StopButton.Name = "StopButton"
StopButton.Parent = MainFrame
StopButton.BackgroundColor3 = Color3.fromRGB(150, 25, 25)
StopButton.BackgroundTransparency = 0.3
StopButton.BorderColor3 = Color3.fromRGB(255, 75, 75)
StopButton.Position = UDim2.new(0.55, 0, 0.35, 0)
StopButton.Size = UDim2.new(0.35, 0, 0, 45)
StopButton.Font = Enum.Font.GothamBold
StopButton.Text = "■ STOP"
StopButton.TextColor3 = Color3.fromRGB(255, 255, 255)
StopButton.TextSize = 16.0

-- Stop Button Corner
local StopButtonCorner = Instance.new("UICorner")
StopButtonCorner.CornerRadius = UDim.new(0, 6)
StopButtonCorner.Parent = StopButton

-- Speed Multiplier
SpeedMultiplier.Name = "SpeedMultiplier"
SpeedMultiplier.Parent = MainFrame
SpeedMultiplier.BackgroundTransparency = 1
SpeedMultiplier.Position = UDim2.new(0.1, 0, 0.5, 0)
SpeedMultiplier.Size = UDim2.new(0.8, 0, 0, 20)
SpeedMultiplier.Font = Enum.Font.GothamSemibold
SpeedMultiplier.Text = "Speed: 1.0x"
SpeedMultiplier.TextColor3 = Color3.fromRGB(255, 220, 100)
SpeedMultiplier.TextSize = 14.0

-- Stats Frame with shadow
StatsFrame.Name = "StatsFrame"
StatsFrame.Parent = MainFrame
StatsFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
StatsFrame.BackgroundTransparency = 0.6
StatsFrame.BorderColor3 = Color3.fromRGB(85, 170, 255)
StatsFrame.Position = UDim2.new(0.1, 0, 0.57, 0)
StatsFrame.Size = UDim2.new(0.8, 0, 0.23, 0)

-- Stats Frame Corner
local StatsFrameCorner = Instance.new("UICorner")
StatsFrameCorner.CornerRadius = UDim.new(0, 6)
StatsFrameCorner.Parent = StatsFrame

-- Resource Counter with icon
ResourceCount.Name = "Resources"
ResourceCount.Parent = StatsFrame
ResourceCount.BackgroundTransparency = 1
ResourceCount.Position = UDim2.new(0, 15, 0, 10)
ResourceCount.Size = UDim2.new(1, -30, 0, 20)
ResourceCount.Font = Enum.Font.GothamSemibold
ResourceCount.Text = "🌿 Resources: 0"
ResourceCount.TextColor3 = Color3.fromRGB(120, 255, 120)
ResourceCount.TextSize = 14.0
ResourceCount.TextXAlignment = Enum.TextXAlignment.Left

-- Time Counter with icon
TimeElapsed.Name = "Timer"
TimeElapsed.Parent = StatsFrame
TimeElapsed.BackgroundTransparency = 1
TimeElapsed.Position = UDim2.new(0, 15, 0, 35)
TimeElapsed.Size = UDim2.new(1, -30, 0, 20)
TimeElapsed.Font = Enum.Font.GothamSemibold
TimeElapsed.Text = "⏱️ Time: 00:00:00"
TimeElapsed.TextColor3 = Color3.fromRGB(255, 255, 255)
TimeElapsed.TextSize = 14.0
TimeElapsed.TextXAlignment = Enum.TextXAlignment.Left

-- Settings Button
SettingsButton.Name = "SettingsButton"
SettingsButton.Parent = MainFrame
SettingsButton.BackgroundColor3 = Color3.fromRGB(60, 60, 90)
SettingsButton.BackgroundTransparency = 0.3
SettingsButton.BorderColor3 = Color3.fromRGB(85, 85, 255)
SettingsButton.Position = UDim2.new(0.15, 0, 0.85, 0)
SettingsButton.Size = UDim2.new(0.3, 0, 0, 30)
SettingsButton.Font = Enum.Font.GothamSemibold
SettingsButton.Text = "⚙️ SETTINGS"
SettingsButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SettingsButton.TextSize = 14.0

-- Settings Button Corner
local SettingsButtonCorner = Instance.new("UICorner")
SettingsButtonCorner.CornerRadius = UDim.new(0, 6)
SettingsButtonCorner.Parent = SettingsButton

-- Upgrades Button
UpgradesButton.Name = "UpgradesButton"
UpgradesButton.Parent = MainFrame
UpgradesButton.BackgroundColor3 = Color3.fromRGB(90, 60, 120)
UpgradesButton.BackgroundTransparency = 0.3
UpgradesButton.BorderColor3 = Color3.fromRGB(140, 85, 255)
UpgradesButton.Position = UDim2.new(0.55, 0, 0.85, 0)
UpgradesButton.Size = UDim2.new(0.3, 0, 0, 30)
UpgradesButton.Font = Enum.Font.GothamSemibold
UpgradesButton.Text = "⬆️ UPGRADES"
UpgradesButton.TextColor3 = Color3.fromRGB(255, 255, 255)
UpgradesButton.TextSize = 14.0

-- Upgrades Button Corner
local UpgradesButtonCorner = Instance.new("UICorner")
UpgradesButtonCorner.CornerRadius = UDim.new(0, 6)
UpgradesButtonCorner.Parent = UpgradesButton

-- Close Button
CloseButton.Name = "CloseButton"
CloseButton.Parent = MainFrame
CloseButton.BackgroundColor3 = Color3.fromRGB(150, 25, 25)
CloseButton.BackgroundTransparency = 0.3
CloseButton.BorderSizePixel = 0
CloseButton.Position = UDim2.new(1, -30, 0, 0)
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Text = "✖"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 16.0

-- Close Button Corner
local CloseButtonCorner = Instance.new("UICorner")
CloseButtonCorner.CornerRadius = UDim.new(0, 6)
CloseButtonCorner.Parent = CloseButton

-- Settings Frame
SettingsFrame.Name = "SettingsFrame"
SettingsFrame.Parent = MainFrame
SettingsFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
SettingsFrame.BackgroundTransparency = 0.1
SettingsFrame.BorderSizePixel = 0
SettingsFrame.Position = UDim2.new(0, 0, 0, 35)
SettingsFrame.Size = UDim2.new(1, 0, 1, -35)
SettingsFrame.Visible = false

-- Settings Frame Corner
local SettingsFrameCorner = Instance.new("UICorner")
SettingsFrameCorner.CornerRadius = UDim.new(0, 8)
SettingsFrameCorner.Parent = SettingsFrame

-- Auto Farm Toggle
AutoFarmToggle.Name = "AutoFarmToggle"
AutoFarmToggle.Parent = SettingsFrame
AutoFarmToggle.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
AutoFarmToggle.BackgroundTransparency = 0.3
AutoFarmToggle.Position = UDim2.new(0.1, 0, 0.15, 0)
AutoFarmToggle.Size = UDim2.new(0.8, 0, 0, 40)
AutoFarmToggle.Font = Enum.Font.GothamSemibold
AutoFarmToggle.Text = "🔄 Auto Farm: OFF"
AutoFarmToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoFarmToggle.TextSize = 14.0

-- Auto Farm Toggle Corner
local AutoFarmToggleCorner = Instance.new("UICorner")
AutoFarmToggleCorner.CornerRadius = UDim.new(0, 6)
AutoFarmToggleCorner.Parent = AutoFarmToggle

-- Notifications Toggle
NotificationsToggle.Name = "NotificationsToggle"
NotificationsToggle.Parent = SettingsFrame
NotificationsToggle.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
NotificationsToggle.BackgroundTransparency = 0.3
NotificationsToggle.Position = UDim2.new(0.1, 0, 0.35, 0)
NotificationsToggle.Size = UDim2.new(0.8, 0, 0, 40)
NotificationsToggle.Font = Enum.Font.GothamSemibold
NotificationsToggle.Text = "🔔 Notifications: ON"
NotificationsToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
NotificationsToggle.TextSize = 14.0

-- Notifications Toggle Corner
local NotificationsToggleCorner = Instance.new("UICorner")
NotificationsToggleCorner.CornerRadius = UDim.new(0, 6)
NotificationsToggleCorner.Parent = NotificationsToggle

-- Audio Toggle
AudioToggle.Name = "AudioToggle"
AudioToggle.Parent = SettingsFrame
AudioToggle.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
AudioToggle.BackgroundTransparency = 0.3
AudioToggle.Position = UDim2.new(0.1, 0, 0.55, 0)
AudioToggle.Size = UDim2.new(0.8, 0, 0, 40)
AudioToggle.Font = Enum.Font.GothamSemibold
AudioToggle.Text = "🔊 Sound Effects: ON"
AudioToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
AudioToggle.TextSize = 14.0

-- Audio Toggle Corner
local AudioToggleCorner = Instance.new("UICorner")
AudioToggleCorner.CornerRadius = UDim.new(0, 6)
AudioToggleCorner.Parent = AudioToggle

-- Settings Back Button
BackButton.Name = "BackButton"
BackButton.Parent = SettingsFrame
BackButton.BackgroundColor3 = Color3.fromRGB(60, 60, 90)
BackButton.BackgroundTransparency = 0.3
BackButton.Position = UDim2.new(0.3, 0, 0.8, 0)
BackButton.Size = UDim2.new(0.4, 0, 0, 40)
BackButton.Font = Enum.Font.GothamSemibold
BackButton.Text = "◀ BACK"
BackButton.TextColor3 = Color3.fromRGB(255, 255, 255)
BackButton.TextSize = 14.0

-- Back Button Corner
local BackButtonCorner = Instance.new("UICorner")
BackButtonCorner.CornerRadius = UDim.new(0, 6)
BackButtonCorner.Parent = BackButton

-- Upgrades Frame
UpgradesFrame.Name = "UpgradesFrame"
UpgradesFrame.Parent = MainFrame
UpgradesFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
UpgradesFrame.BackgroundTransparency = 0.1
UpgradesFrame.BorderSizePixel = 0
UpgradesFrame.Position = UDim2.new(0, 0, 0, 35)
UpgradesFrame.Size = UDim2.new(1, 0, 1, -35)
UpgradesFrame.Visible = false

-- Upgrades Frame Corner
local UpgradesFrameCorner = Instance.new("UICorner")
UpgradesFrameCorner.CornerRadius = UDim.new(0, 8)
UpgradesFrameCorner.Parent = UpgradesFrame

-- Speed Upgrade Button
SpeedUpgrade.Name = "SpeedUpgrade"
SpeedUpgrade.Parent = UpgradesFrame
SpeedUpgrade.BackgroundColor3 = Color3.fromRGB(40, 80, 120)
SpeedUpgrade.BackgroundTransparency = 0.3
SpeedUpgrade.Position = UDim2.new(0.1, 0, 0.15, 0)
SpeedUpgrade.Size = UDim2.new(0.8, 0, 0, 40)
SpeedUpgrade.Font = Enum.Font.GothamSemibold
SpeedUpgrade.Text = "⚡ Speed Upgrade (50 Resources)"
SpeedUpgrade.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedUpgrade.TextSize = 14.0

-- Speed Upgrade Corner
local SpeedUpgradeCorner = Instance.new("UICorner")
SpeedUpgradeCorner.CornerRadius = UDim.new(0, 6)
SpeedUpgradeCorner.Parent = SpeedUpgrade

-- Capacity Upgrade Button
CapacityUpgrade.Name = "CapacityUpgrade"
CapacityUpgrade.Parent = UpgradesFrame
CapacityUpgrade.BackgroundColor3 = Color3.fromRGB(80, 40, 120)
CapacityUpgrade.BackgroundTransparency = 0.3
CapacityUpgrade.Position = UDim2.new(0.1, 0, 0.35, 0)
CapacityUpgrade.Size = UDim2.new(0.8, 0, 0, 40)
CapacityUpgrade.Font = Enum.Font.GothamSemibold
CapacityUpgrade.Text = "📦 Capacity Upgrade (75 Resources)"
CapacityUpgrade.TextColor3 = Color3.fromRGB(255, 255, 255)
CapacityUpgrade.TextSize = 14.0

-- Capacity Upgrade Corner
local CapacityUpgradeCorner = Instance.new("UICorner")
CapacityUpgradeCorner.CornerRadius = UDim.new(0, 6)
CapacityUpgradeCorner.Parent = CapacityUpgrade

-- Efficiency Upgrade Button
EfficiencyUpgrade.Name = "EfficiencyUpgrade"
EfficiencyUpgrade.Parent = UpgradesFrame
EfficiencyUpgrade.BackgroundColor3 = Color3.fromRGB(120, 80, 40)
EfficiencyUpgrade.BackgroundTransparency = 0.3
EfficiencyUpgrade.Position = UDim2.new(0.1, 0, 0.55, 0)
EfficiencyUpgrade.Size = UDim2.new(0.8, 0, 0, 40)
EfficiencyUpgrade.Font = Enum.Font.GothamSemibold
EfficiencyUpgrade.Text = "🔧 Efficiency Upgrade (100 Resources)"
EfficiencyUpgrade.TextColor3 = Color3.fromRGB(255, 255, 255)
EfficiencyUpgrade.TextSize = 14.0

-- Efficiency Upgrade Corner
local EfficiencyUpgradeCorner = Instance.new("UICorner")
EfficiencyUpgradeCorner.CornerRadius = UDim.new(0, 6)
EfficiencyUpgradeCorner.Parent = EfficiencyUpgrade

-- Upgrades Back Button
UpgradesBackButton.Name = "UpgradesBackButton"
UpgradesBackButton.Parent = UpgradesFrame
UpgradesBackButton.BackgroundColor3 = Color3.fromRGB(60, 60, 90)
UpgradesBackButton.BackgroundTransparency = 0.3
UpgradesBackButton.Position = UDim2.new(0.3, 0, 0.8, 0)
UpgradesBackButton.Size = UDim2.new(0.4, 0, 0, 40)
UpgradesBackButton.Font = Enum.Font.GothamSemibold
UpgradesBackButton.Text = "◀ BACK"
UpgradesBackButton.TextColor3 = Color3.fromRGB(255, 255, 255)
UpgradesBackButton.TextSize = 14.0

-- Upgrades Back Button Corner
local UpgradesBackButtonCorner = Instance.new("UICorner")
UpgradesBackButtonCorner.CornerRadius = UDim.new(0, 6)
UpgradesBackButtonCorner.Parent = UpgradesBackButton

-- Variables for farming system
local farming = false
local autoFarm = false
local notifications = true
local soundEffects = true
local startTime = 0
local resources = 0
local maxResources = 100
local speedMultiplier = 1
local upgradeCosts = {
    speed = 50,
    capacity = 75,
    efficiency = 100
}

-- Function to show notification
local function showNotification(message, color)
    if not notifications then return end
    
    local notification = Instance.new("Frame")
    notification.Name = "Notification"
    notification.Parent = ScreenGui
    notification.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
    notification.BackgroundTransparency = 0.2
    notification.BorderSizePixel = 0
    notification.Position = UDim2.new(0.5, -150, 0.05, 0)
    notification.Size = UDim2.new(0, 300, 0, 50)
    
    local notificationCorner = Instance.new("UICorner")
    notificationCorner.CornerRadius = UDim.new(0, 8)
    notificationCorner.Parent = notification
    
    local notificationText = Instance.new("TextLabel")
    notificationText.Name = "Text"
    notificationText.Parent = notification
    notificationText.BackgroundTransparency = 1
    notificationText.Position = UDim2.new(0, 0, 0, 0)
    notificationText.Size = UDim2.new(1, 0, 1, 0)
    notificationText.Font = Enum.Font.GothamSemibold
    notificationText.Text = message
    notificationText.TextColor3 = color or Color3.fromRGB(255, 255, 255)
    notificationText.TextSize = 16.0
    
    -- Animation
    notification.Position = UDim2.new(0.5, -150, -0.2, 0)
    notification:TweenPosition(UDim2.new(0.5, -150, 0.05, 0), "Out", "Quad", 0.5, true)
    
    -- Auto destroy after 3 seconds
    spawn(function()
        wait(2.5)
        notification:TweenPosition(UDim2.new(0.5, -150, -0.2, 0), "Out", "Quad", 0.5, true)
        wait(0.5)
        notification:Destroy()
    end)
    
    -- Play sound effect
    if soundEffects then
        local sound = Instance.new("Sound")
        sound.SoundId = "rbxassetid://6026984224" -- Replace with your sound ID
        sound.Volume = 0.5
        sound.Parent = ScreenGui
        sound:Play()
        
        spawn(function()
            wait(2)
            sound:Destroy()
        end)
    end
end

-- Function to update progress bar
local function updateProgressBar()
    ProgressFill:TweenSize(UDim2.new(resources / maxResources, 0, 1, 0), "Out", "Quad", 0.3, true)
    
    -- Change color based on fullness
    local ratio = resources / maxResources
    if ratio > 0.8 then
        ProgressGradient.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 100, 0)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 50, 50))
        })
    elseif ratio > 0.5 then
        ProgressGradient.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 200, 0)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 150, 0))
        })
    else
        ProgressGradient.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(55, 155, 255)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 215, 255))
        })
    end
end

-- Function to handle the start button
StartButton.MouseButton1Click:Connect(function()
    if not farming then
        farming = true
        FarmingStatus.Text = "Status: Active"
        FarmingStatus.TextColor3 = Color3.fromRGB(75, 255, 75)
        startTime = tick()
        
        -- Flash animation
        StartButton.BackgroundTransparency = 0.1
        wait(0.1)
        StartButton.BackgroundTransparency = 0.3
        
        showNotification("Farming Started!", Color3.fromRGB(75, 255, 75))
        
        -- Start farming loop
        spawn(function()
            while farming do
                if resources < maxResources then
                    resources = resources + (1 * speedMultiplier)
                    if resources > maxResources then
                        resources = maxResources
                        if notifications then
                            showNotification("Storage Full!", Color3.fromRGB(255, 100, 100))
                        end
                    end
                    ResourceCount.Text = "🌿 Resources: " .. math.floor(resources)
                    updateProgressBar()
                end
                
                wait(1) -- Collect resource every second
                
                local elapsed = tick() - startTime
                local hours = math.floor(elapsed / 3600)
                local minutes = math.floor((elapsed % 3600) / 60)
                local seconds = math.floor(elapsed % 60)
                
                TimeElapsed.Text = string.format("⏱️ Time: %02d:%02d:%02d", hours, minutes, seconds)
            end
        end)
    end
end)

-- Function to handle the stop button
StopButton.MouseButton1Click:Connect(function()
    if farming then
        farming = false
        FarmingStatus.Text = "Status: Inactive"
        FarmingStatus.TextColor3 = Color3.fromRGB(255, 75, 75)
        
        -- Flash animation
        StopButton.BackgroundTransparency = 0.1
        wait(0.1)
        StopButton.BackgroundTransparency = 0.3
        
        showNotification("Farming Stopped!", Color3.fromRGB(255, 100, 100))
    end
end)

-- Function to handle settings button
SettingsButton.MouseButton1Click:Connect(function()
    SettingsFrame.Visible = true
    SettingsFrame.Position = UDim2.new(1, 0, 0, 35)
    SettingsFrame:TweenPosition(UDim2.new(0, 0, 0, 35), "Out", "Quad", 0.3, true)
    
    -- Button animation
    SettingsButton.BackgroundTransparency = 0.1
    wait(0.1)
    SettingsButton.BackgroundTransparency = 0.3
end)

-- Function to handle back button in settings
BackButton.MouseButton1Click:Connect(function()
    SettingsFrame:TweenPosition(UDim2.new(1, 0, 0, 35), "Out", "Quad", 0.3, true)
    wait(0.3)
    SettingsFrame.Visible = false
end)

-- Function to handle upgrades button
UpgradesButton.MouseButton1Click:Connect(function()
    UpgradesFrame.Visible = true
    UpgradesFrame.Position = UDim2.new(-1, 0, 0, 35)
    UpgradesFrame:TweenPosition(UDim2.new(0, 0, 0, 35), "Out", "Quad", 0.3, true)
    
    -- Button animation
    UpgradesButton.BackgroundTransparency = 0.1
    wait(0.1)
    UpgradesButton.BackgroundTransparency = 0.3
end)

-- Function to handle back button in upgrades
UpgradesBackButton.MouseButton1Click:Connect(function()
    UpgradesFrame:TweenPosition(UDim2.new(-1, 0, 0, 35), "Out", "Quad", 0.3, true)
    wait(0.3)
    UpgradesFrame.Visible = false
end)

-- Toggle Buttons Logic
AutoFarmToggle.MouseButton1Click:Connect(function()
    autoFarm = not autoFarm
    AutoFarmToggle.Text = "🔄 Auto Farm: " .. (autoFarm and "ON" or "OFF")
    
    if autoFarm then
        AutoFarmToggle.BackgroundColor3 = Color3.fromRGB(25, 150, 50)
        showNotification("Auto Farm Enabled!", Color3.fromRGB(75, 255, 75))
        
        -- Start auto farm if not already farming
        if not farming then
            farming = true
            FarmingStatus.Text = "Status: Active (Auto)"
            FarmingStatus.TextColor3 = Color3.fromRGB(75, 255, 75)
            startTime = tick()
            
            -- Start farming loop
            spawn(function()
                while farming and autoFarm do
                    if resources < maxResources then
                        resources = resources + (1 * speedMultiplier)
                        if resources > maxResources then
                            resources = maxResources
                            if notifications then
                                showNotification("Storage Full!", Color3.fromRGB(255, 100, 100))
                            end
                        end
                        ResourceCount.Text = "🌿 Resources: " .. math.floor(resources)
                        updateProgressBar()
                    end
                    
                    wait(1) -- Collect resource every second
                    
                    local elapsed = tick() - startTime
                    local hours = math.floor(elapsed / 3600)
                    local minutes = math.floor((elapsed % 3600) / 60)
                    local seconds = math.floor(elapsed % 60)
                    
                    TimeElapsed.Text = string.format("⏱️ Time: %02d:%02d:%02d", hours, minutes, seconds)
                end
            end)
        end
    else
        AutoFarmToggle.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
        showNotification("Auto Farm Disabled!", Color3.fromRGB(255, 100, 100))
        
        if farming then
            FarmingStatus.Text = "Status: Active"
        end
    end
end)

NotificationsToggle.MouseButton1Click:Connect(function()
    notifications = not notifications
    NotificationsToggle.Text = "🔔 Notifications: " .. (notifications and "ON" or "OFF")
    
    if notifications then
        NotificationsToggle.BackgroundColor3 = Color3.fromRGB(25, 150, 50)
        showNotification("Notifications Enabled!", Color3.fromRGB(75, 255, 75))
    else
        NotificationsToggle.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
    end
end)

AudioToggle.MouseButton1Click:Connect(function()
    soundEffects = not soundEffects
    AudioToggle.Text = "🔊 Sound Effects: " .. (soundEffects and "ON" or "OFF")
    
    if soundEffects then
        AudioToggle.BackgroundColor3 = Color3.fromRGB(25, 150, 50)
        showNotification("Sound Effects Enabled!", Color3.fromRGB(75, 255, 75))
        
        -- Play a test sound
        local sound = Instance.new("Sound")
        sound.SoundId = "rbxassetid://6026984224" -- Replace with your sound ID
        sound.Volume = 0.5
        sound.Parent = ScreenGui
        sound:Play()
        
        spawn(function()
            wait(2)
            sound:Destroy()
        end)
    else
        AudioToggle.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
    end
end)

-- Upgrades Logic
SpeedUpgrade.MouseButton1Click:Connect(function()
    if resources >= upgradeCosts.speed then
        resources = resources - upgradeCosts.speed
        ResourceCount.Text = "🌿 Resources: " .. math.floor(resources)
        
        speedMultiplier = speedMultiplier + 0.25
        SpeedMultiplier.Text = "Speed: " .. speedMultiplier .. "x"
        
        -- Increase cost for next upgrade
        upgradeCosts.speed = math.floor(upgradeCosts.speed * 1.5)
        SpeedUpgrade.Text = "⚡ Speed Upgrade (" .. upgradeCosts.speed .. " Resources)"
        
        showNotification("Speed Upgraded! New speed: " .. speedMultiplier .. "x", Color3.fromRGB(100, 200, 255))
        updateProgressBar()
        
        -- Flash effect
        local originalColor = SpeedUpgrade.BackgroundColor3
        SpeedUpgrade.BackgroundColor3 = Color3.fromRGB(255, 255, 100)
        wait(0.2)
        SpeedUpgrade.BackgroundColor3 = originalColor
    else
        showNotification("Not enough resources!", Color3.fromRGB(255, 100, 100))
        
        -- Shake effect
        local originalPosition = SpeedUpgrade.Position
        for i = 1, 5 do
            SpeedUpgrade.Position = originalPosition + UDim2.new(0, math.random(-5, 5), 0, 0)
            wait(0.05)
        end
        SpeedUpgrade.Position = originalPosition
    end
end)

CapacityUpgrade.MouseButton1Click:Connect(function()
    if resources >= upgradeCosts.capacity then
        resources = resources - upgradeCosts.capacity
        ResourceCount.Text = "🌿 Resources: " .. math.floor(resources)
        
        local oldMax = maxResources
        maxResources = maxResources + 50
        
        -- Increase cost for next upgrade
        upgradeCosts.capacity = math.floor(upgradeCosts.capacity * 1.5)
        CapacityUpgrade.Text = "📦 Capacity Upgrade (" .. upgradeCosts.capacity .. " Resources)"
        
        showNotification("Storage Upgraded! Capacity: " .. oldMax .. " → " .. maxResources, Color3.fromRGB(200, 150, 255))
        updateProgressBar()
        
        -- Flash effect
        local originalColor = CapacityUpgrade.BackgroundColor3
        CapacityUpgrade.BackgroundColor3 = Color3.fromRGB(255, 255, 100)
        wait(0.2)
        CapacityUpgrade.BackgroundColor3 = originalColor
    else
        showNotification("Not enough resources!", Color3.fromRGB(255, 100, 100))
        
        -- Shake effect
        local originalPosition = CapacityUpgrade.Position
        for i = 1, 5 do
            CapacityUpgrade.Position = originalPosition + UDim2.new(0, math.random(-5, 5), 0, 0)
            wait(0.05)
        end
        CapacityUpgrade.Position = originalPosition
    end
end)

EfficiencyUpgrade.MouseButton1Click:Connect(function()
    if resources >= upgradeCosts.efficiency then
        resources = resources - upgradeCosts.efficiency
        ResourceCount.Text = "🌿 Resources: " .. math.floor(resources)
        
        -- Add random bonus resources
        local bonus = math.random(10, 30)
        resources = resources + bonus
        ResourceCount.Text = "🌿 Resources: " .. math.floor(resources)
        
        -- Increase cost for next upgrade
        upgradeCosts.efficiency = math.floor(upgradeCosts.efficiency * 1.5)
        EfficiencyUpgrade.Text = "🔧 Efficiency Upgrade (" .. upgradeCosts.efficiency .. " Resources)"
        
        showNotification("Efficiency Upgraded! Bonus: +" .. bonus .. " resources", Color3.fromRGB(255, 200, 100))
        updateProgressBar()
        
        -- Flash effect
        local originalColor = EfficiencyUpgrade.BackgroundColor3
        EfficiencyUpgrade.BackgroundColor3 = Color3.fromRGB(255, 255, 100)
        wait(0.2)
        EfficiencyUpgrade.BackgroundColor3 = originalColor
    else
        showNotification("Not enough resources!", Color3.fromRGB(255, 100, 100))
        
        -- Shake effect
        local originalPosition = EfficiencyUpgrade.Position
        for i = 1, 5 do
            EfficiencyUpgrade.Position = originalPosition + UDim2.new(0, math.random(-5, 5), 0, 0)
            wait(0.05)
        end
        EfficiencyUpgrade.Position = originalPosition
    end
end)

-- Function to handle the close button
CloseButton.MouseButton1Click:Connect(function()
    if farming then
        farming = false
    end
    
    -- Closing animation
    MainFrame:TweenSize(UDim2.new(0, 350, 0, 0), "Out", "Quad", 0.3, true)
    wait(0.3)
    ScreenGui:Destroy()
end)

-- Apply button effects for all buttons
local function applyButtonEffect(button)
    local originalColor = button.BackgroundColor3
    local originalTransparency = button.BackgroundTransparency
    
    button.MouseEnter:Connect(function()
        button:TweenSize(button.Size + UDim2.new(0, 4, 0, 4), "Out", "Quad", 0.1, true)
        button.BackgroundTransparency = originalTransparency - 0.2
    end)
    
    button.MouseLeave:Connect(function()
        button:TweenSize(button.Size - UDim2.new(0, 4, 0, 4), "Out", "Quad", 0.1, true)
        button.BackgroundTransparency = originalTransparency
    end)
    
    button.MouseButton1Down:Connect(function()
        button:TweenSize(button.Size - UDim2.new(0, 6, 0, 6), "Out", "Quad", 0.05, true)
        button.TextSize = button.TextSize - 1
    end)
    
    button.MouseButton1Up:Connect(function()
        button:TweenSize(button.Size + UDim2.new(0, 6, 0, 6), "Out", "Quad", 0.05, true)
        button.TextSize = button.TextSize + 1
    end)
end

-- Apply effects to all buttons
local buttons = {StartButton, StopButton, SettingsButton, UpgradesButton, CloseButton, 
                BackButton, UpgradesBackButton, AutoFarmToggle, NotificationsToggle, 
                AudioToggle, SpeedUpgrade, CapacityUpgrade, EfficiencyUpgrade}

for _, button in pairs(buttons) do
    applyButtonEffect(button)
end

-- Add pulsing animation to title
spawn(function()
    while wait(1) do
        Title.TextColor3 = Color3.fromRGB(255, 255, 255)
        for i = 1, 10 do
            Title.TextColor3 = Color3.fromRGB(255, 255 - (i * 5), 255 - (i * 10))
            wait(0.05)
        end
        for i = 10, 1, -1 do
            Title.TextColor3 = Color3.fromRGB(255, 255 - (i * 5), 255 - (i * 10))
            wait(0.05)
        end
    end
end)

-- Add floating particles effect
spawn(function()
    while wait(0.5) do
        if farming then
            local particle = Instance.new("Frame")
            particle.BackgroundColor3 = Color3.fromRGB(85, 255, 127)
            particle.BackgroundTransparency = 0.7
            particle.BorderSizePixel = 0
            particle.Size = UDim2.new(0, math.random(3, 8), 0, math.random(3, 8))
            particle.Position = UDim2.new(math.random()/2 + 0.25, 0, 0.57, 0)
            particle.Parent = MainFrame
            
            local particleCorner = Instance.new("UICorner")
            particleCorner.CornerRadius = UDim.new(1, 0)
            particleCorner.Parent = particle
            
            -- Animate particle floating up
            spawn(function()
                for i = 1, 20 do
                    particle.Position = particle.Position - UDim2.new(0, 0, 0.01, 0)
                    particle.BackgroundTransparency = 0.7 + (i/50)
                    wait(0.1)
                end
                particle:Destroy()
            end)
        end
    end
end)

-- Opening animation
MainFrame.Size = UDim2.new(0, 350, 0, 0)
MainFrame:TweenSize(UDim2.new(0, 350, 0, 300), "Out", "Back", 0.5, true)

-- Show welcome notification after a short delay
wait(0.5)
showNotification("مرحبا بك في نظام المزرعة المتطور! 🌾", Color3.fromRGB(85, 255, 255))

-- Add a mini tutorial at the start
local function showTutorial()
    local tutorialFrame = Instance.new("Frame")
    tutorialFrame.Name = "Tutorial"
    tutorialFrame.Parent = ScreenGui
    tutorialFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    tutorialFrame.BackgroundTransparency = 0.3
    tutorialFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
    tutorialFrame.Size = UDim2.new(0, 400, 0, 300)
    
    local tutorialCorner = Instance.new("UICorner")
    tutorialCorner.CornerRadius = UDim.new(0, 10)
    tutorialCorner.Parent = tutorialFrame
    
    local tutorialTitle = Instance.new("TextLabel")
    tutorialTitle.Name = "Title"
    tutorialTitle.Parent = tutorialFrame
    tutorialTitle.BackgroundTransparency = 1
    tutorialTitle.Position = UDim2.new(0, 0, 0, 20)
    tutorialTitle.Size = UDim2.new(1, 0, 0, 40)
    tutorialTitle.Font = Enum.Font.GothamBold
    tutorialTitle.Text = "🌱 مرحبا بنظام المزرعة المتطور! 🌱"
    tutorialTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    tutorialTitle.TextSize = 20.0
    
    local tutorialText = Instance.new("TextLabel")
    tutorialText.Name = "Text"
    tutorialText.Parent = tutorialFrame
    tutorialText.BackgroundTransparency = 1
    tutorialText.Position = UDim2.new(0.05, 0, 0, 80)
    tutorialText.Size = UDim2.new(0.9, 0, 0, 150)
    tutorialText.Font = Enum.Font.Gotham
    tutorialText.TextColor3 = Color3.fromRGB(255, 255, 255)
    tutorialText.TextSize = 16.0
    tutorialText.TextWrapped = true
    tutorialText.Text = "• اضغط على 'START' لبدأ الزراعة\n• اجمع الموارد لترقية سرعة الإنتاج\n• استخدم 'UPGRADES' لتحسين قدراتك\n• يمكنك تفعيل الزراعة التلقائية من الإعدادات\n\nاستمتع بالزراعة! 🌿"
    tutorialText.TextXAlignment = Enum.TextXAlignment.Left
    
    local closeButton = Instance.new("TextButton")
    closeButton.Name = "CloseButton"
    closeButton.Parent = tutorialFrame
    closeButton.BackgroundColor3 = Color3.fromRGB(60, 60, 90)
    closeButton.BackgroundTransparency = 0.3
    closeButton.Position = UDim2.new(0.3, 0, 0.8, 0)
    closeButton.Size = UDim2.new(0.4, 0, 0, 40)
    closeButton.Font = Enum.Font.GothamBold
    closeButton.Text = "بدء الزراعة"
    closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeButton.TextSize = 16.0
    
    local closeButtonCorner = Instance.new("UICorner")
    closeButtonCorner.CornerRadius = UDim.new(0, 8)
    closeButtonCorner.Parent = closeButton
    
    -- Animation
    tutorialFrame.BackgroundTransparency = 1
    tutorialTitle.TextTransparency = 1
    tutorialText.TextTransparency = 1
    closeButton.BackgroundTransparency = 1
    closeButton.TextTransparency = 1
    
    wait(1)
    
    tutorialFrame:TweenBackgroundTransparency(0.3, "Out", "Quad", 0.5, true)
    wait(0.2)
    tutorialTitle:TweenPosition(UDim2.new(0, 0, 0, 20), "Out", "Back", 0.5, true)
    tutorialTitle:TweenTextTransparency(0, "Out", "Quad", 0.5, true)
    wait(0.3)
    tutorialText:TweenTextTransparency(0, "Out", "Quad", 0.5, true)
    wait(0.4)
    closeButton:TweenBackgroundTransparency(0.3, "Out", "Quad", 0.5, true)
    closeButton:TweenTextTransparency(0, "Out", "Quad", 0.5, true)
    
    closeButton.MouseButton1Click:Connect(function()
        tutorialFrame:TweenPosition(UDim2.new(0.5, -200, 1.5, 0), "Out", "Quad", 0.5, true)
        wait(0.5)
        tutorialFrame:Destroy()
    end)
    
    -- Apply button effect
    applyButtonEffect(closeButton)
end

-- Show tutorial after a short delay
wait(1)
showTutorial()

-- Add anti-AFK system
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local antiAFK = false

spawn(function()
    while wait(60) do
        if autoFarm and antiAFK then
            local humanoid = Player.Character and Player.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end
    end
end)
