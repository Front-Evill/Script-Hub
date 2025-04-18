--Data
getgenv().AutoFarms = {Coins = false, Wins = false}
getgenv().Esp = {AllPlayers = false, Murder = false, Sheriff = false,Gun = false,Gems = false}
getgenv().TargetUserName = nil
getgenv().FlingMurder = false
getgenv().Ready = false

local version = 1.1
local Running = false
local TweenList = {}
local TeamsColor = {
	Murder = Vector3.new(255, 54, 54),
	Sheriff = Vector3.new(97, 207, 196),
	Innocent = Vector3.new(104, 255, 124),
	Died = Vector3.new(207, 209, 229)
}
local RaritesColor = {
    Godly = Vector3.new(255,0,179),
    Red = Vector3.new(220, 0, 5),
    Default = Vector3.new(106, 106, 106)
}
--Functions

local function ApplyAnimation(animName, animations)
    local player = game.Players.LocalPlayer
    
    -- تنظيف الرسوم المتحركة والاتصالات الحالية
    if _G.CurrentAnimSetup then
        -- إلغاء جميع الاتصالات السابقة
        for _, conn in pairs(_G.CurrentAnimSetup.connections) do
            if typeof(conn) == "RBXScriptConnection" and conn.Connected then
                conn:Disconnect()
            end
        end
        
        -- إيقاف جميع الرسوم المتحركة وإزالتها
        if _G.CurrentAnimSetup.character then
            local humanoid = _G.CurrentAnimSetup.character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                for _, track in pairs(humanoid:GetPlayingAnimationTracks()) do
                    track:Stop()
                end
            end
            
            for _, anim in pairs(_G.CurrentAnimSetup.character:GetChildren()) do
                if anim:IsA("Animation") and anim.Name:match("CustomAnim_") then
                    anim:Destroy()
                end
            end
        end
    end
    
    -- إنشاء مجموعة جديدة للإعداد الحالي
    _G.CurrentAnimSetup = {
        name = animName,
        connections = {},
        animTracks = {},
        character = nil,
        lastState = "idle"
    }
    
    local function setupAnimations(character)
        if not character then return end
        
        -- تخزين مرجع للشخصية
        _G.CurrentAnimSetup.character = character
        
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if not humanoid then
            task.wait(0.5)
            humanoid = character:FindFirstChildOfClass("Humanoid")
            if not humanoid then return end
        end
        
        -- التحقق من نوع Rig
        if humanoid.RigType ~= Enum.HumanoidRigType.R15 then
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "خطأ في الرسوم المتحركة",
                Text = "حزمة الرسوم المتحركة هذه تعمل فقط مع هياكل R15",
                Duration = 3
            })
            return
        end
        
        -- إيقاف جميع الرسوم المتحركة الحالية
        for _, track in pairs(humanoid:GetPlayingAnimationTracks()) do
            track:Stop()
        end
        
        -- إزالة الرسوم المتحركة المخصصة السابقة
        for _, anim in pairs(character:GetChildren()) do
            if anim:IsA("Animation") and anim.Name:match("CustomAnim_") then
                anim:Destroy()
            end
        end
        
        -- إنشاء وتحميل الرسوم المتحركة الجديدة
        local animationObjects = {}
        local animTracks = {}
        
        for animType, animID in pairs(animations) do
            if type(animID) ~= "number" or animID <= 0 then
                continue
            end
            
            local anim = Instance.new("Animation")
            anim.Name = "CustomAnim_" .. animType
            anim.AnimationId = "rbxassetid://" .. animID
            anim.Parent = character
            animationObjects[animType] = anim
            
            local success, animTrack = pcall(function()
                return humanoid:LoadAnimation(anim)
            end)
            
            if success and animTrack then
                animTracks[animType] = animTrack
                
                -- ضبط إعدادات الرسوم المتحركة
                if animType == "idle" then
                    animTrack.Priority = Enum.AnimationPriority.Core
                    animTrack.Looped = true
                elseif animType == "walk" or animType == "run" then
                    animTrack.Priority = Enum.AnimationPriority.Movement
                    animTrack.Looped = true
                elseif animType == "jump" then
                    animTrack.Priority = Enum.AnimationPriority.Action
                elseif animType == "fall" then
                    animTrack.Priority = Enum.AnimationPriority.Action
                end
            else
                warn("فشل تحميل الرسم المتحرك: " .. animType)
            end
        end
        
        _G.CurrentAnimSetup.animTracks = animTracks
        
        -- تشغيل حركة الوقوف مبدئياً
        if animTracks["idle"] then
            animTracks["idle"]:Play()
            _G.CurrentAnimSetup.lastState = "idle"
        end
        
        -- دالة تغيير الحالة - تتأكد من إيقاف الرسوم المتحركة غير المستخدمة
        local function changeState(newState)
            if _G.CurrentAnimSetup.lastState == newState then 
                return -- تجنب التحديثات غير الضرورية
            end
            
            -- إيقاف الرسوم المتحركة النشطة الحالية
            if _G.CurrentAnimSetup.lastState ~= newState then
                if _G.CurrentAnimSetup.lastState == "idle" and animTracks["idle"] and animTracks["idle"].IsPlaying then
                    animTracks["idle"]:Stop()
                elseif _G.CurrentAnimSetup.lastState == "walk" and animTracks["walk"] and animTracks["walk"].IsPlaying then
                    animTracks["walk"]:Stop()
                elseif _G.CurrentAnimSetup.lastState == "run" and animTracks["run"] and animTracks["run"].IsPlaying then
                    animTracks["run"]:Stop()
                elseif _G.CurrentAnimSetup.lastState == "jump" and animTracks["jump"] and animTracks["jump"].IsPlaying then
                    animTracks["jump"]:Stop()
                elseif _G.CurrentAnimSetup.lastState == "fall" and animTracks["fall"] and animTracks["fall"].IsPlaying then
                    animTracks["fall"]:Stop()
                end
            end
            
            -- تشغيل الرسم المتحرك الجديد
            if newState == "idle" and animTracks["idle"] then
                animTracks["idle"]:Play()
            elseif newState == "walk" and animTracks["walk"] then
                animTracks["walk"]:Play()
            elseif newState == "run" and animTracks["run"] then
                animTracks["run"]:Play()
            elseif newState == "jump" and animTracks["jump"] then
                animTracks["jump"]:Play()
            elseif newState == "fall" and animTracks["fall"] then
                animTracks["fall"]:Play()
            end
            
            _G.CurrentAnimSetup.lastState = newState
        end
        
        -- مراقبة تغييرات الحركة باستخدام RunService للحصول على دقة أعلى
        local runService = game:GetService("RunService")
        local movementConn = runService.Heartbeat:Connect(function()
            if not character or not character:IsDescendantOf(game.Workspace) or not humanoid then
                return
            end
            
            local state = humanoid:GetState()
            
            -- معالجة حالات القفز والسقوط
            if state == Enum.HumanoidStateType.Jumping then
                changeState("jump")
                return
            elseif state == Enum.HumanoidStateType.Freefall then
                changeState("fall")
                return
            end
            
            -- معالجة المشي والركض والوقوف
            if humanoid.MoveDirection.Magnitude <= 0.1 then
                -- شخصية متوقفة
                changeState("idle")
            else
                -- شخصية تتحرك - التحقق من سرعة الحركة
                local speed = humanoid.RootPart and (humanoid.RootPart.Velocity * Vector3.new(1, 0, 1)).Magnitude or 0
                
                if speed >= 10 then
                    changeState("run")
                else
                    changeState("walk")
                end
            end
        end)
        
        table.insert(_G.CurrentAnimSetup.connections, movementConn)
        
        -- معالجة إعادة تعيين حالة التحريك
        local resetConn = humanoid.Running:Connect(function(speed)
            if speed < 0.1 and _G.CurrentAnimSetup.lastState ~= "idle" and 
               humanoid:GetState() ~= Enum.HumanoidStateType.Jumping and
               humanoid:GetState() ~= Enum.HumanoidStateType.Freefall then
                changeState("idle")
            end
        end)
        
        table.insert(_G.CurrentAnimSetup.connections, resetConn)
        
        -- معالجة إضافية للحالات
        local stateConn = humanoid.StateChanged:Connect(function(_, newState)
            if newState == Enum.HumanoidStateType.Jumping then
                changeState("jump")
            elseif newState == Enum.HumanoidStateType.Freefall then
                changeState("fall")
            elseif newState == Enum.HumanoidStateType.Landed then
                -- عند الهبوط، التحقق من سرعة الحركة
                if humanoid.MoveDirection.Magnitude > 0.1 then
                    local speed = humanoid.RootPart and (humanoid.RootPart.Velocity * Vector3.new(1, 0, 1)).Magnitude or 0
                    if speed >= 10 then
                        changeState("run")
                    else
                        changeState("walk")
                    end
                else
                    changeState("idle")
                end
            end
        end)
        
        table.insert(_G.CurrentAnimSetup.connections, stateConn)
    end

    local character = player.Character
    if character then
        setupAnimations(character)
    end
    
    -- رصد شخصية جديدة عند إعادة التوليد
    local charAddedConn = player.CharacterAdded:Connect(setupAnimations)
    table.insert(_G.CurrentAnimSetup.connections, charAddedConn)
    
    -- إشعار للاعب
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "تم تغيير الرسوم المتحركة",
        Text = "يتم الآن استخدام " .. animName,
        Duration = 3
    })
    
    -- إرسال معلومات الرسوم المتحركة للاعبين الآخرين (اختياري)
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local AnimEvent = ReplicatedStorage:FindFirstChild("AnimationEvent")
    
    if not AnimEvent then
        AnimEvent = Instance.new("RemoteEvent")
        AnimEvent.Name = "AnimationEvent"
        AnimEvent.Parent = ReplicatedStorage
    end
    
    -- إرسال البيانات إلى الخادم
    if AnimEvent:IsA("RemoteEvent") then
        AnimEvent:FireServer({
            playerName = player.Name,
            animPack = animName
        })
    end
end
 


local function Notify(Title,Dis)
    pcall(function()
        Fluent:Notify({Title = tostring(Title),Content = tostring(Dis),Duration = 5})
        local sound = Instance.new("Sound", game.Workspace) sound.SoundId = "rbxassetid://3398620867" sound.Volume = 1 sound.Ended:Connect(function() sound:Destroy() end) sound:Play()
    end)
end

local function GetTeamOf(Target)
	local Player
	if typeof(Target) == "string" then
		Player = game.Players:FindFirstChild(Target)
	elseif typeof(Target) == "Instance" then
		Player = Target
	end
    if Player then
        local Backpack = Player:FindFirstChild("Backpack")
        if Player.Character and Player.Character:FindFirstChild("Stab",true) then
            return "Murder"
        elseif Player.Character and Player.Character:FindFirstChild("IsGun",true) then
            return "Sheriff"
        end
        if Backpack and Backpack:FindFirstChild("Stab",true) then
            return "Murder"
        elseif Backpack and Backpack:FindFirstChild("IsGun",true) then
            return "Sheriff"
        elseif Player.Character and Player.Character:FindFirstChild("Humanoid") and Player.Character:FindFirstChild("Humanoid").NameDisplayDistance ~= 0 then
            return "Died"
        else
            return "Innocent"
        end
    end
    return false
end

local function GetUserPic(UserId)
    local Data = game:HttpGet("https://thumbnails.roblox.com/v1/users/avatar?userIds="..UserId.."&size=420x420&format=Png&isCircular=false")
    return Data:match('"imageUrl"%s*:%s*"([^"]+)"')
end

local function CheckHWID()
    local jasbddajsdwjs = {"57D3220E-B408-47A3-95B4-4B8063EC7EAD","d5856005-51ea-496b-8e03-74ee7f287942"," "}
    for _,P in ipairs(jasbddajsdwjs) do 
        if game:GetService("RbxAnalyticsService"):GetClientId() == P then
            return {Value = true,ID = P}
        end
    end
    return {Value = false,ID = nil}
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

local function CheckCharacter(Tagert)
    getgenv().ass = Tagert
    local success,error = pcall(function()
        getgenv().ass.Character.Humanoid.Health = tonumber(getgenv().ass.Character.Humanoid.Health)
    end)
    if success then return true else return false end
end

local function GetNearestCoin()
	local CoinContainer = workspace:FindFirstChild("CoinContainer", true)
    if not CoinContainer then return nil end
    local NearestCoin, NearestDistance = nil, math.huge

    for _, Coin in ipairs(CoinContainer:GetChildren()) do
        if Coin:IsA("BasePart") and Coin:FindFirstChild("TouchInterest",true) then
            local Distance = (Coin.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
            if Distance < NearestDistance then
                NearestCoin, NearestDistance = Coin, Distance
            end
        end
    end

    return NearestCoin
end

local function TweenTo(Part)
    if Running then return end
    Running = true
    local Tween = game:GetService("TweenService"):Create(
        game.Players.LocalPlayer.Character.HumanoidRootPart,
        TweenInfo.new((game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Part.Position).Magnitude / 27, Enum.EasingStyle.Linear),
        {CFrame = CFrame.new(Part.Position) * CFrame.Angles(0, game.Players.LocalPlayer.Character.HumanoidRootPart.Orientation.Y, 0)}
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

local function Chat(text)
isLegacyChat = game:GetService("TextChatService").ChatVersion == Enum.ChatVersion.LegacyChatService
    if not isLegacyChat then
        game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync(tostring(text))
    else
        game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(tostring(text), "All")
    end
end

local function CreateEsp(Target)
    local Character = Target.Character
    local NameTag = Character:FindFirstChild("NameTag")
    local TeamColor = TeamsColor[GetTeamOf(Target)]

    local Esp = Character:FindFirstChild("ESP")
    if Esp then
        Esp.FillColor = Color3.fromRGB(TeamColor.X, TeamColor.Y, TeamColor.Z)
    else
        Esp = Instance.new("Highlight")
        Esp.Name = "ESP"
        Esp.OutlineColor = Color3.fromRGB(0, 0, 0)
        Esp.FillColor = Color3.fromRGB(TeamColor.X, TeamColor.Y, TeamColor.Z)
        Esp.Parent = Target.Character
    end
    
    if GetTeamOf(Target) ~= "Died" then
        if NameTag then
            local Label = NameTag:FindFirstChild("TextLabel")
            if Label then
                Label.TextColor3 = Color3.fromRGB(TeamColor.X, TeamColor.Y, TeamColor.Z)
            end
        else
            NameTag = Instance.new("BillboardGui")
            NameTag.Name = "NameTag"
            NameTag.Size = UDim2.new(0, 90, 0, 25)
            NameTag.Adornee = Character:FindFirstChild("Head")
            NameTag.AlwaysOnTop = true
            NameTag.Parent = Character
            NameTag.StudsOffset = Vector3.new(0, 2.5, 0) 

            local Label = Instance.new("TextLabel")
            Label.Size = UDim2.new(1, 0, 1, 0) 
            Label.Text = Target.Name
            Label.TextColor3 = Color3.fromRGB(TeamColor.X, TeamColor.Y, TeamColor.Z)
            Label.BackgroundTransparency = 1
            Label.TextSize = 12 
            Label.TextStrokeTransparency = 0  
            Label.Parent = NameTag
        end
    end
end

local function StopEsp(Target)
    local Esp = Target.Character:FindFirstChild("ESP")
    local NameTag = Target.Character:FindFirstChild("NameTag")
    if Esp then
        Esp:Destroy()
    end
    if NameTag then
        NameTag:Destroy()
    end
end

local function MurderKill(Target) 
	if GetTeamOf(game.Players.LocalPlayer) == "Murder" then
		if not game.Players.LocalPlayer.Character:FindFirstChild("Knife") then 
			game.Players.LocalPlayer.Character.Humanoid:EquipTool(game.Players.LocalPlayer.Backpack:FindFirstChild("Knife"))
		end
		for _,P in ipairs(game.Players:GetPlayers()) do
			if P == Target then
                pcall(function()
                    Target.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0,0,-2)
                    game.Players.LocalPlayer.Character:FindFirstChild("Stab",true):FireServer(Target.Name)
                end)
			end
		end
	end
end 

local function GetMurder()
	for _,P in ipairs(game.Players:GetPlayers()) do 
		if GetTeamOf(P) == "Murder" then
			return P
		end 
	end	
	return nil
end

local function GetSheriff()
	for _,P in ipairs(game.Players:GetPlayers()) do 
		if GetTeamOf(P) == "Sheriff" then
			return P
		end 
	end	
	return nil
end

local function SendTrade(Plr)
	return game:GetService("ReplicatedStorage"):WaitForChild("Trade"):WaitForChild("SendRequest"):InvokeServer(game.Players:FindFirstChild(Plr))
end

local function CancelTrade()
	game:GetService("ReplicatedStorage"):WaitForChild("Trade"):WaitForChild("CancelRequest"):FireServer()
end

local function RemoveSpaces(Str)
    return Str:gsub("%s+", "")
end

local function OfferItem(Type,Name)
    game:GetService("ReplicatedStorage"):WaitForChild("Trade"):WaitForChild("OfferItem"):FireServer(Name,Type)
end

local function AcceptTrade()
    game:GetService("ReplicatedStorage"):WaitForChild("Trade"):WaitForChild("AcceptTrade"):FireServer(285646582)
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
    SubTitle = "By Front / 7sone",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, High),
    Acrylic = false,
    Theme = Guitheme,
    MinimizeKey = Enum.KeyCode.B
})

local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "shield-alert" }),
    Targetting = Window:AddTab({ Title = "Targetting", Icon = "target" }),
    Visuals = Window:AddTab({ Title = "Visuals", Icon = "eye" }),
    Teleport = Window:AddTab({ Title = "Teleport", Icon = "http://www.roblox.com/asset/?id=6034767608"}),
    Player = Window:AddTab({ Title = "Player", Icon = "user" }),
    Setting = Window:AddTab({ Title = "setting", Icon = "settings" }),
    Scain = Window:AddTab({ Title = "SCIN", Icon = "user" }),
}
local Options = Fluent.Options
Window:SelectTab(1)

local FlyHubMain = Tabs.Main:AddSection("Fly")
local AutofarmMain = Tabs.Main:AddSection("Auto Farms")
local AutoMurderMain = Tabs.Main:AddSection("Auto Murder")
local TrollingMain = Tabs.Main:AddSection("Trolling")


FlyHubMain:AddButton({
    Title = "Fly Script",
    Description =  nil,
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Front-Evill/Script-Hub/refs/heads/main/Fly.lua.txt"))()
    end
})


AutofarmMain:AddToggle("AutoCoinsToggle",{
    Title = "AutoCoins", 
    Description = nil,
    Default = false,
    Callback = function(state)
        getgenv().AutoFarms.Coins = state
        while getgenv().AutoFarms.Coins do task.wait()
            pcall(function()
            local Coin = GetNearestCoin()
                if GetTeamOf(game.Players.LocalPlayer) ~= "Died" and Coin and Coin:FindFirstChild("CoinVisual",true) and Coin:FindFirstChild("TouchInterest",true) and Coin:FindFirstChild("CoinVisual",true).Transparency == 1 then 
                    TweenTo(Coin)
                    firetouchinterest(Coin,game.Players.LocalPlayer.Character.HumanoidRootPart,0) 
                    firetouchinterest(Coin,game.Players.LocalPlayer.Character.HumanoidRootPart,1) 
                else
                    StopAllTweens()
                end
            end)
        end
        if not getgenv().AutoFarms.Coins then
            StopAllTweens()
        end
    end 
})

AutofarmMain:AddToggle("AutoCoinsToggle",{
    Title = "AutoFling", 
    Description = nil,
    Default = false,
    Callback = function(state)
        getgenv().AutoFarms.Wins = state
		getgenv().FlingMurder = state
        if state then Notify("Note","This option looks like an auto win option just leave it alone and the murder gonna be flinged in each match.\nMurder knife must be unequipped") end
        while getgenv().AutoFarms.Wins do task.wait()
            pcall(function()
                if GetTeamOf(game.Players.LocalPlayer) ~= "Murder" and GetMurder() and CheckCharacter(GetMurder()) and GetMurder().Character.Humanoid.RootPart.Velocity.Magnitude < 500 and GetMurder().Backpack:FindFirstChild("Knife") then
                    getgenv().MurderUserName = GetMurder().Name
                    getgenv().FlingMurder = true
                    if getgenv().FlingMurder then
                        if not getgenv().MurderUserName then return end
                        if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character.Humanoid and game.Players.LocalPlayer.Character.Humanoid.RootPart then
                            if game.Players.LocalPlayer.Character.Humanoid.RootPart.Velocity.Magnitude < 50 then
                                getgenv().OldPos = game.Players.LocalPlayer.Character.Humanoid.RootPart.CFrame
                            end
                            if game.Players[getgenv().MurderUserName].Character.Head then
                                workspace.CurrentCamera.CameraSubject = game.Players[getgenv().MurderUserName].Character.Head
                            elseif game.Players[getgenv().MurderUserName].Character:FindFirstChildOfClass("Accessory"):FindFirstChild("Handle") then
                                workspace.CurrentCamera.CameraSubject = game.Players[getgenv().MurderUserName].Character:FindFirstChildOfClass("Accessory"):FindFirstChild("Handle")
                            else
                                workspace.CurrentCamera.CameraSubject = game.Players[getgenv().MurderUserName].Character.Humanoid
                            end
                            if not game.Players[getgenv().MurderUserName].Character:FindFirstChildWhichIsA("BasePart") then
                                return
                            end
                            
                            local function FPos(BasePart, Pos, Ang)
                                game.Players.LocalPlayer.Character.Humanoid.RootPart.CFrame = CFrame.new(BasePart.Position) * Pos * Ang
                                game.Players.LocalPlayer.Character:SetPrimaryPartCFrame(CFrame.new(BasePart.Position) * Pos * Ang)
                                game.Players.LocalPlayer.Character.Humanoid.RootPart.Velocity = Vector3.new(9e7, 9e7 * 10, 9e7)
                                game.Players.LocalPlayer.Character.Humanoid.RootPart.RotVelocity = Vector3.new(9e8, 9e8, 9e8)
                            end
                            
                            local function SFBasePart()
                                local Angle = 0
                                getgenv().FPDH = workspace.FallenPartsDestroyHeight
                                workspace.FallenPartsDestroyHeight = 0/0
                                repeat
                                    task.wait()
                                    pcall(function()
                                        if game.Players.LocalPlayer.Character.Humanoid.RootPart and game.Players[getgenv().MurderUserName].Character.Humanoid then
                                            if game.Players[getgenv().MurderUserName].Character.Humanoid.RootPart.Velocity.Magnitude < 50 then
                                                Angle = Angle + 100
                                                for _, Offset in ipairs({
                                                    Vector3.new(0, 1.5, 0), Vector3.new(0, -1.5, 0),
                                                    Vector3.new(2.25, 1.5, -2.25), Vector3.new(-2.25, -1.5, 2.25),
                                                    Vector3.new(0, 1.5, 0), Vector3.new(0, -1.5, 0)
                                                }) do
                                                    FPos(game.Players[getgenv().MurderUserName].Character.Humanoid.RootPart, CFrame.new(Offset) + game.Players[getgenv().MurderUserName].Character.Humanoid.MoveDirection * (game.Players[getgenv().MurderUserName].Character.Humanoid.RootPart.Velocity.Magnitude / 1.25), CFrame.Angles(math.rad(Angle), 0, 0))
                                                    task.wait()
                                                end
                                            else
                                                for _, Data in ipairs({
                                                    {Vector3.new(0, 1.5, game.Players[getgenv().MurderUserName].Character.Humanoid.WalkSpeed), math.rad(90)},
                                                    {Vector3.new(0, -1.5, -game.Players[getgenv().MurderUserName].Character.Humanoid.WalkSpeed), 0},
                                                    {Vector3.new(0, 1.5, game.Players[getgenv().MurderUserName].Character.Humanoid.WalkSpeed), math.rad(90)},
                                                    {Vector3.new(0, 1.5, game.Players[getgenv().MurderUserName].Character.Humanoid.RootPart.Velocity.Magnitude / 1.25), math.rad(90)},
                                                    {Vector3.new(0, -1.5, -game.Players[getgenv().MurderUserName].Character.Humanoid.RootPart.Velocity.Magnitude / 1.25), 0},
                                                    {Vector3.new(0, 1.5, game.Players[getgenv().MurderUserName].Character.Humanoid.RootPart.Velocity.Magnitude / 1.25), math.rad(90)},
                                                    {Vector3.new(0, -1.5, 0), math.rad(90)},
                                                    {Vector3.new(0, -1.5, 0), 0},
                                                    {Vector3.new(0, -1.5, 0), math.rad(-90)},
                                                    {Vector3.new(0, -1.5, 0), 0}
                                                }) do
                                                    FPos(game.Players[getgenv().MurderUserName].Character.Humanoid.RootPart, CFrame.new(Data[1]), CFrame.Angles(Data[2], 0, 0))
                                                    task.wait()
                                                end                        
                                            end
                                            game.Players.LocalPlayer.Character.Humanoid.Sit = false
                                            if game.Players[getgenv().MurderUserName].Character:FindFirstChild("Head") then
                                                workspace.CurrentCamera.CameraSubject = game.Players[getgenv().MurderUserName].Character.Head
                                            end
                                        end
                                    end)
                                    if not GetMurder() then
                                        getgenv().FlingMurder = false
                                        break
                                    end
                                until not getgenv().FlingMurder or not GetMurder().Backpack:FindFirstChild("Knife") or CheckCharacter(GetMurder()) and GetMurder().Character.Humanoid.RootPart.Velocity.Magnitude > 500 or game.Players[getgenv().MurderUserName].Character.Humanoid.RootPart.Parent ~= GetMurder().Character or GetMurder().Parent ~= game.Players or GetMurder().Character.Humanoid.Sit or GetMurder().Character.Humanoid.Health <= 0 
                                getgenv().FlingMurder = false
                            end
                            
                            local BV = Instance.new("BodyVelocity")
                            BV.Name = "Flinger"
                            BV.Parent = game.Players.LocalPlayer.Character.Humanoid.RootPart
                            BV.Velocity = Vector3.new(9e8, 9e8, 9e8)
                            BV.MaxForce = Vector3.new(1/0, 1/0, 1/0)

                            game.Players.LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
                        
                            SFBasePart()

                            BV:Destroy()
                            game.Players.LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
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
                                game.Players.LocalPlayer.Character.Humanoid.sit = false
                            end
                        end
                    end
                else
                    getgenv().FlingMurder = false
                    workspace.FallenPartsDestroyHeight = getgenv().FPDH
                end 
            end)
        end
    end 
})

AutofarmMain:AddToggle("AutoCoinsToggle",{
    Title = "AutoGun", 
    Description = "Immediately take gun when dropped.",
    Default = false,
    Callback = function(state)
        getgenv().AutoFarms.Gun = state
        while getgenv().AutoFarms.Gun do task.wait()
            if GetTeamOf(game.Players.LocalPlayer) ~= "Died" then
                local Dropgun = workspace:FindFirstChild("GunDrop",true)
                if Dropgun then
                    local Oldpos = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                    wait()
                    repeat task.wait()
                        pcall(function()
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Dropgun.Position + Vector3.new(0, -4, 0)) * CFrame.Angles(math.rad(90), 0, 0)
                        firetouchinterest(Dropgun,game.Players.LocalPlayer.Character.HumanoidRootPart,0)
                        firetouchinterest(Dropgun,game.Players.LocalPlayer.Character.HumanoidRootPart,1)
                        end)
                    until not Dropgun or not getgenv().AutoFarms.Gun or game.Players.LocalPlayer.Character:FindFirstChild("Gun") or game.Players.LocalPlayer.Backpack:FindFirstChild("Gun")
                    wait()
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Oldpos
                    game.Players.LocalPlayer.Character.Humanoid:ChangeState("GettingUp")
                end
            end
        end
    end 
})

AutoMurderMain:AddButton({
    Title = "Kill All",
    Description = nil,
    Callback = function()
        if GetTeamOf(game.Players.LocalPlayer) == "Murder" then
            local t = 0 
            repeat wait()
            for _,P in ipairs(game.Players:GetPlayers()) do 
                if GetTeamOf(P) ~= "Died" then
                    MurderKill(P)
                end
            end
            t += 1
            until t >= 20
        else
        Notify("Error","You must be a murder")
        end
    end
})

AutoMurderMain:AddButton({
    Title = "Kill Sheriff",
    Description = nil,
    Callback = function()
        if GetTeamOf(game.Players.LocalPlayer) == "Murder" then
            local t = 0 
            repeat wait()
            for _,P in ipairs(game.Players:GetPlayers()) do 
                if GetTeamOf(P) == "Sheriff" then
                    MurderKill(P)
                end
            end
            t += 1
            until t >= 20
        else
        Notify("Error","You must be a murder")
        end
    end
})

TrollingMain:AddButton({
    Title = "Say Sheriff & Killer",
    Description = nil,
    Callback = function()
        if GetMurder() then
            Chat("|Murder: "..GetMurder().Name)
        end
        wait()
        if GetSheriff() then
            Chat("|Sheriff: "..GetSheriff().Name)
        end
    end
})

TrollingMain:AddButton({
    Title = "Fling all",
    Description = nil,
    Callback = function()
        Window:Dialog({
            Title = "Warning",
            Content = "Using this option may break the game teleport for you.\nDo you want to continue?",
            Buttons = {
                { 
                    Title = "Confirm",
                    Callback = function()
                        loadstring(game:HttpGet("https://raw.githubusercontent.com/Hm5011/hussain/refs/heads/main/UnForbidden%20Fling"))()
                    end 
                }, {
                    Title = "Cancel",
                    Callback = function()
                        return nil
                    end 
                }
            }
        })
    end
})

local PlayerNameTargetting = Tabs.Targetting:AddSection("Target")
local OptionsTargetting = Tabs.Targetting:AddSection("Options")

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
			Notify("@".. Target.Name .. " Info↓","Account Age: ".. tostring(Target.AccountAge) .."\nLevel: ".. tostring(game.Players.LocalPlayer:GetAttribute("Level")) .."\nTeam: ".. tostring(GetTeamOf(Target)))
		elseif getgenv().Ready then
			Notify("Error","Please choose a player to target")
		end
    end
})

OptionsTargetting:AddButton({
    Title = "Say Team",
    Description = nil,
    Callback = function()
		if getgenv().Ready and getgenv().TargetUserName and game.Players:FindFirstChild(getgenv().TargetUserName) then
			local Target = game.Players:FindFirstChild(getgenv().TargetUserName)
            Chat(getgenv().TargetUserName.." is a "..GetTeamOf(getgenv().TargetUserName))
            elseif getgenv().Ready then
			Notify("Error","Please choose a player to target")
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
    Title = "Kill",
    Description = nil,
    Callback = function()
		if getgenv().Ready and getgenv().TargetUserName and game.Players:FindFirstChild(getgenv().TargetUserName) then
			local Target = game.Players:FindFirstChild(getgenv().TargetUserName)
			if GetTeamOf(game.Players.LocalPlayer) == "Murder" then
                local t = 0 
                repeat wait()
                for _,P in ipairs(game.Players:GetPlayers()) do 
                    if P == Target then
                        MurderKill(P)
                    end
                end
                t += 1
                until t >= 20
            else
            Notify("Error","You must be a murder")
            end
		elseif getgenv().Ready then
			Notify("Error","Please choose a player to target")
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

OptionsTargetting:AddToggle("FlingTargetToggle", {
    Title = "Fling", 
    Description = nil,
    Default = false,
    Callback = function(Value)
		getgenv().FlingTarget = Value
        if getgenv().FlingTarget then
            if not getgenv().TargetUserName then  Notify("Error","Please choose a player to target") return end
			if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character.Humanoid and game.Players.LocalPlayer.Character.Humanoid.RootPart then
				if game.Players.LocalPlayer.Character.Humanoid.RootPart.Velocity.Magnitude < 50 then
					getgenv().OldPos = game.Players.LocalPlayer.Character.Humanoid.RootPart.CFrame
				end
				if game.Players[getgenv().TargetUserName].Character.Head then
					workspace.CurrentCamera.CameraSubject = game.Players[getgenv().TargetUserName].Character.Head
				elseif game.Players[getgenv().TargetUserName].Character:FindFirstChildOfClass("Accessory"):FindFirstChild("Handle") then
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
					game.Players.LocalPlayer.Character.Humanoid.RootPart.Velocity = Vector3.new(9e7, 9e7 * 10, 9e7)
					game.Players.LocalPlayer.Character.Humanoid.RootPart.RotVelocity = Vector3.new(9e8, 9e8, 9e8)
				end
				
				local function SFBasePart()
					local Angle = 0
					getgenv().FPDH = workspace.FallenPartsDestroyHeight
					workspace.FallenPartsDestroyHeight = 0/0
					repeat
						task.wait()
						pcall(function()
							if game.Players.LocalPlayer.Character.Humanoid.RootPart and game.Players[getgenv().TargetUserName].Character.Humanoid then
								if game.Players[getgenv().TargetUserName].Character.Humanoid.RootPart.Velocity.Magnitude < 50 then
									Angle = Angle + 100
									for _, Offset in ipairs({
										Vector3.new(0, 1.5, 0), Vector3.new(0, -1.5, 0),
										Vector3.new(2.25, 1.5, -2.25), Vector3.new(-2.25, -1.5, 2.25),
										Vector3.new(0, 1.5, 0), Vector3.new(0, -1.5, 0)
									}) do
										FPos(game.Players[getgenv().TargetUserName].Character.Humanoid.RootPart, CFrame.new(Offset) + game.Players[getgenv().TargetUserName].Character.Humanoid.MoveDirection * (game.Players[getgenv().TargetUserName].Character.Humanoid.RootPart.Velocity.Magnitude / 1.25), CFrame.Angles(math.rad(Angle), 0, 0))
										task.wait()
									end
								else
									for _, Data in ipairs({
										{Vector3.new(0, 1.5, game.Players[getgenv().TargetUserName].Character.Humanoid.WalkSpeed), math.rad(90)},
										{Vector3.new(0, -1.5, -game.Players[getgenv().TargetUserName].Character.Humanoid.WalkSpeed), 0},
										{Vector3.new(0, 1.5, game.Players[getgenv().TargetUserName].Character.Humanoid.WalkSpeed), math.rad(90)},
										{Vector3.new(0, 1.5, game.Players[getgenv().TargetUserName].Character.Humanoid.RootPart.Velocity.Magnitude / 1.25), math.rad(90)},
										{Vector3.new(0, -1.5, -game.Players[getgenv().TargetUserName].Character.Humanoid.RootPart.Velocity.Magnitude / 1.25), 0},
										{Vector3.new(0, 1.5, game.Players[getgenv().TargetUserName].Character.Humanoid.RootPart.Velocity.Magnitude / 1.25), math.rad(90)},
										{Vector3.new(0, -1.5, 0), math.rad(90)},
										{Vector3.new(0, -1.5, 0), 0},
										{Vector3.new(0, -1.5, 0), math.rad(-90)},
										{Vector3.new(0, -1.5, 0), 0}
									}) do
										FPos(game.Players[getgenv().TargetUserName].Character.Humanoid.RootPart, CFrame.new(Data[1]), CFrame.Angles(Data[2], 0, 0))
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
				
				local BV = Instance.new("BodyVelocity")
				BV.Name = "Flinger"
				BV.Parent = game.Players.LocalPlayer.Character.Humanoid.RootPart
				BV.Velocity = Vector3.new(9e8, 9e8, 9e8)
				BV.MaxForce = Vector3.new(1/0, 1/0, 1/0)

				game.Players.LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
			
				SFBasePart()

				BV:Destroy()
				game.Players.LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
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
					game.Players.LocalPlayer.Character.Humanoid.sit = false
				end
			end
		end
    end 
})

local PlayersEspVisuals = Tabs.Visuals:AddSection("Players Esp")
local EntitiesEspVisuals = Tabs.Visuals:AddSection("Entities Esp")

PlayersEspVisuals:AddToggle("AllPlayersEspToggle", {
    Title = "All Players Esp", 
    Description = nil,
    Default = false,
    Callback = function(state)
        getgenv().Esp.AllPlayers = state
        if getgenv().Esp.AllPlayers then
            Options.MurderEspToggle:SetValue(false)
            Options.SheriffEspToggle:SetValue(false)
            while getgenv().Esp.AllPlayers do 
                for _,P in ipairs(game.Players:GetPlayers()) do 
                    if P ~= game.Players.LocalPlayer then
                        pcall(function()
                            CreateEsp(P)
                        end)
                    end
                end
                wait(0.6)
            end
            wait(0.1)
            for _,P in ipairs(game.Players:GetPlayers()) do
                pcall(function() 
                    StopEsp(P)
                end)
            end
        end
    end 
})

PlayersEspVisuals:AddToggle("MurderEspToggle", {
    Title = "Murder Esp", 
    Description = nil,
    Default = false,
    Callback = function(state)
        getgenv().Esp.Murder = state
        if getgenv().Esp.Murder then
            Options.AllPlayersEspToggle:SetValue(false)
            while getgenv().Esp.Murder do 
                for _,P in ipairs(game.Players:GetPlayers()) do 
                    if P ~= game.Players.LocalPlayer and GetTeamOf(P) == "Murder" then
                        pcall(function()
                            CreateEsp(P)
                        end)
                    end
                end
                wait(0.6)
            end
            wait(0.1)
            for _,P in ipairs(game.Players:GetPlayers()) do
                if GetTeamOf(P) == "Murder" then 
                    pcall(function() 
                        StopEsp(P)
                    end)
                end
            end
        end
    end 
})

PlayersEspVisuals:AddToggle("SheriffEspToggle", {
    Title = "Sheriff Esp", 
    Description = nil,
    Default = false,
    Callback = function(state)
        getgenv().Esp.Sheriff = state
        if getgenv().Esp.Sheriff then
            Options.AllPlayersEspToggle:SetValue(false)
            while getgenv().Esp.Sheriff do 
                for _,P in ipairs(game.Players:GetPlayers()) do 
                    if P ~= game.Players.LocalPlayer and GetTeamOf(P) == "Sheriff" then
                        pcall(function()
                            CreateEsp(P)
                        end)
                    end
                end
                wait(0.6)
            end
            wait(0.1)
            for _,P in ipairs(game.Players:GetPlayers()) do
                if GetTeamOf(P) == "Sheriff" then 
                    pcall(function() 
                        StopEsp(P)
                    end)
                end
            end
        end
    end 
})

EntitiesEspVisuals:AddToggle("GunEspToggle", {
    Title = "Gun Esp", 
    Description = nil,
    Default = false,
    Callback = function(state)
        getgenv().Esp.Gun = state
        if getgenv().Esp.Gun then
            while getgenv().Esp.Gun do task.wait()
                local Dropgun = workspace:FindFirstChild("GunDrop",true)
                local Billboard
                if Dropgun then
                    if not Dropgun:FindFirstChild("ESP") then
                        while getgenv().Esp.Gun do 
                            task.wait()
                            local Dropgun = workspace:FindFirstChild("GunDrop", true)
                            if Dropgun then
                                if not Dropgun:FindFirstChild("ESP") then
									local Billboard = Instance.new("BillboardGui", Dropgun)
									Billboard.Name = "ESP"
									Billboard.Size = UDim2.new(0, 200, 0, 100) 
									Billboard.Adornee = Dropgun
									Billboard.StudsOffset = Vector3.new(0, 3, 0) 
									Billboard.AlwaysOnTop = true
								
									local TextLabel = Instance.new("TextLabel", Billboard)
									TextLabel.Size = UDim2.new(1, 0, 1, 0)
									TextLabel.BackgroundTransparency = 1
									TextLabel.Text = "Gun Drop"
									TextLabel.TextColor3 = Color3.fromRGB(255, 234, 41)
									TextLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
									TextLabel.TextStrokeTransparency = 0
									TextLabel.Font = Enum.Font.SourceSansBold
									TextLabel.TextSize = 40
								end
                            end
                        end  
                        if Billboard then
                            Billboard:Destroy()
                        end
                    end
                end
            end
        end
    end 
})

local PlayersTeleport = Tabs.Teleport:AddSection("Players")
local PlacesTeleport = Tabs.Teleport:AddSection("Places")

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

PlayersTeleport:AddButton({
    Title = "Murder",
    Description = nil,
    Callback = function()
		if GetMurder() and CheckCharacter(GetMurder()) and GetMurder() ~= game.Players.LocalPlayer then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = GetMurder().Character.HumanoidRootPart.CFrame * CFrame.new(0,0,-4)
        else
            Notify("Error","There is no murder")
        end
    end
})

PlayersTeleport:AddButton({
    Title = "Sheriff",
    Description = nil,
    Callback = function()
		if GetSheriff() and CheckCharacter(GetSheriff()) and GetSheriff() ~= game.Players.LocalPlayer then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = GetSheriff().Character.HumanoidRootPart.CFrame * CFrame.new(0,0,-4)
        else
            Notify("Error","There is no sheriff")
        end
    end
})

PlacesTeleport:AddButton({
    Title = "Lobby",
    Description = nil,
    Callback = function()
		for _, P in ipairs(game.Workspace:GetDescendants()) do
            if P.Name == "Spawns" and P.Parent.Name == "Lobby" then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(P:GetChildren()[math.random(#P:GetChildren())].Position + Vector3.new(0,3,0))
                return nil
            end
        end        
    end
})

PlacesTeleport:AddButton({
    Title = "Map",
    Description = nil,
    Callback = function()
		for _, P in ipairs(game.Workspace:GetDescendants()) do
            if P.Name == "Spawns" and P.Parent.Name ~= "Lobby" then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(P:GetChildren()[math.random(#P:GetChildren())].Position + Vector3.new(0,3,0))
                return nil
            end
        end  
        Notify("Error","There is no map")
    end
})
getgenv().Ready = true

local PlkFarmPlayer = Tabs.Player:AddSection("For Player")
local SpeedJumpPlayer = Tabs.Player:AddSection("Speed & Jump")
local NoClipPlayer = Tabs.Player:AddSection("No clip")

----------------- Infinite Jump --------------------

PlkFarmPlayer:AddToggle("InfiniteJump", {
    Title = "Infinite Jump",
    Description = nil,
    Default = false,
    Callback = function(state)
        infiniteJumpEnabled = state
        if state then
            Notify("The script has been turned on")
        else
            Notify("The script has been turned off")
        end
    end
})

game:GetService("UserInputService").JumpRequest:Connect(function()
    if infiniteJumpEnabled then
        local player = game.Players.LocalPlayer
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)

----------------- speed & jump --------------------

SpeedJumpPlayer:AddToggle("HighJump", {
    Title = "High Jump",
    Description = "Enables higher jumping ability",
    Default = false,
    Callback = function(state)
        if state then
            game.Players.LocalPlayer.Character.Humanoid.JumpPower = 100
        else
            game.Players.LocalPlayer.Character.Humanoid.JumpPower = 50
        end
    end
})


SpeedJumpPlayer:AddToggle("SpeedBoost", {
    Title = "Speed Boost",
    Description = "Increases movement speed",
    Default = false,
    Callback = function(state)
        if state then
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 32
        else
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
        end
    end
})

----------------- No clip --------------------


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


---------------- Setting -------------------

local FarmsSettingHub = Tabs.Setting:AddSection("FOG")
local FarmFpsQuSetting = Tabs.Setting:AddSection("FPS & Quality")
local ServerHub3 = Tabs.Setting:AddSection("Server")
local FarmMoodHub = Tabs.Setting:AddSection("Mood")

----------- FOG -------------
FarmsSettingHub:AddButton({
    Title = "Remove Fog",
    Description = "Removes all fog from the game",
    Callback = function()
        game.Lighting.FogStart = 0
        game.Lighting.FogEnd = 9999999
        game.Lighting.Atmosphere.Density = 0
        game.Lighting.Atmosphere.Haze = 0
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




----------------- MOODE ---------------

FarmMoodHub:AddButton({
    Title = "Night Mode",
    Description = "Change game time to night",
    Callback = function()
        local lighting = game:GetService("Lighting")
        lighting.ClockTime = 0
        lighting.Brightness = 0.1
        lighting.Ambient = Color3.fromRGB(20, 20, 30)
        lighting.OutdoorAmbient = Color3.fromRGB(5, 5, 10)
        lighting.FogEnd = 275
        lighting.FogColor = Color3.fromRGB(0, 0, 20)
    end
 })
 
 FarmMoodHub:AddButton({
    Title = "Day Mode",
    Description = "Change game time to day",
    Callback = function()
        local lighting = game:GetService("Lighting")
        lighting.ClockTime = 12
        lighting.Brightness = 1.5
        lighting.Ambient = Color3.fromRGB(150, 150, 150)
        lighting.OutdoorAmbient = Color3.fromRGB(120, 120, 120)
        lighting.FogEnd = 1000
        lighting.FogColor = Color3.fromRGB(255, 255, 255)
    end
 })
 
 FarmMoodHub:AddButton({
    Title = "Default Mode",
    Description = "Reset lighting to default",
    Callback = function()
        local lighting = game:GetService("Lighting")
        lighting.ClockTime = 14
        lighting.Brightness = 1
        lighting.Ambient = Color3.fromRGB(127, 127, 127)
        lighting.OutdoorAmbient = Color3.fromRGB(127, 127, 127)
        lighting.FogEnd = 100000
        lighting.FogColor = Color3.fromRGB(191, 191, 191)
    end
 })

 ----------------- TAB SCIN ---------------

 local SwordHub1 = Tabs.Scain:AddSection("SWORD FREE / soon")
 local GunHub2 = Tabs.Scain:AddSection("GUN FREE / soon")
 local DanceHub3 = Tabs.Scain:AddSection("DANCE FREE / soon")
 local AnimationHub4 = Tabs.Scain:AddSection("Animation Free (BETA)")




AnimationHub4:AddButton({
    Title = "Oldschool Animation Pack",
    Description = "Apply Oldschool animations (R15)",
    Callback = function()
        local animations = {
            idle = 5319828216,
            walk = 5319847204,
            run = 5319844329,
            jump = 5319841935,
            fall = 5319839762
        }
        
        ApplyAnimation("Oldschool Animation Pack", animations)
    end
})

AnimationHub4:AddButton({
    Title = "Robot Animation Package",
    Description = "Apply Robot animations (R15)",
    Callback = function()
        local animations = {
            idle = 616088211,
            walk = 616146177,
            run = 616163682,
            jump = 616139451,
            fall = 616134815
        }
        
        ApplyAnimation("Robot Animation Package", animations)
    end
})

AnimationHub4:AddButton({
    Title = "Magsa Animation Package",
    Description = "Apply Magsa animations (R15)",
    Callback = function()
        local animations = {
            idle = 3489171152,
            walk = 3489173414,
            run = 3489175274,
            jump = 3489174223,
            fall = 3489174223
        }
        
        ApplyAnimation("Magsa Animation Package", animations)
    end
})

AnimationHub4:AddButton({
    Title = "Robot Animation Pack",
    Description = "Apply Robot animations (R15)",
    Callback = function()
        local animations = {
            idle = 5712866595,
            walk = 5712850190,
            run = 5712856902,
            jump = 5712848865,
            fall = 5712852267
        }
        
        ApplyAnimation("Robot Animation Pack", animations)
    end
})

AnimationHub4:AddButton({
    Title = "Levitation Animation Pack",
    Description = "Apply Levitation animations (R15)",
    Callback = function()
        local animations = {
            idle = 616006778,
            walk = 616013216,
            run = 616010382,
            jump = 616008087,
            fall = 616005863
        }
        
        ApplyAnimation("Levitation Animation Pack", animations)
    end
})

-- Complete modified Dance Hub code with all dances
DanceHub3:AddButton({
    Title = "Floss Dance",
    Description = nil,
    Callback = function()
        local animation = Instance.new("Animation")
        animation.AnimationId = "rbxassetid://16488431869"
        
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character:WaitForChild("Humanoid")
        
        local animTrack = humanoid:LoadAnimation(animation)
        animTrack:Play()
    end
})

DanceHub3:AddButton({
    Title = "Zombie Dance",
    Description = nil,
    Callback = function()
        local animation = Instance.new("Animation")
        animation.AnimationId = "rbxassetid://4212499637"
        
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character:WaitForChild("Humanoid")
        
        local animTrack = humanoid:LoadAnimation(animation)
        animTrack:Play()
    end
})

DanceHub3:AddButton({
    Title = "Dab Dance",
    Description = nil,
    Callback = function()
        local animation = Instance.new("Animation")
        animation.AnimationId = "rbxassetid://4212499189"
        
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character:WaitForChild("Humanoid")
        
        local animTrack = humanoid:LoadAnimation(animation)
        animTrack:Play()
    end
})

DanceHub3:AddButton({
    Title = "Ninja Dance",
    Description = nil,
    Callback = function()
        local animation = Instance.new("Animation")
        animation.AnimationId = "rbxassetid://4212500292"
        
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character:WaitForChild("Humanoid")
        
        local animTrack = humanoid:LoadAnimation(animation)
        animTrack:Play()
    end
})

DanceHub3:AddButton({
    Title = "Groove Dance",
    Description = nil,
    Callback = function()
        local animation = Instance.new("Animation")
        animation.AnimationId = "rbxassetid://4212506118"
        
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character:WaitForChild("Humanoid")
        
        local animTrack = humanoid:LoadAnimation(animation)
        animTrack:Play()
    end
})

DanceHub3:AddButton({
    Title = "Hip Hop Dance",
    Description = nil,
    Callback = function()
        local animation = Instance.new("Animation")
        animation.AnimationId = "rbxassetid://3695500161"
        
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character:WaitForChild("Humanoid")
        
        local animTrack = humanoid:LoadAnimation(animation)
        animTrack:Play()
    end
})

DanceHub3:AddButton({
    Title = "Disco Dance",
    Description = nil,
    Callback = function()
        local animation = Instance.new("Animation")
        animation.AnimationId = "rbxassetid://3695493465"
        
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character:WaitForChild("Humanoid")
        
        local animTrack = humanoid:LoadAnimation(animation)
        animTrack:Play()
    end
})

DanceHub3:AddButton({
    Title = "Robot Dance",
    Description = nil,
    Callback = function()
        local animation = Instance.new("Animation")
        animation.AnimationId = "rbxassetid://3695525251"
        
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character:WaitForChild("Humanoid")
        
        local animTrack = humanoid:LoadAnimation(animation)
        animTrack:Play()
    end
})

DanceHub3:AddButton({
    Title = "Twirl Dance",
    Description = nil,
    Callback = function()
        local animation = Instance.new("Animation")
        animation.AnimationId = "rbxassetid://3695486745"
        
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character:WaitForChild("Humanoid")
        
        local animTrack = humanoid:LoadAnimation(animation)
        animTrack:Play()
    end
})

DanceHub3:AddButton({
    Title = "Silly Dance",
    Description = nil,
    Callback = function()
        local animation = Instance.new("Animation")
        animation.AnimationId = "rbxassetid://4212499771"
        
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character:WaitForChild("Humanoid")
        
        local animTrack = humanoid:LoadAnimation(animation)
        animTrack:Play()
    end
})

DanceHub3:AddButton({
    Title = "Breakdance",
    Description = nil,
    Callback = function()
        local animation = Instance.new("Animation")
        animation.AnimationId = "rbxassetid://5915648917"
        
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character:WaitForChild("Humanoid")
        
        local animTrack = humanoid:LoadAnimation(animation)
        animTrack:Play()
    end
})

DanceHub3:AddButton({
    Title = "Electro Shuffle",
    Description = nil,
    Callback = function()
        local animation = Instance.new("Animation")
        animation.AnimationId = "rbxassetid://3695333486"
        
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character:WaitForChild("Humanoid")
        
        local animTrack = humanoid:LoadAnimation(animation)
        animTrack:Play()
    end
})

DanceHub3:AddButton({
    Title = "Orange Justice",
    Description = nil,
    Callback = function()
        local animation = Instance.new("Animation")
        animation.AnimationId = "rbxassetid://3695342270"
        
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character:WaitForChild("Humanoid")
        
        local animTrack = humanoid:LoadAnimation(animation)
        animTrack:Play()
    end
})

DanceHub3:AddButton({
    Title = "Take The L",
    Description = nil,
    Callback = function()
        local animation = Instance.new("Animation")
        animation.AnimationId = "rbxassetid://4049646104"
        
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character:WaitForChild("Humanoid")
        
        local animTrack = humanoid:LoadAnimation(animation)
        animTrack:Play()
    end
})

DanceHub3:AddButton({
    Title = "Hype Dance",
    Description = nil,
    Callback = function()
        local animation = Instance.new("Animation")
        animation.AnimationId = "rbxassetid://3695373233"
        
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character:WaitForChild("Humanoid")
        
        local animTrack = humanoid:LoadAnimation(animation)
        animTrack:Play()
    end
})

DanceHub3:AddButton({
    Title = "Default Dance",
    Description = nil,
    Callback = function()
        local animation = Instance.new("Animation")
        animation.AnimationId = "rbxassetid://4212499637"
        
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character:WaitForChild("Humanoid")
        
        local animTrack = humanoid:LoadAnimation(animation)
        animTrack:Play()
    end
})

DanceHub3:AddButton({
    Title = "Macarena",
    Description = nil,
    Callback = function()
        local animation = Instance.new("Animation")
        animation.AnimationId = "rbxassetid://4235834241"
        
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character:WaitForChild("Humanoid")
        
        local animTrack = humanoid:LoadAnimation(animation)
        animTrack:Play()
    end
})

DanceHub3:AddButton({
    Title = "Gangnam Style",
    Description = nil,
    Callback = function()
        local animation = Instance.new("Animation")
        animation.AnimationId = "rbxassetid://4235835055"
        
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character:WaitForChild("Humanoid")
        
        local animTrack = humanoid:LoadAnimation(animation)
        animTrack:Play()
    end
})

DanceHub3:AddButton({
    Title = "Moonwalk",
    Description = nil,
    Callback = function()
        local animation = Instance.new("Animation")
        animation.AnimationId = "rbxassetid://4212500834"
        
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character:WaitForChild("Humanoid")
        
        local animTrack = humanoid:LoadAnimation(animation)
        animTrack:Play()
    end
})

DanceHub3:AddButton({
    Title = "Carlton Dance",
    Description = nil,
    Callback = function()
        local animation = Instance.new("Animation")
        animation.AnimationId = "rbxassetid://4235823281"
        
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character:WaitForChild("Humanoid")
        
        local animTrack = humanoid:LoadAnimation(animation)
        animTrack:Play()
    end
})

-- رقصات محدثة مع إيقاف الرقصة عند الحركة أو القفز
DanceHub3:AddButton({
    Title = "رقصة الفرح",
    Description = nil,
    Callback = function()
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character:WaitForChild("Humanoid")
        
        -- تشغيل رقصة بـ ID محدث
        local animation = Instance.new("Animation")
        animation.AnimationId = "rbxassetid://4841405708" -- رقصة الفرح - محدثة
        
        local animTrack = humanoid:LoadAnimation(animation)
        animTrack:Play()
        
        -- إيقاف الرقصة عند الحركة أو القفز
        local connection
        connection = humanoid.Running:Connect(function(speed)
            if speed > 0 then
                animTrack:Stop()
                connection:Disconnect()
            end
        end)
        
        local jumpConnection
        jumpConnection = humanoid.StateChanged:Connect(function(oldState, newState)
            if newState == Enum.HumanoidStateType.Jumping then
                animTrack:Stop()
                jumpConnection:Disconnect()
                if connection then
                    connection:Disconnect()
                end
            end
        end)
    end
})

DanceHub3:AddButton({
    Title = "رقصة المشاعر",
    Description = nil,
    Callback = function()
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character:WaitForChild("Humanoid")
        
        local animation = Instance.new("Animation")
        animation.AnimationId = "rbxassetid://4841407203" -- رقصة المشاعر - محدثة
        
        local animTrack = humanoid:LoadAnimation(animation)
        animTrack:Play()
        
        local connection
        connection = humanoid.Running:Connect(function(speed)
            if speed > 0 then
                animTrack:Stop()
                connection:Disconnect()
            end
        end)
        
        local jumpConnection
        jumpConnection = humanoid.StateChanged:Connect(function(oldState, newState)
            if newState == Enum.HumanoidStateType.Jumping then
                animTrack:Stop()
                jumpConnection:Disconnect()
                if connection then
                    connection:Disconnect()
                end
            end
        end)
    end
})

DanceHub3:AddButton({
    Title = "رقصة هيب هوب",
    Description = nil,
    Callback = function()
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character:WaitForChild("Humanoid")
        
        local animation = Instance.new("Animation")
        animation.AnimationId = "rbxassetid://3189773368" -- رقصة هيب هوب - محدثة
        
        local animTrack = humanoid:LoadAnimation(animation)
        animTrack:Play()
        
        local connection
        connection = humanoid.Running:Connect(function(speed)
            if speed > 0 then
                animTrack:Stop()
                connection:Disconnect()
            end
        end)
        
        local jumpConnection
        jumpConnection = humanoid.StateChanged:Connect(function(oldState, newState)
            if newState == Enum.HumanoidStateType.Jumping then
                animTrack:Stop()
                jumpConnection:Disconnect()
                if connection then
                    connection:Disconnect()
                end
            end
        end)
    end
})

-- رقصات MM2
DanceHub3:AddButton({
    Title = "MM2 - رقصة فلوس",
    Description = nil,
    Callback = function()
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character:WaitForChild("Humanoid")
        
        local animation = Instance.new("Animation")
        animation.AnimationId = "rbxassetid://4212455378" -- رقصة فلوس من MM2
        
        local animTrack = humanoid:LoadAnimation(animation)
        animTrack:Play()
        
        local connection
        connection = humanoid.Running:Connect(function(speed)
            if speed > 0 then
                animTrack:Stop()
                connection:Disconnect()
            end
        end)
        
        local jumpConnection
        jumpConnection = humanoid.StateChanged:Connect(function(oldState, newState)
            if newState == Enum.HumanoidStateType.Jumping then
                animTrack:Stop()
                jumpConnection:Disconnect()
                if connection then
                    connection:Disconnect()
                end
            end
        end)
    end
})

DanceHub3:AddButton({
    Title = "MM2 - رقصة زومبي",
    Description = nil,
    Callback = function()
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character:WaitForChild("Humanoid")
        
        local animation = Instance.new("Animation")
        animation.AnimationId = "rbxassetid://4212457264" -- رقصة زومبي من MM2
        
        local animTrack = humanoid:LoadAnimation(animation)
        animTrack:Play()
        
        local connection
        connection = humanoid.Running:Connect(function(speed)
            if speed > 0 then
                animTrack:Stop()
                connection:Disconnect()
            end
        end)
        
        local jumpConnection
        jumpConnection = humanoid.StateChanged:Connect(function(oldState, newState)
            if newState == Enum.HumanoidStateType.Jumping then
                animTrack:Stop()
                jumpConnection:Disconnect()
                if connection then
                    connection:Disconnect()
                end
            end
        end)
    end
})

DanceHub3:AddButton({
    Title = "MM2 - رقصة لاي لاي",
    Description = nil,
    Callback = function()
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character:WaitForChild("Humanoid")
        
        local animation = Instance.new("Animation")
        animation.AnimationId = "rbxassetid://4212460119" -- رقصة لاي لاي من MM2
        
        local animTrack = humanoid:LoadAnimation(animation)
        animTrack:Play()
        
        local connection
        connection = humanoid.Running:Connect(function(speed)
            if speed > 0 then
                animTrack:Stop()
                connection:Disconnect()
            end
        end)
        
        local jumpConnection
        jumpConnection = humanoid.StateChanged:Connect(function(oldState, newState)
            if newState == Enum.HumanoidStateType.Jumping then
                animTrack:Stop()
                jumpConnection:Disconnect()
                if connection then
                    connection:Disconnect()
                end
            end
        end)
    end
})

DanceHub3:AddButton({
    Title = "MM2 - رقصة فليكس",
    Description = nil,
    Callback = function()
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character:WaitForChild("Humanoid")
        
        local animation = Instance.new("Animation")
        animation.AnimationId = "rbxassetid://4212458130" -- رقصة فليكس من MM2
        
        local animTrack = humanoid:LoadAnimation(animation)
        animTrack:Play()
        
        local connection
        connection = humanoid.Running:Connect(function(speed)
            if speed > 0 then
                animTrack:Stop()
                connection:Disconnect()
            end
        end)
        
        local jumpConnection
        jumpConnection = humanoid.StateChanged:Connect(function(oldState, newState)
            if newState == Enum.HumanoidStateType.Jumping then
                animTrack:Stop()
                jumpConnection:Disconnect()
                if connection then
                    connection:Disconnect()
                end
            end
        end)
    end
})

DanceHub3:AddButton({
    Title = "MM2 - رقصة الدوران",
    Description = nil,
    Callback = function()
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character:WaitForChild("Humanoid")
        
        local animation = Instance.new("Animation")
        animation.AnimationId = "rbxassetid://4212453130" -- رقصة الدوران من MM2
        
        local animTrack = humanoid:LoadAnimation(animation)
        animTrack:Play()
        
        local connection
        connection = humanoid.Running:Connect(function(speed)
            if speed > 0 then
                animTrack:Stop()
                connection:Disconnect()
            end
        end)
        
        local jumpConnection
        jumpConnection = humanoid.StateChanged:Connect(function(oldState, newState)
            if newState == Enum.HumanoidStateType.Jumping then
                animTrack:Stop()
                jumpConnection:Disconnect()
                if connection then
                    connection:Disconnect()
                end
            end
        end)
    end
})

DanceHub3:AddButton({
    Title = "MM2 - رقصة علم",
    Description = nil,
    Callback = function()
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character:WaitForChild("Humanoid")
        
        local animation = Instance.new("Animation")
        animation.AnimationId = "rbxassetid://4212451974" -- رقصة علم من MM2
        
        local animTrack = humanoid:LoadAnimation(animation)
        animTrack:Play()
        
        local connection
        connection = humanoid.Running:Connect(function(speed)
            if speed > 0 then
                animTrack:Stop()
                connection:Disconnect()
            end
        end)
        
        local jumpConnection
        jumpConnection = humanoid.StateChanged:Connect(function(oldState, newState)
            if newState == Enum.HumanoidStateType.Jumping then
                animTrack:Stop()
                jumpConnection:Disconnect()
                if connection then
                    connection:Disconnect()
                end
            end
        end)
    end
})
