local player = game.Players.LocalPlayer
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "FrontEvillGUI_Enhanced"
screenGui.ResetOnSpawn = false

if syn then
    syn.protect_gui(screenGui)
    screenGui.Parent = game:GetService("CoreGui")
elseif gethui then
    screenGui.Parent = gethui()
else
    screenGui.Parent = player.PlayerGui
end

-- تحسين الأيقونات باستخدام أيقونات أفضل (يمكنك استبدالها بأيقونات حقيقية)
local scriptIcon = "rbxassetid://130714468148923"
local arabicIcon = "rbxassetid://109597213480889"
local englishIcon = "rbxassetid://113626041682134"

-- إضافة تأثيرات ألوان وخلفيات جميلة
local mainColor = Color3.fromRGB(255, 0, 0)      -- اللون الرئيسي (أحمر)
local accentColor = Color3.fromRGB(230, 30, 30)  -- لون ثانوي (أحمر داكن)
local darkColor = Color3.fromRGB(20, 20, 20)     -- خلفية داكنة
local buttonColor = Color3.fromRGB(35, 35, 35)   -- لون الأزرار

-- تحسين الإشعارات بتصميم أجمل
local function createNotification(text, duration)
    duration = duration or 3
    
    local notification = Instance.new("Frame")
    notification.Name = "EnhancedNotification"
    notification.Size = UDim2.new(0, 300, 0, 80)
    notification.Position = UDim2.new(0.5, -150, 0.85, 0)
    notification.BackgroundColor3 = darkColor
    notification.BorderSizePixel = 0
    notification.BackgroundTransparency = 0.1
    notification.Parent = screenGui
    
    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(0, 12)
    uiCorner.Parent = notification
    
    -- إضافة تأثير ظل للإشعار
    local shadow = Instance.new("ImageLabel")
    shadow.Name = "Shadow"
    shadow.AnchorPoint = Vector2.new(0.5, 0.5)
    shadow.BackgroundTransparency = 1
    shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
    shadow.Size = UDim2.new(1, 24, 1, 24)
    shadow.ZIndex = -1
    shadow.Image = "rbxassetid://6014261993"
    shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    shadow.ImageTransparency = 0.5
    shadow.ScaleType = Enum.ScaleType.Slice
    shadow.SliceCenter = Rect.new(49, 49, 450, 450)
    shadow.Parent = notification
    
    local uiStroke = Instance.new("UIStroke")
    uiStroke.Color = mainColor
    uiStroke.Thickness = 2.5
    uiStroke.Parent = notification
    
    -- إضافة تدرج لوني للإشعار
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 30, 30)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(25, 25, 25))
    })
    gradient.Rotation = 45
    gradient.Parent = notification
    
    local iconImage = Instance.new("ImageLabel")
    iconImage.Name = "NotifIcon"
    iconImage.Size = UDim2.new(0, 45, 0, 45)
    iconImage.Position = UDim2.new(0, 15, 0.5, -22.5)
    iconImage.BackgroundTransparency = 1
    iconImage.Image = scriptIcon
    iconImage.Parent = notification
    
    -- إضافة تأثير دائري للأيقونة
    local iconCorner = Instance.new("UICorner")
    iconCorner.CornerRadius = UDim.new(1, 0)
    iconCorner.Parent = iconImage
    
    -- إضافة إطار للأيقونة
    local iconStroke = Instance.new("UIStroke")
    iconStroke.Color = mainColor
    iconStroke.Thickness = 2
    iconStroke.Parent = iconImage
    
    local notifText = Instance.new("TextLabel")
    notifText.Name = "NotifText"
    notifText.Size = UDim2.new(1, -80, 1, -20)
    notifText.Position = UDim2.new(0, 70, 0, 10)
    notifText.BackgroundTransparency = 1
    notifText.TextColor3 = Color3.fromRGB(255, 255, 255)
    notifText.TextSize = 18
    notifText.Font = Enum.Font.GothamBold
    notifText.Text = text
    notifText.TextWrapped = true
    notifText.TextXAlignment = Enum.TextXAlignment.Left
    notifText.Parent = notification
    
    -- إضافة شريط تقدم للإشعار
    local progressBar = Instance.new("Frame")
    progressBar.Name = "ProgressBar"
    progressBar.Size = UDim2.new(1, -20, 0, 3)
    progressBar.Position = UDim2.new(0, 10, 1, -10)
    progressBar.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    progressBar.BorderSizePixel = 0
    progressBar.Parent = notification
    
    local progressFill = Instance.new("Frame")
    progressFill.Name = "ProgressFill"
    progressFill.Size = UDim2.new(1, 0, 1, 0)
    progressFill.BackgroundColor3 = mainColor
    progressFill.BorderSizePixel = 0
    progressFill.Parent = progressBar
    
    -- تأثيرات ظهور الإشعار
    notification.BackgroundTransparency = 1
    uiStroke.Transparency = 1
    notifText.TextTransparency = 1
    iconImage.ImageTransparency = 1
    shadow.ImageTransparency = 1
    progressBar.BackgroundTransparency = 1
    progressFill.BackgroundTransparency = 1
    iconStroke.Transparency = 1
    
    -- تحريك الإشعار بطريقة أكثر احترافية
    notification.Position = UDim2.new(1.1, 0, 0.85, 0)
    
    game:GetService("TweenService"):Create(notification, TweenInfo.new(0.7, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = UDim2.new(0.5, -150, 0.85, 0), BackgroundTransparency = 0.1}):Play()
    game:GetService("TweenService"):Create(uiStroke, TweenInfo.new(0.7, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Transparency = 0}):Play()
    game:GetService("TweenService"):Create(notifText, TweenInfo.new(0.7, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
    game:GetService("TweenService"):Create(iconImage, TweenInfo.new(0.7, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {ImageTransparency = 0}):Play()
    game:GetService("TweenService"):Create(shadow, TweenInfo.new(0.7, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {ImageTransparency = 0.5}):Play()
    game:GetService("TweenService"):Create(progressBar, TweenInfo.new(0.7, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {BackgroundTransparency = 0}):Play()
    game:GetService("TweenService"):Create(progressFill, TweenInfo.new(0.7, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {BackgroundTransparency = 0}):Play()
    game:GetService("TweenService"):Create(iconStroke, TweenInfo.new(0.7, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Transparency = 0}):Play()
    
    -- تأثير شريط التقدم
    game:GetService("TweenService"):Create(progressFill, TweenInfo.new(duration, Enum.EasingStyle.Linear), {Size = UDim2.new(0, 0, 1, 0)}):Play()
    
    spawn(function()
        wait(duration)
        -- تأثير اختفاء الإشعار
        local fadeOut = game:GetService("TweenService"):Create(notification, TweenInfo.new(0.7, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Position = UDim2.new(-0.3, 0, 0.85, 0), BackgroundTransparency = 1})
        local strokeFade = game:GetService("TweenService"):Create(uiStroke, TweenInfo.new(0.7, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {Transparency = 1})
        local textFade = game:GetService("TweenService"):Create(notifText, TweenInfo.new(0.7, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {TextTransparency = 1})
        local iconFade = game:GetService("TweenService"):Create(iconImage, TweenInfo.new(0.7, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {ImageTransparency = 1})
        local shadowFade = game:GetService("TweenService"):Create(shadow, TweenInfo.new(0.7, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {ImageTransparency = 1})
        local progressBarFade = game:GetService("TweenService"):Create(progressBar, TweenInfo.new(0.7, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {BackgroundTransparency = 1})
        local iconStrokeFade = game:GetService("TweenService"):Create(iconStroke, TweenInfo.new(0.7, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {Transparency = 1})
        
        fadeOut:Play()
        strokeFade:Play()
        textFade:Play()
        iconFade:Play()
        shadowFade:Play()
        progressBarFade:Play()
        iconStrokeFade:Play()
        
        fadeOut.Completed:Wait()
        notification:Destroy()
    end)
end

-- تحسين تأثير مقدمة الواجهة
local function typewriterEffect(text)
    local background = Instance.new("Frame")
    background.Name = "EnhancedWelcomeScreen"
    background.Size = UDim2.new(1, 0, 1, 0)
    background.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    background.BackgroundTransparency = 1
    background.BorderSizePixel = 0
    background.Parent = screenGui
    
    -- إضافة تأثير خلفية متحركة للمقدمة
    local backgroundPattern = Instance.new("ImageLabel")
    backgroundPattern.Name = "BackgroundPattern"
    backgroundPattern.Size = UDim2.new(1.2, 0, 1.2, 0)
    backgroundPattern.Position = UDim2.new(-0.1, 0, -0.1, 0)
    backgroundPattern.BackgroundTransparency = 1
    backgroundPattern.Image = "rbxassetid://6372755229"
    backgroundPattern.ImageColor3 = Color3.fromRGB(30, 30, 30)
    backgroundPattern.ImageTransparency = 1
    backgroundPattern.ScaleType = Enum.ScaleType.Tile
    backgroundPattern.TileSize = UDim2.new(0, 200, 0, 200)
    backgroundPattern.Parent = background
    
    -- تأثير تدرج للخلفية
    local backgroundGradient = Instance.new("UIGradient")
    backgroundGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(15, 15, 15)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))
    })
    backgroundGradient.Rotation = 45
    backgroundGradient.Parent = background
    
    game:GetService("TweenService"):Create(background, TweenInfo.new(1, Enum.EasingStyle.Quart), {BackgroundTransparency = 0.2}):Play()
    game:GetService("TweenService"):Create(backgroundPattern, TweenInfo.new(1, Enum.EasingStyle.Quart), {ImageTransparency = 0.7}):Play()
    
    -- تحسين تأثير الضبابية
    local blur = Instance.new("BlurEffect")
    blur.Size = 0
    blur.Parent = game:GetService("Lighting")
    
    game:GetService("TweenService"):Create(blur, TweenInfo.new(1, Enum.EasingStyle.Quart), {Size = 25}):Play()
    
    -- تحريك نمط الخلفية ببطء للحصول على تأثير حركي
    spawn(function()
        while background.Parent do
            game:GetService("TweenService"):Create(backgroundPattern, TweenInfo.new(8, Enum.EasingStyle.Linear), {Position = UDim2.new(0.1, 0, 0.1, 0)}):Play()
            wait(8)
            game:GetService("TweenService"):Create(backgroundPattern, TweenInfo.new(8, Enum.EasingStyle.Linear), {Position = UDim2.new(-0.1, 0, -0.1, 0)}):Play()
            wait(8)
        end
    end)
    
    -- تحسين تأثير الشعار
    local logoContainer = Instance.new("Frame")
    logoContainer.Name = "LogoContainer"
    logoContainer.Size = UDim2.new(0, 150, 0, 150)
    logoContainer.Position = UDim2.new(0.5, -75, 0.25, -75)
    logoContainer.BackgroundTransparency = 1
    logoContainer.Parent = background
    
    local logoGlow = Instance.new("ImageLabel")
    logoGlow.Name = "LogoGlow"
    logoGlow.Size = UDim2.new(1.5, 0, 1.5, 0)
    logoGlow.Position = UDim2.new(-0.25, 0, -0.25, 0)
    logoGlow.BackgroundTransparency = 1
    logoGlow.Image = "rbxassetid://6072996363"
    logoGlow.ImageColor3 = mainColor
    logoGlow.ImageTransparency = 1
    logoGlow.Parent = logoContainer
    
    local logoImage = Instance.new("ImageLabel")
    logoImage.Name = "LogoImage"
    logoImage.Size = UDim2.new(1, 0, 1, 0)
    logoImage.Position = UDim2.new(0, 0, 0, 0)
    logoImage.BackgroundTransparency = 1
    logoImage.Image = scriptIcon
    logoImage.ImageTransparency = 1
    logoImage.Parent = logoContainer
    
    -- إضافة تأثير دوران للشعار
    spawn(function()
        local rotation = 0
        while logoImage.Parent do
            rotation = rotation + 1
            if rotation > 360 then rotation = 0 end
            logoGlow.Rotation = rotation
            wait()
        end
    end)
    
    -- تحسين النص الترحيبي
    local welcomeTextContainer = Instance.new("Frame")
    welcomeTextContainer.Name = "WelcomeTextContainer"
    welcomeTextContainer.Size = UDim2.new(0.8, 0, 0.2, 0)
    welcomeTextContainer.Position = UDim2.new(0.1, 0, 0.45, 0)
    welcomeTextContainer.BackgroundTransparency = 1
    welcomeTextContainer.Parent = background
    
    local welcomeText = Instance.new("TextLabel")
    welcomeText.Name = "WelcomeText"
    welcomeText.Size = UDim2.new(1, 0, 1, 0)
    welcomeText.BackgroundTransparency = 1
    welcomeText.TextColor3 = Color3.fromRGB(255, 255, 255)
    welcomeText.TextSize = 40
    welcomeText.Font = Enum.Font.GothamBold
    welcomeText.Text = ""
    welcomeText.TextWrapped = true
    welcomeText.Parent = welcomeTextContainer
    
    -- إضافة تأثير ظل للنص
    local textShadow = Instance.new("TextLabel")
    textShadow.Name = "TextShadow"
    textShadow.Size = UDim2.new(1, 0, 1, 0)
    textShadow.Position = UDim2.new(0, 2, 0, 2)
    textShadow.BackgroundTransparency = 1
    textShadow.TextColor3 = mainColor
    textShadow.TextSize = 40
    textShadow.Font = Enum.Font.GothamBold
    textShadow.Text = ""
    textShadow.TextWrapped = true
    textShadow.ZIndex = -1
    textShadow.Parent = welcomeTextContainer
    
    -- تحسين النص الفرعي
    local subText = Instance.new("TextLabel")
    subText.Name = "SubText"
    subText.Size = UDim2.new(0.7, 0, 0.1, 0)
    subText.Position = UDim2.new(0.15, 0, 0.62, 0)
    subText.BackgroundTransparency = 1
    subText.TextColor3 = Color3.fromRGB(200, 200, 200)
    subText.TextSize = 24
    subText.Font = Enum.Font.Gotham
    subText.Text = "Created by Front-Evill"
    subText.TextTransparency = 1
    subText.Parent = background
    
    -- إضافة خط تحت النص الفرعي
    local underline = Instance.new("Frame")
    underline.Name = "Underline"
    underline.Size = UDim2.new(0, 0, 0, 3)
    underline.Position = UDim2.new(0.5, 0, 1, 5)
    underline.AnchorPoint = Vector2.new(0.5, 0)
    underline.BackgroundColor3 = mainColor
    underline.BorderSizePixel = 0
    underline.Parent = subText
    
    -- تأثيرات الظهور
    game:GetService("TweenService"):Create(logoGlow, TweenInfo.new(1.5, Enum.EasingStyle.Quart), {ImageTransparency = 0.5}):Play()
    game:GetService("TweenService"):Create(logoImage, TweenInfo.new(1, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {ImageTransparency = 0}):Play()
    
    game:GetService("TweenService"):Create(subText, TweenInfo.new(1, Enum.EasingStyle.Quart), {TextTransparency = 0}):Play()
    wait(0.2)
    game:GetService("TweenService"):Create(underline, TweenInfo.new(1, Enum.EasingStyle.Quart), {Size = UDim2.new(0.5, 0, 0, 3)}):Play()
    
    -- تأثير الكتابة المحسن
    spawn(function()
        for i = 1, #text do
            welcomeText.Text = string.sub(text, 1, i)
            textShadow.Text = string.sub(text, 1, i)
            
            -- إضافة تأثير صوتي (اختياري، يمكن إزالته)
            if i % 3 == 0 then
                local typeSound = Instance.new("Sound")
                typeSound.Volume = 0.1
                typeSound.SoundId = "rbxassetid://4681278859"
                typeSound.Parent = welcomeText
                typeSound:Play()
                game:GetService("Debris"):AddItem(typeSound, 1)
            end
            
            wait(0.03)
        end
        
        wait(1.5)
        
        -- تأثير اختفاء تدريجي
        game:GetService("TweenService"):Create(background, TweenInfo.new(1, Enum.EasingStyle.Quart), {BackgroundTransparency = 1}):Play()
        game:GetService("TweenService"):Create(welcomeText, TweenInfo.new(1, Enum.EasingStyle.Quart), {TextTransparency = 1}):Play()
        game:GetService("TweenService"):Create(textShadow, TweenInfo.new(1, Enum.EasingStyle.Quart), {TextTransparency = 1}):Play()
        game:GetService("TweenService"):Create(logoImage, TweenInfo.new(1, Enum.EasingStyle.Quart), {ImageTransparency = 1}):Play()
        game:GetService("TweenService"):Create(logoGlow, TweenInfo.new(1, Enum.EasingStyle.Quart), {ImageTransparency = 1}):Play()
        game:GetService("TweenService"):Create(subText, TweenInfo.new(1, Enum.EasingStyle.Quart), {TextTransparency = 1}):Play()
        game:GetService("TweenService"):Create(underline, TweenInfo.new(1, Enum.EasingStyle.Quart), {BackgroundTransparency = 1}):Play()
        game:GetService("TweenService"):Create(backgroundPattern, TweenInfo.new(1, Enum.EasingStyle.Quart), {ImageTransparency = 1}):Play()
        game:GetService("TweenService"):Create(blur, TweenInfo.new(1, Enum.EasingStyle.Quart), {Size = 0}):Play()
        
        wait(1)
        showLanguageSelector()
        
        wait(0.5)
        background:Destroy()
        blur:Destroy()
    end)
end

-- تحسين واجهة اختيار اللغة
function showLanguageSelector()
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "EnhancedLanguageSelector"
    mainFrame.Size = UDim2.new(0, 480, 0, 320)
    mainFrame.Position = UDim2.new(0.5, -240, 0.5, -160)
    mainFrame.BackgroundColor3 = darkColor
    mainFrame.BorderSizePixel = 0
    mainFrame.Parent = screenGui
    mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    
    -- إضافة تأثير ظل للإطار الرئيسي
    local mainShadow = Instance.new("ImageLabel")
    mainShadow.Name = "MainShadow"
    mainShadow.AnchorPoint = Vector2.new(0.5, 0.5)
    mainShadow.BackgroundTransparency = 1
    mainShadow.Position = UDim2.new(0.5, 0, 0.5, 0)
    mainShadow.Size = UDim2.new(1, 30, 1, 30)
    mainShadow.ZIndex = -1
    mainShadow.Image = "rbxassetid://6014261993"
    mainShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    mainShadow.ImageTransparency = 0.5
    mainShadow.ScaleType = Enum.ScaleType.Slice
    mainShadow.SliceCenter = Rect.new(49, 49, 450, 450)
    mainShadow.Parent = mainFrame
    
    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(0, 15)
    uiCorner.Parent = mainFrame
    
    -- تحسين تدرج الخلفية
    local bgGradient = Instance.new("UIGradient")
    bgGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 30, 30)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 15, 15))
    })
    bgGradient.Rotation = 45
    bgGradient.Parent = mainFrame
    
    local uiStroke = Instance.new("UIStroke")
    uiStroke.Color = mainColor
    uiStroke.Thickness = 2.5
    uiStroke.Parent = mainFrame
    
    -- إضافة نمط جميل للخلفية
    local patternImage = Instance.new("ImageLabel")
    patternImage.Name = "PatternImage"
    patternImage.Size = UDim2.new(1, 0, 1, 0)
    patternImage.BackgroundTransparency = 1
    patternImage.Image = "rbxassetid://6372755229"
    patternImage.ImageColor3 = Color3.fromRGB(255, 255, 255)
    patternImage.ImageTransparency = 0.92
    patternImage.ScaleType = Enum.ScaleType.Tile
    patternImage.TileSize = UDim2.new(0, 100, 0, 100)
    patternImage.Parent = mainFrame
    
    -- تحسين أيقونة العنوان
    local topIconContainer = Instance.new("Frame")
    topIconContainer.Name = "TopIconContainer"
    topIconContainer.Size = UDim2.new(0, 80, 0, 80)
    topIconContainer.Position = UDim2.new(0.5, -40, 0, 25)
    topIconContainer.BackgroundTransparency = 1
    topIconContainer.Parent = mainFrame
    
    local iconGlow = Instance.new("ImageLabel")
    iconGlow.Name = "IconGlow"
    iconGlow.Size = UDim2.new(1.5, 0, 1.5, 0)
    iconGlow.Position = UDim2.new(-0.25, 0, -0.25, 0)
    iconGlow.BackgroundTransparency = 1
    iconGlow.Image = "rbxassetid://6072996363"
    iconGlow.ImageColor3 = mainColor
    iconGlow.ImageTransparency = 0.5
    iconGlow.Parent = topIconContainer
    
    local topIcon = Instance.new("ImageLabel")
    topIcon.Name = "TopIcon"
    topIcon.Size = UDim2.new(1, 0, 1, 0)
    topIcon.BackgroundTransparency = 1
    topIcon.Image = scriptIcon
    topIcon.Parent = topIconContainer
    
    -- تأثير دوران للأيقونة
    spawn(function()
        local rotation = 0
        while topIcon.Parent do
            rotation = rotation + 0.5
            if rotation > 360 then rotation = 0 end
            iconGlow.Rotation = rotation
            wait()
        end
    end)
    
    -- تحسين عنوان الواجهة
    local titleContainer = Instance.new("Frame")
    titleContainer.Name = "TitleContainer"
    titleContainer.Size = UDim2.new(1, 0, 0, 60)
    titleContainer.Position = UDim2.new(0, 0, 0, 110)
    titleContainer.BackgroundTransparency = 1
    titleContainer.Parent = mainFrame
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "TitleLabel"
    titleLabel.Size = UDim2.new(1, 0, 1, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.TextSize = 28
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.Text = "Select Your Language"
    titleLabel.Parent = titleContainer
    
    -- إضافة خط أنيق تحت العنوان
    local titleUnderline = Instance.new("Frame")
    titleUnderline.Name = "TitleUnderline"
    titleUnderline.Size = UDim2.new(0, 0, 0, 3)
    titleUnderline.Position = UDim2.new(0.5, 0, 1, 0)
    titleUnderline.AnchorPoint = Vector2.new(0.5, 0)
    titleUnderline.BackgroundColor3 = mainColor
    titleUnderline.BorderSizePixel = 0
    titleUnderline.Parent = titleContainer
    
    -- تحسين زر اللغة العربية
    local arabicButton = Instance.new("Frame")
    arabicButton.Name = "ArabicButton"
    arabicButton.Size = UDim2.new(0.42, 0, 0, 75)
    arabicButton.Position = UDim2.new(0.07, 0, 0.55, 0)
    arabicButton.BackgroundColor3 = buttonColor
    arabicButton.Parent = mainFrame
    
    local arabicCorner = Instance.new("UICorner")
    arabicCorner.CornerRadius = UDim.new(0, 12)
    arabicCorner.Parent = arabicButton
    
    -- إضافة تأثيرات للزر
    local arabicStroke = Instance.new("UIStroke")
    arabicStroke.Color = Color3.fromRGB(70, 70, 70)
    arabicStroke.Thickness = 1.5
    arabicStroke.Parent = arabicButton
    
    -- إضافة تدرج لوني للزر
    local arabicGradient = Instance.new("UIGradient")
    arabicGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(45, 45, 45)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(35, 35, 35))
    })
    arabicGradient.Rotation = 90
    arabicGradient.Parent = arabicButton
    
    -- تحسين الأيقونة
    local arabicIconBg = Instance.new("Frame")
    arabicIconBg.Name = "ArabicIconBg"
    arabicIconBg.Size = UDim2.new(0, 45, 0, 45)
    arabicIconBg.Position = UDim2.new(0, 15, 0.5, -22.5)
    arabicIconBg.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    arabicIconBg.Parent = arabicButton
    
    local arabicIconCorner = Instance.new("UICorner")
    arabicIconCorner.CornerRadius = UDim.new(1, 0)
    arabicIconCorner.Parent = arabicIconBg
    
    local arabicIconImage = Instance.new("ImageLabel")
    arabicIconImage.Name = "ArabicIcon"
    arabicIconImage.Size = UDim2.new(0.8, 0, 0.8, 0)
    arabicIconImage.Position = UDim2.new(0.1, 0, 0.1, 0)
    arabicIconImage.BackgroundTransparency = 1
    arabicIconImage.Image = arabicIcon
    arabicIconImage.Parent = arabicIconBg
    
    local arabicText = Instance.new("TextLabel")
    arabicText.Name = "ArabicText"
    arabicText.Size = UDim2.new(1, -75, 1, -20)
    arabicText.Position = UDim2.new(0, 70, 0, 10)
    arabicText.BackgroundTransparency = 1
    arabicText.TextColor3 = Color3.fromRGB(255, 255, 255)
    arabicText.TextSize = 22
    arabicText.Font = Enum.Font.GothamBold
    arabicText.Text = "العربية"
    arabicText.TextXAlignment = Enum.TextXAlignment.Left
    arabicText.Parent = arabicButton
    
    -- إضافة نص إضافي تحت النص الرئيسي
    local arabicSubtext = Instance.new("TextLabel")
    arabicSubtext.Name = "ArabicSubtext"
    arabicSubtext.Size = UDim2.new(1, -75, 0, 20)
    arabicSubtext.Position = UDim2.new(0, 70, 1, -30)
    arabicSubtext.BackgroundTransparency = 1
    arabicSubtext.TextColor3 = Color3.fromRGB(180, 180, 180)
    arabicSubtext.TextSize = 14
    arabicSubtext.Font = Enum.Font.Gotham
    arabicSubtext.Text = "اختر اللغة العربية"
    arabicSubtext.TextXAlignment = Enum.TextXAlignment.Left
    arabicSubtext.Parent = arabicButton
    
    local arabicClickDetector = Instance.new("TextButton")
    arabicClickDetector.Name = "ArabicClickDetector"
    arabicClickDetector.Size = UDim2.new(1, 0, 1, 0)
    arabicClickDetector.BackgroundTransparency = 1
    arabicClickDetector.Text = ""
    arabicClickDetector.Parent = arabicButton
    
    -- تحسين فاصل "أو"
    local orLabel = Instance.new("TextLabel")
    orLabel.Name = "OrLabel"
    orLabel.Size = UDim2.new(0.1, 0, 0, 40)
    orLabel.Position = UDim2.new(0.45, 0, 0.55, 17.5)
    orLabel.BackgroundTransparency = 1
    orLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
    orLabel.TextSize = 18
    orLabel.Font = Enum.Font.GothamBold
    orLabel.Text = "OR"
    orLabel.Parent = mainFrame
    
    -- إضافة خطوط زخرفية حول "أو"
    local leftLine = Instance.new("Frame")
    leftLine.Name = "LeftLine"
    leftLine.Size = UDim2.new(0.12, 0, 0, 2)
    leftLine.Position = UDim2.new(0.33, 0, 0.55, 20)
    leftLine.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    leftLine.BorderSizePixel = 0
    leftLine.Parent = mainFrame
    
    local rightLine = Instance.new("Frame")
    rightLine.Name = "RightLine"
    rightLine.Size = UDim2.new(0.12, 0, 0, 2)
    rightLine.Position = UDim2.new(0.55, 0, 0.55, 20)
    rightLine.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    rightLine.BorderSizePixel = 0
    rightLine.Parent = mainFrame
    
    -- تحسين زر اللغة الإنجليزية
    local englishButton = Instance.new("Frame")
    englishButton.Name = "EnglishButton"
    englishButton.Size = UDim2.new(0.42, 0, 0, 75)
    englishButton.Position = UDim2.new(0.51, 0, 0.55, 0)
    englishButton.BackgroundColor3 = buttonColor
    englishButton.Parent = mainFrame
    
    local englishCorner = Instance.new("UICorner")
    englishCorner.CornerRadius = UDim.new(0, 12)
    englishCorner.Parent = englishButton
    
    -- إضافة تأثيرات للزر
    local englishStroke = Instance.new("UIStroke")
    englishStroke.Color = Color3.fromRGB(70, 70, 70)
    englishStroke.Thickness = 1.5
    englishStroke.Parent = englishButton
    
    -- إضافة تدرج لوني للزر
    local englishGradient = Instance.new("UIGradient")
    englishGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(45, 45, 45)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(35, 35, 35))
    })
    englishGradient.Rotation = 90
    englishGradient.Parent = englishButton
    
    -- تحسين الأيقونة
    local englishIconBg = Instance.new("Frame")
    englishIconBg.Name = "EnglishIconBg"
    englishIconBg.Size = UDim2.new(0, 45, 0, 45)
    englishIconBg.Position = UDim2.new(0, 15, 0.5, -22.5)
    englishIconBg.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    englishIconBg.Parent = englishButton
    
    local englishIconCorner = Instance.new("UICorner")
    englishIconCorner.CornerRadius = UDim.new(1, 0)
    englishIconCorner.Parent = englishIconBg
    
    local englishIconImage = Instance.new("ImageLabel")
    englishIconImage.Name = "EnglishIcon"
    englishIconImage.Size = UDim2.new(0.8, 0, 0.8, 0)
    englishIconImage.Position = UDim2.new(0.1, 0, 0.1, 0)
    englishIconImage.BackgroundTransparency = 1
    englishIconImage.Image = englishIcon
    englishIconImage.Parent = englishIconBg
    
    local englishText = Instance.new("TextLabel")
    englishText.Name = "EnglishText"
    englishText.Size = UDim2.new(1, -75, 1, -20)
    englishText.Position = UDim2.new(0, 70, 0, 10)
    englishText.BackgroundTransparency = 1
    englishText.TextColor3 = Color3.fromRGB(255, 255, 255)
    englishText.TextSize = 22
    englishText.Font = Enum.Font.GothamBold
    englishText.Text = "English"
    englishText.TextXAlignment = Enum.TextXAlignment.Left
    englishText.Parent = englishButton
    
    -- إضافة نص إضافي تحت النص الرئيسي
    local englishSubtext = Instance.new("TextLabel")
    englishSubtext.Name = "EnglishSubtext"
    englishSubtext.Size = UDim2.new(1, -75, 0, 20)
    englishSubtext.Position = UDim2.new(0, 70, 1, -30)
    englishSubtext.BackgroundTransparency = 1
    englishSubtext.TextColor3 = Color3.fromRGB(180, 180, 180)
    englishSubtext.TextSize = 14
    englishSubtext.Font = Enum.Font.Gotham
    englishSubtext.Text = "Choose English language"
    englishSubtext.TextXAlignment = Enum.TextXAlignment.Left
    englishSubtext.Parent = englishButton
    
    local englishClickDetector = Instance.new("TextButton")
    englishClickDetector.Name = "EnglishClickDetector"
    englishClickDetector.Size = UDim2.new(1, 0, 1, 0)
    englishClickDetector.BackgroundTransparency = 1
    englishClickDetector.Text = ""
    englishClickDetector.Parent = englishButton
    
    -- تحسين معلومات النص السفلية
    local footerContainer = Instance.new("Frame")
    footerContainer.Name = "FooterContainer"
    footerContainer.Size = UDim2.new(0.9, 0, 0, 40)
    footerContainer.Position = UDim2.new(0.05, 0, 1, -45)
    footerContainer.BackgroundTransparency = 1
    footerContainer.Parent = mainFrame
    
    local divider = Instance.new("Frame")
    divider.Name = "Divider"
    divider.Size = UDim2.new(1, 0, 0, 2)
    divider.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    divider.BorderSizePixel = 0
    divider.Parent = footerContainer
    
    -- إضافة تأثير تدرج للفاصل
    local dividerGradient = Instance.new("UIGradient")
    dividerGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(60, 60, 60)),
        ColorSequenceKeypoint.new(0.5, mainColor),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(60, 60, 60))
    })
    dividerGradient.Parent = divider
    
    local scriptInfoLeft = Instance.new("TextLabel")
    scriptInfoLeft.Name = "ScriptInfoLeft"
    scriptInfoLeft.Size = UDim2.new(0.5, -10, 0, 25)
    scriptInfoLeft.Position = UDim2.new(0, 0, 0, 10)
    scriptInfoLeft.BackgroundTransparency = 1
    scriptInfoLeft.TextColor3 = Color3.fromRGB(200, 200, 200)
    scriptInfoLeft.TextSize = 14
    scriptInfoLeft.Font = Enum.Font.Gotham
    scriptInfoLeft.Text = "GUI BY: FRONT-EVIll"
    scriptInfoLeft.TextXAlignment = Enum.TextXAlignment.Left
    scriptInfoLeft.Parent = footerContainer
    
    local scriptInfoRight = Instance.new("TextLabel")
    scriptInfoRight.Name = "ScriptInfoRight"
    scriptInfoRight.Size = UDim2.new(0.5, -10, 0, 25)
    scriptInfoRight.Position = UDim2.new(0.5, 10, 0, 10)
    scriptInfoRight.BackgroundTransparency = 1
    scriptInfoRight.TextColor3 = Color3.fromRGB(200, 200, 200)
    scriptInfoRight.TextSize = 14
    scriptInfoRight.Font = Enum.Font.Gotham
    scriptInfoRight.Text = "Script By: front-evill / 7sone"
    scriptInfoRight.TextXAlignment = Enum.TextXAlignment.Right
    scriptInfoRight.Parent = footerContainer
    
    -- تأثيرات المؤشر عند التحويم فوق الأزرار
    arabicClickDetector.MouseEnter:Connect(function()
        game:GetService("TweenService"):Create(arabicButton, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {BackgroundColor3 = mainColor}):Play()
        game:GetService("TweenService"):Create(arabicStroke, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {Color = Color3.fromRGB(255, 70, 70)}):Play()
        game:GetService("TweenService"):Create(arabicIconBg, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {BackgroundColor3 = Color3.fromRGB(70, 70, 70)}):Play()
        game:GetService("TweenService"):Create(arabicButton, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0.44, 0, 0, 80)}):Play()
        
        -- إضافة تأثير ظل عند التحويم
        local arabicShadow = Instance.new("ImageLabel")
        arabicShadow.Name = "HoverShadow"
        arabicShadow.AnchorPoint = Vector2.new(0.5, 0.5)
        arabicShadow.BackgroundTransparency = 1
        arabicShadow.Position = UDim2.new(0.5, 0, 0.5, 0)
        arabicShadow.Size = UDim2.new(1, 24, 1, 24)
        arabicShadow.ZIndex = -1
        arabicShadow.Image = "rbxassetid://6014261993"
        arabicShadow.ImageColor3 = mainColor
        arabicShadow.ImageTransparency = 1
        arabicShadow.ScaleType = Enum.ScaleType.Slice
        arabicShadow.SliceCenter = Rect.new(49, 49, 450, 450)
        arabicShadow.Parent = arabicButton
        
        game:GetService("TweenService"):Create(arabicShadow, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {ImageTransparency = 0.7}):Play()
    end)
    
    arabicClickDetector.MouseLeave:Connect(function()
        game:GetService("TweenService"):Create(arabicButton, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {BackgroundColor3 = buttonColor}):Play()
        game:GetService("TweenService"):Create(arabicStroke, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {Color = Color3.fromRGB(70, 70, 70)}):Play()
        game:GetService("TweenService"):Create(arabicIconBg, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}):Play()
        game:GetService("TweenService"):Create(arabicButton, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {Size = UDim2.new(0.42, 0, 0, 75)}):Play()
        
        local arabicShadow = arabicButton:FindFirstChild("HoverShadow")
        if arabicShadow then
            game:GetService("TweenService"):Create(arabicShadow, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {ImageTransparency = 1}):Play()
            game:GetService("Debris"):AddItem(arabicShadow, 0.3)
        end
    end)
    
    englishClickDetector.MouseEnter:Connect(function()
        game:GetService("TweenService"):Create(englishButton, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {BackgroundColor3 = mainColor}):Play()
        game:GetService("TweenService"):Create(englishStroke, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {Color = Color3.fromRGB(255, 70, 70)}):Play()
        game:GetService("TweenService"):Create(englishIconBg, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {BackgroundColor3 = Color3.fromRGB(70, 70, 70)}):Play()
        game:GetService("TweenService"):Create(englishButton, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0.44, 0, 0, 80)}):Play()
        
        -- إضافة تأثير ظل عند التحويم
        local englishShadow = Instance.new("ImageLabel")
        englishShadow.Name = "HoverShadow"
        englishShadow.AnchorPoint = Vector2.new(0.5, 0.5)
        englishShadow.BackgroundTransparency = 1
        englishShadow.Position = UDim2.new(0.5, 0, 0.5, 0)
        englishShadow.Size = UDim2.new(1, 24, 1, 24)
        englishShadow.ZIndex = -1
        englishShadow.Image = "rbxassetid://6014261993"
        englishShadow.ImageColor3 = mainColor
        englishShadow.ImageTransparency = 1
        englishShadow.ScaleType = Enum.ScaleType.Slice
        englishShadow.SliceCenter = Rect.new(49, 49, 450, 450)
        englishShadow.Parent = englishButton
        
        game:GetService("TweenService"):Create(englishShadow, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {ImageTransparency = 0.7}):Play()
    end)
    
    englishClickDetector.MouseLeave:Connect(function()
        game:GetService("TweenService"):Create(englishButton, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {BackgroundColor3 = buttonColor}):Play()
        game:GetService("TweenService"):Create(englishStroke, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {Color = Color3.fromRGB(70, 70, 70)}):Play()
        game:GetService("TweenService"):Create(englishIconBg, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}):Play()
        game:GetService("TweenService"):Create(englishButton, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {Size = UDim2.new(0.42, 0, 0, 75)}):Play()
        
        local englishShadow = englishButton:FindFirstChild("HoverShadow")
        if englishShadow then
            game:GetService("TweenService"):Create(englishShadow, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {ImageTransparency = 1}):Play()
            game:GetService("Debris"):AddItem(englishShadow, 0.3)
        end
    end)
    
    -- تحسين تأثير النقر
    arabicClickDetector.MouseButton1Click:Connect(function()
        -- تأثير نقر محسن
        game:GetService("TweenService"):Create(arabicButton, TweenInfo.new(0.1, Enum.EasingStyle.Quart), {Size = UDim2.new(0.4, 0, 0, 72)}):Play()
        
        -- إضافة تأثير الموجة عند النقر
        local ripple = Instance.new("Frame")
        ripple.Name = "ClickRipple"
        ripple.Size = UDim2.new(0, 0, 0, 0)
        ripple.AnchorPoint = Vector2.new(0.5, 0.5)
        ripple.Position = UDim2.new(0.5, 0, 0.5, 0)
        ripple.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        ripple.BackgroundTransparency = 0.8
        ripple.BorderSizePixel = 0
        ripple.Parent = arabicButton
        
        local rippleCorner = Instance.new("UICorner")
        rippleCorner.CornerRadius = UDim.new(1, 0)
        rippleCorner.Parent = ripple
        
        game:GetService("TweenService"):Create(ripple, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(2, 0, 2, 0), BackgroundTransparency = 1}):Play()
        game:GetService("Debris"):AddItem(ripple, 0.5)
        
        wait(0.1)
        game:GetService("TweenService"):Create(arabicButton, TweenInfo.new(0.1, Enum.EasingStyle.Bounce), {Size = UDim2.new(0.42, 0, 0, 75)}):Play()
        
        -- تأثير اختفاء اللوحة
        local exitTween = game:GetService("TweenService"):Create(mainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Position = UDim2.new(0.5, -240, 1.2, 0), BackgroundTransparency = 1})
        local shadowTween = game:GetService("TweenService"):Create(mainShadow, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {ImageTransparency = 1})
        local strokeTween = game:GetService("TweenService"):Create(uiStroke, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {Transparency = 1})
        
        exitTween:Play()
        shadowTween:Play()
        strokeTween:Play()
        
        -- إنشاء إشعار محسن
        createNotification("تم تشغيل السكربت باللغة العربية ✓", 5)
        
        wait(0.5)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Front-Evill/Script-Hub/refs/heads/main/Arabic.lua"))()
        
        wait(0.5)
        mainFrame:Destroy()
    end)
    
    englishClickDetector.MouseButton1Click:Connect(function()
        -- تأثير نقر محسن
        game:GetService("TweenService"):Create(englishButton, TweenInfo.new(0.1, Enum.EasingStyle.Quart), {Size = UDim2.new(0.4, 0, 0, 72)}):Play()
        
        -- إضافة تأثير الموجة عند النقر
        local ripple = Instance.new("Frame")
        ripple.Name = "ClickRipple"
        ripple.Size = UDim2.new(0, 0, 0, 0)
        ripple.AnchorPoint = Vector2.new(0.5, 0.5)
        ripple.Position = UDim2.new(0.5, 0, 0.5, 0)
        ripple.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        ripple.BackgroundTransparency = 0.8
        ripple.BorderSizePixel = 0
        ripple.Parent = englishButton
        
        local rippleCorner = Instance.new("UICorner")
        rippleCorner.CornerRadius = UDim.new(1, 0)
        rippleCorner.Parent = ripple
        
        game:GetService("TweenService"):Create(ripple, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(2, 0, 2, 0), BackgroundTransparency = 1}):Play()
        game:GetService("Debris"):AddItem(ripple, 0.5)
        
        wait(0.1)
        game:GetService("TweenService"):Create(englishButton, TweenInfo.new(0.1, Enum.EasingStyle.Bounce), {Size = UDim2.new(0.42, 0, 0, 75)}):Play()
        
        -- تأثير اختفاء اللوحة
        local exitTween = game:GetService("TweenService"):Create(mainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Position = UDim2.new(0.5, -240, 1.2, 0), BackgroundTransparency = 1})
        local shadowTween = game:GetService("TweenService"):Create(mainShadow, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {ImageTransparency = 1})
        local strokeTween = game:GetService("TweenService"):Create(uiStroke, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {Transparency = 1})
        
        exitTween:Play()
        shadowTween:Play()
        strokeTween:Play()
        
        -- إنشاء إشعار محسن
        createNotification("Script launched in English ✓", 5)
        
        wait(0.5)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Front-Evill/Script-Hub/refs/heads/main/F-150.lua"))()
        
        wait(0.5)
        mainFrame:Destroy()
    end)
    
    -- تأثيرات الظهور المحسنة
    mainFrame.Position = UDim2.new(0.5, -240, 1.2, 0)
    mainFrame.BackgroundTransparency = 1
    mainShadow.ImageTransparency = 1
    topIcon.ImageTransparency = 1
    iconGlow.ImageTransparency = 1
    titleLabel.TextTransparency = 1
    titleUnderline.Size = UDim2.new(0, 0, 0, 3)
    arabicButton.BackgroundTransparency = 1
    arabicIconBg.BackgroundTransparency = 1
    arabicText.TextTransparency = 1
    arabicSubtext.TextTransparency = 1
    orLabel.TextTransparency = 1
    leftLine.BackgroundTransparency = 1
    rightLine.BackgroundTransparency = 1
    englishButton.BackgroundTransparency = 1
    englishIconBg.BackgroundTransparency = 1
    englishText.TextTransparency = 1
    englishSubtext.TextTransparency = 1
    scriptInfoLeft.TextTransparency = 1
    scriptInfoRight.TextTransparency = 1
    divider.BackgroundTransparency = 1
    uiStroke.Transparency = 1
    arabicStroke.Transparency = 1
    englishStroke.Transparency = 1
    patternImage.ImageTransparency = 1
    

    -- رسوم متحركة للظهور
    game:GetService("TweenService"):Create(mainFrame, TweenInfo.new(0.8, Enum.EasingStyle.Bounce), {Position = UDim2.new(0.5, -225, 0.5, -150), BackgroundTransparency = 0}):Play()
    wait(0.1)
    game:GetService("TweenService"):Create(topIcon, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {ImageTransparency = 0}):Play()
    wait(0.1)
    game:GetService("TweenService"):Create(titleLabel, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {TextTransparency = 0}):Play()
    wait(0.1)
    game:GetService("TweenService"):Create(arabicButton, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {BackgroundTransparency = 0}):Play()
    game:GetService("TweenService"):Create(arabicText, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {TextTransparency = 0}):Play()
    game:GetService("TweenService"):Create(arabicIconImage, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {ImageTransparency = 0}):Play()
    wait(0.1)
    game:GetService("TweenService"):Create(orLabel, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {TextTransparency = 0}):Play()
    wait(0.1)
    game:GetService("TweenService"):Create(englishButton, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {BackgroundTransparency = 0}):Play()
    game:GetService("TweenService"):Create(englishText, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {TextTransparency = 0}):Play()
    game:GetService("TweenService"):Create(englishIconImage, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {ImageTransparency = 0}):Play()
    wait(0.1)
    game:GetService("TweenService"):Create(scriptInfoLeft, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {TextTransparency = 0}):Play()
    game:GetService("TweenService"):Create(scriptInfoRight, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {TextTransparency = 0}):Play()
    game:GetService("TweenService"):Create(divider, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {BackgroundTransparency = 0}):Play()
    game:GetService("TweenService"):Create(uiStroke, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {Transparency = 0}):Play()
    
    -- تأثيرات للأزرار
    arabicClickDetector.MouseEnter:Connect(function()
        game:GetService("TweenService"):Create(arabicButton, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {BackgroundColor3 = Color3.fromRGB(255, 0, 0)}):Play()
        game:GetService("TweenService"):Create(arabicText, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
        game:GetService("TweenService"):Create(arabicButton, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {Size = UDim2.new(0.42, 0, 0, 75)}):Play()
    end)
    
    arabicClickDetector.MouseLeave:Connect(function()
        game:GetService("TweenService"):Create(arabicButton, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}):Play()
        game:GetService("TweenService"):Create(arabicText, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
        game:GetService("TweenService"):Create(arabicButton, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {Size = UDim2.new(0.4, 0, 0, 70)}):Play()
    end)
    
    englishClickDetector.MouseEnter:Connect(function()
        game:GetService("TweenService"):Create(englishButton, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {BackgroundColor3 = Color3.fromRGB(255, 0, 0)}):Play()
        game:GetService("TweenService"):Create(englishText, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
        game:GetService("TweenService"):Create(englishButton, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {Size = UDim2.new(0.42, 0, 0, 75)}):Play()
    end)
    
    englishClickDetector.MouseLeave:Connect(function()
        game:GetService("TweenService"):Create(englishButton, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}):Play()
        game:GetService("TweenService"):Create(englishText, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
        game:GetService("TweenService"):Create(englishButton, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {Size = UDim2.new(0.4, 0, 0, 70)}):Play()
    end)
    
    arabicClickDetector.MouseButton1Click:Connect(function()
        -- تأثير نقرة للزر
        game:GetService("TweenService"):Create(arabicButton, TweenInfo.new(0.15, Enum.EasingStyle.Quart), {Size = UDim2.new(0.38, 0, 0, 65)}):Play()
        wait(0.15)
        game:GetService("TweenService"):Create(arabicButton, TweenInfo.new(0.15, Enum.EasingStyle.Quart), {Size = UDim2.new(0.4, 0, 0, 70)}):Play()
        
        -- خروج الإطار
        game:GetService("TweenService"):Create(mainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Position = UDim2.new(0.5, -225, 1.5, 0), BackgroundTransparency = 1}):Play()
        game:GetService("TweenService"):Create(uiStroke, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {Transparency = 1}):Play()
        
    
typewriterEffect("Welcome to Front Evill Script 🔥👀")
