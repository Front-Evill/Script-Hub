-- سكربت لإرسال معلومات اللاعب إلى Discord Webhook

local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local webhookUrl = "https://discord.com/api/webhooks/1366289471204491305/1ptaRoAxMAKUu4wRMmPIogL_c5wXPdSd6NwIXtO7wFS-HHoLr2-9RH0Zbo_8qRWiY0KD"

-- الحصول على معلومات التاريخ والوقت
local function getDateTime()
    local dateTime = os.date("*t")
    local gregorianDate = os.date("%Y-%m-%d %H:%M:%S")
    
    -- تحويل التاريخ الميلادي إلى هجري (تقريبي)
    local hijriYear = math.floor((dateTime.year - 622) * (33/32))
    local hijriMonth = dateTime.month
    local hijriDay = dateTime.day
    
    local hijriDate = hijriYear .. "-" .. hijriMonth .. "-" .. hijriDay
    
    return gregorianDate, hijriDate
end

-- دالة للحصول على رابط صورة اللاعب
local function getPlayerAvatar(userId)
    local success, result = pcall(function()
        return Players:GetUserThumbnailAsync(userId, Enum.ThumbnailType.AvatarBust, Enum.ThumbnailSize.Size420x420)
    end)
    
    if success then
        return result
    else
        return "https://www.roblox.com/headshot-thumbnail/image?userId=" .. userId .. "&width=420&height=420&format=png"
    end
end

-- دالة لإرسال المعلومات إلى الويب هوك
local function sendWebhook(player)
    local gregorianDateTime, hijriDateTime = getDateTime()
    local playerName = player.Name
    local playerDisplayName = player.DisplayName
    local playerUserId = player.UserId
    
    -- الحصول على صورة السكن (الأفاتار)
    local avatarUrl = getPlayerAvatar(playerUserId)
    
    -- إنشاء بيانات الرسالة
    local data = {
        embeds = {
            {
                title = "تم تشغيل السكربت",
                color = 65280, -- لون أخضر
                fields = {
                    {
                        name = "اسم اللاعب",
                        value = playerName,
                        inline = true
                    },
                    {
                        name = "الاسم المعروض",
                        value = playerDisplayName,
                        inline = true
                    },
                    {
                        name = "معرف المستخدم",
                        value = tostring(playerUserId),
                        inline = true
                    },
                    {
                        name = "التاريخ الميلادي",
                        value = gregorianDateTime,
                        inline = true
                    },
                    {
                        name = "التاريخ الهجري",
                        value = hijriDateTime,
                        inline = true
                    },
                    {
                        name = "وقت التشغيل",
                        value = os.date("%H:%M:%S"),
                        inline = true
                    }
                },
                thumbnail = {
                    url = avatarUrl
                },
                image = {
                    url = avatarUrl
                },
                timestamp = os.date("!%Y-%m-%dT%H:%M:%S") .. "Z"
            }
        }
    }
    
    -- إرسال البيانات إلى الويب هوك
    local success, response = pcall(function()
        return HttpService:PostAsync(webhookUrl, HttpService:JSONEncode(data), Enum.HttpContentType.ApplicationJson)
    end)
    
    if success then
        print("تم إرسال المعلومات بنجاح!")
    else
        warn("فشل إرسال المعلومات: " .. tostring(response))
    end
end

-- تشغيل الدالة عند تشغيل السكربت
local localPlayer = Players.LocalPlayer
if localPlayer then
    sendWebhook(localPlayer)
else
    -- انتظار حتى يتم تحميل اللاعب
    Players.PlayerAdded:Connect(function(player)
        if player == Players.LocalPlayer then
            sendWebhook(player)
        end
    end)
end

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
