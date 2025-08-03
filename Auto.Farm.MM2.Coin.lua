getgenv().Ready = getgenv().Ready or {}
getgenv().Ready.BeachBallCollector = false
getgenv().Ready.ESPPlayers = false
getgenv().Ready.KillAllPlayers = false

local CollectConnection = nil
local ESPConnection = nil
local KillConnection = nil
local player = game.Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local coinCount = 0
local isRoundActive = false
local isDead = false
local Running = false
local TweenList = {}
local hasKilledThisRound = false

local playerHighlights = {}
local playerCounts = {murderer = 0, sheriff = 0, innocent = 0}

local function ShowWelcomeAnimation()
   local ScreenGui = Instance.new("ScreenGui")
   local TextLabel = Instance.new("TextLabel")
   
   ScreenGui.Name = "WelcomeGui"
   ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
   ScreenGui.ResetOnSpawn = false
   ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
   
   TextLabel.Parent = ScreenGui
   TextLabel.BackgroundTransparency = 1
   TextLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
   TextLabel.Size = UDim2.new(0, 600, 0, 100)
   TextLabel.AnchorPoint = Vector2.new(0.5, 0.5)
   TextLabel.Font = Enum.Font.GothamBold
   TextLabel.Text = ""
   TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
   TextLabel.TextScaled = true
   TextLabel.TextStrokeTransparency = 0
   TextLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
   TextLabel.ZIndex = 10
   
   local welcomeText = "Welcome to script Front evill"
   
   spawn(function()
       for i = 1, #welcomeText do
           TextLabel.Text = string.sub(welcomeText, 1, i)
           wait(0.08)
       end
       
       wait(2.5)
       local fadeOut = TweenService:Create(TextLabel, TweenInfo.new(1.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
           TextTransparency = 1
       })
       fadeOut:Play()
       fadeOut.Completed:Connect(function()
           ScreenGui:Destroy()
       end)
   end)
end

local function Notify(Title, Dis)
   pcall(function()
       Fluent:Notify({Title = tostring(Title), Content = tostring(Dis), Duration = 3})
       local sound = Instance.new("Sound", game.Workspace) 
       sound.SoundId = "rbxassetid://3398620867" 
       sound.Volume = 0.3 
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

local function GetPlayerCoins()
   local coins = 0
   pcall(function()
       if player.PlayerGui:FindFirstChild("MainGUI") then
           local coinsGui = player.PlayerGui.MainGUI:FindFirstChild("Game")
           if coinsGui and coinsGui:FindFirstChild("CashBag") then
               local coinsText = coinsGui.CashBag:FindFirstChild("TextLabel")
               if coinsText then
                   coins = tonumber(coinsText.Text) or 0
               end
           end
       end
       
       if player.leaderstats and player.leaderstats:FindFirstChild("Coins") then
           coins = player.leaderstats.Coins.Value
       end
   end)
   return coins
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
       
       if player.Character then
           if player.Character:FindFirstChild("Knife") or 
              (player.Backpack and player.Backpack:FindFirstChild("Knife")) then
               role = "Murderer"
           elseif player.Character:FindFirstChild("Gun") or 
                  (player.Backpack and player.Backpack:FindFirstChild("Gun")) then
               role = "Sheriff"
           else
               if role == "Unknown" then
                   role = "Innocent"
               end
           end
       end
   end)
   return role
end

local function CreateHighlight(obj, color)
   if obj and obj:FindFirstChild("HumanoidRootPart") then
       local highlight = Instance.new("Highlight")
       highlight.FillColor = color
       highlight.OutlineColor = color
       highlight.FillTransparency = 0.2
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
           
           playerHighlights[otherPlayer] = CreateHighlight(otherPlayer.Character, color)
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

local function TweenTo(Part)
   if Running then return end
   Running = true
   local Tween = TweenService:Create(
       player.Character.HumanoidRootPart,
       TweenInfo.new((player.Character.HumanoidRootPart.Position - Part.Position).Magnitude / 27, Enum.EasingStyle.Linear),
       {CFrame = CFrame.new(Part.Position) * CFrame.Angles(0, math.rad(player.Character.HumanoidRootPart.Rotation.Y), 0)}
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

local function MoveToCoin(coin)
   if not ValidateCharacter() or not coin or not coin.Parent or isDead or not isRoundActive then
       return false
   end
   
   TweenTo(coin)
   
   spawn(function()
       wait(0.8)
       if coin and coin.Parent and ValidateCharacter() and isRoundActive and not isDead then
           local attempts = 0
           local originalCoin = coin
           
           while originalCoin and originalCoin.Parent and attempts < 6 and ValidateCharacter() and not isDead do
               attempts = attempts + 1
               
               player.Character.HumanoidRootPart.CFrame = CFrame.new(originalCoin.Position + Vector3.new(0, 0.5, 0))
               
               firetouchinterest(player.Character.HumanoidRootPart, originalCoin, 0)
               wait(0.05)
               firetouchinterest(player.Character.HumanoidRootPart, originalCoin, 1)
               wait(0.05)
               
               if not originalCoin.Parent then
                   coinCount = coinCount + 1
                   break
               end
           end
           
           local actualCoins = GetPlayerCoins()
           if actualCoins > coinCount then
               coinCount = actualCoins
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
   if not ValidateCharacter() or isDead or not isRoundActive or hasKilledThisRound then return end
   
   local knife = EquipKnife()
   if not knife then 
       Notify("Error", "No knife found!")
       return 
   end
   
   hasKilledThisRound = true
   Notify("Kill Mode", "Starting elimination process...")
   wait(0.7)
   
   local allPlayers = {}
   for _, otherPlayer in pairs(Players:GetPlayers()) do
       if otherPlayer ~= player and otherPlayer.Character and 
          otherPlayer.Character:FindFirstChild("HumanoidRootPart") and 
          otherPlayer.Character:FindFirstChild("Humanoid") and 
          otherPlayer.Character.Humanoid.Health > 0 then
           table.insert(allPlayers, otherPlayer)
       end
   end
   
   if ValidateCharacter() then
       local humanoidRootPart = player.Character.HumanoidRootPart
       local humanoid = player.Character.Humanoid
       
       for _, targetPlayer in pairs(allPlayers) do
           pcall(function()
               if targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
                   local targetPosition = targetPlayer.Character.HumanoidRootPart.Position
                   
                   humanoidRootPart.CFrame = CFrame.new(targetPosition + Vector3.new(0, 2, 0))
                   
                   local bodyVelocity = Instance.new("BodyVelocity")
                   bodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)
                   bodyVelocity.Velocity = (targetPosition - humanoidRootPart.Position).Unit * 50
                   bodyVelocity.Parent = humanoidRootPart
                   
                   game:GetService("Debris"):AddItem(bodyVelocity, 0.5)
                   
                   wait(0.3)
                   
                   if knife and knife:FindFirstChild("Stab") then
                       knife.Stab:FireServer()
                   elseif knife then
                       knife:Activate()
                   end
                   
                   wait(0.2)
               end
           end)
       end
   end
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
                   
                   local actualCoins = GetPlayerCoins()
                   if actualCoins > 0 then
                       coinCount = actualCoins
                   end
                   
                   local closestCoin = GetClosestCoin()
                   if closestCoin then
                       MoveToCoin(closestCoin)
                       wait(2.0)
                   else
                       wait(0.5)
                   end
               else
                   wait(1.0)
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
           pcall(function()
               if isRoundActive then
                   UpdatePlayerHighlights()
               end
           end)
           wait(1.0)
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
           wait(0.5)
           pcall(function()
               if isRoundActive and not isDead and ValidateCharacter() then
                   local actualCoins = GetPlayerCoins()
                   if actualCoins >= 40 and not hasKilledThisRound then
                       local role = GetPlayerRole()
                       
                       if role == "Murderer" or role:lower():find("murder") then
                           KillAllPlayers()
                           wait(5)
                       end
                   end
               end
           end)
       end
   end)
end

local function StopCollection()
   if CollectConnection then
       CollectConnection:Disconnect()
       CollectConnection = nil
   end
   StopAllTweens()
   coinCount = 0
end

local function StopESP()
   if ESPConnection then
       ESPConnection:Disconnect()
       ESPConnection = nil
   end
   
   for _, highlight in pairs(playerHighlights) do
       if highlight then
           highlight:Destroy()
       end
   end
   playerHighlights = {}
end

local function StopKillMonitor()
   if KillConnection then
       KillConnection:Disconnect()
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

local previousRoundStatus = false
spawn(function()
   while true do
       wait(1)
       local currentRoundStatus = CheckRoundStatus()
       if currentRoundStatus ~= previousRoundStatus then
           if currentRoundStatus then
               hasKilledThisRound = false
               coinCount = 0
               isDead = false
           end
           previousRoundStatus = currentRoundStatus
       end
   end
end)

player.CharacterAdded:Connect(function()
   wait(2)
   isDead = false
   SetupCharacterHandlers()
   coinCount = 0
   TweenList = {}
   Running = false
   hasKilledThisRound = false
   
   if getgenv().Ready.BeachBallCollector then
       wait(0.5)
       StartCollection()
   end
   if getgenv().Ready.ESPPlayers then
       StartESP()
   end
   if getgenv().Ready.KillAllPlayers then
       StartKillMonitor()
   end
end)

player.CharacterRemoving:Connect(function()
   isDead = true
   StopCollection()
   StopESP()
   StopAllTweens()
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

ShowWelcomeAnimation()

wait(4)

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

local Tab = Tabs.Main:AddSection("Attack / Farm")

local playerCountLabel = Tab:AddParagraph({
   Title = "Player Count",
   Content = "Murderer: 0 | Sheriff: 0 | Innocent: 0"
})

local coinsLabel = Tab:AddParagraph({
   Title = "Coins Progress",
   Content = "Coins: 0/40"
})

local roleLabel = Tab:AddParagraph({
   Title = "Current Role",
   Content = "Role: Unknown"
})

Tab:AddToggle("BeachBallCollectorEnhanced", {
   Title = "Start Farm Beach Ball",
   Default = getgenv().Ready.BeachBallCollector or false,
   Callback = function(state)
       getgenv().Ready.BeachBallCollector = state
       
       if state then
           StartCollection()
           Notify("Farm Active", "Coin collection started!")
       else
           StopCollection()
           Notify("Farm Stopped", "Coin collection stopped!")
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
           Notify("ESP Active", "Player highlighting enabled!")
       else
           StopESP()
           Notify("ESP Stopped", "Player highlighting disabled!")
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
           Notify("Kill Monitor", "Auto kill activated for Murderer!")
       else
           StopKillMonitor()
           Notify("Kill Stopped", "Auto kill deactivated!")
       end
   end 
})

spawn(function()
   while true do
       wait(0.5)
       pcall(function()
           CountPlayers()
           local currentRole = GetPlayerRole()
           local actualCoins = GetPlayerCoins()
           
           if actualCoins > coinCount then
               coinCount = actualCoins
           end
           
           playerCountLabel:SetDesc(string.format("Murderer: %d | Sheriff: %d | Innocent: %d", 
               playerCounts.murderer, playerCounts.sheriff, playerCounts.innocent))
           
           coinsLabel:SetDesc(string.format("Coins: %d/40", coinCount))
           
           roleLabel:SetDesc(string.format("Role: %s", currentRole))
       end)
   end
end)
