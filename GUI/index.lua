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

local function createNotification(text, duration)
    duration = duration or 3
    
    local notification = Instance.new("Frame")
    notification.Name = "Notification"
    notification.Size = UDim2.new(0, 250, 0, 60)
    notification.Position = UDim2.new(0.5, -125, 0.85, 0)
    notification.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    notification.BorderSizePixel = 0
    notification.BackgroundTransparency = 0.2
    notification.Parent = screenGui
    
    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(0, 6)
    uiCorner.Parent = notification
    
    local uiStroke = Instance.new("UIStroke")
    uiStroke.Color = Color3.fromRGB(255, 0, 0)
    uiStroke.Thickness = 1.5
    uiStroke.Parent = notification
    
    local notifText = Instance.new("TextLabel")
    notifText.Name = "NotifText"
    notifText.Size = UDim2.new(1, -20, 1, -10)
    notifText.Position = UDim2.new(0, 10, 0, 5)
    notifText.BackgroundTransparency = 1
    notifText.TextColor3 = Color3.fromRGB(255, 255, 255)
    notifText.TextSize = 16
    notifText.Font = Enum.Font.GothamBold
    notifText.Text = text
    notifText.TextWrapped = true
    notifText.Parent = notification
    
    notification.BackgroundTransparency = 1
    uiStroke.Transparency = 1
    notifText.TextTransparency = 1
    
    game:GetService("TweenService"):Create(notification, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {BackgroundTransparency = 0.2}):Play()
    game:GetService("TweenService"):Create(uiStroke, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Transparency = 0}):Play()
    game:GetService("TweenService"):Create(notifText, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
    
    spawn(function()
        wait(duration)
        local fadeOut = game:GetService("TweenService"):Create(notification, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {BackgroundTransparency = 1})
        local strokeFade = game:GetService("TweenService"):Create(uiStroke, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {Transparency = 1})
        local textFade = game:GetService("TweenService"):Create(notifText, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {TextTransparency = 1})
        
        fadeOut:Play()
        strokeFade:Play()
        textFade:Play()
        
        fadeOut.Completed:Wait()
        notification:Destroy()
    end)
end

local function typewriterEffect(text)
    local background = Instance.new("Frame")
    background.Name = "WelcomeScreen"
    background.Size = UDim2.new(1, 0, 1, 0)
    background.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    background.BackgroundTransparency = 0.3
    background.BorderSizePixel = 0
    background.Parent = screenGui
    
    local blur = Instance.new("BlurEffect")
    blur.Size = 20
    blur.Parent = game:GetService("Lighting")
    
    local welcomeText = Instance.new("TextLabel")
    welcomeText.Name = "WelcomeText"
    welcomeText.Size = UDim2.new(0.8, 0, 0.2, 0)
    welcomeText.Position = UDim2.new(0.1, 0, 0.4, 0)
    welcomeText.BackgroundTransparency = 1
    welcomeText.TextColor3 = Color3.fromRGB(255, 0, 0)
    welcomeText.TextSize = 32
    welcomeText.Font = Enum.Font.GothamBold
    welcomeText.Text = ""
    welcomeText.TextWrapped = true
    welcomeText.Parent = background
    
    spawn(function()
        for i = 1, #text do
            welcomeText.Text = string.sub(text, 1, i)
            wait(0.05)
        end
        
        wait(1.5)
        
        game:GetService("TweenService"):Create(background, TweenInfo.new(1, Enum.EasingStyle.Quart), {BackgroundTransparency = 1}):Play()
        game:GetService("TweenService"):Create(welcomeText, TweenInfo.new(1, Enum.EasingStyle.Quart), {TextTransparency = 1}):Play()
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
    mainFrame.Size = UDim2.new(0, 400, 0, 250)
    mainFrame.Position = UDim2.new(0.5, -200, 0.5, -125)
    mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    mainFrame.BorderSizePixel = 0
    mainFrame.Parent = screenGui
    mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    
    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(0, 10)
    uiCorner.Parent = mainFrame
    
    local uiStroke = Instance.new("UIStroke")
    uiStroke.Color = Color3.fromRGB(255, 0, 0)
    uiStroke.Thickness = 2
    uiStroke.Parent = mainFrame
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "TitleLabel"
    titleLabel.Size = UDim2.new(1, 0, 0, 50)
    titleLabel.Position = UDim2.new(0, 0, 0, 15)
    titleLabel.BackgroundTransparency = 1
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.TextSize = 22
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.Text = "هل تريد سكربت بلغة:"
    titleLabel.Parent = mainFrame
    
    local arabicButton = Instance.new("TextButton")
    arabicButton.Name = "ArabicButton"
    arabicButton.Size = UDim2.new(0.35, 0, 0, 50)
    arabicButton.Position = UDim2.new(0.1, 0, 0.5, 0)
    arabicButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    arabicButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    arabicButton.TextSize = 18
    arabicButton.Font = Enum.Font.GothamBold
    arabicButton.Text = "عربي"
    arabicButton.Parent = mainFrame
    
    local arabicCorner = Instance.new("UICorner")
    arabicCorner.CornerRadius = UDim.new(0, 6)
    arabicCorner.Parent = arabicButton
    
    local orLabel = Instance.new("TextLabel")
    orLabel.Name = "OrLabel"
    orLabel.Size = UDim2.new(0.1, 0, 0, 50)
    orLabel.Position = UDim2.new(0.45, 0, 0.5, 0)
    orLabel.BackgroundTransparency = 1
    orLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    orLabel.TextSize = 18
    orLabel.Font = Enum.Font.GothamBold
    orLabel.Text = "or"
    orLabel.Parent = mainFrame
    
    local englishButton = Instance.new("TextButton")
    englishButton.Name = "EnglishButton"
    englishButton.Size = UDim2.new(0.35, 0, 0, 50)
    englishButton.Position = UDim2.new(0.55, 0, 0.5, 0)
    englishButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    englishButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    englishButton.TextSize = 18
    englishButton.Font = Enum.Font.GothamBold
    englishButton.Text = "English"
    englishButton.Parent = mainFrame
    
    local englishCorner = Instance.new("UICorner")
    englishCorner.CornerRadius = UDim.new(0, 6)
    englishCorner.Parent = englishButton
    
    local scriptInfoLeft = Instance.new("TextLabel")
    scriptInfoLeft.Name = "ScriptInfoLeft"
    scriptInfoLeft.Size = UDim2.new(0.5, -10, 0, 20)
    scriptInfoLeft.Position = UDim2.new(0, 10, 1, -30)
    scriptInfoLeft.BackgroundTransparency = 1
    scriptInfoLeft.TextColor3 = Color3.fromRGB(200, 200, 200)
    scriptInfoLeft.TextSize = 12
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
    scriptInfoRight.TextSize = 12
    scriptInfoRight.Font = Enum.Font.Gotham
    scriptInfoRight.Text = "The Script By: front-evill / 7sone"
    scriptInfoRight.TextXAlignment = Enum.TextXAlignment.Right
    scriptInfoRight.Parent = mainFrame
    
    mainFrame.Position = mainFrame.Position + UDim2.new(0, 0, 0.2, 0)
    mainFrame.BackgroundTransparency = 1
    titleLabel.TextTransparency = 1
    arabicButton.BackgroundTransparency = 1
    arabicButton.TextTransparency = 1
    orLabel.TextTransparency = 1
    englishButton.BackgroundTransparency = 1
    englishButton.TextTransparency = 1
    scriptInfoLeft.TextTransparency = 1
    scriptInfoRight.TextTransparency = 1
    uiStroke.Transparency = 1
    
    game:GetService("TweenService"):Create(mainFrame, TweenInfo.new(0.8, Enum.EasingStyle.Bounce), {Position = UDim2.new(0.5, -200, 0.5, -125), BackgroundTransparency = 0}):Play()
    wait(0.1)
    game:GetService("TweenService"):Create(titleLabel, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {TextTransparency = 0}):Play()
    wait(0.1)
    game:GetService("TweenService"):Create(arabicButton, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {BackgroundTransparency = 0, TextTransparency = 0}):Play()
    wait(0.1)
    game:GetService("TweenService"):Create(orLabel, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {TextTransparency = 0}):Play()
    wait(0.1)
    game:GetService("TweenService"):Create(englishButton, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {BackgroundTransparency = 0, TextTransparency = 0}):Play()
    wait(0.1)
    game:GetService("TweenService"):Create(scriptInfoLeft, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {TextTransparency = 0}):Play()
    game:GetService("TweenService"):Create(scriptInfoRight, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {TextTransparency = 0}):Play()
    game:GetService("TweenService"):Create(uiStroke, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {Transparency = 0}):Play()
    
    arabicButton.MouseEnter:Connect(function()
        game:GetService("TweenService"):Create(arabicButton, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {BackgroundColor3 = Color3.fromRGB(255, 0, 0)}):Play()
    end)
    
    arabicButton.MouseLeave:Connect(function()
        game:GetService("TweenService"):Create(arabicButton, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}):Play()
    end)
    
    englishButton.MouseEnter:Connect(function()
        game:GetService("TweenService"):Create(englishButton, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {BackgroundColor3 = Color3.fromRGB(255, 0, 0)}):Play()
    end)
    
    englishButton.MouseLeave:Connect(function()
        game:GetService("TweenService"):Create(englishButton, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}):Play()
    end)
    
    arabicButton.MouseButton1Click:Connect(function()
        game:GetService("TweenService"):Create(mainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2.new(0.5, -200, 1.5, 0), BackgroundTransparency = 1}):Play()
        game:GetService("TweenService"):Create(uiStroke, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {Transparency = 1}):Play()
        
        createNotification("تم تشغيل السكربت باللغة العربية", 5)
        
        wait(0.5)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Front-Evill/Script-Hub/refs/heads/main/Arabic.lua"))()
        
        wait(0.5)
        mainFrame:Destroy()
    end)
    
    englishButton.MouseButton1Click:Connect(function()
        game:GetService("TweenService"):Create(mainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2.new(0.5, -200, 1.5, 0), BackgroundTransparency = 1}):Play()
        game:GetService("TweenService"):Create(uiStroke, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {Transparency = 1}):Play()
        
        createNotification("Script launched in English", 5)
        
        wait(0.5)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Front-Evill/Script-Hub/refs/heads/main/F-150.lua"))()
        
        wait(0.5)
        mainFrame:Destroy()
    end)
end

typewriterEffect("Welcome to script front evill")
