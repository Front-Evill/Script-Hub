-- Farm GUI for Roblox (Black & Transparent with Enhancements)
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

-- Parent the GUI to the player
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

-- Main Frame
MainFrame.Name = "FarmGUI"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
MainFrame.BackgroundTransparency = 0.4
MainFrame.BorderColor3 = Color3.fromRGB(85, 170, 255)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -125)
MainFrame.Size = UDim2.new(0, 300, 0, 250)
MainFrame.Active = true
MainFrame.Draggable = true

-- Title
Title.Name = "Title"
Title.Parent = MainFrame
Title.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Title.BackgroundTransparency = 0.6
Title.BorderColor3 = Color3.fromRGB(85, 170, 255)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Font = Enum.Font.GothamBold
Title.Text = "Farm System"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 18.0

-- Farming Status
FarmingStatus.Name = "Status"
FarmingStatus.Parent = MainFrame
FarmingStatus.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
FarmingStatus.BackgroundTransparency = 0.8
FarmingStatus.BorderSizePixel = 0
FarmingStatus.Position = UDim2.new(0, 10, 0, 40)
FarmingStatus.Size = UDim2.new(1, -20, 0, 25)
FarmingStatus.Font = Enum.Font.Gotham
FarmingStatus.Text = "Status: Inactive"
FarmingStatus.TextColor3 = Color3.fromRGB(255, 75, 75)
FarmingStatus.TextSize = 14.0
FarmingStatus.TextXAlignment = Enum.TextXAlignment.Left

-- Start Button
StartButton.Name = "StartButton"
StartButton.Parent = MainFrame
StartButton.BackgroundColor3 = Color3.fromRGB(25, 150, 50)
StartButton.BackgroundTransparency = 0.3
StartButton.BorderColor3 = Color3.fromRGB(0, 255, 100)
StartButton.Position = UDim2.new(0.1, 0, 0.35, 0)
StartButton.Size = UDim2.new(0.35, 0, 0, 40)
StartButton.Font = Enum.Font.GothamSemibold
StartButton.Text = "START"
StartButton.TextColor3 = Color3.fromRGB(255, 255, 255)
StartButton.TextSize = 16.0

-- Stop Button
StopButton.Name = "StopButton"
StopButton.Parent = MainFrame
StopButton.BackgroundColor3 = Color3.fromRGB(150, 25, 25)
StopButton.BackgroundTransparency = 0.3
StopButton.BorderColor3 = Color3.fromRGB(255, 75, 75)
StopButton.Position = UDim2.new(0.55, 0, 0.35, 0)
StopButton.Size = UDim2.new(0.35, 0, 0, 40)
StopButton.Font = Enum.Font.GothamSemibold
StopButton.Text = "STOP"
StopButton.TextColor3 = Color3.fromRGB(255, 255, 255)
StopButton.TextSize = 16.0

-- Stats Frame
StatsFrame.Name = "StatsFrame"
StatsFrame.Parent = MainFrame
StatsFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
StatsFrame.BackgroundTransparency = 0.7
StatsFrame.BorderColor3 = Color3.fromRGB(85, 170, 255)
StatsFrame.Position = UDim2.new(0.1, 0, 0.55, 0)
StatsFrame.Size = UDim2.new(0.8, 0, 0.3, 0)

-- Resource Counter
ResourceCount.Name = "Resources"
ResourceCount.Parent = StatsFrame
ResourceCount.BackgroundTransparency = 1
ResourceCount.Position = UDim2.new(0, 10, 0, 5)
ResourceCount.Size = UDim2.new(1, -20, 0, 20)
ResourceCount.Font = Enum.Font.Gotham
ResourceCount.Text = "Resources: 0"
ResourceCount.TextColor3 = Color3.fromRGB(255, 255, 255)
ResourceCount.TextSize = 14.0
ResourceCount.TextXAlignment = Enum.TextXAlignment.Left

-- Time Counter
TimeElapsed.Name = "Timer"
TimeElapsed.Parent = StatsFrame
TimeElapsed.BackgroundTransparency = 1
TimeElapsed.Position = UDim2.new(0, 10, 0, 30)
TimeElapsed.Size = UDim2.new(1, -20, 0, 20)
TimeElapsed.Font = Enum.Font.Gotham
TimeElapsed.Text = "Time: 00:00:00"
TimeElapsed.TextColor3 = Color3.fromRGB(255, 255, 255)
TimeElapsed.TextSize = 14.0
TimeElapsed.TextXAlignment = Enum.TextXAlignment.Left

-- Settings Button
SettingsButton.Name = "SettingsButton"
SettingsButton.Parent = MainFrame
SettingsButton.BackgroundColor3 = Color3.fromRGB(50, 50, 75)
SettingsButton.BackgroundTransparency = 0.3
SettingsButton.BorderColor3 = Color3.fromRGB(85, 85, 255)
SettingsButton.Position = UDim2.new(0.3, 0, 0.88, 0)
SettingsButton.Size = UDim2.new(0.4, 0, 0, 25)
SettingsButton.Font = Enum.Font.GothamSemibold
SettingsButton.Text = "SETTINGS"
SettingsButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SettingsButton.TextSize = 14.0

-- Close Button
CloseButton.Name = "CloseButton"
CloseButton.Parent = MainFrame
CloseButton.BackgroundColor3 = Color3.fromRGB(150, 25, 25)
CloseButton.BackgroundTransparency = 0.3
CloseButton.BorderSizePixel = 0
CloseButton.Position = UDim2.new(1, -25, 0, 0)
CloseButton.Size = UDim2.new(0, 25, 0, 25)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 14.0

-- Function to handle the start button
local farming = false
local startTime = 0
local resources = 0

StartButton.MouseButton1Click:Connect(function()
    if not farming then
        farming = true
        FarmingStatus.Text = "Status: Active"
        FarmingStatus.TextColor3 = Color3.fromRGB(75, 255, 75)
        startTime = tick()
        
        -- Start farming loop
        spawn(function()
            while farming do
                resources = resources + 1
                ResourceCount.Text = "Resources: " .. resources
                wait(1) -- Collect resource every second
                
                local elapsed = tick() - startTime
                local hours = math.floor(elapsed / 3600)
                local minutes = math.floor((elapsed % 3600) / 60)
                local seconds = math.floor(elapsed % 60)
                
                TimeElapsed.Text = string.format("Time: %02d:%02d:%02d", hours, minutes, seconds)
            end
        end)
    end
end)

-- Function to handle the stop button
StopButton.MouseButton1Click:Connect(function()
    farming = false
    FarmingStatus.Text = "Status: Inactive"
    FarmingStatus.TextColor3 = Color3.fromRGB(255, 75, 75)
end)

-- Function to handle the close button
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Apply glow effect to buttons
local function applyButtonEffect(button)
    local originalColor = button.BackgroundColor3
    local originalTransparency = button.BackgroundTransparency
    
    button.MouseEnter:Connect(function()
        button.BackgroundTransparency = originalTransparency - 0.2
    end)
    
    button.MouseLeave:Connect(function()
        button.BackgroundTransparency = originalTransparency
    end)
end

applyButtonEffect(StartButton)
applyButtonEffect(StopButton)
applyButtonEffect(SettingsButton)
