-- تحميل مكتبة Fluent
local Library = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

-- إنشاء النافذة الرئيسية
local Window = Library:CreateWindow({
    Title = "Fluent " .. Library.Version,
    SubTitle = "by dawid",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

-- إنشاء زر صورة REDZ
local function createRedzButton()
    -- إنشاء الزر
    local imageButton = Instance.new("ImageButton")
    imageButton.Position = UDim2.new(1, -60, 0, 20) -- الزاوية اليمنى العليا
    imageButton.Size = UDim2.new(0, 50, 0, 50)
    imageButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    imageButton.BorderSizePixel = 0
    imageButton.Image = "rbxassetid://73031703958632" -- استبدل برقم معرف الصورة الخاصة بك
    imageButton.ScaleType = Enum.ScaleType.Fit
    imageButton.Parent = game:GetService("CoreGui")
    
    -- متغير لتتبع حالة النافذة
    local windowVisible = true
    
    -- عملية النقر على الزر
    imageButton.MouseButton1Click:Connect(function()
        windowVisible = not windowVisible
        -- فتح أو إغلاق النافذة
        if windowVisible then
            Library:Notify({
                Title = "فتح الواجهة",
                Content = "تم فتح الواجهة",
                Duration = 2
            })
            Window:Show()
        else
            Library:Notify({
                Title = "إغلاق الواجهة",
                Content = "تم إغلاق الواجهة",
                Duration = 2
            })
            Window:Hide()
        end
    end)
    
    return imageButton
end

-- إنشاء التبويبات والمحتوى في النافذة
local Tabs = {
    Main = Window:AddTab({ Title = "الرئيسية", Icon = "rbxassetid://ICON_ID" }),
    Settings = Window:AddTab({ Title = "الإعدادات", Icon = "rbxassetid://ICON_ID" })
}

-- إضافة بعض المحتوى للنافذة
Tabs.Main:AddButton({
    Title = "زر تجريبي",
    Description = "هذا زر تجريبي",
    Callback = function()
        print("تم النقر على الزر")
    end
})

-- استخدام الدالة لإنشاء زر REDZ
local redzBtn = createRedzButton()
