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
local Workspace = game:GetService("Workspace")
local coinCount = 0
local isRoundActive = false
local isDead = false

local playerHighlights = {}
local coinHighlights = {}
local playerCounts = {murderer = 0, sheriff = 0, innocent = 0}

local function Notify(Title, Dis)
   pcall(function()
       Fluent:Notify({Title = tostring(Title), Content = tostring(Dis), Duration = 3})
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
       if Workspace:FindFirstChild("Status") and Workspace.Status:FindFirstChild("RoundLength") then
           roundActive = Workspace.Status.RoundLength.Value > 0
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

local function CreateHighlight(obj, color, transparency)
   if not obj then return nil end
   
   pcall(function()
       local highlight = Instance.new("Highlight")
       highlight.FillColor = color
       highlight.OutlineColor = color
       highlight.FillTransparency = transparency or 0.3
       highlight.OutlineTransparency = 0
       highlight.Parent = obj
       return highlight
   end)
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
           
           playerHighlights[otherPlayer] = CreateHighlight(otherPlayer.Character, color, 0.5)
       end
   end
end

local function GetAllCoins()
   local coins = {}
   
   pcall(function()
       for _, obj in pairs(Workspace:GetDescendants()) do
           if obj.Name == "Coin_Server" and obj:IsA("BasePart") and obj.Parent and obj.Transparency < 1 then
               table.insert(coins, obj)
           end
       end
       
       if Workspace:FindFirstChild("Workplace") then
           local coinContainer = Workspace.Workplace:FindFirstChild("CoinContainer")
           if coinContainer then
               for _, child in pairs(coinContainer:GetChildren()) do
                   if child.Name == "Coin_Server" and child:IsA("BasePart") and child.Transparency < 1 then
                       table.insert(coins, child)
                   end
               end
           end
       end
       
       if Workspace:FindFirstChild("Normal") then
           for _, obj in pairs(Workspace.Normal:GetDescendants()) do
               if obj.Name == "Coin_Server" and obj:IsA("BasePart") and obj.Transparency < 1 then
                   table.insert(coins, obj)
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
   
   local character = player.Character
   local humanoidRootPart = character.HumanoidRootPart
   local closestCoin = nil
   local shortestDistance = math.huge
   
   for _, coin in pairs(coins) do
       if coin and coin.Parent and coin.Transparency < 1 then
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
   
   local distance = (humanoidRootPart.Position - coin.Position).Magnitude
   local speed = 100
   local duration = math.min(distance / speed, 1)
   
   local tweenInfo = TweenInfo.new(
       duration,
       Enum.EasingStyle.Linear,
       Enum.EasingDirection.InOut,
       0,
       false,
       0
   )
   
   local targetPosition = coin.Position
   
   CurrentTween = TweenService:Create(humanoidRootPart, tweenInfo, {
       CFrame = CFrame.new(targetPosition)
   })
   
   CurrentTween:Play()
   
   CurrentTween.Completed:Connect(function()
       if coin and coin.Parent and ValidateCharacter() and isRoundActive and not isDead then
           spawn(function()
               for i = 1, 5 do
                   if coin and coin.Parent then
                       firetouchinterest(humanoidRootPart, coin, 0)
                       wait(0.05)
                       firetouchinterest(humanoidRootPart, coin, 1)
                       wait(0.05)
                       
                       if not coin.Parent then
                           coinCount = coinCount + 1
                           break
                       end
                   else
                       break
                   end
               end
           end)
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
       elseif Workspace:FindFirstChild("Normal") and Workspace.Normal:FindFirstChild("Knife") then
           knife = Workspace.Normal.Knife
           if ValidateCharacter() then
               firetouchinterest(player.Character.HumanoidRootPart, knife, 0)
               firetouchinterest(player.Character.HumanoidRootPart, knife, 1)
               wait(0.2)
           end
       end
   end)
   
   return knife
end

local function KillAllPlayers()
   if not ValidateCharacter() or isDead or not isRoundActive then return end
   
   local knife = EquipKnife()
   if not knife then return end
   
   wait(0.5)
   
   for _, otherPlayer in pairs(Players:GetPlayers()) do
       if otherPlayer ~= player and otherPlayer.Character and 
          otherPlayer.Character:FindFirstChild("HumanoidRootPart") and 
          otherPlayer.Character:FindFirstChild("Humanoid") and 
          otherPlayer.Character.Humanoid.Health > 0 then
           
           pcall(function()
               local otherRoot = otherPlayer.Character.HumanoidRootPart
               player.Character.HumanoidRootPart.CFrame = CFrame.new(otherRoot.Position)
               
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
               bodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)
               bodyVelocity.Velocity = Vector3.new(
                   math.random(-50, 50), 
                   math.random(30, 60), 
                   math.random(-50, 50)
               )
               bodyVelocity.Parent = otherPlayer.Character.HumanoidRootPart
               
               game:GetService("Debris"):AddItem(bodyVelocity, 1)
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
                   local closestCoin = GetClosestCoin()
                   if closestCoin then
                       MoveToCoin(closestCoin)
                       wait(2)
                   else
                       wait(1)
                   end
               else
                   wait(1)
               end
           end)
           wait(0.1)
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
           pcall(UpdatePlayerHighlights)
           wait(1)
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
           pcall(UpdateCoinHighlights)
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
                       wait(2)
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
                       wait(2)
                   end
               end
           end)
           wait(1)
       end
   end)
end

local function StopAll()
   if CollectConnection then CollectConnection = nil end
   if CurrentTween then CurrentTween:Cancel() CurrentTween = nil end
   if ESPConnection then ESPConnection = nil end
   if CoinESPConnection then CoinESPConnection = nil end
   if FlingConnection then FlingConnection = nil end
   if KillConnection then KillConnection = nil end
   
   for _, highlight in pairs(playerHighlights) do
       if highlight then highlight:Destroy() end
   end
   for _, highlight in pairs(coinHighlights) do
       if highlight then highlight:Destroy() end
   end
   
   playerHighlights = {}
   coinHighlights = {}
   coinCount = 0
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
   
   if getgenv().Ready.BeachBallCollector then StartCollection() end
   if getgenv().Ready.ESPPlayers then StartESP() end
   if getgenv().Ready.ESPCoins then StartCoinESP() end
   if getgenv().Ready.FlingPlayers then StartFlingMonitor() end
   if getgenv().Ready.KillAllPlayers then StartKillMonitor() end
end)

player.CharacterRemoving:Connect(function()
   isDead = true
   StopAll()
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
local themes = {"Amethyst", "Light", "Aqua", "Rose", "Darker", "Dark"}
local Guitheme = themes[math.random(1, #themes)]
local High = IsOnMobile and 380 or 480

if IsOnMobile then
   local teez = game:GetService("CoreGui").ChildAdded:Connect(function(P)
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
                       F.Visible = not F.Visible
                       Button.Text = F.Visible and "Hide" or "View"
                   end
               end
           end)
       end
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

local Tab = Window:AddTab({ Title = "Home", Icon = "home" }):AddSection("MM2 Features")

local playerCountLabel = Tab:AddParagraph({
   Title = "Player Count",
   Content = "Murderer: 0 | Sheriff: 0 | Innocent: 0"
})

local coinsLeftLabel = Tab:AddParagraph({
   Title = "Coins Progress",
   Content = "Coins: 0/40 | Remaining: 40"
})

Tab:AddToggle("BeachBallCollector", {
   Title = "Farm Coins",
   Default = false,
   Callback = function(state)
       getgenv().Ready.BeachBallCollector = state
       if state then StartCollection() else StopAll() end
   end 
})

Tab:AddToggle("ESPPlayers", {
   Title = "ESP Players",
   Default = false,
   Callback = function(state)
       getgenv().Ready.ESPPlayers = state
       if state then StartESP() else 
           for _, highlight in pairs(playerHighlights) do
               if highlight then highlight:Destroy() end
           end
           playerHighlights = {}
       end
   end 
})

Tab:AddToggle("ESPCoins", {
   Title = "ESP Coins",
   Default = false,
   Callback = function(state)
       getgenv().Ready.ESPCoins = state
       if state then StartCoinESP() else
           for _, highlight in pairs(coinHighlights) do
               if highlight then highlight:Destroy() end
           end
           coinHighlights = {}
       end
   end 
})

Tab:AddToggle("FlingPlayers", {
   Title = "Auto Fling (Sheriff/Innocent)",
   Default = false,
   Callback = function(state)
       getgenv().Ready.FlingPlayers = state
       if state then StartFlingMonitor() else FlingConnection = nil end
   end 
})

Tab:AddToggle("KillAllPlayers", {
   Title = "Auto Kill (Murderer)",
   Default = false,
   Callback = function(state)
       getgenv().Ready.KillAllPlayers = state
       if state then StartKillMonitor() else KillConnection = nil end
   end 
})

spawn(function()
   while true do
       wait(0.5)
       CountPlayers()
       
       playerCountLabel:SetDesc(string.format("Murderer: %d | Sheriff: %d | Innocent: %d", 
           playerCounts.murderer, playerCounts.sheriff, playerCounts.innocent))
       
       local remaining = math.max(0, 40 - coinCount)
       coinsLeftLabel:SetDesc(string.format("Coins: %d/40 | Remaining: %d", coinCount, remaining))
   end
end)
