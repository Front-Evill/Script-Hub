-- Front-Evill Script Hub GUI
-- Created for Front-Evill / 7sone

-- تحسين الجودة للنصوص
local TextService = game:GetService("TextService")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local Player = Players.LocalPlayer

-- إنشاء واجهة المستخدم الرئيسية
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FrontEvillScriptHub"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.DisplayOrder = 999

-- أنيميشن الكتابة المتحركة للترحيب
local WelcomeFrame = Instance.new("Frame")
WelcomeFrame.Name = "WelcomeFrame"
WelcomeFrame.Parent = ScreenGui
WelcomeFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
WelcomeFrame.BackgroundTransparency = 0.3
WelcomeFrame.BorderSizePixel = 0
WelcomeFrame.Position = UDim2.new(0, 0, 0, 0)
WelcomeFrame.Size = UDim2.new(1, 0, 1, 0)

local BlurEffect = Instance.new("BlurEffect")
BlurEffect.Parent = game:GetService("Lighting")
BlurEffect.Size = 0

-- تأثير ضبابي متحرك
local blurTween = TweenService:Create(BlurEffect, TweenInfo.new(1), {Size = 12})
blurTween:Play()

local WelcomeText = Instance.new("TextLabel")
WelcomeText.Name = "WelcomeText"
WelcomeText.Parent = WelcomeFrame
WelcomeText.BackgroundTransparency = 1
WelcomeText.Position = UDim2.new(0.5, 0, 0.5, 0)
WelcomeText.AnchorPoint = Vector2.new(0.5, 0.5)
WelcomeText.Size = UDim2.new(0.8, 0, 0.2, 0)
WelcomeText.Font = Enum.Font.GothamBold
WelcomeText.TextColor3 = Color3.fromRGB(255, 255, 255)
WelcomeText.TextSize = 36
WelcomeText.Text = ""
WelcomeText.TextStrokeTransparency = 0.7
WelcomeText.TextStrokeColor3 = Color3.fromRGB(0, 170, 255)

-- أنيميشن الكتابة المتحركة
local welcomeMessage = "Welcome to Script Front-Evill"
local typeSpeed = 0.05

local function typeWriter()
    for i = 1, #welcomeMessage do
        WelcomeText.Text = string.sub(welcomeMessage, 1, i)
        wait(typeSpeed)
    end
    wait(1)
    
    -- انتقال للواجهة الرئيسية
    local fadeOut = TweenService:Create(WelcomeFrame, TweenInfo.new(1.2), {BackgroundTransparency = 1})
    local textFade = TweenService:Create(WelcomeText, TweenInfo.new(1.2), {TextTransparency = 1, TextStrokeTransparency = 1})
    fadeOut:Play()
    textFade:Play()
    
    -- تصحيح الخطأ - استخدام task.spawn بدلاً من spawn لأنه أكثر استقرارًا
    task.spawn(function()
        wait(1.2)
        WelcomeFrame.Visible = false
        showMainGUI()
    end)
end

-- إنشاء الواجهة الرئيسية (اختيار اللغة)
local function showMainGUI()
    -- تأثير الضبابي للخلفية
    local blurReduction = TweenService:Create(BlurEffect, TweenInfo.new(1), {Size = 6})
    blurReduction:Play()
    
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ScreenGui
    MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    MainFrame.BorderSizePixel = 0
    MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    MainFrame.Size = UDim2.new(0, 0, 0, 0) -- سيتم تكبيره بالتدريج
    MainFrame.ClipsDescendants = true
    
    -- تأثير تظليل للإطار الرئيسي
    local UIGradient = Instance.new("UIGradient")
    UIGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 40, 40)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(25, 25, 25))
    })
    UIGradient.Rotation = 45
    UIGradient.Parent = MainFrame
    
    -- تأثير الحواف المستديرة
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 10)
    UICorner.Parent = MainFrame
    
    -- إطار العنوان
    local TitleFrame = Instance.new("Frame")
    TitleFrame.Name = "TitleFrame"
    TitleFrame.Parent = MainFrame
    TitleFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    TitleFrame.BorderSizePixel = 0
    TitleFrame.Size = UDim2.new(1, 0, 0.15, 0)
    
    local TitleUICorner = Instance.new("UICorner")
    TitleUICorner.CornerRadius = UDim.new(0, 10)
    TitleUICorner.Parent = TitleFrame
    
    -- إصلاح زاوية الإطار العلوي
    local TitleFrameCornerFix = Instance.new("Frame")
    TitleFrameCornerFix.Name = "CornerFix"
    TitleFrameCornerFix.Parent = TitleFrame
    TitleFrameCornerFix.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    TitleFrameCornerFix.BorderSizePixel = 0
    TitleFrameCornerFix.Position = UDim2.new(0, 0, 0.9, 0)
    TitleFrameCornerFix.Size = UDim2.new(1, 0, 0.1, 0)
    
    -- عنوان الواجهة
    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.Parent = TitleFrame
    Title.BackgroundTransparency = 1
    Title.Position = UDim2.new(0, 0, 0, 0)
    Title.Size = UDim2.new(1, 0, 1, 0)
    Title.Font = Enum.Font.GothamBold
    Title.Text = "هل تريد سكربت بلغة:"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 22
    
    -- معلومات الإنشاء (في الأسفل)
    local LeftCredit = Instance.new("TextLabel")
    LeftCredit.Name = "LeftCredit"
    LeftCredit.Parent = MainFrame
    LeftCredit.AnchorPoint = Vector2.new(0, 1)
    LeftCredit.BackgroundTransparency = 1
    LeftCredit.Position = UDim2.new(0.02, 0, 0.98, 0)
    LeftCredit.Size = UDim2.new(0.4, 0, 0.08, 0)
    LeftCredit.Font = Enum.Font.Gotham
    LeftCredit.Text = "GUI BY: FRONT-EVILL"
    LeftCredit.TextColor3 = Color3.fromRGB(200, 200, 200)
    LeftCredit.TextSize = 14
    LeftCredit.TextXAlignment = Enum.TextXAlignment.Left
    
    local RightCredit = Instance.new("TextLabel")
    RightCredit.Name = "RightCredit"
    RightCredit.Parent = MainFrame
    RightCredit.AnchorPoint = Vector2.new(1, 1)
    RightCredit.BackgroundTransparency = 1
    RightCredit.Position = UDim2.new(0.98, 0, 0.98, 0)
    RightCredit.Size = UDim2.new(0.5, 0, 0.08, 0)
    RightCredit.Font = Enum.Font.Gotham
    RightCredit.Text = "The Script By: front-evill / 7sone"
    RightCredit.TextColor3 = Color3.fromRGB(200, 200, 200)
    RightCredit.TextSize = 14
    RightCredit.TextXAlignment = Enum.TextXAlignment.Right
    
    -- إنشاء أزرار اختيار اللغة
    local ButtonsContainer = Instance.new("Frame")
    ButtonsContainer.Name = "ButtonsContainer"
    ButtonsContainer.Parent = MainFrame
    ButtonsContainer.BackgroundTransparency = 1
    ButtonsContainer.Position = UDim2.new(0.1, 0, 0.3, 0)
    ButtonsContainer.Size = UDim2.new(0.8, 0, 0.5, 0)
    
    -- زر اللغة العربية
    local ArabicButton = Instance.new("TextButton")
    ArabicButton.Name = "ArabicButton"
    ArabicButton.Parent = ButtonsContainer
    ArabicButton.BackgroundColor3 = Color3.fromRGB(50, 150, 220)
    ArabicButton.BorderSizePixel = 0
    ArabicButton.Position = UDim2.new(0, 0, 0, 0)
    ArabicButton.Size = UDim2.new(0.425, 0, 0.7, 0)
    ArabicButton.Font = Enum.Font.GothamBold
    ArabicButton.Text = "عربي"
    ArabicButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    ArabicButton.TextSize = 22
    
    local ArabicButtonCorner = Instance.new("UICorner")
    ArabicButtonCorner.CornerRadius = UDim.new(0, 8)
    ArabicButtonCorner.Parent = ArabicButton
    
    -- كلمة "أو" في الوسط
    local OrLabel = Instance.new("TextLabel")
    OrLabel.Name = "OrLabel"
    OrLabel.Parent = ButtonsContainer
    OrLabel.BackgroundTransparency = 1
    OrLabel.Position = UDim2.new(0.425, 0, 0, 0)
    OrLabel.Size = UDim2.new(0.15, 0, 0.7, 0)
    OrLabel.Font = Enum.Font.GothamBold
    OrLabel.Text = "OR"
    OrLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    OrLabel.TextSize = 20
    
    -- زر اللغة الإنجليزية
    local EnglishButton = Instance.new("TextButton")
    EnglishButton.Name = "EnglishButton"
    EnglishButton.Parent = ButtonsContainer
    EnglishButton.BackgroundColor3 = Color3.fromRGB(50, 150, 220)
    EnglishButton.BorderSizePixel = 0
    EnglishButton.Position = UDim2.new(0.575, 0, 0, 0)
    EnglishButton.Size = UDim2.new(0.425, 0, 0.7, 0)
    EnglishButton.Font = Enum.Font.GothamBold
    EnglishButton.Text = "English"
    EnglishButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    EnglishButton.TextSize = 22
    
    local EnglishButtonCorner = Instance.new("UICorner")
    EnglishButtonCorner.CornerRadius = UDim.new(0, 8)
    EnglishButtonCorner.Parent = EnglishButton
    
    -- تأثير الظهور التدريجي للواجهة الرئيسية
    local resizeTween = TweenService:Create(MainFrame, TweenInfo.new(0.8, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 400, 0, 240)
    })
    resizeTween:Play()
    
    -- إخفاء العناصر ثم إظهارها تدريجياً
    TitleFrame.BackgroundTransparency = 1
    Title.TextTransparency = 1
    LeftCredit.TextTransparency = 1
    RightCredit.TextTransparency = 1
    ArabicButton.BackgroundTransparency = 1
    ArabicButton.TextTransparency = 1
    OrLabel.TextTransparency = 1
    EnglishButton.BackgroundTransparency = 1
    EnglishButton.TextTransparency = 1
    
    -- إظهار العناصر بالتدريج بعد ظهور الإطار الرئيسي
    resizeTween.Completed:Connect(function()
        local fadeElements = {
            {TitleFrame, "BackgroundTransparency"},
            {Title, "TextTransparency"},
            {LeftCredit, "TextTransparency"},
            {RightCredit, "TextTransparency"},
            {ArabicButton, "BackgroundTransparency"},
            {ArabicButton, "TextTransparency"},
            {OrLabel, "TextTransparency"},
            {EnglishButton, "BackgroundTransparency"},
            {EnglishButton, "TextTransparency"}
        }
        
        for i, element in ipairs(fadeElements) do
            local fadeInTween = TweenService:Create(element[1], TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, (i-1)*0.05), {
                [element[2]] = 0
            })
            fadeInTween:Play()
        end
    end)
    
    -- وظيفة إظهار الإشعارات
    local function showNotification(message, color)
        local Notification = Instance.new("Frame")
        Notification.Name = "Notification"
        Notification.Parent = ScreenGui
        Notification.AnchorPoint = Vector2.new(0.5, 0)
        Notification.BackgroundColor3 = color or Color3.fromRGB(40, 40, 40)
        Notification.BorderSizePixel = 0
        Notification.Position = UDim2.new(0.5, 0, -0.1, 0)
        Notification.Size = UDim2.new(0, 300, 0, 60)
        
        local NotificationCorner = Instance.new("UICorner")
        NotificationCorner.CornerRadius = UDim.new(0, 8)
        NotificationCorner.Parent = Notification
        
        local NotificationText = Instance.new("TextLabel")
        NotificationText.Name = "NotificationText"
        NotificationText.Parent = Notification
        NotificationText.BackgroundTransparency = 1
        NotificationText.Position = UDim2.new(0, 0, 0, 0)
        NotificationText.Size = UDim2.new(1, 0, 1, 0)
        NotificationText.Font = Enum.Font.GothamSemibold
        NotificationText.Text = message
        NotificationText.TextColor3 = Color3.fromRGB(255, 255, 255)
        NotificationText.TextSize = 16
        
        -- تأثير ظهور الإشعار
        local showTween = TweenService:Create(Notification, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Position = UDim2.new(0.5, 0, 0.02, 0)
        })
        showTween:Play()
        
        -- إخفاء الإشعار بعد فترة
        task.spawn(function()
            wait(3)
            local hideTween = TweenService:Create(Notification, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                Position = UDim2.new(0.5, 0, -0.1, 0)
            })
            hideTween:Play()
            
            hideTween.Completed:Connect(function()
                Notification:Destroy()
            end)
        end)
    end
    
    -- وظائف إغلاق الواجهة وتنفيذ السكربت
    local function closeGUI()
        local blurFadeTween = TweenService:Create(BlurEffect, TweenInfo.new(0.5), {Size = 0})
        blurFadeTween:Play()
        
        local fadeTween = TweenService:Create(MainFrame, TweenInfo.new(0.7, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
            Size = UDim2.new(0, 0, 0, 0),
            Position = UDim2.new(0.5, 0, 1.5, 0)
        })
        fadeTween:Play()
        
        fadeTween.Completed:Connect(function()
            wait(0.5)
            ScreenGui:Destroy()
            BlurEffect:Destroy()
        end)
    end
    
    -- تنفيذ السكربت العربي
    ArabicButton.MouseButton1Click:Connect(function()
        -- تأثير الضغط على الزر
        local clickTween = TweenService:Create(ArabicButton, TweenInfo.new(0.15), {
            BackgroundColor3 = Color3.fromRGB(30, 100, 180),
            Size = UDim2.new(0.415, 0, 0.68, 0)
        })
        clickTween:Play()
        
        wait(0.15)
        
        local resetTween = TweenService:Create(ArabicButton, TweenInfo.new(0.15), {
            BackgroundColor3 = Color3.fromRGB(50, 150, 220),
            Size = UDim2.new(0.425, 0, 0.7, 0)
        })
        resetTween:Play()
        
        -- إظهار إشعار
        showNotification("جاري تشغيل السكربت باللغة العربية...", Color3.fromRGB(50, 180, 100))
        
        -- تنفيذ السكربت وإغلاق الواجهة
        task.spawn(function()
            wait(1)
            closeGUI()
            wait(1)
            
            -- تنفيذ السكربت العربي
            pcall(function()
                loadstring(game:HttpGet("https://raw.githubusercontent.com/Front-Evill/Script-Hub/refs/heads/main/Arabic.lua"))()
            end)
        end)
    end)
    
    -- تنفيذ السكربت الإنجليزي
    EnglishButton.MouseButton1Click:Connect(function()
        -- تأثير الضغط على الزر
        local clickTween = TweenService:Create(EnglishButton, TweenInfo.new(0.15), {
            BackgroundColor3 = Color3.fromRGB(30, 100, 180),
            Size = UDim2.new(0.415, 0, 0.68, 0)
        })
        clickTween:Play()
        
        wait(0.15)
        
        local resetTween = TweenService:Create(EnglishButton, TweenInfo.new(0.15), {
            BackgroundColor3 = Color3.fromRGB(50, 150, 220),
            Size = UDim2.new(0.425, 0, 0.7, 0)
        })
        resetTween:Play()
        
        -- إظهار إشعار
        showNotification("Loading English script...", Color3.fromRGB(50, 180, 100))
        
        -- تنفيذ السكربت وإغلاق الواجهة
        task.spawn(function()
            wait(1)
            closeGUI()
            wait(1)
            
            -- تنفيذ السكربت الإنجليزي
            pcall(function()
                loadstring(game:HttpGet("https://raw.githubusercontent.com/Front-Evill/Script-Hub/refs/heads/main/F-150.lua"))()
            end)
        end)
    end)
    
    -- تأثير التحويم على الأزرار
    local function applyHoverEffect(button)
        button.MouseEnter:Connect(function()
            TweenService:Create(button, TweenInfo.new(0.3), {
                BackgroundColor3 = Color3.fromRGB(70, 170, 240)
            }):Play()
        end)
        
        button.MouseLeave:Connect(function()
            TweenService:Create(button, TweenInfo.new(0.3), {
                BackgroundColor3 = Color3.fromRGB(50, 150, 220)
            }):Play()
        end)
    end
    
    applyHoverEffect(ArabicButton)
    applyHoverEffect(EnglishButton)
end

-- بدء تشغيل الواجهة مع انيميشن الكتابة
task.spawn(typeWriter)
