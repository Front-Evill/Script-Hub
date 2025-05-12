-- Data
getgenv().Ready = false

local function Notify(Title,Dis)
    pcall(function()
        Fluent:Notify({Title = tostring(Title),Content = tostring(Dis),Duration = 5})
        local sound = Instance.new("Sound", game.Workspace) sound.SoundId = "rbxassetid://3398620867" sound.Volume = 1 sound.Ended:Connect(function() sound:Destroy() end) sound:Play()
    end)
end

local function GetDevice()
    local IsOnMobile = table.find({Enum.Platform.IOS, Enum.Platform.Android}, game:GetService("UserInputService"):GetPlatform())
    if IsOnMobile then
        return "Mobile"
    end
    return "PC"
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
local Window = Fluent:CreateWindow({
    Title =  game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name,
    SubTitle = "By Front -evill",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, High),
    Acrylic = false,
    Theme = Guitheme,
    MinimizeKey = Enum.KeyCode.B
})

local Options = Fluent.Options
Window:SelectTab(1)


local Tabs = {
    -- Main = Window:AddTab({ Title = "Main", Icon = "shield-alert" }),
    -- Visuals = Window:AddTab({ Title = "Visuals", Icon = "eye" }),
    Teleport = Window:AddTab({ Title = "Teleport", Icon = "http://www.roblox.com/asset/?id=6034767608"}),
    Player = Window:AddTab({ Title = "Player", Icon = "user" }),
    Setting = Window:AddTab({ Title = "Setting", Icon = "settings" }),
}
--[[
local FlyScript = Tabs.Main:AddSection("Fly Script (Gui 3)")

FlyScript:AddButton({
    Title = "Fly Script",
    Description = "Clic here for give script fly (Gui3) !!!",
    Callback = function(state)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Front-Evill/Script-Hub/refs/heads/main/Fly.lua.txt"))()
    end
})

local PlayersEspVisuals = Tabs.Visuals:AddSection("Tedyy Esp")

PlayersEspVisuals:AddToggle("TeddyEsp", {
    Title = "Teddy Esp",
    Description = nil,
    Default = false,
    Callback = function()
        if getgenv().Ready then
            for _,v in pairs(workspace:GetChildren()) do
                if v:IsA("Model") and v:FindFirstChild("Head") and v:FindFirstChild("Humanoid") and v.Name == "Teddy" then
                    local BillboardGui = Instance.new("BillboardGui")
                    BillboardGui.Size = UDim2.new(0, 100, 0, 100)
                    BillboardGui.AlwaysOnTop = true
                    BillboardGui.Parent = v.Head
                    local TextLabel = Instance.new("TextLabel")
                    TextLabel.Size = UDim2.new(1, 0, 1, 0)
                    TextLabel.BackgroundTransparency = 1
                    TextLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
                    TextLabel.TextScaled = true
                    TextLabel.Text = "Teddy"
                    TextLabel.Parent = BillboardGui
                end
            end
        else
            for _,v in pairs(workspace:GetChildren()) do
                if v:IsA("Model") and v:FindFirstChild("Head") and v:FindFirstChild("Humanoid") and v.Name == "Teddy" then
                    if v.Head:FindFirstChildOfClass("BillboardGui") then
                        v.Head:FindFirstChildOfClass("BillboardGui"):Destroy()
                    end
                end
            end
        end
    end 
})
--]]


local PlayersTeleport = Tabs.Teleport:AddSection("Players")
local ToolHub = Tabs.Teleport:AddSection("Tool")
PlayersTeleport:AddInput("Input", {
    Title = "Goto Player",
    Description = nil,
    Default = nil,
    Placeholder = "Player Name",
    Numeric = false, 
    Finished = true,
    Callback = function(Value)
		if getgenv().Ready then
			local Target = GetPlayer(Value)
			if Target and Target ~= game.Players.LocalPlayer then
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players[Target.Name].Character.HumanoidRootPart.CFrame * CFrame.new(0,0,-2) * CFrame.Angles(0,math.rad(180),0)
			elseif not Target then
				Notify("Error","Unkown Player")
			end
		end
    end
})

ToolHub:AddButton({
    Title = "TeleportTool",
    Description = "!Click here  for give Tool Teleport",
    Callback = function()
    local Players = game:GetService("Players")
    local player = Players.LocalPlayer


    local tool = Instance.new("Tool")
    tool.Name = "Teleporter"
    tool.ToolTip = "Click to Part For Teleporter"
    tool.RequiresHandle = false
    tool.Parent = player:WaitForChild("Backpack")
    local mouse = player:GetMouse()

    local function onActivated()
    local hit = mouse.Hit
    if not hit then return end
    local destination = hit.p + Vector3.new(0, 5, 0)
    local character = player.Character
    if not character then return end
    if character.PrimaryPart then
        character:SetPrimaryPartCFrame(CFrame.new(destination))
    else
        local hrp = character:FindFirstChild("HumanoidRootPart")
        if hrp then
            hrp.CFrame = CFrame.new(destination)
        end
    end
end
--------- o ----------
tool.Activated:Connect(onActivated)
    end
})
--------- o ---------- 

local PlayerNameTargetting = Tabs.Teleport:AddSection("Target")
local OptionsTargetting = Tabs.Teleport:AddSection("Options")

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

local PlkFarmPlayer = Tabs.Player:AddSection("InfiniteJump")
local SpeedJumpPlayer = Tabs.Player:AddSection("Speed & jump ")
local NoClipPlayer = Tabs.Player:AddSection("NoClip")


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

SpeedJumpPlayer:AddToggle("HighJump", {
    Title = "HighJump",
    Description = "Enables higher jumping ability",
    Default = false,
    Callback = function(state)
        if state then
            game.Players.LocalPlayer.Character.Humanoid.JumpPower = 75
        else
            game.Players.LocalPlayer.Character.Humanoid.JumpPower = 50
        end
    end
})

SpeedJumpPlayer:AddToggle("SpeedBoost", {
    Title = "SpeedBoost",
    Description = "Increases movement speed",
    Default = false,
    Callback = function(state)
        if state then
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 30
        else
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
        end
    end
})

--------- o ----------

local FaemFofSE = Tabs.Setting:AddSection("RemoveFog")
local FarmFpsQuSetting = Tabs.Setting:AddSection("FPS & Quailite")
local ResetSetting = Tabs.Setting:AddSection("Reset Setting")

FaemFofSE:AddButton({
    Title = "Remove Fog",
    Description = nil,
    Callback = function(state)     
        local lighting = game:GetService("Lighting")
       lighting.FogStart = 0
       lighting.FogEnd = 9e9
       lighting.Brightness = 1
       
       for _, v in pairs(lighting:GetChildren()) do
           if v:IsA("Atmosphere") or v:IsA("Sky") or v:IsA("BloomEffect") or v:IsA("BlurEffect") then
               v:Destroy()
           end
       end
        if  state then
           Notify("EZ" , "The code is working" , 7)
          else
           Notify("Oops" , "The script is not working" , 10)
        end
    end
})

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


ResetSetting:AddButton({
    Title = "Reset",
    Description = "Resets all settings to default",
    Callback = function()
        game.Lighting.GlobalShadows = true
        settings().Rendering.QualityLevel = 10
        local bloom = game.Lighting:FindFirstChild("QualityBloom")
        if bloom then bloom:Destroy() end
        local colorCorrection = game.Lighting:FindFirstChild("QualityColorCorrection")
        if colorCorrection then colorCorrection:Destroy() end
        game.Lighting.Ambient = Color3.fromRGB(127, 127, 127)
        game.Lighting.Brightness = 2
        game.Lighting.ClockTime = 12
    end
})

ResetSetting:AddButton({
    Title = "Reset FPS",
    Description = "Resets FPS settings to default",
    Callback = function()
        game.Lighting.GlobalShadows = true
        settings().Rendering.QualityLevel = 10
        local bloom = game.Lighting:FindFirstChild("QualityBloom")
        if bloom then bloom:Destroy() end
        local colorCorrection = game.Lighting:FindFirstChild("QualityColorCorrection")
        if colorCorrection then colorCorrection:Destroy() end
        game.Lighting.Ambient = Color3.fromRGB(127, 127, 127)
        game.Lighting.Brightness = 2
        game.Lighting.ClockTime = 12
    end
})

ResetSetting:AddButton({
    Title = "Reset Quality",
    Description = "Resets Quality settings to default",
    Callback = function()
        game.Lighting.GlobalShadows = true
        settings().Rendering.QualityLevel = 10
        local bloom = game.Lighting:FindFirstChild("QualityBloom")
        if bloom then bloom:Destroy() end
        local colorCorrection = game.Lighting:FindFirstChild("QualityColorCorrection")
        if colorCorrection then colorCorrection:Destroy() end
        game.Lighting.Ambient = Color3.fromRGB(127, 127, 127)
        game.Lighting.Brightness = 2
        game.Lighting.ClockTime = 12
    end
})



ResetSetting:AddButton({
    Title = "Reset Fog",
    Description = "Resets fog settings to default",
    Callback = function()
        local lighting = game:GetService("Lighting")
        lighting.FogStart = 0
        lighting.FogEnd = 9e9
        lighting.Brightness = 1
        
        for _, v in pairs(lighting:GetChildren()) do
            if v:IsA("Atmosphere") or v:IsA("Sky") or v:IsA("BloomEffect") or v:IsA("BlurEffect") then
                v:Destroy()
            end
        end
    end
})

getgenv().Ready = true
Notify("Successed","The script is loaded successfully",5)
