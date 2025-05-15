-- Script by Front-Evill / 7sone
-- تحسينات وتطويرات للواجهة الرسومية

-- المتغيرات العامة
local player = game.Players.LocalPlayer
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "FrontEvillGUI"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- تأكد من أن الواجهة ستظهر على الشاشة بشكل صحيح
if syn then
    syn.protect_gui(screenGui)
    screenGui.Parent = game:GetService("CoreGui")
elseif gethui then
    screenGui.Parent = gethui()
else
    screenGui.Parent = player.PlayerGui
end

-- إضافة نظام جزيئات (Particles) لخلفية الشاشة
local function createParticles()
    local particleContainer = Instance.new("Frame")
    particleContainer.Name = "ParticleContainer"
    particleContainer.Size = UDim2.new(1, 0, 1, 0)
    particleContainer.BackgroundTransparency = 1
    particleContainer.ZIndex = 1
    particleContainer.Parent = screenGui
    
    -- إنشاء 30 جزيء متحرك
    for i = 1, 30 do
        local particle = Instance.new("Frame")
        particle.Name = "Particle" .. i
        particle.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        particle.BorderSizePixel = 0
        particle.ZIndex = 1
        
        -- تغيير حجم الجزيئات بشكل عشوائي
        local size = math.random(2, 4)
        particle.Size = UDim2.new(0, size, 0, size)
        
        -- تحديد موقع عشوائي للجزيء
        local xPos = math.random(0, 100) / 100
        local yPos = math.random(0, 100) / 100
        particle.Position = UDim2.new(xPos, 0, yPos, 0)
        
        -- تعديل شفافية الجزيء بشكل عشوائي
        particle.BackgroundTransparency = math.random(40, 80) / 100
        
        -- مدور الشكل
        local uiCorner = Instance.new("UICorner")
        uiCorner.CornerRadius = UDim.new(1, 0)
        uiCorner.Parent = particle
        
        particle.Parent = particleContainer
        
        -- إنشاء حركة عشوائية للجزيئات
        spawn(function()
            while true do
                local moveX = math.random(-10, 10) / 1000
                local moveY = math.random(-10, 10) / 1000
                local moveDuration = math.random(3, 8)
                
                local newXPos = math.clamp(xPos + moveX, 0, 1)
                local newYPos = math.clamp(yPos + moveY, 0, 1)
                
                game:GetService("TweenService"):Create(
                    particle, 
                    TweenInfo.new(moveDuration, Enum.EasingStyle.Linear), 
                    {Position = UDim2.new(newXPos, 0, newYPos, 0)}
                ):Play()
                
                xPos = newXPos
                yPos = newYPos
                
                wait(moveDuration)
            end
        end)
    end
    
    return particleContainer
end

-- إضافة نظام الإشعارات المحسن
local function createNotification(text, duration)
    duration = duration or 3
    
    local notification = Instance.new("Frame")
    notification.Name = "Notification"
    notification.Size = UDim2.new(0, 0, 0, 60) -- سيتم تغيير العرض بالتدريج
    notification.Position = UDim2.new(0.5, 0, 0.85, 0)
    notification.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    notification.BorderSizePixel = 0
    notification.BackgroundTransparency = 0.2
    notification.Parent = screenGui
    notification.ZIndex = 10
    notification.AnchorPoint = Vector2.new(0.5, 0)
    
    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(0, 6)
    uiCorner.Parent = notification
    
    local uiStroke = Instance.new("UIStroke")
    uiStroke.Color = Color3.fromRGB(255, 0, 0)
    uiStroke.Thickness = 1.5
    uiStroke.Parent = notification
    
    local uiGradient = Instance.new("UIGradient")
    uiGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 40, 40)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 30, 30))
    })
    uiGradient.Rotation = 45
    uiGradient.Parent = notification
    
    local iconFrame = Instance.new("Frame")
    iconFrame.Name = "IconFrame"
    iconFrame.Size = UDim2.new(0, 40, 0, 40)
    iconFrame.Position = UDim2.new(0, 10, 0.5, -20)
    iconFrame.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    iconFrame.BackgroundTransparency = 0.5
    iconFrame.ZIndex = 11
    iconFrame.Parent = notification
    
    local iconCorner = Instance.new("UICorner")
    iconCorner.CornerRadius = UDim.new(1, 0)
    iconCorner.Parent = iconFrame
    
    local icon = Instance.new("TextLabel")
    icon.Size = UDim2.new(1, 0, 1, 0)
    icon.BackgroundTransparency = 1
    icon.TextColor3 = Color3.fromRGB(255, 255, 255)
    icon.TextSize = 20
    icon.Font = Enum.Font.GothamBold
    icon.Text = "!"
    icon.ZIndex = 12
    icon.Parent = iconFrame
    
    local notifText = Instance.new("TextLabel")
    notifText.Name = "NotifText"
    notifText.Size = UDim2.new(1, -70, 1, -10)
    notifText.Position = UDim2.new(0, 60, 0, 5)
    notifText.BackgroundTransparency = 1
    notifText.TextColor3 = Color3.fromRGB(255, 255, 255)
    notifText.TextSize = 16
    notifText.Font = Enum.Font.GothamBold
    notifText.Text = text
    notifText.TextWrapped = true
    notifText.TextXAlignment = Enum.TextXAlignment.Left
    notifText.ZIndex = 11
    notifText.Parent = notification
    
    notification.BackgroundTransparency = 1
    uiStroke.Transparency = 1
    notifText.TextTransparency = 1
    iconFrame.BackgroundTransparency = 1
    icon.TextTransparency = 1
    
    -- أنيميشن الظهور
    game:GetService("TweenService"):Create(notification, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 250, 0, 60),
        BackgroundTransparency = 0.2
    }):Play()
    
    wait(0.1)
    game:GetService("TweenService"):Create(uiStroke, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Transparency = 0}):Play()
    game:GetService("TweenService"):Create(notifText, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
    game:GetService("TweenService"):Create(iconFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {BackgroundTransparency = 0.5}):Play()
    game:GetService("TweenService"):Create(icon, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
    
    -- أنيميشن نبض للأيقونة
    spawn(function()
        while notification.Parent do
            game:GetService("TweenService"):Create(iconFrame, TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                Size = UDim2.new(0, 43, 0, 43)
            }):Play()
            wait(0.8)
            game:GetService("TweenService"):Create(iconFrame, TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                Size = UDim2.new(0, 40, 0, 40)
            }):Play()
            wait(0.8)
        end
    end)
    
    spawn(function()
        wait(duration)
        -- أنيميشن الاختفاء
        local fadeOut = game:GetService("TweenService"):Create(notification, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
            Position = UDim2.new(0.5, 0, 0.85, 60),
            BackgroundTransparency = 1
        })
        local strokeFade = game:GetService("TweenService"):Create(uiStroke, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {Transparency = 1})
        local textFade = game:GetService("TweenService"):Create(notifText, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {TextTransparency = 1})
        local iconFade = game:GetService("TweenService"):Create(iconFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {BackgroundTransparency = 1})
        local iconTextFade = game:GetService("TweenService"):Create(icon, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {TextTransparency = 1})
        
        fadeOut:Play()
        strokeFade:Play()
        textFade:Play()
        iconFade:Play()
        iconTextFade:Play()
        
        fadeOut.Completed:Wait()
        notification:Destroy()
    end)
end

-- إنشاء أنيميشن النص الترحيبي محسن
local function typewriterEffect(text)
    -- إنشاء تأثير الخلفية الضبابية
    local background = Instance.new("Frame")
    background.Name = "WelcomeScreen"
    background.Size = UDim2.new(1, 0, 1, 0)
    background.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    background.BackgroundTransparency = 0.3
    background.BorderSizePixel = 0
    background.Parent = screenGui
    background.ZIndex = 5
    
    -- إضافة تأثير الخلفية المتدرجة
    local uiGradient = Instance.new("UIGradient")
    uiGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 20, 20)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(15, 15, 15)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 10, 10))
    })
    uiGradient.Rotation = 45
    uiGradient.Parent = background
    
    -- إضافة تأثير الضباب
    local blur = Instance.new("BlurEffect")
    blur.Size = 20
    blur.Parent = game:GetService("Lighting")
    
    -- إنشاء وعاء للنص
    local textContainer = Instance.new("Frame")
    textContainer.Name = "TextContainer"
    textContainer.Size = UDim2.new(0.8, 0, 0.2, 0)
    textContainer.Position = UDim2.new(0.1, 0, 0.4, 0)
    textContainer.BackgroundTransparency = 1
    textContainer.ZIndex = 6
    textContainer.Parent = background
    
    -- إنشاء النص الرئيسي
    local welcomeText = Instance.new("TextLabel")
    welcomeText.Name = "WelcomeText"
    welcomeText.Size = UDim2.new(1, 0, 1, 0)
    welcomeText.BackgroundTransparency = 1
    welcomeText.TextColor3 = Color3.fromRGB(255, 0, 0)
    welcomeText.TextSize = 32
    welcomeText.Font = Enum.Font.GothamBold
    welcomeText.Text = ""
    welcomeText.TextWrapped = true
    welcomeText.ZIndex = 7
    welcomeText.Parent = textContainer
    
    -- إضافة تأثير Stroke للنص
    local textStroke = Instance.new("UIStroke")
    textStroke.Color = Color3.fromRGB(255, 100, 100)
    textStroke.Thickness = 1
    textStroke.Transparency = 0.5
    textStroke.Parent = welcomeText
    
    -- إضافة تأثير Glow للنص
    local textShadow = Instance.new("TextLabel")
    textShadow.Name = "TextShadow"
    textShadow.Size = UDim2.new(1, 0, 1, 0)
    textShadow.Position = UDim2.new(0, 2, 0, 2)
    textShadow.BackgroundTransparency = 1
    textShadow.TextColor3 = Color3.fromRGB(150, 0, 0)
    textShadow.TextSize = 32
    textShadow.Font = Enum.Font.GothamBold
    textShadow.Text = ""
    textShadow.TextWrapped = true
    textShadow.TextTransparency = 0.7
    textShadow.ZIndex = 6
    textShadow.Parent = textContainer
    
    -- إضافة خط أفقي تحت النص
    local underline = Instance.new("Frame")
    underline.Name = "Underline"
    underline.Size = UDim2.new(0, 0, 0, 3)
    underline.Position = UDim2.new(0.5, 0, 1.1, 0)
    underline.AnchorPoint = Vector2.new(0.5, 0)
    underline.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    underline.BorderSizePixel = 0
    underline.ZIndex = 7
    underline.Parent = textContainer
    
    -- تأثير الكتابة مع الصوت
    spawn(function()
        for i = 1, #text do
            local currentText = string.sub(text, 1, i)
            welcomeText.Text = currentText
            textShadow.Text = currentText
            
            -- محاكاة صوت الكتابة (قد لا يعمل في جميع المتصفحات)
            if i % 2 == 0 then
                -- يمكن إضافة أصوات هنا إذا كان مسموحًا
            end
            
            wait(0.05)
        end
        
        -- تمديد الخط الأفقي تحت النص
        game:GetService("TweenService"):Create(underline, TweenInfo.new(0.8, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Size = UDim2.new(1, 0, 0, 3)
        }):Play()
        
        wait(1.5)
        
        -- إخفاء شاشة الترحيب
        game:GetService("TweenService"):Create(background, TweenInfo.new(1, Enum.EasingStyle.Quart), {BackgroundTransparency = 1}):Play()
        game:GetService("TweenService"):Create(welcomeText, TweenInfo.new(1, Enum.EasingStyle.Quart), {TextTransparency = 1}):Play()
        game:GetService("TweenService"):Create(textShadow, TweenInfo.new(1, Enum.EasingStyle.Quart), {TextTransparency = 1}):Play()
        game:GetService("TweenService"):Create(textStroke, TweenInfo.new(1, Enum.EasingStyle.Quart), {Transparency = 1}):Play()
        game:GetService("TweenService"):Create(underline, TweenInfo.new(1, Enum.EasingStyle.Quart), {BackgroundTransparency = 1}):Play()
        game:GetService("TweenService"):Create(blur, TweenInfo.new(1, Enum.EasingStyle.Quart), {Size = 0}):Play()
        
        wait(1)
        showLanguageSelector()
        
        wait(0.5)
        background:Destroy()
        blur:Destroy()
    end)
end

-- عرض واجهة اختيار اللغة المحسنة
function showLanguageSelector()
    -- إنشاء وعاء الجزيئات المتحركة في الخلفية
    local particles = createParticles()
    
    -- إضافة تأثير الضباب الخفيف
    local blur = Instance.new("BlurEffect")
    blur.Size = 10
    blur.Parent = game:GetService("Lighting")
    
    -- إطار الواجهة الرئيسي
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "LanguageSelector"
    mainFrame.Size = UDim2.new(0, 400, 0, 250)
    mainFrame.Position = UDim2.new(0.5, -200, 0.5, -125)
    mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    mainFrame.BorderSizePixel = 0
    mainFrame.Parent = screenGui
    mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    mainFrame.ZIndex = 2
    
    -- إضافة تأثير التدرج للخلفية
    local frameGradient = Instance.new("UIGradient")
    frameGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 30, 30)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 15, 15))
    })
    frameGradient.Rotation = 90
    frameGradient.Parent = mainFrame
    
    -- إضافة تأثير الزاوية المدورة
    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(0, 10)
    uiCorner.Parent = mainFrame
    
    -- تأثير الظل
    local uiStroke = Instance.new("UIStroke")
    uiStroke.Color = Color3.fromRGB(255, 0, 0)
    uiStroke.Thickness = 2
    uiStroke.Parent = mainFrame
    
    -- إضافة شعار فوق الواجهة
    local logo = Instance.new("ImageLabel")
    logo.Name = "Logo"
    logo.Size = UDim2.new(0, 50, 0, 50)
    logo.Position = UDim2.new(0.5, 0, 0, -25)
    logo.AnchorPoint = Vector2.new(0.5, 0)
    logo.BackgroundTransparency = 1
    logo.Image = "rbxassetid://6031075938" -- استبدل هذا الرقم بمعرف الصورة المناسبة
    logo.ZIndex = 3
    logo.Parent = mainFrame
    
    -- إطار زخرفي علوي
    local topDecoration = Instance.new("Frame")
    topDecoration.Name = "TopDecoration"
    topDecoration.Size = UDim2.new(0.9, 0, 0, 3)
    topDecoration.Position = UDim2.new(0.05, 0, 0, 10)
    topDecoration.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    topDecoration.BorderSizePixel = 0
    topDecoration.ZIndex = 3
    topDecoration.Parent = mainFrame
    
    local topDecGradient = Instance.new("UIGradient")
    topDecGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 100, 100)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))
    })
    topDecGradient.Parent = topDecoration
    
    -- العنوان
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "TitleLabel"
    titleLabel.Size = UDim2.new(1, 0, 0, 50)
    titleLabel.Position = UDim2.new(0, 0, 0, 15)
    titleLabel.BackgroundTransparency = 1
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.TextSize = 24
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.Text = "هل تريد سكربت بلغة:"
    titleLabel.ZIndex = 3
    titleLabel.Parent = mainFrame
    
    -- إضافة تأثير Glow للعنوان
    local titleStroke = Instance.new("UIStroke")
    titleStroke.Color = Color3.fromRGB(255, 100, 100)
    titleStroke.Thickness = 1
    titleStroke.Transparency = 0.7
    titleStroke.Parent = titleLabel
    
    -- زر اللغة العربية محسن
    local arabicButton = Instance.new("TextButton")
    arabicButton.Name = "ArabicButton"
    arabicButton.Size = UDim2.new(0.35, 0, 0, 50)
    arabicButton.Position = UDim2.new(0.1, 0, 0.5, 0)
    arabicButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    arabicButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    arabicButton.TextSize = 20
    arabicButton.Font = Enum.Font.GothamBold
    arabicButton.Text = "عربي"
    arabicButton.ZIndex = 3
    arabicButton.Parent = mainFrame
    
    local arabicCorner = Instance.new("UICorner")
    arabicCorner.CornerRadius = UDim.new(0, 6)
    arabicCorner.Parent = arabicButton
    
    local arabicStroke = Instance.new("UIStroke")
    arabicStroke.Color = Color3.fromRGB(255, 0, 0)
    arabicStroke.Thickness = 1
    arabicStroke.Transparency = 0.7
    arabicStroke.Parent = arabicButton
    
    local arabicGradient = Instance.new("UIGradient")
    arabicGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(60, 60, 60)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(40, 40, 40))
    })
    arabicGradient.Rotation = 90
    arabicGradient.Parent = arabicButton
    
    -- أيقونة للغة العربية
    local arabicIcon = Instance.new("TextLabel")
    arabicIcon.Name = "ArabicIcon"
    arabicIcon.Size = UDim2.new(0, 30, 0, 30)
    arabicIcon.Position = UDim2.new(0, 10, 0.5, -15)
    arabicIcon.BackgroundTransparency = 1
    arabicIcon.TextColor3 = Color3.fromRGB(255, 100, 100)
    arabicIcon.TextSize = 20
    arabicIcon.Font = Enum.Font.GothamBold
    arabicIcon.Text = "ع"
    arabicIcon.ZIndex = 4
    arabicIcon.Parent = arabicButton
    
    -- النص في الوسط
    local orLabel = Instance.new("TextLabel")
    orLabel.Name = "OrLabel"
    orLabel.Size = UDim2.new(0.1, 0, 0, 50)
    orLabel.Position = UDim2.new(0.45, 0, 0.5, 0)
    orLabel.BackgroundTransparency = 1
    orLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    orLabel.TextSize = 20
    orLabel.Font = Enum.Font.GothamSemibold
    orLabel.Text = "or"
    orLabel.ZIndex = 3
    orLabel.Parent = mainFrame
    
    -- زر اللغة الإنجليزية محسن
    local englishButton = Instance.new("TextButton")
    englishButton.Name = "EnglishButton"
    englishButton.Size = UDim2.new(0.35, 0, 0, 50)
    englishButton.Position = UDim2.new(0.55, 0, 0.5, 0)
    englishButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    englishButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    englishButton.TextSize = 20
    englishButton.Font = Enum.Font.GothamBold
    englishButton.Text = "English"
    englishButton.ZIndex = 3
    englishButton.Parent = mainFrame
    
    local englishCorner = Instance.new("UICorner")
    englishCorner.CornerRadius = UDim.new(0, 6)
    englishCorner.Parent = englishButton
    
    local englishStroke = Instance.new("UIStroke")
    englishStroke.Color = Color3.fromRGB(255, 0, 0)
    englishStroke.Thickness = 1
    englishStroke.Transparency = 0.7
    englishStroke.Parent = englishButton
    
    local englishGradient = Instance.new("UIGradient")
    englishGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(60, 60, 60)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(40, 40, 40))
    })
    englishGradient.Rotation = 90
    englishGradient.Parent = englishButton
    
    -- أيقونة للغة الإنجليزية
    local englishIcon = Instance.new("TextLabel")
    englishIcon.Name = "EnglishIcon"
    englishIcon.Size = UDim2.new(0, 30, 0, 30)
    englishIcon.Position = UDim2.new(0, 10, 0.5, -15)
    englishIcon.BackgroundTransparency = 1
    englishIcon.TextColor3 = Color3.fromRGB(255, 100, 100)
    englishIcon.TextSize = 20
    englishIcon.Font = Enum.Font.GothamBold
    englishIcon.Text = "E"
    englishIcon.ZIndex = 4
    englishIcon.Parent = englishButton
    
    -- إطار زخرفي سفلي
    local bottomDecoration = Instance.new("Frame")
    bottomDecoration.Name = "BottomDecoration"
    bottomDecoration.Size = UDim2.new(0.9, 0, 0, 3)
    bottomDecoration.Position = UDim2.new(0.05, 0, 1, -25)
    bottomDecoration.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    bottomDecoration.BorderSizePixel = 0
    bottomDecoration.ZIndex = 3
    bottomDecoration.Parent = mainFrame
    
    local bottomDecGradient = Instance.new("UIGradient")
    bottomDecGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 100, 100)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))
    })
    bottomDecGradient.Parent = bottomDecoration

    -- معلومات المطور (يسار)
   local scriptInfoLeft = Instance.new("TextLabel")
   scriptInfoLeft.Name = "ScriptInfoLeft"
   scriptInfoLeft.Size = UDim2.new(0.5, -10, 0, 20)
   scriptInfoLeft.Position = UDim2.new(0, 10, 1, -20)
   scriptInfoLeft.BackgroundTransparency = 1
   scriptInfoLeft.TextColor3 = Color3.fromRGB(200, 200, 200)
   scriptInfoLeft.TextSize = 14
   scriptInfoLeft.Font = Enum.Font.Gotham
   scriptInfoLeft.Text = "GUI BY: FRONT-EVIll"
   scriptInfoLeft.TextXAlignment = Enum.TextXAlignment.Left
   scriptInfoLeft.ZIndex = 3
   scriptInfoLeft.Parent = mainFrame
   
   -- معلومات المطور (يمين)
   local scriptInfoRight = Instance.new("TextLabel")
   scriptInfoRight.Name = "ScriptInfoRight"
   scriptInfoRight.Size = UDim2.new(0.5, -10, 0, 20)
   scriptInfoRight.Position = UDim2.new(0.5, 0, 1, -20)
   scriptInfoRight.BackgroundTransparency = 1
   scriptInfoRight.TextColor3 = Color3.fromRGB(200, 200, 200)
   scriptInfoRight.TextSize = 14
   scriptInfoRight.Font = Enum.Font.Gotham
   scriptInfoRight.Text = "The Script By: front-evill / 7sone"
   scriptInfoRight.TextXAlignment = Enum.TextXAlignment.Right
   scriptInfoRight.ZIndex = 3
   scriptInfoRight.Parent = mainFrame
   
   -- إضافة تأثير بريق لعناصر الواجهة
   spawn(function()
       while mainFrame.Parent do
           game:GetService("TweenService"):Create(topDecGradient, TweenInfo.new(2, Enum.EasingStyle.Linear), {
               Offset = Vector2.new(-1, 0)
           }):Play()
           
           game:GetService("TweenService"):Create(bottomDecGradient, TweenInfo.new(2, Enum.EasingStyle.Linear), {
               Offset = Vector2.new(1, 0)
           }):Play()
           
           wait(2)
           
           topDecGradient.Offset = Vector2.new(1, 0)
           bottomDecGradient.Offset = Vector2.new(-1, 0)
           
           game:GetService("TweenService"):Create(topDecGradient, TweenInfo.new(2, Enum.EasingStyle.Linear), {
               Offset = Vector2.new(0, 0)
           }):Play()
           
           game:GetService("TweenService"):Create(bottomDecGradient, TweenInfo.new(2, Enum.EasingStyle.Linear), {
               Offset = Vector2.new(0, 0)
           }):Play()
           
           wait(2)
       end
   end)
   
   -- أنيميشن الظهور
   mainFrame.Position = mainFrame.Position + UDim2.new(0, 0, 0.2, 0)
   mainFrame.BackgroundTransparency = 1
   titleLabel.TextTransparency = 1
   topDecoration.BackgroundTransparency = 1
   bottomDecoration.BackgroundTransparency = 1
   arabicButton.BackgroundTransparency = 1
   arabicButton.TextTransparency = 1
   arabicIcon.TextTransparency = 1
   arabicStroke.Transparency = 1
   orLabel.TextTransparency = 1
   englishButton.BackgroundTransparency = 1
   englishButton.TextTransparency = 1
   englishIcon.TextTransparency = 1
   englishStroke.Transparency = 1
   scriptInfoLeft.TextTransparency = 1
   scriptInfoRight.TextTransparency = 1
   uiStroke.Transparency = 1
   titleStroke.Transparency = 1
   logo.ImageTransparency = 1
   
   -- تأثير الظهور المتتابع
   game:GetService("TweenService"):Create(mainFrame, TweenInfo.new(0.8, Enum.EasingStyle.Bounce), {
       Position = UDim2.new(0.5, -200, 0.5, -125), 
       BackgroundTransparency = 0
   }):Play()
   wait(0.1)
   
   game:GetService("TweenService"):Create(logo, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {
       ImageTransparency = 0
   }):Play()
   wait(0.1)
   
   game:GetService("TweenService"):Create(topDecoration, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {
       BackgroundTransparency = 0
   }):Play()
   wait(0.1)
   
   game:GetService("TweenService"):Create(titleLabel, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {
       TextTransparency = 0
   }):Play()
   game:GetService("TweenService"):Create(titleStroke, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {
       Transparency = 0.7
   }):Play()
   wait(0.1)
   
   game:GetService("TweenService"):Create(arabicButton, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {
       BackgroundTransparency = 0, 
       TextTransparency = 0
   }):Play()
   game:GetService("TweenService"):Create(arabicIcon, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {
       TextTransparency = 0
   }):Play()
   game:GetService("TweenService"):Create(arabicStroke, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {
       Transparency = 0.7
   }):Play()
   wait(0.1)
   
   game:GetService("TweenService"):Create(orLabel, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {
       TextTransparency = 0
   }):Play()
   wait(0.1)
   
   game:GetService("TweenService"):Create(englishButton, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {
       BackgroundTransparency = 0, 
       TextTransparency = 0
   }):Play()
   game:GetService("TweenService"):Create(englishIcon, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {
       TextTransparency = 0
   }):Play()
   game:GetService("TweenService"):Create(englishStroke, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {
       Transparency = 0.7
   }):Play()
   wait(0.1)
   
   game:GetService("TweenService"):Create(bottomDecoration, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {
       BackgroundTransparency = 0
   }):Play()
   wait(0.1)
   
   game:GetService("TweenService"):Create(scriptInfoLeft, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {
       TextTransparency = 0
   }):Play()
   game:GetService("TweenService"):Create(scriptInfoRight, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {
       TextTransparency = 0
   }):Play()
   game:GetService("TweenService"):Create(uiStroke, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {
       Transparency = 0
   }):Play()
   
   -- تأثيرات التحويم المحسنة
   arabicButton.MouseEnter:Connect(function()
       game:GetService("TweenService"):Create(arabicButton, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {
           BackgroundColor3 = Color3.fromRGB(255, 0, 0),
           Size = UDim2.new(0.37, 0, 0, 55)
       }):Play()
       
       game:GetService("TweenService"):Create(arabicIcon, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {
           TextSize = 24,
           TextColor3 = Color3.fromRGB(255, 255, 255)
       }):Play()
   end)
   
   arabicButton.MouseLeave:Connect(function()
       game:GetService("TweenService"):Create(arabicButton, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {
           BackgroundColor3 = Color3.fromRGB(40, 40, 40),
           Size = UDim2.new(0.35, 0, 0, 50)
       }):Play()
       
       game:GetService("TweenService"):Create(arabicIcon, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {
           TextSize = 20,
           TextColor3 = Color3.fromRGB(255, 100, 100)
       }):Play()
   end)
   
   englishButton.MouseEnter:Connect(function()
       game:GetService("TweenService"):Create(englishButton, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {
           BackgroundColor3 = Color3.fromRGB(255, 0, 0),
           Size = UDim2.new(0.37, 0, 0, 55)
       }):Play()
       
       game:GetService("TweenService"):Create(englishIcon, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {
           TextSize = 24,
           TextColor3 = Color3.fromRGB(255, 255, 255)
       }):Play()
   end)
   
   englishButton.MouseLeave:Connect(function()
       game:GetService("TweenService"):Create(englishButton, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {
           BackgroundColor3 = Color3.fromRGB(40, 40, 40),
           Size = UDim2.new(0.35, 0, 0, 50)
       }):Play()
       
       game:GetService("TweenService"):Create(englishIcon, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {
           TextSize = 20,
           TextColor3 = Color3.fromRGB(255, 100, 100)
       }):Play()
   end)
   
   -- وظائف الأزرار المحسنة
   arabicButton.MouseButton1Click:Connect(function()
       -- تأثير النقر
       game:GetService("TweenService"):Create(arabicButton, TweenInfo.new(0.1, Enum.EasingStyle.Quart), {
           BackgroundColor3 = Color3.fromRGB(200, 0, 0),
           Size = UDim2.new(0.33, 0, 0, 45)
       }):Play()
       
       wait(0.1)
       
       game:GetService("TweenService"):Create(arabicButton, TweenInfo.new(0.1, Enum.EasingStyle.Quart), {
           BackgroundColor3 = Color3.fromRGB(255, 0, 0),
           Size = UDim2.new(0.35, 0, 0, 50)
       }):Play()
       
       -- أنيميشن الاختفاء
       wait(0.2)
       
       local mainFrameMotion = game:GetService("TweenService"):Create(mainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
           Position = UDim2.new(0.5, -200, 1.5, 0), 
           BackgroundTransparency = 1,
           Rotation = 5
       })
       
       mainFrameMotion:Play()
       game:GetService("TweenService"):Create(uiStroke, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {
           Transparency = 1
       }):Play()
       
       -- إنشاء إشعار مخصص مع أيقونة العربية
       createNotification("تم تشغيل السكربت باللغة العربية ✓", 5)
       
       -- تحميل السكربت العربي
       wait(0.5)
       loadstring(game:HttpGet("https://raw.githubusercontent.com/Front-Evill/Script-Hub/refs/heads/main/Arabic.lua"))()
       
       -- التنظيف
       wait(0.5)
       particles:Destroy()
       blur:Destroy()
       mainFrame:Destroy()
   end)
   
   englishButton.MouseButton1Click:Connect(function()
       -- تأثير النقر
       game:GetService("TweenService"):Create(englishButton, TweenInfo.new(0.1, Enum.EasingStyle.Quart), {
           BackgroundColor3 = Color3.fromRGB(200, 0, 0),
           Size = UDim2.new(0.33, 0, 0, 45)
       }):Play()
       
       wait(0.1)
       
       game:GetService("TweenService"):Create(englishButton, TweenInfo.new(0.1, Enum.EasingStyle.Quart), {
           BackgroundColor3 = Color3.fromRGB(255, 0, 0),
           Size = UDim2.new(0.35, 0, 0, 50)
       }):Play()
       
       -- أنيميشن الاختفاء
       wait(0.2)
       
       local mainFrameMotion = game:GetService("TweenService"):Create(mainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
           Position = UDim2.new(0.5, -200, 1.5, 0), 
           BackgroundTransparency = 1,
           Rotation = -5
       })
       
       mainFrameMotion:Play()
       game:GetService("TweenService"):Create(uiStroke, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {
           Transparency = 1
       }):Play()
       
       createNotification("Script launched in English ✓", 5)
       
       wait(0.5)
       loadstring(game:HttpGet("https://raw.githubusercontent.com/Front-Evill/Script-Hub/refs/heads/main/F-150.lua"))()
       
       wait(0.5)
       particles:Destroy()
       blur:Destroy()
       mainFrame:Destroy()
   end)
   
   local exitButton = Instance.new("TextButton")
   exitButton.Name = "ExitButton"
   exitButton.Size = UDim2.new(0, 30, 0, 30)
   exitButton.Position = UDim2.new(1, -15, 0, 15)
   exitButton.AnchorPoint = Vector2.new(1, 0.5)
   exitButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
   exitButton.TextColor3 = Color3.fromRGB(255, 255, 255)
   exitButton.TextSize = 18
   exitButton.Font = Enum.Font.GothamBold
   exitButton.Text = "X"
   exitButton.ZIndex = 4
   exitButton.Parent = mainFrame
   
   local exitCorner = Instance.new("UICorner")
   exitCorner.CornerRadius = UDim.new(1, 0)
   exitCorner.Parent = exitButton
   
   local exitStroke = Instance.new("UIStroke")
   exitStroke.Color = Color3.fromRGB(255, 0, 0)
   exitStroke.Thickness = 1
   exitStroke.Transparency = 0.7
   exitStroke.Parent = exitButton
   
   exitButton.MouseEnter:Connect(function()
       game:GetService("TweenService"):Create(exitButton, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {
           BackgroundColor3 = Color3.fromRGB(255, 0, 0),
           Size = UDim2.new(0, 35, 0, 35)
       }):Play()
   end)
   
   exitButton.MouseLeave:Connect(function()
       game:GetService("TweenService"):Create(exitButton, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {
           BackgroundColor3 = Color3.fromRGB(40, 40, 40),
           Size = UDim2.new(0, 30, 0, 30)
       }):Play()
   end)
   
   exitButton.MouseButton1Click:Connect(function()
       -- تأثير النقر
       game:GetService("TweenService"):Create(exitButton, TweenInfo.new(0.1, Enum.EasingStyle.Quart), {
           BackgroundColor3 = Color3.fromRGB(200, 0, 0),
           Size = UDim2.new(0, 28, 0, 28)
       }):Play()
       
       wait(0.1)
       
       local mainFrameMotion = game:GetService("TweenService"):Create(mainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
           Size = UDim2.new(0, 0, 0, 0),
           Position = UDim2.new(0.5, 0, 0.5, 0),
           BackgroundTransparency = 1
       })
       
       mainFrameMotion:Play()
       game:GetService("TweenService"):Create(uiStroke, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {
           Transparency = 1
       }):Play()
       
       wait(0.5)
       particles:Destroy()
       blur:Destroy()
       mainFrame:Destroy()
       createNotification("Script cancelled", 3)
   end)
   
   spawn(function()
       while mainFrame.Parent do
           game:GetService("TweenService"):Create(logo, TweenInfo.new(10, Enum.EasingStyle.Linear), {
               Rotation = logo.Rotation + 360
           }):Play()
           
           wait(10)
       end
   end)
end

typewriterEffect("Welcome to script front evill")
