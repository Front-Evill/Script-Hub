-- GUI Script for Roblox by front-evill / 7sone (Enhanced Version 2.0)

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
local NotificationFrame = Instance.new("Frame")
local NotificationText = Instance.new("TextLabel")
local NotificationIcon = Instance.new("ImageLabel")

-- Properties
ScreenGui.Parent = game.CoreGui -- Changed to CoreGui for better compatibility
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.ResetOnSpawn = false -- Prevent GUI from disappearing when character respawns

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

-- Add shadow effect with improved visuals
local Shadow = Instance.new("ImageLabel")
Shadow.Name = "Shadow"
Shadow.BackgroundTransparency = 1
Shadow.Image = "rbxassetid://6015897843" -- Shadow image
Shadow.ImageColor3 = Color3.new(0, 0, 0)
Shadow.ImageTransparency = 0.5
Shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
Shadow.AnchorPoint = Vector2.new(0.5, 0.5)
Shadow.Size = UDim2.new(1, 40, 1, 40) -- Larger shadow for better effect
Shadow.ZIndex = 0
Shadow.Parent = MainFrame

-- Top bar with improved gradient
TopBar.Name = "TopBar"
TopBar.Parent = MainFrame
TopBar.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
TopBar.BorderSizePixel = 0
TopBar.Position = UDim2.new(0, 0, 0, 0)
TopBar.Size = UDim2.new(1, 0, 0, 40)

-- Add gradient to top bar with more vibrant colors
local TopBarGradient = Instance.new("UIGradient")
TopBarGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(60, 60, 100)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(35, 35, 60))
})
TopBarGradient.Rotation = 10 -- Slight rotation for better appearance
TopBarGradient.Parent = TopBar

-- Add corner radius to top bar
local TopBarCorner = Instance.new("UICorner")
TopBarCorner.CornerRadius = UDim.new(0, 10)
TopBarCorner.Parent = TopBar

-- Logo image (optional)
local Logo = Instance.new("ImageLabel")
Logo.Name = "Logo"
Logo.Parent = TopBar
Logo.BackgroundTransparency = 1
Logo.Position = UDim2.new(0.05, 0, 0.5, 0)
Logo.Size = UDim2.new(0, 30, 0, 30)
Logo.Image = "rbxassetid://7072706001" -- Generic code icon, replace with your own if desired
Logo.ImageColor3 = Color3.fromRGB(200, 200, 255)
Logo.AnchorPoint = Vector2.new(0.5, 0.5)

-- Title in top bar with enhanced glow effect
Title.Name = "Title"
Title.Parent = TopBar
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0.5, 0, 0.5, 0)
Title.Size = UDim2.new(0, 300, 0, 30)
Title.Font = Enum.Font.GothamBold
Title.Text = "FRONT-EVILL SCRIPT HUB"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 18
Title.AnchorPoint = Vector2.new(0.5, 0.5)

-- Add enhanced glow to title
local TitleGlow = Instance.new("UIStroke")
TitleGlow.Color = Color3.fromRGB(100, 100, 255)
TitleGlow.Thickness = 1.5
TitleGlow.Parent = Title

-- Add text shadow for better visibility
local TitleShadow = Instance.new("TextLabel")
TitleShadow.Name = "TitleShadow"
TitleShadow.Parent = Title
TitleShadow.BackgroundTransparency = 1
TitleShadow.Position = UDim2.new(0, 1, 0, 1)
TitleShadow.Size = UDim2.new(1, 0, 1, 0)
TitleShadow.Font = Title.Font
TitleShadow.Text = Title.Text
TitleShadow.TextColor3 = Color3.fromRGB(40, 40, 80)
TitleShadow.TextSize = Title.TextSize
TitleShadow.ZIndex = Title.ZIndex - 1
TitleShadow.TextXAlignment = Title.TextXAlignment
TitleShadow.TextYAlignment = Title.TextYAlignment

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

-- Add enhanced glow effect
local TextGlow = Instance.new("UIStroke")
TextGlow.Color = Color3.fromRGB(100, 100, 255)
TextGlow.Thickness = 2
TextGlow.Parent = WelcomeText

-- Add text shadow for better visibility
local WelcomeTextShadow = Instance.new("TextLabel")
WelcomeTextShadow.Name = "WelcomeTextShadow"
WelcomeTextShadow.Parent = WelcomeText
WelcomeTextShadow.BackgroundTransparency = 1
WelcomeTextShadow.Position = UDim2.new(0, 2, 0, 2)
WelcomeTextShadow.Size = UDim2.new(1, 0, 1, 0)
WelcomeTextShadow.Font = WelcomeText.Font
WelcomeTextShadow.Text = WelcomeText.Text
WelcomeTextShadow.TextColor3 = Color3.fromRGB(40, 40, 80)
WelcomeTextShadow.TextSize = WelcomeText.TextSize
WelcomeTextShadow.ZIndex = WelcomeText.ZIndex - 1
WelcomeTextShadow.TextXAlignment = WelcomeText.TextXAlignment
WelcomeTextShadow.TextYAlignment = WelcomeText.TextYAlignment

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

-- Add shimmer effect background
local ShimmerBg = Instance.new("Frame")
ShimmerBg.Name = "ShimmerBg"
ShimmerBg.Parent = MainFrame
ShimmerBg.BackgroundColor3 = Color3.fromRGB(70, 70, 120)
ShimmerBg.BackgroundTransparency = 0.9
ShimmerBg.BorderSizePixel = 0
ShimmerBg.Position = UDim2.new(0.5, 0, 0.65, 0)
ShimmerBg.Size = UDim2.new(0.9, 0, 0.3, 0)
ShimmerBg.AnchorPoint = Vector2.new(0.5, 0.5)

local ShimmerCorner = Instance.new("UICorner")
ShimmerCorner.CornerRadius = UDim.new(0, 8)
ShimmerCorner.Parent = ShimmerBg

local ShimmerGradient = Instance.new("UIGradient")
ShimmerGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 40, 60)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(80, 80, 150)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(40, 40, 60))
})
ShimmerGradient.Parent = ShimmerBg

-- Decorative elements with better glow
Decoration.Name = "Decoration"
Decoration.Parent = MainFrame
Decoration.BackgroundColor3 = Color3.fromRGB(100, 100, 230)
Decoration.BorderSizePixel = 0
Decoration.Position = UDim2.new(0.5, 0, 0.4, 0)
Decoration.Size = UDim2.new(0.8, 0, 0, 2) -- Thicker line
Decoration.AnchorPoint = Vector2.new(0.5, 0.5)

Decoration2.Name = "Decoration2"
Decoration2.Parent = MainFrame
Decoration2.BackgroundColor3 = Color3.fromRGB(100, 100, 230)
Decoration2.BorderSizePixel = 0
Decoration2.Position = UDim2.new(0.5, 0, 0.7, 0)
Decoration2.Size = UDim2.new(0.8, 0, 0, 2) -- Thicker line
Decoration2.AnchorPoint = Vector2.new(0.5, 0.5)

-- Add enhanced glow to decorations
local DecorationBloom = Instance.new("UIGradient")
DecorationBloom.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(80, 80, 200)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(140, 140, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(80, 80, 200))
})
DecorationBloom.Parent = Decoration
local DecorationBloom2 = DecorationBloom:Clone()
DecorationBloom2.Parent = Decoration2

-- Buttons with improved styling and hover effects
ArabicButton.Name = "ArabicButton"
ArabicButton.Parent = MainFrame
ArabicButton.BackgroundColor3 = Color3.fromRGB(40, 40, 70)
ArabicButton.BorderColor3 = Color3.fromRGB(60, 60, 100)
ArabicButton.Position = UDim2.new(0.7, 0, 0.55, 0)
ArabicButton.Size = UDim2.new(0, 130, 0, 45)
ArabicButton.Font = Enum.Font.GothamBold
ArabicButton.Text = "عربي"
ArabicButton.TextColor3 = Color3.fromRGB(220, 220, 255)
ArabicButton.TextSize = 20
ArabicButton.AnchorPoint = Vector2.new(0.5, 0.5)
ArabicButton.AutoButtonColor = false -- We'll handle our own hover effects

-- Add button style
local ArabicButtonCorner = Instance.new("UICorner")
ArabicButtonCorner.CornerRadius = UDim.new(0, 8)
ArabicButtonCorner.Parent = ArabicButton

-- Add button gradient
local ArabicButtonGradient = Instance.new("UIGradient")
ArabicButtonGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(60, 60, 100)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(40, 40, 70))
})
ArabicButtonGradient.Rotation = 45 -- Diagonal gradient
ArabicButtonGradient.Parent = ArabicButton

-- Add button glow
local ArabicButtonStroke = Instance.new("UIStroke")
ArabicButtonStroke.Color = Color3.fromRGB(100, 100, 200)
ArabicButtonStroke.Thickness = 1.5
ArabicButtonStroke.Parent = ArabicButton

-- Add Arabic icon
local ArabicIcon = Instance.new("ImageLabel")
ArabicIcon.Name = "Icon"
ArabicIcon.Parent = ArabicButton
ArabicIcon.BackgroundTransparency = 1
ArabicIcon.Position = UDim2.new(0.15, 0, 0.5, 0)
ArabicIcon.Size = UDim2.new(0, 25, 0, 25)
ArabicIcon.Image = "rbxassetid://7072716982" -- Generic globe icon, replace with better one if desired
ArabicIcon.ImageColor3 = Color3.fromRGB(200, 200, 255)
ArabicIcon.AnchorPoint = Vector2.new(0.5, 0.5)

EnglishButton.Name = "EnglishButton"
EnglishButton.Parent = MainFrame
EnglishButton.BackgroundColor3 = Color3.fromRGB(40, 40, 70)
EnglishButton.BorderColor3 = Color3.fromRGB(60, 60, 100)
EnglishButton.Position = UDim2.new(0.3, 0, 0.55, 0)
EnglishButton.Size = UDim2.new(0, 130, 0, 45)
EnglishButton.Font = Enum.Font.GothamBold
EnglishButton.Text = "English"
EnglishButton.TextColor3 = Color3.fromRGB(220, 220, 255)
EnglishButton.TextSize = 20
EnglishButton.AnchorPoint = Vector2.new(0.5, 0.5)
EnglishButton.AutoButtonColor = false -- We'll handle our own hover effects

-- Add button style
local EnglishButtonCorner = Instance.new("UICorner")
EnglishButtonCorner.CornerRadius = UDim.new(0, 8)
EnglishButtonCorner.Parent = EnglishButton

-- Add button gradient
local EnglishButtonGradient = ArabicButtonGradient:Clone()
EnglishButtonGradient.Parent = EnglishButton

-- Add button glow
local EnglishButtonStroke = Instance.new("UIStroke")
EnglishButtonStroke.Color = Color3.fromRGB(100, 100, 200)
EnglishButtonStroke.Thickness = 1.5
EnglishButtonStroke.Parent = EnglishButton

-- Add English icon
local EnglishIcon = Instance.new("ImageLabel")
EnglishIcon.Name = "Icon"
EnglishIcon.Parent = EnglishButton
EnglishIcon.BackgroundTransparency = 1
EnglishIcon.Position = UDim2.new(0.15, 0, 0.5, 0)
EnglishIcon.Size = UDim2.new(0, 25, 0, 25)
EnglishIcon.Image = "rbxassetid://7072706206" -- Generic document icon, replace if desired
EnglishIcon.ImageColor3 = Color3.fromRGB(200, 200, 255)
EnglishIcon.AnchorPoint = Vector2.new(0.5, 0.5)

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

-- Add glow to OR label
local OrLabelStroke = Instance.new("UIStroke")
OrLabelStroke.Color = Color3.fromRGB(80, 80, 150)
OrLabelStroke.Thickness = 1
OrLabelStroke.Transparency = 0.5
OrLabelStroke.Parent = OrLabel

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

-- Notification system
NotificationFrame.Name = "NotificationFrame"
NotificationFrame.Parent = ScreenGui
NotificationFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
NotificationFrame.BorderSizePixel = 0
NotificationFrame.Position = UDim2.new(0.5, 0, 0.15, 0)
NotificationFrame.Size = UDim2.new(0, 300, 0, 60)
NotificationFrame.AnchorPoint = Vector2.new(0.5, 0.5)
NotificationFrame.Visible = false
NotificationFrame.ZIndex = 10

-- Add notification corner
local NotificationCorner = Instance.new("UICorner")
NotificationCorner.CornerRadius = UDim.new(0, 8)
NotificationCorner.Parent = NotificationFrame

-- Add notification gradient
local NotificationGradient = Instance.new("UIGradient")
NotificationGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(50, 50, 80)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 30, 45))
})
NotificationGradient.Rotation = 45
NotificationGradient.Parent = NotificationFrame

-- Add notification shadow
local NotificationShadow = Shadow:Clone()
NotificationShadow.Parent = NotificationFrame
NotificationShadow.ZIndex = 9

-- Add notification icon
NotificationIcon.Name = "Icon"
NotificationIcon.Parent = NotificationFrame
NotificationIcon.BackgroundTransparency = 1
NotificationIcon.Position = UDim2.new(0.1, 0, 0.5, 0)
NotificationIcon.Size = UDim2.new(0, 30, 0, 30)
NotificationIcon.Image = "rbxassetid://7072706318" -- Check mark icon
NotificationIcon.ImageColor3 = Color3.fromRGB(100, 255, 100)
NotificationIcon.AnchorPoint = Vector2.new(0.5, 0.5)
NotificationIcon.ZIndex = 11

-- Add notification text
NotificationText.Name = "Text"
NotificationText.Parent = NotificationFrame
NotificationText.BackgroundTransparency = 1
NotificationText.Position = UDim2.new(0.55, 0, 0.5, 0)
NotificationText.Size = UDim2.new(0.8, 0, 0.8, 0)
NotificationText.Font = Enum.Font.GothamSemibold
NotificationText.Text = "Script activated successfully!"
NotificationText.TextColor3 = Color3.fromRGB(220, 220, 255)
NotificationText.TextSize = 14
NotificationText.AnchorPoint = Vector2.new(0.5, 0.5)
NotificationText.TextXAlignment = Enum.TextXAlignment.Left
NotificationText.ZIndex = 11

-- Add notification stroke
local NotificationStroke = Instance.new("UIStroke")
NotificationStroke.Color = Color3.fromRGB(80, 80, 150)
NotificationStroke.Thickness = 1.5
NotificationStroke.Parent = NotificationFrame

-- Script Frames for Arabic and English versions (with improvements)
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

-- Arabic script content with improved styling
local ArabicContent = Instance.new("TextLabel")
ArabicContent.Name = "Content"
ArabicContent.Parent = ArabicScriptFrame
ArabicContent.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
ArabicContent.BackgroundTransparency = 0.7
ArabicContent.BorderSizePixel = 0
ArabicContent.Position = UDim2.new(0.5, 0, 0.55, 0)
ArabicContent.Size = UDim2.new(0.9, 0, 0.7, 0)
ArabicContent.Font = Enum.Font.Code
ArabicContent.Text = [[loadstring(game:HttpGet("https://raw.githubusercontent.com/Front-Evill/Script-Hub/refs/heads/main/Arabic.lua"))()]]
ArabicContent.TextColor3 = Color3.fromRGB(100, 255, 100)
ArabicContent.TextSize = 16
ArabicContent.AnchorPoint = Vector2.new(0.5, 0.5)
ArabicContent.TextXAlignment = Enum.TextXAlignment.Left
ArabicContent.TextYAlignment = Enum.TextYAlignment.Top
ArabicContent.RichText = true

-- Add content corner and padding
local ArabicContentCorner = Instance.new("UICorner")
ArabicContentCorner.CornerRadius = UDim.new(0, 6)
ArabicContentCorner.Parent = ArabicContent

local ArabicContentPadding = Instance.new("UIPadding")
ArabicContentPadding.PaddingLeft = UDim.new(0, 10)
ArabicContentPadding.PaddingRight = UDim.new(0, 10)
ArabicContentPadding.PaddingTop = UDim.new(0, 10)
ArabicContentPadding.PaddingBottom = UDim.new(0, 10)
ArabicContentPadding.Parent = ArabicContent

-- Close button for Arabic script with improved styling
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
ArabicCloseButton.AutoButtonColor = false

-- Add corner radius to close button
local ArabicCloseButtonCorner = Instance.new("UICorner")
ArabicCloseButtonCorner.CornerRadius = UDim.new(0, 12)
ArabicCloseButtonCorner.Parent = ArabicCloseButton

-- English Script Frame (with direct improvements rather than cloning)
local EnglishScriptFrame = Instance.new("Frame")
EnglishScriptFrame.Name = "EnglishScriptFrame"
EnglishScriptFrame.Parent = ScreenGui
EnglishScriptFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 28)
EnglishScriptFrame.BorderColor3 = Color3.fromRGB(40, 40, 45)
EnglishScriptFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
EnglishScriptFrame.Size = UDim2.new(0, 450, 0, 300)
EnglishScriptFrame.AnchorPoint = Vector2.new(0.5, 0.5)
EnglishScriptFrame.Visible = false
EnglishScriptFrame.ClipsDescendants = true

-- Add corner radius to English frame
local EnglishFrameCorner = UICorner:Clone()
EnglishFrameCorner.Parent = EnglishScriptFrame

-- Add shadow to English frame
local EnglishShadow = Shadow:Clone()
EnglishShadow.Parent = EnglishScriptFrame

-- English script top bar
local EnglishTopBar = Instance.new("Frame")
EnglishTopBar.Name = "TopBar"
EnglishTopBar.Parent = EnglishScriptFrame
EnglishTopBar.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
EnglishTopBar.BorderSizePixel = 0
EnglishTopBar.Position = UDim2.new(0, 0, 0, 0)
EnglishTopBar.Size = UDim2.new(1, 0, 0, 40)

-- Add gradient to English top bar
local EnglishTopBarGradient = TopBarGradient:Clone()
EnglishTopBarGradient.Parent = EnglishTopBar

-- Add corner radius to English top bar
local EnglishTopBarCorner = TopBarCorner:Clone()
EnglishTopBarCorner.Parent = EnglishTopBar

-- English script title
local EnglishTitle = Instance.new("TextLabel")
EnglishTitle.Name = "Title"
EnglishTitle.Parent = EnglishTopBar
EnglishTitle.BackgroundTransparency = 1
EnglishTitle.Position = UDim2.new(0.5, 0, 0.5, 0)
EnglishTitle.Size = UDim2.new(0, 300, 0, 30)
EnglishTitle.Font = Enum.Font.GothamBold
EnglishTitle.Text = "ENGLISH SCRIPT"
EnglishTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
EnglishTitle.TextSize = 18
EnglishTitle.AnchorPoint = Vector2.new(0.5, 0.5)

-- Add glow to English title
local EnglishTitleGlow = TitleGlow:Clone()
EnglishTitleGlow.Parent = EnglishTitle

-- English script content with improved styling
local EnglishContent = Instance.new("TextLabel")
EnglishContent.Name = "Content"
EnglishContent.Parent = EnglishScriptFrame
EnglishContent.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
EnglishContent.BackgroundTransparency = 0.7
EnglishContent.BorderSizePixel = 0
EnglishContent.Position = UDim2.new(0.5, 0, 0.55, 0)
EnglishContent.Size = UDim2.new(0.9, 0, 0.7, 0)
EnglishContent.Font = Enum.Font.Code
EnglishContent.Text = [[loadstring(game:HttpGet("https://raw.githubusercontent.com/Front-Evill/Script-Hub/refs/heads/main/F-150.lua"))()]]
EnglishContent.TextColor3 = Color3.fromRGB(100, 255, 100)
EnglishContent.TextSize = 16
EnglishContent.AnchorPoint = Vector2.new(0.5, 0.5)
EnglishContent.TextXAlignment = Enum.TextXAlignment.Left
EnglishContent.TextYAlignment = Enum.TextYAlignment.Top
EnglishContent.RichText = true

-- Add content corner and padding
local EnglishContentCorner = Instance.new("UICorner")
EnglishContentCorner.CornerRadius = UDim.new(0, 6)
EnglishContentCorner.Parent = EnglishContent

local EnglishContentPadding = Instance.new("UIPadding")
EnglishContentPadding.PaddingLeft = UDim.new(0, 10)
EnglishContentPadding.PaddingRight = UDim.new(0, 10)
EnglishContentPadding.PaddingTop = UDim.new(0, 10)
EnglishContentPadding.PaddingBottom = UDim.new(0, 10)
EnglishContentPadding.Parent = EnglishContent

-- Close button for English script
local EnglishCloseButton = Instance.new("TextButton")
EnglishCloseButton.Name = "CloseButton"
EnglishCloseButton.Parent = EnglishTopBar
EnglishCloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
EnglishCloseButton.Position = UDim2.new(0.95, 0, 0.5, 0)
EnglishCloseButton.Size = UDim2.new(0, 24, 0, 24)
EnglishCloseButton.Font = Enum.Font.GothamBold
EnglishCloseButton.Text = "X"
EnglishCloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
EnglishCloseButton.TextSize = 14
EnglishCloseButton.AnchorPoint = Vector2.new(0.5, 0.5)
EnglishCloseButton.AutoButtonColor = false

-- Add corner radius to close button
local EnglishCloseButtonCorner = Instance.new("UICorner")
EnglishCloseButtonCorner.CornerRadius = UDim.new(0, 12)
EnglishCloseButtonCorner.Parent = EnglishCloseButton

-- Animations and functionalities
local function typeWriterEffect(textLabel, text, delay)
    local shadowLabel = textLabel:FindFirstChild(textLabel.Name .. "Shadow")
    textLabel.Text = ""
    if shadowLabel then shadowLabel.Text = "" end
    
    for i = 1, #text do
        textLabel.Text = string.sub(text, 1, i)
        if shadowLabel then shadowLabel.Text = textLabel.Text end
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

-- Function to show notification
local function showNotification(text, color, icon)
    NotificationText.Text = text
    NotificationIcon.ImageColor3 = color or Color3.fromRGB(100, 255, 100)
    NotificationIcon.Image = icon or "rbxassetid://7072706318" -- Default checkmark
    
    -- Set initial state
    NotificationFrame.Position = UDim2.new(0.5, 0, -0.1, 0)
    NotificationFrame.Visible = true
    NotificationFrame.BackgroundTransparency = 0
    
    -- Slide down animation
    local tweenInfo = TweenInfo.new(
        0.5,
        Enum.EasingStyle.Back,
        Enum.EasingDirection.Out
    )
    
    local tween = game:GetService("TweenService"):Create(
        NotificationFrame,
        tweenInfo,
        {Position = UDim2.new(0.5, 0, 0.15, 0)}
    )
    
    tween:Play()
    
    -- Glow effect on notification
    local originalColor = NotificationStroke.Color
    game:GetService("TweenService"):Create(
        NotificationStroke,
        TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true),
        {Color = Color3.fromRGB(150, 150, 255)}
    ):Play()
    
    -- Auto hide after delay
    spawn(function()
        wait(3)
        
        -- Fade out animation
        local fadeTween = game:GetService("TweenService"):Create(
            NotificationFrame,
            TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
            {
                Position = UDim2.new(0.5, 0, -0.1, 0),
                BackgroundTransparency = 1
            }
        )
        
        fadeTween:Play()
        
        -- Hide notification after fade
        wait(0.5)
        NotificationFrame.Visible = false
        NotificationStroke.Color = originalColor
    end)
end

-- Function to execute scripts
local function executeScript(script)
    -- Create a protected call to run the script
    local success, error = pcall(function()
        loadstring(script)()
    end)
    
    if success then
        showNotification("Script executed successfully!", Color3.fromRGB(100, 255, 100), "rbxassetid://7072706318")
    else
        showNotification("Failed to execute script!", Color3.fromRGB(255, 100, 100), "rbxassetid://7072725299")
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
    
    -- Animate the shimmer background
    ShimmerBg.BackgroundTransparency = 1
    ShimmerBg.Visible = true
    
    game:GetService("TweenService"):Create(
        ShimmerBg,
        TweenInfo.new(0.8),
        {BackgroundTransparency = 0.9}
    ):Play()
end

-- Function to show script frame with auto-execution
local function showScriptFrame(frame, scriptContent)
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
    
    -- Execute the script automatically
    wait(0.5)
    executeScript(scriptContent)
    
    -- Auto close GUI after script execution
    wait(1)
    hideScriptFrame(frame)
    
    -- Clean up the entire GUI after script is executed
    wait(1)
    ScreenGui:Destroy()
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

-- Button hover and click effects
ArabicButton.MouseEnter:Connect(function()
    -- Pulsing glow effect
    game:GetService("TweenService"):Create(
        ArabicButtonStroke,
        TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true),
        {Thickness = 2.5, Color = Color3.fromRGB(140, 140, 255)}
    ):Play()
    
    game:GetService("TweenService"):Create(
        ArabicButton,
        TweenInfo.new(0.3),
        {
            BackgroundColor3 = Color3.fromRGB(60, 60, 100),
            TextColor3 = Color3.fromRGB(255, 255, 255)
        }
    ):Play()
    
    -- Scale effect
    game:GetService("TweenService"):Create(
        ArabicButton,
        TweenInfo.new(0.3, Enum.EasingStyle.Back),
        {Size = UDim2.new(0, 135, 0, 48)}
    ):Play()
end)

ArabicButton.MouseLeave:Connect(function()
    -- Stop pulsing
    game:GetService("TweenService"):Create(
        ArabicButtonStroke,
        TweenInfo.new(0.3),
        {Thickness = 1.5, Color = Color3.fromRGB(100, 100, 200)}
    ):Play()
    
    game:GetService("TweenService"):Create(
        ArabicButton,
        TweenInfo.new(0.3),
        {
            BackgroundColor3 = Color3.fromRGB(40, 40, 70),
            TextColor3 = Color3.fromRGB(220, 220, 255),
            Size = UDim2.new(0, 130, 0, 45)
        }
    ):Play()
end)

EnglishButton.MouseEnter:Connect(function()
    -- Pulsing glow effect
    game:GetService("TweenService"):Create(
        EnglishButtonStroke,
        TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true),
        {Thickness = 2.5, Color = Color3.fromRGB(140, 140, 255)}
    ):Play()
    
    game:GetService("TweenService"):Create(
        EnglishButton,
        TweenInfo.new(0.3),
        {
            BackgroundColor3 = Color3.fromRGB(60, 60, 100),
            TextColor3 = Color3.fromRGB(255, 255, 255)
        }
    ):Play()
    
    -- Scale effect
    game:GetService("TweenService"):Create(
        EnglishButton,
        TweenInfo.new(0.3, Enum.EasingStyle.Back),
        {Size = UDim2.new(0, 135, 0, 48)}
    ):Play()
end)

EnglishButton.MouseLeave:Connect(function()
    -- Stop pulsing
    game:GetService("TweenService"):Create(
        EnglishButtonStroke,
        TweenInfo.new(0.3),
        {Thickness = 1.5, Color = Color3.fromRGB(100, 100, 200)}
    ):Play()
    
    game:GetService("TweenService"):Create(
        EnglishButton,
        TweenInfo.new(0.3),
        {
            BackgroundColor3 = Color3.fromRGB(40, 40, 70),
            TextColor3 = Color3.fromRGB(220, 220, 255),
            Size = UDim2.new(0, 130, 0, 45)
        }
    ):Play()
end)

-- Add hover effects to close buttons
ArabicCloseButton.MouseEnter:Connect(function()
    game:GetService("TweenService"):Create(
        ArabicCloseButton,
        TweenInfo.new(0.2),
        {BackgroundColor3 = Color3.fromRGB(255, 80, 80), Size = UDim2.new(0, 26, 0, 26)}
    ):Play()
end)

ArabicCloseButton.MouseLeave:Connect(function()
    game:GetService("TweenService"):Create(
        ArabicCloseButton,
        TweenInfo.new(0.2),
        {BackgroundColor3 = Color3.fromRGB(200, 50, 50), Size = UDim2.new(0, 24, 0, 24)}
    ):Play()
end)

EnglishCloseButton.MouseEnter:Connect(function()
    game:GetService("TweenService"):Create(
        EnglishCloseButton,
        TweenInfo.new(0.2),
        {BackgroundColor3 = Color3.fromRGB(255, 80, 80), Size = UDim2.new(0, 26, 0, 26)}
    ):Play()
end)

EnglishCloseButton.MouseLeave:Connect(function()
    game:GetService("TweenService"):Create(
        EnglishCloseButton,
        TweenInfo.new(0.2),
        {BackgroundColor3 = Color3.fromRGB(200, 50, 50), Size = UDim2.new(0, 24, 0, 24)}
    ):Play()
end)

-- Button click handlers
ArabicCloseButton.MouseButton1Click:Connect(function()
    hideScriptFrame(ArabicScriptFrame)
    wait(0.5)
    showMainFrame()
end)

EnglishCloseButton.MouseButton1Click:Connect(function()
    hideScriptFrame(EnglishScriptFrame)
    wait(0.5)
    showMainFrame()
end)

ArabicButton.MouseButton1Click:Connect(function()
    -- Button click effect
    game:GetService("TweenService"):Create(
        ArabicButton,
        TweenInfo.new(0.1),
        {Size = UDim2.new(0, 125, 0, 40)}
    ):Play()
    
    wait(0.1)
    
    game:GetService("TweenService"):Create(
        ArabicButton,
        TweenInfo.new(0.1),
        {Size = UDim2.new(0, 130, 0, 45)}
    ):Play()
    
    wait(0.2)
    
    -- Hide main menu elements
    local elements = {LanguageQuestion, ArabicButton, EnglishButton, OrLabel, LeftCredit, RightCredit, Decoration, Decoration2, ShimmerBg}
    
    for _, element in ipairs(elements) do
        game:GetService("TweenService"):Create(
            element,
            TweenInfo.new(0.3),
            {TextTransparency = 1, BackgroundTransparency = 1}
        ):Play()
    end
    
    wait(0.3)
    
    -- Close main frame
    game:GetService("TweenService"):Create(
        MainFrame,
        TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In),
        {Size = UDim2.new(0, 0, 0, 0)}
    ):Play()
    
    wait(0.5)
    MainFrame.Visible = false
    
    -- Show and auto-execute Arabic script
    showScriptFrame(ArabicScriptFrame, ArabicContent.Text)
end)

EnglishButton.MouseButton1Click:Connect(function()
    -- Button click effect
    game:GetService("TweenService"):Create(
        EnglishButton,
        TweenInfo.new(0.1),
        {Size = UDim2.new(0, 125, 0, 40)}
    ):Play()
    
    wait(0.1)
    
    game:GetService("TweenService"):Create(
        EnglishButton,
        TweenInfo.new(0.1),
        {Size = UDim2.new(0, 130, 0, 45)}
    ):Play()
    
    wait(0.2)
    
    -- Hide main menu elements
    local elements = {LanguageQuestion, ArabicButton, EnglishButton, OrLabel, LeftCredit, RightCredit, Decoration, Decoration2, ShimmerBg}
    
    for _, element in ipairs(elements) do
        game:GetService("TweenService"):Create(
            element,
            TweenInfo.new(0.3),
            {TextTransparency = 1, BackgroundTransparency = 1}
        ):Play()
    end
    
    wait(0.3)
    
    -- Close main frame
    game:GetService("TweenService"):Create(
        MainFrame,
        TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In),
        {Size = UDim2.new(0, 0, 0, 0)}
    ):Play()
    
    wait(0.5)
    MainFrame.Visible = false
    
    -- Show and auto-execute English script
    showScriptFrame(EnglishScriptFrame, EnglishContent.Text)
end)

-- Animated decorations with improved effects
spawn(function()
    while wait(1) do
        -- Animate decoration gradients with smoother transitions
        game:GetService("TweenService"):Create(
            DecorationBloom,
            TweenInfo.new(3, Enum.EasingStyle.Sine),
            {Offset = Vector2.new(1, 0)}
        ):Play()
        
        game:GetService("TweenService"):Create(
            DecorationBloom2,
            TweenInfo.new(3, Enum.EasingStyle.Sine),
            {Offset = Vector2.new(-1, 0)}
        ):Play()
        
        wait(3)
        
        DecorationBloom.Offset = Vector2.new(-1, 0)
        DecorationBloom2.Offset = Vector2.new(1, 0)
        
        -- Also animate shimmer gradient if visible
        if ShimmerBg.Visible and ShimmerGradient then
            game:GetService("TweenService"):Create(
                ShimmerGradient,
                TweenInfo.new(2, Enum.EasingStyle.Sine),
                {Offset = Vector2.new(1, 0)}
            ):Play()
            
            wait(2)
            ShimmerGradient.Offset = Vector2.new(-1, 0)
        end
    end
end)

-- Try-catch wrapper for the entire script to handle errors
local success, error = pcall(function()
    -- Start the sequence
    wait(1)
    
    -- Enhanced welcome text with particles
    spawn(function()
        local particles = {}
        for i = 1, 10 do
            local particle = Instance.new("Frame")
            particle.Parent = ScreenGui
            particle.BackgroundColor3 = Color3.fromRGB(100, 100, 255)
            particle.BorderSizePixel = 0
            particle.Size = UDim2.new(0, math.random(2, 5), 0, math.random(2, 5))
            particle.Position = UDim2.new(math.random(4, 8)/10, 0, 0.4, 0)
            particle.BackgroundTransparency = 0.5
            
            local particleCorner = Instance.new("UICorner")
            particleCorner.CornerRadius = UDim.new(1, 0)
            particleCorner.Parent = particle
            
            table.insert(particles, particle)
            
            -- Animate particle
            spawn(function()
                while particle.Parent do
                    game:GetService("TweenService"):Create(
                        particle,
                        TweenInfo.new(math.random(15, 25)/10, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
                        {
                            Position = UDim2.new(
                                particle.Position.X.Scale + math.random(-10, 10)/100,
                                0,
                                particle.Position.Y.Scale + math.random(-10, 10)/100,
                                0
                            ),
                            BackgroundTransparency = math.random(5, 9)/10
                        }
                    ):Play()
                    wait(math.random(10, 20)/10)
                end
            end)
        end
        
        -- Clean up particles later
        wait(5)
        for _, particle in ipairs(particles) do
            particle:Destroy()
        end
    end)
    
    typeWriterEffect(WelcomeText, "Welcome to Front-Evill Script Hub", 0.05)
    wait(1)
    
    -- Animated fade out welcome text with pulsing effect
    local originalTextSize = WelcomeText.TextSize
    game:GetService("TweenService"):Create(
        WelcomeText,
        TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
        {TextSize = originalTextSize * 1.1}
    ):Play()
    
    wait(0.5)
    
    game:GetService("TweenService"):Create(
        WelcomeText,
        TweenInfo.new(0.7),
        {TextTransparency = 1, TextSize = originalTextSize * 0.9}
    ):Play()
    
    -- Also fade out shadow and glow
    local shadowText = WelcomeText:FindFirstChild("WelcomeTextShadow")
    if shadowText then
        game:GetService("TweenService"):Create(
            shadowText,
            TweenInfo.new(0.7),
            {TextTransparency = 1}
        ):Play()
    end
    
    if TextGlow then
        game:GetService("TweenService"):Create(
            TextGlow,
            TweenInfo.new(0.7),
            {Transparency = 1}
        ):Play()
    end
    
    wait(0.7)
    WelcomeText.Visible = false
    
    -- Show main frame with enhanced effects
    showMainFrame()
end)

-- Handle any script errors gracefully
if not success then
    warn("Front-Evill Script Hub Error: " .. tostring(error))
    
    -- Create an error notification
    local errorNotification = Instance.new("TextLabel")
    errorNotification.Parent = ScreenGui
    errorNotification.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    errorNotification.BorderSizePixel = 0
    errorNotification.Position = UDim2.new(0.5, 0, 0.9, 0)
    errorNotification.Size = UDim2.new(0, 300, 0, 40)
    errorNotification.Font = Enum.Font.GothamBold
    errorNotification.Text = "ERROR: Please report this to front-evill!"
    errorNotification.TextColor3 = Color3.fromRGB(255, 255, 255)
    errorNotification.TextSize = 14
    errorNotification.AnchorPoint = Vector2.new(0.5, 0.5)
    
    local errorCorner = Instance.new("UICorner")
    errorCorner.CornerRadius = UDim.new(0, 8)
    errorCorner.Parent = errorNotification
    
    -- Auto-remove after 5 seconds
    wait(5)
    errorNotification:Destroy()
    ScreenGui:Destroy()
end
