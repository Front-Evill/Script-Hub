local Library = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

-- تخزين مرجع للواجهة الرئيسية
local fluentInterface = nil

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


--كل ما يخص الصوره 


-- حفظ مرجع الواجهة
fluentInterface = Window

-- إنشاء زر التبديل
local function createToggleButton()
    -- إنشاء ScreenGui
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "ToggleButtonGui"
    screenGui.ResetOnSpawn = false
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screenGui.DisplayOrder = 9999
    
    -- محاولة وضع الـ ScreenGui في الأصل المناسب
    pcall(function() screenGui.Parent = game:GetService("CoreGui") end)
    if not screenGui.Parent then
        pcall(function() screenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui") end)
    end
    
    -- إنشاء الزر
    local toggleButton = Instance.new("ImageButton")
    toggleButton.Size = UDim2.new(0, 40, 0, 40)
    toggleButton.Position = UDim2.new(0.5, -20, 0, 3) -- وضع أعلى أكثر
    toggleButton.BackgroundTransparency = 1
    toggleButton.Image = "rbxassetid://73031703958632"
    toggleButton.ZIndex = 10
    toggleButton.Parent = screenGui
    
    -- متغير لتتبع حالة النافذة
    local windowVisible = true
    
    -- وظيفة النقر على الزر
    toggleButton.MouseButton1Click:Connect(function()
        windowVisible = not windowVisible
        if windowVisible then
            Window:Show()
        else
            Window:Hide()
        end
    end)
    
    -- دالة حذف الزر
    local function removeButton()
        if screenGui and screenGui.Parent then
            screenGui:Destroy()
        end
    end
    
    return toggleButton, removeButton
end
--نهايه

-- إنشاء التبويبات
local Tabs = {
    Main = Window:AddTab({ Title = "main", Icon = "rbxassetid://103167069627270"      })
    Teleport = Window:AddTab({ Title = "Teleport", Icon = "rbxassetid://139926030461" })
    Player = Window:AddTab({ Title = "Player", Icon = "rbxassetid://112831378967496"  })
    Esp = Window:AddTab({ Title = "Esp", Icon = "rbxassetid://113403744497786"        })
    Server = Window:AddTab({ Title = "Server", Icon = "rbxassetid://93989683556149"   })
}

-- استخدام دالة إنشاء الزر
local toggleBtn, removeToggleBtn = createToggleButton()

-- إضافة زر لحذف الواجهة والزر في تبويب الإعدادات
Tabs.Main:AddButton({
    Title = "حذف الواجهة والزر",
    Description = "حذف واجهة Fluent وزر التبديل معاً",
    Callback = function()
        -- حذف زر التبديل أولاً
        if removeToggleBtn then
            removeToggleBtn()
        end
        
        -- ثم حذف واجهة Fluent
        pcall(function()
            if fluentInterface then
                fluentInterface:Destroy()
            end
        end)
    end
})

-- إضافة خيار لإظهار/إخفاء الزر
Tabs.Settings:AddToggle({
    Title = "إظهار/إخفاء زر التبديل",
    Default = true,
    Callback = function(Value)
        if toggleBtn then
            toggleBtn.Visible = Value
        end
    end
})
