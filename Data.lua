-- سكربت لإرسال معلومات اللاعب إلى Discord Webhook
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local webhookUrl = "https://discord.com/api/webhooks/1366289453743738890/gXGICSQf4Gzcs3y8FJZhqupo_Y0yHfaVWxMwGCUEfKCD1FrUzau3TDpjtyCYqB-sgXEd"

-- دالة لإرسال المعلومات إلى الويب هوك
local function sendWebhook()
    local player = Players.LocalPlayer
    if not player then return end
    
    -- الحصول على معلومات الوقت
    local currentTime = os.date("%Y-%m-%d %H:%M:%S")
    
    -- إنشاء رابط صورة اللاعب
    local avatarUrl = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. player.UserId .. "&width=420&height=420&format=png"
    
    -- إنشاء البيانات للإرسال
    local data = {
        username = "MM2 Script Logger",
        content = "تم تفعيل السكربت",
        embeds = {
            {
                title = "معلومات اللاعب",
                color = 7419530,
                fields = {
                    {
                        name = "اسم اللاعب",
                        value = player.Name,
                        inline = true
                    },
                    {
                        name = "الاسم المعروض",
                        value = player.DisplayName,
                        inline = true
                    },
                    {
                        name = "معرف المستخدم",
                        value = tostring(player.UserId),
                        inline = true
                    },
                    {
                        name = "وقت التفعيل",
                        value = currentTime,
                        inline = false
                    }
                },
                thumbnail = {
                    url = avatarUrl
                }
            }
        }
    }
    
    -- تحويل البيانات إلى JSON
    local jsonData
    local success, result = pcall(function()
        return HttpService:JSONEncode(data)
    end)
    
    if not success then
        warn("فشل تحويل البيانات إلى JSON")
        return
    end
    
    jsonData = result
    
    -- إرسال البيانات
    local success, response = pcall(function()
        return syn and syn.request or http and http.request or request or HttpPost
    end)
    
    if not success or not response then
        -- استخدام HttpService إذا لم تكن الدوال السابقة متوفرة
        success, response = pcall(function()
            return HttpService:RequestAsync({
                Url = webhookUrl,
                Method = "POST",
                Headers = {
                    ["Content-Type"] = "application/json"
                },
                Body = jsonData
            })
        end)
        
        if success then
            if response.Success then
                print("تم إرسال المعلومات بنجاح!")
            else
                warn("فشل الإرسال: " .. (response.StatusMessage or "خطأ غير معروف"))
            end
        else
            warn("حدث خطأ أثناء الإرسال: " .. tostring(response))
        end
    else
        -- استخدام دالة الطلب المتوفرة (لمحركات سكربت مختلفة)
        local requestFunc = response
        local res = requestFunc({
            Url = webhookUrl,
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json"
            },
            Body = jsonData
        })
        
        if res.Success or res.StatusCode == 200 or res.StatusCode == 204 then
            print("تم إرسال المعلومات بنجاح!")
        else
            warn("فشل الإرسال: " .. (res.StatusMessage or "خطأ غير معروف"))
        end
    end
end

-- ننتظر تحميل اللاعب ثم نرسل البيانات
if Players.LocalPlayer then
    task.wait(1) -- انتظار ثانية واحدة للتأكد من تحميل كامل البيانات
    sendWebhook()
else
    Players.PlayerAdded:Connect(function(player)
        if player == Players.LocalPlayer then
            task.wait(1)
            sendWebhook()
        end
    end)
end

-- كود الواجهة منفصل عن كود الإرسال
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local Window = Fluent:CreateWindow({
    Title = "MM2 Script",
    SubTitle = "by FRONT",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true,
    Theme = "Darker",
    MinimizeKey = Enum.KeyCode.LeftControl
})

local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "home" }),
}

local MainSection = Tabs.Main:AddSection("MM2 Script Controls")
