local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")

local Player = Players.LocalPlayer
local RenderStepped = RunService.RenderStepped
local Heartbeat = RunService.Heartbeat

-- Initialize required variables
local playerRoleBoxes = {}
local roleBoxesEnabled = false
local targetedPlayers = {}

--فنشكن

local roleColors = {
    Murderer = Color3.fromRGB(255, 0, 0),      -- أحمر للقاتل
    Sheriff = Color3.fromRGB(0, 0, 255),       -- أزرق للشرطي
    Innocent = Color3.fromRGB(0, 255, 0)       -- أخضر للمسالم
}

-- دالة التحقق من حالة اللعبة
local function CheckGameState()
    -- بسيطة للتحقق من حالة اللعبة
    return "InGame" -- افتراضيًا سنفترض أن اللعبة جارية
end

-- Function to automatically detect player roles
local function AutoDetectPlayerRoles()
    if not roleBoxesEnabled then return end
    
    for _, player in pairs(game:GetService("Players"):GetPlayers()) do
        if player ~= game.Players.LocalPlayer then
            local role = DetectPlayerRole(player)
            if role then
                CreateRoleBox(player, role)
            end
        end
    end
end

local function ClearAllRoleBoxes()
    for playerName, boxInfo in pairs(playerRoleBoxes) do
        if boxInfo.box and boxInfo.box.Parent then
            boxInfo.box:Destroy()
        end
        if boxInfo.label and boxInfo.label.Parent then
            boxInfo.label:Destroy()
        end
    end
    playerRoleBoxes = {}
end

-- دالة حفظ الإعدادات
local function SaveSettings()
    -- حفظ الإعدادات في ملف أو في data store
    print("Settings saved!")
end

-- Improved DetectPlayerRole function with more comprehensive detection
local function DetectPlayerRole(player)
    local backpack = player.Backpack
    local character = player.Character
    
    if not character then
        return nil
    end
    
    -- More comprehensive weapon lists
    local murdererItems = {"Knife", "Blade", "Darkblade", "Chroma", "Corrupt", "Slasher", "Laser", "Dagger", "Claw", "Scythe", "Sickle"}
    local sheriffItems = {"Gun", "Revolver", "Pistol", "Luger", "Blaster", "Deagle", "Sheriff", "Glock", "Handgun"}
    
    -- Check both character and backpack for items
    local function checkForItems(container, itemList)
        if not container then return false end
        
        for _, item in pairs(container:GetChildren()) do
            for _, itemName in pairs(itemList) do
                if string.find(string.lower(item.Name), string.lower(itemName)) then
                    return true
                end
            end
        end
        return false
    end
    
    -- Check for murder weapons in character or backpack
    if checkForItems(character, murdererItems) or checkForItems(backpack, murdererItems) then
        return "Murderer"
    end
    
    -- Check for sheriff weapons in character or backpack
    if checkForItems(character, sheriffItems) or checkForItems(backpack, sheriffItems) then
        return "Sheriff"
    end
    
    return "Innocent"
end

-- Improved ESP function to work better with role detection
local function CreateRoleBox(player, role)
    if player == game.Players.LocalPlayer then
        return -- Ignore local player
    end
    
    local character = player.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then
        return
    end
    
    -- Remove previous box if exists
    if playerRoleBoxes[player.Name] then
        if playerRoleBoxes[player.Name].box and playerRoleBoxes[player.Name].box.Parent then
            playerRoleBoxes[player.Name].box:Destroy()
        end
        if playerRoleBoxes[player.Name].label and playerRoleBoxes[player.Name].label.Parent then
            playerRoleBoxes[player.Name].label:Destroy()
        end
        playerRoleBoxes[player.Name] = nil
    end
    
    if not roleBoxesEnabled or not role then
        return
    end
    
    -- Get character size
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    
    if not humanoid or not rootPart then
        return
    end
    
    -- Create ESP box
    local box = Instance.new("BoxHandleAdornment")
    box.Name = "RoleBox_" .. player.Name
    box.Adornee = rootPart
    box.AlwaysOnTop = true
    box.ZIndex = 10
    box.Transparency = 0.5
    box.Color3 = roleColors[role] or Color3.fromRGB(255, 255, 255)
    
    -- Calculate box size to fit character
    local characterSize = character:GetExtentsSize()
    box.Size = characterSize * 1.05
    box.Parent = rootPart
    
    -- Add player name and role label
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "PlayerLabel_" .. player.Name
    billboard.Adornee = rootPart
    billboard.Size = UDim2.new(0, 200, 0, 50)
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.AlwaysOnTop = true
    billboard.Parent = rootPart
    
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, 0, 1, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.TextColor3 = roleColors[role] or Color3.fromRGB(255, 255, 255)
    nameLabel.Text = player.Name .. " [" .. role .. "]"
    nameLabel.TextSize = 14
    nameLabel.Font = Enum.Font.SourceSansBold
    nameLabel.TextStrokeTransparency = 0.5
    nameLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    nameLabel.Parent = billboard
    
    -- Store box and label for later reference
    playerRoleBoxes[player.Name] = {
        box = box,
        label = billboard
    }
    
    -- Ensure box visibility through walls with continuous updates
    spawn(function()
        while wait(0.1) do
            if roleBoxesEnabled and box and box.Parent and character and character.Parent then
                -- Check distance and adjust transparency
                local distance = (rootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                local transparency = math.clamp(distance / 100, 0.3, 0.8)
                box.Transparency = transparency
                
                -- Update box size if character size changes
                local newSize = character:GetExtentsSize()
                box.Size = newSize * 1.05
            else
                if playerRoleBoxes[player.Name] then
                    if playerRoleBoxes[player.Name].box and playerRoleBoxes[player.Name].box.Parent then
                        playerRoleBoxes[player.Name].box:Destroy()
                    end
                    if playerRoleBoxes[player.Name].label and playerRoleBoxes[player.Name].label.Parent then
                        playerRoleBoxes[player.Name].label:Destroy()
                    end
                    playerRoleBoxes[player.Name] = nil
                end
                break
            end
        end
    end)
end

-- دالة القضاء على لاعب محدد
local function EliminatePlayer(playerName)
    if targetedPlayers[playerName] then
        return false -- تم استهداف اللاعب بالفعل
    end

    if TeleportToPlayer(playerName) then
        -- تحديد اللاعب كمستهدف
        targetedPlayers[playerName] = true

        -- التحقق من تجهيز أداة القتل
        local localPlayer = game.Players.LocalPlayer
        local character = localPlayer.Character
        local backpack = localPlayer.Backpack

        local hasMurderWeapon = false
        local murdererItems = {"Knife", "Blade", "Darkblade", "Chroma", "Corrupt", "Slasher", "Laser"}

        -- محاولة تجهيز سلاح القتل إذا لم يكن مجهزاً بالفعل
        for _, itemName in pairs(murdererItems) do
            if character and character:FindFirstChild(itemName) then
                hasMurderWeapon = true
                break
            elseif backpack and backpack:FindFirstChild(itemName) then
                backpack:FindFirstChild(itemName).Parent = character
                hasMurderWeapon = true
                break
            end
        end

        if hasMurderWeapon then
            -- محاكاة الهجوم
            local virtualInputManager = game:GetService("VirtualInputManager")
            virtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 1)
            wait(0.1)
            virtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 1)

            return true
        end
    end
    return false
end

-- دالة القضاء على جميع اللاعبين
local function EliminateAllPlayers()
    local targetCount = 0
    local successCount = 0

    for _, player in pairs(game.Players:GetPlayers()) do
        if player ~= game.Players.LocalPlayer and not targetedPlayers[player.Name] then
            targetCount = targetCount + 1
            if EliminatePlayer(player.Name) then
                successCount = successCount + 1
                wait(1) -- انتظار بين عمليات القتل لتجنب الكشف
            end
        end
    end

    return targetCount, successCount
end

-- دالة الانتقال إلى لاعب محدد
-- Function to apply character skin
local function applyCharacterSkin(characterId)
    if not isAlive() then 
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Character Skin",
            Text = "You need to be alive to change skins",
            Duration = 3
        })
        return false
    end
    
    local player = game.Players.LocalPlayer
    local character = player.Character
    
    -- Save current position and properties
    local position = character:GetPrimaryPartCFrame()
    local health = character.Humanoid.Health
    local walkSpeed = character.Humanoid.WalkSpeed
    local jumpPower = character.Humanoid.JumpPower
    
    -- Create a new character model
    local newCharacter = game:GetObjects("rbxassetid://" .. characterId)[1]
    if not newCharacter then
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Character Skin",
            Text = "Failed to load character skin",
            Duration = 3
        })
        return false
    end
    
    -- Parent the new character to workspace and set up
    newCharacter.Parent = workspace
    player.Character = newCharacter
    
    -- Setup new character
    newCharacter:SetPrimaryPartCFrame(position)
    newCharacter.Humanoid.Health = health
    newCharacter.Humanoid.WalkSpeed = walkSpeed
    newCharacter.Humanoid.JumpPower = jumpPower
    
    -- Clean up old character
    character:Destroy()
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Character Skin",
        Text = "Character skin applied",
        Duration = 3
    })
    return true
end

-- Run auto detection every few seconds
spawn(function()
    while wait(3) do
        pcall(AutoDetectPlayerRoles)
    end
end)

local redzlib = loadstring(game:HttpGet("https://raw.githubusercontent.com/realredz/RedzLibV5/refs/heads/main/Source.lua"))()

-- تعريف النافذة الرئيسية
local window = redzlib:MakeWindow({
    Name = "Script Mm2",
    SubTitle = "by Front_9",
    SaveFolder = "",
    TIcon = "rbxassetid://73031703958632"  -- استبدل الرقم هنا
})

--قسم ديسكورد
local discordTab = window:MakeTab({
    Title = "acount fruit",
    Icon = "rbxassetid://17079723166"
})

discordTab:AddSection({
    Name = " ... Discord... "
})

discordTab:AddDiscordInvite({
    Name = "Join Our Community", -- نص الدعوة
    Logo = "rbxassetid://10709752906",
    Invite = "https://discord.gg/vr7" -- رابط الدعوة الخاص بك
})

discordTab:AddSection({
    Name = " ...guns.lol... "
})

discordTab:AddDiscordInvite({
    Name = "Join Our Community", -- نص الدعوة
    Logo = "rbxassetid://12089799843",
    Invite = "https://guns.lol/front_evill" -- رابط الدعوة الخاص بك
})
--نهايه

-- قسم رئيسي
local mainTab = window:MakeTab({
    Title = "Main",
    Icon = "rbxassetid://10723407389"
})

mainTab:AddSection({
    Name = " ...fly... "
})

mainTab:AddButton({
    Name = "Activate Flight Script", -- اسم الزر
    Desc = "Click to activate the flight script", -- وصف الزر
    Callback = function()
        -- هنا يتم تنفيذ سكربت الطيران
        loadstring(game:HttpGet("https://raw.githubusercontent.com/PROG-404/front-script/refs/heads/main/Source.lua"))()
        print("Flight script activated!") -- رسالة تأكيد في الكونسول
    end
})

mainTab:AddSection({
    Name = " ...Auto win... "
})

-- Added button instead of toggle for elimination
mainTab:AddButton({
    Name = "Eliminate All Players",
    Desc = "Attempt to eliminate all players in the game",
    Callback = function()
        local targetCount, successCount = EliminateAllPlayers()
        if targetCount == 0 then
            print("No targets found.")
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "Auto Elimination",
                Text = "No targets found.",
                Duration = 3
            })
        else
            print("Attempted to eliminate " .. targetCount .. " players. Successfully eliminated " .. successCount .. " players.")
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "Auto Elimination",
                Text = "Eliminated " .. successCount .. "/" .. targetCount .. " players.",
                Duration = 3
            })
        end
    end
})

mainTab:AddSection({
    Name = " ...ESP... "
})

mainTab:AddToggle({
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
                AutoDetectPlayerRoles()
            end
        end
    end
})

local teleportTab = window:MakeTab({
    Title = "Teleport",
    Icon = "rbxassetid://10709811445"
})

teleportTab:AddSection({
    Name = "teleport"
})

local teleportDropdown = teleportTab:AddDropdown({
    Name = "Select Player",
    Default = "None",
    Options = {"None"}, -- Will be updated with player names
    Callback = function(Value)
        -- Nothing to do here, just storing the selection
    end
})

-- Update player dropdown
spawn(function()
    while wait(5) do
        local playerNames = {"None"}
        for _, player in pairs(game.Players:GetPlayers()) do
            if player ~= game.Players.LocalPlayer then
                table.insert(playerNames, player.Name)
            end
        end
        teleportDropdown:Refresh(playerNames, true)
    end
end)

-- زر للانتقال إلى لاعب معين
teleportTab:AddButton({
    Name = "Teleport to Selected Player",
    Callback = function()
        local selectedPlayerName = teleportDropdown.Value
        if selectedPlayerName and selectedPlayerName ~= "None" then
            if TeleportToPlayer(selectedPlayerName) then
                print("Teleported to: " .. selectedPlayerName)
            else
                print("Failed to teleport to: " .. selectedPlayerName)
            end
        else
            print("Please select a player first")
        end
    end
})

-- زر لالتقاط المسدس المُسقط
teleportTab:AddButton({
    Name = "Pickup Dropped Gun",
    Callback = function()
        if PickupDroppedGun() then
            print("تم التقاط المسدس بنجاح والعودة إلى الموقع الأصلي.")
        else
            print("فشل في التقاط المسدس.")
        end
    end
})

local playerTab = window:MakeTab({
    Title = "Player", -- اسم التبويب
    Icon = "rbxassetid://10747373426" 
})

playerTab:AddSection({
    Name = "jump"
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

-- إضافة توغل لتفعيل زيادة قوة القفز
playerTab:AddToggle({
    Name = "تفعيل قوة القفز العالية",
    Default = false,
    Flag = "jumpPowerEnabled",
    Callback = function(Value)
        local Players = game:GetService("Players")
        local Player = Players.LocalPlayer
        local Character = Player.Character or Player.CharacterAdded:Wait()
        local Humanoid = Character:WaitForChild("Humanoid")
        
        if Value then
            -- تفعيل قوة القفز العالية
            Humanoid.JumpPower = 100 -- قيمة مضاعفة لقوة القفز
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "قوة القفز",
                Text = "تم تفعيل قوة القفز العالية",
                Duration = 3
            })
        else
            -- إعادة قوة القفز للقيمة الطبيعية
            Humanoid.JumpPower = 50 -- القيمة الافتراضية في الروبلوكس
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "قوة القفز",
                Text = "تم إيقاف قوة القفز العالية",
                Duration = 3
            })
        end
    end
})

-- إضافة سلايدر للتحكم في قيمة قوة القفز
playerTab:AddSlider({
    Name = "تعديل قوة القفز",
    Min = 50,
    Max = 250,
    Default = 100,
    Increase = 5,
    Flag = "jumpPowerValue",
    Callback = function(Value)
        local Players = game:GetService("Players")
        local Player = Players.LocalPlayer
        local Character = Player.Character or Player.CharacterAdded:Wait()
        local Humanoid = Character:WaitForChild("Humanoid")
        
        -- التحقق من أن زيادة القفز مفعلة
        if redzlib:GetFlag("jumpPowerEnabled") then
            Humanoid.JumpPower = Value
        end
    end
})

playerTab:AddSection({
    Name = "speed"
})

-- إضافة توغل لتفعيل زيادة السرعة
playerTab:AddToggle({
    Name = "تفعيل السرعة العالية",
    Default = false,
    Flag = "speedEnabled",
    Callback = function(Value)
        local Players = game:GetService("Players")
        local Player = Players.LocalPlayer
        local Character = Player.Character or Player.CharacterAdded:Wait()
        local Humanoid = Character:WaitForChild("Humanoid")
        
        if Value then
            -- تفعيل السرعة العالية
            Humanoid.WalkSpeed = 32 -- قيمة مضاعفة للسرعة
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "السرعة",
                Text = "تم تفعيل السرعة العالية",
                Duration = 3
            })
        else
            -- إعادة السرعة للقيمة الطبيعية
            Humanoid.WalkSpeed = 16 -- القيمة الافتراضية في الروبلوكس
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "السرعة",
                Text = "تم إيقاف السرعة العالية",
                Duration = 3
            })
        end
    end
})

-- إضافة سلايدر للتحكم في قيمة السرعة
playerTab:AddSlider({
    Name = "تعديل السرعة",
    Min = 16,
    Max = 150,
    Default = 32,
    Increase = 2,
    Flag = "speedValue",
    Callback = function(Value)
        local Players = game:GetService("Players")
        local Player = Players.LocalPlayer
        local Character = Player.Character or Player.CharacterAdded:Wait()
        local Humanoid = Character:WaitForChild("Humanoid")
        
        -- التحقق من أن زيادة السرعة مفعلة
        if redzlib:GetFlag("speedEnabled") then
            Humanoid.WalkSpeed = Value
        end
    end
})

-- إضافة زر سرعة فائقة (سرعة مؤقتة عالية جداً)
playerTab:AddButton({
    Name = "سرعة فائقة (مؤقتة)",
    Desc = "يعطي سرعة فائقة لمدة 5 ثوانٍ",
    Callback = function()
        local Players = game:GetService("Players")
        local Player = Players.LocalPlayer
        local Character = Player.Character or Player.CharacterAdded:Wait()
        local Humanoid = Character:WaitForChild("Humanoid")
        
        -- حفظ السرعة الحالية
        local originalSpeed = Humanoid.WalkSpeed
        
        -- تطبيق السرعة الفائقة
        Humanoid.WalkSpeed = 200
        
        -- إشعار
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "سرعة فائقة",
            Text = "تم تفعيل السرعة الفائقة لمدة 5 ثوانٍ",
            Duration = 3
        })
        
        -- انتظار 5 ثوانٍ ثم العودة للسرعة السابقة
        spawn(function()
            wait(5)
            if Character and Character:FindFirstChild("Humanoid") then
                Humanoid.WalkSpeed = originalSpeed
                
                game:GetService("StarterGui"):SetCore("SendNotification", {
                    Title = "سرعة فائقة",
                    Text = "انتهت مدة السرعة الفائقة",
                    Duration = 3
                })
            end
        end)
    end
})

-- إضافة قسم المشيات
playerTab:AddSection({
    Name = "Animations"
})

playerTab:AddButton({
    Name = "Astronaut Animation",
    Callback = function()
        if not isAlive() then 
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "Animation",
                Text = "You need to be alive to use animations",
                Duration = 3
            })
            return 
        end
        
        local Animate = game.Players.LocalPlayer.Character.Animate
        Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=891621366"
        Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=891633237"
        Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=891667138"
        Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=891636393"
        Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=891627522"
        Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=891609353"
        Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=891617961"
        
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Animation",
            Text = "Astronaut Animation applied",
            Duration = 3
        })
    end
})

playerTab:AddButton({
    Name = "Superhero Animation",
    Callback = function()
        if not isAlive() then 
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "Animation",
                Text = "You need to be alive to use animations",
                Duration = 3
            })
            return 
        end
        
        local Animate = game.Players.LocalPlayer.Character.Animate
        Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=616111295"
        Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=616113536"
        Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=616122287"
        Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=616117076"
        Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=616115533"
        Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=616104706"
        Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=616108001"
        
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Animation",
            Text = "Superhero Animation applied",
            Duration = 3
        })
    end
})

-- Add more popular animations
playerTab:AddButton({
    Name = "Zombie Animation",
    Callback = function()
        if not isAlive() then 
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "Animation",
                Text = "You need to be alive to use animations",
                Duration = 3
            })
            return 
        end
        
        local Animate = game.Players.LocalPlayer.Character.Animate
        Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=616158929"
        Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=616160636"
        Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=616168032"
        Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=616163682"
        Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=616161997"
        Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=616156119"
        Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=616157476"
        
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Animation",
            Text = "Zombie Animation applied",
            Duration = 3
        })
    end
})

playerTab:AddButton({
    Name = "Ninja Animation",
    Callback = function()
        if not isAlive() then 
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "Animation",
                Text = "You need to be alive to use animations",
                Duration = 3
            })
            return 
        end
        
        local Animate = game.Players.LocalPlayer.Character.Animate
        Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=656117400"
        Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=656118341"
        Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=656121766"
        Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=656118852"
        Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=656117878"
        Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=656114359"
        Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=656115606"
        
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Animation",
            Text = "Ninja Animation applied",
            Duration = 3
        })
    end
})

playerTab:AddButton({
    Name = "Robot Animation",
    Callback = function()
        if not isAlive() then 
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "Animation",
                Text = "You need to be alive to use animations",
                Duration = 3
            })
            return 
        end
        
        local Animate = game.Players.LocalPlayer.Character.Animate
        Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=616088211"
        Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=616089559"
        Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=616095330"
        Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=616091570"
        Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=616090535"
        Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=616086039"
        Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=616087089"
        
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Animation",
            Text = "Robot Animation applied",
            Duration = 3
        })
    end
})

playerTab:AddButton({
    Name = "Stylish Animation",
    Callback = function()
        if not isAlive() then 
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "Animation",
                Text = "You need to be alive to use animations",
                Duration = 3
            })
            return 
        end
        
        local Animate = game.Players.LocalPlayer.Character.Animate
        Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=616136790"
        Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=616138447"
        Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=616146177"
        Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=616140816"
        Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=616139451"
        Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=616133594"
        Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=616134815"
        
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Animation",
            Text = "Stylish Animation applied",
            Duration = 3
        })
    end
})

-- Add new Character Skins section
playerTab:AddSection({
    Name = "Character Skins"
})

-- Function to apply character skin
local function applyCharacterSkin(characterId)
    if not isAlive() then 
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Character Skin",
            Text = "You need to be alive to change skins",
            Duration = 3
        })
        return false
    end
    
    local player = game.Players.LocalPlayer
    local character = player.Character
    
    -- Save current position and properties
    local position = character:GetPrimaryPartCFrame()
    local health = character.Humanoid.Health
    local walkSpeed = character.Humanoid.WalkSpeed
    local jumpPower = character.Humanoid.JumpPower
    
    -- Create a new character model
    local newCharacter = game:GetObjects("rbxassetid://" .. characterId)[1]
    if not newCharacter then
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Character Skin",
            Text = "Failed to load character skin",
            Duration = 3
        })
        return false
    end
    
    -- Parent the new character to workspace and set up
    newCharacter.Parent = workspace
    player.Character = newCharacter
    
    -- Setup new character
    newCharacter:SetPrimaryPartCFrame(position)
    newCharacter.Humanoid.Health = health
    newCharacter.Humanoid.WalkSpeed = walkSpeed
    newCharacter.Humanoid.JumpPower = jumpPower
    
    -- Clean up old character
    character:Destroy()
    
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Character Skin",
        Text = "Character skin applied",
        Duration = 3
    })
    return true
end

-- Add popular character skins
playerTab:AddButton({
    Name = "Noob Skin",
    Callback = function()
        applyCharacterSkin("1117652448") -- Basic noob character ID
    end
})

playerTab:AddButton({
    Name = "Zombie Skin",
    Callback = function()
        applyCharacterSkin("7560153869") -- Zombie character ID
    end
})

playerTab:AddButton({
    Name = "Slender Skin",
    Callback = function()
        applyCharacterSkin("6772599158") -- Slender character ID
    end
})

playerTab:AddButton({
    Name = "Knight Skin",
    Callback = function()
        applyCharacterSkin("7242526462") -- Knight character ID
    end
})

playerTab:AddButton({
    Name = "Ninja Skin",
    Callback = function()
        applyCharacterSkin("6889073485") -- Ninja character ID
    end
})

playerTab:AddButton({
    Name = "Restore Default Skin",
    Callback = function()
        -- Force respawn to restore default character
        local player = game.Players.LocalPlayer
        local character = player.Character
        if character then
            character:BreakJoints()
        end
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Character Skin",
            Text = "Default skin will be restored on respawn",
            Duration = 3
        })
    end
})

-- Improved ESP function to work better with role detection
local function CreateRoleBox(player, role)
    if player == game.Players.LocalPlayer then
        return -- Ignore local player
    end
    
    local character = player.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then
        return
    end
    
    -- Remove previous box if exists
    if playerRoleBoxes[player.Name] then
        if playerRoleBoxes[player.Name].box and playerRoleBoxes[player.Name].box.Parent then
            playerRoleBoxes[player.Name].box:Destroy()
        end
        if playerRoleBoxes[player.Name].label and playerRoleBoxes[player.Name].label.Parent then
            playerRoleBoxes[player.Name].label:Destroy()
        end
        playerRoleBoxes[player.Name] = nil
    end
    
    if not roleBoxesEnabled or not role then
        return
    end
    
    -- Get character size
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    
    if not humanoid or not rootPart then
        return
    end
    
    -- Create ESP box
    local box = Instance.new("BoxHandleAdornment")
    box.Name = "RoleBox_" .. player.Name
    box.Adornee = rootPart
    box.AlwaysOnTop = true
    box.ZIndex = 10
    box.Transparency = 0.5
    box.Color3 = roleColors[role] or Color3.fromRGB(255, 255, 255)
    
    -- Calculate box size to fit character
    local characterSize = character:GetExtentsSize()
    box.Size = characterSize * 1.05
    box.Parent = rootPart
    
    -- Add player name and role label
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "PlayerLabel_" .. player.Name
    billboard.Adornee = rootPart
    billboard.Size = UDim2.new(0, 200, 0, 50)
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.AlwaysOnTop = true
    billboard.Parent = rootPart
    
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, 0, 1, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.TextColor3 = roleColors[role] or Color3.fromRGB(255, 255, 255)
    nameLabel.Text = player.Name .. " [" .. role .. "]"
    nameLabel.TextSize = 14
    nameLabel.Font = Enum.Font.SourceSansBold
    nameLabel.TextStrokeTransparency = 0.5
    nameLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    nameLabel.Parent = billboard
    
    -- Store box and label for later reference
    playerRoleBoxes[player.Name] = {
        box = box,
        label = billboard
    }
    
    -- Ensure box visibility through walls with continuous updates
    spawn(function()
        while wait(0.1) do
            if roleBoxesEnabled and box and box.Parent and character and character.Parent then
                -- Check distance and adjust transparency
                local distance = (rootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                local transparency = math.clamp(distance / 100, 0.3, 0.8)
                box.Transparency = transparency
                
                -- Update box size if character size changes
                local newSize = character:GetExtentsSize()
                box.Size = newSize * 1.05
            else
                if playerRoleBoxes[player.Name] then
                    if playerRoleBoxes[player.Name].box and playerRoleBoxes[player.Name].box.Parent then
                        playerRoleBoxes[player.Name].box:Destroy()
                    end
                    if playerRoleBoxes[player.Name].label and playerRoleBoxes[player.Name].label.Parent then
                        playerRoleBoxes[player.Name].label:Destroy()
                    end
                    playerRoleBoxes[player.Name] = nil
                end
                break
            end
        end
    end)
end

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

settingsTab:AddButton({
  Name = "Increase FPS",
  Callback = function()
      -- قائمة بالقيم المحتملة لـ FPS
      local fpsOptions = {30, 60, 120, nil} -- nil تعني إزالة الحد
      local currentOption = 1

      -- محاولة تعيين FPS باستخدام الخيارات المتاحة
      while currentOption <= #fpsOptions do
          local targetFPS = fpsOptions[currentOption]
          local success, errorMessage = pcall(function()
              if targetFPS then
                  setfpscap(targetFPS)
                  print("FPS cap set to", targetFPS)
              else
                  setfpscap(nil) -- إزالة الحد
                  print("FPS cap removed.")
              end
          end)

          if success then
              print("FPS increased successfully!")
              return -- الخروج من الدالة عند النجاح
          else
              warn("Failed to set FPS cap to", targetFPS, ":", errorMessage)
              currentOption = currentOption + 1 -- الانتقال إلى الخيار التالي
          end
      end

      -- إذا فشلت جميع المحاولات
      warn("All attempts to increase FPS failed.")
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

-- إضافة زر لتحسين الأداء العام
settingsTab:AddButton({
    Name = "Optimize Performance",
    Callback = function()
        -- تعطيل الظلال
        pcall(function()
            game.Lighting.GlobalShadows = false
            print("Global shadows disabled")
        end)
        
        -- تقليل جودة التفاصيل
        pcall(function()
            settings().Rendering.QualityLevel = 1
            print("Rendering quality reduced")
        end)
        
        -- إزالة الآثار البصرية
        pcall(function()
            for _, v in pairs(game.Lighting:GetChildren()) do
                if v:IsA("BloomEffect") or v:IsA("BlurEffect") or v:IsA("ColorCorrectionEffect") or v:IsA("SunRaysEffect") then
                    v.Enabled = false
                end
            end
            print("Visual effects disabled")
        end)
        
        -- تقليل المسافة المرئية
        pcall(function()
            game.Workspace.StreamingEnabled = true
            settings().Rendering.StreamingEnabled = true
            print("Streaming enabled")
        end)
        
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "تحسين الأداء",
            Text = "تم تحسين أداء اللعبة",
            Duration = 3
        })
    end
})

-- إضافة قسم للإضاءة
settingsTab:AddSection({
    Name = "lighting"
})

-- إضافة زر لزيادة الإضاءة
settingsTab:AddButton({
    Name = "Increase Brightness",
    Callback = function()
        pcall(function()
            game.Lighting.Brightness = 3 -- زيادة السطوع
            game.Lighting.ClockTime = 14 -- وقت النهار
            game.Lighting.Ambient = Color3.fromRGB(200, 200, 200) -- إضاءة محيطة أعلى
            print("Brightness increased!")
        end)
    end
})

-- إضافة زر لتفعيل الوضع الليلي
settingsTab:AddButton({
    Name = "Night Mode",
    Callback = function()
        pcall(function()
            game.Lighting.ClockTime = 0 -- وقت الليل
            game.Lighting.Brightness = 0.5 -- خفض السطوع
            game.Lighting.Ambient = Color3.fromRGB(50, 50, 80) -- إضاءة زرقاء
            game.Lighting.OutdoorAmbient = Color3.fromRGB(50, 50, 80) -- إضاءة خارجية زرقاء
            print("Night mode activated!")
        end)
    end
})

-- إضافة قسم للمميزات الأخرى
settingsTab:AddSection({
    Name = "other features"
})

-- إضافة زر لتنظيف الذاكرة
settingsTab:AddButton({
    Name = "Clean Memory",
    Callback = function()
        pcall(function()
            for i = 1, 10 do
                game:GetService("Debris"):AddItem(Instance.new("Frame"), 0)
            end
            collectgarbage("collect")
            print("Memory cleaned!")
        end)
        
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Clean Memory",
            Text = "Memory has been cleaned",
            Duration = 3
        })
    end
})

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

game:GetService("StarterGui"):SetCore("SendNotification", { 
    Title = "hello baby";
    Text = "script by front_9";
})
