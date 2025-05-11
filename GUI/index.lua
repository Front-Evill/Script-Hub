-- إنشاء الواجهة الرئيسية GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MainUI"
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

-- الإطار الرئيسي مع الخلفية السوداء الشفافة
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0.7, 0, 0.6, 0)
MainFrame.Position = UDim2.new(0.15, 0, 0.2, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
MainFrame.BackgroundTransparency = 0.3 -- شفافية 70%
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

-- جعل حواف الواجهة دائرية
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0.02, 0)
UICorner.Parent = MainFrame

-- الإطار العلوي للتحريك والأزرار
local TopFrame = Instance.new("Frame")
TopFrame.Name = "TopFrame"
TopFrame.Size = UDim2.new(1, 0, 0.07, 0)
TopFrame.Position = UDim2.new(0, 0, 0, 0)
TopFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
TopFrame.BackgroundTransparency = 0.2
TopFrame.BorderSizePixel = 0
TopFrame.Parent = MainFrame

-- UICorner للإطار العلوي
local TopCorner = Instance.new("UICorner")
TopCorner.CornerRadius = UDim.new(0.2, 0)
TopCorner.Parent = TopFrame

-- جعل الإطار العلوي قابل للسحب
local UserInputService = game:GetService("UserInputService")
local dragging
local dragInput
local dragStart
local startPos

local function updateDrag(input)
    local delta = input.Position - dragStart
    MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

TopFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
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
        updateDrag(input)
    end
end)

-- إضافة أزرار التحكم في الإطار العلوي (إغلاق، تصغير، تكبير)
local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0.05, 0, 0.8, 0)
CloseButton.Position = UDim2.new(0.94, 0, 0.1, 0)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextScaled = true
CloseButton.BorderSizePixel = 0
CloseButton.Parent = TopFrame

local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Size = UDim2.new(0.05, 0, 0.8, 0)
MinimizeButton.Position = UDim2.new(0.84, 0, 0.1, 0)
MinimizeButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
MinimizeButton.Text = "-"
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.TextScaled = true
MinimizeButton.BorderSizePixel = 0
MinimizeButton.Parent = TopFrame

local MaximizeButton = Instance.new("TextButton")
MaximizeButton.Name = "MaximizeButton"
MaximizeButton.Size = UDim2.new(0.05, 0, 0.8, 0)
MaximizeButton.Position = UDim2.new(0.89, 0, 0.1, 0)
MaximizeButton.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
MaximizeButton.Text = "+"
MaximizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MaximizeButton.TextScaled = true
MaximizeButton.BorderSizePixel = 0
MaximizeButton.Parent = TopFrame

-- جعل الأزرار دائرية
local function makeButtonRound(button)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0.3, 0)
    corner.Parent = button
end

makeButtonRound(CloseButton)
makeButtonRound(MinimizeButton)
makeButtonRound(MaximizeButton)

-- إطار التبويبات (على اليسار)
local TabsFrame = Instance.new("Frame")
TabsFrame.Name = "TabsFrame"
TabsFrame.Size = UDim2.new(0.2, 0, 0.93, 0)
TabsFrame.Position = UDim2.new(0, 0, 0.07, 0)
TabsFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
TabsFrame.BackgroundTransparency = 0.2
TabsFrame.BorderSizePixel = 0
TabsFrame.Parent = MainFrame

-- UICorner للإطار التبويبات
local TabsCorner = Instance.new("UICorner")
TabsCorner.CornerRadius = UDim.new(0.05, 0)
TabsCorner.Parent = TabsFrame

-- إطار المحتوى (الأزرار والإعدادات)
local ContentFrame = Instance.new("Frame")
ContentFrame.Name = "ContentFrame"
ContentFrame.Size = UDim2.new(0.8, 0, 0.93, 0)
ContentFrame.Position = UDim2.new(0.2, 0, 0.07, 0)
ContentFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
ContentFrame.BackgroundTransparency = 0.2
ContentFrame.BorderSizePixel = 0
ContentFrame.Parent = MainFrame

-- UICorner للإطار المحتوى
local ContentCorner = Instance.new("UICorner")
ContentCorner.CornerRadius = UDim.new(0.05, 0)
ContentCorner.Parent = ContentFrame

-- إضافة خط فاصل بين الإطارات
local Separator = Instance.new("Frame")
Separator.Name = "Separator"
Separator.Size = UDim2.new(0.002, 0, 0.93, 0)
Separator.Position = UDim2.new(0.2, -1, 0.07, 0)
Separator.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Separator.BackgroundTransparency = 0.5
Separator.BorderSizePixel = 0
Separator.ZIndex = 10
Separator.Parent = MainFrame

-- وظائف الأزرار
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
        MainFrame.Size = UDim2.new(1, 0, 1, 0)
        MainFrame.Position = UDim2.new(0, 0, 0, 0)
    else
        MainFrame.Size = originalSize
        MainFrame.Position = originalPosition
    end
end)

-- إضافة وظيفة لإعادة فتح الواجهة بعد الإغلاق باستخدام K أو Control
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed then
        if isMinimized and (input.KeyCode == Enum.KeyCode.K or input.KeyCode == Enum.KeyCode.LeftControl or input.KeyCode == Enum.KeyCode.RightControl) then
            ScreenGui.Enabled = true
            isMinimized = false
        end
    end
end)

-- إضافة مثال للتبويبات (نموذج)
local function createTab(name, icon, position)
    local TabButton = Instance.new("TextButton")
    TabButton.Name = name .. "Tab"
    TabButton.Size = UDim2.new(0.9, 0, 0.06, 0)
    TabButton.Position = UDim2.new(0.05, 0, position, 0)
    TabButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    TabButton.BackgroundTransparency = 0.3
    TabButton.Text = ""
    TabButton.BorderSizePixel = 0
    TabButton.Parent = TabsFrame
    
    local TabCorner = Instance.new("UICorner")
    TabCorner.CornerRadius = UDim.new(0.2, 0)
    TabCorner.Parent = TabButton
    
    local IconImage = Instance.new("ImageLabel")
    IconImage.Name = "Icon"
    IconImage.Size = UDim2.new(0.2, 0, 0.8, 0)
    IconImage.Position = UDim2.new(0.05, 0, 0.1, 0)
    IconImage.BackgroundTransparency = 1
    IconImage.Image = icon
    IconImage.Parent = TabButton
    
    local NameLabel = Instance.new("TextLabel")
    NameLabel.Name = "NameLabel"
    NameLabel.Size = UDim2.new(0.65, 0, 0.8, 0)
    NameLabel.Position = UDim2.new(0.3, 0, 0.1, 0)
    NameLabel.BackgroundTransparency = 1
    NameLabel.Text = name
    NameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    NameLabel.TextScaled = true
    NameLabel.TextXAlignment = Enum.TextXAlignment.Left
    NameLabel.Parent = TabButton
    
    return TabButton
end

-- إنشاء عدة تبويبات كأمثلة
createTab("Home", "rbxassetid://3926305904", 0.05)
createTab("Settings", "rbxassetid://3926307971", 0.15)
createTab("Players", "rbxassetid://3926307971", 0.25)
