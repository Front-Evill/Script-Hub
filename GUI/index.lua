local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

local IsOnMobile = table.find({Enum.Platform.IOS, Enum.Platform.Android}, UserInputService:GetPlatform())

function RandomTheme() 
    local themes = {"Amethyst", "Light", "Aqua", "Rose", "Darker", "Dark", "NeonBlue", "Sunset"} 
    return themes[math.random(1, #themes)] 
end

local Guitheme = RandomTheme()

local themeColors = {
    Light = {
        primary = Color3.fromRGB(255, 255, 255),
        secondary = Color3.fromRGB(245, 245, 245),
        accent = Color3.fromRGB(66, 133, 244),
        text = Color3.fromRGB(40, 40, 40),
        border = Color3.fromRGB(200, 200, 200),
        button = Color3.fromRGB(80, 150, 255),
        buttonHover = Color3.fromRGB(100, 170, 255)
    },
    Amethyst = {
        primary = Color3.fromRGB(153, 102, 204),
        secondary = Color3.fromRGB(133, 82, 184),
        accent = Color3.fromRGB(173, 122, 224),
        text = Color3.fromRGB(255, 255, 255),
        border = Color3.fromRGB(113, 62, 164),
        button = Color3.fromRGB(193, 142, 244),
        buttonHover = Color3.fromRGB(213, 162, 255)
    },
    Aqua = {
        primary = Color3.fromRGB(0, 180, 216),
        secondary = Color3.fromRGB(0, 160, 196),
        accent = Color3.fromRGB(0, 200, 236),
        text = Color3.fromRGB(255, 255, 255),
        border = Color3.fromRGB(0, 140, 176),
        button = Color3.fromRGB(0, 210, 255),
        buttonHover = Color3.fromRGB(40, 230, 255)
    },
    Rose = {
        primary = Color3.fromRGB(255, 182, 193),
        secondary = Color3.fromRGB(235, 162, 173),
        accent = Color3.fromRGB(255, 102, 153),
        text = Color3.fromRGB(70, 70, 70),
        border = Color3.fromRGB(215, 142, 153),
        button = Color3.fromRGB(255, 122, 173),
        buttonHover = Color3.fromRGB(255, 142, 193)
    },
    Darker = {
        primary = Color3.fromRGB(40, 40, 40),
        secondary = Color3.fromRGB(30, 30, 30),
        accent = Color3.fromRGB(85, 170, 255),
        text = Color3.fromRGB(255, 255, 255),
        border = Color3.fromRGB(60, 60, 60),
        button = Color3.fromRGB(65, 150, 235),
        buttonHover = Color3.fromRGB(85, 170, 255)
    },
    Dark = {
        primary = Color3.fromRGB(25, 25, 25),
        secondary = Color3.fromRGB(15, 15, 15),
        accent = Color3.fromRGB(85, 85, 255),
        text = Color3.fromRGB(255, 255, 255),
        border = Color3.fromRGB(50, 50, 50),
        button = Color3.fromRGB(65, 65, 235),
        buttonHover = Color3.fromRGB(85, 85, 255)
    },
    NeonBlue = {
        primary = Color3.fromRGB(10, 10, 35),
        secondary = Color3.fromRGB(5, 5, 25),
        accent = Color3.fromRGB(0, 200, 255),
        text = Color3.fromRGB(220, 240, 255),
        border = Color3.fromRGB(0, 150, 200),
        button = Color3.fromRGB(0, 180, 255),
        buttonHover = Color3.fromRGB(50, 220, 255)
    },
    Sunset = {
        primary = Color3.fromRGB(35, 10, 45),
        secondary = Color3.fromRGB(25, 5, 35),
        accent = Color3.fromRGB(255, 100, 130),
        text = Color3.fromRGB(255, 255, 255),
        border = Color3.fromRGB(200, 50, 80),
        button = Color3.fromRGB(255, 80, 110),
        buttonHover = Color3.fromRGB(255, 120, 150)
    }
}

local currentTheme = themeColors[Guitheme]

-- Función para crear efecto de sombras
local function createShadow(parent, transparency, size)
    local shadow = Instance.new("ImageLabel")
    shadow.Name = "Shadow"
    shadow.Size = UDim2.new(1, size or 20, 1, size or 20)
    shadow.Position = UDim2.new(0, -(size or 20)/2, 0, -(size or 20)/2)
    shadow.BackgroundTransparency = 1
    shadow.Image = "rbxassetid://5028857084"
    shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    shadow.ImageTransparency = transparency or 0.6
    shadow.ScaleType = Enum.ScaleType.Slice
    shadow.SliceCenter = Rect.new(24, 24, 276, 276)
    shadow.ZIndex = -1
    shadow.Parent = parent
    return shadow
end

-- Función para crear efecto de brillos
local function createGlow(parent, color, transparency)
    local glow = Instance.new("ImageLabel")
    glow.Name = "Glow"
    glow.Size = UDim2.new(1, 40, 1, 40)
    glow.Position = UDim2.new(0, -20, 0, -20)
    glow.BackgroundTransparency = 1
    glow.Image = "rbxassetid://5028857084"
    glow.ImageColor3 = color or currentTheme.accent
    glow.ImageTransparency = transparency or 0.9
    glow.ScaleType = Enum.ScaleType.Slice
    glow.SliceCenter = Rect.new(24, 24, 276, 276)
    glow.Parent = parent
    return glow
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "EnhancedUI"
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0.75, 0, 0.65, 0)
MainFrame.Position = UDim2.new(0.125, 0, 0.175, 0)
MainFrame.BackgroundColor3 = currentTheme.primary
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

-- Crear sombra principal
createShadow(MainFrame, 0.5, 30)

-- Efecto de brillo sutil en el borde
createGlow(MainFrame, currentTheme.accent, 0.85)

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0.02, 0)
UICorner.Parent = MainFrame

-- Panel superior con gradiente mejorado
local TopFrame = Instance.new("Frame")
TopFrame.Name = "TopFrame"
TopFrame.Size = UDim2.new(1, 0, 0.07, 0)
TopFrame.Position = UDim2.new(0, 0, 0, 0)
TopFrame.BackgroundColor3 = currentTheme.secondary
TopFrame.BorderSizePixel = 0
TopFrame.Parent = MainFrame

local TopGradient = Instance.new("UIGradient")
TopGradient.Rotation = 90
TopGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, currentTheme.secondary),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(
        currentTheme.secondary.R * 0.95, 
        currentTheme.secondary.G * 0.95, 
        currentTheme.secondary.B * 0.95
    )),
    ColorSequenceKeypoint.new(1, currentTheme.secondary)
})
TopGradient.Parent = TopFrame

local TopCorner = Instance.new("UICorner")
TopCorner.CornerRadius = UDim.new(0, 10)
TopCorner.Parent = TopFrame

-- Título con estilo mejorado
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Name = "Title"
TitleLabel.Size = UDim2.new(0.5, 0, 0.7, 0)
TitleLabel.Position = UDim2.new(0.02, 0, 0.15, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "Premium UI"
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextColor3 = currentTheme.text
TitleLabel.TextSize = 18
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = TopFrame

-- Efecto de brillo del título
local TitleStroke = Instance.new("UIStroke")
TitleStroke.Color = currentTheme.accent
TitleStroke.Transparency = 0.8
TitleStroke.Thickness = 1
TitleStroke.Parent = TitleLabel

-- Logotipo (opcional)
local Logo = Instance.new("ImageLabel")
Logo.Name = "Logo"
Logo.Size = UDim2.new(0.04, 0, 0.7, 0)
Logo.Position = UDim2.new(-0.05, 0, 0.15, 0)
Logo.BackgroundTransparency = 1
Logo.Image = "rbxassetid://6031068433" -- Icono genérico, reemplaza con tu propio ID
Logo.ImageColor3 = currentTheme.accent
Logo.Visible = false -- Activar si quieres mostrar un logo
Logo.Parent = TopFrame

-- Animación del logo
TweenService:Create(Logo, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
    Position = UDim2.new(0.01, 0, 0.15, 0)
}):Play()

-- Configuración para arrastrar la ventana
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

-- Función mejorada para crear botones de control
local function createControlButton(name, position, color, symbol)
    local button = Instance.new("TextButton")
    button.Name = name
    button.Size = UDim2.new(0.035, 0, 0.7, 0)
    button.Position = position
    button.BackgroundColor3 = color
    button.Text = symbol
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextSize = 16
    button.Font = Enum.Font.GothamBold
    button.BorderSizePixel = 0
    button.BackgroundTransparency = 0.2
    button.AutoButtonColor = false
    button.Parent = TopFrame
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(1, 0)
    buttonCorner.Parent = button
    
    local buttonStroke = Instance.new("UIStroke")
    buttonStroke.Color = Color3.fromRGB(255, 255, 255)
    buttonStroke.Transparency = 0.9
    buttonStroke.Thickness = 1
    buttonStroke.Parent = button
    
    -- Efectos avanzados
    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.3), {
            BackgroundTransparency = 0,
            Size = UDim2.new(0.038, 0, 0.75, 0)
        }):Play()
        TweenService:Create(buttonStroke, TweenInfo.new(0.3), {
            Transparency = 0.7
        }):Play()
    end)
    
    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.3), {
            BackgroundTransparency = 0.2,
            Size = UDim2.new(0.035, 0, 0.7, 0)
        }):Play()
        TweenService:Create(buttonStroke, TweenInfo.new(0.3), {
            Transparency = 0.9
        }):Play()
    end)
    
    return button
end

-- Botones de control con posiciones más adecuadas
local CloseButton = createControlButton("CloseButton", UDim2.new(0.97, 0, 0.15, 0), Color3.fromRGB(255, 70, 70), "×")
local MinimizeButton = createControlButton("MinimizeButton", UDim2.new(0.89, 0, 0.15, 0), Color3.fromRGB(100, 100, 100), "−")
local MaximizeButton = createControlButton("MaximizeButton", UDim2.new(0.93, 0, 0.15, 0), Color3.fromRGB(70, 180, 70), "□")

-- Panel lateral con efecto de cristal (glassmorphism)
local TabsFrame = Instance.new("Frame")
TabsFrame.Name = "TabsFrame"
TabsFrame.Size = UDim2.new(0.2, 0, 0.93, 0)
TabsFrame.Position = UDim2.new(0, 0, 0.07, 0)
TabsFrame.BackgroundColor3 = currentTheme.secondary
TabsFrame.BackgroundTransparency = 0.1
TabsFrame.BorderSizePixel = 0
TabsFrame.Parent = MainFrame

-- Efecto de cristal para panel lateral
local TabsGradient = Instance.new("UIGradient")
TabsGradient.Rotation = 45
TabsGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(
        currentTheme.secondary.R * 1.1, 
        currentTheme.secondary.G * 1.1, 
        currentTheme.secondary.B * 1.1
    )),
    ColorSequenceKeypoint.new(1, currentTheme.secondary)
})
TabsGradient.Transparency = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 0.05),
    NumberSequenceKeypoint.new(1, 0.2)
})
TabsGradient.Parent = TabsFrame

local TabsCorner = Instance.new("UICorner")
TabsCorner.CornerRadius = UDim.new(0, 10)
TabsCorner.Parent = TabsFrame

-- Efecto de borde sutil para el panel lateral
local TabsStroke = Instance.new("UIStroke")
TabsStroke.Color = currentTheme.accent
TabsStroke.Transparency = 0.9
TabsStroke.Thickness = 1
TabsStroke.Parent = TabsFrame

local TabsScrolling = Instance.new("ScrollingFrame")
TabsScrolling.Name = "TabsScrolling"
TabsScrolling.Size = UDim2.new(1, -10, 1, -10)
TabsScrolling.Position = UDim2.new(0, 5, 0, 5)
TabsScrolling.BackgroundTransparency = 1
TabsScrolling.BorderSizePixel = 0
TabsScrolling.ScrollBarThickness = 3
TabsScrolling.ScrollBarImageColor3 = currentTheme.accent
TabsScrolling.ScrollBarImageTransparency = 0.5
TabsScrolling.Parent = TabsFrame

local TabsPadding = Instance.new("UIPadding")
TabsPadding.PaddingTop = UDim.new(0, 10)
TabsPadding.PaddingBottom = UDim.new(0, 10)
TabsPadding.Parent = TabsScrolling

local TabsList = Instance.new("UIListLayout")
TabsList.Name = "TabsList"
TabsList.SortOrder = Enum.SortOrder.LayoutOrder
TabsList.Padding = UDim.new(0, 8)
TabsList.HorizontalAlignment = Enum.HorizontalAlignment.Center
TabsList.Parent = TabsScrolling

-- Panel de contenido principal con efecto de profundidad
local ContentFrame = Instance.new("Frame")
ContentFrame.Name = "ContentFrame"
ContentFrame.Size = UDim2.new(0.8, 0, 0.93, 0)
ContentFrame.Position = UDim2.new(0.2, 0, 0.07, 0)
ContentFrame.BackgroundColor3 = currentTheme.primary
ContentFrame.BackgroundTransparency = 0
ContentFrame.BorderSizePixel = 0
ContentFrame.Parent = MainFrame

-- Efecto de degradado sutile para panel de contenido
local ContentGradient = Instance.new("UIGradient")
ContentGradient.Rotation = 45
ContentGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(
        currentTheme.primary.R * 1.05, 
        currentTheme.primary.G * 1.05, 
        currentTheme.primary.B * 1.05
    )),
    ColorSequenceKeypoint.new(1, currentTheme.primary)
})
ContentGradient.Transparency = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 0),
    NumberSequenceKeypoint.new(1, 0.1)
})
ContentGradient.Parent = ContentFrame

local ContentCorner = Instance.new("UICorner")
ContentCorner.CornerRadius = UDim.new(0, 10)
ContentCorner.Parent = ContentFrame

-- Separador con efecto de luz
local Separator = Instance.new("Frame")
Separator.Name = "Separator"
Separator.Size = UDim2.new(0.002, 0, 0.93, 0)
Separator.Position = UDim2.new(0.2, -1, 0.07, 0)
Separator.BackgroundColor3 = currentTheme.accent
Separator.BackgroundTransparency = 0.7
Separator.BorderSizePixel = 0
Separator.ZIndex = 10
Separator.Parent = MainFrame

-- Efecto de brillo para el separador
local SeparatorGlow = Instance.new("UIGradient")
SeparatorGlow.Rotation = 90
SeparatorGlow.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
    ColorSequenceKeypoint.new(0.5, currentTheme.accent),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
})
SeparatorGlow.Transparency = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 0.9),
    NumberSequenceKeypoint.new(0.5, 0.7),
    NumberSequenceKeypoint.new(1, 0.9)
})
SeparatorGlow.Parent = Separator

local isMinimized = false
local originalSize = MainFrame.Size
local originalPosition = MainFrame.Position

-- Funcionalidad de los botones
CloseButton.MouseButton1Click:Connect(function()
    -- Efecto de cierre
    TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
        Size = UDim2.new(0, 0, 0, 0),
        Position = UDim2.new(0.5, 0, 0.5, 0)
    }).Completed:Connect(function()
        ScreenGui.Enabled = false
    end)
    TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
        Size = UDim2.new(0, 0, 0, 0),
        Position = UDim2.new(0.5, 0, 0.5, 0)
    }):Play()
end)

MinimizeButton.MouseButton1Click:Connect(function()
    isMinimized = true
    -- Efecto de minimizar
    TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
        Size = UDim2.new(0, 0, 0, 0),
        Position = UDim2.new(0.5, 0, 0.5, 0)
    }).Completed:Connect(function()
        ScreenGui.Enabled = false
    end)
    TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
        Size = UDim2.new(0, 0, 0, 0),
        Position = UDim2.new(0.5, 0, 0.5, 0)
    }):Play()
end)

MaximizeButton.MouseButton1Click:Connect(function()
    if MainFrame.Size == originalSize then
        originalSize = MainFrame.Size
        originalPosition = MainFrame.Position
        
        TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Size = UDim2.new(1, -20, 1, -20),
            Position = UDim2.new(0, 10, 0, 10)
        }):Play()
    else
        TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Size = originalSize,
            Position = originalPosition
        }):Play()
    end
end)

-- Función mejorada para crear pestañas (tabs)
local function createTab(name, icon, layoutOrder)
    local TabButton = Instance.new("TextButton")
    TabButton.Name = name .. "Tab"
    TabButton.Size = UDim2.new(0.9, 0, 0, 45)
    TabButton.LayoutOrder = layoutOrder
    TabButton.BackgroundColor3 = currentTheme.accent
    TabButton.BackgroundTransparency = 0.8
    TabButton.Text = ""
    TabButton.BorderSizePixel = 0
    TabButton.AutoButtonColor = false
    TabButton.Parent = TabsScrolling
    
    local TabCorner = Instance.new("UICorner")
    TabCorner.CornerRadius = UDim.new(0, 8)
    TabCorner.Parent = TabButton
    
    local TabStroke = Instance.new("UIStroke")
    TabStroke.Color = currentTheme.accent
    TabStroke.Transparency = 0.7
    TabStroke.Thickness = 1
    TabStroke.Parent = TabButton
    
    local IconImage = Instance.new("ImageLabel")
    IconImage.Name = "Icon"
    IconImage.Size = UDim2.new(0.18, 0, 0.6, 0)
    IconImage.Position = UDim2.new(0.05, 0, 0.2, 0)
    IconImage.BackgroundTransparency = 1
    IconImage.Image = icon
    IconImage.ImageColor3 = currentTheme.text
    IconImage.Parent = TabButton
    
    local NameLabel = Instance.new("TextLabel")
    NameLabel.Name = "NameLabel"
    NameLabel.Size = UDim2.new(0.65, 0, 0.6, 0)
    NameLabel.Position = UDim2.new(0.28, 0, 0.2, 0)
    NameLabel.BackgroundTransparency = 1
    NameLabel.Text = name
    NameLabel.TextColor3 = currentTheme.text
    NameLabel.Font = Enum.Font.GothamSemibold
    NameLabel.TextSize = 14
    NameLabel.TextXAlignment = Enum.TextXAlignment.Left
    NameLabel.Parent = TabButton
    
    -- Indicador de pestaña activa
    local ActiveIndicator = Instance.new("Frame")
    ActiveIndicator.Name = "ActiveIndicator"
    ActiveIndicator.Size = UDim2.new(0.01, 0, 0.6, 0)
    ActiveIndicator.Position = UDim2.new(0.01, 0, 0.2, 0)
    ActiveIndicator.BackgroundColor3 = currentTheme.accent
    ActiveIndicator.BorderSizePixel = 0
    ActiveIndicator.Visible = layoutOrder == 1
    ActiveIndicator.Parent = TabButton
    
    local IndicatorCorner = Instance.new("UICorner")
    IndicatorCorner.CornerRadius = UDim.new(1, 0)
    IndicatorCorner.Parent = ActiveIndicator

    local ContentPanel = Instance.new("ScrollingFrame")
    ContentPanel.Name = name .. "Panel"
    ContentPanel.Size = UDim2.new(1, -20, 1, -20)
    ContentPanel.Position = UDim2.new(0, 10, 0, 10)
    ContentPanel.BackgroundTransparency = 1
    ContentPanel.BorderSizePixel = 0
    ContentPanel.ScrollBarThickness = 4
    ContentPanel.ScrollBarImageColor3 = currentTheme.accent
    ContentPanel.ScrollBarImageTransparency = 0.5
    ContentPanel.Visible = layoutOrder == 1
    ContentPanel.Parent = ContentFrame
    
    local ContentPadding = Instance.new("UIPadding")
    ContentPadding.PaddingTop = UDim.new(0, 5)
    ContentPadding.PaddingBottom = UDim.new(0, 5)
    ContentPadding.PaddingLeft = UDim.new(0, 5)
    ContentPadding.PaddingRight = UDim.new(0, 5)
    ContentPadding.Parent = ContentPanel
    
    local ContentList = Instance.new("UIListLayout")
    ContentList.SortOrder = Enum.SortOrder.LayoutOrder
    ContentList.Padding = UDim.new(0, 10)
    ContentList.Parent = ContentPanel
    
    -- Efectos de interacción mejorados
    TabButton.MouseEnter:Connect(function()
        if ContentPanel.Visible == false then
            TweenService:Create(TabButton, TweenInfo.new(0.3), {
                BackgroundTransparency = 0.6,
                Size = UDim2.new(0.93, 0, 0, 48)
            }):Play()
            TweenService:Create(TabStroke, TweenInfo.new(0.3), {
                Transparency = 0.5
            }):Play()
        end
    end)
    
    TabButton.MouseLeave:Connect(function()
        if ContentPanel.Visible == false then
            TweenService:Create(TabButton, TweenInfo.new(0.3), {
                BackgroundTransparency = 0.8,
                Size = UDim2.new(0.9, 0, 0, 45)
            }):Play()
            TweenService:Create(TabStroke, TweenInfo.new(0.3), {
                Transparency = 0.7
            }):Play()
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
                TweenService:Create(tab, TweenInfo.new(0.3), {
                    BackgroundTransparency = 0.8,
                    Size = UDim2.new(0.9, 0, 0, 45)
                }):Play()
                
                local tabIndicator = tab:FindFirstChild("ActiveIndicator")
                if tabIndicator then 
                    tabIndicator.Visible = false 
                end
                
                local tabStroke = tab:FindFirstChild("UIStroke")
                if tabStroke then
                    TweenService:Create(tabStroke, TweenInfo.new(0.3), {
                        Transparency = 0.7
                    }):Play()
                end
            end
        end
        
        ContentPanel.Visible = true
        ActiveIndicator.Visible = true
        
        -- Animación de entrada del panel
       ContentPanel.Position = UDim2.new(0.05, 0, 0, 10)
       ContentPanel.BackgroundTransparency = 1
       
       TweenService:Create(ContentPanel, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
           Position = UDim2.new(0, 10, 0, 10)
       }):Play()
       
       TweenService:Create(TabButton, TweenInfo.new(0.3), {
           BackgroundTransparency = 0.4,
           Size = UDim2.new(0.93, 0, 0, 48)
       }):Play()
       
       TweenService:Create(TabStroke, TweenInfo.new(0.3), {
           Transparency = 0.3
       }):Play()
   end)
   
   if layoutOrder == 1 then
       TabButton.BackgroundTransparency = 0.4
       ActiveIndicator.Visible = true
       TabStroke.Transparency = 0.3
   end
   
   return TabButton, ContentPanel
end

-- Función mejorada para crear botones estilizados
local function createButton(parent, text, layoutOrder)
   local ButtonContainer = Instance.new("Frame")
   ButtonContainer.Name = text .. "Container"
   ButtonContainer.Size = UDim2.new(0.9, 0, 0, 50)
   ButtonContainer.Position = UDim2.new(0.05, 0, 0, 0)
   ButtonContainer.BackgroundTransparency = 1
   ButtonContainer.LayoutOrder = layoutOrder
   ButtonContainer.Parent = parent
   
   local Button = Instance.new("TextButton")
   Button.Name = text .. "Button"
   Button.Size = UDim2.new(1, 0, 1, 0)
   Button.Position = UDim2.new(0, 0, 0, 0)
   Button.BackgroundColor3 = currentTheme.button
   Button.BackgroundTransparency = 0.2
   Button.Text = ""
   Button.BorderSizePixel = 0
   Button.AutoButtonColor = false
   Button.Parent = ButtonContainer
   
   local ButtonCorner = Instance.new("UICorner")
   ButtonCorner.CornerRadius = UDim.new(0, 8)
   ButtonCorner.Parent = Button
   
   local ButtonStroke = Instance.new("UIStroke")
   ButtonStroke.Color = currentTheme.accent
   ButtonStroke.Transparency = 0.7
   ButtonStroke.Thickness = 1.5
   ButtonStroke.Parent = Button
   
   -- Efecto de sombra sutil
   createShadow(Button, 0.85, 12)
   
   -- Efecto de gradiente
   local ButtonGradient = Instance.new("UIGradient")
   ButtonGradient.Rotation = 90
   ButtonGradient.Color = ColorSequence.new({
       ColorSequenceKeypoint.new(0, Color3.fromRGB(
           math.min(255, currentTheme.button.R * 1.1 * 255),
           math.min(255, currentTheme.button.G * 1.1 * 255),
           math.min(255, currentTheme.button.B * 1.1 * 255)
       )),
       ColorSequenceKeypoint.new(1, currentTheme.button)
   })
   ButtonGradient.Parent = Button
   
   local ButtonText = Instance.new("TextLabel")
   ButtonText.Name = "ButtonText"
   ButtonText.Size = UDim2.new(0.85, 0, 0.5, 0)
   ButtonText.Position = UDim2.new(0.08, 0, 0.25, 0)
   ButtonText.BackgroundTransparency = 1
   ButtonText.Text = text
   ButtonText.TextColor3 = currentTheme.text
   ButtonText.Font = Enum.Font.GothamSemibold
   ButtonText.TextSize = 16
   ButtonText.TextXAlignment = Enum.TextXAlignment.Center
   ButtonText.Parent = Button
   
   -- Icono (opcional)
   local ButtonIcon = Instance.new("ImageLabel")
   ButtonIcon.Name = "Icon"
   ButtonIcon.Size = UDim2.new(0.06, 0, 0.4, 0)
   ButtonIcon.Position = UDim2.new(0.92, 0, 0.3, 0)
   ButtonIcon.BackgroundTransparency = 1
   ButtonIcon.Image = "rbxassetid://6031091004" -- Icono de flecha
   ButtonIcon.ImageColor3 = currentTheme.text
   ButtonIcon.ImageTransparency = 0.3
   ButtonIcon.Parent = Button
   
   -- Efectos de interacción avanzados
   Button.MouseEnter:Connect(function()
       TweenService:Create(Button, TweenInfo.new(0.3), {
           BackgroundTransparency = 0,
           Size = UDim2.new(1, 0, 1, 5)
       }):Play()
       
       TweenService:Create(ButtonText, TweenInfo.new(0.3), {
           TextSize = 18,
           Position = UDim2.new(0.08, 0, 0.23, 0)
       }):Play()
       
       TweenService:Create(ButtonIcon, TweenInfo.new(0.3), {
           ImageTransparency = 0,
           Position = UDim2.new(0.94, 0, 0.3, 0)
       }):Play()
       
       TweenService:Create(ButtonStroke, TweenInfo.new(0.3), {
           Transparency = 0.3
       }):Play()
   end)
   
   Button.MouseLeave:Connect(function()
       TweenService:Create(Button, TweenInfo.new(0.3), {
           BackgroundTransparency = 0.2,
           Size = UDim2.new(1, 0, 1, 0)
       }):Play()
       
       TweenService:Create(ButtonText, TweenInfo.new(0.3), {
           TextSize = 16,
           Position = UDim2.new(0.08, 0, 0.25, 0)
       }):Play()
       
       TweenService:Create(ButtonIcon, TweenInfo.new(0.3), {
           ImageTransparency = 0.3,
           Position = UDim2.new(0.92, 0, 0.3, 0)
       }):Play()
       
       TweenService:Create(ButtonStroke, TweenInfo.new(0.3), {
           Transparency = 0.7
       }):Play()
   end)
   
   Button.MouseButton1Down:Connect(function()
       TweenService:Create(Button, TweenInfo.new(0.1), {
           Size = UDim2.new(0.98, 0, 0.95, 0),
           Position = UDim2.new(0.01, 0, 0.025, 0)
       }):Play()
   end)
   
   Button.MouseButton1Up:Connect(function()
       TweenService:Create(Button, TweenInfo.new(0.1), {
           Size = UDim2.new(1, 0, 1, 0),
           Position = UDim2.new(0, 0, 0, 0)
       }):Play()
   end)
   
   return Button
end

-- Función mejorada para crear interruptores (toggles)
local function createToggle(parent, text, layoutOrder)
   local ToggleContainer = Instance.new("Frame")
   ToggleContainer.Name = text .. "Container"
   ToggleContainer.Size = UDim2.new(0.9, 0, 0, 50)
   ToggleContainer.BackgroundTransparency = 1
   ToggleContainer.LayoutOrder = layoutOrder
   ToggleContainer.Parent = parent
   
   local ToggleFrame = Instance.new("Frame")
   ToggleFrame.Name = text .. "Toggle"
   ToggleFrame.Size = UDim2.new(1, 0, 1, 0)
   ToggleFrame.BackgroundColor3 = currentTheme.secondary
   ToggleFrame.BackgroundTransparency = 0.7
   ToggleFrame.BorderSizePixel = 0
   ToggleFrame.Parent = ToggleContainer
   
   local ToggleCorner = Instance.new("UICorner")
   ToggleCorner.CornerRadius = UDim.new(0, 8)
   ToggleCorner.Parent = ToggleFrame
   
   local ToggleStroke = Instance.new("UIStroke")
   ToggleStroke.Color = currentTheme.accent
   ToggleStroke.Transparency = 0.8
   ToggleStroke.Thickness = 1.5
   ToggleStroke.Parent = ToggleFrame
   
   local TextLabel = Instance.new("TextLabel")
   TextLabel.Size = UDim2.new(0.7, 0, 0.6, 0)
   TextLabel.Position = UDim2.new(0.05, 0, 0.2, 0)
   TextLabel.BackgroundTransparency = 1
   TextLabel.Text = text
   TextLabel.TextColor3 = currentTheme.text
   TextLabel.Font = Enum.Font.GothamSemibold
   TextLabel.TextSize = 15
   TextLabel.TextXAlignment = Enum.TextXAlignment.Left
   TextLabel.Parent = ToggleFrame
   
   local ToggleButton = Instance.new("Frame")
   ToggleButton.Name = "ToggleButton"
   ToggleButton.Size = UDim2.new(0.18, 0, 0.55, 0)
   ToggleButton.Position = UDim2.new(0.77, 0, 0.225, 0)
   ToggleButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
   ToggleButton.BorderSizePixel = 0
   ToggleButton.Parent = ToggleFrame
   
   local ToggleCorner = Instance.new("UICorner")
   ToggleCorner.CornerRadius = UDim.new(1, 0)
   ToggleCorner.Parent = ToggleButton
   
   local ToggleCircle = Instance.new("Frame")
   ToggleCircle.Name = "Circle"
   ToggleCircle.Size = UDim2.new(0.45, 0, 0.9, 0)
   ToggleCircle.Position = UDim2.new(0.025, 0, 0.05, 0)
   ToggleCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
   ToggleCircle.BorderSizePixel = 0
   ToggleCircle.Parent = ToggleButton
   
   -- Efecto de sombra para el círculo
   createShadow(ToggleCircle, 0.5, 6)
   
   local CircleCorner = Instance.new("UICorner")
   CircleCorner.CornerRadius = UDim.new(1, 0)
   CircleCorner.Parent = ToggleCircle
   
   -- Efectos de interacción
   ToggleFrame.MouseEnter:Connect(function()
       TweenService:Create(ToggleFrame, TweenInfo.new(0.3), {
           BackgroundTransparency = 0.5
       }):Play()
       
       TweenService:Create(TextLabel, TweenInfo.new(0.3), {
           TextSize = 16
       }):Play()
       
       TweenService:Create(ToggleStroke, TweenInfo.new(0.3), {
           Transparency = 0.6
       }):Play()
   end)
   
   ToggleFrame.MouseLeave:Connect(function()
       TweenService:Create(ToggleFrame, TweenInfo.new(0.3), {
           BackgroundTransparency = 0.7
       }):Play()
       
       TweenService:Create(TextLabel, TweenInfo.new(0.3), {
           TextSize = 15
       }):Play()
       
       TweenService:Create(ToggleStroke, TweenInfo.new(0.3), {
           Transparency = 0.8
       }):Play()
   end)
   
   local Toggled = false
   ToggleFrame.InputBegan:Connect(function(input)
       if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
           Toggled = not Toggled
           if Toggled then
               TweenService:Create(ToggleButton, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                   BackgroundColor3 = currentTheme.accent
               }):Play()
               
               TweenService:Create(ToggleCircle, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                   Position = UDim2.new(0.525, 0, 0.05, 0)
               }):Play()
               
               -- Efecto de brillo al activar
               local glow = createGlow(ToggleButton, currentTheme.accent, 0.7)
               TweenService:Create(glow, TweenInfo.new(0.5), {
                   ImageTransparency = 0.9
               }):Play()
           else
               TweenService:Create(ToggleButton, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                   BackgroundColor3 = Color3.fromRGB(80, 80, 80)
               }):Play()
               
               TweenService:Create(ToggleCircle, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                   Position = UDim2.new(0.025, 0, 0.05, 0)
               }):Play()
               
               -- Eliminar el brillo
               for _, child in pairs(ToggleButton:GetChildren()) do
                   if child.Name == "Glow" then
                       child:Destroy()
                   end
               end
           end
       end
   end)
   
   return ToggleFrame, Toggled
end

-- Función para crear un slider personalizado
local function createSlider(parent, text, min, max, default, layoutOrder)
   local SliderContainer = Instance.new("Frame")
   SliderContainer.Name = text .. "Container"
   SliderContainer.Size = UDim2.new(0.9, 0, 0, 65)
   SliderContainer.BackgroundTransparency = 1
   SliderContainer.LayoutOrder = layoutOrder
   SliderContainer.Parent = parent
   
   local SliderFrame = Instance.new("Frame")
   SliderFrame.Name = text .. "Slider"
   SliderFrame.Size = UDim2.new(1, 0, 1, 0)
   SliderFrame.BackgroundColor3 = currentTheme.secondary
   SliderFrame.BackgroundTransparency = 0.7
   SliderFrame.BorderSizePixel = 0
   SliderFrame.Parent = SliderContainer
   
   local SliderCorner = Instance.new("UICorner")
   SliderCorner.CornerRadius = UDim.new(0, 8)
   SliderCorner.Parent = SliderFrame
   
   local SliderStroke = Instance.new("UIStroke")
   SliderStroke.Color = currentTheme.accent
   SliderStroke.Transparency = 0.8
   SliderStroke.Thickness = 1.5
   SliderStroke.Parent = SliderFrame
   
   local TextLabel = Instance.new("TextLabel")
   TextLabel.Size = UDim2.new(0.7, 0, 0.4, 0)
   TextLabel.Position = UDim2.new(0.05, 0, 0.1, 0)
   TextLabel.BackgroundTransparency = 1
   TextLabel.Text = text
   TextLabel.TextColor3 = currentTheme.text
   TextLabel.Font = Enum.Font.GothamSemibold
   TextLabel.TextSize = 14
   TextLabel.TextXAlignment = Enum.TextXAlignment.Left
   TextLabel.Parent = SliderFrame
   
   local ValueLabel = Instance.new("TextLabel")
   ValueLabel.Size = UDim2.new(0.2, 0, 0.4, 0)
   ValueLabel.Position = UDim2.new(0.75, 0, 0.1, 0)
   ValueLabel.BackgroundTransparency = 1
   ValueLabel.Text = tostring(default)
   ValueLabel.TextColor3 = currentTheme.text
   ValueLabel.Font = Enum.Font.GothamSemibold
   ValueLabel.TextSize = 14
   ValueLabel.TextXAlignment = Enum.TextXAlignment.Right
   ValueLabel.Parent = SliderFrame
   
   local SliderBackground = Instance.new("Frame")
   SliderBackground.Name = "SliderBackground"
   SliderBackground.Size = UDim2.new(0.9, 0, 0.1, 0)
   SliderBackground.Position = UDim2.new(0.05, 0, 0.65, 0)
   SliderBackground.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
   SliderBackground.BorderSizePixel = 0
   SliderBackground.Parent = SliderFrame
   
   local BackgroundCorner = Instance.new("UICorner")
   BackgroundCorner.CornerRadius = UDim.new(1, 0)
   BackgroundCorner.Parent = SliderBackground
   
   local SliderFill = Instance.new("Frame")
   SliderFill.Name = "SliderFill"
   SliderFill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
   SliderFill.Position = UDim2.new(0, 0, 0, 0)
   SliderFill.BackgroundColor3 = currentTheme.accent
   SliderFill.BorderSizePixel = 0
   SliderFill.Parent = SliderBackground
   
   local FillCorner = Instance.new("UICorner")
   FillCorner.CornerRadius = UDim.new(1, 0)
   FillCorner.Parent = SliderFill
   
   local SliderButton = Instance.new("Frame")
   SliderButton.Name = "SliderButton"
   SliderButton.Size = UDim2.new(0, 18, 0, 18)
   SliderButton.Position = UDim2.new((default - min) / (max - min), -9, 0, -4)
   SliderButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
   SliderButton.BorderSizePixel = 0
   SliderButton.Parent = SliderBackground
   
   createShadow(SliderButton, 0.5, 6)
   
   local ButtonCorner = Instance.new("UICorner")
   ButtonCorner.CornerRadius = UDim.new(1, 0)
   ButtonCorner.Parent = SliderButton
   
   -- Efectos de interacción
   SliderFrame.MouseEnter:Connect(function()
       TweenService:Create(SliderFrame, TweenInfo.new(0.3), {
           BackgroundTransparency = 0.5
       }):Play()
       
       TweenService:Create(SliderStroke, TweenInfo.new(0.3), {
           Transparency = 0.6
       }):Play()
   end)
   
   SliderFrame.MouseLeave:Connect(function()
       TweenService:Create(SliderFrame, TweenInfo.new(0.3), {
           BackgroundTransparency = 0.7
       }):Play()
       
       TweenService:Create(SliderStroke, TweenInfo.new(0.3), {
           Transparency = 0.8
       }):Play()
   end)
   
   local value = default
   local dragging = false
   
   SliderBackground.InputBegan:Connect(function(input)
       if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
           dragging = true
           
           -- Crear efecto de brillo temporal
           local glow = createGlow(SliderButton, Color3.fromRGB(255, 255, 255), 0.8)
           TweenService:Create(glow, TweenInfo.new(0.5), {
               ImageTransparency = 0.92
           }):Play()
           
           -- Agregar tamaño al botón
           TweenService:Create(SliderButton, TweenInfo.new(0.2), {
               Size = UDim2.new(0, 20, 0, 20),
               Position = UDim2.new(SliderButton.Position.X.Scale, -10, 0, -5)
           }):Play()
       end
   end)
   
   SliderBackground.InputEnded:Connect(function(input)
       if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
           dragging = false
           
           -- Eliminar el brillo
           for _, child in pairs(SliderButton:GetChildren()) do
               if child.Name == "Glow" then
                   child:Destroy()
               end
           end
           
           -- Restaurar tamaño
           TweenService:Create(SliderButton, TweenInfo.new(0.2), {
               Size = UDim2.new(0, 18, 0, 18),
               Position = UDim2.new(SliderButton.Position.X.Scale, -9, 0, -4)
           }):Play()
       end
   end)
   
   UserInputService.InputChanged:Connect(function(input)
       if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
           local sliderPosition = math.clamp((input.Position.X - SliderBackground.AbsolutePosition.X) / SliderBackground.AbsoluteSize.X, 0, 1)
           value = math.floor(min + (sliderPosition * (max - min)))
           
           SliderFill.Size = UDim2.new(sliderPosition, 0, 1, 0)
           SliderButton.Position = UDim2.new(sliderPosition, -9, 0, -4)
           ValueLabel.Text = tostring(value)
       end
   end)
   
   return SliderContainer, function() return value end
end

-- Reconstruir la interfaz con los nuevos elementos
UserInputService.InputBegan:Connect(function(input, gameProcessed)
   if not gameProcessed then
       if isMinimized and (input.KeyCode == Enum.KeyCode.K or input.KeyCode == Enum.KeyCode.LeftControl or input.KeyCode == Enum.KeyCode.RightControl) then
           ScreenGui.Enabled = true
           isMinimized = false
           
           -- Animación de entrada
           MainFrame.Size = UDim2.new(0, 0, 0, 0)
           MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
           
           TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
               Size = originalSize,
               Position = originalPosition
           }):Play()
       end
   end
end)

-- Crear pestañas con iconos modernos
local HomeTab, HomePanel = createTab("Home", "rbxassetid://6026568198", 1)
local SettingsTab, SettingsPanel = createTab("Settings", "rbxassetid://6031280882", 2)
local PlayersTab, PlayersPanel = createTab("Players", "rbxassetid://6031754970", 3)
local ToolsTab, ToolsPanel = createTab("Tools", "rbxassetid://6022668907", 4)
local CreditsTab, CreditsPanel = createTab("Credits", "rbxassetid://6031075931", 5)

-- Añadir elementos al panel Home con los nuevos estilos
createButton(HomePanel, "Play Game", 1)
createButton(HomePanel, "Join Friends", 2)
createToggle(HomePanel, "Auto Farm", 3)
createToggle(HomePanel, "God Mode", 4)
createSlider(HomePanel, "Speed", 1, 100, 50, 5)
createSlider(HomePanel, "Jump Power", 1, 200, 100, 6)

-- Configuración
createToggle(SettingsPanel, "Enable Effects", 1)
createToggle(SettingsPanel, "Sound Effects", 2)
createSlider(SettingsPanel, "Music Volume", 0, 100, 75, 3)
createSlider(SettingsPanel, "UI Transparency", 0, 100, 20, 4)
createButton(SettingsPanel, "Save Settings", 5)
createButton(SettingsPanel, "Reset All", 6)

-- Jugadores
for i = 1, 3 do
   local PlayerButton = createButton(PlayersPanel, "Player " .. i, i)
end

-- Herramientas
createButton(ToolsPanel, "Speed Boost", 1)
createButton(ToolsPanel, "Teleport Tool", 2)
createButton(ToolsPanel, "Gravity Gun", 3)
createButton(ToolsPanel, "Invisible Tool", 4)

-- Créditos
local CreditsLabel = Instance.new("TextLabel")
CreditsLabel.Name = "CreditsLabel"
CreditsLabel.Size = UDim2.new(0.9, 0, 0, 200)
CreditsLabel.Position = UDim2.new(0.05, 0, 0, 10)
CreditsLabel.BackgroundTransparency = 1
CreditsLabel.Text = "UI Created by Developer\n\nVersion 2.0\n\nThanks for using!"
CreditsLabel.TextColor3 = currentTheme.text
CreditsLabel.Font = Enum.Font.GothamSemibold
CreditsLabel.TextSize = 18
CreditsLabel.TextWrapped = true
CreditsLabel.Parent = CreditsPanel

RunService.RenderStepped:Connect(function()
   for _, panel in pairs(ContentFrame:GetChildren()) do
       if panel:IsA("ScrollingFrame") and panel:FindFirstChildOfClass("UIListLayout") then
           local listLayout = panel:FindFirstChildOfClass("UIListLayout")
           panel.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y + 20)
       end
   end
   
   local tabsList = TabsScrolling:FindFirstChild("TabsList")
   if tabsList then
       TabsScrolling.CanvasSize = UDim2.new(0, 0, 0, tabsList.AbsoluteContentSize.Y + 20)
   end
end)

-- Animación inicial
MainFrame:TweenSize(UDim2.new(0, 0, 0, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Back, 0, true)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)

TweenService:Create(MainFrame, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
   Size = UDim2.new(0.75, 0, 0.65, 0),
   Position = UDim2.new(0.125, 0, 0.175, 0)
}):Play()

-- Animación de pestañas
for i, tab in pairs(TabsScrolling:GetChildren()) do
   if tab:IsA("TextButton") then
       tab.Position = UDim2.new(-1, 0, 0, tab.Position.Y.Offset)
       TweenService:Create(tab, TweenInfo.new(0.5 + (i * 0.1), Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
           Position = UDim2.new(0, 0, 0, tab.Position.Y.Offset)
       }):Play()
   end
end
