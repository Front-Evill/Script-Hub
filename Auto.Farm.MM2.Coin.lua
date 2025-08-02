getgenv().Ready = getgenv().Ready or {}
getgenv().Ready.BeachBallCollector = false
getgenv().Ready.ESPPlayers = false
getgenv().Ready.ESPCoins = false
getgenv().Ready.FlingPlayers = false
getgenv().Ready.KillAllPlayers = false

local CollectConnection = nil
local CurrentTween = nil
local ESPConnection = nil
local CoinESPConnection = nil
local FlingConnection = nil
local KillConnection = nil
local player = game.Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local coinCount = 0
local isRoundActive = false
local isDead = false

local playerHighlights = {}
local coinHighlights = {}
local playerCounts = {murderer = 0, sheriff = 0, innocent = 0}

local function Notify(Title, Dis)
    pcall(function()
        Fluent:Notify({Title = tostring(Title), Content = tostring(Dis), Duration = 5})
        local sound = Instance.new("Sound", game.Workspace) 
        sound.SoundId = "rbxassetid://3398620867" 
        sound.Volume = 3 
        sound.Ended:Connect(function() sound:Destroy() end) 
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
        highlight.FillTransparency = isPlayer and 0.5 or 0.3
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
                color = Color3.fromRGB(0, 0, 255)
            end
            
            playerHighlights[otherPlayer] = CreateHighlight(otherPlayer.Character, color, true)
        end
    end
end

local function UpdateCoinHighlights()
    if not getgenv().Ready.ESPCoins then return end
    
    for _, highlight in pairs(coinHighlights) do
        if highlight then
            highlight:Destroy()
        end
    end
    coinHighlights = {}
    
    local coins = GetAllCoins()
    for _, coin in pairs(coins) do
        if coin and coin.Parent then
            local highlight = CreateHighlight(coin, Color3.fromRGB(255, 255, 0), false)
            if highlight then
                table.insert(coinHighlights, highlight)
            end
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
            if obj.Name == "Coin_Server" and obj:IsA("BasePart") and obj.Parent then
                table.insert(coins, obj)
            end
        end
        
        if workspace:FindFirstChild("Workplace") then
            local coinContainer = workspace.Workplace:FindFirstChild("CoinContainer")
            if coinContainer then
                for _, child in pairs(coinContainer:GetChildren()) do
                    if child.Name == "Coin_Server" and child:IsA("BasePart") then
                        table.insert(coins, child)
                    end
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
    
    local character = player.Character
    local humanoidRootPart = character.HumanoidRootPart
    local humanoid = character.Humanoid
    
    if CurrentTween then
        CurrentTween:Cancel()
        CurrentTween = nil
    end
    
    humanoid.PlatformStand = true
    humanoidRootPart.Anchored = false
    
    local distance = (humanoidRootPart.Position - coin.Position).Magnitude
    local speed = 80
    local duration = distance / speed
    
    if duration < 0.2 then duration = 0.2 end
    if duration > 1.5 then duration = 1.5 end
    
    local tweenInfo = TweenInfo.new(
        duration,
        Enum.EasingStyle.Quint,
        Enum.EasingDirection.Out,
        0,
        false,
        0
    )
    
    local targetPosition = coin.Position + Vector3.new(0, 1.5, 0)
    local targetCFrame = CFrame.lookAt(targetPosition, coin.Position)
    
    CurrentTween = TweenService:Create(humanoidRootPart, tweenInfo, {
        CFrame = targetCFrame
    })
    
    CurrentTween:Play()
    
    CurrentTween.Completed:Connect(function()
        if coin and coin.Parent and ValidateCharacter() and isRoundActive and not isDead then
            spawn(function()
                local attempts = 0
                local originalCoin = coin
                
                while originalCoin and originalCoin.Parent and attempts < 8 and ValidateCharacter() and not isDead do
                    attempts = attempts + 1
                    
                    humanoidRootPart.CFrame = CFrame.new(originalCoin.Position + Vector3.new(0, 0.5, 0))
                    
                    firetouchinterest(humanoidRootPart, originalCoin, 0)
                    wait(0.05)
                    firetouchinterest(humanoidRootPart, originalCoin, 1)
                    wait(0.05)
                    
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
    
    Notify("Kill Mode", "Starting elimination process...")
    wait(0.8)
    
    for _, otherPlayer in pairs(Players:GetPlayers()) do
        if otherPlayer ~= player and otherPlayer.Character and 
           otherPlayer.Character:FindFirstChild("HumanoidRootPart") and 
           otherPlayer.Character:FindFirstChild("Humanoid") and 
           otherPlayer.Character.Humanoid.Health > 0 then
            
            pcall(function()
                local otherRoot = otherPlayer.Character.HumanoidRootPart
                
                local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
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
                
                wait(0.2)
            end)
        end
    end
end

local function FlingAllPlayers()
    if not ValidateCharacter() or isDead or not isRoundActive then return end
    
    Notify("Fling Mode", "Activating fling script...")
    
    pcall(function()
        for _, otherPlayer in pairs(Players:GetPlayers()) do
            if otherPlayer ~= player and otherPlayer.Character and otherPlayer.Character:FindFirstChild("HumanoidRootPart") then
                local bodyVelocity = Instance.new("BodyVelocity")
                bodyVelocity.MaxForce = Vector3.new(5000, 5000, 5000)
                bodyVelocity.Velocity = Vector3.new(
                    math.random(-60, 60), 
                    math.random(40, 80), 
                    math.random(-60, 60)
                )
                bodyVelocity.Parent = otherPlayer.Character.HumanoidRootPart
                
                game:GetService("Debris"):AddItem(bodyVelocity, 1.2)
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
                        wait(0.8)
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

local function StartCoinESP()
    if CoinESPConnection then
        CoinESPConnection:Disconnect()
        CoinESPConnection = nil
    end
    
    CoinESPConnection = spawn(function()
        while getgenv().Ready.ESPCoins do
            pcall(function()
                if isRoundActive then
                    UpdateCoinHighlights()
                end
            end)
            wait(0.5)
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
    if CurrentTween then
        CurrentTween:Cancel()
        CurrentTween = nil
    end
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

local function StopCoinESP()
    if CoinESPConnection then
        CoinESPConnection = nil
    end
    
    for _, highlight in pairs(coinHighlights) do
        if highlight then
            highlight:Destroy()
        end
    end
    coinHighlights = {}
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
        end)
    end
end

player.CharacterAdded:Connect(function()
    wait(1)
    isDead = false
    SetupCharacterHandlers()
    coinCount = 0
    
    if getgenv().Ready.BeachBallCollector then
        wait(0.8)
        StartCollection()
    end
    if getgenv().Ready.ESPPlayers then
        StartESP()
    end
    if getgenv().Ready.ESPCoins then
        StartCoinESP()
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
    StopCoinESP()
end)

Players.PlayerRemoving:Connect(function(removedPlayer)
    if playerHighlights[removedPlayer] then
        playerHighlights[removedPlayer]:Destroy() playerHighlights[removedPlayer] = nil
    end
end) 

if ValidateCharacter() then
    SetupCharacterHandlers()
end

local IsOnMobile = table.find({Enum.Platform.IOS, Enum.Platform.Android}, UserInputService:GetPlatform())
function RandomTheme() 
    local themes = {"Amethyst", "Light", "Aqua", "Rose", "Darker", "Dark"} 
    return themes[math.random(1, #themes)] 
end

local Guitheme = RandomTheme()
local High = IsOnMobile and 380 or 480
if IsOnMobile then
    local teez
    teez = game:GetService("CoreGui").ChildAdded:Connect(function(P)
        if P.Name == "ScreenGui" then
            local Button = Instance.new("TextButton")
            local UICorner = Instance.new("UICorner")
            
            Button.Name = "Hider"
            Button.Parent = P
            Button.Size = UDim2.new(0, 100, 0, 50)
            Button.Position = UDim2.new(0, 10, 0.5, -25)
            Button.BackgroundTransparency = 0.5
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
            UICorner.CornerRadius = UDim.new(0, 12)
            
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
    Title = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name,
    SubTitle = "By Front -evill / 7sone - Enhanced Version",
    TabWidth = 160,
    Size = UDim2.fromOffset(600, High),
    Acrylic = false,
    Theme = Guitheme,
    MinimizeKey = Enum.KeyCode.B
})

local Tabs = {
    Main = Window:AddTab({ Title = "Home", Icon = "home" }),
}

Window:SelectTab(1)

local Tab = Tabs.Main:AddSection("MM2 Auto Features")

local playerCountLabel = Tab:AddParagraph({
    Title = "Player Count",
    Content = "Murderer: 0 | Sheriff: 0 | Innocent: 0"
})

local coinsLeftLabel = Tab:AddParagraph({
    Title = "Coins Progress",
    Content = "Coins Collected: 0/40 | Remaining: 40"
})

Tab:AddToggle("BeachBallCollectorEnhanced", {
    Title = "Start Farm Beach Ball",
    Description = nil,
    Default = getgenv().Ready.BeachBallCollector or false,
    Callback = function(state)
        getgenv().Ready.BeachBallCollector = state
        
        if state then
            StartCollection()
            Notify("Farm Active", "Smooth coin collection started!")
        else
            StopCollection()
            Notify("Farm Stopped", "Coin collection stopped!")
        end
    end 
})

Tab:AddToggle("ESPPlayers", {
    Title = "ESP Players",
    Description = nil,
    Default = getgenv().Ready.ESPPlayers or false,
    Callback = function(state)
        getgenv().Ready.ESPPlayers = state
        
        if state then
            StartESP()
            Notify("ESP Active", "Player highlighting enabled!")
        else
            StopESP()
            Notify("ESP Stopped", "Player highlighting disabled!")
        end
    end 
})

Tab:AddToggle("ESPCoins", {
    Title = "ESP Coins / كشف الكرات",
    Description = "Show all coins with yellow highlight",
    Default = getgenv().Ready.ESPCoins or false,
    Callback = function(state)
        getgenv().Ready.ESPCoins = state
        
        if state then
            StartCoinESP()
            Notify("Coin ESP Active", "Coin highlighting enabled!")
        else
            StopCoinESP()
            Notify("Coin ESP Stopped", "Coin highlighting disabled!")
        end
    end 
})

Tab:AddToggle("FlingPlayers", {
    Title = "Auto Fling (Sheriff/Innocent)",
    Description = "Fling all players when 40 coins as Sheriff/Innocent",
    Default = getgenv().Ready.FlingPlayers or false,
    Callback = function(state)
        getgenv().Ready.FlingPlayers = state
        
        if state then
            StartFlingMonitor()
            Notify("Fling Monitor", "Auto fling activated for Sheriff/Innocent!")
        else
            StopFlingMonitor()
            Notify("Fling Stopped", "Auto fling deactivated!")
        end
    end 
})

Tab:AddToggle("KillAllPlayers", {
    Title = "Auto Kill (Murderer) ",
    Description = nil,
    Default = getgenv().Ready.KillAllPlayers or false,
    Callback = function(state)
        getgenv().Ready.KillAllPlayers = state
        
        if state then
            StartKillMonitor()
            Notify("Kill Monitor", "Auto kill activated for Murderer!")
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
           getgenv().Ready.ESPCoins or getgenv().Ready.FlingPlayers or 
           getgenv().Ready.KillAllPlayers then
            
            CountPlayers()
            
            playerCountLabel:SetDesc(string.format("Murderer: %d | Sheriff: %d | Innocent: %d", 
                playerCounts.murderer, playerCounts.sheriff, playerCounts.innocent))
            
            local remaining = math.max(0, 40 - coinCount)
            coinsLeftLabel:SetDesc(string.format("Coins Collected: %d/40 | Remaining: %d",
                coinCount, remaining))
        end
    end
end)
