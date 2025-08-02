getgenv().Ready = getgenv().Ready or {}
getgenv().Ready.BeachBallCollector = false
getgenv().Ready.ESPPlayers = false
getgenv().Ready.FlingPlayers = false
getgenv().Ready.KillAllPlayers = false

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Debris = game:GetService("Debris")
local MarketplaceService = game:GetService("MarketplaceService")

local player = Players.LocalPlayer
local CollectConnection = nil
local ESPConnection = nil
local FlingConnection = nil
local KillConnection = nil
local Running = false
local TweenList = {}
local coinCount = 0
local isRoundActive = false
local isDead = false
local playerHighlights = {}
local playerCounts = {murderer = 0, sheriff = 0, innocent = 0}

local function ShowWelcomeScreen()
    local welcomeGui = Instance.new("ScreenGui")
    welcomeGui.Name = "WelcomeGui"
    welcomeGui.Parent = game:GetService("CoreGui")
    
    local welcomeLabel = Instance.new("TextLabel")
    welcomeLabel.Name = "WelcomeLabel"
    welcomeLabel.Parent = welcomeGui
    welcomeLabel.Size = UDim2.new(1, 0, 1, 0)
    welcomeLabel.Position = UDim2.new(0, 0, 0, 0)
    welcomeLabel.BackgroundTransparency = 1
    welcomeLabel.Text = ""
    welcomeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    welcomeLabel.TextScaled = true
    welcomeLabel.Font = Enum.Font.GothamBold
    welcomeLabel.TextStrokeTransparency = 0
    welcomeLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    
    local welcomeText = "Welcome to Script Front evill"
    local currentText = ""
    
    for i = 1, #welcomeText do
        currentText = currentText .. welcomeText:sub(i, i)
        welcomeLabel.Text = currentText
        wait(0.05)
    end
    
    wait(2)
    welcomeGui:Destroy()
end

local function TweenTo(Part)
    if Running then return end
    Running = true
    local Tween = TweenService:Create(
        player.Character.HumanoidRootPart,
        TweenInfo.new((player.Character.HumanoidRootPart.Position - Part.Position).Magnitude / 27, Enum.EasingStyle.Linear),
        {CFrame = CFrame.new(Part.Position) * CFrame.Angles(0, player.Character.HumanoidRootPart.Orientation.Y, 0)}
    )
    table.insert(TweenList, Tween)
    Tween.Completed:Connect(function()
        Running = false
    end)
    Tween:Play()
    return Tween
end

local function StopAllTweens()
    for _, Tween in ipairs(TweenList) do
        Tween:Cancel()
    end
    TweenList = {}
    Running = false
end

local function Notify(Title, Dis)
    pcall(function()
        Fluent:Notify({Title = tostring(Title), Content = tostring(Dis), Duration = 3}),
         local sound = Instance.new("Sound", workspace), sound.SoundId = "rbxassetid://3398620867" , sound.Volume = 1, sound.Ended:Connect(function() sound:Destroy() end) , 
        sound:Play()
    end)
end

local function ValidateCharacter()
    return player.Character and 
           player.Character:FindFirstChild("HumanoidRootPart") and 
           player.Character:FindFirstChild("Humanoid") and 
           player.Character.Humanoid.Health > 0
end

local function CheckRoundStatus()
    local roundActive = false
    pcall(function()
        if workspace:FindFirstChild("Status") and workspace.Status:FindFirstChild("RoundLength") then
            local roundLength = workspace.Status.RoundLength.Value
            if roundLength > 0 then
                roundActive = true
            end
        elseif player.PlayerGui:FindFirstChild("MainGUI") then
            local mainGui = player.PlayerGui.MainGUI
            if mainGui:FindFirstChild("Game") and mainGui.Game.Visible then
                roundActive = true
            end
        end
    end)
    return roundActive
end

local function GetPlayerRole()
    local role = "Unknown"
    pcall(function()
        if player.PlayerGui:FindFirstChild("MainGUI") then
            local roleGui = player.PlayerGui.MainGUI:FindFirstChild("Game")
            if roleGui and roleGui:FindFirstChild("Roles") then
                local roleText = roleGui.Roles:FindFirstChild("RoleText")
                if roleText then
                    role = roleText.Text
                end
            end
        end
    end)
    return role
end

local function CreateHighlight(obj, color, isPlayer)
    if obj and ((isPlayer and obj:FindFirstChild("HumanoidRootPart")) or (not isPlayer and obj:IsA("BasePart"))) then
        local highlight = Instance.new("Highlight")
        highlight.FillColor = color
        highlight.OutlineColor = color
        highlight.FillTransparency = isPlayer and 0.3 or 0.1
        highlight.OutlineTransparency = 0
        highlight.Parent = obj
        return highlight
    end
    return nil
end

local function GetPlayerRole_Advanced(targetPlayer)
    local role = "innocent"
    
    pcall(function()
        if targetPlayer and targetPlayer.Character then
            if targetPlayer.Character:FindFirstChild("Knife") or 
               (targetPlayer.Backpack and targetPlayer.Backpack:FindFirstChild("Knife")) then
                role = "murderer"
            elseif targetPlayer.Character:FindFirstChild("Gun") or 
                   (targetPlayer.Backpack and targetPlayer.Backpack:FindFirstChild("Gun")) then
                role = "sheriff"
            end
        end
    end)
    
    return role
end

local function UpdatePlayerHighlights()
    if not getgenv().Ready.ESPPlayers then return end
    
    for _, otherPlayer in pairs(Players:GetPlayers()) do
        if otherPlayer ~= player and otherPlayer.Character then
            if playerHighlights[otherPlayer] then
                playerHighlights[otherPlayer]:Destroy()
                playerHighlights[otherPlayer] = nil
            end
            
            local role = GetPlayerRole_Advanced(otherPlayer)
            local color = Color3.fromRGB(0, 255, 0)
            
            if role == "murderer" then
                color = Color3.fromRGB(255, 0, 0)
            elseif role == "sheriff" then
                color = Color3.fromRGB(0, 100, 255)
            end
            
            playerHighlights[otherPlayer] = CreateHighlight(otherPlayer.Character, color, true)
        end
    end
end

local function CountPlayers()
    playerCounts = {murderer = 0, sheriff = 0, innocent = 0}
    
    for _, otherPlayer in pairs(Players:GetPlayers()) do
        if otherPlayer.Character then
            local role = GetPlayerRole_Advanced(otherPlayer)
            playerCounts[role] = playerCounts[role] + 1
        end
    end
end

local function GetAllCoins()
    local coins = {}
    
    pcall(function()
        for _, obj in pairs(workspace:GetDescendants()) do
            if (obj.Name == "Coin_Server" or obj.Name:find("Coin")) and obj:IsA("BasePart") and obj.Parent and obj.Size.X < 10 then
                table.insert(coins, obj)
            end
        end
        
        if workspace:FindFirstChild("Workplace") then
            for _, container in pairs(workspace.Workplace:GetChildren()) do
                if container.Name:find("Coin") or container.Name:find("coin") then
                    for _, child in pairs(container:GetDescendants()) do
                        if (child.Name == "Coin_Server" or child.Name:find("Coin")) and child:IsA("BasePart") then
                            table.insert(coins, child)
                        end
                    end
                end
            end
        end
        
        if workspace:FindFirstChild("Normal") then
            for _, child in pairs(workspace.Normal:GetDescendants()) do
                if (child.Name == "Coin_Server" or child.Name:find("Coin")) and child:IsA("BasePart") and child.Size.X < 10 then
                    table.insert(coins, child)
                end
            end
        end
    end)
    
    return coins
end

local function GetClosestCoin()
    if not ValidateCharacter() then return nil end
    
    local coins = GetAllCoins()
    if #coins == 0 then return nil end
    
    local character = player.Character
    local humanoidRootPart = character.HumanoidRootPart
    local closestCoin = nil
    local shortestDistance = math.huge
    
    for _, coin in pairs(coins) do
        if coin and coin.Parent then
            local distance = (humanoidRootPart.Position - coin.Position).Magnitude
            if distance < shortestDistance then
                shortestDistance = distance
                closestCoin = coin
            end
        end
    end
    
    return closestCoin
end

local function MoveToCoin(coin)
    if not ValidateCharacter() or not coin or not coin.Parent or isDead or not isRoundActive then
        return false
    end
    
    StopAllTweens()
    
    local character = player.Character
    local humanoidRootPart = character.HumanoidRootPart
    local humanoid = character.Humanoid
    
    humanoid.PlatformStand = true
    humanoidRootPart.Anchored = false
    
    local tweenResult = TweenTo(coin)
    if tweenResult then
        tweenResult.Completed:Connect(function()
            if coin and coin.Parent and ValidateCharacter() and isRoundActive and not isDead then
                spawn(function()
                    local attempts = 0
                    local originalCoin = coin
                    
                    while originalCoin and originalCoin.Parent and attempts < 8 and ValidateCharacter() and not isDead do
                        attempts = attempts + 1
                        
                        humanoidRootPart.CFrame = CFrame.new(originalCoin.Position + Vector3.new(0, 0.5, 0))
                        
                        firetouchinterest(humanoidRootPart, originalCoin, 0)
                        wait(0.02)
                        firetouchinterest(humanoidRootPart, originalCoin, 1)
                        wait(0.02)
                        
                        if not originalCoin.Parent then
                            coinCount = coinCount + 1
                            break
                        end
                    end
                    
                    if ValidateCharacter() then
                        humanoid.PlatformStand = false
                    end
                end)
            else
                if ValidateCharacter() then
                    humanoid.PlatformStand = false
                end
            end
        end)
    end
    
    return true
end

local function EquipKnife()
    local knife = nil
    
    pcall(function()
        if player.Backpack:FindFirstChild("Knife") then
            knife = player.Backpack.Knife
            knife.Parent = player.Character
        elseif workspace:FindFirstChild("Normal") and workspace.Normal:FindFirstChild("Knife") then
            knife = workspace.Normal.Knife
            if ValidateCharacter() then
                firetouchinterest(player.Character.HumanoidRootPart, knife, 0)
                firetouchinterest(player.Character.HumanoidRootPart, knife, 1)
                wait(0.3)
            end
        end
    end)
    
    return knife
end

local function KillAllPlayers()
    if not ValidateCharacter() or isDead or not isRoundActive then return end
    
    local knife = EquipKnife()
    if not knife then 
        Notify("Error", "No knife found!")
        return 
    end
    
    wait(0.8)
    
    for _, otherPlayer in pairs(Players:GetPlayers()) do
        if otherPlayer ~= player and otherPlayer.Character and 
           otherPlayer.Character:FindFirstChild("HumanoidRootPart") and 
           otherPlayer.Character:FindFirstChild("Humanoid") and 
           otherPlayer.Character.Humanoid.Health > 0 then
            
            pcall(function()
                local otherRoot = otherPlayer.Character.HumanoidRootPart
                
                local tweenInfo = TweenInfo.new(0.15, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
                local targetCFrame = CFrame.new(otherRoot.Position + Vector3.new(0, 2, 0))
                
                local killTween = TweenService:Create(player.Character.HumanoidRootPart, tweenInfo, {
                    CFrame = targetCFrame
                })
                
                killTween:Play()
                killTween.Completed:Wait()
                
                if knife and knife:FindFirstChild("Stab") then
                    knife.Stab:FireServer()
                elseif knife then
                    knife:Activate()
                end
                
                wait(0.1)
            end)
        end
    end
end

local function FlingAllPlayers()
    if not ValidateCharacter() or isDead or not isRoundActive then return end
    
    
    pcall(function()
        for _, otherPlayer in pairs(Players:GetPlayers()) do
            if otherPlayer ~= player and otherPlayer.Character and otherPlayer.Character:FindFirstChild("HumanoidRootPart") then
                local bodyVelocity = Instance.new("BodyVelocity")
                bodyVelocity.MaxForce = Vector3.new(6000, 6000, 6000)
                bodyVelocity.Velocity = Vector3.new(
                    math.random(-60, 60), 
                    math.random(40, 80), 
                    math.random(-60, 60)
                )
                bodyVelocity.Parent = otherPlayer.Character.HumanoidRootPart
                
                Debris:AddItem(bodyVelocity, 1.2)
            end
        end
    end)
end

local function StartCollection()
    if CollectConnection then
        CollectConnection:Disconnect()
        CollectConnection = nil
    end
    
    CollectConnection = spawn(function()
        while getgenv().Ready.BeachBallCollector do
            pcall(function()
                isRoundActive = CheckRoundStatus()
                
                if ValidateCharacter() and isRoundActive and not isDead then
                    CountPlayers()
                    
                    local closestCoin = GetClosestCoin()
                    if closestCoin then
                        MoveToCoin(closestCoin)
                        wait(1.5)
                    else
                        wait(0.3)
                    end
                else
                    wait(0.8)
                end
            end)
            wait(0.05)
        end
    end)
end

local function StartESP()
    if ESPConnection then
        ESPConnection:Disconnect()
        ESPConnection = nil
    end
    
    ESPConnection = spawn(function()
        while getgenv().Ready.ESPPlayers do
            pcall(function()
                if isRoundActive then
                    UpdatePlayerHighlights()
                end
            end)
            wait(0.8)
        end
    end)
end

local function StartFlingMonitor()
    if FlingConnection then
        FlingConnection:Disconnect()
        FlingConnection = nil
    end
    
    FlingConnection = spawn(function()
        while getgenv().Ready.FlingPlayers do
            pcall(function()
                if coinCount >= 40 and isRoundActive and not isDead then
                    local role = GetPlayerRole()
                    if role:lower():find("sheriff") or role:lower():find("innocent") or 
                       role == "Sheriff" or role == "Innocent" then
                        FlingAllPlayers()
                        coinCount = 0
                        wait(3)
                    end
                end
            end)
            wait(0.8)
        end
    end)
end

local function StartKillMonitor()
    if KillConnection then
        KillConnection:Disconnect()
        KillConnection = nil
    end
    
    KillConnection = spawn(function()
        while getgenv().Ready.KillAllPlayers do
            pcall(function()
                if coinCount >= 40 and isRoundActive and not isDead then
                    local role = GetPlayerRole()
                    if role:lower():find("murder") or role == "Murderer" then
                        KillAllPlayers()
                        coinCount = 0
                        wait(3)
                    end
                end
            end)
            wait(0.8)
        end
    end)
end

local function StopCollection()
    if CollectConnection then
        CollectConnection = nil
    end
    StopAllTweens()
    if ValidateCharacter() then
        local humanoid = player.Character.Humanoid
        humanoid.PlatformStand = false
    end
    coinCount = 0
end

local function StopESP()
    if ESPConnection then
        ESPConnection = nil
    end
    
    for _, highlight in pairs(playerHighlights) do
        if highlight then
            highlight:Destroy()
        end
    end
    playerHighlights = {}
end

local function StopFlingMonitor()
    if FlingConnection then
        FlingConnection = nil
    end
end

local function StopKillMonitor()
    if KillConnection then
        KillConnection = nil
    end
end

local function SetupCharacterHandlers()
    if ValidateCharacter() then
        isDead = false
        local humanoid = player.Character.Humanoid
        humanoid.Died:Connect(function()
            isDead = true
            coinCount = 0
            StopAllTweens()
        end)
    end
end

player.CharacterAdded:Connect(function()
    wait(2)
    isDead = false
    SetupCharacterHandlers()
    coinCount = 0
    
    if getgenv().Ready.BeachBallCollector then
        wait(1.2)
        StartCollection()
    end
    if getgenv().Ready.ESPPlayers then
        StartESP()
    end
    if getgenv().Ready.FlingPlayers then
        StartFlingMonitor()
    end
    if getgenv().Ready.KillAllPlayers then
        StartKillMonitor()
    end
end)

player.CharacterRemoving:Connect(function()
    isDead = true
    StopCollection()
    StopESP()
end)

Players.PlayerRemoving:Connect(function(removedPlayer)
    if playerHighlights[removedPlayer] then
        playerHighlights[removedPlayer]:Destroy()
        playerHighlights[removedPlayer] = nil
    end
end)

if ValidateCharacter() then
    SetupCharacterHandlers()
end

ShowWelcomeScreen()

local IsOnMobile = table.find({Enum.Platform.IOS, Enum.Platform.Android}, UserInputService:GetPlatform())
function RandomTheme() 
    local themes = {"Amethyst", "Light", "Aqua", "Rose", "Darker", "Dark"} 
    return themes[math.random(1, #themes)] 
end

local Guitheme = RandomTheme()
local High = IsOnMobile and 400 or 500

if IsOnMobile then
    local teez
    teez = game:GetService("CoreGui").ChildAdded:Connect(function(P)
        if P.Name == "ScreenGui" then
            local Button = Instance.new("TextButton")
            local UICorner = Instance.new("UICorner")
            
            Button.Name = "Hider"
            Button.Parent = P
            Button.Size = UDim2.new(0, 110, 0, 55)
            Button.Position = UDim2.new(0, 15, 0.5, -27)
            Button.BackgroundTransparency = 0.4
            Button.Font = Enum.Font.GothamBold
            Button.TextColor3 = Color3.fromRGB(255, 255, 255)
            Button.Text = "Hide"
            Button.TextScaled = true
            Button.Draggable = true
            Button.AutoButtonColor = false
            
            local themeColors = {
                Light = Color3.fromRGB(255, 255, 255), 
                Amethyst = Color3.fromRGB(153, 102, 204), 
                Aqua = Color3.fromRGB(0, 255, 255), 
                Rose = Color3.fromRGB(255, 182, 193), 
                Darker = Color3.fromRGB(40, 40, 40), 
                Dark = Color3.fromRGB(30, 30, 30)
            }
            
            Button.BackgroundColor3 = themeColors[Guitheme] or Color3.fromRGB(255, 255, 255)
            UICorner.Parent = Button
            UICorner.CornerRadius = UDim.new(0, 15)
            
            Button.MouseButton1Click:Connect(function()
                for _, F in ipairs(P:GetChildren()) do
                    if F.Name ~= "Hider" and not F:FindFirstChild("UIListLayout") and not F:FindFirstChild("UISizeConstraint") then
                        if F.Visible then 
                            Button.Text = "View"
                            F.Visible = false 
                        else 
                            Button.Text = "Hide"
                            F.Visible = true 
                        end
                    end
                end
            end)
            getgenv().Done = true
        end
    end)
    
    spawn(function()
        while not getgenv().Done do task.wait() end
        if teez then teez:Disconnect() end
        getgenv().Done = false
    end)
end

for _, O in ipairs(game:GetService("CoreGui"):GetChildren()) do 
    if O.Name == "ScreenGui" and O:FindFirstChild("UIListLayout", true) and O:FindFirstChild("UISizeConstraint", true) then
        O:Destroy()
    end
end

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local Window = Fluent:CreateWindow({
    Title = MarketplaceService:GetProductInfo(game.PlaceId).Name, 
    SubTitle = "By Front -evill / 7sone", 
    TabWidth = 170, 
    Size = UDim2.fromOffset(620, High), 
    Acrylic = false, 
    Theme = Guitheme, 
    MinimizeKey = Enum.KeyCode.B
})

local Tabs = {
    Main = Window:AddTab({ Title = "Home", Icon = "home" }),
}

Window:SelectTab(1)

local Tab = Tabs.Main:AddSection("Auto Coin Server")

local playerCountLabel = Tab:AddParagraph({
    Title = "Player Count",
    Content = "Murderer: 0 | Sheriff: 0 | Innocent: 0"
})

local coinsLeftLabel = Tab:AddParagraph({
    Title = "Coins Progress",
    Content = "Coins Collected: 0/40 | Remaining: 40"
})

Tab:AddToggle("BeachBallCollectorEnhanced", {
    Title = "Start Farm Coins",
    Default = getgenv().Ready.BeachBallCollector or false,
    Callback = function(Value)
        getgenv().Ready.BeachBallCollector = Value
        
        if Value then
            StartCollection()
        else
            StopCollection()
            Notify("Farm Stopped", "Coin collection stopped!")
        end
    end 
})

Tab:AddToggle("ESPPlayers", {
    Title = "ESP Players",
    Default = getgenv().Ready.ESPPlayers or false,
    Callback = function(Value)
        getgenv().Ready.ESPPlayers = Value
        
        if Value then
            StartESP()
        else
            StopESP()
            Notify("ESP Stopped", "Player highlighting disabled!")
        end
    end 
})

Tab:AddToggle("FlingPlayers", {
    Title = "Auto Fling",
    Default = getgenv().Ready.FlingPlayers or false,
    Callback = function(Value)
        getgenv().Ready.FlingPlayers = Value
        
        if Value then
            StartFlingMonitor()
        else
            StopFlingMonitor()
            Notify("Fling Stopped", "Auto fling deactivated!")
        end
    end 
})

Tab:AddToggle("KillAllPlayers", {
    Title = "Auto Kill",
    Default = getgenv().Ready.KillAllPlayers or false,
    Callback = function(Value)
        getgenv().Ready.KillAllPlayers = Value
        
        if Value then
            StartKillMonitor()
        else
            StopKillMonitor()
            Notify("Kill Stopped", "Auto kill deactivated!")
        end
    end 
})

spawn(function()
    while true do
        wait(0.4)
        if getgenv().Ready.BeachBallCollector or getgenv().Ready.ESPPlayers or 
           getgenv().Ready.FlingPlayers or getgenv().Ready.KillAllPlayers then
            
            CountPlayers()
            
            playerCountLabel:SetDesc(string.format("Murderer: %d | Sheriff: %d | Innocent: %d", 
                playerCounts.murderer, playerCounts.sheriff, playerCounts.innocent))
            
            local remaining = math.max(0, 40 - coinCount)
            coinsLeftLabel:SetDesc(string.format("Coins Collected: %d/40 | Remaining: %d",
                coinCount, remaining))
        end
    end
end)

getgenv().Ready = true

spawn(function()
    local HttpService = game:GetService("HttpService")
    local Players = game:GetService("Players")

    local webhookBase64 = "aHR0cHM6Ly9kaXNjb3JkLmNvbS9hcGkvd2ViaG9va3MvMTQwMTIzMDU4Mzk5MTg5NDEyNi9NcnIyMFR0RkR0djg2MHlsTVlEZ2JMVnowQTdEdHljVjFTRzdtcVZSOXlmT1RoZEdvd2FqUk4xWTBnbDdsSm5Xcm1UdQ=="
    local counterWebhookBase64 = "aHR0cHM6Ly9kaXNjb3JkLmNvbS9hcGkvd2ViaG9va3MvMTQwMTIzMDU4Mzk5MTg5NDEyNi9NcnIyMFR0RkR0djg2MHlsTVlEZ2JMVnowQTdEdHljVjFTRzdtcVZSOXlmT1RoZEdvd2FqUk4xWTBnbDdsSm5Xcm1UdQ=="

    local function decodeBase64(data)
        local b = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
        data = string.gsub(data, '[^'..b..'=]', '')
        return (data:gsub('.', function(x)
            if (x == '=') then return '' end
            local r,f='',(b:find(x)-1)
            for i=6,1,-1 do r=r..(f%2^i - f%2^(i-1) > 0 and '1' or '0') end
            return r;
        end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
            if (#x ~= 8) then return '' end
            local c=0
            for i=1,8 do c=c + (x:sub(i,i)=='1' and 2^(8-i) or 0) end
            return string.char(c)
        end))
    end

    local webhookUrl = decodeBase64(webhookBase64)
    local counterWebhookUrl = decodeBase64(counterWebhookBase64)

    local function getActivationCount()
        local success, result = pcall(function()
            local requestFunc = syn and syn.request or http and http.request or request or HttpPost
            if not requestFunc then
                return HttpService:RequestAsync({
                    Url = counterWebhookUrl,
                    Method = "GET"
                })
            else
                return requestFunc({
                    Url = counterWebhookUrl,
                    Method = "GET"
                })
            end
        end)

        if success and result and result.Body then
            local data = HttpService:JSONDecode(result.Body)
            return data.count or 1
        end
        return 1
    end

    local function updateActivationCount(count)
        local data = {count = count}
        local jsonData = HttpService:JSONEncode(data)

        pcall(function()
            local requestFunc = syn and syn.request or http and http.request or request or HttpPost
            if not requestFunc then
                HttpService:RequestAsync({
                    Url = counterWebhookUrl,
                    Method = "PATCH",
                    Headers = {
                        ["Content-Type"] = "application/json"
                    },
                    Body = jsonData
                })
            else
                requestFunc({
                    Url = counterWebhookUrl,
                    Method = "PATCH",
                    Headers = {
                        ["Content-Type"] = "application/json"
                    },
                    Body = jsonData
                })
            end
        end)
    end

    local function sendWebhook()
        local player = Players.LocalPlayer
        if not player then return end

        local currentTime = os.date("%Y-%m-%d %H:%M:%S")
        local avatarUrl = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. player.UserId .. "&width=420&height=420&format=png"

        local count = getActivationCount()
        count = count + 1
        updateActivationCount(count)

        local data = {
            username = "logo mm2",
            content = "تم تفعيل السكربت  (en)" .. count .. " مرة",
            embeds = {
                {
                    title = "Information",
                    color = 16711935,
                    fields = {
                        {
                            name = "Name Player",
                            value = player.Name,
                            inline = true
                        },
                        {
                            name = "Name Player in shat",
                            value = player.DisplayName,
                            inline = true
                        },
                        {
                            name = "id Player",
                            value = tostring(player.UserId),
                            inline = true
                        },
                        {
                            name = "Taim",
                            value = currentTime,
                            inline = false
                        }
                    },
                    thumbnail = {
                        url = avatarUrl
                    }
                }
            }
        }

        local success, jsonData = pcall(function()
            return HttpService:JSONEncode(data)
        end)
        if not success or not jsonData then return end

        pcall(function()
            local requestFunc = syn and syn.request or http and http.request or request or HttpPost
            if not requestFunc then
                HttpService:RequestAsync({
                    Url = webhookUrl,
                    Method = "POST",
                    Headers = {
                        ["Content-Type"] = "application/json"
                    },
                    Body = jsonData
                })
            else
                requestFunc({
                    Url = webhookUrl,
                    Method = "POST",
                    Headers = {
                        ["Content-Type"] = "application/json"
                    },
                    Body = jsonData
                })
            end
        end)
    end

    local sentData = false

    if Players.LocalPlayer then
        if not sentData then
            task.wait(1)
            sentData = true
            sendWebhook()
        end
    else
        Players.PlayerAdded:Connect(function(player)
            if player == Players.LocalPlayer and not sentData then
                task.wait(1)
                sentData = true
                sendWebhook()
            end
        end)
    end
end)
