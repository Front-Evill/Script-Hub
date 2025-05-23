--DATA
getgenv().Ready = false
getgenv().savedPosition = nil

--FUNICTON
local function Notify(Title,Dis)
    pcall(function()
        Fluent:Notify({Title = tostring(Title),Content = tostring(Dis),Duration = 5})
        local sound = Instance.new("Sound", game.Workspace) sound.SoundId = "rbxassetid://3398620867" sound.Volume = 3 sound.Ended:Connect(function() sound:Destroy() end) sound:Play()
    end)
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
    Player = Window:AddTab({ Title = "PLayer", Icon = "user" }),
	Setting = Window:AddTab({ Title = "Setting", Icon = "settings" }),
    Scin = Window:AddTab({ Title = "Scin Player", Icon = "user" })
}

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

local FaemFofSE = Tabs.Setting:AddSection("RemoveFog")
local FarmFpsQuSetting = Tabs.Setting:AddSection("FPS & Quailite")
local ServerNano = Tabs.Setting:AddSection("Server")
local MoodPlayerSetting = Tabs.Setting:AddSection("Mood")
local ForPlayerSetting = Tabs.Setting:AddSection("last")

FaemFofSE:AddButton({
    Title = "Remove Fog",
    Description = nil,
    Callback = function()     
       if getgenv().Ready then
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

ServerNano:AddButton({
    Title = "New Server",
    Description = nil,
    Callback = function() 
       if getgenv().Ready then 
         local TeleportService = game:GetService("TeleportService")
         local Players = game:GetService("Players")
         local HttpService = game:GetService("HttpService")
        
         local placeId = game.PlaceId
        
         local servers = {}
         local req = httprequest({
            Url = "https://games.roblox.com/v1/games/" .. placeId .. "/servers/Public?sortOrder=Desc&limit=100"
         })
         local body = HttpService:JSONDecode(req.Body)
        
         if body and body.data then
             for i, v in pairs(body.data) do
                 if v.playing < v.maxPlayers and v.id ~= game.JobId then
                     table.insert(servers, v.id)
                 end
             end
         end
        
           if #servers > 0 then
                TeleportService:TeleportToPlaceInstance(placeId, servers[math.random(1, #servers)])
               else
                TeleportService:Teleport(placeId)
            end
        end
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

DanceScript:AddButton({
    Title = "Script Dance (WAIT)",
    Description = nil,
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Hm5011/hussain/refs/heads/main/Free%20Dances"))()
    end
})


-----------------------------------------------------------------------------------------------------

getgenv().Ready = true
