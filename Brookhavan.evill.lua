--DATA
getgenv().Ready = false
getgenv().ESPEnabled = getgenv().ESPEnabled or false
getgenv().ESPObjects = getgenv().ESPObjects or {}
getgenv().savedPosition = nil
getgenv().TargetUserName = nil
getgenv().SendMessageLoop = state
getgenv().SendRandomLoop = state
--FUNICTON
local function Notify(Title,Dis)
    pcall(function()
        Fluent:Notify({Title = tostring(Title),Content = tostring(Dis),Duration = 5})
        local sound = Instance.new("Sound", game.Workspace) sound.SoundId = "rbxassetid://3398620867" sound.Volume = 3 sound.Ended:Connect(function() sound:Destroy() end) sound:Play()
    end)
end



local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera

local LocalPlayer = Players.LocalPlayer

local function createESP(player)
    if getgenv().ESPObjects[player] then
        return
    end
    
    local character = player.Character
    if not character then return end
    
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return end
    
    local outerBox = Drawing.new("Square")
    outerBox.Visible = false
    outerBox.Color = Color3.new(0, 0, 0)
    outerBox.Thickness = 4
    outerBox.Transparency = 1
    outerBox.Filled = false
    
    local innerBox = Drawing.new("Square")
    innerBox.Visible = false
    innerBox.Color = Color3.new(0, 1, 0)
    innerBox.Thickness = 2
    innerBox.Transparency = 1
    innerBox.Filled = false
    
    local nameText = Drawing.new("Text")
    nameText.Visible = false
    nameText.Color = Color3.new(0, 1, 0)
    nameText.Size = 18
    nameText.Center = true
    nameText.Outline = true
    nameText.OutlineColor = Color3.new(0, 0, 0) 
    nameText.Font = 2
    
    local distanceText = Drawing.new("Text")
    distanceText.Visible = false
    distanceText.Color = Color3.new(0, 1, 0) 
    distanceText.Size = 14
    distanceText.Center = true
    distanceText.Outline = true
    distanceText.OutlineColor = Color3.new(0, 0, 0) 
    distanceText.Font = 2
    
    getgenv().ESPObjects[player] = {
        outerBox = outerBox,
        innerBox = innerBox,
        nameText = nameText,
        distanceText = distanceText,
        connection = nil
    }
    
    local function updateESP()
        if not getgenv().ESPEnabled then
            outerBox.Visible = false
            innerBox.Visible = false
            nameText.Visible = false
            distanceText.Visible = false
            return
        end
        
        if character and character.Parent and humanoidRootPart and humanoidRootPart.Parent then
            local vector, onScreen = Camera:WorldToViewportPoint(humanoidRootPart.Position)
            
            if onScreen then
                local head = character:FindFirstChild("Head")
                local leg = character:FindFirstChild("Left Leg") or character:FindFirstChild("LeftFoot") or character:FindFirstChild("LeftLowerLeg")
                
                if head and leg then
                    local headVector = Camera:WorldToViewportPoint(head.Position + Vector3.new(0, 0.5, 0))
                    local legVector = Camera:WorldToViewportPoint(leg.Position - Vector3.new(0, 0.5, 0))
                    
                    local height = math.abs(headVector.Y - legVector.Y)
                    local width = height * 0.6
                    
                    outerBox.Size = Vector2.new(width + 4, height + 4)
                    outerBox.Position = Vector2.new(vector.X - (width + 4)/2, headVector.Y - 2)
                    outerBox.Visible = true
                    
                    innerBox.Size = Vector2.new(width, height)
                    innerBox.Position = Vector2.new(vector.X - width/2, headVector.Y)
                    innerBox.Visible = true
                    
                    local distance = math.floor((LocalPlayer.Character.HumanoidRootPart.Position - humanoidRootPart.Position).Magnitude)
                    
                    nameText.Text = "@" .. player.Name
                    nameText.Position = Vector2.new(vector.X, headVector.Y - 35)
                    nameText.Visible = true
                    
                    distanceText.Text = distance .. "m"
                    distanceText.Position = Vector2.new(vector.X, headVector.Y - 18)
                    distanceText.Visible = true
                else
                    outerBox.Visible = false
                    innerBox.Visible = false
                    nameText.Visible = false
                    distanceText.Visible = false
                end
            else
                outerBox.Visible = false
                innerBox.Visible = false
                nameText.Visible = false
                distanceText.Visible = false
            end
        else
            outerBox.Visible = false
            innerBox.Visible = false
            nameText.Visible = false
            distanceText.Visible = false
        end
    end
    
    getgenv().ESPObjects[player].connection = RunService.Heartbeat:Connect(updateESP)
end

local function removeESP(player)
    if getgenv().ESPObjects[player] then
        getgenv().ESPObjects[player].outerBox:Remove()
        getgenv().ESPObjects[player].innerBox:Remove()
        getgenv().ESPObjects[player].nameText:Remove()
        getgenv().ESPObjects[player].distanceText:Remove()
        if getgenv().ESPObjects[player].connection then
            getgenv().ESPObjects[player].connection:Disconnect()
        end
        getgenv().ESPObjects[player] = nil
    end
end

local function enableESP()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            createESP(player)
        end
    end
end

local function disableESP()
    for player, _ in pairs(getgenv().ESPObjects) do
        removeESP(player)
    end
end

local function onPlayerAdded(player)
    local function onCharacterAdded()
        wait(1)
        if getgenv().ESPEnabled then
            createESP(player)
        end
    end
    
    if player.Character then
        onCharacterAdded()
    end
    player.CharacterAdded:Connect(onCharacterAdded)
    player.CharacterRemoving:Connect(function()
        removeESP(player)
    end)
end

for _, player in pairs(Players:GetPlayers()) do
    if player ~= LocalPlayer then
        onPlayerAdded(player)
    end
end

Players.PlayerAdded:Connect(onPlayerAdded)
Players.PlayerRemoving:Connect(function(player)
    removeESP(player)
end)



local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

local fireEffect, smokeEffect, rainbowEffect
local rainbowConnection

local function createFireEffect()
   if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then return end
   local fire = Instance.new("Fire")
   fire.Size = 5
   fire.Heat = 10
   fire.Parent = player.Character.HumanoidRootPart
   return fire
end

local function createSmokeEffect() 
   if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then return end
   local smoke = Instance.new("Smoke")
   smoke.Size = 3
   smoke.Opacity = 0.5
   smoke.Parent = player.Character.HumanoidRootPart
   return smoke
end

local function createRainbowEffect()
   if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then return end
   local part = Instance.new("Part")
   part.Name = "RainbowEffect"
   part.Size = Vector3.new(4, 4, 4)
   part.Shape = Enum.PartType.Ball
   part.Material = Enum.Material.Neon
   part.CanCollide = false
   part.Anchored = true
   part.Parent = workspace
   return part
end



local function setupDeathHandler()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    
    local humanoid = character:WaitForChild("Humanoid")
    humanoid.Died:Connect(function()
    end)
    
    player.CharacterAdded:Connect(function(newCharacter)
        wait(0.5) 
        if getgenv().savedPosition then
            local hrp = newCharacter:WaitForChild("HumanoidRootPart")
            hrp.CFrame = CFrame.new(getgenv().savedPosition)
        end
        
        local newHumanoid = newCharacter:WaitForChild("Humanoid")
        newHumanoid.Died:Connect(function()
        end)
    end)
end



local function Chat(text)
isLegacyChat = game:GetService("TextChatService").ChatVersion == Enum.ChatVersion.LegacyChatService
    if not isLegacyChat then
        game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync(tostring(text))
    else
        game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(tostring(text), "All")
    end
end



local function GetPlayer(UserDisplay)
	if UserDisplay ~= "" then
        local Value = UserDisplay:match("^%s*(.-)%s*$")
        for _, player in ipairs(game.Players:GetPlayers()) do
            if player ~= game.Players.LocalPlayer then
                local PlayerName = player.Name:lower():match("^%s*(.-)%s*$")
                local DisplayName = player.DisplayName:lower():match("^%s*(.-)%s*$") 
                if PlayerName:sub(1, #Value) == Value:lower() or DisplayName:sub(1, #Value) == Value:lower() then
                    return player
                end
            end
        end
    end
    return nil
end




local function createFireEffect()
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local fire = Instance.new("Fire")
        fire.Size = 10
        fire.Heat = 15
        fire.Color = Color3.fromRGB(255, 140, 0)
        fire.SecondaryColor = Color3.fromRGB(255, 69, 0)
        fire.Parent = player.Character.HumanoidRootPart
        return fire
    end
end



local function createSmokeEffect()
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local smoke = Instance.new("Smoke")
        smoke.Size = 8
        smoke.Opacity = 0.5
        smoke.RiseVelocity = 5
        smoke.Color = Color3.fromRGB(100, 100, 100)
        smoke.Parent = player.Character.HumanoidRootPart
        return smoke
    end
end



local function createRainbowEffect()
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local part = Instance.new("Part")
        part.Name = "RainbowEffect"
        part.Size = Vector3.new(8, 8, 0.1)
        part.Anchored = true
        part.CanCollide = false
        part.Material = Enum.Material.Neon
        part.Shape = Enum.PartType.Block
        part.Parent = workspace
        return part
    end
end



local function GetDevice()
    local IsOnMobile = table.find({Enum.Platform.IOS, Enum.Platform.Android}, game:GetService("UserInputService"):GetPlatform())
    if IsOnMobile then
        return "Mobile"
    end
    return "PC"
end



--Gui & Functionality
local IsOnMobile = table.find({Enum.Platform.IOS, Enum.Platform.Android}, game:GetService("UserInputService"):GetPlatform())
function RandomTheme() local themes = {"Amethyst", "Light", "Aqua", "Rose", "Darker", "Dark"} return themes[math.random(1, #themes)] end
local Guitheme = RandomTheme()
if IsOnMobile then High = 360
local teez
teez = game:GetService("CoreGui").ChildAdded:Connect(function(P)
	if P.Name == "ScreenGui" then
		local ScreenGui = Instance.new("ScreenGui")
		local Button = Instance.new("TextButton")
		local UICorner = Instance.new("UICorner")
		ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
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
		local themeColors = {Light = Color3.fromRGB(255, 255, 255), Amethyst = Color3.fromRGB(153, 102, 204), Aqua = Color3.fromRGB(0, 255, 255), Rose = Color3.fromRGB(255, 182, 193), Darker = Color3.fromRGB(40, 40, 40), Dark = Color3.fromRGB(30, 30, 30)}
		Button.BackgroundColor3 = themeColors[Guitheme] or Color3.fromRGB(255, 255, 255)
		UICorner.Parent = Button
		UICorner.CornerRadius = UDim.new(0, 12)
		Button.MouseButton1Click:Connect(function()
			for _, F in ipairs(P:GetChildren()) do
				if F.Name ~= "Hider" and not F:FindFirstChild("UIListLayout") and not F:FindFirstChild("UISizeConstraint") then
					if F.Visible then 
					Button.Text = "View" F.Visible = false 
					else 
					Button.Text = "Hide" F.Visible = true 
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
else
    High = 460
end
for _,O in ipairs(game:GetService("CoreGui"):GetChildren()) do 
    if O.Name == "ScreenGui" and O:FindFirstChild("UIListLayout",true) and O:FindFirstChild("UISizeConstraint",true) then
        O:Destroy()
    end
end

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local Window = Fluent:CreateWindow({
    Title =  game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name,
    SubTitle = "By Front -evill / 7sone",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, High),
    Acrylic = false,
    Theme = Guitheme,
    MinimizeKey = Enum.KeyCode.B
})
 
local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "home" }),
	Targetting = Window:AddTab({ Title = "Targetting", Icon = "target" }),
    Player = Window:AddTab({ Title = "Player", Icon = "user" }),
	Setting = Window:AddTab({ Title = "Setting", Icon = "settings" }),
    Scin = Window:AddTab({ Title = "Scin Player", Icon = "user" }),
    Humando = Window:AddTab({ Title = "Admin", Icon = "hammer" }),
}

local FlyScriptMain = Tabs.Main:AddSection("Fly Script (Gui 3)")
local EspPlyaerMain = Tabs.Main:AddSection("Esp")
local ShildePlayerMain = Tabs.Main:AddSection("Shilde")


FlyScriptMain:AddButton({
    Title = "Fly Script",
    Description = "Clic here for give script fly (Gui3) !!!",
    Callback = function()
        if getgenv().Ready then
         loadstring(game:HttpGet("https://raw.githubusercontent.com/Front-Evill/Script-Hub/refs/heads/main/Fly.lua.txt"))()
                Notify("Done" , "The script is working" , 5)
            else
                Notify("Oops" , "The script is not working" , 6)
        end
    end
})
 
local PlayerEspMainToggle = EspPlyaerMain:AddToggle("ESPToggle", {
    Title = "Player ESP", 
    Description = nil,
    Default = false,
    Callback = function(state)
        getgenv().ESPEnabled = state
        if state then
            enableESP()
        else
            disableESP()
        end
    end 
})


local AntiFlingToggle = ShildePlayerMain:AddToggle("AntiFlingToggle", {
   Title = "Anti Fling Protection", 
   Description = "Protect yourself from fling attacks",
   Default = false,
   Callback = function(state)
       if state then
           getgenv().AntiFlingEnabled = true
           
           getgenv().AntiFlingConnection = game:GetService("RunService").Heartbeat:Connect(function()
               local player = game.Players.LocalPlayer
               if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                   local humanoidRootPart = player.Character.HumanoidRootPart
                   
                   if humanoidRootPart.Velocity.Magnitude > 50 then
                       humanoidRootPart.Velocity = Vector3.new(0, 0, 0)
                       humanoidRootPart.AngularVelocity = Vector3.new(0, 0, 0)
                   end
                   
                   for _, part in pairs(player.Character:GetChildren()) do
                       if part:IsA("BasePart") and part ~= humanoidRootPart then
                           if part.Velocity.Magnitude > 50 then
                               part.Velocity = Vector3.new(0, 0, 0)
                               part.AngularVelocity = Vector3.new(0, 0, 0)
                           end
                       end
                   end
                   
                   humanoidRootPart.CFrame = humanoidRootPart.CFrame
               end
           end)
           
       else
           getgenv().AntiFlingEnabled = false
           
           if getgenv().AntiFlingConnection then
               getgenv().AntiFlingConnection:Disconnect()
               getgenv().AntiFlingConnection = nil
           end
       end
   end 
})

local AntiSitToggle = ShildePlayerMain:AddToggle("AntiSitToggle", {
   Title = "Anti Sit Protection", 
   Description = "Prevent sitting on any seat",
   Default = false,
   Callback = function(state)
       if state then
           getgenv().AntiSitEnabled = true
           
           getgenv().AntiSitConnection = game:GetService("RunService").Heartbeat:Connect(function()
               local player = game.Players.LocalPlayer
               if player.Character and player.Character:FindFirstChild("Humanoid") then
                   local humanoid = player.Character.Humanoid
                   
                   if humanoid.Sit then
                       humanoid.Sit = false
                       humanoid.Jump = true
                   end
                   
                   if humanoid.SeatPart then
                       humanoid.Sit = false
                       humanoid.Jump = true
                   end
               end
           end)
           
           local player = game.Players.LocalPlayer
           getgenv().SeatTouchedConnection = player.CharacterAdded:Connect(function(character)
               wait(1)
               if getgenv().AntiSitEnabled and character:FindFirstChild("HumanoidRootPart") then
                   local humanoidRootPart = character.HumanoidRootPart
                   
                   humanoidRootPart.Touched:Connect(function(hit)
                       if getgenv().AntiSitEnabled and (hit:IsA("Seat") or hit:IsA("VehicleSeat")) then
                           character.Humanoid.Sit = false
                           character.Humanoid.Jump = true
                       end
                   end)
               end
           end)
           
       else
           getgenv().AntiSitEnabled = false
           
           if getgenv().AntiSitConnection then
               getgenv().AntiSitConnection:Disconnect()
               getgenv().AntiSitConnection = nil
           end
           
           if getgenv().SeatTouchedConnection then
               getgenv().SeatTouchedConnection:Disconnect()
               getgenv().SeatTouchedConnection = nil
           end
       end
   end 
})



local PlayerNameTargetting = Tabs.Targetting:AddSection("Target")
local OptionsTargetting = Tabs.Targetting:AddSection("Options")
local ChatTargetting = Tabs.Targetting:AddSection("Chat Player")

local TargetInput = PlayerNameTargetting:AddInput("Input", {
    Title = "Player Name",
    Description = nil,
    Default = nil,
    Placeholder = "Name Here",
    Numeric = false,
    Finished = true,
    Callback = function(Value)
		if getgenv().Ready then 
			local TargetName = GetPlayer(Value)
			if TargetName then
				Notify("Successed","The Player @"..TargetName.Name.." has been chosen!")
				getgenv().TargetUserName = TargetName.Name
			else
				Notify("Error","Unknown Player")
				getgenv().TargetUserName = nil
			end
		end
    end
})

game.Players.PlayerRemoving:Connect(function(Player)
	pcall(function()
		if Player.Name == getgenv().TargetUserName then
			getgenv().TargetUserName = nil
            Options.FlingTargetToggle:SetValue(false)
			Notify("Error","Target left or rejoined")
		end
	end)
end)

PlayerNameTargetting:AddButton({
    Title = "Choose Player Tool",
    Description = "Click on a player to select him",
    Callback = function()
		for _,P in ipairs(game.Players.LocalPlayer.Backpack:GetChildren()) do if P.Name == "ClickTarget" then P:Destroy() end end
		for _,P in ipairs(game.Players.LocalPlayer.Character:GetChildren()) do if P.Name == "ClickTarget" then P:Destroy() end end
		local GetTargetTool = Instance.new("Tool")
		GetTargetTool.Name = "ClickTarget"
		GetTargetTool.RequiresHandle = false
		GetTargetTool.TextureId = "rbxassetid://13769558274"
		GetTargetTool.ToolTip = "Choose Player"

		local function ActivateTool()
			local Hit = game.Players.LocalPlayer:GetMouse().Target
			local Person = nil
			if Hit and Hit.Parent then
				if Hit.Parent:IsA("Model") then
					Person = game.Players:GetPlayerFromCharacter(Hit.Parent)
				elseif Hit.Parent:IsA("Accessory") then
					Person = game.Players:GetPlayerFromCharacter(Hit.Parent.Parent)
				end
				if Person then
					TargetInput:SetValue(Person.Name)
				end
			end
		end

		GetTargetTool.Activated:Connect(function()
			ActivateTool()
		end)
		GetTargetTool.Parent = game.Players.LocalPlayer.Backpack
    end
})

OptionsTargetting:AddButton({
    Title = "Get Information",
    Description = nil,
    Callback = function()
        if getgenv().Ready and getgenv().TargetUserName and game.Players:FindFirstChild(getgenv().TargetUserName) then
            local Target = game.Players:FindFirstChild(getgenv().TargetUserName)
            
            local PlayerName = Target.Name
            local PlayerDisplayName = Target.DisplayName
            local PlayerUserID = Target.UserId
            local AccountAge = Target.AccountAge
            
            Notify("@" .. PlayerName .. " Info ↓", 
                "Display Name: " .. PlayerDisplayName .. 
                "\nUsername: " .. PlayerName .. 
                "\nUser ID: " .. tostring(PlayerUserID) .. 
                "\nAccount Age: " .. tostring(AccountAge) .. " days"
            )
        elseif getgenv().Ready then
            Notify("Error", "Please choose a player to target")
        end
    end
})

OptionsTargetting:AddButton({
    Title = "Teleport To",
    Description = nil,
    Callback = function()
		if getgenv().Ready and getgenv().TargetUserName and game.Players:FindFirstChild(getgenv().TargetUserName) then
			local Target = game.Players:FindFirstChild(getgenv().TargetUserName)
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Target.Character.HumanoidRootPart.CFrame * CFrame.new(0,0,-2) * CFrame.Angles(0,math.rad(180),0)
		elseif getgenv().Ready then
			Notify("Error","Please choose a player to target")
		end
    end
})


OptionsTargetting:AddButton({
   Title = "kill",
   Description = nil,
   Callback = function()
       if getgenv().Ready and getgenv().TargetUserName then
           local Players = game:GetService("Players")
           local LocalPlayer = Players.LocalPlayer
           local TargetPlayer = Players:FindFirstChild(getgenv().TargetUserName)
           
           if TargetPlayer and TargetPlayer.Character and TargetPlayer.Character:FindFirstChild("HumanoidRootPart") then
               local SchoolBus = Instance.new("Part")
               SchoolBus.Name = "SchoolBus"
               SchoolBus.Size = Vector3.new(10, 5, 20)
               SchoolBus.Material = Enum.Material.SmoothPlastic
               SchoolBus.BrickColor = BrickColor.new("Bright yellow")
               SchoolBus.Shape = Enum.PartType.Block
               SchoolBus.TopSurface = Enum.SurfaceType.Smooth
               SchoolBus.BottomSurface = Enum.SurfaceType.Smooth
               SchoolBus.Anchored = true
               SchoolBus.CanCollide = true
               SchoolBus.Parent = workspace
               
               local TargetPosition = TargetPlayer.Character.HumanoidRootPart.CFrame
               SchoolBus.CFrame = TargetPosition + Vector3.new(15, 0, 0)
               
               wait(0.5)
               TargetPlayer.Character.HumanoidRootPart.CFrame = SchoolBus.CFrame + Vector3.new(0, 3, 0)
               
               local WeldConstraint = Instance.new("WeldConstraint")
               WeldConstraint.Part0 = SchoolBus
               WeldConstraint.Part1 = TargetPlayer.Character.HumanoidRootPart
               WeldConstraint.Parent = SchoolBus
               
               wait(1)
               local DeathPosition = Vector3.new(math.random(-50000, 50000), -50000, math.random(-50000, 50000))
               SchoolBus.CFrame = CFrame.new(DeathPosition)
               
               wait(2)
               if WeldConstraint then
                   WeldConstraint:Destroy()
               end
               
               wait(0.5)
               if TargetPlayer.Character and TargetPlayer.Character:FindFirstChild("HumanoidRootPart") then
                   TargetPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(DeathPosition + Vector3.new(0, -100, 0))
                   
                   spawn(function()
                       wait(0.1)
                       if TargetPlayer.Character and TargetPlayer.Character:FindFirstChild("Humanoid") then
                           TargetPlayer.Character.Humanoid.Health = 0
                       end
                   end)
               end
               Notify("Success", "Player " .. getgenv().TargetUserName .. " has been eliminated!")
           else
               Notify("Error", "Target player not found or invalid")
           end
       else
           Notify("Error", "Please select a target player first")
       end
   end
})


OptionsTargetting:AddToggle("ViewTargetToggle", {
    Title = "View", 
    Description = nil,
    Default = false,
    Callback = function(Value)
		getgenv().View = Value
        while getgenv().View and task.wait() do
            if getgenv().TargetUserName and game.Players:FindFirstChild(getgenv().TargetUserName) then
				pcall(function()
					local Target = game.Players:FindFirstChild(getgenv().TargetUserName)
					workspace.CurrentCamera.CameraSubject = Target.Character.Head 
				end)
            elseif getgenv().Ready then
				workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character.Humanoid
                Notify("Error","Please choose a player to target")
                break
            end
        end
		workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character.Humanoid
    end 
})


local ToggleLoopGoToPlayer = OptionsTargetting:AddToggle("TrackingToggle", {
   Title = "Loop GoTo Player ", 
   Description = nil,
   Default = false,
   Callback = function(state)
       if state then
           getgenv().TrackingConnection = game:GetService("RunService").Heartbeat:Connect(function()
               if getgenv().TargetUserName then
                   local targetPlayer = game.Players:FindFirstChild(getgenv().TargetUserName)
                   
                   if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
                       local localPlayer = game.Players.LocalPlayer
                       
                       if localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
                           local targetPosition = targetPlayer.Character.HumanoidRootPart.Position
                           local currentPosition = localPlayer.Character.HumanoidRootPart.Position
                           local distance = (targetPosition - currentPosition).Magnitude
                           
                           if distance > 50 then
                               localPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(targetPosition + Vector3.new(5, 0, 0))
                           else
                               local direction = (targetPosition - currentPosition).Unit
                               local newPosition = currentPosition + direction * math.min(distance * 0.1, 2)
                               localPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(newPosition)
                           end
                       end
                   else
                       Notify("Error", "Target player not found")
                       Toggle:SetValue(false)
                   end
               else
                   Notify("Error", "No target selected")
                   Toggle:SetValue(false)
               end
           end)
       else
           if getgenv().TrackingConnection then
               getgenv().TrackingConnection:Disconnect()
               getgenv().TrackingConnection = nil
           end
       end
   end 
})

game.Players.PlayerRemoving:Connect(function(Player)
   pcall(function()
       if Player.Name == getgenv().TargetUserName then
           getgenv().TargetUserName = nil
           if Options.FlingTargetToggle then
               Options.FlingTargetToggle:SetValue(false)
           end
           Toggle:SetValue(false)
           Notify("Error", "Target left - Tracking stopped")
       end
   end)
end)

OptionsTargetting:AddToggle("FlingTargetToggle", {
    Title = "Fling", 
    Description = nil,
    Default = false,
    Callback = function(Value)
        getgenv().FlingTarget = Value
        if getgenv().FlingTarget then
            if not getgenv().TargetUserName then  
                Notify("Error","Please choose a player to target") 
                return 
            end
            
            if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character.Humanoid and game.Players.LocalPlayer.Character.Humanoid.RootPart then
                if game.Players.LocalPlayer.Character.Humanoid.RootPart.Velocity.Magnitude < 50 then
                    getgenv().OldPos = game.Players.LocalPlayer.Character.Humanoid.RootPart.CFrame
                end
                
                if game.Players[getgenv().TargetUserName].Character:FindFirstChild("Head") then
                    workspace.CurrentCamera.CameraSubject = game.Players[getgenv().TargetUserName].Character.Head
                elseif game.Players[getgenv().TargetUserName].Character:FindFirstChildOfClass("Accessory") and game.Players[getgenv().TargetUserName].Character:FindFirstChildOfClass("Accessory"):FindFirstChild("Handle") then
                    workspace.CurrentCamera.CameraSubject = game.Players[getgenv().TargetUserName].Character:FindFirstChildOfClass("Accessory"):FindFirstChild("Handle")
                else
                    workspace.CurrentCamera.CameraSubject = game.Players[getgenv().TargetUserName].Character.Humanoid
                end

                if not game.Players[getgenv().TargetUserName].Character:FindFirstChildWhichIsA("BasePart") then
                    return
                end

                local function FPos(BasePart, Pos, Ang)
                    game.Players.LocalPlayer.Character.Humanoid.RootPart.CFrame = CFrame.new(BasePart.Position) * Pos * Ang
                    game.Players.LocalPlayer.Character:SetPrimaryPartCFrame(CFrame.new(BasePart.Position) * Pos * Ang)
                    game.Players.LocalPlayer.Character.Humanoid.RootPart.Velocity = Vector3.new(9e9 * 2, 9e9 * 30, 9e9 * 2)
                    game.Players.LocalPlayer.Character.Humanoid.RootPart.RotVelocity = Vector3.new(9e9 * 2, 9e9 * 2, 9e9 * 2)
                end

                local function SFBasePart()
                    local Angle = 0
                    getgenv().FPDH = workspace.FallenPartsDestroyHeight
                    workspace.FallenPartsDestroyHeight = -math.huge
                    
                    repeat
                        task.wait()
                        pcall(function()
                            if game.Players.LocalPlayer.Character.Humanoid.RootPart and game.Players[getgenv().TargetUserName].Character.Humanoid then
                                if game.Players[getgenv().TargetUserName].Character.Humanoid.RootPart.Velocity.Magnitude < 80 then
                                    Angle = Angle + 170
                                    for _, Offset in ipairs({
                                        Vector3.new(0, 2.5, 0), Vector3.new(0, -2.5, 0),
                                        Vector3.new(3.5, 2.5, -3.5), Vector3.new(-3.5, -2.5, 3.5),
                                        Vector3.new(0, 2.5, 0), Vector3.new(0, -2.5, 0),
                                        Vector3.new(4, 3, -4), Vector3.new(-4, -3, 4),
                                        Vector3.new(5, 0, 0), Vector3.new(-5, 0, 0)
                                    }) do
                                        FPos(game.Players[getgenv().TargetUserName].Character.Humanoid.RootPart, 
                                             CFrame.new(Offset) + game.Players[getgenv().TargetUserName].Character.Humanoid.MoveDirection * (game.Players[getgenv().TargetUserName].Character.Humanoid.WalkSpeed * 4), 
                                             CFrame.Angles(math.rad(Angle), math.rad(Angle/2), math.rad(Angle/3)))
                                        task.wait()
                                    end
                                else
                                    for _, Data in ipairs({
                                        {Vector3.new(0, 10, 1000), math.rad(180)},
                                        {Vector3.new(0, -10, -1000), math.rad(-180)},
                                        {Vector3.new(0, 10, 1000), math.rad(180)},
                                        {Vector3.new(0, 10, 1000), math.rad(180)},
                                        {Vector3.new(0, -10, -1000), math.rad(-180)},
                                        {Vector3.new(0, 10, 1000), math.rad(180)},
                                        {Vector3.new(10, -10, 0), math.rad(270)},
                                        {Vector3.new(-10, -10, 0), math.rad(-270)},
                                        {Vector3.new(0, -15, 0), math.rad(360)},
                                        {Vector3.new(0, 15, 0), math.rad(-360)}
                                    }) do
                                        FPos(game.Players[getgenv().TargetUserName].Character.Humanoid.RootPart, CFrame.new(Data[1]), CFrame.Angles(Data[2], math.rad(Angle * 2), 0))
                                        task.wait()
                                    end                        
                                end
                                game.Players.LocalPlayer.Character.Humanoid.Sit = false
                                if game.Players[getgenv().TargetUserName].Character:FindFirstChild("Head") then
                                    workspace.CurrentCamera.CameraSubject = game.Players[getgenv().TargetUserName].Character.Head
                                end
                            end
                        end)
                    until not getgenv().FlingTarget 
                end

                local BV1 = Instance.new("BodyVelocity")
                BV1.Name = "Flinger1"
                BV1.Parent = game.Players.LocalPlayer.Character.Humanoid.RootPart
                BV1.Velocity = Vector3.new(9e9 * 7, 9e9 * 7, 9e9 * 7)
                BV1.MaxForce = Vector3.new(math.huge, math.huge, math.huge)

                local BV2 = Instance.new("BodyAngularVelocity")
                BV2.Name = "Spinner"
                BV2.Parent = game.Players.LocalPlayer.Character.Humanoid.RootPart
                BV2.AngularVelocity = Vector3.new(9e9 * 8, 9e8 * 8, 9e9 * 8)
                BV2.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)

                game.Players.LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
                game.Players.LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics, false)

                SFBasePart()

                if BV1 then BV1:Destroy() end
                if BV2 then BV2:Destroy() end

                game.Players.LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
                game.Players.LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics, true)
                workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character.Humanoid

                repeat
                    game.Players.LocalPlayer.Character.Humanoid.RootPart.CFrame = getgenv().OldPos * CFrame.new(0, .5, 0)
                    game.Players.LocalPlayer.Character:SetPrimaryPartCFrame(getgenv().OldPos * CFrame.new(0, .5, 0))
                    game.Players.LocalPlayer.Character.Humanoid:ChangeState("GettingUp")
                    table.foreach(game.Players.LocalPlayer.Character:GetChildren(), function(_, x)
                        if x:IsA("BasePart") then
                            x.Velocity, x.RotVelocity = Vector3.new(), Vector3.new()
                        end
                    end)
                    task.wait()
                until (game.Players.LocalPlayer.Character.Humanoid.RootPart.Position - getgenv().OldPos.p).Magnitude < 25

                workspace.FallenPartsDestroyHeight = getgenv().FPDH
                if game.Players.LocalPlayer.Character.Humanoid.Sit then
                    wait(1)
                    game.Players.LocalPlayer.Character.Humanoid.Sit = false
                end
            end
        end
    end 
})


ChatTargetting:AddInput("Input", {
    Title = "Text Chat",
    Description = nil,
    Default = nil,
    Placeholder = "Enter here text",
    Numeric = false,
    Finished = true,
    Callback = function(Value)
        if getgenv().Ready then
            getgenv().ChatMessage = Value
        end
    end
})

ChatTargetting:AddToggle("seendToggle", {
    Title = "seend",
    Description = nil,
    Default = false,
    Callback = function(state)
        if getgenv().Ready then
            getgenv().SendMessageLoop = state
            
            if state then
                spawn(function()
                    while getgenv().SendMessageLoop and getgenv().Ready do
                        if getgenv().ChatMessage and getgenv().ChatMessage ~= "" then
                            Chat(getgenv().ChatMessage)
                        end
                        task.wait()
                    end
                end)
            end
        end
    end
})

ChatTargetting:AddToggle("randomToggle", {
    Title = "random",
    Description = nil,
    Default = false,
    Callback = function(state)
        if getgenv().Ready then
            getgenv().SendRandomLoop = state
            
            if state then
                spawn(function()
                    while getgenv().SendRandomLoop and getgenv().Ready do
                        local randomMessages = {
                            "FRONT-EVILL ON TOP",
                            "NOOBS BEWARE",
                            "FRONT-EVILL RULES",
                            "JTALKM ON TOP"
                        }
                        local randomIndex = math.random(1, #randomMessages)
                        Chat(randomMessages[randomIndex])
                        task.wait()
                    end
                end)
            end
        end
    end
})


ChatTargetting:AddToggle("spamToggle", {
    Title = "Spam Okay",
    Description = nil,
    Default = false,
    Callback = function(state)
        if getgenv().Ready then
            getgenv().SendRandomLoop = state
            
            if state then
                spawn(function()
                    while getgenv().SendRandomLoop and getgenv().Ready do
                        local randomMessages = {
                            [[
           .                 
   .                         
  .                          
 .          .                 
..
..
..
  ...                         .
     .
     ..
     .                       .]]
                        }
                        local randomIndex = math.random(1, #randomMessages)
                        Chat(randomMessages[randomIndex])
                        task.wait()
                    end
                end)
            end
        end
    end
})


local PlkFarmPlayer = Tabs.Player:AddSection("InfiniteJump")
local NoClipPlayer = Tabs.Player:AddSection("NoClip")
local CatPlayerTabPlayer = Tabs.Player:AddSection("car")
local SpeedJumpPlayer = Tabs.Player:AddSection("Speed & jump ")


PlkFarmPlayer:AddToggle("InfiniteJump", {
    Title = "Infinite Jump",
    Description = nil,
    Default = false,
    Callback = function(state)
        infiniteJumpEnabled = state
        if state then
            Notify("Ez" , "The script has been turned on" , 5)
         else
            Notify("Oops" , "The script has been turned off" , 10)
        end
    end
})

--------- o ----------
game:GetService("UserInputService").JumpRequest:Connect(function()
    if infiniteJumpEnabled then
        local player = game.Players.LocalPlayer 
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)
--------- o ----------

NoClipPlayer:AddToggle("Noclip", {
    Title = "Noclip",
    Description = "Walk through walls and obstacles",
    Default = false,
    Callback = function(state)
        _G.Noclip = state
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        
        local noclipConnection
        if state then
            noclipConnection = game:GetService("RunService").Stepped:Connect(function()
                if not _G.Noclip then 
                    if noclipConnection then
                        noclipConnection:Disconnect()
                    end
                    return
                end
                
                if character and character:FindFirstChild("Humanoid") then
                    for _, part in pairs(character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                end
            end)
        else
            if noclipConnection then
                noclipConnection:Disconnect()
            end
            
            if character then
                for _, part in pairs(character:GetDescendants()) do
                    if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                        part.CanCollide = true
                    end
                end
            end
        end
        player.CharacterAdded:Connect(function(newCharacter)
            character = newCharacter
            wait(1)
            if _G.Noclip then
                noclipConnection = game:GetService("RunService").Stepped:Connect(function()
                    if not _G.Noclip then 
                        if noclipConnection then
                            noclipConnection:Disconnect()
                        end
                        return
                    end
                    
                    if character and character:FindFirstChild("Humanoid") then
                        for _, part in pairs(character:GetDescendants()) do
                            if part:IsA("BasePart") then
                                part.CanCollide = false
                            end
                        end
                    end
                end)
            end
        end)
    end
})


CatPlayerTabPlayer:AddSlider("CarSpeedSlider", {
   Title = "Car Speed",
   Description = nil,
   Default = 50,
   Min = 0,
   Max = 500,
   Rounding = 1,
   Callback = function(Value)
       getgenv().CarSpeed = Value
       print("Car speed set to:", Value)
   end
})

CatPlayerTabPlayer:AddToggle("CarSpeedToggle", {
   Title = "Enable Car Speed", 
   Description = nil,
   Default = false,
   Callback = function(state)
       getgenv().CarSpeedEnabled = state
       if state then
           print("Car Speed Enabled")
           getgenv().CarSpeedConnection = game:GetService("RunService").Heartbeat:Connect(function()
               pcall(function()
                   local Player = game.Players.LocalPlayer
                   if Player.Character and Player.Character:FindFirstChild("Humanoid") then
                       local seat = Player.Character.Humanoid.SeatPart
                       
                       if seat and seat:IsA("VehicleSeat") then
                           local vehicle = seat.Parent
                           
                           seat.MaxSpeed = getgenv().CarSpeed or 50
                           seat.Torque = (getgenv().CarSpeed or 50) * 100
                           seat.TurnSpeed = math.min((getgenv().CarSpeed or 50) / 10, 20)
                           
                           for _, part in pairs(vehicle:GetDescendants()) do
                               if part:IsA("VehicleSeat") and part ~= seat then
                                   part.MaxSpeed = getgenv().CarSpeed or 50
                                   part.Torque = (getgenv().CarSpeed or 50) * 100
                                   part.TurnSpeed = math.min((getgenv().CarSpeed or 50) / 10, 20)
                               end
                           end
                       elseif seat and seat:IsA("Seat") then
                           local vehicle = seat.Parent
                           local bodyVelocity = vehicle:FindFirstChildOfClass("BodyVelocity")
                           
                           if not bodyVelocity then
                               bodyVelocity = Instance.new("BodyVelocity")
                               bodyVelocity.MaxForce = Vector3.new(math.huge, 0, math.huge)
                               bodyVelocity.Parent = vehicle.PrimaryPart or vehicle:FindFirstChild("Main") or vehicle:FindFirstChild("Body") or seat
                           end
                           
                           if Player.Character.Humanoid.MoveDirection.Magnitude > 0 then
                               local direction = workspace.CurrentCamera.CFrame.LookVector
                               bodyVelocity.Velocity = direction * (getgenv().CarSpeed or 50)
                           else
                               bodyVelocity.Velocity = Vector3.new(0, 0, 0)
                           end
                       end
                   end
               end)
           end)
       else
           print("Car Speed Disabled")
           if getgenv().CarSpeedConnection then
               getgenv().CarSpeedConnection:Disconnect()
               getgenv().CarSpeedConnection = nil
           end
           
           pcall(function()
               local Player = game.Players.LocalPlayer
               if Player.Character and Player.Character:FindFirstChild("Humanoid") then
                   local seat = Player.Character.Humanoid.SeatPart
                   if seat and seat:IsA("VehicleSeat") then
                       seat.MaxSpeed = 25
                       seat.Torque = 2500
                       seat.TurnSpeed = 5
                   end
               end
               
               for _, vehicle in pairs(workspace:GetChildren()) do
                   for _, part in pairs(vehicle:GetDescendants()) do
                       if part:IsA("BodyVelocity") then
                           part:Destroy()
                       elseif part:IsA("VehicleSeat") then
                           part.MaxSpeed = 25
                           part.Torque = 2500
                           part.TurnSpeed = 5
                       end
                   end
               end
           end)
       end
   end 
})


SpeedJumpPlayer:AddToggle("HighJump", {
    Title = "HighJump",
    Description = "Enables higher jumping ability",
    Default = false,
    Callback = function(state)
       if getgenv().Ready then
          if state then
                game.Players.LocalPlayer.Character.Humanoid.JumpPower = 75
             else
                game.Players.LocalPlayer.Character.Humanoid.JumpPower = 50
           end
        end 
    end
})

SpeedJumpPlayer:AddToggle("SpeedBoost", {
    Title = "SpeedBoost",
    Description = "Increases movement speed",
    Default = false,
    Callback = function(state)
        if getgenv().Ready then
            if state then
               game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 35
              else
               game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
            end   
        end
    end
})




local FarmFpsQuSetting = Tabs.Setting:AddSection("FPS & Quailite")
local ServerNano = Tabs.Setting:AddSection("Server")
local MoodPlayerSetting = Tabs.Setting:AddSection("Mood")
local ForPlayerSetting = Tabs.Setting:AddSection("last")

-------- FPS ---------
FarmFpsQuSetting:AddButton({
    Title = "FPS Boost",
    Description = "Improves frame rate by reducing graphics",
    Callback = function()
        game.Lighting.GlobalShadows = false
        settings().Rendering.QualityLevel = 1
        local skybox = game.Lighting:FindFirstChildOfClass("Sky")
        if skybox then
            skybox.StarCount = 0
            skybox.CelestialBodiesShown = false
        end
        workspace.Terrain.WaterWaveSize = 0
        workspace.Terrain.WaterWaveSpeed = 0
        workspace.Terrain.WaterReflectance = 0
        workspace.Terrain.WaterTransparency = 1
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") and not obj:IsDescendantOf(game.Players.LocalPlayer.Character) then
                obj.CastShadow = false
            end
            
            if obj:IsA("Decal") or obj:IsA("Texture") then
                obj.Transparency = 1
            end
            
            if obj:IsA("ParticleEmitter") or obj:IsA("Trail") then
                obj.Enabled = false
            end
            
            if obj:IsA("Fire") or obj:IsA("Smoke") or obj:IsA("Sparkles") then
                obj.Enabled = false
            end
        end
    end
})

------------------------ QUALITY --------------------------
FarmFpsQuSetting:AddButton({
    Title = "Quality Boost",
    Description = "Enhances visual quality of the game",
    Callback = function()
        game.Lighting.GlobalShadows = true
        settings().Rendering.QualityLevel = 21
        local bloom = Instance.new("BloomEffect")
        bloom.Intensity = 0.25
        bloom.Size = 20
        bloom.Threshold = 1
        bloom.Name = "QualityBloom"
        bloom.Parent = game.Lighting
        
        local colorCorrection = Instance.new("ColorCorrectionEffect")
        colorCorrection.Brightness = 0.05
        colorCorrection.Contrast = 0.05
        colorCorrection.Saturation = 0.1
        colorCorrection.TintColor = Color3.fromRGB(255, 255, 255)
        colorCorrection.Name = "QualityColorCorrection"
        colorCorrection.Parent = game.Lighting

        game.Lighting.Ambient = Color3.fromRGB(25, 25, 25)
        game.Lighting.Brightness = 2
        game.Lighting.ClockTime = 14
        
        workspace.Terrain.WaterReflectance = 0.5
        workspace.Terrain.WaterTransparency = 0.65
        workspace.Terrain.WaterWaveSize = 0.15
        workspace.Terrain.WaterWaveSpeed = 10
    end
})

ServerNano:AddButton({
    Title = "Rejoin",
    Description = nil,
    Callback = function()
       if getgenv().Ready then
         local TeleportService = game:GetService("TeleportService")
         local Players = game:GetService("Players")
         local LocalPlayer = Players.LocalPlayer
         TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
        end
    end
})

ForPlayerSetting:AddButton({
    Title = "Save Check Point",
    Description = nil,
    Callback = function()
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        
        if character then
            local hrp = character:FindFirstChild("HumanoidRootPart")
            if hrp then
                getgenv().savedPosition = hrp.Position
            end
        end
    end
})


ForPlayerSetting:AddButton({
    Title = "come Back To Check Point",
    Description = nil,
    Callback = function()
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        
        if character and getgenv().savedPosition then
            local hrp = character:FindFirstChild("HumanoidRootPart")
            if hrp then
                hrp.CFrame = CFrame.new(getgenv().savedPosition)
            end
        end
    end
})

ForPlayerSetting:AddButton({
    Title = "reset",
    Description = nil,
    Callback = function()
        local player = game.Players.LocalPlayer
        local character = player.Character
        
        if character then
            local humanoid = character:FindFirstChild("Humanoid")
            if humanoid then
                humanoid.Health = 0
                -- player.Character:BreakJoints()
            end
        end
    end
})

MoodPlayerSetting:AddButton({
    Title = "Mood Moon",
    Description = nil,
    Callback = function()
        local lighting = game:GetService("Lighting")
        
        if not getgenv().OriginalLighting then
            getgenv().OriginalLighting = {
                ClockTime = lighting.ClockTime,
                Brightness = lighting.Brightness,
                Ambient = lighting.Ambient,
                OutdoorAmbient = lighting.OutdoorAmbient,
                FogEnd = lighting.FogEnd,
                FogStart = lighting.FogStart
            }
        end
        
        lighting.ClockTime = 0
        lighting.Brightness = 0.1
        lighting.Ambient = Color3.fromRGB(20, 20, 50)
        lighting.OutdoorAmbient = Color3.fromRGB(20, 20, 50)
        lighting.FogEnd = 400
        lighting.FogStart = 100
    end
})

MoodPlayerSetting:AddButton({
    Title = "Mood day",
    Description = nil,
    Callback = function()
        local lighting = game:GetService("Lighting")
        
        if not getgenv().OriginalLighting then
            getgenv().OriginalLighting = {
                ClockTime = lighting.ClockTime,
                Brightness = lighting.Brightness,
                Ambient = lighting.Ambient,
                OutdoorAmbient = lighting.OutdoorAmbient,
                FogEnd = lighting.FogEnd,
                FogStart = lighting.FogStart
            }
        end
        lighting.ClockTime = 7 
        lighting.Brightness = 1.5
        lighting.Ambient = Color3.fromRGB(255, 230, 190)
        lighting.OutdoorAmbient = Color3.fromRGB(210, 190, 160)
        lighting.FogEnd = 1000
        lighting.FogStart = 500
        
    end        
})

MoodPlayerSetting:AddButton({
    Title = "Delete Mood",
    Description = nil,
    Callback = function()
        local lighting = game:GetService("Lighting")
        if getgenv().OriginalLighting then
            lighting.ClockTime = getgenv().OriginalLighting.ClockTime
            lighting.Brightness = getgenv().OriginalLighting.Brightness
            lighting.Ambient = getgenv().OriginalLighting.Ambient
            lighting.OutdoorAmbient = getgenv().OriginalLighting.OutdoorAmbient
            lighting.FogEnd = getgenv().OriginalLighting.FogEnd
            lighting.FogStart = getgenv().OriginalLighting.FogStart
        else
            lighting.ClockTime = 14
            lighting.Brightness = 1
            lighting.Ambient = Color3.fromRGB(150, 150, 150)
            lighting.OutdoorAmbient = Color3.fromRGB(150, 150, 150)
            lighting.FogEnd = 500
            lighting.FogStart = 0
        end
    end
})


-----------------------------------------------------------------------------------------------------
local Animation = Tabs.Scin:AddSection("Animation 1")
local Animation2 = Tabs.Scin:AddSection("Animation 2")
local Animation3 = Tabs.Scin:AddSection("Boy Animation")
local GoodAnimation = Tabs.Scin:AddSection("Good Animation")
local AnimationGirl = Tabs.Scin:AddSection("Girl Animation")
local EfictScinPlayer = Tabs.Scin:AddSection("Efict")
local DanceScript = Tabs.Scin:AddSection("Dance Script")

local plr = game.Players.LocalPlayer
Animation:AddButton({
    Title = "HeroAnim",
    Description = nil,
    Callback = function()
    if game.Players.LocalPlayer.Character.Humanoid.RigType ~= Enum.HumanoidRigType.R15 then
        Notify("System Front","يجب ان تكون R15" , 9)
        return
    end
    local Animate = plr.Character.Animate
    Animate.Disabled = true
    Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=616111295"
    Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=616113536"
    Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=616122287"
    Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=616117076"
    Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=616115533"
    Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=616104706"
    Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=616108001"
    plr.Character.Humanoid:ChangeState(3)
    Animate.Disabled = false
    end
})

Animation:AddButton({
    Title = "ZombieClassicAnim_",
    Description = nil,
    Callback = function()
    if game.Players.LocalPlayer.Character.Humanoid.RigType ~= Enum.HumanoidRigType.R15 then
        Notify("System Front","يجب ان تكون R15" , 9)
        return
    end
    local Animate = plr.Character.Animate
	Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=616158929"
	Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=616160636"
	Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=616168032"
	Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=616163682"
	Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=616161997"
	Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=616156119"
	Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=616157476"
    plr.Character.Humanoid:ChangeState(3) 
    Animate.Disabled = false
    end
})

Animation:AddButton({
    Title = "LevitationAnim",
    Description = nil,
    Callback = function()
    if game.Players.LocalPlayer.Character.Humanoid.RigType ~= Enum.HumanoidRigType.R15 then
        Notify("System Front","يجب ان تكون R15" , 9)
        return
    end
    local Animate = plr.Character.Animate
	Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=616006778"
	Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=616008087"
	Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=616013216"
	Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=616010382"
	Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=616008936"
	Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=616003713"
	Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=616005863"
    plr.Character.Humanoid:ChangeState(3) 
    Animate.Disabled = false
    end
})

Animation:AddButton({
    Title = "AstronautAnim",
    Description = nil,
    Callback = function()
    if game.Players.LocalPlayer.Character.Humanoid.RigType ~= Enum.HumanoidRigType.R15 then
        Notify("System Front","يجب ان تكون R15" , 9)
        return
    end
    local Animate = plr.Character.Animate
	Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=891621366"
	Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=891633237"
	Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=891667138"
	Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=891636393"
	Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=891627522"
	Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=891609353"
	Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=891617961"
    plr.Character.Humanoid:ChangeState(3) 
    Animate.Disabled = false
    end
})


Animation2:AddButton({
    Title = "NinjaAnim",
    Description = nil,
    Callback = function()
    if game.Players.LocalPlayer.Character.Humanoid.RigType ~= Enum.HumanoidRigType.R15 then
        Notify("System Front","يجب ان تكون R15" , 9)
        return
    end
    local Animate = plr.Character.Animate
	Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=656117400"
	Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=656118341"
	Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=656121766"
	Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=656118852"
	Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=656117878"
	Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=656114359"
	Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=656115606"
    plr.Character.Humanoid:ChangeState(3) 
    Animate.Disabled = false
    end
})

Animation2:AddButton({
    Title = "PirateAnim",
    Description = nil,
    Callback = function()
    if game.Players.LocalPlayer.Character.Humanoid.RigType ~= Enum.HumanoidRigType.R15 then
        Notify("System Front","يجب ان تكون R15" , 9)
        return
    end
    local Animate = plr.Character.Animate
	Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=750781874"
	Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=750782770"
	Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=750785693"
	Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=750783738"
	Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=750782230"
	Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=750779899"
	Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=750780242"
    plr.Character.Humanoid:ChangeState(3) 
    Animate.Disabled = false
    end
})


Animation2:AddButton({
    Title = "ToyAnim",
    Description = nil,
    Callback = function()
    if game.Players.LocalPlayer.Character.Humanoid.RigType ~= Enum.HumanoidRigType.R15 then
        Notify("System Front","يجب ان تكون R15" , 9)
        return
    end
    local Animate = plr.Character.Animate
	Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=782841498"
	Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=782845736"
	Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=782843345"
	Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=782842708"
	Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=782847020"
	Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=782843869"
	Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=782846423"
    plr.Character.Humanoid:ChangeState(3) 
    Animate.Disabled = false
    end
})

Animation2:AddButton({
    Title = "CowboyAnim",
    Description = nil,
    Callback = function()
    if game.Players.LocalPlayer.Character.Humanoid.RigType ~= Enum.HumanoidRigType.R15 then
        Notify("System Front","يجب ان تكون R15" , 9)
        return
    end
    local Animate = plr.Character.Animate
    Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=1014390418"
    Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=1014398616"
    Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=1014421541"
    Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=1014401683"
    Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=1014394726"
    Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=1014380606"
    Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=1014384571"      
    plr.Character.Humanoid:ChangeState(3) 
    Animate.Disabled = false
    end
})

Animation3:AddButton({
    Title = "PrincessAnim",
    Description = nil,
    Callback = function()
    if game.Players.LocalPlayer.Character.Humanoid.RigType ~= Enum.HumanoidRigType.R15 then
        Notify("System Front","يجب ان تكون R15" , 9)
        return
    end
    local Animate = plr.Character.Animate
	Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=941003647"
	Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=941013098"
	Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=941028902"
	Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=941015281"
	Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=941008832"
	Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=940996062"
	Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=941000007"
    plr.Character.Humanoid:ChangeState(3) 
    Animate.Disabled = false
    end
})

Animation3:AddButton({
    Title = "KnightAnim",
    Description = nil,
    Callback = function()
    if game.Players.LocalPlayer.Character.Humanoid.RigType ~= Enum.HumanoidRigType.R15 then
        Notify("System Front","يجب ان تكون R15" , 9)
        return
    end
    local Animate = plr.Character.Animate
    Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=657595757"
    Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=657568135"
    Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=657552124"
    Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=657564596"
    Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=658409194"
    Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=658360781"
    Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=657600338"    
    plr.Character.Humanoid:ChangeState(3) 
    Animate.Disabled = false
    end
})

Animation3:AddButton({
    Title = "VampireAnim",
    Description = nil,
    Callback = function()
    if game.Players.LocalPlayer.Character.Humanoid.RigType ~= Enum.HumanoidRigType.R15 then
        Notify("System Front","يجب ان تكون R15" , 9)
        return
    end
    local Animate = plr.Character.Animate
	Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=1083445855"
	Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=1083450166"
	Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=1083473930"
	Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=1083462077"
	Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=1083455352"
	Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=1083439238"
	Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=1083443587"
    plr.Character.Humanoid:ChangeState(3) 
    Animate.Disabled = false
    end
})

Animation3:AddButton({
    Title = "PatrolAnim",
    Description = nil,
    Callback = function()
    if game.Players.LocalPlayer.Character.Humanoid.RigType ~= Enum.HumanoidRigType.R15 then
        Notify("System Front","يجب ان تكون R15" , 9)
        return
    end
    local Animate = plr.Character.Animate
	Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=1149612882"
	Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=1150842221"
	Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=1151231493"
	Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=1150967949"
	Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=1150944216"
	Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=1148811837"
	Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=1148863382"
    plr.Character.Humanoid:ChangeState(3) 
    Animate.Disabled = false
    end
})


Animation3:AddButton({
    Title = "ElderAnim",
    Description = nil,
    Callback = function()
    if game.Players.LocalPlayer.Character.Humanoid.RigType ~= Enum.HumanoidRigType.R15 then
        Notify("System Front","يجب ان تكون R15" , 9)
        return
    end
    local Animate = plr.Character.Animate
	Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=845397899"
	Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=845400520"
	Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=845403856"
	Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=845386501"
	Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=845398858"
	Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=845392038"
	Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=845396048"
    plr.Character  .Humanoid:ChangeState(3) 
    Animate.Disabled = false
    end
})
    
Animation3:AddButton({
    Title = "Patrol Animation Pack",
    Description = nil,
    Callback = function()
    if game.Players.LocalPlayer.Character.Humanoid.RigType ~= Enum.HumanoidRigType.R15 then
        Notify("System Front","يجب ان تكون R15" , 9)
        return
    end
    local Animate = plr.Character.Animate
       Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=1149612882"
       Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=1150842221"
       Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=1151231493"
       Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=1150967949"
       Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=1150944216"
       Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=1148811837"
       Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=1148863382"    
    plr.Character.Humanoid:ChangeState(3) 
    Animate.Disabled = false
    end
})

GoodAnimation:AddButton({
    Title = "MageAnim",
    Description = nil,
    Callback = function()
       if game.Players.LocalPlayer.Character.Humanoid.RigType ~= Enum.HumanoidRigType.R15 then
           Notify("System Front","يجب ان تكون R15" , 9)
           return
       end
       local Animate = plr.Character.Animate
       Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=707742142"
       Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=707855907"
       Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=707897309"
       Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=707861613"
       Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=707853694"
       Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=707826056"
       Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=707829716"
       plr.Character.Humanoid:ChangeState(3)
       Animate.Disabled = false
    end
})

GoodAnimation:AddButton({
    Title = "WerewolfAnim",
    Description = nil,
    Callback = function()
       if game.Players.LocalPlayer.Character.Humanoid.RigType ~= Enum.HumanoidRigType.R15 then
           Notify("System Front","يجب ان تكون R15" , 9)
           return
       end
       local Animate = plr.Character.Animate
       Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=1083195517"
       Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=1083214717"
       Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=1083178339"
       Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=1083216690"
       Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=1083218792"
       Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=1083182000"
       Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=1083189019"
       plr.Character.Humanoid:ChangeState(3)
       Animate.Disabled = false
    end
})

GoodAnimation:AddButton({
    Title = "Cartoony Animation",
    Description = nil,
    Callback = function()
       if game.Players.LocalPlayer.Character.Humanoid.RigType ~= Enum.HumanoidRigType.R15 then
           Notify("System Front","يجب ان تكون R15" , 9)
           return
       end
       local Animate = plr.Character.Animate
       Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=742637544"
       Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=742638445"
       Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=742640026"
       Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=742638842"
       Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=742637942"
       Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=742636889" 
       Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=742637151"
       plr.Character.Humanoid:ChangeState(3)
       Animate.Disabled = false
    end
})

GoodAnimation:AddButton({
    Title = "SneakyAnim",
    Description = nil,
    Callback = function()
       if game.Players.LocalPlayer.Character.Humanoid.RigType ~= Enum.HumanoidRigType.R15 then
           Notify("System Front","يجب ان تكون R15" , 9)
           return
       end
       local Animate = plr.Character.Animate
       Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=1132473842"
       Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=1132477671"
       Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=1132510133"
       Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=1132494274"
       Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=1132489853"
       Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=1132461372"
       Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=1132469004"       
       plr.Character.Humanoid:ChangeState(3)
       Animate.Disabled = false
    end
})

AnimationGirl:AddButton({
    Title = "Stylish Anim",
    Description = nil,
    Callback = function()
    if game.Players.LocalPlayer.Character.Humanoid.RigType ~= Enum.HumanoidRigType.R15 then
        Notify("System Front","يجب ان تكون R15" , 9)
        return
    end
    local Animate = plr.Character.Animate
	Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=616136790"
	Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=616138447"
	Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=616146177"
	Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=616140816"
	Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=616139451"
	Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=616133594"
	Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=616134815"
    plr.Character  .Humanoid:ChangeState(3) 
    Animate.Disabled = false
    end
})

AnimationGirl:AddButton({
    Title = "BubblyAnim",
    Description = nil,
    Callback = function()
    if game.Players.LocalPlayer.Character.Humanoid.RigType ~= Enum.HumanoidRigType.R15 then
        Notify("System Front","يجب ان تكون R15" , 9)
        return
    end
    local Animate = plr.Character.Animate
	Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=910004836"
	Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=891633237"
	Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=910034870"
	Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=910025107"
	Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=910016857"
	Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=909997997"
	Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=910001910"
    plr.Character  .Humanoid:ChangeState(3) 
    Animate.Disabled = false
    end
})

AnimationGirl:AddButton({
    Title = "SuperheroAnim",
    Description = nil,
    Callback = function()
       if game.Players.LocalPlayer.Character.Humanoid.RigType ~= Enum.HumanoidRigType.R15 then
           Notify("System Front","يجب ان تكون R15" , 9)
           return
       end
       local Animate = plr.Character.Animate
       Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=616111295"
       Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=616113536"
       Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=616122287"
       Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=616117076"
       Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=616115533"
       Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=616104706"
       Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=616108001"       
       plr.Character.Humanoid:ChangeState(3)
       Animate.Disabled = false
    end
})

AnimationGirl:AddButton({
    Title = "Stylized",
    Description = nil,
    Callback = function()
       if game.Players.LocalPlayer.Character.Humanoid.RigType ~= Enum.HumanoidRigType.R15 then
           Notify("System Front","يجب ان تكون R15" , 9)
           return
       end
       local Animate = plr.Character.Animate
       Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=4708191566"
       Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=4708192150"
       Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=4708193840"
       Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=4708192705"
       Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=4708188025"
       Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=4708184253"
       Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=4708186162"       
       plr.Character.Humanoid:ChangeState(3)
       Animate.Disabled = false
    end
})

AnimationGirl:AddButton({
    Title = "Popstar Animation Pack",
    Description = nil,
    Callback = function()
       if game.Players.LocalPlayer.Character.Humanoid.RigType ~= Enum.HumanoidRigType.R15 then
           Notify("System Front","يجب ان تكون R15" , 9)
           return
       end
       local Animate = plr.Character.Animate
       Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=1212900985"
       Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=1212954651"
       Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=1212980338"
       Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=1212980348"
       Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=1212954642"
       Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=1213044939"
       Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=1212900995"       
       plr.Character.Humanoid:ChangeState(3)
       Animate.Disabled = false
    end
})

local FireToggle = EfictScinPlayer:AddToggle("FireToggle", {
   Title = "Fire Effect",
   Description = nil,
   Default = false,
   Callback = function(state)
       if state then
           fireEffect = createFireEffect()
       else
           if fireEffect then
               fireEffect:Destroy()
               fireEffect = nil
           end
       end
   end
})

local SmokeToggle = EfictScinPlayer:AddToggle("SmokeToggle", {
   Title = "Smoke Effect",
   Description = nil,
   Default = false,
   Callback = function(state)
       if state then
           smokeEffect = createSmokeEffect()
       else
           if smokeEffect then
               smokeEffect:Destroy()
               smokeEffect = nil
           end
       end
   end
})

local RainbowToggle = EfictScinPlayer:AddToggle("RainbowToggle", {
   Title = "Rainbow Effect",
   Description = nil,
   Default = false,
   Callback = function(state)
       if state then
           rainbowEffect = createRainbowEffect()
           if rainbowEffect then
               rainbowConnection = RunService.Heartbeat:Connect(function()
                   if player.Character and player.Character:FindFirstChild("HumanoidRootPart") and rainbowEffect then
                       local rootPart = player.Character.HumanoidRootPart
                       rainbowEffect.CFrame = rootPart.CFrame * CFrame.new(0, 0, -3)
                       
                       local time = tick() * 3
                       local r = math.sin(time) * 0.5 + 0.5
                       local g = math.sin(time + 2.1) * 0.5 + 0.5
                       local b = math.sin(time + 4.2) * 0.5 + 0.5
                       rainbowEffect.Color = Color3.new(r, g, b)
                   end
               end)
           end
       else
           if rainbowConnection then
               rainbowConnection:Disconnect()
               rainbowConnection = nil
           end
           if rainbowEffect then
               rainbowEffect:Destroy()
               rainbowEffect = nil
           end
       end
   end
})

player.CharacterAdded:Connect(function()
   wait(1)
   if FireToggle and Options.FireToggle and Options.FireToggle.Value then
       fireEffect = createFireEffect()
   end
   if SmokeToggle and Options.SmokeToggle and Options.SmokeToggle.Value then
       smokeEffect = createSmokeEffect()
   end
   if RainbowToggle and Options.RainbowToggle and Options.RainbowToggle.Value then
       rainbowEffect = createRainbowEffect()
   end
end)


DanceScript:AddButton({
    Title = "Script Dance (WAIT)",
    Description = nil,
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Hm5011/hussain/refs/heads/main/Free%20Dances"))()
    end
})

local AudioHub = Tabs.Humando:AddSection("Audio")



local currentSound = nil

local SoundInput = AudioHub:AddInput("Sound ID", {
    Title = "Music Player",
    Description = nil,
    Default = "",
    Placeholder = "Enter song ID here",
    Numeric = true,
    Finished = true,
    Callback = function(SoundID)
        if SoundID and SoundID ~= "" then
            local sound = Instance.new("Sound")
            sound.SoundId = "rbxassetid://" .. SoundID
            sound.Volume = 1
            sound.Looped = true 
            sound.Parent = game.Workspace
            sound:Play()
            
            if currentSound then
                currentSound:Destroy()
            end
            currentSound = sound
            
            print("Playing song with ID:", SoundID)
        else
            print("Please enter a valid ID")
        end
    end
})

AudioHub:AddButton({
    Title = "Stop Sound",
    Description = nil,
    Callback = function()
        if currentSound then
            currentSound:Stop()
            print("Current sound stopped")
        else
            print("No sound is currently playing")
        end
    end
})


-----------------------------------------------------------------------------------------------------
getgenv().Ready = true
