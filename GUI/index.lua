local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local IsOnMobile = table.find({Enum.Platform.IOS, Enum.Platform.Android}, UserInputService:GetPlatform())

function RandomTheme() 
    local themes = {"Amethyst", "Light", "Aqua", "Rose", "Darker", "Dark"} 
    return themes[math.random(1, #themes)] 
end

local Guitheme = RandomTheme()

local themeColors = {
    Light = {
        primary = Color3.fromRGB(255, 255, 255),
        secondary = Color3.fromRGB(240, 240, 240),
        accent = Color3.fromRGB(200, 200, 200),
        text = Color3.fromRGB(50, 50, 50),
        border = Color3.fromRGB(180, 180, 180)
    },
    Amethyst = {
        primary = Color3.fromRGB(153, 102, 204),
        secondary = Color3.fromRGB(133, 82, 184),
        accent = Color3.fromRGB(173, 122, 224),
        text = Color3.fromRGB(255, 255, 255),
        border = Color3.fromRGB(113, 62, 164)
    },
    Aqua = {
        primary = Color3.fromRGB(0, 180, 216),
        secondary = Color3.fromRGB(0, 160, 196),
        accent = Color3.fromRGB(0, 200, 236),
        text = Color3.fromRGB(255, 255, 255),
        border = Color3.fromRGB(0, 140, 176)
    },
    Rose = {
        primary = Color3.fromRGB(255, 182, 193),
        secondary = Color3.fromRGB(235, 162, 173),
        accent = Color3.fromRGB(255, 202, 213),
        text = Color3.fromRGB(80, 80, 80),
        border = Color3.fromRGB(215, 142, 153)
    },
    Darker = {
        primary = Color3.fromRGB(40, 40, 40),
        secondary = Color3.fromRGB(30, 30, 30),
        accent = Color3.fromRGB(50, 50, 50),
        text = Color3.fromRGB(255, 255, 255),
        border = Color3.fromRGB(60, 60, 60)
    },
    Dark = {
        primary = Color3.fromRGB(30, 30, 30),
        secondary = Color3.fromRGB(20, 20, 20),
        accent = Color3.fromRGB(40, 40, 40),
        text = Color3.fromRGB(255, 255, 255),
        border = Color3.fromRGB(50, 50, 50)
    }
}

local currentTheme = themeColors[Guitheme]

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MainUI"
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0.7, 0, 0.6, 0)
MainFrame.Position = UDim2.new(0.15, 0, 0.2, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
MainFrame.BackgroundTransparency = 0.3 -- شفافية 70%
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

local Shadow = Instance.new("ImageLabel")
Shadow.Name = "Shadow"
Shadow.Size = UDim2.new(1, 20, 1, 20)
Shadow.Position = UDim2.new(0, -10, 0, -10)
Shadow.BackgroundTransparency = 1
Shadow.Image = "rbxassetid://5028857084"
Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
Shadow.ImageTransparency = 0.6
Shadow.ScaleType = Enum.ScaleType.Slice
Shadow.SliceCenter = Rect.new(24, 24, 276, 276)
Shadow.ZIndex = -1
Shadow.Parent = MainFrame

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0.02, 0)
UICorner.Parent = MainFrame

local TopFrame = Instance.new("Frame")
TopFrame.Name = "TopFrame"
TopFrame.Size = UDim2.new(1, 0, 0.07, 0)
TopFrame.Position = UDim2.new(0, 0, 0, 0)
TopFrame.BackgroundColor3 = currentTheme.secondary
TopFrame.BackgroundTransparency = 0.1
TopFrame.BorderSizePixel = 0
TopFrame.Parent = MainFrame

local TopGradient = Instance.new("UIGradient")
TopGradient.Rotation = 90
TopGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, currentTheme.secondary),
    ColorSequenceKeypoint.new(1, currentTheme.accent)
})
TopGradient.Parent = TopFrame

local TopCorner = Instance.new("UICorner")
TopCorner.CornerRadius = UDim.new(0.2, 0)
TopCorner.Parent = TopFrame

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Name = "Title"
TitleLabel.Size = UDim2.new(0.5, 0, 0.7, 0)
TitleLabel.Position = UDim2.new(0.02, 0, 0.15, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "Custom UI"
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextColor3 = currentTheme.text
TitleLabel.TextSize = 16
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = TopFrame

local dragging = false
local dragInput
local dragStart
local startPos

local function updateInput(input)
    local delta = input.Position - dragStart
    MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

TopFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

TopFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        updateInput(input)
    end
end)

local function createControlButton(name, position, color, symbol)
    local button = Instance.new("TextButton")
    button.Name = name
    button.Size = UDim2.new(0.05, 0, 0.8, 0)
    button.Position = position
    button.BackgroundColor3 = color
    button.Text = symbol
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextScaled = true
    button.BorderSizePixel = 0
    button.BackgroundTransparency = 0.2
    button.AutoButtonColor = false
    button.Parent = TopFrame
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0.5, 0)
    buttonCorner.Parent = button
    
    button.MouseEnter:Connect(function()
        game:GetService("TweenService"):Create(button, TweenInfo.new(0.3), {BackgroundTransparency = 0}):Play()
    end)
    
    button.MouseLeave:Connect(function()
        game:GetService("TweenService"):Create(button, TweenInfo.new(0.3), {BackgroundTransparency = 0.2}):Play()
    end)
    
    return button
end

local CloseButton = createControlButton("CloseButton", UDim2.new(0.94, 0, 0.1, 0), Color3.fromRGB(255, 70, 70), "×")
local MinimizeButton = createControlButton("MinimizeButton", UDim2.new(0.84, 0, 0.1, 0), Color3.fromRGB(100, 100, 100), "−")
local MaximizeButton = createControlButton("MaximizeButton", UDim2.new(0.89, 0, 0.1, 0), Color3.fromRGB(70, 180, 70), "□")

local TabsFrame = Instance.new("Frame")
TabsFrame.Name = "TabsFrame"
TabsFrame.Size = UDim2.new(0.2, 0, 0.93, 0)
TabsFrame.Position = UDim2.new(0, 0, 0.07, 0)
TabsFrame.BackgroundColor3 = currentTheme.secondary
TabsFrame.BackgroundTransparency = 0.1
TabsFrame.BorderSizePixel = 0
TabsFrame.Parent = MainFrame

local TabsGradient = Instance.new("UIGradient")
TabsGradient.Rotation = 0
TabsGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, currentTheme.secondary),
    ColorSequenceKeypoint.new(1, currentTheme.accent)
})
TabsGradient.Transparency = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 0.1),
    NumberSequenceKeypoint.new(1, 0.3)
})
TabsGradient.Parent = TabsFrame

local TabsCorner = Instance.new("UICorner")
TabsCorner.CornerRadius = UDim.new(0.05, 0)
TabsCorner.Parent = TabsFrame

local TabsScrolling = Instance.new("ScrollingFrame")
TabsScrolling.Name = "TabsScrolling"
TabsScrolling.Size = UDim2.new(1, 0, 1, 0)
TabsScrolling.Position = UDim2.new(0, 0, 0, 0)
TabsScrolling.BackgroundTransparency = 1
TabsScrolling.BorderSizePixel = 0
TabsScrolling.ScrollBarThickness = 2
TabsScrolling.ScrollBarImageColor3 = currentTheme.border
TabsScrolling.Parent = TabsFrame

local TabsList = Instance.new("UIListLayout")
TabsList.Name = "TabsList"
TabsList.SortOrder = Enum.SortOrder.LayoutOrder
TabsList.Padding = UDim.new(0.01, 0)
TabsList.HorizontalAlignment = Enum.HorizontalAlignment.Center
TabsList.Parent = TabsScrolling

local ContentFrame = Instance.new("Frame")
ContentFrame.Name = "ContentFrame"
ContentFrame.Size = UDim2.new(0.8, 0, 0.93, 0)
ContentFrame.Position = UDim2.new(0.2, 0, 0.07, 0)
ContentFrame.BackgroundColor3 = currentTheme.primary
ContentFrame.BackgroundTransparency = 0.1
ContentFrame.BorderSizePixel = 0
ContentFrame.Parent = MainFrame

local ContentGradient = Instance.new("UIGradient")
ContentGradient.Rotation = 45
ContentGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, currentTheme.primary),
    ColorSequenceKeypoint.new(1, currentTheme.secondary)
})
ContentGradient.Transparency = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 0.1),
    NumberSequenceKeypoint.new(1, 0.2)
})
ContentGradient.Parent = ContentFrame

local ContentCorner = Instance.new("UICorner")
ContentCorner.CornerRadius = UDim.new(0.05, 0)
ContentCorner.Parent = ContentFrame

local Separator = Instance.new("Frame")
Separator.Name = "Separator"
Separator.Size = UDim2.new(0.002, 0, 0.93, 0)
Separator.Position = UDim2.new(0.2, -1, 0.07, 0)
Separator.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Separator.BackgroundTransparency = 0.5
Separator.BorderSizePixel = 0
Separator.ZIndex = 10
Separator.Parent = MainFrame

local SeparatorGlow = Instance.new("UIGradient")
SeparatorGlow.Rotation = 90
SeparatorGlow.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
    ColorSequenceKeypoint.new(0.5, currentTheme.accent),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
})
SeparatorGlow.Parent = Separator

local isMinimized = false
local originalSize = MainFrame.Size
local originalPosition = MainFrame.Position

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui.Enabled = false
end)

MinimizeButton.MouseButton1Click:Connect(function()
    isMinimized = true
    ScreenGui.Enabled = false
end)

MaximizeButton.MouseButton1Click:Connect(function()
    if MainFrame.Size == originalSize then
        originalSize = MainFrame.Size
        originalPosition = MainFrame.Position
        
        game:GetService("TweenService"):Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Size = UDim2.new(1, -20, 1, -20),
            Position = UDim2.new(0, 10, 0, 10)
        }):Play()
    else
        game:GetService("TweenService"):Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Size = originalSize,
            Position = originalPosition
        }):Play()
    end
end)

local function createTab(name, icon, layoutOrder)
    local TabButton = Instance.new("TextButton")
    TabButton.Name = name .. "Tab"
    TabButton.Size = UDim2.new(0.9, 0, 0, 40)
    TabButton.LayoutOrder = layoutOrder
    TabButton.BackgroundColor3 = currentTheme.accent
    TabButton.BackgroundTransparency = 0.7
    TabButton.Text = ""
    TabButton.BorderSizePixel = 0
    TabButton.AutoButtonColor = false
    TabButton.Parent = TabsScrolling
    
    local TabCorner = Instance.new("UICorner")
    TabCorner.CornerRadius = UDim.new(0.2, 0)
    TabCorner.Parent = TabButton
    
    local IconImage = Instance.new("ImageLabel")
    IconImage.Name = "Icon"
    IconImage.Size = UDim2.new(0.2, 0, 0.8, 0)
    IconImage.Position = UDim2.new(0.05, 0, 0.1, 0)
    IconImage.BackgroundTransparency = 1
    IconImage.Image = icon
    IconImage.ImageColor3 = currentTheme.text
    IconImage.Parent = TabButton
    
    local NameLabel = Instance.new("TextLabel")
    NameLabel.Name = "NameLabel"
    NameLabel.Size = UDim2.new(0.65, 0, 0.8, 0)
    NameLabel.Position = UDim2.new(0.3, 0, 0.1, 0)
    NameLabel.BackgroundTransparency = 1
    NameLabel.Text = name
    NameLabel.TextColor3 = currentTheme.text
    NameLabel.Font = Enum.Font.GothamSemibold
    NameLabel.TextSize = 14
    NameLabel.TextXAlignment = Enum.TextXAlignment.Left
    NameLabel.Parent = TabButton

    local ContentPanel = Instance.new("ScrollingFrame")
    ContentPanel.Name = name .. "Panel"
    ContentPanel.Size = UDim2.new(1, -10, 1, -10)
    ContentPanel.Position = UDim2.new(0, 5, 0, 5)
    ContentPanel.BackgroundTransparency = 1
    ContentPanel.BorderSizePixel = 0
    ContentPanel.ScrollBarThickness = 4
    ContentPanel.Visible = layoutOrder == 1
    ContentPanel.Parent = ContentFrame
    
    local ContentList = Instance.new("UIListLayout")
    ContentList.SortOrder = Enum.SortOrder.LayoutOrder
    ContentList.Padding = UDim.new(0, 5)
    ContentList.Parent = ContentPanel
    
    TabButton.MouseEnter:Connect(function()
        if ContentPanel.Visible == false then
            game:GetService("TweenService"):Create(TabButton, TweenInfo.new(0.3), {BackgroundTransparency = 0.5}):Play()
        end
    end)
    
    TabButton.MouseLeave:Connect(function()
        if ContentPanel.Visible == false then
            game:GetService("TweenService"):Create(TabButton, TweenInfo.new(0.3), {BackgroundTransparency = 0.7}):Play()
        end
    end)
    
    TabButton.MouseButton1Click:Connect(function()
        for _, child in pairs(ContentFrame:GetChildren()) do
            if child:IsA("ScrollingFrame") then
                child.Visible = false
            end
        end
        
        for _, tab in pairs(TabsScrolling:GetChildren()) do
            if tab:IsA("TextButton") then
                game:GetService("TweenService"):Create(tab, TweenInfo.new(0.3), {BackgroundTransparency = 0.7}):Play()
            end
        end
        
        ContentPanel.Visible = true
        game:GetService("TweenService"):Create(TabButton, TweenInfo.new(0.3), {BackgroundTransparency = 0.2}):Play()
    end)
    
    if layoutOrder == 1 then
        TabButton.BackgroundTransparency = 0.2
    end
    
    return TabButton, ContentPanel
end

local function createButton(parent, text, layoutOrder)
    local Button = Instance.new("TextButton")
    Button.Name = text .. "Button"
    Button.Size = UDim2.new(0.9, 0, 0, 40)
    Button.LayoutOrder = layoutOrder
    Button.BackgroundColor3 = currentTheme.accent
    Button.BackgroundTransparency = 0.5
    Button.Text = text
    Button.TextColor3 = currentTheme.text
    Button.Font = Enum.Font.GothamSemibold
    Button.TextSize = 14
    Button.BorderSizePixel = 0
    Button.AutoButtonColor = false
    Button.Parent = parent
    
    local ButtonCorner = Instance.new("UICorner")
    ButtonCorner.CornerRadius = UDim.new(0.2, 0)
    ButtonCorner.Parent = Button
    
    -- Efectos hover
    Button.MouseEnter:Connect(function()
        game:GetService("TweenService"):Create(Button, TweenInfo.new(0.3), {BackgroundTransparency = 0.3}):Play()
    end)
    
    Button.MouseLeave:Connect(function()
        game:GetService("TweenService"):Create(Button, TweenInfo.new(0.3), {BackgroundTransparency = 0.5}):Play()
    end)
    
    return Button
end

local function createToggle(parent, text, layoutOrder)
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Name = text .. "Toggle"
    ToggleFrame.Size = UDim2.new(0.9, 0, 0, 40)
    ToggleFrame.LayoutOrder = layoutOrder
    ToggleFrame.BackgroundTransparency = 1
    ToggleFrame.Parent = parent
    
    local TextLabel = Instance.new("TextLabel")
    TextLabel.Size = UDim2.new(0.7, 0, 1, 0)
    TextLabel.Position = UDim2.new(0, 0, 0, 0)
    TextLabel.BackgroundTransparency = 1
    TextLabel.Text = text
    TextLabel.TextColor3 = currentTheme.text
    TextLabel.Font = Enum.Font.GothamSemibold
    TextLabel.TextSize = 14
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left
    TextLabel.Parent = ToggleFrame
    
    local ToggleButton = Instance.new("Frame")
    ToggleButton.Name = "ToggleButton"
    ToggleButton.Size = UDim2.new(0.2, 0, 0.6, 0)
    ToggleButton.Position = UDim2.new(0.75, 0, 0.2, 0)
    ToggleButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    ToggleButton.BorderSizePixel = 0
    ToggleButton.Parent = ToggleFrame
    
    local ToggleCorner = Instance.new("UICorner")
    ToggleCorner.CornerRadius = UDim.new(1, 0)
    ToggleCorner.Parent = ToggleButton
    
    local ToggleCircle = Instance.new("Frame")
    ToggleCircle.Name = "Circle"
    ToggleCircle.Size = UDim2.new(0.5, 0, 1, -2)
    ToggleCircle.Position = UDim2.new(0, 1, 0, 1)
    ToggleCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ToggleCircle.BorderSizePixel = 0
    ToggleCircle.Parent = ToggleButton
    
    local CircleCorner = Instance.new("UICorner")
    CircleCorner.CornerRadius = UDim.new(1, 0)
    CircleCorner.Parent = ToggleCircle
    
    local Toggled = false
    ToggleButton.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            Toggled = not Toggled
            if Toggled then
                game:GetService("TweenService"):Create(ToggleButton, TweenInfo.new(0.3), {BackgroundColor3 = currentTheme.accent}):Play()
                game:GetService("TweenService"):Create(ToggleCircle, TweenInfo.new(0.3), {Position = UDim2.new(0.5, 0, 0, 1)}):Play()
            else
                game:GetService("TweenService"):Create(ToggleButton, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(80, 80, 80)}):Play()
                game:GetService("TweenService"):Create(ToggleCircle, TweenInfo.new(0.3), {Position = UDim2.new(0, 1, 0, 1)}):Play()
            end
        end
    end)
    
    return ToggleFrame, Toggled
end

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed then
        if isMinimized and (input.KeyCode == Enum.KeyCode.K or input.KeyCode == Enum.KeyCode.LeftControl or input.KeyCode == Enum.KeyCode.RightControl) then
            ScreenGui.Enabled = true
            isMinimized = false
        end
    end
end)

local HomeTab, HomePanel = createTab("Home", "rbxassetid://3926305904", 1)
local SettingsTab, SettingsPanel = createTab("Settings", "rbxassetid://3926307971", 2)
local PlayersTab, PlayersPanel = createTab("Players", "rbxassetid://3926305904", 3)
local ToolsTab, ToolsPanel = createTab("Tools", "rbxassetid://3926307971", 4)
local CreditsTab, CreditsPanel = createTab("Credits", "rbxassetid://3926305904", 5)

-- Añadir elementos al panel Home
createButton(HomePanel, "Botón 1", 1)
createButton(HomePanel, "Botón 2", 2)
createToggle(HomePanel, "Opción 1", 3)
createToggle(HomePanel, "Opción 2", 4)

createToggle(SettingsPanel, "Activar Efecto", 1)
createToggle(SettingsPanel, "Sonidos", 2)
createButton(SettingsPanel, "Guardar", 3)
createButton(SettingsPanel, "Reiniciar", 4)

RunService.RenderStepped:Connect(function()
    for _, panel in pairs(ContentFrame:GetChildren()) do
        if panel:IsA("ScrollingFrame") and panel:FindFirstChildOfClass("UIListLayout") then
            local listLayout = panel:FindFirstChildOfClass("UIListLayout")
            panel.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y + 10)
        end
    end
    
    local tabsList = TabsScrolling:FindFirstChild("TabsList")
    if tabsList then
        TabsScrolling.CanvasSize = UDim2.new(0, 0, 0, tabsList.AbsoluteContentSize.Y + 10)
    end
end)

MainFrame.Size = UDim2.new(0, 0, 0, 0)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)

game:GetService("TweenService"):Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
    Size = UDim2.new(0.7, 0, 0.6, 0),
    Position = UDim2.new(0.15, 0, 0.2, 0)
}):Play()
