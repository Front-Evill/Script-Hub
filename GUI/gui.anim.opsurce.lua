-- إنشاء الواجهة الرئيسية
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local ScrollingFrame = Instance.new("ScrollingFrame")
local UIGridLayout = Instance.new("UIGridLayout")
local CloseButton = Instance.new("TextButton")

-- إعدادات الواجهة
ScreenGui.Name = "AnimationSelector"
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- الإطار الرئيسي
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.Size = UDim2.new(0, 500, 0, 600)

-- تأثير الظل والحواف المدورة
local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 15)
Corner.Parent = MainFrame

local Shadow = Instance.new("Frame")
Shadow.Name = "Shadow"
Shadow.Parent = MainFrame
Shadow.AnchorPoint = Vector2.new(0.5, 0.5)
Shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Shadow.BackgroundTransparency = 0.8
Shadow.Position = UDim2.new(0.5, 3, 0.5, 3)
Shadow.Size = UDim2.new(1, 0, 1, 0)
Shadow.ZIndex = -1

local ShadowCorner = Instance.new("UICorner")
ShadowCorner.CornerRadius = UDim.new(0, 15)
ShadowCorner.Parent = Shadow

-- العنوان
Title.Name = "Title"
Title.Parent = MainFrame
Title.BackgroundColor3 = Color3.fromRGB(40, 120, 255)
Title.BackgroundTransparency = 0
Title.BorderSizePixel = 0
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Font = Enum.Font.GothamBold
Title.Text = "🎭 Animation Selector"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 20

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 15)
TitleCorner.Parent = Title

-- زر الإغلاق
CloseButton.Name = "CloseButton"
CloseButton.Parent = Title
CloseButton.AnchorPoint = Vector2.new(1, 0.5)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 75, 75)
CloseButton.BorderSizePixel = 0
CloseButton.Position = UDim2.new(1, -10, 0.5, 0)
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Text = "✕"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 14

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 15)
CloseCorner.Parent = CloseButton

-- إطار التمرير
ScrollingFrame.Name = "ScrollingFrame"
ScrollingFrame.Parent = MainFrame
ScrollingFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
ScrollingFrame.BorderSizePixel = 0
ScrollingFrame.Position = UDim2.new(0, 10, 0, 60)
ScrollingFrame.Size = UDim2.new(1, -20, 1, -70)
ScrollingFrame.ScrollBarThickness = 6
ScrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 120)

local ScrollCorner = Instance.new("UICorner")
ScrollCorner.CornerRadius = UDim.new(0, 10)
ScrollCorner.Parent = ScrollingFrame

-- تخطيط الشبكة
UIGridLayout.Parent = ScrollingFrame
UIGridLayout.CellSize = UDim2.new(0, 140, 0, 100)
UIGridLayout.CellPadding = UDim2.new(0, 10, 0, 10)
UIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder

-- قائمة الأنيميشن
local animations = {
    {name = "Levitation", emoji = "🔮", color = Color3.fromRGB(138, 43, 226)},
    {name = "Astronaut", emoji = "🚀", color = Color3.fromRGB(30, 144, 255)},
    {name = "Ninja", emoji = "🥷", color = Color3.fromRGB(75, 75, 75)},
    {name = "Pirate", emoji = "🏴‍☠️", color = Color3.fromRGB(139, 69, 19)},
    {name = "Toy", emoji = "🧸", color = Color3.fromRGB(255, 182, 193)},
    {name = "Cowboy", emoji = "🤠", color = Color3.fromRGB(139, 90, 43)},
    {name = "Princess", emoji = "👑", color = Color3.fromRGB(255, 20, 147)},
    {name = "Knight", emoji = "⚔️", color = Color3.fromRGB(112, 128, 144)},
    {name = "Vampire", emoji = "🧛", color = Color3.fromRGB(139, 0, 0)},
    {name = "Patrol", emoji = "👮", color = Color3.fromRGB(0, 100, 0)},
    {name = "Elder", emoji = "👴", color = Color3.fromRGB(139, 137, 112)},
    {name = "Mage", emoji = "🧙", color = Color3.fromRGB(72, 61, 139)},
    {name = "Werewolf", emoji = "🐺", color = Color3.fromRGB(139, 90, 0)},
    {name = "Cartoony", emoji = "🎨", color = Color3.fromRGB(255, 165, 0)},
    {name = "Sneaky", emoji = "🕵️", color = Color3.fromRGB(47, 79, 79)},
    {name = "Stylish", emoji = "💃", color = Color3.fromRGB(255, 105, 180)},
    {name = "Bubbly", emoji = "💖", color = Color3.fromRGB(255, 182, 193)},
    {name = "Superhero", emoji = "🦸", color = Color3.fromRGB(220, 20, 60)},
    {name = "Stylized", emoji = "✨", color = Color3.fromRGB(186, 85, 211)},
    {name = "Popstar", emoji = "🎤", color = Color3.fromRGB(255, 20, 147)}
}

-- الأنيميشن IDs
local animationData = {
    Levitation = {
        idle1 = "616006778", idle2 = "616008087", walk = "616013216",
        run = "616010382", jump = "616008936", climb = "616003713", fall = "616005863"
    },
    Astronaut = {
        idle1 = "891621366", idle2 = "891633237", walk = "891667138",
        run = "891636393", jump = "891627522", climb = "891609353", fall = "891617961"
    },
    Ninja = {
        idle1 = "656117400", idle2 = "656118341", walk = "656121766",
        run = "656118852", jump = "656117878", climb = "656114359", fall = "656115606"
    },
    Pirate = {
        idle1 = "750781874", idle2 = "750782770", walk = "750785693",
        run = "750783738", jump = "750782230", climb = "750779899", fall = "750780242"
    },
    Toy = {
        idle1 = "782841498", idle2 = "782845736", walk = "782843345",
        run = "782842708", jump = "782847020", climb = "782843869", fall = "782846423"
    },
    Cowboy = {
        idle1 = "1014390418", idle2 = "1014398616", walk = "1014421541",
        run = "1014401683", jump = "1014394726", climb = "1014380606", fall = "1014384571"
    },
    Princess = {
        idle1 = "941003647", idle2 = "941013098", walk = "941028902",
        run = "941015281", jump = "941008832", climb = "940996062", fall = "941000007"
    },
    Knight = {
        idle1 = "657595757", idle2 = "657568135", walk = "657552124",
        run = "657564596", jump = "658409194", climb = "658360781", fall = "657600338"
    },
    Vampire = {
        idle1 = "1083445855", idle2 = "1083450166", walk = "1083473930",
        run = "1083462077", jump = "1083455352", climb = "1083439238", fall = "1083443587"
    },
    Patrol = {
        idle1 = "1149612882", idle2 = "1150842221", walk = "1151231493",
        run = "1150967949", jump = "1150944216", climb = "1148811837", fall = "1148863382"
    },
    Elder = {
        idle1 = "845397899", idle2 = "845400520", walk = "845403856",
        run = "845386501", jump = "845398858", climb = "845392038", fall = "845396048"
    },
    Mage = {
        idle1 = "707742142", idle2 = "707855907", walk = "707897309",
        run = "707861613", jump = "707853694", climb = "707826056", fall = "707829716"
    },
    Werewolf = {
        idle1 = "1083195517", idle2 = "1083214717", walk = "1083178339",
        run = "1083216690", jump = "1083218792", climb = "1083182000", fall = "1083189019"
    },
    Cartoony = {
        idle1 = "742637544", idle2 = "742638445", walk = "742640026",
        run = "742638842", jump = "742637942", climb = "742636889", fall = "742637151"
    },
    Sneaky = {
        idle1 = "1132473842", idle2 = "1132477671", walk = "1132510133",
        run = "1132494274", jump = "1132489853", climb = "1132461372", fall = "1132469004"
    },
    Stylish = {
        idle1 = "616136790", idle2 = "616138447", walk = "616146177",
        run = "616140816", jump = "616139451", climb = "616133594", fall = "616134815"
    },
    Bubbly = {
        idle1 = "910004836", idle2 = "891633237", walk = "910034870",
        run = "910025107", jump = "910016857", climb = "909997997", fall = "910001910"
    },
    Superhero = {
        idle1 = "616111295", idle2 = "616113536", walk = "616122287",
        run = "616117076", jump = "616115533", climb = "616104706", fall = "616108001"
    },
    Stylized = {
        idle1 = "4708191566", idle2 = "4708192150", walk = "4708193840",
        run = "4708192705", jump = "4708188025", climb = "4708184253", fall = "4708186162"
    },
    Popstar = {
        idle1 = "1212900985", idle2 = "1212954651", walk = "1212980338",
        run = "1212980348", jump = "1212954642", climb = "1213044939", fall = "1212900995"
    }
}

-- دالة التنبيه
local function Notify(title, message, duration)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = title,
        Text = message,
        Duration = duration or 5
    })
end

-- دالة تطبيق الأنيميشن
local function ApplyAnimation(animName)
    local plr = game.Players.LocalPlayer
    
    if plr.Character.Humanoid.RigType ~= Enum.HumanoidRigType.R15 then
        Notify("FRONT SYSTEM", "YOUR NOT THE R15", 5)
        return
    end
    
    local data = animationData[animName]
    if not data then return end
    
    local Animate = plr.Character.Animate
    
    Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=" .. data.idle1
    Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=" .. data.idle2
    Animate.walk.WalkAnim.AnimationId = "http://www.roblox.com/asset/?id=" .. data.walk
    Animate.run.RunAnim.AnimationId = "http://www.roblox.com/asset/?id=" .. data.run
    Animate.jump.JumpAnim.AnimationId = "http://www.roblox.com/asset/?id=" .. data.jump
    Animate.climb.ClimbAnim.AnimationId = "http://www.roblox.com/asset/?id=" .. data.climb
    Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=" .. data.fall
    
    plr.Character.Humanoid:ChangeState(3)
    Animate.Disabled = false
    
    Notify("نجح!", "تم تطبيق أنيميشن " .. animName, 3)
    
    -- حذف الواجهة بعد الاختيار
    ScreenGui:Destroy()
end

-- إنشاء أزرار الأنيميشن
for i, anim in ipairs(animations) do
    local Button = Instance.new("TextButton")
    local ButtonCorner = Instance.new("UICorner")
    local Gradient = Instance.new("UIGradient")
    
    Button.Name = anim.name .. "Button"
    Button.Parent = ScrollingFrame
    Button.BackgroundColor3 = anim.color
    Button.BorderSizePixel = 0
    Button.Font = Enum.Font.GothamBold
    Button.Text = anim.emoji .. "\n" .. anim.name
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.TextSize = 12
    Button.LayoutOrder = i
    
    ButtonCorner.CornerRadius = UDim.new(0, 10)
    ButtonCorner.Parent = Button
    
    Gradient.Parent = Button
    Gradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(200, 200, 200))
    }
    Gradient.Rotation = 45
    
    -- تأثيرات التفاعل
    Button.MouseEnter:Connect(function()
        Button:TweenSize(UDim2.new(0, 150, 0, 110), "Out", "Quad", 0.2, true)
        Button.TextSize = 13
    end)
    
    Button.MouseLeave:Connect(function()
        Button:TweenSize(UDim2.new(0, 140, 0, 100), "Out", "Quad", 0.2, true)
        Button.TextSize = 12
    end)
    
    Button.MouseButton1Click:Connect(function()
        ApplyAnimation(anim.name)
    end)
end

-- تحديث حجم التمرير
local contentSize = math.ceil(#animations / 3) * (100 + 10) - 10
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, contentSize)

-- وظيفة زر الإغلاق
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- تأثير الحركة عند الفتح
MainFrame.Size = UDim2.new(0, 0, 0, 0)
MainFrame:TweenSize(UDim2.new(0, 500, 0, 600), "Out", "Back", 0.5, true)

-- تأثير اهتزاز العنوان
spawn(function()
    while Title.Parent do
        Title:TweenPosition(UDim2.new(0, 2, 0, 0), "Out", "Quad", 0.1, true)
        wait(0.1)
        Title:TweenPosition(UDim2.new(0, -2, 0, 0), "Out", "Quad", 0.1, true)
        wait(0.1)
        Title:TweenPosition(UDim2.new(0, 0, 0, 0), "Out", "Quad", 0.1, true)
        wait(2)
    end
end)
