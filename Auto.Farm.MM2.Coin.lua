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
       Fluent:Notify({Title = tostring(Title), Content = tostring(Dis), Duration = 3})
       local sound = Instance.new("Sound", workspace) 
       sound.SoundId = "rbxassetid://3398620867" 
       sound.Volume = 2 
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
           roundActive = workspace.Status.RoundLength.Value > 0
       elseif player.PlayerGui:FindFirstChild("MainGUI") then
           local mainGui = player.PlayerGui.MainGUI
           roundActive = mainGui:FindFirstChild("Game") and mainGui.Game.Visible
       end
   end)
   return roundActive
end

local function GetPlayerRole()
   local role = "Unknown"
   pcall(function()
       local mainGui = player.PlayerGui:FindFirstChild("MainGUI")
       if mainGui and mainGui:FindFirstChild("Game") then
           local roleGui = mainGui.Game:FindFirstChild("Roles")
           if roleGui and roleGui:FindFirstChild("RoleText") then
               role = roleGui.RoleText.Text
           end
       end
   end)
   return role
end

local function CreateHighlight(obj, color, transparency)
   if not obj then return nil end
   
   local highlight = Instance.new("Highlight")
   highlight.FillColor = color
   highlight.OutlineColor = color
   highlight.FillTransparency = transparency or 0.4
   highlight.OutlineTransparency = 0
   highlight.Parent = obj
   return highlight
end

local function GetPlayerRole_Advanced(targetPlayer)
   local role = "innocent"
   
   pcall(function()
       if targetPlayer and targetPlayer.Character then
           local character = targetPlayer.Character
           local backpack = targetPlayer.Backpack
           
           if character:FindFirstChild("Knife") or (backpack and backpack:FindFirstChild("Knife")) then
               role = "murderer"
           elseif character:FindFirstChild("Gun") or (backpack and backpack:FindFirstChild("Gun")) then
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
           end
           
           local role = GetPlayerRole_Advanced(otherPlayer)
           local color = Color3.fromRGB(0, 255, 0)
           
           if role == "murderer" then
               color = Color3.fromRGB(255, 0, 0)
           elseif role == "sheriff" then
               color = Color3.fromRGB(0, 100, 255)
           end
           
           playerHighlights[otherPlayer] = CreateHighlight(otherPlayer.Character, color, 0.5)
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
       
       local workplace = workspace:FindFirstChild("Workplace")
       if workplace then
           local coinContainer = workplace:FindFirstChild("CoinContainer")
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

local function UpdateCoinHighlights()
   if not getgenv().Ready.ESPCoins then return end
   
   for _, highlight in pairs(coinHighlights) do
       if highlight and highlight.Parent then
           highlight:Destroy()
       end
   end
   coinHighlights = {}
   
   local coins = GetAllCoins()
   for _, coin in pairs(coins) do
       if coin and coin.Parent then
           local highlight = CreateHighlight(coin, Color3.fromRGB(255, 255, 0), 0.2)
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

local function GetClosestCoin()
   if not ValidateCharacter() then return nil end
   
   local coins = GetAllCoins()
   if #coins == 0 then return nil end
   
   local humanoidRootPart = player.Character.HumanoidRootPart
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
   
   local distance = (humanoidRootPart.Position - coin.Position).Magnitude
   local speed = 100
   local duration = math.clamp(distance / speed, 0.1, 1.2)
   
   local tweenInfo = TweenInfo.new(
       duration,
       Enum.EasingStyle.Linear,
       Enum.EasingDirection.InOut,
       0,
       false,
       0
   )
   
   local targetPosition = coin.Position + Vector3.new(0, 1, 0)
   
   CurrentTween = TweenService:Create(humanoidRootPart, tweenInfo, {
       Position = targetPosition
   })
   
   CurrentTween:Play()
   
   spawn(function()
       CurrentTween.Completed:Wait()
       
       if coin and coin.Parent and ValidateCharacter() and isRoundActive and not isDead then
           local attempts = 0
           
           while coin and coin.Parent and attempts < 5 and ValidateCharacter() and not isDead do
               attempts = attempts + 1
               
               humanoidRootPart.Position = coin.Position + Vector3.new(0, 0.5, 0)
               
               firetouchinterest(humanoidRootPart, coin, 0)
               wait(0.02)
               firetouchinterest(humanoidRootPart, coin, 1)
               wait(0.02)
               
               if not coin.Parent then
                   coinCount = coinCount + 1
                   break
               end
           end
       end
       
       if ValidateCharacter() then
           humanoid.PlatformStand = false
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
               wait(0.2)
               if player.Character:FindFirstChild("Knife") then
                   knife = player.Character.Knife
               end
           end
       end
   end)
   
   return knife
end

local function KillAllPlayers()
   if not ValidateCharacter() or isDead or not isRoundActive then return end
   
   local knife = EquipKnife()
   if not knife then 
       Notify("Error", "Knife not found")
       return 
   end
   
   Notify("Kill Mode", "Eliminating targets")
   
   for _, otherPlayer in pairs(Players:GetPlayers()) do
       if otherPlayer ~= player and otherPlayer.Character and 
          otherPlayer.Character:FindFirstChild("HumanoidRootPart") and 
          otherPlayer.Character:FindFirstChild("Humanoid") and 
          otherPlayer.Character.Humanoid.Health > 0 then
           
           pcall(function()
               local otherRoot = otherPlayer.Character.HumanoidRootPart
               player.Character.HumanoidRootPart.Position = otherRoot.Position + Vector3.new(0, 1, 0)
               
               wait(0.1)
               
               if knife:FindFirstChild("Stab") then
                   knife.Stab:FireServer()
               else
                   knife:Activate()
               end
               
               wait(0.1)
           end)
       end
   end
end

local function FlingAllPlayers()
   if not ValidateCharacter() or isDead or not isRoundActive then return end
   
   Notify("Fling Mode", "Activating fling")
   
   for _, otherPlayer in pairs(Players:GetPlayers()) do
       if otherPlayer ~= player and otherPlayer.Character and otherPlayer.Character:FindFirstChild("HumanoidRootPart") then
           pcall(function()
               local bodyVelocity = Instance.new("BodyVelocity")
               bodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)
               bodyVelocity.Velocity = Vector3.new(
                   math.random(-50, 50), 
                   math.random(30, 70), 
                   math.random(-50, 50)
               )
               bodyVelocity.Parent = otherPlayer.Character.HumanoidRootPart
               
               game:GetService("Debris"):AddItem(bodyVelocity, 1)
           end)
       end
   end
end

local function StartCollection()
   if CollectConnection then
       CollectConnection:Disconnect()
   end
   
   CollectConnection = spawn(function()
       while getgenv().Ready.BeachBallCollector do
           pcall(function()
               isRoundActive = CheckRoundStatus()
               
               if ValidateCharacter() and isRoundActive and not isDead then
                   local closestCoin = GetClosestCoin()
                   if closestCoin then
                       MoveToCoin(closestCoin)
                       wait(2)
                   else
                       wait(1)
                   end
               else
                   wait(2)
               end
           end)
           wait(0.1)
       end
   end)
end

local function StartESP()
   if ESPConnection then
       ESPConnection:Disconnect()
   end
   
   ESPConnection = spawn(function()
       while getgenv().Ready.ESPPlayers do
           pcall(function()
               if isRoundActive then
                   UpdatePlayerHighlights()
               end
           end)
           wait(1)
       end
   end)
end

local function StartCoinESP()
   if CoinESPConnection then
       CoinESPConnection:Disconnect()
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
           wait(1)
       end
   end)
end

local function StartKillMonitor()
   if KillConnection then
       KillConnection:Disconnect()
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
           wait(1)
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
       player.Character.Humanoid.PlatformStand = false
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
       player.Character.Humanoid.Died:Connect(function()
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
       wait(1)
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
       playerHighlights[removedPlayer]:Destroy()
       playerHighlights[removedPlayer] = nil
   end
end)

if ValidateCharacter() then
   SetupCharacterHandlers()
end

local IsOnMobile = table.find({Enum.Platform.IOS, Enum.Platform.Android}, UserInputService:GetPlatform())
local Guitheme = "Dark"
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
           Button.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
           
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
   SubTitle = "By Front -evill / 7sone",
   TabWidth = 160,
   Size = UDim2.fromOffset(580, High),
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
   Default = getgenv().Ready.BeachBallCollector or false,
   Callback = function(state)
       getgenv().Ready.BeachBallCollector = state
       
       if state then
           StartCollection()
           Notify("Farm Active", "Coin collection started")
       else
           StopCollection()
           Notify("Farm Stopped", "Coin collection stopped")
       end
   end 
})

Tab:AddToggle("ESPPlayers", {
   Title = "ESP Players",
   Default = getgenv().Ready.ESPPlayers or false,
   Callback = function(state)
       getgenv().Ready.ESPPlayers = state
       
       if state then
           StartESP()
           Notify("ESP Active", "Player highlighting enabled")
       else
           StopESP()
           Notify("ESP Stopped", "Player highlighting disabled")
       end
   end 
})

Tab:AddToggle("ESPCoins", {
   Title = "ESP Coins",
   Default = getgenv().Ready.ESPCoins or false,
   Callback = function(state)
       getgenv().Ready.ESPCoins = state
       
       if state then
           StartCoinESP()
           Notify("Coin ESP Active", "Coin highlighting enabled")
       else
           StopCoinESP()
           Notify("Coin ESP Stopped", "Coin highlighting disabled")
       end
   end 
})

Tab:AddToggle("FlingPlayers", {
   Title = "Auto Fling (Sheriff/Innocent)",
   Default = getgenv().Ready.FlingPlayers or false,
   Callback = function(state)
       getgenv().Ready.FlingPlayers = state
       
       if state then
           StartFlingMonitor()
           Notify("Fling Monitor", "Auto fling activated")
       else
           StopFlingMonitor()
           Notify("Fling Stopped", "Auto fling deactivated")
       end
   end 
})

Tab:AddToggle("KillAllPlayers", {
   Title = "Auto Kill (Murderer)",
   Default = getgenv().Ready.KillAllPlayers or false,
   Callback = function(state)
       getgenv().Ready.KillAllPlayers = state
       
       if state then
           StartKillMonitor()
           Notify("Kill Monitor", "Auto kill activated")
       else
           StopKillMonitor()
           Notify("Kill Stopped", "Auto kill deactivated")
       end
   end 
})

spawn(function()
   while true do
       wait(0.5)
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
