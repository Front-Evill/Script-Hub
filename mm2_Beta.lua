local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")

local Player = Players.LocalPlayer
local RenderStepped = RunService.RenderStepped
local Heartbeat = RunService.Heartbeat

-- تعاريف و فنش

--تعرف سكربت طيران 
local flyScript = loadstring(game:HttpGet("https://raw.githubusercontent.com/PROG-404/front-script/refs/heads/main/Source.lua"))()

-- استدعاء مكتبه ريدز الخرا 
local redzlib = loadstring(game:HttpGet("https://raw.githubusercontent.com/realredz/RedzLibV5/refs/heads/main/Source.lua"))()

local window = redzlib:MakeWindow({
    Name = "Script Mm2",
    SubTitle = "by Front_9",
    SaveFolder = "MM2Script",
    icon = "rbxassetid://10709752906"
})

--قسم ديسكورد

local discordTab = window:MakeTab({
    Title = "acount fruit",
    Icon = "rbxassetid://10709752906"
})

discordTab:AddSection({
    Name = "Discord"
})


discordTab:AddDiscordInvite({
    Name = "Join Our Community", -- نص الدعوة
    Logo = "rbxassetid://10709752906",
    Invite = "https://discord.gg/vr7", -- رابط الدعوة الخاص بك
    Desc = "Click to join our Discord server!" -- وصف صغير
})

discordTab:AddSection({
    Name = "guns.lol"
})


discordTab:AddDiscordInvite({
    Name = "Join Our Community", -- نص الدعوة
    Logo = "rbxassetid://10709769508",
    Invite = "https://guns.lol/front_evill" -- رابط الدعوة الخاص بك
})
--نهايه

-- قسم رئيسي
local mainTab = window:MakeTab({
    Title = "Main",
    Icon = "rbxassetid://10709752906"
})

mainTab:AddButton({
    Name = "Activate Flight",
    Desc = "Click to enable flight",
    Callback = function()
        flyScript() -- تنفيذ سكربت الطيران
        print("Flight script activated!")
    end
})

-- قسم لاعبين
local playerTab = window:MakeTab({
    Title = "Player", -- اسم التبويب
    Icon = "rbxassetid://10709752906" 
})


playerTab:AddSection({
    Name = "jump & speed"
})

playerTab:AddToggle({
    Name = "High Jump", -- اسم التبديل
    Default = false, -- القيمة الافتراضية (غير مفعل)
    Flag = "highJumpToggle", -- معرف التبديل
    Callback = function(Value)
        if Value then
            -- تفعيل القفز العالي
            game.Players.LocalPlayer.Character.Humanoid.JumpHeight = 100 -- يمكنك تغيير القيمة
            print("High Jump enabled!")
        else
            -- إعادة القفز إلى القيمة الافتراضية
            game.Players.LocalPlayer.Character.Humanoid.JumpHeight = 50 -- القيمة الافتراضية
            print("High Jump disabled!")
        end
    end
})

playerTab:AddToggle({
    Name = "Speed Boost", -- اسم التبديل
    Default = false, -- القيمة الافتراضية (غير مفعل)
    Flag = "speedBoostToggle", -- معرف التبديل
    Callback = function(Value)
        if Value then
            -- تفعيل السرعة العالية
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 100 -- يمكنك تغيير القيمة
            print("Speed Boost enabled!")
        else
            -- إعادة السرعة إلى القيمة الافتراضية
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16 -- القيمة الافتراضية
            print("Speed Boost disabled!")
        end
    end
})

local infiniteJumpEnabled = false

playerTab:AddToggle({
    Name = "Infinite Jump",
    Default = false,
    Flag = "infiniteJumpToggle",
    Callback = function(Value)
        infiniteJumpEnabled = Value
        if Value then
            print("Infinite Jump enabled!")
        else
            print("Infinite Jump disabled!")
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


playerTab:AddSection({
    Name = "moodess"
})

local invisibilityEnabled = false
playerTab:AddToggle({
    Name = "Invisibility",
    Default = false,
    Flag = "invisibilityToggle",
    Callback = function(Value)
        invisibilityEnabled = Value
        if Value then
            -- تفعيل الإخفاء
            for _, part in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.Transparency = 1 -- جعل الأجزاء شفافة
                end
            end
            print("Invisibility enabled!")
       else
            -- إعادة الظهور
            for _, part in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.Transparency = 0 -- إعادة الأجزاء إلى حالتها الأصلية
                end
            end
            print("Invisibility disabled!")
        end
    end
})

playerTab:AddSection({
    Name = "copy ..."
})

local playerList = {}
local dropdown = playerTab:AddDropdown({
    Name = "Select Player",
    Options = playerList,
    Default = "None",
    Flag = "playerDropdown",
    Callback = function(Value)
        print("Selected Player: " .. Value)
    end
})

local function updatePlayerList()
    playerList = {}
    for _, player in pairs(game.Players:GetPlayers()) do
        if player ~= game.Players.LocalPlayer then
            table.insert(playerList, player.Name)
        end
    end
    dropdown:UpdateOptions(playerList) -- تحديث القائمة
end

-- تحديث القائمة كل 5 ثواني
spawn(function()
    while true do
        updatePlayerList()
        wait(5)
    end
end)

playerTab:AddButton({
    Name = "Copy Player Skin",
    Desc = "Copy the selected player's skin",
    Callback = function()
        local selectedPlayerName = redzlib:GetFlag("playerDropdown")
        local selectedPlayer = game.Players:FindFirstChild(selectedPlayerName)
        
        if selectedPlayer and selectedPlayer.Character then
            -- حذف السكن الحالي للاعب
            for _, part in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                if part:IsA("BasePart") or part:IsA("Decal") then
                    part:Destroy()
                end
            end
                for _, part in pairs(selectedPlayer.Character:GetDescendants()) do
                if part:IsA("BasePart") or part:IsA("Decal") then
                    local clone = part:Clone()
                    clone.Parent = game.Players.LocalPlayer.Character
                end
            end

            print("Copied skin of: " .. selectedPlayerName)
        else
            print("Player not found or has no character!")
        end
    end
})
-- قسم تنقل

-- قسم اعدادات 


-- قسم الإعدادات
local settingsTab = window:MakeTab({
    Title = "seting",
    Icon = "rbxassetid://10709752906"
})

-- إضافة سكشن السيرفرات
settingsTab:AddSection({
    Name = "servers"
})

-- زر الانتقال إلى سيرفر جديد
settingsTab:AddButton({
    Name = "new server",
    Callback = function()
        local TeleportService = game:GetService("TeleportService")
        local placeId = game.PlaceId
        
        local servers = {}
        local req = HttpService:JSONDecode(game:HttpGetAsync("https://games.roblox.com/v1/games/" .. placeId .. "/servers/Public?sortOrder=Asc&limit=100"))
        
        for _, server in pairs(req.data) do
            if server.playing < server.maxPlayers and server.id ~= game.JobId then
                table.insert(servers, server.id)
            end
        end
        
        if #servers > 0 then
            TeleportService:TeleportToPlaceInstance(placeId, servers[math.random(1, #servers)])
        else
            TeleportService:Teleport(placeId)
        end
    end
})

-- زر إعادة الاتصال بنفس السيرفر
settingsTab:AddButton({
    Name = "rejoin",
    Callback = function()
        local TeleportService = game:GetService("TeleportService")
        TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId)
    end
})

local function SaveSettings()
    local settings = {
        flight = redzlib:GetFlag("flightToggle")
    }
    
    print("Settings saved:", settings)
end

-- قسم الـ Tween
settingsTab:AddSection({
    Name = "Tween"
})

-- إضافة وحدة الكاش للتخزين المؤقت
local Cached = {
    Humanoids = {}
}

-- دالة للحصول على Humanoid من الشخصية
local function GetCharacterHumanoid(Character)
    return Character:FindFirstChildOfClass("Humanoid")
end

-- دالة محدثة للتحقق من حياة الشخصية
local function IsAlive(Character)
    if Character then
        local Humanoids = Cached.Humanoids
        local Humanoid = Humanoids[Character] or GetCharacterHumanoid(Character)
        
        if Humanoid then
            if not Humanoids[Character] then
                Humanoids[Character] = Humanoid
            end
            return Humanoid[Humanoid.ClassName == "Humanoid" and "Health" or "Value"] > 0
        end
    end
    return false
end

-- دالة لتفعيل نظام الحركة
local function EnableMovementSystem(Character)
    if not IsAlive(Character) then
        print("الشخصية غير موجودة أو ميتة")
        return false
    end
    
    -- إعداد BodyVelocity
    local bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    bodyVelocity.Velocity = Vector3.new(0, 0, 0)
    bodyVelocity.P = 9000
    bodyVelocity.Parent = Character.HumanoidRootPart
    
    -- حفظ مرجع للـ BodyVelocity
    Tween.BodyVelocity = bodyVelocity
    
    -- إعداد NoClip
    BaseParts = Character:GetChildren()
    CanCollideObjects = {}
    
    for i = 1, #BaseParts do
        local BasePart = BaseParts[i]
        if BasePart:IsA("BasePart") then
            CanCollideObjects[BasePart] = BasePart.CanCollide
        end
    end
    
    -- تحديث دالة NoClipOnStepped
    function Tween:NoClipOnStepped(Character)
        if not IsAlive(Character) then
            return nil
        end
        if _ENV.OnFarm then
            for i = 1, #BaseParts do
                local BasePart = BaseParts[i]
                if CanCollideObjects[BasePart] and BasePart.CanCollide then
                    BasePart.CanCollide = false
                end
            end
        end
    end
    
    -- ربط الـ NoClip بدورة التشغيل
    RunService:BindToRenderStep("NoClip", 2000, function()
        Tween:NoClipOnStepped(Character)
    end)
    
    print("تم تفعيل نظام الحركة")
    return true
end

-- دالة لإيقاف نظام الحركة
local function DisableMovementSystem()
    if Tween.BodyVelocity then
        Tween.BodyVelocity:Destroy()
    end
    
    -- إلغاء ربط NoClip
    RunService:UnbindFromRenderStep("NoClip")
    
    -- إعادة ضبط CanCollide
    if BaseParts and CanCollideObjects then
        for i = 1, #BaseParts do
            local BasePart = BaseParts[i]
            if CanCollideObjects[BasePart] ~= nil then
                BasePart.CanCollide = CanCollideObjects[BasePart]
            end
        end
    end
    
    print("تم إلغاء تفعيل نظام الحركة")
    return true
end

-- تفعيل نظام الحركة تلقائياً عند بدء السكريبت
_ENV.OnFarm = true
local Character = game.Players.LocalPlayer.Character
if Character then
    EnableMovementSystem(Character)
else
    game.Players.LocalPlayer.CharacterAdded:Connect(function(NewCharacter)
        EnableMovementSystem(NewCharacter)
    end)
end

-- زر توجل لتفعيل/إيقاف نظام الحركة
settingsTab:AddToggle({
    Name = "system Tween",
    Default = true,  -- مفعل افتراضياً
    Flag = "tweenMovement",
    Callback = function(Value)
        _ENV.OnFarm = Value
        
        if Value then
            local Character = game.Players.LocalPlayer.Character
            EnableMovementSystem(Character)
        else
            DisableMovementSystem()
        end
    end
})


spawn(function()
    while wait(60) do
        SaveSettings()
    end
end)


game:GetService("CoreGui").ChildRemoved:Connect(function(child)
    if child.Name == "Script Mm2" then
        SaveSettings()
        print("Script closed")
    end
end)
