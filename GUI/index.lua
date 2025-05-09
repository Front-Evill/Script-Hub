-- FRONT-evill - Enhanced Minimalist UI Design
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local BorderFrame = Instance.new("Frame")
local LogoContainer = Instance.new("Frame")
local LogoText = Instance.new("TextLabel")

-- Parent the GUI to the player
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false
ScreenGui.Name = "FRONT-evill"

-- Create a border frame for a sleek edge effect
BorderFrame.Name = "BorderEffect"
BorderFrame.Parent = ScreenGui
BorderFrame.BackgroundColor3 = Color3.fromRGB(120, 0, 255)
BorderFrame.BorderSizePixel = 0
BorderFrame.Position = UDim2.new(0.5, -180, 0.5, -155)
BorderFrame.Size = UDim2.new(0, 360, 0, 310)

-- Add blur effect to border
local BorderGlow = Instance.new("UIGradient")
BorderGlow.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 100)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(120, 0, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 100, 255))
})
BorderGlow.Rotation = 45
BorderGlow.Parent = BorderFrame

-- Add corner radius to border
local BorderCorner = Instance.new("UICorner")
BorderCorner.CornerRadius = UDim.new(0, 12)
BorderCorner.Parent = BorderFrame

-- Main Frame with enhanced gradient and corner radius
MainFrame.Name = "FRONT-evill"
MainFrame.Parent = BorderFrame
MainFrame.BackgroundColor3 = Color3.fromRGB(5, 5, 10)
MainFrame.BackgroundTransparency = 0.1
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0, 5, 0, 5)
MainFrame.Size = UDim2.new(1, -10, 1, -10)
MainFrame.ClipsDescendants = true

-- Add corner radius to main frame
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

-- Add enhanced gradient
local UIGradient = Instance.new("UIGradient")
UIGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(10, 10, 20)),
    ColorSequenceKeypoint.new(0.7, Color3.fromRGB(15, 15, 25)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 20, 35))
})
UIGradient.Rotation = 145
UIGradient.Parent = MainFrame

-- Title with enhanced glow effect
Title.Name = "Title"
Title.Parent = MainFrame
Title.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Title.BackgroundTransparency = 0.9
Title.BorderSizePixel = 0
Title.Position = UDim2.new(0, 0, 0, 20)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Font = Enum.Font.GothamBold
Title.Text = "FRONT-evill"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 22.0

-- Add text gradient to title
local TextGradient = Instance.new("UIGradient")
TextGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 100, 100)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(100, 100, 255))
})
TextGradient.Parent = Title

-- Create logo container with glow
LogoContainer.Name = "LogoContainer"
LogoContainer.Parent = MainFrame
LogoContainer.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
LogoContainer.BackgroundTransparency = 0.5
LogoContainer.BorderSizePixel = 0
LogoContainer.Position = UDim2.new(0.5, -50, 0.5, -50)
LogoContainer.Size = UDim2.new(0, 100, 0, 100)

-- Add corner radius to logo container
local LogoCorner = Instance.new("UICorner")
LogoCorner.CornerRadius = UDim.new(1, 0) -- Makes it circular
LogoCorner.Parent = LogoContainer

-- Add stroke to logo container
local LogoStroke = Instance.new("UIStroke")
LogoStroke.Color = Color3.fromRGB(120, 0, 255)
LogoStroke.Thickness = 2
LogoStroke.Parent = LogoContainer

-- Add logo text
LogoText.Name = "Logo"
LogoText.Parent = LogoContainer
LogoText.BackgroundTransparency = 1
LogoText.Size = UDim2.new(1, 0, 1, 0)
LogoText.Font = Enum.Font.GothamBlack
LogoText.Text = "FE"
LogoText.TextColor3 = Color3.fromRGB(255, 255, 255)
LogoText.TextSize = 40.0
LogoText.TextStrokeTransparency = 0.7
LogoText.TextStrokeColor3 = Color3.fromRGB(180, 0, 255)

-- Add decorative line
local DecorativeLine = Instance.new("Frame")
DecorativeLine.Name = "DecorativeLine"
DecorativeLine.Parent = MainFrame
DecorativeLine.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
DecorativeLine.BackgroundTransparency = 0.7
DecorativeLine.BorderSizePixel = 0
DecorativeLine.Position = UDim2.new(0.1, 0, 0.8, 0)
DecorativeLine.Size = UDim2.new(0.8, 0, 0, 1)

-- Add animation for visual appeal
local function animateUI()
    while true do
        -- Animate gradient rotation
        for i = 0, 360, 1 do
            BorderGlow.Rotation = i
            wait(0.05)
        end
    end
end

-- Start animation
spawn(animateUI)

-- Opening animation
MainFrame.BackgroundTransparency = 1
Title.TextTransparency = 1
LogoContainer.BackgroundTransparency = 1
LogoText.TextTransparency = 1
DecorativeLine.BackgroundTransparency = 1

wait(0.5)
MainFrame:TweenBackgroundTransparency(0.1, "Out", "Quad", 0.8, true)
wait(0.2)
Title:TweenTextTransparency(0, "Out", "Quad", 0.8, true)
wait(0.3)
LogoContainer:TweenBackgroundTransparency(0.5, "Out", "Quad", 0.8, true)
LogoText:TweenTextTransparency(0, "Out", "Quad", 0.8, true)
wait(0.3)
DecorativeLine:TweenBackgroundTransparency(0.7, "Out", "Quad", 0.8, true)
