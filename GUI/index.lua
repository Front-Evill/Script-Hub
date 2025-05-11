-- إنشاء واجهة مستخدم متكاملة بأسلوب Fluent Design
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FluentUIComplete"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- الخلفية الرئيسية (مع تأثير Acrylic)
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainPanel"
mainFrame.Size = UDim2.new(0, 800, 0, 500)
mainFrame.Position = UDim2.new(0.5, -400, 0.5, -250)
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
title.Text = "واجهة مستخدم متكاملة"
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

-- شريط التنقل الجانبي
local sidebar = Instance.new("Frame")
sidebar.Name = "Sidebar"
sidebar.Size = UDim2.new(0, 200, 1, 0)
sidebar.Position = UDim2.new(0, 0, 0, 0)
sidebar.BackgroundColor3 = Color3.fromRGB(245, 245, 245)
sidebar.BackgroundTransparency = 0.7
sidebar.BorderSizePixel = 0
sidebar.Parent = contentArea

local sidebarCorner = Instance.new("UICorner", sidebar)
sidebarCorner.CornerRadius = UDim.new(0, 8)

-- صورة الملف الشخصي
local profileArea = Instance.new("Frame")
profileArea.Name = "ProfileArea"
profileArea.Size = UDim2.new(1, -20, 0, 80)
profileArea.Position = UDim2.new(0, 10, 0, 10)
profileArea.BackgroundTransparency = 1
profileArea.Parent = sidebar

local profilePicture = Instance.new("ImageLabel")
profilePicture.Name = "ProfilePicture"
profilePicture.Size = UDim2.new(0, 50, 0, 50)
profilePicture.Position = UDim2.new(0, 10, 0, 10)
profilePicture.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
profilePicture.Image = "rbxassetid://7712236219" -- صورة افتراضية
profilePicture.Parent = profileArea

local profileCorner = Instance.new("UICorner", profilePicture)
profileCorner.CornerRadius = UDim.new(1, 0)

local profileStroke = Instance.new("UIStroke", profilePicture)
profileStroke.Color = Color3.fromRGB(255, 255, 255)
profileStroke.Thickness = 2

local usernameLabel = Instance.new("TextLabel")
usernameLabel.Name = "Username"
usernameLabel.Size = UDim2.new(0, 120, 0, 25)
usernameLabel.Position = UDim2.new(0, 70, 0, 15)
usernameLabel.BackgroundTransparency = 1
usernameLabel.Font = Enum.Font.GothamSemibold
usernameLabel.Text = "اسم المستخدم"
usernameLabel.TextColor3 = Color3.fromRGB(60, 60, 60)
usernameLabel.TextSize = 16
usernameLabel.TextXAlignment = Enum.TextXAlignment.Left
usernameLabel.Parent = profileArea

local statusLabel = Instance.new("TextLabel")
statusLabel.Name = "Status"
statusLabel.Size = UDim2.new(0, 120, 0, 20)
statusLabel.Position = UDim2.new(0, 70, 0, 40)
statusLabel.BackgroundTransparency = 1
statusLabel.Font = Enum.Font.Gotham
statusLabel.Text = "متصل الآن"
statusLabel.TextColor3 = Color3.fromRGB(80, 180, 80)
statusLabel.TextSize = 14
statusLabel.TextXAlignment = Enum.TextXAlignment.Left
statusLabel.Parent = profileArea

-- خط فاصل
local divider = Instance.new("Frame")
divider.Name = "Divider"
divider.Size = UDim2.new(1, -20, 0, 1)
divider.Position = UDim2.new(0, 10, 0, 100)
divider.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
divider.BorderSizePixel = 0
divider.Parent = sidebar

-- دالة لإنشاء أزرار القائمة
local function createNavButton(name, icon, posY)
    local navButton = Instance.new("TextButton")
    navButton.Name = name.."Button"
    navButton.Size = UDim2.new(1, -20, 0, 40)
    navButton.Position = UDim2.new(0, 10, 0, posY)
    navButton.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
    navButton.BackgroundTransparency = 0.8
    navButton.Text = "  "..name
    navButton.TextColor3 = Color3.fromRGB(80, 80, 80)
    navButton.TextSize = 16
    navButton.Font = Enum.Font.Gotham
    navButton.TextXAlignment = Enum.TextXAlignment.Left
    navButton.Parent = sidebar
    
    local btnCorner = Instance.new("UICorner", navButton)
    btnCorner.CornerRadius = UDim.new(0, 6)
    
    local iconLabel = Instance.new("TextLabel")
    iconLabel.Name = "Icon"
    iconLabel.Size = UDim2.new(0, 24, 0, 24)
    iconLabel.Position = UDim2.new(0, 10, 0.5, -12)
    iconLabel.BackgroundTransparency = 1
    iconLabel.Font = Enum.Font.GothamSemibold
    iconLabel.Text = icon
    iconLabel.TextColor3 = Color3.fromRGB(80, 80, 80)
    iconLabel.TextSize = 18
    iconLabel.Parent = navButton
    
    -- تعديل نص الزر ليكون بعد الأيقونة
    navButton.Text = "          "..name
    
    -- دالة التحريك عند تمرير المؤشر
    navButton.MouseEnter:Connect(function()
        local tween = game:GetService("TweenService"):Create(
            navButton,
            TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {BackgroundTransparency = 0.5, TextColor3 = Color3.fromRGB(0, 120, 215)}
        )
        tween:Play()
        
        local iconTween = game:GetService("TweenService"):Create(
            iconLabel,
            TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {TextColor3 = Color3.fromRGB(0, 120, 215)}
        )
        iconTween:Play()
    end)
    
    navButton.MouseLeave:Connect(function()
        local tween = game:GetService("TweenService"):Create(
            navButton,
            TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {BackgroundTransparency = 0.8, TextColor3 = Color3.fromRGB(80, 80, 80)}
        )
        tween:Play()
        
        local iconTween = game:GetService("TweenService"):Create(
            iconLabel,
            TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {TextColor3 = Color3.fromRGB(80, 80, 80)}
        )
        iconTween:Play()
    end)
    
    return navButton
end

-- إنشاء أزرار التنقل مع الأيقونات
createNavButton("الرئيسية", "🏠", 120)
createNavButton("الملف الشخصي", "👤", 170)
createNavButton("الأصدقاء", "👥", 220)
createNavButton("الإشعارات", "🔔", 270)
createNavButton("الإعدادات", "⚙️", 320)
createNavButton("المتجر", "🛒", 370)

-- منطقة العرض الرئيسية
local displayArea = Instance.new("Frame")
displayArea.Name = "DisplayArea"
displayArea.Size = UDim2.new(1, -220, 1, -20)
displayArea.Position = UDim2.new(0, 210, 0, 10)
displayArea.BackgroundTransparency = 1
displayArea.Parent = contentArea

-- عنوان الصفحة الرئيسية
local pageTitle = Instance.new("TextLabel")
pageTitle.Name = "PageTitle"
pageTitle.Size = UDim2.new(0, 200, 0, 40)
pageTitle.Position = UDim2.new(0, 0, 0, 0)
pageTitle.BackgroundTransparency = 1
pageTitle.Font = Enum.Font.GothamBold
pageTitle.Text = "الصفحة الرئيسية"
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
welcomeTitle.Text = "مرحباً بك في التطبيق"
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
welcomeDesc.Text = "هذه واجهة مستخدم متكاملة بتصميم Fluent مخصصة للاستخدام في ألعاب Roblox. يمكنك التنقل بين الأقسام المختلفة عبر القائمة الجانبية."
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
    card.Size = UDim2.new(0.31, 0, 0, 180)
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
    cardDesc.Size = UDim2.new(1, -40, 0, 60)
    cardDesc.Position = UDim2.new(0, 20, 0, 95)
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
createInfoCard("المهام اليومية", "استعرض المهام اليومية الخاصة بك وتتبع تقدمك", "📋", 0)
createInfoCard("الإحصائيات", "شاهد إحصائياتك وتقدمك في اللعبة", "📊", 0.345)
createInfoCard("الإنجازات", "استعرض إنجازاتك المكتملة والقادمة", "🏆", 0.69)

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

local statusText = Instance.new("TextLabel")
statusText.Name = "StatusText"
statusText.Size = UDim2.new(0, 200, 1, 0)
statusText.Position = UDim2.new(0, 10, 0, 0)
statusText.BackgroundTransparency = 1
statusText.Font = Enum.Font.Gotham
statusText.Text = "حالة الاتصال: متصل"
statusText.TextColor3 = Color3.fromRGB(80, 80, 80)
statusText.TextSize = 14
statusText.TextXAlignment = Enum.TextXAlignment.Left
statusText.Parent = statusBar

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
    if mainFrame.Size ~= UDim2.new(0, 800, 0, 50) then
        local tween = game:GetService("TweenService"):Create(
            mainFrame,
            TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {Size = UDim2.new(0, 800, 0, 50)}
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
            {Size = UDim2.new(0, 800, 0, 500)}
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
            {Size = UDim2.new(0, 800, 0, 500), Position = UDim2.new(0.5, -400, 0.5, -250)}
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
searchBar.Position = UDim2.new(0, 0, 0, 420)
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
searchBox.PlaceholderText = "ابحث هنا..."
searchBox.Text = ""
searchBox.TextColor3 = Color3.fromRGB(60, 60, 60)
searchBox.TextSize = 16
searchBox.TextXAlignment = Enum.TextXAlignment.Left
searchBox.Parent = searchBar

-- إضافة زر الإجراء الرئيسي
local actionButton = Instance.new("TextButton")
actionButton.Name = "ActionButton"
actionButton.Size = UDim2.new(0, 200, 0, 45)
actionButton.Position = UDim2.new(1, -200, 0, 420)
actionButton.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
actionButton.BackgroundTransparency = 0.2
actionButton.BorderSizePixel = 0
actionButton.Text = "ابدأ الآن"
actionButton.TextColor3 = Color3.fromRGB(255, 255, 255)
actionButton.TextSize = 18
actionButton.Font = Enum.Font.GothamSemibold
actionButton.Parent = displayArea

local actionCorner = Instance.new("UICorner", actionButton)
actionCorner.CornerRadius = UDim.new(0, 8)

-- تأثيرات زر الإجراء
actionButton.MouseEnter:Connect(function()
   local tween = game:GetService("TweenService"):Create(
       actionButton,
       TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
       {BackgroundTransparency = 0, TextSize = 19}
   )
   tween:Play()
end)

actionButton.MouseLeave:Connect(function()
   local tween = game:GetService("TweenService"):Create(
       actionButton,
       TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
       {BackgroundTransparency = 0.2, TextSize = 18}
   )
   tween:Play()
end)

-- تأثير تموج الزر عند النقر (Ripple)
actionButton.MouseButton1Down:Connect(function()
   local ripple = Instance.new("Frame")
   ripple.Name = "Ripple"
   ripple.ZIndex = actionButton.ZIndex + 1
   ripple.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
   ripple.BackgroundTransparency = 0.7
   ripple.BorderSizePixel = 0
   ripple.Position = UDim2.new(0.5, 0, 0.5, 0)
   ripple.AnchorPoint = Vector2.new(0.5, 0.5)
   ripple.Size = UDim2.new(0, 0, 0, 0)
   ripple.Parent = actionButton
   
   local corner = Instance.new("UICorner", ripple)
   corner.CornerRadius = UDim.new(1, 0)
   
   local targetSize = UDim2.new(2, 0, 2, 0)
   
   local tween = game:GetService("TweenService"):Create(
       ripple,
       TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
       {Size = targetSize, BackgroundTransparency = 1}
   )
   
   tween:Play()
   
   tween.Completed:Connect(function()
       ripple:Destroy()
   end)
end)

-- إضافة قسم لعرض الإشعارات في الجانب
local notificationsArea = Instance.new("Frame")
notificationsArea.Name = "NotificationsArea"
notificationsArea.Size = UDim2.new(0, 250, 0, 0) -- سيتم تعديل الحجم لاحقاً
notificationsArea.Position = UDim2.new(1, 10, 0, 0)
notificationsArea.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
notificationsArea.BackgroundTransparency = 0.1
notificationsArea.BorderSizePixel = 0
notificationsArea.Visible = false
notificationsArea.Parent = mainFrame

local notifCorner = Instance.new("UICorner", notificationsArea)
notifCorner.CornerRadius = UDim.new(0, 8)

local notifHeader = Instance.new("Frame")
notifHeader.Name = "Header"
notifHeader.Size = UDim2.new(1, 0, 0, 40)
notifHeader.Position = UDim2.new(0, 0, 0, 0)
notifHeader.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
notifHeader.BackgroundTransparency = 0.5
notifHeader.BorderSizePixel = 0
notifHeader.Parent = notificationsArea

local headerCorner = Instance.new("UICorner", notifHeader)
headerCorner.CornerRadius = UDim.new(0, 8)

local notifTitle = Instance.new("TextLabel")
notifTitle.Name = "Title"
notifTitle.Size = UDim2.new(1, -40, 1, 0)
notifTitle.Position = UDim2.new(0, 15, 0, 0)
notifTitle.BackgroundTransparency = 1
notifTitle.Font = Enum.Font.GothamSemibold
notifTitle.Text = "الإشعارات"
notifTitle.TextColor3 = Color3.fromRGB(60, 60, 60)
notifTitle.TextSize = 18
notifTitle.TextXAlignment = Enum.TextXAlignment.Left
notifTitle.Parent = notifHeader

local closeNotif = Instance.new("TextButton")
closeNotif.Name = "CloseButton"
closeNotif.Size = UDim2.new(0, 30, 0, 30)
closeNotif.Position = UDim2.new(1, -35, 0, 5)
closeNotif.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
closeNotif.BackgroundTransparency = 0.8
closeNotif.Text = "✕"
closeNotif.TextColor3 = Color3.fromRGB(100, 100, 100)
closeNotif.TextSize = 18
closeNotif.Font = Enum.Font.GothamSemibold
closeNotif.Parent = notifHeader

local closeNotifCorner = Instance.new("UICorner", closeNotif)
closeNotifCorner.CornerRadius = UDim.new(0, 4)

-- دالة لإغلاق لوحة الإشعارات
closeNotif.MouseButton1Click:Connect(function()
   notificationsArea.Visible = false
end)

-- دالة لإنشاء إشعار
local function createNotification(title, message, time)
   local notifItem = Instance.new("Frame")
   notifItem.Name = "NotificationItem"
   notifItem.Size = UDim2.new(1, -20, 0, 80)
   notifItem.Position = UDim2.new(0, 10, 0, 50 + (#notificationsArea:GetChildren() - 2) * 90)
   notifItem.BackgroundColor3 = Color3.fromRGB(250, 250, 250)
   notifItem.BackgroundTransparency = 0.3
   notifItem.BorderSizePixel = 0
   notifItem.Parent = notificationsArea
   
   local itemCorner = Instance.new("UICorner", notifItem)
   itemCorner.CornerRadius = UDim.new(0, 6)
   
   local notifIcon = Instance.new("TextLabel")
   notifIcon.Name = "Icon"
   notifIcon.Size = UDim2.new(0, 36, 0, 36)
   notifIcon.Position = UDim2.new(0, 10, 0, 10)
   notifIcon.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
   notifIcon.BackgroundTransparency = 0.8
   notifIcon.Text = "🔔"
   notifIcon.TextColor3 = Color3.fromRGB(0, 120, 215)
   notifIcon.TextSize = 18
   notifIcon.Font = Enum.Font.GothamBold
   notifIcon.Parent = notifItem
   
   local iconCorner = Instance.new("UICorner", notifIcon)
   iconCorner.CornerRadius = UDim.new(1, 0)
   
   local notifTitle = Instance.new("TextLabel")
   notifTitle.Name = "Title"
   notifTitle.Size = UDim2.new(1, -60, 0, 20)
   notifTitle.Position = UDim2.new(0, 50, 0, 10)
   notifTitle.BackgroundTransparency = 1
   notifTitle.Font = Enum.Font.GothamSemibold
   notifTitle.Text = title
   notifTitle.TextColor3 = Color3.fromRGB(60, 60, 60)
   notifTitle.TextSize = 16
   notifTitle.TextXAlignment = Enum.TextXAlignment.Left
   notifTitle.Parent = notifItem
   
   local notifMessage = Instance.new("TextLabel")
   notifMessage.Name = "Message"
   notifMessage.Size = UDim2.new(1, -60, 0, 40)
   notifMessage.Position = UDim2.new(0, 50, 0, 30)
   notifMessage.BackgroundTransparency = 1
   notifMessage.Font = Enum.Font.Gotham
   notifMessage.Text = message
   notifMessage.TextColor3 = Color3.fromRGB(100, 100, 100)
   notifMessage.TextSize = 14
   notifMessage.TextWrapped = true
   notifMessage.TextXAlignment = Enum.TextXAlignment.Left
   notifMessage.Parent = notifItem
   
   local timeLabel = Instance.new("TextLabel")
   timeLabel.Name = "Time"
   timeLabel.Size = UDim2.new(0, 100, 0, 20)
   timeLabel.Position = UDim2.new(1, -110, 0, 10)
   timeLabel.BackgroundTransparency = 1
   timeLabel.Font = Enum.Font.Gotham
   timeLabel.Text = time
   timeLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
   timeLabel.TextSize = 12
   timeLabel.TextXAlignment = Enum.TextXAlignment.Right
   timeLabel.Parent = notifItem
   
   -- ضبط حجم منطقة الإشعارات
   notificationsArea.Size = UDim2.new(0, 250, 0, 50 + (#notificationsArea:GetChildren() - 1) * 90)
   
   return notifItem
end

-- إنشاء بعض الإشعارات كمثال
createNotification("تحديث جديد", "تم إصدار تحديث جديد للتطبيق! تفقد الميزات الجديدة.", "منذ دقيقة")
createNotification("رسالة جديدة", "لديك رسالة جديدة من صديقك", "منذ 30 دقيقة")
createNotification("تذكير", "لديك مهمة قادمة يجب إنجازها قريبًا", "منذ ساعة")

-- زر لإظهار الإشعارات
local notificationButton = Instance.new("TextButton")
notificationButton.Name = "NotificationButton"
notificationButton.Size = UDim2.new(0, 30, 0, 30)
notificationButton.Position = UDim2.new(0, 415, 0, 10)
notificationButton.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
notificationButton.BackgroundTransparency = 0.8
notificationButton.Text = "🔔"
notificationButton.TextColor3 = Color3.fromRGB(100, 100, 100)
notificationButton.TextSize = 18
notificationButton.Font = Enum.Font.GothamSemibold
notificationButton.Parent = titleBar

local notifButtonCorner = Instance.new("UICorner", notificationButton)
notifButtonCorner.CornerRadius = UDim.new(0, 4)

-- إضافة مؤشر للإشعارات الجديدة
local notifIndicator = Instance.new("Frame")
notifIndicator.Name = "Indicator"
notifIndicator.Size = UDim2.new(0, 10, 0, 10)
notifIndicator.Position = UDim2.new(1, -5, 0, 5)
notifIndicator.BackgroundColor3 = Color3.fromRGB(255, 70, 70)
notifIndicator.BorderSizePixel = 0
notifIndicator.Parent = notificationButton

local indicatorCorner = Instance.new("UICorner", notifIndicator)
indicatorCorner.CornerRadius = UDim.new(1, 0)

-- وظيفة لعرض الإشعارات
notificationButton.MouseButton1Click:Connect(function()
   notificationsArea.Visible = not notificationsArea.Visible
end)

-- إضافة قائمة منسدلة للإعدادات
local settingsDropdown = Instance.new("Frame")
settingsDropdown.Name = "SettingsDropdown"
settingsDropdown.Size = UDim2.new(0, 200, 0, 0) -- سيتم تعديل الحجم لاحقاً
settingsDropdown.Position = UDim2.new(0, 375, 0, 50)
settingsDropdown.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
settingsDropdown.BackgroundTransparency = 0.1
settingsDropdown.BorderSizePixel = 0
settingsDropdown.Visible = false
settingsDropdown.Parent = titleBar

local dropdownCorner = Instance.new("UICorner", settingsDropdown)
dropdownCorner.CornerRadius = UDim.new(0, 8)

-- دالة لإنشاء عناصر القائمة المنسدلة
local function createDropdownItem(text, icon, posY)
   local item = Instance.new("TextButton")
   item.Name = text.."Item"
   item.Size = UDim2.new(1, -20, 0, 40)
   item.Position = UDim2.new(0, 10, 0, posY)
   item.BackgroundColor3 = Color3.fromRGB(250, 250, 250)
   item.BackgroundTransparency = 1
   item.Text = "          "..text
   item.TextColor3 = Color3.fromRGB(80, 80, 80)
   item.TextSize = 16
   item.Font = Enum.Font.Gotham
   item.TextXAlignment = Enum.TextXAlignment.Left
   item.Parent = settingsDropdown
   
   local itemIcon = Instance.new("TextLabel")
   itemIcon.Name = "Icon"
   itemIcon.Size = UDim2.new(0, 24, 0, 24)
   itemIcon.Position = UDim2.new(0, 10, 0.5, -12)
   itemIcon.BackgroundTransparency = 1
   itemIcon.Font = Enum.Font.GothamSemibold
   itemIcon.Text = icon
   itemIcon.TextColor3 = Color3.fromRGB(80, 80, 80)
   itemIcon.TextSize = 18
   itemIcon.Parent = item
   
   item.MouseEnter:Connect(function()
       local tween = game:GetService("TweenService"):Create(
           item,
           TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
           {BackgroundTransparency = 0.7}
       )
       tween:Play()
   end)
   
   item.MouseLeave:Connect(function()
       local tween = game:GetService("TweenService"):Create(
           item,
           TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
           {BackgroundTransparency = 1}
       )
       tween:Play()
   end)
   
   return item
end

-- إنشاء عناصر القائمة المنسدلة
createDropdownItem("حسابي", "👤", 10)
createDropdownItem("المظهر", "🎨", 60)
createDropdownItem("الإعدادات", "⚙️", 110)
createDropdownItem("المساعدة", "❔", 160)
createDropdownItem("تسجيل الخروج", "🚪", 210)

-- تعديل حجم القائمة المنسدلة
settingsDropdown.Size = UDim2.new(0, 200, 0, 260)

-- زر الإعدادات
local settingsButton = Instance.new("TextButton")
settingsButton.Name = "SettingsButton"
settingsButton.Size = UDim2.new(0, 30, 0, 30)
settingsButton.Position = UDim2.new(0, 380, 0, 10)
settingsButton.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
settingsButton.BackgroundTransparency = 0.8
settingsButton.Text = "⚙️"
settingsButton.TextColor3 = Color3.fromRGB(100, 100, 100)
settingsButton.TextSize = 18
settingsButton.Font = Enum.Font.GothamSemibold
settingsButton.Parent = titleBar

local settingsButtonCorner = Instance.new("UICorner", settingsButton)
settingsButtonCorner.CornerRadius = UDim.new(0, 4)

-- وظيفة لعرض قائمة الإعدادات
settingsButton.MouseButton1Click:Connect(function()
   settingsDropdown.Visible = not settingsDropdown.Visible
end)

-- إضافة مؤثرات تحرك وانتقال سلسة
for _, ui in pairs(mainFrame:GetDescendants()) do
   if ui:IsA("GuiBase2d") and ui.Name ~= "Shadow" then
       ui.Active = true
   end
end
