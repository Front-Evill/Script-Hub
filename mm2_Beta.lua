local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")

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
    
    -- الحصول على حجم الشخصية
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    
    if not humanoid or not rootPart then
        return
    end
    
    -- إنشاء المربع
    local box = Instance.new("BoxHandleAdornment")
    box.Name = "RoleBox_" .. player.Name
    box.Adornee = rootPart
    box.AlwaysOnTop = true  -- يظهر دائمًا فوق العناصر الأخرى
    box.ZIndex = 10  -- أولوية عالية للظهور
    box.Transparency = 0.5
    box.Color3 = roleColors[role] or Color3.fromRGB(255, 255, 255)
    
    -- حساب حجم المربع ليتناسب مع حجم الشخصية
    local characterSize = character:GetExtentsSize()
    box.Size = characterSize * 1.05  -- زيادة طفيفة لتغطية الشخصية بالكامل
    
    box.Parent = rootPart
    
    -- إضافة اسم اللاعب ودوره
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
    
    -- تخزين المربع واللوحة للإشارة إليهما لاحقًا
    playerRoleBoxes[player.Name] = {
        box = box,
        label = billboard
    }
    
    -- ضمان ظهور المربع عبر الجدران باستخدام الخصائص المناسبة
    -- إضافة تأثير نظام الإحاطة بتحديث مستمر
    spawn(function()
        while wait(0.1) do
            if roleBoxesEnabled and box and box.Parent and character and character.Parent then
                -- التحقق من المسافة والتعديل على الشفافية (مثال)
                local distance = (rootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                local transparency = math.clamp(distance / 100, 0.3, 0.8)
                box.Transparency = transparency
                
                -- تعديل حجم المربع في حالة تغير حجم الشخصية
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
    if not eliminationEnabled then
        return 0, 0
    end

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
local function TeleportToPlayer(playerName)
    local player = game.Players:FindFirstChild(playerName)
    local localPlayer = game.Players.LocalPlayer

    if player and player.Character and localPlayer.Character then
        local targetHRP = player.Character:FindFirstChild("HumanoidRootPart")
        local localHRP = localPlayer.Character:FindFirstChild("HumanoidRootPart")

        if targetHRP and localHRP then
            -- إضافة إزاحة بسيطة لتجنب الكشف
            localHRP.CFrame = targetHRP.CFrame * CFrame.new(0, 0, 3)
            return true
        end
    end
    return false
end

-- تحديث قائمة اللاعبين المتاحين للتنقل
local function GetPlayerList()
    local playerList = {}
    for _, player in pairs(game.Players:GetPlayers()) do
        if player ~= game.Players.LocalPlayer then
            table.insert(playerList, player.Name)
        end
    end
    return playerList
end

local redzlib = loadstring(game:HttpGet("https://raw.githubusercontent.com/realredz/RedzLibV5/refs/heads/main/Source.lua"))()

-- تعريف النافذة الرئيسية
local window = redzlib:MakeWindow({
    Name = "Script Mm2",
    SubTitle = "by Front_9",
    SaveFolder = "",
    icon = "rbxassetid://10709752906"
})

--قسم ديسكورد
local discordTab = window:MakeTab({
    Title = "acount fruit",
    Icon = "rbxassetid://10709752906"
})

discordTab:AddSection({
    Name = " ... Discord... "
})

discordTab:AddDiscordInvite({
    Name = "Join Our Community", -- نص الدعوة
    Logo = "rbxassetid://10709752906",
    Invite = "https://discord.gg/vr7", -- رابط الدعوة الخاص بك
    Desc = "Click to join our Discord server!" -- وصف صغير
})

discordTab:AddSection({
    Name = " ...guns.lol... "
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

-- متغير لتخزين حالة تفعيل النظام التلقائي
local eliminationEnabled = false

-- إضافة زر Toggle لتفعيل/تعطيل النظام التلقائي
mainTab:AddToggle({
    Name = "Enable Auto Elimination",
    Default = false,
    Flag = "autoEliminationToggle",
    Callback = function(Value)
        eliminationEnabled = Value
        if Value then
            print("Auto Elimination System Enabled")
            -- بدء دورة القتل التلقائي
            spawn(function()
                while eliminationEnabled do
                    local targetCount, successCount = EliminateAllPlayers()
                    if targetCount == 0 or successCount == 0 then
                        wait(2) -- انتظار أطول إذا لم يكن هناك أهداف
                    else
                        wait(0.5) -- انتظار قصير بين الدورات
                    end
                end
            end)
        else
            print("Auto Elimination System Disabled")
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

local teleportTab = window:MakeTab({
    Title = "Teleport",
    Icon = "rbxassetid://10709752906"
})

teleportTab:AddSection({
    Name = "teleport"
})

-- قائمة منسدلة لاختيار لاعب للتنقل إليه
local teleportDropdown = teleportTab:AddDropdown({
    Name = "Select Player",
    Options = GetPlayerList(),
    Default = "None",
    Flag = "teleportPlayerDropdown",
    Callback = function(Value)
        print("Selected Player for Teleport: " .. Value)
    end
})

-- تحديث قائمة اللاعبين كل 3 ثوانٍ
spawn(function()
    while wait(3) do
        pcall(function()
            teleportDropdown:Refresh(GetPlayerList())
        end)
    end
end)

-- زر التليبورت للاعب المحدد
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
            print("No player selected for teleport")
        end
    end
})

-- متغير لتخزين الموقع الأصلي للشخصية
local originalPosition = nil

-- دالة للحصول على إحداثيات المسدس المُسقط
local function GetDroppedGunPosition()
    -- البحث عن الأسلحة المُسقطة في اللعبة
    for _, tool in pairs(workspace:GetDescendants()) do
        if tool:IsA("Tool") and tool:FindFirstChild("Handle") then
            local toolName = tool.Name
            local sheriffItems = {"Gun", "Revolver", "Pistol", "Luger", "Blaster"}
            
            -- التحقق مما إذا كان السلاح ينتمي إلى قائمة أسلحة الشرطة
            for _, itemName in pairs(sheriffItems) do
                if toolName == itemName then
                    return tool.Handle.Position, tool -- إرجاع موقع السلاح والسلاح نفسه
                end
            end
        end
    end
    return nil, nil
end

-- دالة للانتقال إلى موقع معين
local function TeleportToPosition(position)
    local localPlayer = game.Players.LocalPlayer
    local character = localPlayer.Character
    
    if character and character:FindFirstChild("HumanoidRootPart") then
        local hrp = character.HumanoidRootPart
        hrp.CFrame = CFrame.new(position) * CFrame.new(0, 5, 0) -- إضافة ارتفاع بسيط لتجنب الاصطدام بالأرض
        return true
    end
    return false
end

-- دالة للعودة إلى الموقع الأصلي
local function ReturnToOriginalPosition()
    if originalPosition then
        TeleportToPosition(originalPosition)
        print("Returned to the original position.")
    else
        print("No original position saved.")
    end
end

-- دالة لأخذ المسدس المُسقط
local function PickupDroppedGun()
    local gunPosition, gunTool = GetDroppedGunPosition()
    
    if not gunPosition or not gunTool then
        print("No dropped gun found.")
        return false
    end
    
    -- حفظ الموقع الأصلي
    local localPlayer = game.Players.LocalPlayer
    local character = localPlayer.Character
    
    if character and character:FindFirstChild("HumanoidRootPart") then
        originalPosition = character.HumanoidRootPart.Position
    end
    
    -- الانتقال إلى موقع المسدس
    print("Teleporting to the dropped gun...")
    if TeleportToPosition(gunPosition) then
        wait(1) -- انتظار قصير للتأكد من الوصول
        
        -- محاولة أخذ السلاح
        local backpack = localPlayer.Backpack
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        
        if humanoid then
            humanoid:EquipTool(gunTool)
            print("Equipped the dropped gun: " .. gunTool.Name)
        else
            print("Failed to equip the dropped gun.")
        end
        
        -- العودة إلى الموقع الأصلي
        wait(1) -- انتظار قصير قبل العودة
        ReturnToOriginalPosition()
        return true
    else
        print("Failed to teleport to the dropped gun.")
        return false
    end
end

-- زر للتنقل إلى المسدس المُسقط وأخذه
teleportTab:AddButton({
    Name = "Pickup Dropped Gun",
    Callback = function()
        if PickupDroppedGun() then
            print("Successfully picked up the dropped gun and returned to the original position.")
        else
            print("Failed to pick up the dropped gun.")
        end
    end
})

local playerTab = window:MakeTab({
    Title = "Player", -- اسم التبويب
    Icon = "rbxassetid://10709752906" 
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

-- التعامل مع إعادة إنشاء الشخصية
Players.LocalPlayer.CharacterAdded:Connect(function(Character)
    local Humanoid = Character:WaitForChild("Humanoid")
    
    -- إعادة تطبيق قوة القفز إذا كانت مفعلة
    if redzlib:GetFlag("jumpPowerEnabled") then
        Humanoid.JumpPower = redzlib:GetFlag("jumpPowerValue")
    end
    
    -- إعادة تطبيق السرعة إذا كانت مفعلة
    if redzlib:GetFlag("speedEnabled") then
        Humanoid.WalkSpeed = redzlib:GetFlag("speedValue")
    end
end)

playerTab:AddSection({
    Name = "anemochin"
})


playerTab:AddButton({
   Name = "Astronaut Animation",
   Callback = function()
       if not isAlive() then return end
       local Animate = player.Character.Animate
       Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=891621366"
       Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=891633237"
       Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=891667138"
       Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=891636393"
       Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=891627522"
       Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=891609353"
       Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=891617961"
   end
})

playerTab:AddButton({
   Name = "Superhero Animation",
   Callback = function()
       if not isAlive() then return end
       local Animate = player.Character.Animate
       Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=616111295"
       Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=616113536"
       Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=616122287"
       Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=616117076"
       Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=616115533"
       Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=616104706"
       Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=616108001"
   end
})



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
            Title = "تنظيف الذاكرة",
            Text = "تم تنظيف الذاكرة بنجاح",
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
    Title = "GO SUB TO HIM";
    Text = "script by front_9";
})
