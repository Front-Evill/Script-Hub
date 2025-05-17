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

local function createParticles()
    local particleContainer = Instance.new("Frame")
    particleContainer.Name = "ParticleContainer"
    particleContainer.Size = UDim2.new(1, 0, 1, 0)
    particleContainer.BackgroundTransparency = 1
    particleContainer.ZIndex = 1
    particleContainer.Parent = screenGui
    
    for i = 1, 20 do
        local particle = Instance.new("Frame")
        particle.Name = "Particle" .. i
        local size = math.random(5, 20)
        particle.Size = UDim2.new(0, size, 0, size)
        particle.Position = UDim2.new(math.random(), 0, math.random(), 0)
        particle.BackgroundColor3 = Color3.fromHSV(math.random() * 0.1 + 0.9, 0.7, 1) -- رمادي مائل للأحمر
        particle.BackgroundTransparency = math.random() * 0.5 + 0.2
        particle.ZIndex = 2
        particle.Parent = particleContainer
        
        local uiCorner = Instance.new("UICorner")
        uiCorner.CornerRadius = UDim.new(1, 0)
        uiCorner.Parent = particle
        
        local glow = Instance.new("UIGradient")
        glow.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))
        })
        glow.Rotation = math.random(0, 360)
        glow.Parent = particle
        
        spawn(function()
            local speedX = (math.random() - 0.5) * 0.005
            local speedY = (math.random() - 0.5) * 0.005
            
            while particle.Parent do
                local posX = particle.Position.X.Scale
                local posY = particle.Position.Y.Scale
                
                posX = posX + speedX
                posY = posY + speedY
                
                if posX > 1 then posX = 0 elseif posX < 0 then posX = 1 end
                if posY > 1 then posY = 0 elseif posY < 0 then posY = 1 end
                
                particle.Position = UDim2.new(posX, 0, posY, 0)
                
                local pulseSize = size + math.sin(tick() * math.random(1, 3)) * 3
                particle.Size = UDim2.new(0, pulseSize, 0, pulseSize)
                
                local transparency = 0.2 + math.abs(math.sin(tick() * 0.5)) * 0.3
                particle.BackgroundTransparency = transparency
                
                local hue = (tick() * 0.05) % 0.1 + 0.9
                glow.Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, Color3.fromHSV(hue, 0.7, 1)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))
                })
                
                wait()
            end
        end)
    end
    
    return particleContainer
end

local function createLightEffect(parent, position, color)
    local light = Instance.new("ImageLabel")
    light.Name = "LightEffect"
    light.Size = UDim2.new(0, 250, 0, 250)
    light.Position = position - UDim2.new(0, 125, 0, 125)
    light.BackgroundTransparency = 1
    light.Image = "rbxassetid://6014261993" -- صورة توهج دائرية
    light.ImageColor3 = color or Color3.fromRGB(255, 0, 0)
    light.ImageTransparency = 0.85
    light.ZIndex = 1
    light.Parent = parent
    
    spawn(function()
        while light.Parent do
            for i = 0.85, 0.75, -0.01 do
                if not light or not light.Parent then break end
                light.ImageTransparency = i
                wait(0.05)
            end
            for i = 0.75, 0.85, 0.01 do
                if not light or not light.Parent then break end
                light.ImageTransparency = i
                wait(0.05)
            end
        end
    end)
    
    return light
end

local function createNotification(text, duration)
    duration = duration or 3
    
    local notification = Instance.new("Frame")
    notification.Name = "Notification"
    notification.Size = UDim2.new(0, 280, 0, 70)
    notification.Position = UDim2.new(0.5, -140, 0.85, 0)
    notification.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    notification.BorderSizePixel = 0
    notification.BackgroundTransparency = 0.1
    notification.Parent = screenGui
    
    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(0, 12)
    uiCorner.Parent = notification
    
    local uiStroke = Instance.new("UIStroke")
    uiStroke.Color = Color3.fromRGB(255, 0, 0)
    uiStroke.Thickness = 2.5
    uiStroke.Parent = notification
    
    createLightEffect(notification, UDim2.new(0.5, 0, 0.5, 0))
    
    local iconImage = Instance.new("ImageLabel")
    iconImage.Name = "NotifIcon"
    iconImage.Size = UDim2.new(0, 45, 0, 45)
    iconImage.Position = UDim2.new(0, 15, 0.5, -22)
    iconImage.BackgroundTransparency = 1
    iconImage.Image = scriptIcon
    iconImage.Parent = notification
    
    spawn(function()
        while iconImage.Parent do
            iconImage.Rotation = (iconImage.Rotation + 1) % 360
            wait(0.05)
        end
    end)
    
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
    
    spawn(function()
        local originalTextSize = 18
        while notifText.Parent do
            for i = originalTextSize, originalTextSize + 1, 0.1 do
                if not notifText or not notifText.Parent then break end
                notifText.TextSize = i
                wait(0.05)
            end
            for i = originalTextSize + 1, originalTextSize, -0.1 do
                if not notifText or not notifText.Parent then break end
                notifText.TextSize = i
                wait(0.05)
            end
        end
    end)
    
    notification.BackgroundTransparency = 1
    uiStroke.Transparency = 1
    notifText.TextTransparency = 1
    iconImage.ImageTransparency = 1
    
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
    local particles = createParticles()
    
    local background = Instance.new("Frame")
    background.Name = "WelcomeScreen"
    background.Size = UDim2.new(1, 0, 1, 0)
    background.BackgroundColor3 = Color3.fromRGB(10, 10, 10) -- خلفية أغمق
    background.BackgroundTransparency = 0.2
    background.BorderSizePixel = 0
    background.ZIndex = 5
    background.Parent = screenGui
    
    local gradient = Instance.new("UIGradient")
    gradient.Rotation = 45
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 20, 20)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(30, 0, 0)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 15, 15))
    })
    gradient.Parent = background
    
    spawn(function()
        local startTime = tick()
        while background.Parent do
            local elapsed = tick() - startTime
            gradient.Rotation = 45 + math.sin(elapsed * 0.5) * 10
            wait()
        end
    end)
    
    game:GetService("TweenService"):Create(background, TweenInfo.new(0.8, Enum.EasingStyle.Quart), {BackgroundTransparency = 0.1}):Play()
    
    local light1 = createLightEffect(background, UDim2.new(0.3, 0, 0.2, 0), Color3.fromRGB(255, 50, 50))
    local light2 = createLightEffect(background, UDim2.new(0.7, 0, 0.8, 0), Color3.fromRGB(255, 50, 50))
    
    local blur = Instance.new("BlurEffect")
    blur.Size = 0
    blur.Parent = game:GetService("Lighting")
    
    game:GetService("TweenService"):Create(blur, TweenInfo.new(0.8, Enum.EasingStyle.Quart), {Size = 20}):Play()
    
    local logoContainer = Instance.new("Frame")
    logoContainer.Name = "LogoContainer"
    logoContainer.Size = UDim2.new(0, 150, 0, 150)
    logoContainer.Position = UDim2.new(0.5, -75, 0.25, -75)
    logoContainer.BackgroundTransparency = 1
    logoContainer.ZIndex = 10
    logoContainer.Parent = background
    
    local logoGlow = Instance.new("ImageLabel")
    logoGlow.Name = "LogoGlow"
    logoGlow.Size = UDim2.new(1.5, 0, 1.5, 0)
    logoGlow.Position = UDim2.new(-0.25, 0, -0.25, 0)
    logoGlow.BackgroundTransparency = 1
    logoGlow.Image = "rbxassetid://6014261993"
    logoGlow.ImageColor3 = Color3.fromRGB(255, 0, 0)
    logoGlow.ImageTransparency = 0.7
    logoGlow.ZIndex = 9
    logoGlow.Parent = logoContainer
    
    spawn(function()
        while logoGlow.Parent do
            for i = 0.7, 0.5, -0.01 do
                if not logoGlow or not logoGlow.Parent then break end
                logoGlow.ImageTransparency = i
                logoGlow.Size = UDim2.new(1.5 + ((0.7 - i) * 0.4), 0, 1.5 + ((0.7 - i) * 0.4), 0)
                logoGlow.Position = UDim2.new(-0.25 - ((0.7 - i) * 0.2), 0, -0.25 - ((0.7 - i) * 0.2), 0)
                wait(0.03)
            end
            for i = 0.5, 0.7, 0.01 do
                if not logoGlow or not logoGlow.Parent then break end
                logoGlow.ImageTransparency = i
                logoGlow.Size = UDim2.new(1.5 + ((0.7 - i) * 0.4), 0, 1.5 + ((0.7 - i) * 0.4), 0)
                logoGlow.Position = UDim2.new(-0.25 - ((0.7 - i) * 0.2), 0, -0.25 - ((0.7 - i) * 0.2), 0)
                wait(0.03)
            end
        end
    end)
    
    local logoImage = Instance.new("ImageLabel")
    logoImage.Name = "LogoImage"
    logoImage.Size = UDim2.new(1, 0, 1, 0)
    logoImage.BackgroundTransparency = 1
    logoImage.Image = scriptIcon
    logoImage.ImageTransparency = 1
    logoImage.ZIndex = 10
    logoImage.Parent = logoContainer

    spawn(function()
        while logoImage.Parent do
            logoImage.Rotation = (logoImage.Rotation + 0.5) % 360
            wait(0.02)
        end
    end)
    
    game:GetService("TweenService"):Create(logoImage, TweenInfo.new(1, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {ImageTransparency = 0}):Play()
    
    local welcomeContainer = Instance.new("Frame")
    welcomeContainer.Name = "WelcomeContainer"
    welcomeContainer.Size = UDim2.new(0.8, 0, 0.2, 0)
    welcomeContainer.Position = UDim2.new(0.1, 0, 0.45, 0)
    welcomeContainer.BackgroundTransparency = 1
    welcomeContainer.ZIndex = 10
    welcomeContainer.Parent = background
    
    local textGlow = Instance.new("ImageLabel")
    textGlow.Name = "TextGlow"
    textGlow.Size = UDim2.new(1.2, 0, 2, 0)
    textGlow.Position = UDim2.new(-0.1, 0, -0.5, 0)
    textGlow.BackgroundTransparency = 1
    textGlow.Image = "rbxassetid://6014261993"
    textGlow.ImageColor3 = Color3.fromRGB(255, 0, 0)
    textGlow.ImageTransparency = 0.8
    textGlow.ZIndex = 9
    textGlow.Parent = welcomeContainer
    
    local welcomeText = Instance.new("TextLabel")
    welcomeText.Name = "WelcomeText"
    welcomeText.Size = UDim2.new(1, 0, 1, 0)
    welcomeText.BackgroundTransparency = 1
    welcomeText.TextColor3 = Color3.fromRGB(255, 255, 255) 
    welcomeText.TextStrokeColor3 = Color3.fromRGB(255, 0, 0) 
    welcomeText.TextStrokeTransparency = 0.5
    welcomeText.TextSize = 40
    welcomeText.Font = Enum.Font.GothamBold
    welcomeText.Text = ""
    welcomeText.TextWrapped = true
    welcomeText.ZIndex = 10
    welcomeText.Parent = welcomeContainer
    
    spawn(function()
        local originalTextSize = 40
        while welcomeText.Parent do
            for i = originalTextSize, originalTextSize + 2, 0.1 do
                if not welcomeText or not welcomeText.Parent then break end
                welcomeText.TextSize = i
                wait(0.02)
            end
            for i = originalTextSize + 2, originalTextSize, -0.1 do
                if not welcomeText or not welcomeText.Parent then break end
                welcomeText.TextSize = i
                wait(0.02)
            end
        end
    end)
    
    local subText = Instance.new("TextLabel")
    subText.Name = "SubText"
    subText.Size = UDim2.new(0.6, 0, 0.1, 0)
    subText.Position = UDim2.new(0.2, 0, 0.62, 0)
    subText.BackgroundTransparency = 1
    subText.TextColor3 = Color3.fromRGB(200, 200, 200)
    subText.TextStrokeColor3 = Color3.fromRGB(255, 0, 0)
    subText.TextStrokeTransparency = 0.7
    subText.TextSize = 22
    subText.Font = Enum.Font.Gotham
    subText.Text = "Created by Front-Evill"
    subText.TextTransparency = 1
    subText.ZIndex = 10
    subText.Parent = background
    
    spawn(function()
        while subText.Parent do
            for i = 1, 0.95, -0.01 do
                if not subText or not subText.Parent then break end
                subText.TextTransparency = i
                wait(0.05)
            end
            for i = 0.95, 1, 0.01 do
                if not subText or not subText.Parent then break end
                subText.TextTransparency = i
                wait(0.05)
            end
        end
    end)
    
    local rainContainer = Instance.new("Frame")
    rainContainer.Name = "RainContainer"
    rainContainer.Size = UDim2.new(1, 0, 1, 0)
    rainContainer.BackgroundTransparency = 1
    rainContainer.ZIndex = 6
    rainContainer.Parent = background
    
    for i = 1, 50 do
        spawn(function()
            while rainContainer.Parent do
                local rainDrop = Instance.new("Frame")
                rainDrop.Name = "RainDrop" .. i
                rainDrop.Size = UDim2.new(0, math.random(1, 3), 0, math.random(5, 20))
                rainDrop.Position = UDim2.new(math.random(), 0, -0.05, 0)
                rainDrop.BackgroundColor3 = Color3.fromHSV(0, math.random() * 0.5, 1) -- أحمر متفاوت
                rainDrop.BackgroundTransparency = math.random() * 0.3 + 0.5
                rainDrop.BorderSizePixel = 0
                rainDrop.ZIndex = 7
                rainDrop.Parent = rainContainer
                
                local speed = math.random() * 0.005 + 0.003
                
                spawn(function()
                    while rainDrop and rainDrop.Parent do
                        rainDrop.Position = UDim2.new(rainDrop.Position.X.Scale, 0, rainDrop.Position.Y.Scale + speed, 0)
                        
                        if rainDrop.Position.Y.Scale > 1 then
                            rainDrop:Destroy()
                            break
                        end
                        wait()
                    end
                end)
                
                wait(math.random() * 2)
            end
        end)
    end
    
    game:GetService("TweenService"):Create(subText, TweenInfo.new(1, Enum.EasingStyle.Quart), {TextTransparency = 0.2}):Play()
    
    spawn(function()
        for i = 1, #text do
            welcomeText.Text = string.sub(text, 1, i)
            wait(0.05)
        end
        
        wait(1.5)
        
        game:GetService("TweenService"):Create(background, TweenInfo.new(1, Enum.EasingStyle.Quart), {BackgroundTransparency = 1}):Play()
        game:GetService("TweenService"):Create(welcomeText, TweenInfo.new(1, Enum.EasingStyle.Quart), {TextTransparency = 1}):Play()
        game:GetService("TweenService"):Create(logoImage, TweenInfo.new(1, Enum.EasingStyle.Quart), {ImageTransparency = 1}):Play()
        game:GetService("TweenService"):Create(logoGlow, TweenInfo.new(1, Enum.EasingStyle.Quart), {ImageTransparency = 1}):Play()
        game:GetService("TweenService"):Create(subText, TweenInfo.new(1, Enum.EasingStyle.Quart), {TextTransparency = 1}):Play()
        game:GetService("TweenService"):Create(blur, TweenInfo.new(1, Enum.EasingStyle.Quart), {Size = 0}):Play()
        game:GetService("TweenService"):Create(textGlow, TweenInfo.new(1, Enum.EasingStyle.Quart), {ImageTransparency = 1}):Play()
        
        wait(1)
        showLanguageSelector()
        
        wait(0.5)
        background:Destroy()
        blur:Destroy()
        particles:Destroy()
        rainContainer:Destroy()
    end)
end

function showLanguageSelector()
    local particles = createParticles()
    
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "LanguageSelector"
    mainFrame.Size = UDim2.new(0, 450, 0, 300)
    mainFrame.Position = UDim2.new(0.5, -225, 0.5, -150)
    mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    mainFrame.BorderSizePixel = 0
    mainFrame.Parent = screenGui
    mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    mainFrame.ZIndex = 10
    
    local frameGradient = Instance.new("UIGradient")
    frameGradient.Rotation = 45
    frameGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 20, 20)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(40, 0, 0)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 15, 15))
    })
    frameGradient.Parent = mainFrame
    
    spawn(function()
        local startTime = tick()
        while mainFrame.Parent do
            local elapsed = tick() - startTime
            frameGradient.Rotation = 45 + math.sin(elapsed * 0.5) * 10
            wait()
        end
    end)
    
    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(0, 20)
    uiCorner.Parent = mainFrame
    
    local uiStroke = Instance.new("UIStroke")
    uiStroke.Color = Color3.fromRGB(255, 0, 0)
    uiStroke.Thickness = 3
    uiStroke.Parent = mainFrame
    
    local frameLight1 = createLightEffect(mainFrame, UDim2.new(0.2, 0, 0.2, 0), Color3.fromRGB(255, 0, 0))
    local frameLight2 = createLightEffect(mainFrame, UDim2.new(0.8, 0, 0.8, 0), Color3.fromRGB(255, 0, 0))
    
    local topIconContainer = Instance.new("Frame")
    topIconContainer.Name = "TopIconContainer"
    topIconContainer.Size = UDim2.new(0, 80, 0, 80)
    topIconContainer.Position = UDim2.new(0.5, -40, 0, 20)
    topIconContainer.BackgroundTransparency = 1
    topIconContainer.ZIndex = 12
    topIconContainer.Parent = mainFrame
    
    local iconGlow = Instance.new("ImageLabel")
    iconGlow.Name = "IconGlow"
    iconGlow.Size = UDim2.new(1.5, 0, 1.5, 0)
    iconGlow.Position = UDim2.new(-0.25, 0, -0.25, 0)
    iconGlow.BackgroundTransparency = 1
    iconGlow.Image = "rbxassetid://6014261993"
    iconGlow.ImageColor3 = Color3.fromRGB(255, 0, 0)
    iconGlow.ImageTransparency = 0.5
    iconGlow.ZIndex = 11
    iconGlow.Parent = topIconContainer

    spawn(function()
        while iconGlow.Parent do
            for i = 0.5, 0.3, -0.01 do
                if not iconGlow or not iconGlow.Parent then break end
                iconGlow.ImageTransparency = i
                wait(0.03)
            end
            for i = 0.3, 0.5, 0.01 do
                if not iconGlow or not iconGlow.Parent then break end
                iconGlow.ImageTransparency = i
                wait(0.03)
            end
        end
    end)
    
    local topIcon = Instance.new("ImageLabel")
    topIcon.Name = "TopIcon"
    topIcon.Size = UDim2.new(1, 0, 1, 0)
    topIcon.BackgroundTransparency = 1
    topIcon.Image = scriptIcon
    topIcon.ZIndex = 12
    topIcon.Parent = topIconContainer
    
    spawn(function()
        while topIcon.Parent do
            topIcon.Rotation = (topIcon.Rotation + 0.5) % 360
            wait(0.02)
        end
    end)
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "TitleLabel"
    titleLabel.Size = UDim2.new(1, 0, 0, 50)
    titleLabel.Position = UDim2.new(0, 0, 0, 110)
    titleLabel.BackgroundTransparency = 1
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.TextStrokeColor3 = Color3.fromRGB(255, 0, 0)
    titleLabel.TextStrokeTransparency = 0.7
    titleLabel.TextSize = 28
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.Text = "Select Your Language"
    titleLabel.ZIndex = 12
    titleLabel.Parent = mainFrame
    
    spawn(function()
        local originalTextSize = 28
        while titleLabel.Parent do
            for i = originalTextSize, originalTextSize + 2, 0.1 do
                if not titleLabel or not titleLabel.Parent then break end
                titleLabel.TextSize = i
                wait(0.03)
            end
            for i = originalTextSize + 2, originalTextSize, -0.1 do
                if not titleLabel or not titleLabel.Parent then break end
                titleLabel.TextSize = i
                wait(0.03)
            end
        end
    end)
    
    local arabicButton = Instance.new("Frame")
    arabicButton.Name = "ArabicButton"
    arabicButton.Size = UDim2.new(0.4, 0, 0, 70)
    arabicButton.Position = UDim2.new(0.07, 0, 0.5, 0)
    arabicButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    arabicButton.ZIndex = 12
    arabicButton.Parent = mainFrame
    
    local arabicButtonGlow = Instance.new("ImageLabel")
    arabicButtonGlow.Name = "ButtonGlow"
    arabicButtonGlow.Size = UDim2.new(1.2, 0, 1.4, 0)
    arabicButtonGlow.Position = UDim2.new(-0.1, 0, -0.2, 0)
    arabicButtonGlow.BackgroundTransparency = 1
    arabicButtonGlow.Image = "rbxassetid://6014261993"
    arabicButtonGlow.ImageColor3 = Color3.fromRGB(255, 0, 0)
    arabicButtonGlow.ImageTransparency = 0.9
    arabicButtonGlow.ZIndex = 11
    arabicButtonGlow.Parent = arabicButton
    
    local arabicCorner = Instance.new("UICorner")
    arabicCorner.CornerRadius = UDim.new(0, 15)
    arabicCorner.Parent = arabicButton
    
    local arabicGradient = Instance.new("UIGradient")
    arabicGradient.Rotation = 90
    arabicGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 40, 40)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(30, 30, 30)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 20, 20))
    })
    arabicGradient.Parent = arabicButton
    
    local arabicStroke = Instance.new("UIStroke")
    arabicStroke.Color = Color3.fromRGB(255, 0, 0)
    arabicStroke.Thickness = 2
    arabicStroke.Parent = arabicButton
    
    local arabicIconImage = Instance.new("ImageLabel")
    arabicIconImage.Name = "ArabicIcon"
    arabicIconImage.Size = UDim2.new(0, 50, 0, 50)
    arabicIconImage.Position = UDim2.new(0, 15, 0.5, -25)
    arabicIconImage.BackgroundTransparency = 1
    arabicIconImage.Image = arabicIcon
    arabicIconImage.ZIndex = 13
    arabicIconImage.Parent = arabicButton
    
    spawn(function()
        while arabicIconImage.Parent do
            arabicIconImage.Rotation = math.sin(tick() * 2) * 10
            wait(0.02)
        end
    end)
    
    local arabicText = Instance.new("TextLabel")
    arabicText.Name = "ArabicText"
    arabicText.Size = UDim2.new(1, -75, 1, 0)
    arabicText.Position = UDim2.new(0, 75, 0, 0)
    arabicText.BackgroundTransparency = 1
    arabicText.TextColor3 = Color3.fromRGB(255, 255, 255)
    arabicText.TextStrokeColor3 = Color3.fromRGB(255, 0, 0)
    arabicText.TextStrokeTransparency = 0.7
    arabicText.TextSize = 24
    arabicText.Font = Enum.Font.GothamBold
    arabicText.Text = "Arabic"
    arabicText.ZIndex = 13
    arabicText.Parent = arabicButton
    
    spawn(function()
        while arabicText.Parent do
            for i = 1, 0.8, -0.02 do
                if not arabicText or not arabicText.Parent then break end
                arabicText.TextStrokeTransparency = i
                wait(0.03)
            end
            for i = 0.8, 1, 0.02 do
                if not arabicText or not arabicText.Parent then break end
                arabicText.TextStrokeTransparency = i
                wait(0.03)
            end
        end
    end)
    
    local arabicClickDetector = Instance.new("TextButton")
    arabicClickDetector.Name = "ArabicClickDetector"
    arabicClickDetector.Size = UDim2.new(1, 0, 1, 0)
    arabicClickDetector.BackgroundTransparency = 1
    arabicClickDetector.Text = ""
    arabicClickDetector.ZIndex = 14
    arabicClickDetector.Parent = arabicButton
    
    local orLabel = Instance.new("TextLabel")
    orLabel.Name = "OrLabel"
    orLabel.Size = UDim2.new(0.1, 0, 0, 50)
    orLabel.Position = UDim2.new(0.45, 0, 0.5, 10)
    orLabel.BackgroundTransparency = 1
    orLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    orLabel.TextStrokeColor3 = Color3.fromRGB(255, 0, 0)
    orLabel.TextStrokeTransparency = 0.7
    orLabel.TextSize = 22
    orLabel.Font = Enum.Font.GothamBold
    orLabel.Text = "OR"
    orLabel.ZIndex = 12
    orLabel.Parent = mainFrame

    spawn(function()
        while orLabel.Parent do
            for i = 1, 0.5, -0.05 do
                if not orLabel or not orLabel.Parent then break end
                orLabel.TextStrokeTransparency = i
                orLabel.TextSize = 22 + ((1 - i) * 4)
                wait(0.05)
            end
            for i = 0.5, 1, 0.05 do
                if not orLabel or not orLabel.Parent then break end
                orLabel.TextStrokeTransparency = i
                orLabel.TextSize = 22 + ((1 - i) * 4)
                wait(0.05)
            end
        end
    end)
    
    local englishButton = Instance.new("Frame")
    englishButton.Name = "EnglishButton"
    englishButton.Size = UDim2.new(0.4, 0, 0, 70)
    englishButton.Position = UDim2.new(0.53, 0, 0.5, 0)
    englishButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    englishButton.ZIndex = 12
    englishButton.Parent = mainFrame
    
    local englishButtonGlow = Instance.new("ImageLabel")
    englishButtonGlow.Name = "ButtonGlow"
    englishButtonGlow.Size = UDim2.new(1.2, 0, 1.4, 0)
    englishButtonGlow.Position = UDim2.new(-0.1, 0, -0.2, 0)
    englishButtonGlow.BackgroundTransparency = 1
    englishButtonGlow.Image = "rbxassetid://6014261993"
    englishButtonGlow.ImageColor3 = Color3.fromRGB(255, 0, 0)
    englishButtonGlow.ImageTransparency = 0.9
    englishButtonGlow.ZIndex = 11
    englishButtonGlow.Parent = englishButton
    
    local englishCorner = Instance.new("UICorner")
    englishCorner.CornerRadius = UDim.new(0, 15)
    englishCorner.Parent = englishButton
    
    local englishGradient = Instance.new("UIGradient")
    englishGradient.Rotation = 90
    englishGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 40, 40)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(30, 30, 30)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 20, 20))
    })
    englishGradient.Parent = englishButton
    
    local englishStroke = Instance.new("UIStroke")
    englishStroke.Color = Color3.fromRGB(255, 0, 0)
    englishStroke.Thickness = 2
    englishStroke.Parent = englishButton
    
    local englishIconImage = Instance.new("ImageLabel")
    englishIconImage.Name = "EnglishIcon"
    englishIconImage.Size = UDim2.new(0, 50, 0, 50)
    englishIconImage.Position = UDim2.new(0, 15, 0.5, -25)
    englishIconImage.BackgroundTransparency = 1
    englishIconImage.Image = englishIcon
    englishIconImage.ZIndex = 13
    englishIconImage.Parent = englishButton
    
    spawn(function()
        while englishIconImage.Parent do
            englishIconImage.Rotation = math.sin(tick() * 2 + 1) * 10
            wait(0.02)
        end
    end)
    
    local englishText = Instance.new("TextLabel")
    englishText.Name = "EnglishText"
    englishText.Size = UDim2.new(1, -75, 1, 0)
    englishText.Position = UDim2.new(0, 75, 0, 0)
    englishText.BackgroundTransparency = 1
    englishText.TextColor3 = Color3.fromRGB(255, 255, 255)
    englishText.TextStrokeColor3 = Color3.fromRGB(255, 0, 0)
    englishText.TextStrokeTransparency = 0.7
    englishText.TextSize = 24
    englishText.Font = Enum.Font.GothamBold
    englishText.Text = "English"
    englishText.ZIndex = 13
    englishText.Parent = englishButton
    
    spawn(function()
        while englishText.Parent do
            for i = 1, 0.8, -0.02 do
                if not englishText or not englishText.Parent then break end
                englishText.TextStrokeTransparency = i
                wait(0.03)
            end
            for i = 0.8, 1, 0.02 do
                if not englishText or not englishText.Parent then break end
                englishText.TextStrokeTransparency = i
                wait(0.03)
            end
        end
    end)
    
    local englishClickDetector = Instance.new("TextButton")
    englishClickDetector.Name = "EnglishClickDetector"
    englishClickDetector.Size = UDim2.new(1, 0, 1, 0)
    englishClickDetector.BackgroundTransparency = 1
    englishClickDetector.Text = ""
    englishClickDetector.ZIndex = 14
    englishClickDetector.Parent = englishButton
    
    local scriptInfoContainer = Instance.new("Frame")
    scriptInfoContainer.Name = "ScriptInfoContainer"
    scriptInfoContainer.Size = UDim2.new(1, 0, 0, 20)
    scriptInfoContainer.Position = UDim2.new(0, 0, 1, -30)
    scriptInfoContainer.BackgroundTransparency = 1
    scriptInfoContainer.ZIndex = 12
    scriptInfoContainer.Parent = mainFrame
    
    local infoGlow = Instance.new("ImageLabel")
    infoGlow.Name = "InfoGlow"
    infoGlow.Size = UDim2.new(1, 0, 2, 0)
    infoGlow.Position = UDim2.new(0, 0, -0.5, 0)
    infoGlow.BackgroundTransparency = 1
    infoGlow.Image = "rbxassetid://6014261993"
    infoGlow.ImageColor3 = Color3.fromRGB(255, 0, 0)
    infoGlow.ImageTransparency = 0.9
    infoGlow.ZIndex = 11
    infoGlow.Parent = scriptInfoContainer
    
    local scriptInfoLeft = Instance.new("TextLabel")
    scriptInfoLeft.Name = "ScriptInfoLeft"
    scriptInfoLeft.Size = UDim2.new(0.5, -10, 0, 20)
    scriptInfoLeft.Position = UDim2.new(0, 10, 0, 0)
    scriptInfoLeft.BackgroundTransparency = 1
    scriptInfoLeft.TextColor3 = Color3.fromRGB(200, 200, 200)
    scriptInfoLeft.TextSize = 16
    scriptInfoLeft.Font = Enum.Font.Gotham
    scriptInfoLeft.Text = "GUI BY: FRONT-EVIll"
    scriptInfoLeft.TextXAlignment = Enum.TextXAlignment.Left
    scriptInfoLeft.ZIndex = 12
    scriptInfoLeft.Parent = scriptInfoContainer
    
    local scriptInfoRight = Instance.new("TextLabel")
    scriptInfoRight.Name = "ScriptInfoRight"
    scriptInfoRight.Size = UDim2.new(0.5, -10, 0, 20)
    scriptInfoRight.Position = UDim2.new(0.5, 0, 0, 0)
    scriptInfoRight.BackgroundTransparency = 1
    scriptInfoRight.TextColor3 = Color3.fromRGB(200, 200, 200)
    scriptInfoRight.TextSize = 16
    scriptInfoRight.Font = Enum.Font.Gotham
    scriptInfoRight.Text = "Script By: front-evill / 7sone"
    scriptInfoRight.TextXAlignment = Enum.TextXAlignment.Right
    scriptInfoRight.ZIndex = 12
    scriptInfoRight.Parent = scriptInfoContainer
    
    spawn(function()
        while scriptInfoLeft.Parent do
            for i = 200, 255, 2 do
                if not scriptInfoLeft or not scriptInfoLeft.Parent then break end
                scriptInfoLeft.TextColor3 = Color3.fromRGB(i, i, i)
                scriptInfoRight.TextColor3 = Color3.fromRGB(i, i, i)
                wait(0.05)
            end
            for i = 255, 200, -2 do
                if not scriptInfoLeft or not scriptInfoLeft.Parent then break end
                scriptInfoLeft.TextColor3 = Color3.fromRGB(i, i, i)
                scriptInfoRight.TextColor3 = Color3.fromRGB(i, i, i)
                wait(0.05)
            end
        end
    end)
    
    local divider = Instance.new("Frame")
    divider.Name = "Divider"
    divider.Size = UDim2.new(0.85, 0, 0, 2)
    divider.Position = UDim2.new(0.075, 0, 1, -50)
    divider.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    divider.BorderSizePixel = 0
    divider.ZIndex = 12
    divider.Parent = mainFrame
    
    spawn(function()
        while divider.Parent do
            for i = 0, 1, 0.01 do
                if not divider or not divider.Parent then break end
                local color = Color3.fromHSV(0, 1, 0.7 + math.sin(i * math.pi * 2) * 0.3)
                divider.BackgroundColor3 = color
                wait(0.03)
            end
        end
    end)
    
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
    arabicStroke.Transparency = 1
    englishStroke.Transparency = 1
    
    game:GetService("TweenService"):Create(mainFrame, TweenInfo.new(0.8, Enum.EasingStyle.Bounce), {Position = UDim2.new(0.5, -225, 0.5, -150), BackgroundTransparency = 0}):Play()
    wait(0.1)
    game:GetService("TweenService"):Create(topIcon, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {ImageTransparency = 0}):Play()
    wait(0.1)
    game:GetService("TweenService"):Create(titleLabel, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {TextTransparency = 0}):Play()
    wait(0.1)
    game:GetService("TweenService"):Create(arabicButton, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {BackgroundTransparency = 0}):Play()
    game:GetService("TweenService"):Create(arabicText, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {TextTransparency = 0}):Play()
    game:GetService("TweenService"):Create(arabicIconImage, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {ImageTransparency = 0}):Play()
    game:GetService("TweenService"):Create(arabicStroke, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {Transparency = 0}):Play()
    wait(0.1)
    game:GetService("TweenService"):Create(orLabel, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {TextTransparency = 0}):Play()
    wait(0.1)
    game:GetService("TweenService"):Create(englishButton, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {BackgroundTransparency = 0}):Play()
    game:GetService("TweenService"):Create(englishText, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {TextTransparency = 0}):Play()
    game:GetService("TweenService"):Create(englishIconImage, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {ImageTransparency = 0}):Play()
    game:GetService("TweenService"):Create(englishStroke, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {Transparency = 0}):Play()
    wait(0.1)
    game:GetService("TweenService"):Create(scriptInfoLeft, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {TextTransparency = 0}):Play()
    game:GetService("TweenService"):Create(scriptInfoRight, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {TextTransparency = 0}):Play()
    game:GetService("TweenService"):Create(divider, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {BackgroundTransparency = 0}):Play()
    game:GetService("TweenService"):Create(uiStroke, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {Transparency = 0}):Play()
    
    arabicClickDetector.MouseEnter:Connect(function()
        game:GetService("TweenService"):Create(arabicButton, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {BackgroundColor3 = Color3.fromRGB(255, 0, 0)}):Play()
        game:GetService("TweenService"):Create(arabicText, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
        game:GetService("TweenService"):Create(arabicButton, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {Size = UDim2.new(0.42, 0, 0, 75)}):Play()
        game:GetService("TweenService"):Create(arabicButtonGlow, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {ImageTransparency = 0.7}):Play()
    end)
    
    arabicClickDetector.MouseLeave:Connect(function()
        game:GetService("TweenService"):Create(arabicButton, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}):Play()
        game:GetService("TweenService"):Create(arabicText, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
        game:GetService("TweenService"):Create(arabicButton, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {Size = UDim2.new(0.4, 0, 0, 70)}):Play()
        game:GetService("TweenService"):Create(arabicButtonGlow, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {ImageTransparency = 0.9}):Play()
    end)
    
    englishClickDetector.MouseEnter:Connect(function()
        game:GetService("TweenService"):Create(englishButton, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {BackgroundColor3 = Color3.fromRGB(255, 0, 0)}):Play()
        game:GetService("TweenService"):Create(englishText, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
        game:GetService("TweenService"):Create(englishButton, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {Size = UDim2.new(0.42, 0, 0, 75)}):Play()
        game:GetService("TweenService"):Create(englishButtonGlow, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {ImageTransparency = 0.7}):Play()
    end)
    
    englishClickDetector.MouseLeave:Connect(function()
        game:GetService("TweenService"):Create(englishButton, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}):Play()
        game:GetService("TweenService"):Create(englishText, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
        game:GetService("TweenService"):Create(englishButton, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {Size = UDim2.new(0.4, 0, 0, 70)}):Play()
        game:GetService("TweenService"):Create(englishButtonGlow, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {ImageTransparency = 0.9}):Play()
    end)
    
    arabicClickDetector.MouseButton1Click:Connect(function()
        game:GetService("TweenService"):Create(arabicButton, TweenInfo.new(0.15, Enum.EasingStyle.Quart), {Size = UDim2.new(0.38, 0, 0, 65)}):Play()
        wait(0.15)
        game:GetService("TweenService"):Create(arabicButton, TweenInfo.new(0.15, Enum.EasingStyle.Quart), {Size = UDim2.new(0.4, 0, 0, 70)}):Play()
        
        game:GetService("TweenService"):Create(mainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Position = UDim2.new(0.5, -225, 1.5, 0), BackgroundTransparency = 1}):Play()
        game:GetService("TweenService"):Create(uiStroke, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {Transparency = 1}):Play()
        
        createNotification("تم تشغيل السكربت باللغة العربية", 5)
        
        wait(0.5)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Front-Evill/Script-Hub/refs/heads/main/Arabic.lua"))()
        
        wait(0.5)
        mainFrame:Destroy()
        particles:Destroy()
    end)
    
    englishClickDetector.MouseButton1Click:Connect(function()
        game:GetService("TweenService"):Create(englishButton, TweenInfo.new(0.15, Enum.EasingStyle.Quart), {Size = UDim2.new(0.38, 0, 0, 65)}):Play()
        wait(0.15)
        game:GetService("TweenService"):Create(englishButton, TweenInfo.new(0.15, Enum.EasingStyle.Quart), {Size = UDim2.new(0.4, 0, 0, 70)}):Play()
        
        game:GetService("TweenService"):Create(mainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection

        englishClickDetector.MouseButton1Click:Connect(function()
    game:GetService("TweenService"):Create(englishButton, TweenInfo.new(0.15, Enum.EasingStyle.Quart), {Size = UDim2.new(0.38, 0, 0, 65)}):Play()
    wait(0.15)
    game:GetService("TweenService"):Create(englishButton, TweenInfo.new(0.15, Enum.EasingStyle.Quart), {Size = UDim2.new(0.4, 0, 0, 70)}):Play()
    
    game:GetService("TweenService"):Create(mainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Position = UDim2.new(0.5, -225, 1.5, 0), BackgroundTransparency = 1}):Play()
    game:GetService("TweenService"):Create(uiStroke, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {Transparency = 1}):Play()
    
    createNotification("Script launched in English", 5)
    
    wait(0.5)
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Front-Evill/Script-Hub/refs/heads/main/F-150.lua"))()
    
    wait(0.5)
    mainFrame:Destroy()
    particles:Destroy()
end)
