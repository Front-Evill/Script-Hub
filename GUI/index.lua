local player = game.Players.LocalPlayer
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "FrontEvillGUI"
screenGui.ResetOnSpawn = false

if syn then
    syn.protect_gui(screenGui)
    screenGui.Parent = game:GetService("CoreGui")
elseif gethui then
    screenGui.Parent = gethui()
else
    screenGui.Parent = player.PlayerGui
end


local scriptIcon = "rbxassetid://130714468148923"
local arabicIcon = "rbxassetid://109597213480889"
local englishIcon = "rbxassetid://113626041682134"

local function createNotification(text, duration)
    duration = duration or 3
    
    local notification = Instance.new("Frame")
    notification.Name = "Notification"
    notification.Size = UDim2.new(0, 280, 0, 70)
    notification.Position = UDim2.new(0.5, -140, 0.85, 0)
    notification.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    notification.BorderSizePixel = 0
    notification.BackgroundTransparency = 0.1
    notification.Parent = screenGui
    
    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(0, 10)
    uiCorner.Parent = notification
    
    local uiStroke = Instance.new("UIStroke")
    uiStroke.Color = Color3.fromRGB(255, 0, 0)
    uiStroke.Thickness = 2
    uiStroke.Parent = notification
    
    -- أيقونة الإشعار
    local iconImage = Instance.new("ImageLabel")
    iconImage.Name = "NotifIcon"
    iconImage.Size = UDim2.new(0, 40, 0, 40)
    iconImage.Position = UDim2.new(0, 15, 0.5, -20)
    iconImage.BackgroundTransparency = 1
    iconImage.Image = scriptIcon
    iconImage.Parent = notification
    
    local notifText = Instance.new("TextLabel")
    notifText.Name = "NotifText"
    notifText.Size = UDim2.new(1, -80, 1, -20)
    notifText.Position = UDim2.new(0, 65, 0, 10)
    notifText.BackgroundTransparency = 1
    notifText.TextColor3 = Color3.fromRGB(255, 255, 255)
    notifText.TextSize = 16
    notifText.Font = Enum.Font.GothamBold
    notifText.Text = text
    notifText.TextWrapped = true
    notifText.TextXAlignment = Enum.TextXAlignment.Left
    notifText.Parent = notification
    
    notification.BackgroundTransparency = 1
    uiStroke.Transparency = 1
    notifText.TextTransparency = 1
    iconImage.ImageTransparency = 1
    
    -- تحسين الرسوم المتحركة
    game:GetService("TweenService"):Create(notification, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {BackgroundTransparency = 0.1}):Play()
    game:GetService("TweenService"):Create(uiStroke, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Transparency = 0}):Play()
    game:GetService("TweenService"):Create(notifText, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
    game:GetService("TweenService"):Create(iconImage, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {ImageTransparency = 0}):Play()
    
    spawn(function()
        wait(duration)
        local fadeOut = game:GetService("TweenService"):Create(notification, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {BackgroundTransparency = 1})
        local strokeFade = game:GetService("TweenService"):Create(uiStroke, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {Transparency = 1})
        local textFade = game:GetService("TweenService"):Create(notifText, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {TextTransparency = 1})
        local iconFade = game:GetService("TweenService"):Create(iconImage, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {ImageTransparency = 1})
        
        fadeOut:Play()
        strokeFade:Play()
        textFade:Play()
        iconFade:Play()
        
        fadeOut.Completed:Wait()
        notification:Destroy()
    end)
end

local function typewriterEffect(text)
    local background = Instance.new("Frame")
    background.Name = "WelcomeScreen"
    background.Size = UDim2.new(1, 0, 1, 0)
    background.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    background.BackgroundTransparency = 0.2
    background.BorderSizePixel = 0
    background.Parent = screenGui
    
    -- تأثير انتقالي تدريجي للخلفية
    game:GetService("TweenService"):Create(background, TweenInfo.new(0.8, Enum.EasingStyle.Quart), {BackgroundTransparency = 0.2}):Play()
    
    local blur = Instance.new("BlurEffect")
    blur.Size = 0
    blur.Parent = game:GetService("Lighting")
    
    -- زيادة تدريجية للضبابية
    game:GetService("TweenService"):Create(blur, TweenInfo.new(0.8, Enum.EasingStyle.Quart), {Size = 20}):Play()
    
    -- إضافة أيقونة للشاشة الترحيبية
    local logoImage = Instance.new("ImageLabel")
    logoImage.Name = "LogoImage"
    logoImage.Size = UDim2.new(0, 120, 0, 120)
    logoImage.Position = UDim2.new(0.5, -60, 0.25, -60)
    logoImage.BackgroundTransparency = 1
    logoImage.Image = scriptIcon
    logoImage.ImageTransparency = 1
    logoImage.Parent = background
    
    -- رسوم متحركة للشعار
    game:GetService("TweenService"):Create(logoImage, TweenInfo.new(1, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {ImageTransparency = 0}):Play()
    
    local welcomeText = Instance.new("TextLabel")
    welcomeText.Name = "WelcomeText"
    welcomeText.Size = UDim2.new(0.8, 0, 0.2, 0)
    welcomeText.Position = UDim2.new(0.1, 0, 0.45, 0)
    welcomeText.BackgroundTransparency = 1
    welcomeText.TextColor3 = Color3.fromRGB(255, 0, 0)
    welcomeText.TextSize = 36
    welcomeText.Font = Enum.Font.GothamBold
    welcomeText.Text = ""
    welcomeText.TextWrapped = true
    welcomeText.Parent = background
    
    -- تأثير نص متحرك تحت الشعار
    local subText = Instance.new("TextLabel")
    subText.Name = "SubText"
    subText.Size = UDim2.new(0.6, 0, 0.1, 0)
    subText.Position = UDim2.new(0.2, 0, 0.6, 0)
    subText.BackgroundTransparency = 1
    subText.TextColor3 = Color3.fromRGB(200, 200, 200)
    subText.TextSize = 22
    subText.Font = Enum.Font.Gotham
    subText.Text = "Created by Front-Evill"
    subText.TextTransparency = 1
    subText.Parent = background
    
    -- عرض النص الفرعي بعد تأثير الكتابة
    game:GetService("TweenService"):Create(subText, TweenInfo.new(1, Enum.EasingStyle.Quart), {TextTransparency = 0}):Play()
    
    spawn(function()
        for i = 1, #text do
            welcomeText.Text = string.sub(text, 1, i)
            wait(0.05)
        end
        
        wait(1.5)
        
        game:GetService("TweenService"):Create(background, TweenInfo.new(1, Enum.EasingStyle.Quart), {BackgroundTransparency = 1}):Play()
        game:GetService("TweenService"):Create(welcomeText, TweenInfo.new(1, Enum.EasingStyle.Quart), {TextTransparency = 1}):Play()
        game:GetService("TweenService"):Create(logoImage, TweenInfo.new(1, Enum.EasingStyle.Quart), {ImageTransparency = 1}):Play()
        game:GetService("TweenService"):Create(subText, TweenInfo.new(1, Enum.EasingStyle.Quart), {TextTransparency = 1}):Play()
        game:GetService("TweenService"):Create(blur, TweenInfo.new(1, Enum.EasingStyle.Quart), {Size = 0}):Play()
        
        wait(1)
        showLanguageSelector()
        
        wait(0.5)
        background:Destroy()
        blur:Destroy()
    end)
end

function showLanguageSelector()
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "LanguageSelector"
    mainFrame.Size = UDim2.new(0, 450, 0, 300)
    mainFrame.Position = UDim2.new(0.5, -225, 0.5, -150)
    mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    mainFrame.BorderSizePixel = 0
    mainFrame.Parent = screenGui
    mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    
    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(0, 15)
    uiCorner.Parent = mainFrame
    
    local uiStroke = Instance.new("UIStroke")
    uiStroke.Color = Color3.fromRGB(255, 0, 0)
    uiStroke.Thickness = 2.5
    uiStroke.Parent = mainFrame
    
    -- إضافة أيقونة في أعلى الإطار
    local topIcon = Instance.new("ImageLabel")
    topIcon.Name = "TopIcon"
    topIcon.Size = UDim2.new(0, 60, 0, 60)
    topIcon.Position = UDim2.new(0.5, -30, 0, 20)
    topIcon.BackgroundTransparency = 1
    topIcon.Image = scriptIcon
    topIcon.Parent = mainFrame
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "TitleLabel"
    titleLabel.Size = UDim2.new(1, 0, 0, 50)
    titleLabel.Position = UDim2.new(0, 0, 0, 90)
    titleLabel.BackgroundTransparency = 1
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.TextSize = 24
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.Text = "Select Your Language"
    titleLabel.Parent = mainFrame
    
    -- تحسين أزرار اللغة مع أيقونات
    local arabicButton = Instance.new("Frame")
    arabicButton.Name = "ArabicButton"
    arabicButton.Size = UDim2.new(0.4, 0, 0, 70)
    arabicButton.Position = UDim2.new(0.07, 0, 0.5, 0)
    arabicButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    arabicButton.Parent = mainFrame
    
    local arabicCorner = Instance.new("UICorner")
    arabicCorner.CornerRadius = UDim.new(0, 10)
    arabicCorner.Parent = arabicButton
    
    local arabicIconImage = Instance.new("ImageLabel")
    arabicIconImage.Name = "ArabicIcon"
    arabicIconImage.Size = UDim2.new(0, 40, 0, 40)
    arabicIconImage.Position = UDim2.new(0, 15, 0.5, -20)
    arabicIconImage.BackgroundTransparency = 1
    arabicIconImage.Image = arabicIcon
    arabicIconImage.Parent = arabicButton
    
    local arabicText = Instance.new("TextLabel")
    arabicText.Name = "ArabicText"
    arabicText.Size = UDim2.new(1, -70, 1, 0)
    arabicText.Position = UDim2.new(0, 65, 0, 0)
    arabicText.BackgroundTransparency = 1
    arabicText.TextColor3 = Color3.fromRGB(255, 255, 255)
    arabicText.TextSize = 22
    arabicText.Font = Enum.Font.GothamBold
    arabicText.Text = "Arabic"
    arabicText.Parent = arabicButton
    
    -- إضافة تأثير عند المرور فوق الزر
    local arabicClickDetector = Instance.new("TextButton")
    arabicClickDetector.Name = "ArabicClickDetector"
    arabicClickDetector.Size = UDim2.new(1, 0, 1, 0)
    arabicClickDetector.BackgroundTransparency = 1
    arabicClickDetector.Text = ""
    arabicClickDetector.Parent = arabicButton
    
    local orLabel = Instance.new("TextLabel")
    orLabel.Name = "OrLabel"
    orLabel.Size = UDim2.new(0.1, 0, 0, 50)
    orLabel.Position = UDim2.new(0.45, 0, 0.5, 10)
    orLabel.BackgroundTransparency = 1
    orLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    orLabel.TextSize = 20
    orLabel.Font = Enum.Font.GothamBold
    orLabel.Text = "OR"
    orLabel.Parent = mainFrame
    
    local englishButton = Instance.new("Frame")
    englishButton.Name = "EnglishButton"
    englishButton.Size = UDim2.new(0.4, 0, 0, 70)
    englishButton.Position = UDim2.new(0.53, 0, 0.5, 0)
    englishButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    englishButton.Parent = mainFrame
    
    local englishCorner = Instance.new("UICorner")
    englishCorner.CornerRadius = UDim.new(0, 10)
    englishCorner.Parent = englishButton
    
    local englishIconImage = Instance.new("ImageLabel")
    englishIconImage.Name = "EnglishIcon"
    englishIconImage.Size = UDim2.new(0, 40, 0, 40)
    englishIconImage.Position = UDim2.new(0, 15, 0.5, -20)
    englishIconImage.BackgroundTransparency = 1
    englishIconImage.Image = englishIcon
    englishIconImage.Parent = englishButton
    
    local englishText = Instance.new("TextLabel")
    englishText.Name = "EnglishText"
    englishText.Size = UDim2.new(1, -70, 1, 0)
    englishText.Position = UDim2.new(0, 65, 0, 0)
    englishText.BackgroundTransparency = 1
    englishText.TextColor3 = Color3.fromRGB(255, 255, 255)
    englishText.TextSize = 22
    englishText.Font = Enum.Font.GothamBold
    englishText.Text = "English"
    englishText.Parent = englishButton
    
    -- إضافة تأثير عند المرور فوق الزر
    local englishClickDetector = Instance.new("TextButton")
    englishClickDetector.Name = "EnglishClickDetector"
    englishClickDetector.Size = UDim2.new(1, 0, 1, 0)
    englishClickDetector.BackgroundTransparency = 1
    englishClickDetector.Text = ""
    englishClickDetector.Parent = englishButton
    
    local scriptInfoLeft = Instance.new("TextLabel")
    scriptInfoLeft.Name = "ScriptInfoLeft"
    scriptInfoLeft.Size = UDim2.new(0.5, -10, 0, 20)
    scriptInfoLeft.Position = UDim2.new(0, 10, 1, -30)
    scriptInfoLeft.BackgroundTransparency = 1
    scriptInfoLeft.TextColor3 = Color3.fromRGB(200, 200, 200)
    scriptInfoLeft.TextSize = 14
    scriptInfoLeft.Font = Enum.Font.Gotham
    scriptInfoLeft.Text = "GUI BY: FRONT-EVIll"
    scriptInfoLeft.TextXAlignment = Enum.TextXAlignment.Left
    scriptInfoLeft.Parent = mainFrame
    
    local scriptInfoRight = Instance.new("TextLabel")
    scriptInfoRight.Name = "ScriptInfoRight"
    scriptInfoRight.Size = UDim2.new(0.5, -10, 0, 20)
    scriptInfoRight.Position = UDim2.new(0.5, 0, 1, -30)
    scriptInfoRight.BackgroundTransparency = 1
    scriptInfoRight.TextColor3 = Color3.fromRGB(200, 200, 200)
    scriptInfoRight.TextSize = 14
    scriptInfoRight.Font = Enum.Font.Gotham
    scriptInfoRight.Text = "Script By: front-evill / 7sone"
    scriptInfoRight.TextXAlignment = Enum.TextXAlignment.Right
    scriptInfoRight.Parent = mainFrame
    
    -- إضافة خط فاصل جميل
    local divider = Instance.new("Frame")
    divider.Name = "Divider"
    divider.Size = UDim2.new(0.85, 0, 0, 2)
    divider.Position = UDim2.new(0.075, 0, 1, -50)
    divider.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    divider.BorderSizePixel = 0
    divider.Parent = mainFrame
    
    -- جعل الإطار يظهر بشكل متحرك
    mainFrame.Position = mainFrame.Position + UDim2.new(0, 0, 0.2, 0)
    mainFrame.BackgroundTransparency = 1
    topIcon.ImageTransparency = 1
    titleLabel.TextTransparency = 1
    arabicButton.BackgroundTransparency = 1
    arabicText.TextTransparency = 1
    arabicIconImage.ImageTransparency = 1
    orLabel.TextTransparency = 1
    englishButton.BackgroundTransparency = 1
    englishText.TextTransparency = 1
    englishIconImage.ImageTransparency = 1
    scriptInfoLeft.TextTransparency = 1
    scriptInfoRight.TextTransparency = 1
    divider.BackgroundTransparency = 1
    uiStroke.Transparency = 1
    
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
        
        -- إشعار حول اللغة العربية
        createNotification("تم تشغيل السكربت باللغة العربية", 5)
        
        wait(0.5)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Front-Evill/Script-Hub/refs/heads/main/Arabic.lua"))()
        
        wait(0.5)
        mainFrame:Destroy()
    end)
    
    englishClickDetector.MouseButton1Click:Connect(function()
        -- تأثير نقرة للزر
        game:GetService("TweenService"):Create(englishButton, TweenInfo.new(0.15, Enum.EasingStyle.Quart), {Size = UDim2.new(0.38, 0, 0, 65)}):Play()
        wait(0.15)
        game:GetService("TweenService"):Create(englishButton, TweenInfo.new(0.15, Enum.EasingStyle.Quart), {Size = UDim2.new(0.4, 0, 0, 70)}):Play()
        
        -- خروج الإطار
        game:GetService("TweenService"):Create(mainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Position = UDim2.new(0.5, -225, 1.5, 0), BackgroundTransparency = 1}):Play()
        game:GetService("TweenService"):Create(uiStroke, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {Transparency = 1}):Play()

        createNotification("Script launched in English", 5)
       
       wait(0.5)
       loadstring(game:HttpGet("https://raw.githubusercontent.com/Front-Evill/Script-Hub/refs/heads/main/F-150.lua"))()
       
       wait(0.5)
       mainFrame:Destroy()
   end)
end

typewriterEffect("Welcome to Front Evill Script 🔥👀")
