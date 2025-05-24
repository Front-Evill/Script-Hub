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
    notification.Size = UDim2.new(0, 320, 0, 90)
    notification.Position = UDim2.new(0.5, -160, 0.85, 0)
    notification.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    notification.BorderSizePixel = 0
    notification.BackgroundTransparency = 0.1
    notification.Parent = screenGui
    
    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(0, 15)
    uiCorner.Parent = notification
    
    local uiStroke = Instance.new("UIStroke")
    uiStroke.Color = Color3.fromRGB(255, 0, 0)
    uiStroke.Thickness = 3
    uiStroke.Parent = notification
    
    local glowEffect = Instance.new("ImageLabel")
    glowEffect.Name = "GlowEffect"
    glowEffect.Size = UDim2.new(1.2, 0, 1.2, 0)
    glowEffect.Position = UDim2.new(-0.1, 0, -0.1, 0)
    glowEffect.BackgroundTransparency = 1
    glowEffect.Image = "rbxassetid://5028857084"
    glowEffect.ImageColor3 = Color3.fromRGB(255, 0, 0)
    glowEffect.ImageTransparency = 0.7
    glowEffect.ZIndex = -1
    glowEffect.Parent = notification
    
    local iconImage = Instance.new("ImageLabel")
    iconImage.Name = "NotifIcon"
    iconImage.Size = UDim2.new(0, 60, 0, 60)
    iconImage.Position = UDim2.new(0, 15, 0.5, -30)
    iconImage.BackgroundTransparency = 1
    iconImage.Image = scriptIcon
    iconImage.Parent = notification
    
    local iconGlow = Instance.new("ImageLabel")
    iconGlow.Name = "IconGlow"
    iconGlow.Size = UDim2.new(1.3, 0, 1.3, 0)
    iconGlow.Position = UDim2.new(-0.15, 0, -0.15, 0)
    iconGlow.BackgroundTransparency = 1
    iconGlow.Image = "rbxassetid://5028857084"
    iconGlow.ImageColor3 = Color3.fromRGB(255, 0, 0)
    iconGlow.ImageTransparency = 0.5
    iconGlow.ZIndex = -1
    iconGlow.Parent = iconImage
    
    local notifText = Instance.new("TextLabel")
    notifText.Name = "NotifText"
    notifText.Size = UDim2.new(1, -90, 1, -20)
    notifText.Position = UDim2.new(0, 85, 0, 10)
    notifText.BackgroundTransparency = 1
    notifText.TextColor3 = Color3.fromRGB(255, 255, 255)
    notifText.TextSize = 20
    notifText.Font = Enum.Font.GothamBold
    notifText.Text = text
    notifText.TextWrapped = true
    notifText.TextXAlignment = Enum.TextXAlignment.Left
    notifText.Parent = notification
    
    notification.BackgroundTransparency = 1
    uiStroke.Transparency = 1
    notifText.TextTransparency = 1
    iconImage.ImageTransparency = 1
    glowEffect.ImageTransparency = 1
    
    game:GetService("TweenService"):Create(notification, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {BackgroundTransparency = 0.1}):Play()
    game:GetService("TweenService"):Create(uiStroke, TweenInfo.new(0.6, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Transparency = 0}):Play()
    game:GetService("TweenService"):Create(notifText, TweenInfo.new(0.6, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
    game:GetService("TweenService"):Create(iconImage, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {ImageTransparency = 0}):Play()
    game:GetService("TweenService"):Create(glowEffect, TweenInfo.new(0.6, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {ImageTransparency = 0.7}):Play()
    
    local pulseAnimation = function()
        local pulseIn = game:GetService("TweenService"):Create(iconGlow, TweenInfo.new(1.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {ImageTransparency = 0.3})
        local pulseOut = game:GetService("TweenService"):Create(iconGlow, TweenInfo.new(1.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {ImageTransparency = 0.7})
        
        pulseIn:Play()
        pulseIn.Completed:Connect(function()
            pulseOut:Play()
            pulseOut.Completed:Connect(function()
                if iconGlow.Parent then
                    pulseIn:Play()
                end
            end)
        end)
    end
    
    spawn(pulseAnimation)
    
    spawn(function()
        wait(duration)
        local fadeOut = game:GetService("TweenService"):Create(notification, TweenInfo.new(0.6, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {BackgroundTransparency = 1})
        local strokeFade = game:GetService("TweenService"):Create(uiStroke, TweenInfo.new(0.6, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {Transparency = 1})
        local textFade = game:GetService("TweenService"):Create(notifText, TweenInfo.new(0.6, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {TextTransparency = 1})
        local iconFade = game:GetService("TweenService"):Create(iconImage, TweenInfo.new(0.6, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {ImageTransparency = 1})
        local glowFade = game:GetService("TweenService"):Create(glowEffect, TweenInfo.new(0.6, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {ImageTransparency = 1})
        
        fadeOut:Play()
        strokeFade:Play()
        textFade:Play()
        iconFade:Play()
        glowFade:Play()
        
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
    
    game:GetService("TweenService"):Create(background, TweenInfo.new(0.8, Enum.EasingStyle.Quart), {BackgroundTransparency = 0.2}):Play()
    
    local blur = Instance.new("BlurEffect")
    blur.Size = 0
    blur.Parent = game:GetService("Lighting")
    
    game:GetService("TweenService"):Create(blur, TweenInfo.new(0.8, Enum.EasingStyle.Quart), {Size = 20}):Play()
    
    local contentFrame = Instance.new("Frame")
    contentFrame.Name = "ContentFrame"
    contentFrame.Size = UDim2.new(0.8, 0, 0.6, 0)
    contentFrame.Position = UDim2.new(0.1, 0, 0.2, 0)
    contentFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    contentFrame.BackgroundTransparency = 0.3
    contentFrame.BorderSizePixel = 0
    contentFrame.Parent = background
    
    local contentCorner = Instance.new("UICorner")
    contentCorner.CornerRadius = UDim.new(0, 20)
    contentCorner.Parent = contentFrame
    
    local contentStroke = Instance.new("UIStroke")
    contentStroke.Color = Color3.fromRGB(255, 0, 0)
    contentStroke.Thickness = 3
    contentStroke.Transparency = 0.2
    contentStroke.Parent = contentFrame
    
    local contentGlow = Instance.new("ImageLabel")
    contentGlow.Name = "ContentGlow"
    contentGlow.Size = UDim2.new(1.1, 0, 1.1, 0)
    contentGlow.Position = UDim2.new(-0.05, 0, -0.05, 0)
    contentGlow.BackgroundTransparency = 1
    contentGlow.Image = "rbxassetid://5028857084"
    contentGlow.ImageColor3 = Color3.fromRGB(255, 0, 0)
    contentGlow.ImageTransparency = 0.7
    contentGlow.ZIndex = -1
    contentGlow.Parent = contentFrame
    
    local logoImage = Instance.new("ImageLabel")
    logoImage.Name = "LogoImage"
    logoImage.Size = UDim2.new(0, 180, 0, 180)
    logoImage.Position = UDim2.new(0.5, -90, 0.25, -90)
    logoImage.BackgroundTransparency = 1
    logoImage.Image = scriptIcon
    logoImage.ImageTransparency = 1
    logoImage.Parent = contentFrame
    
    local logoGlow = Instance.new("ImageLabel")
    logoGlow.Name = "LogoGlow"
    logoGlow.Size = UDim2.new(1.2, 0, 1.2, 0)
    logoGlow.Position = UDim2.new(-0.1, 0, -0.1, 0)
    logoGlow.BackgroundTransparency = 1
    logoGlow.Image = "rbxassetid://5028857084"
    logoGlow.ImageColor3 = Color3.fromRGB(255, 0, 0)
    logoGlow.ImageTransparency = 0.5
    logoGlow.ZIndex = -1
    logoGlow.Parent = logoImage
    
    local welcomeText = Instance.new("TextLabel")
    welcomeText.Name = "WelcomeText"
    welcomeText.Size = UDim2.new(0.8, 0, 0.2, 0)
    welcomeText.Position = UDim2.new(0.1, 0, 0.45, 0)
    welcomeText.BackgroundTransparency = 1
    welcomeText.TextColor3 = Color3.fromRGB(255, 0, 0)
    welcomeText.TextSize = 48
    welcomeText.Font = Enum.Font.GothamBold
    welcomeText.Text = ""
    welcomeText.TextWrapped = true
    welcomeText.Parent = contentFrame
    
    local textGradient = Instance.new("UIGradient")
    textGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))
    })
    textGradient.Parent = welcomeText
    
    local subText = Instance.new("TextLabel")
    subText.Name = "SubText"
    subText.Size = UDim2.new(0.6, 0, 0.1, 0)
    subText.Position = UDim2.new(0.2, 0, 0.65, 0)
    subText.BackgroundTransparency = 1
    subText.TextColor3 = Color3.fromRGB(200, 200, 200)
    subText.TextSize = 28
    subText.Font = Enum.Font.Gotham
    subText.Text = "GUI by Front-Evill"
    subText.TextTransparency = 1
    subText.Parent = contentFrame
    
    local particles = Instance.new("Frame")
    particles.Name = "Particles"
    particles.Size = UDim2.new(1, 0, 1, 0)
    particles.BackgroundTransparency = 1
    particles.ZIndex = 0
    particles.Parent = background
    
    for i = 1, 30 do
        local particle = Instance.new("Frame")
        particle.Name = "Particle" .. i
        particle.Size = UDim2.new(0, math.random(2, 5), 0, math.random(2, 5))
        particle.Position = UDim2.new(math.random(), 0, math.random(), 0)
        particle.BackgroundColor3 = Color3.fromRGB(255, math.random(0, 100), 0)
        particle.BackgroundTransparency = math.random(0.3, 0.7)
        particle.BorderSizePixel = 0
        particle.Parent = particles
        
        local particleCorner = Instance.new("UICorner")
        particleCorner.CornerRadius = UDim.new(1, 0)
        particleCorner.Parent = particle
        
        local randomDuration = math.random(3, 8)
        local randomX = math.random() - 0.5
        local randomY = math.random() - 0.5
        
        spawn(function()
            while true do
                local moveParticle = game:GetService("TweenService"):Create(
                    particle, 
                    TweenInfo.new(randomDuration, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), 
                    {Position = UDim2.new(particle.Position.X.Scale + randomX, 0, particle.Position.Y.Scale + randomY, 0)}
                )
                moveParticle:Play()
                moveParticle.Completed:Wait()
                
                randomX = math.random() - 0.5
                randomY = math.random() - 0.5
            end
        end)
        
        spawn(function()
            while true do
                local pulseParticle = game:GetService("TweenService"):Create(
                    particle, 
                    TweenInfo.new(math.random(1, 3), Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), 
                    {BackgroundTransparency = math.random(0.3, 0.9)}
                )
                pulseParticle:Play()
                wait(math.random(1, 3))
            end
        end)
    end
    
    game:GetService("TweenService"):Create(subText, TweenInfo.new(1, Enum.EasingStyle.Quart), {TextTransparency = 0}):Play()
    
    spawn(function()
        for i = 0, 1, 0.02 do
            textGradient.Offset = Vector2.new(i, 0)
            wait(0.05)
        end
    end)
    
    spawn(function()
        while true do
            local rotateLogo = game:GetService("TweenService"):Create(
                logoImage, 
                TweenInfo.new(10, Enum.EasingStyle.Linear), 
                {Rotation = logoImage.Rotation + 360}
            )
            rotateLogo:Play()
            wait(10)
        end
    end)
    
    local pulseLogo = function()
        local scaleUp = game:GetService("TweenService"):Create(
            logoGlow, 
            TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), 
            {Size = UDim2.new(1.3, 0, 1.3, 0), ImageTransparency = 0.3}
        )
        local scaleDown = game:GetService("TweenService"):Create(
            logoGlow, 
            TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), 
            {Size = UDim2.new(1.1, 0, 1.1, 0), ImageTransparency = 0.7}
        )
        
        scaleUp:Play()
        scaleUp.Completed:Connect(function()
            scaleDown:Play()
            scaleDown.Completed:Connect(function()
                if logoGlow.Parent then
                    scaleUp:Play()
                end
            end)
        end)
    end
    
    spawn(pulseLogo)
    
    game:GetService("TweenService"):Create(logoImage, TweenInfo.new(1.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {ImageTransparency = 0}):Play()
    
    spawn(function()
        for i = 1, #text do
            welcomeText.Text = string.sub(text, 1, i)
            wait(0.04)
        end
        
        wait(1.5)
        
        game:GetService("TweenService"):Create(background, TweenInfo.new(1, Enum.EasingStyle.Quart), {BackgroundTransparency = 1}):Play()
        game:GetService("TweenService"):Create(contentFrame, TweenInfo.new(1, Enum.EasingStyle.Quart), {BackgroundTransparency = 1}):Play()
        game:GetService("TweenService"):Create(welcomeText, TweenInfo.new(1, Enum.EasingStyle.Quart), {TextTransparency = 1}):Play()
        game:GetService("TweenService"):Create(logoImage, TweenInfo.new(1, Enum.EasingStyle.Quart), {ImageTransparency = 1}):Play()
        game:GetService("TweenService"):Create(subText, TweenInfo.new(1, Enum.EasingStyle.Quart), {TextTransparency = 1}):Play()
        game:GetService("TweenService"):Create(contentStroke, TweenInfo.new(1, Enum.EasingStyle.Quart), {Transparency = 1}):Play()
        game:GetService("TweenService"):Create(contentGlow, TweenInfo.new(1, Enum.EasingStyle.Quart), {ImageTransparency = 1}):Play()
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
    mainFrame.Size = UDim2.new(0, 350, 0, 250)  -- حجم أصغر للجوال
    mainFrame.Position = UDim2.new(0.5, -175, 0.5, -125)
    mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    mainFrame.BorderSizePixel = 0
    mainFrame.Parent = screenGui
    mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    
    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(0, 20)
    uiCorner.Parent = mainFrame
    
    local uiStroke = Instance.new("UIStroke")
    uiStroke.Color = Color3.fromRGB(255, 0, 0)
    uiStroke.Thickness = 3
    uiStroke.Parent = mainFrame
    
    local frameGlow = Instance.new("ImageLabel")
    frameGlow.Name = "FrameGlow"
    frameGlow.Size = UDim2.new(1.1, 0, 1.1, 0)
    frameGlow.Position = UDim2.new(-0.05, 0, -0.05, 0)
    frameGlow.BackgroundTransparency = 1
    frameGlow.Image = "rbxassetid://5028857084"
    frameGlow.ImageColor3 = Color3.fromRGB(255, 0, 0)
    frameGlow.ImageTransparency = 0.7
    frameGlow.ZIndex = -1
    frameGlow.Parent = mainFrame
    
    local topIcon = Instance.new("ImageLabel")
    topIcon.Name = "TopIcon"
    topIcon.Size = UDim2.new(0, 60, 0, 60)  -- أيقونة أصغر
    topIcon.Position = UDim2.new(0.5, -30, 0, 20)
    topIcon.BackgroundTransparency = 1
    topIcon.Image = scriptIcon
    topIcon.Parent = mainFrame
    
    local iconGlow = Instance.new("ImageLabel")
    iconGlow.Name = "IconGlow"
    iconGlow.Size = UDim2.new(1.2, 0, 1.2, 0)
    iconGlow.Position = UDim2.new(-0.1, 0, -0.1, 0)
    iconGlow.BackgroundTransparency = 1
    iconGlow.Image = "rbxassetid://5028857084"
    iconGlow.ImageColor3 = Color3.fromRGB(255, 0, 0)
    iconGlow.ImageTransparency = 0.5
    iconGlow.ZIndex = -1
    iconGlow.Parent = topIcon
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "TitleLabel"
    titleLabel.Size = UDim2.new(1, 0, 0, 40)
    titleLabel.Position = UDim2.new(0, 0, 0, 85)
    titleLabel.BackgroundTransparency = 1
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.TextSize = 24  -- نص أصغر
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.Text = "Select Your Language"
    titleLabel.Parent = mainFrame
    
    local titleGradient = Instance.new("UIGradient")
    titleGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 0, 0)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
    })
    titleGradient.Parent = titleLabel
    
    -- ترتيب الأزرار عمودياً في المنتصف
    local arabicButton = Instance.new("Frame")
    arabicButton.Name = "ArabicButton"
    arabicButton.Size = UDim2.new(0.8, 0, 0, 50)  -- أزرار أصغر
    arabicButton.Position = UDim2.new(0.1, 0, 0.5, -30)  -- توسيط
    arabicButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    arabicButton.Parent = mainFrame
    
    local arabicCorner = Instance.new("UICorner")
    arabicCorner.CornerRadius = UDim.new(0, 15)
    arabicCorner.Parent = arabicButton
    
    local arabicStroke = Instance.new("UIStroke")
    arabicStroke.Color = Color3.fromRGB(150, 0, 0)
    arabicStroke.Thickness = 2
    arabicStroke.Transparency = 0.5
    arabicStroke.Parent = arabicButton
    
    local arabicIconImage = Instance.new("ImageLabel")
    arabicIconImage.Name = "ArabicIcon"
    arabicIconImage.Size = UDim2.new(0, 35, 0, 35)  
    arabicIconImage.Position = UDim2.new(0, 10, 0.5, -17.5)
    arabicIconImage.BackgroundTransparency = 1
    arabicIconImage.Image = arabicIcon
    arabicIconImage.Parent = arabicButton
    
    local arabicGlow = Instance.new("ImageLabel")
    arabicGlow.Name = "ArabicGlow"
    arabicGlow.Size = UDim2.new(1.2, 0, 1.2, 0)
    arabicGlow.Position = UDim2.new(-0.1, 0, -0.1, 0)
    arabicGlow.BackgroundTransparency = 1
    arabicGlow.Image = "rbxassetid://5028857084"
    arabicGlow.ImageColor3 = Color3.fromRGB(255, 0, 0)
    arabicGlow.ImageTransparency = 0.8
    arabicGlow.ZIndex = 0
    arabicGlow.Parent = arabicIconImage
    
    local arabicText = Instance.new("TextLabel")
    arabicText.Name = "ArabicText"
    arabicText.Size = UDim2.new(1, -50, 1, 0)
    arabicText.Position = UDim2.new(0, 50, 0, 0)
    arabicText.BackgroundTransparency = 1
    arabicText.TextColor3 = Color3.fromRGB(255, 255, 255)
    arabicText.TextSize = 20 
    arabicText.Font = Enum.Font.GothamBold
    arabicText.Text = "Arabic"
    arabicText.TextXAlignment = Enum.TextXAlignment.Left
    arabicText.Parent = arabicButton
    
    local arabicClickDetector = Instance.new("TextButton")
    arabicClickDetector.Name = "ArabicClickDetector"
    arabicClickDetector.Size = UDim2.new(1, 0, 1, 0)
    arabicClickDetector.BackgroundTransparency = 1
    arabicClickDetector.Text = ""
    arabicClickDetector.Parent = arabicButton
    
    local englishButton = Instance.new("Frame")
    englishButton.Name = "EnglishButton"
    englishButton.Size = UDim2.new(0.8, 0, 0, 50)  
    englishButton.Position = UDim2.new(0.1, 0, 0.5, 30) 
    englishButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    englishButton.Parent = mainFrame
    
    local englishCorner = Instance.new("UICorner")
    englishCorner.CornerRadius = UDim.new(0, 15)
    englishCorner.Parent = englishButton
    
    local englishStroke = Instance.new("UIStroke")
    englishStroke.Color = Color3.fromRGB(150, 0, 0)
    englishStroke.Thickness = 2
    englishStroke.Transparency = 0.5
    englishStroke.Parent = englishButton
    
    local englishIconImage = Instance.new("ImageLabel")
    englishIconImage.Name = "EnglishIcon"
    englishIconImage.Size = UDim2.new(0, 35, 0, 35)  
    englishIconImage.Position = UDim2.new(0, 10, 0.5, -17.5)
    englishIconImage.BackgroundTransparency = 1
    englishIconImage.Image = englishIcon
    englishIconImage.Parent = englishButton
    
    local englishGlow = Instance.new("ImageLabel")
    englishGlow.Name = "EnglishGlow"
    englishGlow.Size = UDim2.new(1.2, 0, 1.2, 0)
    englishGlow.Position = UDim2.new(-0.1, 0, -0.1, 0)
    englishGlow.BackgroundTransparency = 1
    englishGlow.Image = "rbxassetid://5028857084"
    englishGlow.ImageColor3 = Color3.fromRGB(255, 0, 0)
    englishGlow.ImageTransparency = 0.8
    englishGlow.ZIndex = 0
    englishGlow.Parent = englishIconImage
    
    local englishText = Instance.new("TextLabel")
    englishText.Name = "EnglishText"
    englishText.Size = UDim2.new(1, -50, 1, 0)
    englishText.Position = UDim2.new(0, 50, 0, 0)
    englishText.BackgroundTransparency = 1
   englishText.TextColor3 = Color3.fromRGB(255, 255, 255)
   englishText.TextSize = 20 
   englishText.Font = Enum.Font.GothamBold
   englishText.Text = "English"
   englishText.TextXAlignment = Enum.TextXAlignment.Left
   englishText.Parent = englishButton
   
   local englishClickDetector = Instance.new("TextButton")
   englishClickDetector.Name = "EnglishClickDetector"
   englishClickDetector.Size = UDim2.new(1, 0, 1, 0)
   englishClickDetector.BackgroundTransparency = 1
   englishClickDetector.Text = ""
   englishClickDetector.Parent = englishButton
   
   local divider = Instance.new("Frame")
   divider.Name = "Divider"
   divider.Size = UDim2.new(0.8, 0, 0, 2)
   divider.Position = UDim2.new(0.1, 0, 1, -40)
   divider.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
   divider.BorderSizePixel = 0
   divider.Parent = mainFrame
   
   local dividerGradient = Instance.new("UIGradient")
   dividerGradient.Color = ColorSequence.new({
       ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
       ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)),
       ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))
   })
   dividerGradient.Parent = divider
   
   local scriptInfo = Instance.new("TextLabel")
   scriptInfo.Name = "ScriptInfo"
   scriptInfo.Size = UDim2.new(0.9, 0, 0, 25)
   scriptInfo.Position = UDim2.new(0.05, 0, 1, -30)
   scriptInfo.BackgroundTransparency = 1
   scriptInfo.TextColor3 = Color3.fromRGB(200, 200, 200)
   scriptInfo.TextSize = 14 
   scriptInfo.Font = Enum.Font.GothamSemibold
   scriptInfo.Text = "GUI BY: FRONT-EVILL | Script By: front-evill / 7sone"
   scriptInfo.TextXAlignment = Enum.TextXAlignment.Center
   scriptInfo.Parent = mainFrame
   
   local particles = Instance.new("Frame")
   particles.Name = "Particles"
   particles.Size = UDim2.new(1, 0, 1, 0)
   particles.BackgroundTransparency = 1
   particles.ZIndex = 0
   particles.Parent = mainFrame
   
   for i = 1, 15 do 
       local particle = Instance.new("Frame")
       particle.Name = "Particle" .. i
       particle.Size = UDim2.new(0, math.random(2, 3), 0, math.random(2, 3))
       particle.Position = UDim2.new(math.random(), 0, math.random(), 0)
       particle.BackgroundColor3 = Color3.fromRGB(255, math.random(0, 100), 0)
       particle.BackgroundTransparency = math.random(0.4, 0.8)
       particle.BorderSizePixel = 0
       particle.ZIndex = 0
       particle.Parent = particles
       
       local particleCorner = Instance.new("UICorner")
       particleCorner.CornerRadius = UDim.new(1, 0)
       particleCorner.Parent = particle
       
       local randomDuration = math.random(4, 7)
       local randomX = math.random() - 0.5
       local randomY = math.random() - 0.5
       
       spawn(function()
           while particle.Parent do
               local moveParticle = game:GetService("TweenService"):Create(
                   particle, 
                   TweenInfo.new(randomDuration, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), 
                   {Position = UDim2.new(math.clamp(particle.Position.X.Scale + randomX, 0, 1), 0, math.clamp(particle.Position.Y.Scale + randomY, 0, 1), 0)}
               )
               moveParticle:Play()
               moveParticle.Completed:Wait()
               
               randomX = math.random() - 0.5
               randomY = math.random() - 0.5
           end
       end)
       
       spawn(function()
           while particle.Parent do
               local pulseParticle = game:GetService("TweenService"):Create(
                   particle, 
                   TweenInfo.new(math.random(2, 4), Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), 
                   {BackgroundTransparency = math.random(0.4, 0.9)}
               )
               pulseParticle:Play()
               wait(math.random(2, 4))
           end
       end)
   end
   
   spawn(function()
       while divider.Parent do
           local gradientMove = game:GetService("TweenService"):Create(
               dividerGradient, 
               TweenInfo.new(3, Enum.EasingStyle.Linear), 
               {Offset = Vector2.new(1, 0)}
           )
           dividerGradient.Offset = Vector2.new(-1, 0)
           gradientMove:Play()
           wait(3)
       end
   end)
   
   spawn(function()
       while titleGradient.Parent do
           local gradientMove = game:GetService("TweenService"):Create(
               titleGradient, 
               TweenInfo.new(3, Enum.EasingStyle.Linear), 
               {Offset = Vector2.new(1, 0)}
           )
           titleGradient.Offset = Vector2.new(-1, 0)
           gradientMove:Play()
           wait(3)
       end
   end)
   
   local pulseIconGlow = function()
       local fadeIn = game:GetService("TweenService"):Create(
           iconGlow, 
           TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), 
           {ImageTransparency = 0.3, Size = UDim2.new(1.3, 0, 1.3, 0)}
       )
       local fadeOut = game:GetService("TweenService"):Create(
           iconGlow, 
           TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), 
           {ImageTransparency = 0.7, Size = UDim2.new(1.1, 0, 1.1, 0)}
       )
       
       fadeIn:Play()
       fadeIn.Completed:Connect(function()
           if iconGlow.Parent then
               fadeOut:Play()
               fadeOut.Completed:Connect(function()
                   if iconGlow.Parent then
                       fadeIn:Play()
                   end
               end)
           end
       end)
   end
   
   local rotateIcon = function()
       while topIcon.Parent do
           local rotation = game:GetService("TweenService"):Create(
               topIcon, 
               TweenInfo.new(8, Enum.EasingStyle.Linear), 
               {Rotation = topIcon.Rotation + 360}
           )
           rotation:Play()
           wait(8)
       end
   end
   
   local pulseFrameGlow = function()
       local fadeIn = game:GetService("TweenService"):Create(
           frameGlow, 
           TweenInfo.new(2.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), 
           {ImageTransparency = 0.5, Size = UDim2.new(1.12, 0, 1.12, 0)}
       )
       local fadeOut = game:GetService("TweenService"):Create(
           frameGlow, 
           TweenInfo.new(2.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), 
           {ImageTransparency = 0.8, Size = UDim2.new(1.08, 0, 1.08, 0)}
       )
       
       fadeIn:Play()
       fadeIn.Completed:Connect(function()
           if frameGlow.Parent then
               fadeOut:Play()
               fadeOut.Completed:Connect(function()
                   if frameGlow.Parent then
                       fadeIn:Play()
                   end
               end)
           end
       end)
   end
   
   spawn(pulseIconGlow)
   spawn(rotateIcon)
   spawn(pulseFrameGlow)
   
   mainFrame.Position = mainFrame.Position + UDim2.new(0, 0, 0.3, 0)
   mainFrame.BackgroundTransparency = 1
   topIcon.ImageTransparency = 1
   titleLabel.TextTransparency = 1
   arabicButton.BackgroundTransparency = 1
   arabicText.TextTransparency = 1
   arabicIconImage.ImageTransparency = 1
   arabicStroke.Transparency = 1
   englishButton.BackgroundTransparency = 1
   englishText.TextTransparency = 1
   englishIconImage.ImageTransparency = 1
   englishStroke.Transparency = 1
   scriptInfo.TextTransparency = 1
   divider.BackgroundTransparency = 1
   uiStroke.Transparency = 1
   frameGlow.ImageTransparency = 1
   
   game:GetService("TweenService"):Create(mainFrame, TweenInfo.new(0.8, Enum.EasingStyle.Bounce), {Position = UDim2.new(0.5, -175, 0.5, -125), BackgroundTransparency = 0}):Play()
   wait(0.1)
   game:GetService("TweenService"):Create(uiStroke, TweenInfo.new(0.6, Enum.EasingStyle.Quart), {Transparency = 0}):Play()
   game:GetService("TweenService"):Create(frameGlow, TweenInfo.new(0.6, Enum.EasingStyle.Quart), {ImageTransparency = 0.7}):Play()
   wait(0.1)
   game:GetService("TweenService"):Create(topIcon, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {ImageTransparency = 0}):Play()
   wait(0.1)
   game:GetService("TweenService"):Create(titleLabel, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {TextTransparency = 0}):Play()
   wait(0.1)
   game:GetService("TweenService"):Create(arabicButton, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {BackgroundTransparency = 0}):Play()
   game:GetService("TweenService"):Create(arabicText, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {TextTransparency = 0}):Play()
   game:GetService("TweenService"):Create(arabicIconImage, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {ImageTransparency = 0}):Play()
   game:GetService("TweenService"):Create(arabicStroke, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {Transparency = 0.5}):Play()
   wait(0.1)
   game:GetService("TweenService"):Create(englishButton, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {BackgroundTransparency = 0}):Play()
   game:GetService("TweenService"):Create(englishText, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {TextTransparency = 0}):Play()
   game:GetService("TweenService"):Create(englishIconImage, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {ImageTransparency = 0}):Play()
   game:GetService("TweenService"):Create(englishStroke, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {Transparency = 0.5}):Play()
   wait(0.1)
   game:GetService("TweenService"):Create(scriptInfo, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {TextTransparency = 0}):Play()
   game:GetService("TweenService"):Create(divider, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {BackgroundTransparency = 0}):Play()
   
   arabicClickDetector.MouseEnter:Connect(function()
       game:GetService("TweenService"):Create(arabicButton, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {BackgroundColor3 = Color3.fromRGB(255, 0, 0)}):Play()
       game:GetService("TweenService"):Create(arabicText, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {TextSize = 22}):Play()
       game:GetService("TweenService"):Create(arabicButton, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0.82, 0, 0, 52)}):Play()
       game:GetService("TweenService"):Create(arabicStroke, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {Transparency = 0}):Play()
       game:GetService("TweenService"):Create(arabicGlow, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {ImageTransparency = 0.5}):Play()
   end)
   
   arabicClickDetector.MouseLeave:Connect(function()
       game:GetService("TweenService"):Create(arabicButton, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}):Play()
       game:GetService("TweenService"):Create(arabicText, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {TextSize = 20}):Play()
       game:GetService("TweenService"):Create(arabicButton, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0.8, 0, 0, 50)}):Play()
       game:GetService("TweenService"):Create(arabicStroke, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {Transparency = 0.5}):Play()
       game:GetService("TweenService"):Create(arabicGlow, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {ImageTransparency = 0.8}):Play()
   end)
   
   englishClickDetector.MouseEnter:Connect(function()
       game:GetService("TweenService"):Create(englishButton, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {BackgroundColor3 = Color3.fromRGB(255, 0, 0)}):Play()
       game:GetService("TweenService"):Create(englishText, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {TextSize = 22}):Play()
       game:GetService("TweenService"):Create(englishButton, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0.82, 0, 0, 52)}):Play()
       game:GetService("TweenService"):Create(englishStroke, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {Transparency = 0}):Play()
       game:GetService("TweenService"):Create(englishGlow, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {ImageTransparency = 0.5}):Play()
   end)
   
   englishClickDetector.MouseLeave:Connect(function()
       game:GetService("TweenService"):Create(englishButton, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}):Play()
       game:GetService("TweenService"):Create(englishText, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {TextSize = 20}):Play()
       game:GetService("TweenService"):Create(englishButton, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0.8, 0, 0, 50)}):Play()
       game:GetService("TweenService"):Create(englishStroke, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {Transparency = 0.5}):Play()
       game:GetService("TweenService"):Create(englishGlow, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {ImageTransparency = 0.8}):Play()
   end)
   
   arabicClickDetector.MouseButton1Click:Connect(function()
       local clickEffect = game:GetService("TweenService"):Create(arabicButton, TweenInfo.new(0.15, Enum.EasingStyle.Quart), {Size = UDim2.new(0.76, 0, 0, 48), BackgroundTransparency = 0.2})
       clickEffect:Play()
       wait(0.15)
       game:GetService("TweenService"):Create(arabicButton, TweenInfo.new(0.15, Enum.EasingStyle.Quart), {Size = UDim2.new(0.8, 0, 0, 50), BackgroundTransparency = 0}):Play()
       
       local brightnessEffect = Instance.new("ColorCorrectionEffect")
       brightnessEffect.Brightness = 0
       brightnessEffect.Parent = game:GetService("Lighting")
       
       game:GetService("TweenService"):Create(brightnessEffect, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {Brightness = 0.2}):Play()
       
       game:GetService("TweenService"):Create(mainFrame, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Position = UDim2.new(0.5, -175, 1.5, 0), BackgroundTransparency = 1}):Play()
       game:GetService("TweenService"):Create(uiStroke, TweenInfo.new(0.6, Enum.EasingStyle.Quart), {Transparency = 1}):Play()
       game:GetService("TweenService"):Create(frameGlow, TweenInfo.new(0.6, Enum.EasingStyle.Quart), {ImageTransparency = 1}):Play()
       
       createNotification("تم تشغيل السكربت باللغة العربية ✓", 5)
       
       wait(0.6)
       game:GetService("TweenService"):Create(brightnessEffect, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {Brightness = 0}):Play()
       
       loadstring(game:HttpGet("https://raw.githubusercontent.com/Front-Evill/Script-Hub/refs/heads/main/GUI/brookhavan.arabic.lua"))()
       
       wait(0.3)
       brightnessEffect:Destroy()
       mainFrame:Destroy()
   end)
   
   englishClickDetector.MouseButton1Click:Connect(function()
       local clickEffect = game:GetService("TweenService"):Create(englishButton, TweenInfo.new(0.15, Enum.EasingStyle.Quart), {Size = UDim2.new(0.76, 0, 0, 48), BackgroundTransparency = 0.2})
       clickEffect:Play()
       wait(0.15)
       game:GetService("TweenService"):Create(englishButton, TweenInfo.new(0.15, Enum.EasingStyle.Quart), {Size = UDim2.new(0.8, 0, 0, 50), BackgroundTransparency = 0}):Play()
       
       local brightnessEffect = Instance.new("ColorCorrectionEffect")
       brightnessEffect.Brightness = 0
       brightnessEffect.Parent = game:GetService("Lighting")
       
       game:GetService("TweenService"):Create(brightnessEffect, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {Brightness = 0.2}):Play()
       
       game:GetService("TweenService"):Create(mainFrame, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Position = UDim2.new(0.5, -175, 1.5, 0), BackgroundTransparency = 1}):Play()
       game:GetService("TweenService"):Create(uiStroke, TweenInfo.new(0.6, Enum.EasingStyle.Quart), {Transparency = 1}):Play()
       game:GetService("TweenService"):Create(frameGlow, TweenInfo.new(0.6, Enum.EasingStyle.Quart), {ImageTransparency = 1}):Play()

       createNotification("Script launched in English ✓", 5)
      
       wait(0.6)
       game:GetService("TweenService"):Create(brightnessEffect, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {Brightness = 0}):Play()
      
       loadstring(game:HttpGet("https://raw.githubusercontent.com/Front-Evill/Script-Hub/refs/heads/main/Brookhavan.evill.lua"))()
      
       wait(0.3)
       brightnessEffect:Destroy()
       mainFrame:Destroy()
   end)
end

typewriterEffect("Welcome to Front Evill Script 🔥👀")
