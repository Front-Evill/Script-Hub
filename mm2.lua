-- سكربت Murder Mystery 2 محسن ومطور
-- بواسطة Front_9 مع تحسينات إضافية

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local StarterGui = game:GetService("StarterGui")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")

-- تحميل المكتبة الأساسية
local redzlib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Front-Evill/Script-Hub/refs/heads/main/redz/Source.lua"))()

-- متغيرات عامة
local Player = Players.LocalPlayer
local roleBoxesEnabled = false
local targetedPlayers = {}

-- ألوان الأدوار مع تحسينات بصرية
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

-- دالة ESP المتقدمة
local function CreateESPBox(player, role)
    if player == Player or not role then return end
    
    local character = player.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then return end
    
    -- إنشاء صندوق ESP
    local box = Instance.new("BoxHandleAdornment")
    box.Name = "RoleESP_" .. player.Name
    box.Adornee = character.HumanoidRootPart
    box.AlwaysOnTop = true
    box.ZIndex = 10
    box.Transparency = 0.5
    box.Color3 = roleColors[role] or Color3.fromRGB(255, 255, 255)
    box.Size = character:GetExtentsSize() * 1.2
    box.Parent = character.HumanoidRootPart
    
    -- إنشاء لوحة معلومات
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "RoleLabel_" .. player.Name
    billboard.Adornee = character.HumanoidRootPart
    billboard.Size = UDim2.new(0, 200, 0, 50)
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.AlwaysOnTop = true
    billboard.Parent = character.HumanoidRootPart
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = player.Name .. " [" .. role .. "]"
    label.TextColor3 = roleColors[role]
    label.TextSize = 14
    label.Font = Enum.Font.SourceSansBold
    label.Parent = billboard
    
    return box, billboard
end

-- إنشاء النافذة الرئيسية
local window = redzlib:MakeWindow({
    Name = "🔫 Murder Mystery 2 Script",
    SubTitle = "بواسطة Front_9",
    SaveFolder = "MM2_Script_Settings"
})

-- تبويب الهجوم
local attackTab = window:MakeTab({
    Title = "🗡️ القتال والهجوم",
    Icon = "rbxassetid://10723407389"
})

attackTab:AddSection({
    Name = "⚔️ خيارات القتل المتقدمة"
})

-- زر القتل المتقدم
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

-- استكمال سكربت Murder Mystery 2

-- تبويب ESP والكشف
local espTab = window:MakeTab({
    Title = "🕵️ الكشف والتتبع",
    Icon = "rbxassetid://10709811445"
})

espTab:AddSection({
    Name = "🎯 خيارات الكشف المتقدمة"
})

-- تبديل ESP الأدوار
espTab:AddToggle({
    Name = "تفعيل ESP الأدوار",
    Default = false,
    Callback = function(isEnabled)
        roleBoxesEnabled = isEnabled
        
        if isEnabled then
            -- مسح أي ESP سابق
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= Player then
                    local role = DetectPlayerRole(player)
                    if role then
                        CreateESPBox(player, role)
                    end
                end
            end
            
            StarterGui:SetCore("SendNotification", {
                Title = "نظام ESP",
                Text = "تم تفعيل الكشف عن الأدوار",
                Duration = 3
            })
        else
            -- إزالة جميع صناديق ESP
            for _, player in pairs(Players:GetPlayers()) do
                local character = player.Character
                if character then
                    local espBox = character.HumanoidRootPart:FindFirstChild("RoleESP_" .. player.Name)
                    local espLabel = character.HumanoidRootPart:FindFirstChild("RoleLabel_" .. player.Name)
                    
                    if espBox then espBox:Destroy() end
                    if espLabel then espLabel:Destroy() end
                end
            end
            
            StarterGui:SetCore("SendNotification", {
                Title = "نظام ESP",
                Text = "تم إيقاف الكشف عن الأدوار",
                Duration = 3
            })
        end
    end
})

-- تبويب القدرات اللاعب
local playerTab = window:MakeTab({
    Title = "🏃 قدرات اللاعب",
    Icon = "rbxassetid://10747373426"
})

playerTab:AddSection({
    Name = "🚀 تعزيز الحركة"
})

-- سرعة القفز اللامحدودة
playerTab:AddToggle({
    Name = "قفز لامحدود",
    Default = false,
    Callback = function(isEnabled)
        if isEnabled then
            UserInputService.JumpRequest:Connect(function()
                local character = Player.Character
                if character and character:FindFirstChild("Humanoid") then
                    character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end)
            
            StarterGui:SetCore("SendNotification", {
                Title = "القفز اللامحدود",
                Text = "تم تفعيل القفز المتكرر",
                Duration = 3
            })
        end
    end
})

-- سلايدر قوة القفز
playerTab:AddSlider({
    Name = "قوة القفز",
    Min = 50,
    Max = 250,
    Default = 100,
    Callback = function(value)
        local character = Player.Character
        if character and character:FindFirstChild("Humanoid") then
            character.Humanoid.JumpPower = value
        end
    end
})

-- تبويب الإعدادات العامة
local settingsTab = window:MakeTab({
    Title = "⚙️ الإعدادات",
    Icon = "rbxassetid://10709811445"
})

settingsTab:AddSection({
    Name = "🌈 تخصيص المظهر"
})

-- إزالة الضباب
settingsTab:AddButton({
    Name = "إزالة الضباب",
    Callback = function()
        pcall(function()
            Lighting.FogEnd = 100000
            Lighting.FogStart = 0
            Lighting.ClockTime = 12
            
            StarterGui:SetCore("SendNotification", {
                Title = "إعدادات الإضاءة",
                Text = "تمت إزالة الضباب وتحسين الرؤية",
                Duration = 3
            })
        end)
    end
})

-- دالة حفظ الإعدادات
local function SaveScriptSettings()
    local settings = {
        ESP_Enabled = roleBoxesEnabled,
        -- يمكن إضافة المزيد من الإعدادات هنا
    }
    
    -- حفظ الإعدادات (يمكن تعديلها لاحقًا)
    redzlib:SaveSettings(settings)
end

-- تحميل الإعدادات عند بدء التشغيل
local function LoadScriptSettings()
    local loadedSettings = redzlib:LoadSettings()
    
    if loadedSettings then
        -- استعادة الإعدادات السابقة
        if loadedSettings.ESP_Enabled ~= nil then
            roleBoxesEnabled = loadedSettings.ESP_Enabled
        end
    end
end

-- تشغيل دالة التحميل
LoadScriptSettings()

-- حفظ الإعدادات تلقائيًا كل دقيقة
spawn(function()
    while wait(60) do
        pcall(SaveScriptSettings)
    end
end)

-- رسالة البدء
StarterGui:SetCore("SendNotification", {
    Title = "Murder Mystery 2 Script",
    Text = "تم تحميل السكربت بنجاح! حظًا موفقًا 🎮",
    Duration = 5
})

-- إنهاء السكربت وحفظ الإعدادات
game:GetService("CoreGui").ChildRemoved:Connect(function(child)
    if child.Name == "Script Mm2" then
        pcall(SaveScriptSettings)
        print("تم إغلاق السكربت وحفظ الإعدادات")
    end
end)
