local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local StarterGui = game:GetService("StarterGui")
local UserInputService = game:GetService("UserInputService")

-- تحميل المكتبة الأساسية
local redzlib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Front-Evill/Script-Hub/refs/heads/main/redz/Source.lua"))()

-- متغيرات عامة
local Player = Players.LocalPlayer
local roleBoxesEnabled = false
local targetedPlayers = {}

-- ألوان الأدوار (تحسين التصميم)
local roleColors = {
    Murderer = Color3.fromRGB(220, 20, 60),    -- أحمر غني
    Sheriff = Color3.fromRGB(30, 144, 255),    -- أزرق داكن
    Innocent = Color3.fromRGB(50, 205, 50)     -- أخضر مشرق
}

-- دالة متقدمة للبحث عن السكين
local function FindKnifeInBackpack()
    local backpack = Player.Backpack
    local knives = {
        "Knife", "Blade", "Darkblade", "Chroma", "Corrupt", 
        "Slasher", "Laser", "Dagger", "Claw", "Scythe", "Sickle"
    }
    
    for _, knifeName in ipairs(knives) do
        local knife = backpack:FindFirstChild(knifeName)
        if knife then
            knife.Parent = Player.Character
            return true, knifeName
        end
    end
    
    return false, nil
end

-- دالة متقدمة لسحب اللاعبين
local function PullAllPlayersToMe()
    local localCharacter = Player.Character
    if not localCharacter or not localCharacter:FindFirstChild("HumanoidRootPart") then
        return false, 0
    end
    
    local pullPosition = localCharacter.HumanoidRootPart.CFrame
    local pulledPlayers = 0
    
    for _, otherPlayer in pairs(Players:GetPlayers()) do
        if otherPlayer ~= Player and otherPlayer.Character and otherPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local humanoidRootPart = otherPlayer.Character.HumanoidRootPart
            
            local tweenInfo = TweenInfo.new(
                0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out
            )
            
            local tween = TweenService:Create(humanoidRootPart, tweenInfo, {
                CFrame = pullPosition * CFrame.new(math.random(-3, 3), 0, math.random(-3, 3))
            })
            
            tween:Play()
            pulledPlayers = pulledPlayers + 1
        end
    end
    
    return pulledPlayers > 0, pulledPlayers
end

-- دالة كشف دور اللاعب مع تحسينات
local function DetectPlayerRole(player)
    local backpack = player.Backpack
    local character = player.Character
    
    if not character then return nil end
    
    local murdererWeapons = {"Knife", "Blade", "Dagger", "Scythe"}
    local sheriffWeapons = {"Gun", "Revolver", "Pistol", "Deagle"}
    
    local function hasWeapon(container, weaponList)
        for _, item in pairs(container:GetChildren()) do
            for _, weaponName in pairs(weaponList) do
                if item.Name:lower():find(weaponName:lower()) then
                    return true
                end
            end
        end
        return false
    end
    
    if hasWeapon(character, murdererWeapons) or hasWeapon(backpack, murdererWeapons) then
        return "Murderer"
    end
    
    if hasWeapon(character, sheriffWeapons) or hasWeapon(backpack, sheriffWeapons) then
        return "Sheriff"
    end
    
    return "Innocent"
end

-- تنظيم النافذة الرئيسية مع تحسينات بصرية
local window = redzlib:MakeWindow({
    Name = "🔫 Murder Mystery 2 Script",
    SubTitle = "بواسطة Front_9",
    SaveFolder = "MM2_Script_Settings"
})

-- تبويب القتل والهجوم
local attackTab = window:MakeTab({
    Title = "🗡️ القتال والهجوم",
    Icon = "rbxassetid://10723407389"
})

attackTab:AddSection({
    Name = "⚔️ خيارات القتل المتقدمة"
})

attackTab:AddButton({
    Name = "قتل متقدم بالسكين",
    Desc = "العثور على سكين وسحب جميع اللاعبين",
    Callback = function()
        local knifeFound, knifeName = FindKnifeInBackpack()
        
        if not knifeFound then
            StarterGui:SetCore("SendNotification", {
                Title = "فشل الاقتحام",
                Text = "لم يتم العثور على سكين!",
                Duration = 3
            })
            return
        end
        
        local success, playersPulled = PullAllPlayersToMe()
        
        if success then
            StarterGui:SetCore("SendNotification", {
                Title = "نجاح الاقتحام",
                Text = "تم سحب " .. playersPulled .. " لاعب باستخدام " .. knifeName .. "!",
                Duration = 3
            })
        else
            StarterGui:SetCore("SendNotification", {
                Title = "فشل الاقتحام",
                Text = "تعذر سحب اللاعبين!",
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


end
