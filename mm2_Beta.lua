local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")

local Player = Players.LocalPlayer
local RenderStepped = RunService.RenderStepped
local Heartbeat = RunService.Heartbeat

--فنشكن

local roleColors = {
    Murderer = Color3.fromRGB(255, 0, 0),      -- أحمر للقاتل
    Sheriff = Color3.fromRGB(0, 0, 255),       -- أزرق للشرطي
    Innocent = Color3.fromRGB(0, 255, 0)       -- أخضر للمسالم
}

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

--فنشكن خاصه ب قتل جميع
-- دالة القضاء على جميع اللاعبين
local targetedPlayers = {}

local function EliminateAllPlayers()
    if not eliminationEnabled then
        return false
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
--نهايه

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


--فنشكن تنقل
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

-- دالة للانتقال إلى لاعب محدد
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
--نهايه

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

--فنشكن الانتقال ل ممسدس


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

--نهايه
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
-- زر رفع جودة الرسوميات
settingsTab:AddButton({
  Name = "Improve Graphics",
  Callback = function()
      -- محاولة الطريقة الأولى: تغيير الجودة مباشرة إلى المستوى الأعلى
      local success, errorMessage = pcall(function()
          settings().Rendering.QualityLevel = "Level21"
          print("Attempt 1: Graphics quality set to Level21.")
      end)

      if not success then
          warn("Attempt 1 failed:", errorMessage)
          -- الطريقة الثانية: زيادة الجودة تدريجيًا
          local currentLevel = tonumber(settings().Rendering.QualityLevel:match("%d+")) or 1
          while currentLevel < 21 do
              currentLevel = currentLevel + 1
              local newLevel = string.format("Level%02d", currentLevel)
              local successStep, errorMessageStep = pcall(function()
                  settings().Rendering.QualityLevel = newLevel
                  print("Attempt 2: Graphics quality increased to", newLevel)
              end)

              if not successStep then
                  warn("Attempt 2 failed at level", newLevel, ":", errorMessageStep)
                  break
              end
          end

          if currentLevel < 21 then
              -- الطريقة الثالثة: إعادة الضبط إلى القيم الافتراضية
              local successReset, errorMessageReset = pcall(function()
                  settings().Rendering.QualityLevel = "Level01" -- إعادة الجودة إلى المستوى الأدنى
                  print("Attempt 3: Reset graphics quality to default.")
              end)

              if not successReset then
                  warn("Attempt 3 failed:", errorMessageReset)
              else
                  print("Graphics quality reset to default successfully.")
              end
          end
      else
          print("Graphics quality improved successfully!")
      end
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
