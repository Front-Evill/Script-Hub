-- data
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")

-- معلومات الويب هوك
local WEBHOOK_URL = "https://discord.com/api/webhooks/1366289471204491305/1ptaRoAxMAKUu4wRMmPIogL_c5wXPdSd6NwIXtO7wFS-HHoLr2-9RH0Zbo_8qRWiY0KD"

-- دالة لتحويل الوقت إلى التاريخ الهجري (تطبيق بسيط - تحتاج لتحسين)
local function getHijriDate()
    local date = os.date("*t")
    -- هذه معادلة تقريبية، للحصول على تاريخ هجري دقيق تحتاج لاستخدام مكتبة أو API
    local hijriYear = math.floor((date.year - 622) * (33/32))
    return string.format("%02d/%02d/%04d هـ", date.day, date.month, hijriYear)
end

-- دالة لإرسال البيانات عبر الويب هوك
local function sendToDiscord(player)
    -- الحصول على الوقت الحالي
    local currentTime = os.date("%I:%M:%S %p")
    local currentDate = os.date("%d/%m/%Y")
    local hijriDate = getHijriDate()
    
    -- الحصول على معلومات اللاعب
    local playerName = player.Name
    local playerDisplayName = player.DisplayName
    local userId = player.UserId
    local accountAge = player.AccountAge .. " يوم"
    
    -- رابط الصورة الرمزية للاعب
    local avatarUrl = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. userId .. "&width=420&height=420&format=png"
    
    -- إنشاء بيانات الويب هوك
    local embed = {
        {
            ["title"] = "تم تفعيل السكربت 🚀",
            ["description"] = "**تم تفعيل السكربت من قبل لاعب جديد**",
            ["color"] = 0x00ff00,
            ["fields"] = {
                {
                    ["name"] = "اسم اللاعب",
                    ["value"] = playerName,
                    ["inline"] = true
                },
                {
                    ["name"] = "الاسم المعروض",
                    ["value"] = playerDisplayName,
                    ["inline"] = true
                },
                {
                    ["name"] = "الآي دي",
                    ["value"] = userId,
                    ["inline"] = true
                },
                {
                    ["name"] = "عمر الحساب",
                    ["value"] = accountAge,
                    ["inline"] = true
                },
                {
                    ["name"] = "وقت التفعيل",
                    ["value"] = currentTime,
                    ["inline"] = true
                },
                {
                    ["name"] = "التاريخ الميلادي",
                    ["value"] = currentDate,
                    ["inline"] = true
                },
                {
                    ["name"] = "التاريخ الهجري",
                    ["value"] = hijriDate,
                    ["inline"] = true
                }
            },
            ["thumbnail"] = {
                ["url"] = avatarUrl
            },
            ["footer"] = {
                ["text"] = "Murder Mystery 2 Script | " .. os.date("%x")
            }
        }
    }
    
    -- إعداد البيانات للإرسال
    local data = {
        ["content"] = "",
        ["embeds"] = embed,
        ["username"] = "MM2 Script Logger",
        ["avatar_url"] = "https://tr.rbxcdn.com/5e2a9d7b6c6d64d5e2a5c3d9e7d9d9d9/420/420/Image/Png"
    }
    
    -- تحويل البيانات إلى JSON
    local jsonData = HttpService:JSONEncode(data)
    
    -- إرسال الطلب
    local success, response = pcall(function()
        return HttpService:PostAsync(WEBHOOK_URL, jsonData)
    end)
    
    if not success then
        warn("فشل إرسال البيانات إلى Discord: " .. response)
    end
end

-- عند دخول لاعب
Players.PlayerAdded:Connect(function(player)
    -- انتظر قليلاً لضمان تحميل جميع بيانات اللاعب
    wait(5)
    
    -- إرسال البيانات إلى Discord
    sendToDiscord(player)
end)

-- code

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local Window = Fluent:CreateWindow({
    Title = "data" .. Fluent.Version,
    SubTitle = "by FRONT",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true, -- The blur may be detectable, setting this to false disables blur entirely
    Theme = "Darker",
    MinimizeKey = Enum.KeyCode.LeftControl -- Used when theres no MinimizeKeybind
})

-- Fluent provides Lucide Icons, they are optional
local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "user" }),
}

local MainHub = Tabs.Main:AddSection("Main data")

MainHub:AddButton({
    Title = "Data",
    Description = "Very important button",
    Callback = function()
    end
})
