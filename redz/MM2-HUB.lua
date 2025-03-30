-- المتغيرات الأساسية
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")

-- تحميل مكتبة Redz
local redzlib = loadstring(game:HttpGet("https://raw.githubusercontent.com/realredz/RedzLibV5/refs/heads/main/Source.lua"))()

-- إنشاء النافذة الرئيسية
local window = redzlib:MakeWindow({
    Name = "Murder Mystery 2 Hub", 
    SubTitle = "By FRONT / 7SON",
    SaveFolder = "MM2Scripts"
})

-- إنشاء التبويبات
local mainTab = window:MakeTab({
    Title = "الرئيسية",
    Icon = "rbxassetid://6034767608"
})

local playerTab = window:MakeTab({
    Title = "اللاعب",
    Icon = "rbxassetid://6035037997"
})

local visualsTab = window:MakeTab({
    Title = "المرئيات",
    Icon = "rbxassetid://6034509993"
})

local teleportTab = window:MakeTab({
    Title = "الانتقال",
    Icon = "rbxassetid://6035190846"
})

-- المتغيرات العامة
getgenv().Settings = {
    AutoFarm = {
        Coins = false,
        Gun = false,
        Wins = false
    },
    ESP = {
        AllPlayers = false,
        Murder = false,
        Sheriff = false,
        Gun = false
    },
    Target = nil,
    FlingTarget = false,
    ViewTarget = false
}

-- الوظائف المساعدة
local Functions = {}

-- وظيفة الإشعارات
function Functions.Notify(title, description, duration)
    duration = duration or 3
    window:Dialog({
        Title = title,
        Content = description,
        Buttons = {
            {
                Title = "موافق"
            }
        }
    })
end

-- وظيفة التحقق من فريق اللاعب
function Functions.GetTeamOf(player)
    if not player or not player.Character then return "غير معروف" end
    
    local Backpack = player:FindFirstChild("Backpack")
    
    if player.Character:FindFirstChild("Stab", true) then
        return "Murder"
    elseif player.Character:FindFirstChild("IsGun", true) then
        return "Sheriff"
    end
    
    if Backpack and Backpack:FindFirstChild("Stab", true) then
        return "Murder"
    elseif Backpack and Backpack:FindFirstChild("IsGun", true) then
        return "Sheriff"
    elseif player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health <= 0 then
        return "Died"
    else
        return "Innocent"
    end
end

-- وظيفة الحصول على اللاعب من الإسم
function Functions.GetPlayer(name)
    if name == "" then return nil end
    
    name = name:lower():gsub("^%s*(.-)%s*$", "%1")
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local playerName = player.Name:lower():gsub("^%s*(.-)%s*$", "%1")
            local displayName = player.DisplayName:lower():gsub("^%s*(.-)%s*$", "%1")
            
            if playerName:sub(1, #name) == name or displayName:sub(1, #name) == name then
                return player
            end
        end
    end
    
    return nil
end

-- وظيفة الحصول على أقرب عملة
function Functions.GetNearestCoin()
    local CoinContainer = workspace:FindFirstChild("CoinContainer", true)
    if not CoinContainer then return nil end
    
    local nearestCoin, nearestDistance = nil, math.huge
    
    for _, coin in ipairs(CoinContainer:GetChildren()) do
        if coin:IsA("BasePart") and coin:FindFirstChild("TouchInterest", true) then
            local distance = (coin.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
            if distance < nearestDistance then
                nearestCoin, nearestDistance = coin, distance
            end
        end
    end
    
    return nearestCoin
end

-- وظيفة الانتقال إلى مكان
function Functions.TweenTo(part, speed)
    speed = speed or 27
    
    if Functions.IsTweening then return end
    Functions.IsTweening = true
    
    local tween = TweenService:Create(
        LocalPlayer.Character.HumanoidRootPart,
        TweenInfo.new((LocalPlayer.Character.HumanoidRootPart.Position - part.Position).Magnitude / speed, Enum.EasingStyle.Linear),
        {CFrame = CFrame.new(part.Position) * CFrame.Angles(0, math.rad(LocalPlayer.Character.HumanoidRootPart.Orientation.Y), 0)}
    )
    
    tween.Completed:Connect(function()
        Functions.IsTweening = false
    end)
    
    table.insert(Functions.ActiveTweens, tween)
    tween:Play()
    
    return tween
end

-- وظيفة إيقاف جميع الانتقالات
function Functions.StopAllTweens()
    for _, tween in ipairs(Functions.ActiveTweens) do
        tween:Cancel()
    end
    
    Functions.ActiveTweens = {}
    Functions.IsTweening = false
end

-- وظيفة إنشاء ESP للاعب
function Functions.CreateESP(player)
    if not player or not player.Character then return end
    
    local character = player.Character
    local team = Functions.GetTeamOf(player)
    local teamColors = {
        Murder = Color3.fromRGB(255, 54, 54),
        Sheriff = Color3.fromRGB(97, 207, 196),
        Innocent = Color3.fromRGB(104, 255, 124),
        Died = Color3.fromRGB(207, 209, 229)
    }
    
    local esp = character:FindFirstChild("ESP")
    if esp then
        esp.FillColor = teamColors[team] or Color3.fromRGB(255, 255, 255)
    else
        esp = Instance.new("Highlight")
        esp.Name = "ESP"
        esp.OutlineColor = Color3.fromRGB(0, 0, 0)
        esp.FillColor = teamColors[team] or Color3.fromRGB(255, 255, 255)
        esp.Parent = character
    end
    
    if team ~= "Died" then
        local nameTag = character:FindFirstChild("NameTag")
        
        if nameTag then
            local label = nameTag:FindFirstChild("TextLabel")
            if label then
                label.TextColor3 = teamColors[team] or Color3.fromRGB(255, 255, 255)
            end
        else
            nameTag = Instance.new("BillboardGui")
            nameTag.Name = "NameTag"
            nameTag.Size = UDim2.new(0, 90, 0, 25)
            nameTag.Adornee = character:FindFirstChild("Head")
            nameTag.AlwaysOnTop = true
            nameTag.Parent = character
            nameTag.StudsOffset = Vector3.new(0, 2.5, 0)
            
            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(1, 0, 1, 0)
            label.Text = player.Name
            label.TextColor3 = teamColors[team] or Color3.fromRGB(255, 255, 255)
            label.BackgroundTransparency = 1
            label.TextSize = 12
            label.TextStrokeTransparency = 0
            label.Parent = nameTag
        end
    end
end

-- وظيفة إزالة ESP من اللاعب
function Functions.RemoveESP(player)
    if not player or not player.Character then return end
    
    local esp = player.Character:FindFirstChild("ESP")
    local nameTag = player.Character:FindFirstChild("NameTag")
    
    if esp then esp:Destroy() end
    if nameTag then nameTag:Destroy() end
end

-- وظيفة الحصول على القاتل
function Functions.GetMurder()
    for _, player in ipairs(Players:GetPlayers()) do
        if Functions.GetTeamOf(player) == "Murder" then
            return player
        end
    end
    
    return nil
end

-- وظيفة الحصول على الشريف
function Functions.GetSheriff()
    for _, player in ipairs(Players:GetPlayers()) do
        if Functions.GetTeamOf(player) == "Sheriff" then
            return player
        end
    end
    
    return nil
end

-- وظيفة القتل بالسكين
function Functions.MurderKill(target)
    if Functions.GetTeamOf(LocalPlayer) ~= "Murder" then
        Functions.Notify("خطأ", "يجب أن تكون القاتل لاستخدام هذه الميزة")
        return
    end
    
    if not LocalPlayer.Character:FindFirstChild("Knife") then
        LocalPlayer.Character.Humanoid:EquipTool(LocalPlayer.Backpack:FindFirstChild("Knife"))
    end
    
    pcall(function()
        target.Character.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -2)
        LocalPlayer.Character:FindFirstChild("Stab", true):FireServer(target.Name)
    end)
end

-- تهيئة المتغيرات
Functions.ActiveTweens = {}
Functions.IsTweening = false

-- قسم الوظائف الرئيسية في التبويب الرئيسي
mainTab:AddSection({
    Name = "وظائف القاتل"
})

-- إضافة زر القتل التلقائي
mainTab:AddButton({
    Name = "قتل الجميع (القاتل فقط)",
    Desc = "قتل جميع اللاعبين في اللعبة",
    Callback = function()
        if Functions.GetTeamOf(LocalPlayer) ~= "Murder" then
            Functions.Notify("خطأ", "يجب أن تكون القاتل لاستخدام هذه الميزة")
            return
        end

        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 then
                Functions.MurderKill(player)
                wait(0.2)
            end
        end
    end
})

-- إضافة زر استهداف لاعب معين
mainTab:AddTextBox({
    Name = "استهداف لاعب",
    Default = "",
    PlaceholderText = "أدخل اسم اللاعب",
    ClearText = true,
    Callback = function(Value)
        local target = Functions.GetPlayer(Value)
        if target then
            getgenv().Settings.Target = target
            Functions.Notify("تم", "تم تحديد اللاعب: " .. target.Name)
        else
            Functions.Notify("خطأ", "لم يتم العثور على اللاعب")
        end
    end
})

-- إضافة زر قتل اللاعب المستهدف
mainTab:AddButton({
    Name = "قتل اللاعب المستهدف",
    Desc = "قتل اللاعب المحدد",
    Callback = function()
        if not getgenv().Settings.Target then
            Functions.Notify("خطأ", "لم يتم تحديد لاعب بعد")
            return
        end

        if Functions.GetTeamOf(LocalPlayer) ~= "Murder" then
            Functions.Notify("خطأ", "يجب أن تكون القاتل لاستخدام هذه الميزة")
            return
        end

        Functions.MurderKill(getgenv().Settings.Target)
    end
})

-- قسم المهام التلقائية
mainTab:AddSection({
    Name = "المهام التلقائية"
})

-- إضافة زر تجميع العملات التلقائي
mainTab:AddToggle({
    Name = "تجميع العملات تلقائياً",
    Default = false,
    Flag = "AutoCoin",
    Callback = function(Value)
        getgenv().Settings.AutoFarm.Coins = Value
        
        if Value then
            Functions.Notify("تم التفعيل", "تم تفعيل تجميع العملات التلقائي")
            spawn(function()
                while getgenv().Settings.AutoFarm.Coins do
                    local coin = Functions.GetNearestCoin()
                    if coin and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                        Functions.TweenTo(coin, 30)
                        wait(0.1)
                    else
                        wait(1)
                    end
                end
                Functions.StopAllTweens()
            end)
        else
            Functions.Notify("تم الإيقاف", "تم إيقاف تجميع العملات التلقائي")
            Functions.StopAllTweens()
        end
    end
})

-- قسم ESP في تبويب المرئيات
visualsTab:AddSection({
    Name = "ESP اللاعبين"
})

-- إضافة زر ESP لجميع اللاعبين
visualsTab:AddToggle({
    Name = "ESP لجميع اللاعبين",
    Default = false,
    Flag = "AllESP",
    Callback = function(Value)
        getgenv().Settings.ESP.AllPlayers = Value
        
        if Value then
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= LocalPlayer then
                    Functions.CreateESP(player)
                end
            end
        else
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= LocalPlayer then
                    Functions.RemoveESP(player)
                end
            end
        end
    end
})

-- إضافة زر ESP للقاتل فقط
visualsTab:AddToggle({
    Name = "ESP للقاتل فقط",
    Default = false,
    Flag = "MurderESP",
    Callback = function(Value)
        getgenv().Settings.ESP.Murder = Value
        
        if Value then
            local murder = Functions.GetMurder()
            if murder then
                Functions.CreateESP(murder)
            end
        else
            local murder = Functions.GetMurder()
            if murder then
                Functions.RemoveESP(murder)
            end
        end
    end
})

-- إضافة زر ESP للشريف فقط
visualsTab:AddToggle({
    Name = "ESP للشريف فقط",
    Default = false,
    Flag = "SheriffESP",
    Callback = function(Value)
        getgenv().Settings.ESP.Sheriff = Value
        
        if Value then
            local sheriff = Functions.GetSheriff()
            if sheriff then
                Functions.CreateESP(sheriff)
            end
        else
            local sheriff = Functions.GetSheriff()
            if sheriff then
                Functions.RemoveESP(sheriff)
            end
        end
    end
})

-- قسم وظائف اللاعب في تبويب اللاعب
playerTab:AddSection({
    Name = "حركة اللاعب"
})

-- إضافة زر السرعة
playerTab:AddSlider({
    Name = "سرعة الحركة",
    Min = 16,
    Max = 150,
    Default = 16,
    Increase = 1,
    Flag = "WalkSpeed",
    Callback = function(Value)
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = Value
        end
    end
})

-- إضافة زر قوة القفزة
playerTab:AddSlider({
    Name = "قوة القفز",
    Min = 50,
    Max = 250,
    Default = 50,
    Increase = 1,
    Flag = "JumpPower",
    Callback = function(Value)
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.JumpPower = Value
        end
    end
})

-- إضافة زر الطيران
playerTab:AddToggle({
    Name = "الطيران",
    Default = false,
    Flag = "Fly",
    Callback = function(Value)
        if Value then
            Functions.Notify("تم التفعيل", "تم تفعيل الطيران")
            
            local flyPart = Instance.new("Part")
            flyPart.Name = "FlyPart"
            flyPart.Size = Vector3.new(6, 1, 6)
            flyPart.Transparency = 1
            flyPart.Anchored = true
            flyPart.CanCollide = true
            flyPart.Parent = workspace
            
            local connection
            connection = RunService.Heartbeat:Connect(function()
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    flyPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, -3.5, 0)
                else
                    connection:Disconnect()
                    flyPart:Destroy()
                end
            end)
            
            getgenv().FlyConnection = connection
            getgenv().FlyPart = flyPart
        else
            Functions.Notify("تم الإيقاف", "تم إيقاف الطيران")
            
            if getgenv().FlyConnection then
                getgenv().FlyConnection:Disconnect()
                getgenv().FlyConnection = nil
            end
            
            if getgenv().FlyPart then
                getgenv().FlyPart:Destroy()
                getgenv().FlyPart = nil
            end
        end
    end
})

-- قسم الانتقال في تبويب الانتقال
teleportTab:AddSection({
    Name = "الانتقال السريع"
})

-- إضافة أزرار الانتقال إلى المناطق المهمة
teleportTab:AddButton({
    Name = "الانتقال إلى المنطقة الرئيسية",
    Desc = "الانتقال إلى منطقة البداية",
    Callback = function()
        if workspace:FindFirstChild("Lobby") then
            LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Lobby.SpawnPoints.Spawn.CFrame
        else
            Functions.Notify("خطأ", "لم يتم العثور على المنطقة الرئيسية")
        end
    end
})

teleportTab:AddButton({
    Name = "الانتقال إلى السلاح (إن وجد)",
    Desc = "الانتقال إلى مكان السلاح إذا تم إسقاطه",
    Callback = function()
        local gun = workspace:FindFirstChild("GunDrop")
        if gun then
            Functions.TweenTo(gun, 30)
        else
            Functions.Notify("خطأ", "لم يتم العثور على السلاح")
        end
    end
})

-- إعداد الاتصالات والمراقبين

-- مراقبة تغيرات فريق اللاعبين
Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function()
        wait(1)
        if getgenv().Settings.ESP.AllPlayers then
            Functions.CreateESP(player)
        elseif getgenv().Settings.ESP.Murder and Functions.GetTeamOf(player) == "Murder" then
            Functions.CreateESP(player)
        elseif getgenv().Settings.ESP.Sheriff and Functions.GetTeamOf(player) == "Sheriff" then
            Functions.CreateESP(player)
        end
    end)
end)

-- مراقبة تغيرات الفريق في اللعبة
RunService.Heartbeat:Connect(function()
    if getgenv().Settings.ESP.Murder then
        local murder = Functions.GetMurder()
        if murder then
            Functions.CreateESP(murder)
        end
    end
    
    if getgenv().Settings.ESP.Sheriff then
        local sheriff = Functions.GetSheriff()
        if sheriff then
            Functions.CreateESP(sheriff)
        end
    end
    
    if getgenv().Settings.FlingTarget and getgenv().Settings.Target and getgenv().Settings.Target.Character then
        LocalPlayer.Character.HumanoidRootPart.CFrame = getgenv().Settings.Target.Character.HumanoidRootPart.CFrame
    end
end)

-- إعادة ضبط عند إعادة تحميل الشخصية
LocalPlayer.CharacterAdded:Connect(function()
    wait(1)
    if redzlib:GetFlag("WalkSpeed") then
        LocalPlayer.Character.Humanoid.WalkSpeed = redzlib:GetFlag("WalkSpeed")
    end
    
    if redzlib:GetFlag("JumpPower") then
        LocalPlayer.Character.Humanoid.JumpPower = redzlib:GetFlag("JumpPower")
    end
end)

-- إشعار عند تشغيل السكربت
Functions.Notify("تم التحميل", "تم تحميل Murder Mystery 2 Hub بنجاح!", 5)

-- حفظ الإعدادات عند الخروج
game:GetService("CoreGui").ChildRemoved:Connect(function(child)
    if child.Name == "redz Library V5" then
        Functions.StopAllTweens()
        
        if getgenv().FlyConnection then
            getgenv().FlyConnection:Disconnect()
        end
        
        if getgenv().FlyPart then
            getgenv().FlyPart:Destroy()
        end
    end
end)
