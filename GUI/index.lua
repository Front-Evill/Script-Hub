-- GUI Script for Roblox by front-evill / 7sone (Enhanced Version)

local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local TopBar = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local WelcomeText = Instance.new("TextLabel")
local LanguageQuestion = Instance.new("TextLabel")
local ArabicButton = Instance.new("TextButton")
local EnglishButton = Instance.new("TextButton")
local OrLabel = Instance.new("TextLabel")
local LeftCredit = Instance.new("TextLabel")
local RightCredit = Instance.new("TextLabel")
local Decoration = Instance.new("Frame")
local Decoration2 = Instance.new("Frame")

-- Properties
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 28) -- Slightly blueish dark
MainFrame.BorderColor3 = Color3.fromRGB(40, 40, 45)
MainFrame.BorderSizePixel = 1
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.Size = UDim2.new(0, 400, 0, 250)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.Visible = false
MainFrame.ClipsDescendants = true

-- Add corner radius and drop shadow
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

-- Add shadow effect
local Shadow = Instance.new("ImageLabel")
Shadow.Name = "Shadow"
Shadow.BackgroundTransparency = 1
Shadow.Image = "rbxassetid://6015897843" -- Shadow image
Shadow.ImageColor3 = Color3.new(0, 0, 0)
Shadow.ImageTransparency = 0.6
Shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
Shadow.AnchorPoint = Vector2.new(0.5, 0.5)
Shadow.Size = UDim2.new(1, 30, 1, 30)
Shadow.ZIndex = 0
Shadow.Parent = MainFrame

-- Top bar with gradient
TopBar.Name = "TopBar"
TopBar.Parent = MainFrame
TopBar.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
TopBar.BorderSizePixel = 0
TopBar.Position = UDim2.new(0, 0, 0, 0)
TopBar.Size = UDim2.new(1, 0, 0, 40)

-- Add gradient to top bar
local TopBarGradient = Instance.new("UIGradient")
TopBarGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(45, 45, 55)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(35, 35, 40))
})
TopBarGradient.Parent = TopBar

-- Add corner radius to top bar
local TopBarCorner = Instance.new("UICorner")
TopBarCorner.CornerRadius = UDim.new(0, 10)
TopBarCorner.Parent = TopBar

-- Title in top bar with glow effect
Title.Name = "Title"
Title.Parent = TopBar
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0.5, 0, 0.5, 0)
Title.Size = UDim2.new(0, 300, 0, 30)
Title.Font = Enum.Font.GothamBold
Title.Text = "FRONT-EVILL SCRIPT"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 18
Title.AnchorPoint = Vector2.new(0.5, 0.5)

-- Add glow to title
local TitleGlow = Instance.new("UIStroke")
TitleGlow.Color = Color3.fromRGB(100, 100, 255)
TitleGlow.Thickness = 1
TitleGlow.Parent = Title

WelcomeText.Name = "WelcomeText"
WelcomeText.Parent = ScreenGui
WelcomeText.BackgroundTransparency = 1
WelcomeText.Position = UDim2.new(0.5, 0, 0.4, 0)
WelcomeText.Size = UDim2.new(0, 500, 0, 50)
WelcomeText.Font = Enum.Font.GothamBold
WelcomeText.Text = ""
WelcomeText.TextColor3 = Color3.fromRGB(255, 255, 255)
WelcomeText.TextSize = 28
WelcomeText.AnchorPoint = Vector2.new(0.5, 0.5)

-- Add glow effect
local TextGlow = Instance.new("UIStroke")
TextGlow.Color = Color3.fromRGB(100, 100, 255)
TextGlow.Thickness = 1.5
TextGlow.Parent = WelcomeText

LanguageQuestion.Name = "LanguageQuestion"
LanguageQuestion.Parent = MainFrame
LanguageQuestion.BackgroundTransparency = 1
LanguageQuestion.Position = UDim2.new(0.5, 0, 0.3, 0)
LanguageQuestion.Size = UDim2.new(0, 300, 0, 40)
LanguageQuestion.Font = Enum.Font.GothamSemibold
LanguageQuestion.Text = "هل تريد سكربت بلغة :"
LanguageQuestion.TextColor3 = Color3.fromRGB(220, 220, 220)
LanguageQuestion.TextSize = 22
LanguageQuestion.AnchorPoint = Vector2.new(0.5, 0.5)

-- Decorative elements with glow
Decoration.Name = "Decoration"
Decoration.Parent = MainFrame
Decoration.BackgroundColor3 = Color3.fromRGB(80, 80, 200)
Decoration.BorderSizePixel = 0
Decoration.Position = UDim2.new(0.5, 0, 0.4, 0)
Decoration.Size = UDim2.new(0.8, 0, 0, 1)
Decoration.AnchorPoint = Vector2.new(0.5, 0.5)

Decoration2.Name = "Decoration2"
Decoration2.Parent = MainFrame
Decoration2.BackgroundColor3 = Color3.fromRGB(80, 80, 200)
Decoration2.BorderSizePixel = 0
Decoration2.Position = UDim2.new(0.5, 0, 0.7, 0)
Decoration2.Size = UDim2.new(0.8, 0, 0, 1)
Decoration2.AnchorPoint = Vector2.new(0.5, 0.5)

-- Add glow to decorations
local DecorationBloom = Instance.new("UIGradient")
DecorationBloom.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(80, 80, 200)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(120, 120, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(80, 80, 200))
})
DecorationBloom.Parent = Decoration
local DecorationBloom2 = DecorationBloom:Clone()
DecorationBloom2.Parent = Decoration2

-- Buttons with improved styling
ArabicButton.Name = "ArabicButton"
ArabicButton.Parent = MainFrame
ArabicButton.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
ArabicButton.BorderColor3 = Color3.fromRGB(60, 60, 100)
ArabicButton.Position = UDim2.new(0.7, 0, 0.55, 0)
ArabicButton.Size = UDim2.new(0, 120, 0, 40)
ArabicButton.Font = Enum.Font.GothamBold
ArabicButton.Text = "عربي"
ArabicButton.TextColor3 = Color3.fromRGB(220, 220, 255)
ArabicButton.TextSize = 18
ArabicButton.AnchorPoint = Vector2.new(0.5, 0.5)

-- Add button style
local ArabicButtonCorner = Instance.new("UICorner")
ArabicButtonCorner.CornerRadius = UDim.new(0, 8)
ArabicButtonCorner.Parent = ArabicButton

-- Add button gradient
local ArabicButtonGradient = Instance.new("UIGradient")
ArabicButtonGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(50, 50, 70)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(40, 40, 60))
})
ArabicButtonGradient.Parent = ArabicButton

EnglishButton.Name = "EnglishButton"
EnglishButton.Parent = MainFrame
EnglishButton.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
EnglishButton.BorderColor3 = Color3.fromRGB(60, 60, 100)
EnglishButton.Position = UDim2.new(0.3, 0, 0.55, 0)
EnglishButton.Size = UDim2.new(0, 120, 0, 40)
EnglishButton.Font = Enum.Font.GothamBold
EnglishButton.Text = "English"
EnglishButton.TextColor3 = Color3.fromRGB(220, 220, 255)
EnglishButton.TextSize = 18
EnglishButton.AnchorPoint = Vector2.new(0.5, 0.5)

-- Add button style
local EnglishButtonCorner = Instance.new("UICorner")
EnglishButtonCorner.CornerRadius = UDim.new(0, 8)
EnglishButtonCorner.Parent = EnglishButton

-- Add button gradient
local EnglishButtonGradient = ArabicButtonGradient:Clone()
EnglishButtonGradient.Parent = EnglishButton

OrLabel.Name = "OrLabel"
OrLabel.Parent = MainFrame
OrLabel.BackgroundTransparency = 1
OrLabel.Position = UDim2.new(0.5, 0, 0.55, 0)
OrLabel.Size = UDim2.new(0, 40, 0, 40)
OrLabel.Font = Enum.Font.GothamBold
OrLabel.Text = "OR"
OrLabel.TextColor3 = Color3.fromRGB(150, 150, 200)
OrLabel.TextSize = 18
OrLabel.AnchorPoint = Vector2.new(0.5, 0.5)

LeftCredit.Name = "LeftCredit"
LeftCredit.Parent = MainFrame
LeftCredit.BackgroundTransparency = 1
LeftCredit.Position = UDim2.new(0.2, 0, 0.9, 0)
LeftCredit.Size = UDim2.new(0, 160, 0, 30)
LeftCredit.Font = Enum.Font.GothamSemibold
LeftCredit.Text = "GUI BY: FRONT-EVIll"
LeftCredit.TextColor3 = Color3.fromRGB(150, 150, 200)
LeftCredit.TextSize = 12
LeftCredit.AnchorPoint = Vector2.new(0.5, 0.5)

RightCredit.Name = "RightCredit"
RightCredit.Parent = MainFrame
RightCredit.BackgroundTransparency = 1
RightCredit.Position = UDim2.new(0.8, 0, 0.9, 0)
RightCredit.Size = UDim2.new(0, 160, 0, 30)
RightCredit.Font = Enum.Font.GothamSemibold
RightCredit.Text = "The Script By: front-evill / 7sone"
RightCredit.TextColor3 = Color3.fromRGB(150, 150, 200)
RightCredit.TextSize = 12
RightCredit.AnchorPoint = Vector2.new(0.5, 0.5)

-- Script Frames for Arabic and English versions
local ArabicScriptFrame = Instance.new("Frame")
ArabicScriptFrame.Name = "ArabicScriptFrame"
ArabicScriptFrame.Parent = ScreenGui
ArabicScriptFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 28)
ArabicScriptFrame.BorderColor3 = Color3.fromRGB(40, 40, 45)
ArabicScriptFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
ArabicScriptFrame.Size = UDim2.new(0, 450, 0, 300)
ArabicScriptFrame.AnchorPoint = Vector2.new(0.5, 0.5)
ArabicScriptFrame.Visible = false
ArabicScriptFrame.ClipsDescendants = true

-- Add corner radius to Arabic frame
local ArabicFrameCorner = UICorner:Clone()
ArabicFrameCorner.Parent = ArabicScriptFrame

-- Add shadow to Arabic frame
local ArabicShadow = Shadow:Clone()
ArabicShadow.Parent = ArabicScriptFrame

-- Arabic script top bar
local ArabicTopBar = Instance.new("Frame")
ArabicTopBar.Name = "TopBar"
ArabicTopBar.Parent = ArabicScriptFrame
ArabicTopBar.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
ArabicTopBar.BorderSizePixel = 0
ArabicTopBar.Position = UDim2.new(0, 0, 0, 0)
ArabicTopBar.Size = UDim2.new(1, 0, 0, 40)

-- Add gradient to Arabic top bar
local ArabicTopBarGradient = TopBarGradient:Clone()
ArabicTopBarGradient.Parent = ArabicTopBar

-- Add corner radius to Arabic top bar
local ArabicTopBarCorner = TopBarCorner:Clone()
ArabicTopBarCorner.Parent = ArabicTopBar

-- Arabic script title
local ArabicTitle = Instance.new("TextLabel")
ArabicTitle.Name = "Title"
ArabicTitle.Parent = ArabicTopBar
ArabicTitle.BackgroundTransparency = 1
ArabicTitle.Position = UDim2.new(0.5, 0, 0.5, 0)
ArabicTitle.Size = UDim2.new(0, 300, 0, 30)
ArabicTitle.Font = Enum.Font.GothamBold
ArabicTitle.Text = "السكربت بالعربية"
ArabicTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
ArabicTitle.TextSize = 18
ArabicTitle.AnchorPoint = Vector2.new(0.5, 0.5)

-- Add glow to Arabic title
local ArabicTitleGlow = TitleGlow:Clone()
ArabicTitleGlow.Parent = ArabicTitle

-- Arabic script content
local ArabicContent = Instance.new("TextLabel")
ArabicContent.Name = "Content"
ArabicContent.Parent = ArabicScriptFrame
ArabicContent.BackgroundTransparency = 1
ArabicContent.Position = UDim2.new(0.5, 0, 0.5, 0)
ArabicContent.Size = UDim2.new(0.9, 0, 0.7, 0)
ArabicContent.Font = Enum.Font.GothamSemibold
ArabicContent.Text = [[  ]]
ArabicContent.TextColor3 = Color3.fromRGB(220, 220, 255)
ArabicContent.TextSize = 16
ArabicContent.AnchorPoint = Vector2.new(0.5, 0.5)
ArabicContent.TextXAlignment = Enum.TextXAlignment.Right
ArabicContent.TextYAlignment = Enum.TextYAlignment.Top

-- Close button for Arabic script
local ArabicCloseButton = Instance.new("TextButton")
ArabicCloseButton.Name = "CloseButton"
ArabicCloseButton.Parent = ArabicTopBar
ArabicCloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
ArabicCloseButton.Position = UDim2.new(0.95, 0, 0.5, 0)
ArabicCloseButton.Size = UDim2.new(0, 24, 0, 24)
ArabicCloseButton.Font = Enum.Font.GothamBold
ArabicCloseButton.Text = "X"
ArabicCloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ArabicCloseButton.TextSize = 14
ArabicCloseButton.AnchorPoint = Vector2.new(0.5, 0.5)

-- Add corner radius to close button
local ArabicCloseButtonCorner = Instance.new("UICorner")
ArabicCloseButtonCorner.CornerRadius = UDim.new(0, 12)
ArabicCloseButtonCorner.Parent = ArabicCloseButton

-- English Script Frame (clone from Arabic and modify)
local EnglishScriptFrame = ArabicScriptFrame:Clone()
EnglishScriptFrame.Name = "EnglishScriptFrame"
EnglishScriptFrame.Parent = ScreenGui

-- Update English frame elements
local EnglishTopBar = EnglishScriptFrame:FindFirstChild("TopBar")
local EnglishTitle = EnglishTopBar:FindFirstChild("Title")
EnglishTitle.Text = "ENGLISH SCRIPT"

local EnglishContent = EnglishScriptFrame:FindFirstChild("Content")
EnglishContent.Text = [[ loadstring(game:HttpGet("https://raw.githubusercontent.com/Front-Evill/Script-Hub/refs/heads/main/F-150.lua"))() ]]
EnglishContent.TextXAlignment = Enum.TextXAlignment.Left

-- Animations and functionalities
local function typeWriterEffect(textLabel, text, delay)
    textLabel.Text = ""
    for i = 1, #text do
        textLabel.Text = string.sub(text, 1, i)
        wait(delay)
    end
    return true
end

local function fadeIn(object)
    object.BackgroundTransparency = 1
    object.TextTransparency = 1
    object.Visible = true
    
    for i = 1, 10 do
        object.BackgroundTransparency = object.BackgroundTransparency - 0.1
        object.TextTransparency = object.TextTransparency - 0.1
        wait(0.02)
    end
end

local function showMainFrame()
    MainFrame.Size = UDim2.new(0, 0, 0, 0)
    MainFrame.Visible = true
    
    -- Animation to expand the frame
    local tweenInfo = TweenInfo.new(
        0.7,
        Enum.EasingStyle.Back,
        Enum.EasingDirection.Out
    )
    
    local tween = game:GetService("TweenService"):Create(
        MainFrame,
        tweenInfo,
        {Size = UDim2.new(0, 400, 0, 250)}
    )
    
    tween:Play()
    
    -- Add subtle bounce animation to UI elements
    wait(0.3)
    
    local elements = {LanguageQuestion, ArabicButton, EnglishButton, OrLabel, Decoration, Decoration2}
    
    for i, element in ipairs(elements) do
        local originalPos = element.Position
        
        -- Set start position slightly off
        element.Position = originalPos + UDim2.new(0, 0, 0.02, 0)
        element.Visible = true
        
        -- Bounce into place
        game:GetService("TweenService"):Create(
            element,
            TweenInfo.new(0.3, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out),
            {Position = originalPos}
        ):Play()
        
        wait(0.05)
    end
    
    -- Fade in the credits
    wait(0.2)
    LeftCredit.TextTransparency = 1
    RightCredit.TextTransparency = 1
    LeftCredit.Visible = true
    RightCredit.Visible = true
    
    game:GetService("TweenService"):Create(
        LeftCredit,
        TweenInfo.new(0.5),
        {TextTransparency = 0}
    ):Play()
    
    game:GetService("TweenService"):Create(
        RightCredit,
        TweenInfo.new(0.5),
        {TextTransparency = 0}
    ):Play()
end

-- Function to show script frame
local function showScriptFrame(frame)
    frame.Size = UDim2.new(0, 0, 0, 0)
    frame.Visible = true
    
    -- Animation to expand the frame
    local tweenInfo = TweenInfo.new(
        0.7,
        Enum.EasingStyle.Back,
        Enum.EasingDirection.Out
    )
    
    local tween = game:GetService("TweenService"):Create(
        frame,
        tweenInfo,
        {Size = UDim2.new(0, 450, 0, 300)}
    )
    
    tween:Play()
    
    -- Animate content
    wait(0.5)
    
    local content = frame:FindFirstChild("Content")
    if content then
        content.TextTransparency = 1
        
        game:GetService("TweenService"):Create(
            content,
            TweenInfo.new(0.5),
            {TextTransparency = 0}
        ):Play()
    end
end

local function hideScriptFrame(frame)
    local content = frame:FindFirstChild("Content")
    if content then
        game:GetService("TweenService"):Create(
            content,
            TweenInfo.new(0.3),
            {TextTransparency = 1}
        ):Play()
    end
    
    wait(0.3)
    
    game:GetService("TweenService"):Create(
        frame,
        TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In),
        {Size = UDim2.new(0, 0, 0, 0)}
    ):Play()
    
    wait(0.5)
    frame.Visible = false
end

ArabicButton.MouseEnter:Connect(function()
    game:GetService("TweenService"):Create(
        ArabicButton,
        TweenInfo.new(0.3),
        {
            BackgroundColor3 = Color3.fromRGB(60, 60, 100),
            TextColor3 = Color3.fromRGB(255, 255, 255)
        }
    ):Play()
end)

ArabicButton.MouseLeave:Connect(function()
    game:GetService("TweenService"):Create(
        ArabicButton,
        TweenInfo.new(0.3),
        {
            BackgroundColor3 = Color3.fromRGB(40, 40, 60),
            TextColor3 = Color3.fromRGB(220, 220, 255)
        }
    ):Play()
end)

EnglishButton.MouseEnter:Connect(function()
    game:GetService("TweenService"):Create(
        EnglishButton,
        TweenInfo.new(0.3),
        {
            BackgroundColor3 = Color3.fromRGB(60, 60, 100),
            TextColor3 = Color3.fromRGB(255, 255, 255)
        }
    ):Play()
end)

EnglishButton.MouseLeave:Connect(function()
    game:GetService("TweenService"):Create(
        EnglishButton,
        TweenInfo.new(0.3),
        {
            BackgroundColor3 = Color3.fromRGB(40, 40, 60),
            TextColor3 = Color3.fromRGB(220, 220, 255)
        }
    ):Play()
end)

ArabicCloseButton.MouseButton1Click:Connect(function()
    hideScriptFrame(ArabicScriptFrame)
end)

EnglishScriptFrame:FindFirstChild("TopBar"):FindFirstChild("CloseButton").MouseButton1Click:Connect(function()
    hideScriptFrame(EnglishScriptFrame)
end)

ArabicButton.MouseButton1Click:Connect(function()
    game:GetService("TweenService"):Create(
        ArabicButton,
        TweenInfo.new(0.1),
        {Size = UDim2.new(0, 115, 0, 38)}
    ):Play()
    
    wait(0.1)
    
    game:GetService("TweenService"):Create(
        ArabicButton,
        TweenInfo.new(0.1),
        {Size = UDim2.new(0, 120, 0, 40)}
    ):Play()
    
    wait(0.2)
    
    local elements = {LanguageQuestion, ArabicButton, EnglishButton, OrLabel, LeftCredit, RightCredit, Decoration, Decoration2}
    
    for _, element in ipairs(elements) do
        game:GetService("TweenService"):Create(
            element,
            TweenInfo.new(0.3),
            {TextTransparency = 1, BackgroundTransparency = 1}
        ):Play()
    end
    
    wait(0.3)
    
    game:GetService("TweenService"):Create(
        MainFrame,
        TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In),
        {Size = UDim2.new(0, 0, 0, 0)}
    ):Play()
    
    wait(0.5)
    MainFrame.Visible = false
    showScriptFrame(ArabicScriptFrame)
    
end)

EnglishButton.MouseButton1Click:Connect(function()
    game:GetService("TweenService"):Create(
        EnglishButton,
        TweenInfo.new(0.1),
        {Size = UDim2.new(0, 115, 0, 38)}
    ):Play()
    
    wait(0.1)
    
    game:GetService("TweenService"):Create(
        EnglishButton,
        TweenInfo.new(0.1),
        {Size = UDim2.new(0, 120, 0, 40)}
    ):Play()
    
    wait(0.2)
    
    local elements = {LanguageQuestion, ArabicButton, EnglishButton, OrLabel, LeftCredit, RightCredit, Decoration, Decoration2}
    
    for _, element in ipairs(elements) do
        game:GetService("TweenService"):Create(
            element,
            TweenInfo.new(0.3),
            {TextTransparency = 1, BackgroundTransparency = 1}
        ):Play()
    end
    
    wait(0.3)
    
    game:GetService("TweenService"):Create(
        MainFrame,
        TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In),
        {Size = UDim2.new(0, 0, 0, 0)}
    ):Play()
    
    wait(0.5)
    MainFrame.Visible = false
    
    showScriptFrame(EnglishScriptFrame)
end)

-- Animated decorations
spawn(function()
    while wait(1) do
        -- Animate decoration gradients
        game:GetService("TweenService"):Create(
            DecorationBloom,
            TweenInfo.new(2, Enum.EasingStyle.Linear),
            {Offset = Vector2.new(1, 0)}
        ):Play()
        
        game:GetService("TweenService"):Create(
            DecorationBloom2,
            TweenInfo.new(2, Enum.EasingStyle.Linear),
            {Offset = Vector2.new(-1, 0)}
        ):Play()
        
        wait(2)
        
        DecorationBloom.Offset = Vector2.new(-1, 0)
        DecorationBloom2.Offset = Vector2.new(1, 0)
    end
end)

-- Start the sequence
wait(1)
typeWriterEffect(WelcomeText, "Welcome to script front-evill", 0.05)
wait(1)

-- Fade out welcome text
game:GetService("TweenService"):Create(
    WelcomeText,
    TweenInfo.new(0.5),
    {TextTransparency = 1}
):Play()

wait(0.5)
WelcomeText.Visible = false
showMainFrame()
