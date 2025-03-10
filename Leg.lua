-- Blox Fruits Server Hopper for Zoro Swords
-- Made by front_evill, front_9
-- يبحث عن Legendary Sword Dealer الذي يبيع سيوف زورو: Shizu, Saishi, Oroshi

local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local Player = Players.LocalPlayer

-- السيوف المطلوبة
local targetSwords = {"Shizu", "Saishi", "Oroshi"}

-- معرفات السيرفرات التي تمت زيارتها
local visitedServers = {}

-- المتطلبات الدنيا
local MIN_LEVEL = 700
local MIN_BELI = 2000000 -- 2 مليون

-- طباعة رسائل بدء التشغيل
print("=================================================")
print("           سكربت البحث عن سيوف زورو               ")
print("         Made by front_evill, front_9            ")
print("     يبحث عن: Shizu, Saishi, Oroshi             ")
print("=================================================")

-- وظيفة لإنشاء حركة Tween نحو موقع معين
local function tweenToPosition(targetCFrame, duration)
    if not Player.Character or not Player.Character:FindFirstChild("HumanoidRootPart") then
        return false
    end
    
    local humanoidRootPart = Player.Character.HumanoidRootPart
    
    -- إنشاء معلومات التوين
    local tweenInfo = TweenInfo.new(
        duration,           -- المدة الزمنية
        Enum.EasingStyle.Quad, -- نمط الحركة
        Enum.EasingDirection.Out, -- اتجاه الحركة
        0,                  -- عدد التكرارات (0 = مرة واحدة)
        false,              -- هل يجب أن يعكس الحركة
        0                   -- وقت التأخير
    )
    
    -- إنشاء التوين
    local tween = TweenService:Create(humanoidRootPart, tweenInfo, {CFrame = targetCFrame})
    
    -- تشغيل التوين
    tween:Play()
    
    -- انتظار انتهاء التوين
    local tweenCompleted = false
    
    tween.Completed:Connect(function()
        tweenCompleted = true
    end)
    
    -- الانتظار حتى انتهاء التوين أو انقطاعه
    local startTime = tick()
    while not tweenCompleted and (tick() - startTime) < (duration + 1) do
        wait()
        -- التحقق من أن اللاعب لا يزال موجوداً وحياً
        if not Player.Character or not Player.Character:FindFirstChild("HumanoidRootPart") or 
           not Player.Character:FindFirstChild("Humanoid") or 
           Player.Character.Humanoid.Health <= 0 then
            return false
        end
    end
    
    return tweenCompleted
end

-- التحقق من مستوى اللاعب والبيلي
local function checkPlayerRequirements()
    -- الحصول على المستوى (قد تختلف كيفية الوصول للمستوى حسب لعبة Blox Fruits)
    local level = 0
    local beli = 0
    
    -- محاولة الحصول على المستوى والبيلي من مختلف المصادر المحتملة
    pcall(function()
        -- طريقة 1: التحقق من القيم في PlayerStats
        if Player:FindFirstChild("PlayerStats") then
            local stats = Player.PlayerStats
            if stats:FindFirstChild("Level") then
                level = stats.Level.Value
            end
            if stats:FindFirstChild("Beli") then
                beli = stats.Beli.Value
            end
        end
        
        -- طريقة 2: التحقق من قيم في الـ Leaderstats
        if Player:FindFirstChild("leaderstats") then
            local stats = Player.leaderstats
            if stats:FindFirstChild("Level") then
                level = stats.Level.Value
            end
            if stats:FindFirstChild("Beli") or stats:FindFirstChild("Money") then
                beli = (stats:FindFirstChild("Beli") and stats.Beli.Value) or (stats:FindFirstChild("Money") and stats.Money.Value)
            end
        end
        
        -- طريقة 3: التحقق من قيم في ReplicatedStorage
        local repStorage = game:GetService("ReplicatedStorage")
        if repStorage:FindFirstChild("PlayerData") and repStorage.PlayerData:FindFirstChild(Player.Name) then
            local playerData = repStorage.PlayerData[Player.Name]
            if playerData:FindFirstChild("Level") then
                level = playerData.Level.Value
            end
            if playerData:FindFirstChild("Beli") then
                beli = playerData.Beli.Value
            end
        end
    end)
    
    -- عرض المستوى والبيلي الحاليين
    print("المستوى الحالي: " .. level)
    print("البيلي الحالي: " .. beli)
    
    -- التحقق من المستوى
    if level < MIN_LEVEL then
        -- إرسال رسالة تحذير
        print("=================================================")
        print("     تحذير: المستوى الخاص بك أقل من 700!        ")
        print("   لن تتمكن من شراء سيوف زورو بهذا المستوى      ")
        print("=================================================")
        
        -- محاولة إرسال إشعار
        pcall(function()
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "تحذير المستوى",
                Text = "المستوى الخاص بك أقل من 700!",
                Duration = 10
            })
        end)
        
        return false
    end
    
    -- التحقق من البيلي
    if beli < MIN_BELI then
        -- إرسال رسالة تحذير
        print("=================================================")
        print("     تحذير: ليس لديك ما يكفي من البيلي!        ")
        print("   يجب أن يكون لديك 2 مليون بيلي على الأقل      ")
        print("    البيلي الحالي: " .. beli .. "              ")
        print("=================================================")
        
        -- محاولة إرسال إشعار
        pcall(function()
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "تحذير البيلي",
                Text = "يجب أن يكون لديك 2 مليون بيلي على الأقل!",
                Duration = 10
            })
        end)
        
        return false
    end
    
    return true
end

-- حفظ البيانات للجلسات المستقبلية
local function saveVisitedServers()
    pcall(function()
        writefile("visitedServers.json", HttpService:JSONEncode(visitedServers))
    end)
end

-- تحميل البيانات من الجلسات السابقة
local function loadVisitedServers()
    pcall(function()
        if isfile("visitedServers.json") then
            visitedServers = HttpService:JSONDecode(readfile("visitedServers.json"))
        end
    end)
end

-- فحص مباشر للسيرفر الحالي
local function checkCurrentServer()
    print("جاري فحص السيرفر الحالي...")
    wait(5) -- انتظار تحميل اللعبة
    
    -- التحقق من متطلبات اللاعب أولاً
    if not checkPlayerRequirements() then
        return false
    end
    
    -- إضافة معرف السيرفر الحالي للسيرفرات المزارة
    table.insert(visitedServers, game.JobId)
    saveVisitedServers()
    
    -- البحث عن Legendary Sword Dealer
    local found = false
    local dealerModel = nil
    
    -- البحث في جميع الكائنات في العالم
    for _, obj in pairs(workspace:GetDescendants()) do
        -- تحقق مما إذا كان الكائن هو Legendary Sword Dealer
        if obj:IsA("Model") and (
            obj.Name == "Legendary Sword Dealer" or
            string.find(obj.Name, "Legendary Sword Dealer")
        ) then
            print("تم العثور على Legendary Sword Dealer!")
            dealerModel = obj
            
            -- تحقق من متجر البائع أو المحتوى
            for _, item in pairs(obj:GetDescendants()) do
                for _, targetSword in pairs(targetSwords) do
                    if string.find(item.Name:lower(), targetSword:lower()) then
                        print("وجدت سيف: " .. targetSword)
                        found = true
                    end
                end
            end
            
            -- إذا وجدنا البائع، توقف عن البحث
            if found then
                break
            end
        end
    end
    
    -- إذا وجدنا البائع وسيوف زورو، انتقل إليه
    if found and dealerModel and dealerModel:FindFirstChild("HumanoidRootPart") then
        -- إضافة مؤشر بصري للمتجر
        pcall(function()
            local highlight = Instance.new("Highlight")
            highlight.FillColor = Color3.fromRGB(255, 215, 0) -- لون ذهبي
            highlight.OutlineColor = Color3.fromRGB(255, 0, 0) -- لون أحمر
            highlight.FillTransparency = 0.5
            highlight.OutlineTransparency = 0
            highlight.Parent = dealerModel
            
            -- إرسال إشعار
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "تم العثور على البائع",
                Text = "جاري الانتقال إلى Legendary Sword Dealer",
                Duration = 5
            })
        end)
        
        -- الانتظار قليلاً قبل الانتقال
        wait(1)
        
        -- الانتقال إلى البائع باستخدام Tween
        pcall(function()
            local dealerPosition = dealerModel.HumanoidRootPart.CFrame
            -- إنشاء موقع للوقوف بجانب البائع (مسافة 3 وحدات)
            local standingPosition = dealerPosition * CFrame.new(0, 0, 5)
            
            -- انتقال بالتوين إلى البائع
            print("جاري الانتقال إلى البائع...")
            local tweenSuccess = tweenToPosition(standingPosition, 3)
            
            if tweenSuccess then
                print("تم الانتقال إلى البائع بنجاح!")
                
                -- إرسال إشعار بالنجاح
                game:GetService("StarterGui"):SetCore("SendNotification", {
                    Title = "تم الوصول",
                    Text = "أنت الآن بجانب بائع سيوف زورو",
                    Duration = 10
                })
                
                -- إضافة صوت نجاح
                local sound = Instance.new("Sound")
                sound.SoundId = "rbxassetid://5153734236" -- استبدل بمعرف الصوت المناسب
                sound.Volume = 2
                sound.Parent = game:GetService("SoundService")
                sound:Play()
            else
                print("فشل الانتقال إلى البائع!")
            end
        end)
    end
    
    return found
end

-- الحصول على سيرفر جديد والانتقال إليه
local function teleportToNewServer()
    local servers = {}
    local gameId = game.PlaceId
    
    print("جاري البحث عن سيرفر جديد...")
    
    -- الحصول على قائمة السيرفرات
    local success, result = pcall(function()
        return HttpService:JSONDecode(game:HttpGet(
            "https://games.roblox.com/v1/games/" .. gameId .. "/servers/Public?sortOrder=Asc&limit=100"
        ))
    end)
    
    if success then
        -- تصفية السيرفرات التي لم تتم زيارتها
        for _, server in pairs(result.data) do
            if server.playing < server.maxPlayers and not table.find(visitedServers, server.id) then
                table.insert(servers, server)
            end
        end
        
        if #servers > 0 then
            -- اختيار سيرفر عشوائي
            local server = servers[math.random(1, #servers)]
            print("الانتقال إلى سيرفر جديد...")
            print("عدد اللاعبين: " .. server.playing .. "/" .. server.maxPlayers)
            
            -- إرسال إشعار
            pcall(function()
                game:GetService("StarterGui"):SetCore("SendNotification", {
                    Title = "الانتقال إلى سيرفر",
                    Text = "جاري الانتقال إلى سيرفر جديد...",
                    Duration = 3
                })
            end)
            
            wait(1) -- تأخير صغير لمنع الانتقال المتكرر جداً
            
            -- محاولة الانتقال
            local teleportSuccess, teleportError = pcall(function()
                TeleportService:TeleportToPlaceInstance(gameId, server.id, Player)
            end)
            
            if not teleportSuccess then
                print("فشل الانتقال: " .. teleportError)
                wait(3)
                teleportToNewServer() -- إعادة المحاولة
            end
        else
            print("لم يتم العثور على سيرفرات جديدة. جاري مسح السجل وإعادة المحاولة...")
            visitedServers = {} -- إعادة تعيين قائمة السيرفرات المزارة
            saveVisitedServers()
            wait(5)
            teleportToNewServer()
        end
    else
        print("حدث خطأ أثناء الحصول على قائمة السيرفرات. إعادة المحاولة...")
        wait(10)
        teleportToNewServer()
    end
end

-- الوظيفة الرئيسية
local function main()
    loadVisitedServers() -- تحميل السيرفرات المزارة سابقاً
    
    -- التحقق من السيرفر الحالي
    local swordFound = checkCurrentServer()
    
    if swordFound then
        print("=================================================")
        print("    تم العثور على سيوف زورو في هذا السيرفر!     ")
        print("    Made by front_evill, front_9                ")
        print("=================================================")
    else
        print("لم يتم العثور على سيوف زورو في هذا السيرفر. جاري الانتقال...")
        teleportToNewServer()
    end
end

-- تشغيل السكربت مع التعامل مع الأخطاء
pcall(function()
    main()
end)
