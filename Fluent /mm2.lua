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

-- إنشاء زر صورة REDZ بشكل دائري في وسط أعلى الشاشة
local function createRedzButton()
    -- إنشاء الزر
    local imageButton = Instance.new("ImageButton")
    imageButton.Position = UDim2.new(0.5, -20, 0, 10) -- وسط أعلى الشاشة
    imageButton.Size = UDim2.new(0, 40, 0, 40) -- حجم أصغر قليلاً
    imageButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    imageButton.BorderSizePixel = 0
    imageButton.Image = "rbxassetid://73031703958632" -- استبدل برقم معرف الصورة الخاصة بك
    imageButton.ScaleType = Enum.ScaleType.Fit
    imageButton.Parent = game:GetService("CoreGui")
    
    -- جعل الزر دائري
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(1, 0) -- نصف القطر 1 يجعل الشكل دائري تماماً
    UICorner.Parent = imageButton
    
    -- إضافة تأثير عند تحريك الماوس فوق الزر
    local UIStroke = Instance.new("UIStroke")
    UIStroke.Color = Color3.fromRGB(255, 255, 255)
    UIStroke.Thickness = 2
    UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    UIStroke.Parent = imageButton
    UIStroke.Transparency = 1 -- غير مرئي بشكل افتراضي
    
    -- متغير لتتبع حالة النافذة
    local windowVisible = true
    
    -- عملية تحريك الماوس فوق الزر
    imageButton.MouseEnter:Connect(function()
        game:GetService("TweenService"):Create(UIStroke, TweenInfo.new(0.3), {Transparency = 0}):Play()
    end)
    
    imageButton.MouseLeave:Connect(function()
        game:GetService("TweenService"):Create(UIStroke, TweenInfo.new(0.3), {Transparency = 1}):Play()
    end)
    
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
    Main = Window:AddTab({ Title = "الرئيسية", Icon = "rbxassetid://73031703958632" }),
    Settings = Window:AddTab({ Title = "الإعدادات", Icon = "rbxassetid://73031703958632" })
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
