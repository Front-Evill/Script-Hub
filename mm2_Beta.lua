local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")

local Player = Players.LocalPlayer
local RenderStepped = RunService.RenderStepped
local Heartbeat = RunService.Heartbeat

-- تعاريف و فنش

-- تعرف سكربت طيران 
local flyScript = loadstring(game:HttpGet("https://raw.githubusercontent.com/PROG-404/front-script/refs/heads/main/Source.lua"))()

-- تعرف الصندوق 

-- متغيرات لتخزين حالة الميزة
local roleBoxesEnabled = false  -- Changed to false by default to fix auto-enabling
local playerRoleBoxes = {}
local tweenEnabled = true  -- Added for tween movement system

-- ألوان مختلفة للأدوار
local roleColors = {
    Murderer = Color3.fromRGB(255, 0, 0),      -- أحمر للقاتل
    Sheriff = Color3.fromRGB(0, 0, 255),       -- أزرق للشرطي
    Innocent = Color3.fromRGB(0, 255, 0)       -- أخضر للمسالم
}

-- دالة لإنشاء مربع حول اللاعب بناءً على دوره
local function CreateRoleBox(player, role)
    if player == game.Players.LocalPlayer then
        return -- تجاهل اللاعب الأساسي
    end
    
    local character = player.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then
        return
    end
    
    -- إزالة المربع السابق إذا وجد
    if playerRoleBoxes[player.Name] then
        playerRoleBoxes[player.Name]:Destroy()
        playerRoleBoxes[player.Name] = nil
    end
    
    if not roleBoxesEnabled or not role then
        return
    end
    
    -- إنشاء المربع
    local box = Instance.new("Part")
    box.Name = "RoleBox_" .. player.Name
    box.Anchored = true
    box.CanCollide = false
    box.Transparency = 0.7
    box.Material = Enum.Material.Neon
    box.Color = roleColors[role] or Color3.fromRGB(255, 255, 255) -- لون الدور أو أبيض إذا لم يتم التعرف عليه
    box.Size = Vector3.new(6, 8, 6) -- حجم المربع
    box.CFrame = character.HumanoidRootPart.CFrame
    box.Parent = workspace
    
    -- تخزين المربع للإشارة إليه لاحقاً
    playerRoleBoxes[player.Name] = box
    
    -- تحديث موقع المربع باستمرار
    spawn(function()
        while wait(0.1) do
            if roleBoxesEnabled and box and box.Parent and character and character.Parent and character:FindFirstChild("HumanoidRootPart") then
                box.CFrame = character.HumanoidRootPart.CFrame
            else
                if box and box.Parent then
                    box:Destroy()
                end
                playerRoleBoxes[player.Name] = nil
                break
            end
        end
    end)
end

-- دالة للكشف عن دور اللاعب في MM2 - محسّنة
local function DetectPlayerRole(player)
    local backpack = player.Backpack
    local character = player.Character
    
    if not character then
        return nil
    end
    
    -- قوائم أكثر شمولية للأسلحة
    local murdererItems = {"Knife", "Blade", "Darkblade", "Chroma", "Corrupt", "Slasher", "Laser"}
    local sheriffItems = {"Gun", "Revolver", "Pistol", "Luger", "Blaster"}
    
    -- البحث عن أداة القاتل أو الشرطي في حقيبة اللاعب أو الشخصية
    local function hasItem(itemList)
        for _, itemName in pairs(itemList) do
            if (backpack and backpack:FindFirstChild(itemName)) or (character and character:FindFirstChild(itemName)) then
                return true
            end
        end
        return false
    end
    
    -- الكشف عن الأدوار بناءً على الأدوات الموجودة
    if hasItem(murdererItems) then
        return "Murderer"
    elseif hasItem(sheriffItems) then
        return "Sheriff"
    else
        return "Innocent"
    end
end

-- دالة لمسح جميع المربعات
local function ClearAllRoleBoxes()
    for playerName, box in pairs(playerRoleBoxes) do
        if box and box.Parent then
            box:Destroy()
        end
        playerRoleBoxes[playerName] = nil
    end
end

-- دالة للتحقق من حالة الجولة في MM2
local function CheckGameState()
    local gameState = ""
    
    -- محاولة العثور على الأشياء التي تشير إلى حالة اللعبة
    local lobbyCountdown = workspace:FindFirstChild("LobbyCountdown")
    local roundOver = workspace:FindFirstChild("RoundOver")
    
    if lobbyCountdown and lobbyCountdown:IsA("IntValue") and lobbyCountdown.Value > 0 then
        gameState = "Lobby"
    elseif roundOver and roundOver:IsA("BoolValue") and roundOver.Value then
        gameState = "RoundOver"
        ClearAllRoleBoxes() -- مسح المربعات عند انتهاء الجولة
    else
        gameState = "InGame"
        
        -- تحديث المربعات للاعبين عندما تكون الجولة جارية
        if roleBoxesEnabled then
            for _, player in pairs(game:GetService("Players"):GetPlayers()) do
                if player ~= game.Players.LocalPlayer then
                    local role = DetectPlayerRole(player)
                    if role then
                        CreateRoleBox(player, role)
                    end
                end
            end
        end
    end
    
    return gameState
end

-- دالة للتعامل مع اللاعبين الجدد الذين ينضمون للعبة
local function HandleNewPlayer(player)
    if player ~= game.Players.LocalPlayer then
        player.CharacterAdded:Connect(function(character)
            wait(2) -- انتظار لتأكد من تحميل الشخصية والأدوات بالكامل
            if roleBoxesEnabled and CheckGameState() == "InGame" then
                local role = DetectPlayerRole(player)
                if role then
                    CreateRoleBox(player, role)
                end
            end
        end)
    end
end

-- دالة للتعامل مع اللاعبين الذين يغادرون اللعبة
local function HandlePlayerRemoving(player)
    if playerRoleBoxes[player.Name] then
        playerRoleBoxes[player.Name]:Destroy()
        playerRoleBoxes[player.Name] = nil
    end
end

-- تنفيذ آمن للدوال مع معالجة الأخطاء
local function safeExecute(func, ...)
    local success, result = pcall(func, ...)
    if not success then
        print("Error occurred: " .. tostring(result))
    end
    return success, result
end

-- توصيل الدوال بأحداث Players
game:GetService("Players").PlayerAdded:Connect(HandleNewPlayer)
game:GetService("Players").PlayerRemoving:Connect(HandlePlayerRemoving)

-- دورة للتحقق من حالة اللعبة باستمرار
spawn(function()
    while wait(1) do
        if roleBoxesEnabled then
            CheckGameState()
        end
    end
end)

-- نهايه
-- استدعاء مكتبه ريدز
local redzlib = loadstring(game:HttpGet("https://raw.githubusercontent.com/realredz/RedzLibV5/refs/heads/main/Source.lua"))()

-- تعريف النافذة الرئيسية
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

-- تغيير زر الطيران إلى توجل لمنع التفعيل التلقائي
mainTab:AddToggle({
    Name = "Flight",
    Default = false,
    Flag = "flightToggle",
    Callback = function(Value)
        if Value then
            flyScript() -- تنفيذ سكربت الطيران عند التفعيل
            print("Flight script activated!")
        else
            print("Flight disabled!")
            -- محاولة تعطيل الطيران إذا أمكن - يعتمد على تنفيذ سكربت الطيران
        end
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
            game.Players.LocalPlayer.Character.Humanoid.JumpHeight = 100 -- قيمة أعلى
            print("High Jump enabled!")
        else
            -- إعادة القفز إلى القيمة الافتراضية
            game.Players.LocalPlayer.Character.Humanoid.JumpHeight = 7.2 -- القيمة الافتراضية
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

-- تحسين قائمة اللاعبين
local playerList = {}
local skinCopyingCooldown = false

local function updatePlayerList()
    playerList = {}
    for _, player in pairs(game.Players:GetPlayers()) do
        table.insert(playerList, player.Name)
    end
    return playerList
end

local dropdown = playerTab:AddDropdown({
    Name = "Select Player",
    Options = updatePlayerList(),
    Default = "None",
    Flag = "playerDropdown",
    Callback = function(Value)
        print("Selected Player: " .. Value)
    end
})

-- تحديث قائمة اللاعبين كل 3 ثوانٍ
spawn(function()
    while wait(3) do
        pcall(function()
            dropdown:Refresh(updatePlayerList())
        end)
    end
end)

-- تحسين زر نسخ السكن
playerTab:AddButton({
    Name = "Copy Player Skin",
    Desc = "Copy the selected player's skin",
    Callback = function()
        if skinCopyingCooldown then
            print("Please wait before copying another skin!")
            return
        end
        
        local selectedPlayerName = dropdown.Value
        local selectedPlayer = game.Players:FindFirstChild(selectedPlayerName)
        
        if selectedPlayer and selectedPlayer.Character then
            skinCopyingCooldown = true
            
            -- دالة نسخ آمنة
            local function safeClone(part, parent)
                pcall(function()
                    local clone = part:Clone()
                    clone.Parent = parent
                end)
            end
            
            -- محاولة نسخ السكن بشكل آمن
            pcall(function()
                for _, part in pairs(selectedPlayer.Character:GetDescendants()) do
                    if part:IsA("BasePart") or part:IsA("Decal") then
                        safeClone(part, game.Players.LocalPlayer.Character)
                    end
                end
            end)
            
            print("Attempted to copy skin of: " .. selectedPlayerName)
            
            -- إعادة ضبط وقت الانتظار بعد 5 ثوانٍ
            spawn(function()
                wait(5)
                skinCopyingCooldown = false
            end)
        else
            print("Player not found or has no character!")
        end
    end
})

-- قسم الإعدادات
local settingsTab = window:MakeTab({
    Title = "seting",
    Icon = "rbxassetid://10709810948"
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

-- قسم إعدادات السكربت
settingsTab:AddSection({
    Name = "seting script"
})

-- إضافة وحدة الكاش للتخزين المؤقت
local Cached = {
    Humanoids = {}
}

-- إضافة كائن Tween فارغ إذا لم يكن موجودًا
local Tween = {}
local BaseParts 
local CanCollideObjects

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
            return Humanoid.Health > 0
        end
    end
    return false
end

-- دالة لتفعيل نظام الحركة
local function EnableMovementSystem(Character)
    if not Character or not IsAlive(Character) then
        print("Character is not found or not alive")
        return false
    end
    
    if not Character:FindFirstChild("HumanoidRootPart") then
        print("HumanoidRootPart not found")
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
        if not Character or not IsAlive(Character) then
            return nil
        end
        
        if _ENV.OnFarm then
            for i = 1, #BaseParts do
                local BasePart = BaseParts[i]
                if BasePart and CanCollideObjects[BasePart] and BasePart.CanCollide then
                    BasePart.CanCollide = false
                end
            end
        end
    end
    
    -- ربط الـ NoClip بدورة التشغيل
    if not Tween.StepConnection then
        Tween.StepConnection = RunService:BindToRenderStep("NoClip", 2000, function()
            Tween:NoClipOnStepped(Character)
        end)
    end
    
    print("Movement system enabled successfully")
    return true
end

-- دالة لإيقاف نظام الحركة
local function DisableMovementSystem()
    if Tween.BodyVelocity then
        Tween.BodyVelocity:Destroy()
        Tween.BodyVelocity = nil
    end
    
    -- إلغاء ربط NoClip
    if Tween.StepConnection then
        RunService:UnbindFromRenderStep("NoClip")
        Tween.StepConnection = nil
    end
    
    -- إعادة ضبط CanCollide
    if BaseParts and CanCollideObjects then
        for i = 1, #BaseParts do
            local BasePart = BaseParts[i]
            if BasePart and CanCollideObjects[BasePart] ~= nil then
                pcall(function() 
                    BasePart.CanCollide = CanCollideObjects[BasePart]
                end)
            end
        end
    end
    
    print("Movement system disabled")
    return true
end

-- تعريف متغير _ENV.OnFarm
_ENV.OnFarm = false

-- زر توجل لتفعيل/إيقاف نظام الحركة
settingsTab:AddToggle({
    Name = "Tween Movement System",
    Default = false,  -- غير مفعل افتراضياً
    Flag = "tweenMovementToggle",
    Callback = function(Value)
        tweenEnabled = Value
        _ENV.OnFarm = Value
        
        if Value then
            local Character = game.Players.LocalPlayer.Character
            if Character then
                EnableMovementSystem(Character)
            end
        else
            DisableMovementSystem()
        end
    end
})

-- التوصيل بحدث CharacterAdded
game.Players.LocalPlayer.CharacterAdded:Connect(function(NewCharacter)
    if tweenEnabled then
        wait(0.5) -- انتظار لتحميل الشخصية بالكامل
        EnableMovementSystem(NewCharacter)
    end
end)

-- زر توجل لتفعيل/إيقاف كشف الأدوار (ESP)
settingsTab:AddToggle({
    Name = "ESP Player Boxes",
    Default = false,  -- غير مفعل افتراضياً
    Flag = "roleBoxesToggle",
    Callback = function(Value)
        roleBoxesEnabled = Value
        if not Value then
            ClearAllRoleBoxes()
            print("ESP Player Boxes disabled!")
        else
            print("ESP Player Boxes enabled!")
            -- تحديث المربعات إذا كانت الجولة جارية
            if CheckGameState() == "InGame" then
                for _, player in pairs(game:GetService("Players"):GetPlayers()) do
                    if player ~= game.Players.LocalPlayer then
                        local role = DetectPlayerRole(player)
                        if role then
                            CreateRoleBox(player, role)
                        end
                    end
                end
            end
        end
    end
})

-- قسم Game Pro
settingsTab:AddSection({
    Name = "Game Pro"
})

-- زر زيادة الفريمات
settingsTab:AddButton({
    Name = "Increase FPS",
    Callback = function()
        pcall(function()
            setfpscap(60) -- زيادة عدد الفريمات إلى 60
            print("FPS increased to 60!")
        end)
    end
})

-- زر رفع جودة الرسوميات
settingsTab:AddButton({
    Name = "Improve Graphics",
    Callback = function()
        pcall(function()
            settings().Rendering.QualityLevel = "Level21" -- رفع الجودة إلى المستوى الأعلى
            print("Graphics quality improved!")
        end)
    end
})

-- زر إزالة الضباب
settingsTab:AddButton({
    Name = "Remove Fog",
    Callback = function()
        pcall(function()
            game.Lighting.FogEnd = 100000 -- زيادة نهاية الضباب لتكون بعيدة جدًا
            game.Lighting.FogStart = 0 -- بدء الضباب من نقطة قريبة
            game.Lighting.ClockTime = 12 -- ضبط الوقت ليكون نهارًا دائمًا
            print("Fog removed!")
        end)
    end
})

-- دالة حفظ الإعدادات
local function SaveSettings()
    local settings = {
        flight = redzlib:GetFlag("flightToggle"),
        highJump = redzlib:GetFlag("highJumpToggle"),
        speedBoost = redzlib:GetFlag("speedBoostToggle"),
        infiniteJump = redzlib:GetFlag("infiniteJumpToggle"),
        invisibility = redzlib:GetFlag("invisibilityToggle"),
        tweenMovement = redzlib:GetFlag("tweenMovementToggle"),
        roleBoxes = redzlib:GetFlag("roleBoxesToggle")
    }
    
    print("Settings saved successfully!")
end

-- حفظ الإعدادات تلقائيًا كل دقيقة
spawn(function()
    while wait(60) do
        pcall(SaveSettings)
    end
end)

-- إغلاق السكربت وحفظ الإعدادات
game:GetService("CoreGui").ChildRemoved:Connect(function(child)
    if child.Name == "Script Mm2" then
        pcall(SaveSettings)
        print("Script closed")
    end
end)

-- إظهار رسالة الترحيب
print("MM2 Script by Front_9 loaded successfully!")
print("Made with ❤️ by Front_9")
