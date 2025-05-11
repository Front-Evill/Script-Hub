-- إنشاء واجهة مستخدم متكاملة بأسلوب Fluent Design - نسخة Nano
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "NanoUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- الخلفية الرئيسية (مع تأثير Acrylic)
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainPanel"
mainFrame.Size = UDim2.new(0, 600, 0, 400)
mainFrame.Position = UDim2.new(0.5, -300, 0.5, -200)
mainFrame.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
mainFrame.BackgroundTransparency = 0.1
mainFrame.BorderSizePixel = 0
mainFrame.Parent = ScreenGui

-- إضافة زوايا دائرية للإطار الرئيسي
local mainCorner = Instance.new("UICorner", mainFrame)
mainCorner.CornerRadius = UDim.new(0, 10)

-- إضافة تأثير الظل
local shadow = Instance.new("ImageLabel", mainFrame)
shadow.Name = "Shadow"
shadow.Size = UDim2.new(1, 60, 1, 60)
shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
shadow.AnchorPoint = Vector2.new(0.5, 0.5)
shadow.BackgroundTransparency = 1
shadow.Image = "rbxassetid://5554236805"
shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
shadow.ImageTransparency = 0.7
shadow.ZIndex = mainFrame.ZIndex - 1

-- شريط العنوان
local titleBar = Instance.new("Frame")
titleBar.Name = "TitleBar"
titleBar.Size = UDim2.new(1, 0, 0, 50)
titleBar.Position = UDim2.new(0, 0, 0, 0)
titleBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
titleBar.BackgroundTransparency = 0.5
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

local titleCorner = Instance.new("UICorner", titleBar)
titleCorner.CornerRadius = UDim.new(0, 10)

-- عنوان التطبيق
local title = Instance.new("TextLabel")
title.Name = "Title"
title.Size = UDim2.new(0, 300, 1, 0)
title.Position = UDim2.new(0, 20, 0, 0)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamSemibold
title.Text = "Nano"
title.TextColor3 = Color3.fromRGB(60, 60, 60)
title.TextSize = 22
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = titleBar

-- شعار التطبيق
local logo = Instance.new("ImageLabel")
logo.Name = "Logo"
logo.Size = UDim2.new(0, 30, 0, 30)
logo.Position = UDim2.new(0, 340, 0, 10)
logo.BackgroundTransparency = 1
logo.Image = "rbxassetid://7733658504" -- رمز عام
logo.Parent = titleBar

-- أزرار التحكم
local controlsHolder = Instance.new("Frame")
controlsHolder.Name = "ControlsHolder"
controlsHolder.Size = UDim2.new(0, 120, 1, 0)
controlsHolder.Position = UDim2.new(1, -120, 0, 0)
controlsHolder.BackgroundTransparency = 1
controlsHolder.Parent = titleBar

-- زر التصغير
local minimizeButton = Instance.new("TextButton")
minimizeButton.Name = "MinimizeButton"
minimizeButton.Size = UDim2.new(0, 30, 0, 30)
minimizeButton.Position = UDim2.new(0, 10, 0, 10)
minimizeButton.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
minimizeButton.BackgroundTransparency = 0.8
minimizeButton.Text = "─"
minimizeButton.TextColor3 = Color3.fromRGB(100, 100, 100)
minimizeButton.TextSize = 18
minimizeButton.Font = Enum.Font.GothamSemibold
minimizeButton.Parent = controlsHolder

local minimizeCorner = Instance.new("UICorner", minimizeButton)
minimizeCorner.CornerRadius = UDim.new(0, 4)

-- زر التكبير
local maximizeButton = Instance.new("TextButton")
maximizeButton.Name = "MaximizeButton"
maximizeButton.Size = UDim2.new(0, 30, 0, 30)
maximizeButton.Position = UDim2.new(0, 45, 0, 10)
maximizeButton.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
maximizeButton.BackgroundTransparency = 0.8
maximizeButton.Text = "□"
maximizeButton.TextColor3 = Color3.fromRGB(100, 100, 100)
maximizeButton.TextSize = 18
maximizeButton.Font = Enum.Font.GothamSemibold
maximizeButton.Parent = controlsHolder

local maximizeCorner = Instance.new("UICorner", maximizeButton)
maximizeCorner.CornerRadius = UDim.new(0, 4)

-- زر الإغلاق
local closeButton = Instance.new("TextButton")
closeButton.Name = "CloseButton"
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(0, 80, 0, 10)
closeButton.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
closeButton.BackgroundTransparency = 0.8
closeButton.Text = "✕"
closeButton.TextColor3 = Color3.fromRGB(100, 100, 100)
closeButton.TextSize = 18
closeButton.Font = Enum.Font.GothamSemibold
closeButton.Parent = controlsHolder

local closeCorner = Instance.new("UICorner", closeButton)
closeCorner.CornerRadius = UDim.new(0, 4)

-- منطقة المحتوى الرئيسية
local contentArea = Instance.new("Frame")
contentArea.Name = "ContentArea"
contentArea.Size = UDim2.new(1, -40, 1, -60)
contentArea.Position = UDim2.new(0, 20, 0, 50)
contentArea.BackgroundTransparency = 1
contentArea.Parent = mainFrame

-- منطقة العرض الرئيسية
local displayArea = Instance.new("Frame")
displayArea.Name = "DisplayArea"
displayArea.Size = UDim2.new(1, 0, 1, -20)
displayArea.Position = UDim2.new(0, 0, 0, 10)
displayArea.BackgroundTransparency = 1
displayArea.Parent = contentArea

-- عنوان الصفحة الرئيسية
local pageTitle = Instance.new("TextLabel")
pageTitle.Name = "PageTitle"
pageTitle.Size = UDim2.new(0, 200, 0, 40)
pageTitle.Position = UDim2.new(0, 0, 0, 0)
pageTitle.BackgroundTransparency = 1
pageTitle.Font = Enum.Font.GothamBold
pageTitle.Text = "لوحة التحكم"
pageTitle.TextColor3 = Color3.fromRGB(60, 60, 60)
pageTitle.TextSize = 22
pageTitle.TextXAlignment = Enum.TextXAlignment.Left
pageTitle.Parent = displayArea

-- لوحة الترحيب
local welcomeCard = Instance.new("Frame")
welcomeCard.Name = "WelcomeCard"
welcomeCard.Size = UDim2.new(1, 0, 0, 140)
welcomeCard.Position = UDim2.new(0, 0, 0, 50)
welcomeCard.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
welcomeCard.BackgroundTransparency = 0.2
welcomeCard.BorderSizePixel = 0
welcomeCard.Parent = displayArea

local welcomeCardCorner = Instance.new("UICorner", welcomeCard)
welcomeCardCorner.CornerRadius = UDim.new(0, 10)

local welcomeTitle = Instance.new("TextLabel")
welcomeTitle.Name = "WelcomeTitle"
welcomeTitle.Size = UDim2.new(1, -40, 0, 30)
welcomeTitle.Position = UDim2.new(0, 20, 0, 20)
welcomeTitle.BackgroundTransparency = 1
welcomeTitle.Font = Enum.Font.GothamBold
welcomeTitle.Text = "مرحباً بك في Nano"
welcomeTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
welcomeTitle.TextSize = 22
welcomeTitle.TextXAlignment = Enum.TextXAlignment.Right
welcomeTitle.Parent = welcomeCard

local welcomeDesc = Instance.new("TextLabel")
welcomeDesc.Name = "WelcomeDescription"
welcomeDesc.Size = UDim2.new(1, -40, 0, 60)
welcomeDesc.Position = UDim2.new(0, 20, 0, 60)
welcomeDesc.BackgroundTransparency = 1
welcomeDesc.Font = Enum.Font.Gotham
welcomeDesc.Text = "هذه واجهة مستخدم بسيطة بتصميم Fluent مخصصة للاستخدام في ألعاب Roblox. تتميز بالبساطة وسهولة الاستخدام."
welcomeDesc.TextColor3 = Color3.fromRGB(240, 240, 240)
welcomeDesc.TextSize = 16
welcomeDesc.TextWrapped = true
welcomeDesc.TextXAlignment = Enum.TextXAlignment.Right
welcomeDesc.Parent = welcomeCard

-- قسم البطاقات
local cardsSection = Instance.new("Frame")
cardsSection.Name = "CardsSection"
cardsSection.Size = UDim2.new(1, 0, 0, 200)
cardsSection.Position = UDim2.new(0, 0, 0, 210)
cardsSection.BackgroundTransparency = 1
cardsSection.Parent = displayArea

-- دالة لإنشاء بطاقات المعلومات
local function createInfoCard(title, description, icon, posX)
    local card = Instance.new("Frame")
    card.Name = title.."Card"
    card.Size = UDim2.new(0.31, 0, 0, 120)
    card.Position = UDim2.new(posX, 0, 0, 0)
    card.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    card.BackgroundTransparency = 0.1
    card.BorderSizePixel = 0
    card.Parent = cardsSection
    
    local cardCorner = Instance.new("UICorner", card)
    cardCorner.CornerRadius = UDim.new(0, 8)
    
    local cardIcon = Instance.new("TextLabel")
    cardIcon.Name = "Icon"
    cardIcon.Size = UDim2.new(0, 40, 0, 40)
    cardIcon.Position = UDim2.new(0, 20, 0, 15)
    cardIcon.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
    cardIcon.Text = icon
    cardIcon.TextSize = 20
    cardIcon.Font = Enum.Font.GothamBold
    cardIcon.Parent = card
    
    local iconCorner = Instance.new("UICorner", cardIcon)
    iconCorner.CornerRadius = UDim.new(0, 8)
    
    local cardTitle = Instance.new("TextLabel")
    cardTitle.Name = "Title"
    cardTitle.Size = UDim2.new(1, -40, 0, 25)
    cardTitle.Position = UDim2.new(0, 20, 0, 65)
    cardTitle.BackgroundTransparency = 1
    cardTitle.Font = Enum.Font.GothamSemibold
    cardTitle.Text = title
    cardTitle.TextColor3 = Color3.fromRGB(60, 60, 60)
    cardTitle.TextSize = 18
    cardTitle.TextXAlignment = Enum.TextXAlignment.Left
    cardTitle.Parent = card
    
    local cardDesc = Instance.new("TextLabel")
    cardDesc.Name = "Description"
    cardDesc.Size = UDim2.new(1, -40, 0, 40)
    cardDesc.Position = UDim2.new(0, 20, 0, 90)
    cardDesc.BackgroundTransparency = 1
    cardDesc.Font = Enum.Font.Gotham
    cardDesc.Text = description
    cardDesc.TextColor3 = Color3.fromRGB(100, 100, 100)
    cardDesc.TextSize = 14
    cardDesc.TextWrapped = true
    cardDesc.TextXAlignment = Enum.TextXAlignment.Left
    cardDesc.Parent = card
    
    -- تأثير تحريك البطاقة
    card.MouseEnter:Connect(function()
        local tween = game:GetService("TweenService"):Create(
            card,
            TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {Position = card.Position + UDim2.new(0, 0, 0, -5)}
        )
        tween:Play()
    end)
    
    card.MouseLeave:Connect(function()
        local tween = game:GetService("TweenService"):Create(
            card,
            TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {Position = card.Position - UDim2.new(0, 0, 0, -5)}
        )
        tween:Play()
    end)
    
    return card
end

-- إنشاء بطاقات المعلومات
createInfoCard("معلومات", "معلومات عامة حول المكتبة وكيفية استخدامها", "ℹ️", 0)
createInfoCard("مكونات", "استعراض المكونات المتاحة في المكتبة", "🧩", 0.345)
createInfoCard("توثيق", "الوصول إلى مستندات المكتبة", "📝", 0.69)

-- شريط الحالة السفلي
local statusBar = Instance.new("Frame")
statusBar.Name = "StatusBar"
statusBar.Size = UDim2.new(1, -40, 0, 30)
statusBar.Position = UDim2.new(0, 20, 1, -40)
statusBar.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
statusBar.BackgroundTransparency = 0.7
statusBar.BorderSizePixel = 0
statusBar.Parent = mainFrame

local statusCorner = Instance.new("UICorner", statusBar)
statusCorner.CornerRadius = UDim.new(0, 6)

local versionText = Instance.new("TextLabel")
versionText.Name = "VersionText"
versionText.Size = UDim2.new(0, 200, 1, 0)
versionText.Position = UDim2.new(1, -210, 0, 0)
versionText.BackgroundTransparency = 1
versionText.Font = Enum.Font.Gotham
versionText.Text = "الإصدار: 1.0.0"
versionText.TextColor3 = Color3.fromRGB(80, 80, 80)
versionText.TextSize = 14
versionText.TextXAlignment = Enum.TextXAlignment.Right
versionText.Parent = statusBar

-- جعل الواجهة قابلة للسحب
local isDragging = false
local dragInput
local dragStart
local startPos

local function updateInput(input)
    local delta = input.Position - dragStart
    mainFrame.Position = UDim2.new(
        startPos.X.Scale, 
        startPos.X.Offset + delta.X, 
        startPos.Y.Scale, 
        startPos.Y.Offset + delta.Y
    )
end

titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        isDragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                isDragging = false
            end
        end)
    end
end)

titleBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == dragInput and isDragging then
        updateInput(input)
    end
end)

-- وظيفة إغلاق الواجهة
closeButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- وظائف أزرار التحكم الأخرى
minimizeButton.MouseButton1Click:Connect(function()
    -- يمكن تنفيذ وظيفة التصغير هنا
    if mainFrame.Size ~= UDim2.new(0, 600, 0, 50) then
        local tween = game:GetService("TweenService"):Create(
            mainFrame,
            TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {Size = UDim2.new(0, 600, 0, 50)}
        )
        tween:Play()
        
        for _, child in pairs(mainFrame:GetChildren()) do
            if child.Name ~= "TitleBar" and child.Name ~= "Shadow" then
                child.Visible = false
            end
        end
    else
        local tween = game:GetService("TweenService"):Create(
            mainFrame,
            TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {Size = UDim2.new(0, 600, 0, 400)}
        )
        tween:Play()
        
        for _, child in pairs(mainFrame:GetChildren()) do
            child.Visible = true
        end
    end
end)

maximizeButton.MouseButton1Click:Connect(function()
    -- يمكن تنفيذ وظيفة التكبير هنا
    if mainFrame.Size ~= UDim2.new(1, -40, 1, -40) then
        local tween = game:GetService("TweenService"):Create(
            mainFrame,
            TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {Size = UDim2.new(1, -40, 1, -40), Position = UDim2.new(0, 20, 0, 20)}
        )
        tween:Play()
    else
        local tween = game:GetService("TweenService"):Create(
            mainFrame,
            TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {Size = UDim2.new(0, 600, 0, 400), Position = UDim2.new(0.5, -300, 0.5, -200)}
        )
        tween:Play()
    end
end)

-- تطبيق تأثيرات تحرك عند تمرير المؤشر لأزرار التحكم
for _, button in pairs(controlsHolder:GetChildren()) do
    if button:IsA("TextButton") then
        button.MouseEnter:Connect(function()
            local tween = game:GetService("TweenService"):Create(
                button,
                TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {BackgroundTransparency = 0.5}
            )
            tween:Play()
            
            if button.Name == "CloseButton" then
                button.BackgroundColor3 = Color3.fromRGB(232, 17, 35)
                button.TextColor3 = Color3.fromRGB(255, 255, 255)
            end
        end)

        button.MouseLeave:Connect(function()
           local tween = game:GetService("TweenService"):Create(
               button,
               TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
               {BackgroundTransparency = 0.8, BackgroundColor3 = Color3.fromRGB(240, 240, 240), TextColor3 = Color3.fromRGB(100, 100, 100)}
           )
           tween:Play()
       end)
   end
end

-- إضافة شريط بحث في القمة
local searchBar = Instance.new("Frame")
searchBar.Name = "SearchBar"
searchBar.Size = UDim2.new(0, 300, 0, 36)
searchBar.Position = UDim2.new(0, 0, 0, 330)
searchBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
searchBar.BackgroundTransparency = 0.5
searchBar.BorderSizePixel = 0
searchBar.Parent = displayArea

local searchCorner = Instance.new("UICorner", searchBar)
searchCorner.CornerRadius = UDim.new(0, 8)

local searchIcon = Instance.new("TextLabel")
searchIcon.Name = "SearchIcon"
searchIcon.Size = UDim2.new(0, 36, 0, 36)
searchIcon.Position = UDim2.new(0, 0, 0, 0)
searchIcon.BackgroundTransparency = 1
searchIcon.Font = Enum.Font.GothamSemibold
searchIcon.Text = "🔍"
searchIcon.TextColor3 = Color3.fromRGB(100, 100, 100)
searchIcon.TextSize = 18
searchIcon.Parent = searchBar

local searchBox = Instance.new("TextBox")
searchBox.Name = "SearchBox"
searchBox.Size = UDim2.new(1, -40, 1, 0)
searchBox.Position = UDim2.new(0, 40, 0, 0)
searchBox.BackgroundTransparency = 1
searchBox.Font = Enum.Font.Gotham
searchBox.PlaceholderText = "ابحث في المكتبة..."
searchBox.Text = ""
searchBox.TextColor3 = Color3.fromRGB(60, 60, 60)
searchBox.TextSize = 16
searchBox.TextXAlignment = Enum.TextXAlignment.Left
searchBox.Parent = searchBar

-- إضافة مؤثرات تحرك وانتقال سلسة
for _, ui in pairs(mainFrame:GetDescendants()) do
   if ui:IsA("GuiBase2d") and ui.Name ~= "Shadow" then
       ui.Active = true
   end
end
