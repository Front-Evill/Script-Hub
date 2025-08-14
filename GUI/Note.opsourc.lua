local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local BackgroundGradient = Instance.new("UIGradient")
local TimerFrame = Instance.new("Frame")
local TimerCorner = Instance.new("UICorner")
local TimerLabel = Instance.new("TextLabel")
local TimerStroke = Instance.new("UIStroke")
local InfoFrame = Instance.new("ScrollingFrame")
local InfoCorner = Instance.new("UICorner")
local InfoStroke = Instance.new("UIStroke")
local Title1 = Instance.new("TextLabel")
local Content1 = Instance.new("TextLabel")
local Title2 = Instance.new("TextLabel")
local Content2 = Instance.new("TextLabel")
local CopyrightLabel = Instance.new("TextLabel")
local UIListLayout = Instance.new("UIListLayout")

ScreenGui.Name = "CountdownGui"
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0, 0, 0, 0)
MainFrame.Size = UDim2.new(1, 0, 1, 0)

BackgroundGradient.Parent = MainFrame
BackgroundGradient.Color = ColorSequence.new{
   ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 20, 30)),
   ColorSequenceKeypoint.new(0.5, Color3.fromRGB(5, 5, 10)),
   ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 15, 25))
}
BackgroundGradient.Rotation = 45

TimerFrame.Name = "TimerFrame"
TimerFrame.Parent = MainFrame
TimerFrame.AnchorPoint = Vector2.new(0.5, 0)
TimerFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
TimerFrame.Position = UDim2.new(0.5, 0, 0.05, 0)
TimerFrame.Size = UDim2.new(0, 200, 0, 120)

TimerCorner.CornerRadius = UDim.new(0, 15)
TimerCorner.Parent = TimerFrame

TimerStroke.Parent = TimerFrame
TimerStroke.Color = Color3.fromRGB(60, 120, 255)
TimerStroke.Thickness = 3

TimerLabel.Name = "TimerLabel"
TimerLabel.Parent = TimerFrame
TimerLabel.BackgroundTransparency = 1
TimerLabel.Size = UDim2.new(1, 0, 1, 0)
TimerLabel.Font = Enum.Font.GothamBold
TimerLabel.Text = "30"
TimerLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TimerLabel.TextScaled = true
TimerLabel.TextSize = 48
TimerLabel.TextStrokeTransparency = 0
TimerLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)

InfoFrame.Name = "InfoFrame"
InfoFrame.Parent = MainFrame
InfoFrame.AnchorPoint = Vector2.new(0.5, 0)
InfoFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
InfoFrame.BorderSizePixel = 0
InfoFrame.Position = UDim2.new(0.5, 0, 0.25, 0)
InfoFrame.Size = UDim2.new(0, 600, 0, 400)
InfoFrame.ScrollBarThickness = 8
InfoFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 120)

InfoCorner.CornerRadius = UDim.new(0, 12)
InfoCorner.Parent = InfoFrame

InfoStroke.Parent = InfoFrame
InfoStroke.Color = Color3.fromRGB(60, 120, 255)
InfoStroke.Thickness = 2

UIListLayout.Parent = InfoFrame
UIListLayout.FillDirection = Enum.FillDirection.Vertical
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.Padding = UDim.new(0, 15)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

Title1.Name = "Title1"
Title1.Parent = InfoFrame
Title1.BackgroundTransparency = 1
Title1.Size = UDim2.new(1, -20, 0, 50)
Title1.Font = Enum.Font.GothamBold
Title1.Text = "🎯 Script Information & Developers"
Title1.TextColor3 = Color3.fromRGB(60, 120, 255)
Title1.TextSize = 20
Title1.TextXAlignment = Enum.TextXAlignment.Center
Title1.LayoutOrder = 1

Content1.Name = "Content1"
Content1.Parent = InfoFrame
Content1.BackgroundTransparency = 1
Content1.Size = UDim2.new(1, -40, 0, 150)
Content1.Font = Enum.Font.Gotham
Content1.Text = [[📋 GUI Framework: Fluent UI Library
👨‍💻 Script Developers: 7son & Front Evill
📊 Version: 3.8
🌐 Discord - Front: f18a
🌐 Discord - 7son: 7sone
🔗 Discord Server: https://discord.gg/5TnWvNBcSJ]]
Content1.TextColor3 = Color3.fromRGB(220, 220, 220)
Content1.TextSize = 14
Content1.TextWrapped = true
Content1.TextYAlignment = Enum.TextYAlignment.Top
Content1.LayoutOrder = 2

Title2.Name = "Title2"
Title2.Parent = InfoFrame
Title2.BackgroundTransparency = 1
Title2.Size = UDim2.new(1, -20, 0, 50)
Title2.Font = Enum.Font.GothamBold
Title2.Text = "🌐 Social Media & Additional Info"
Title2.TextColor3 = Color3.fromRGB(60, 120, 255)
Title2.TextSize = 20
Title2.TextXAlignment = Enum.TextXAlignment.Center
Title2.LayoutOrder = 3

Content2.Name = "Content2"
Content2.Parent = InfoFrame
Content2.BackgroundTransparency = 1
Content2.Size = UDim2.new(1, -40, 0, 120)
Content2.Font = Enum.Font.Gotham
Content2.Text = [[🔑 Executor Key: VF9
🌍 Web Script: https://front-evill.github.io/NANO/
🔫 Guns.lol - Front: https://guns.lol/front_evill
🔫 Guns.lol - 7son: https://guns.lol/hm5]]
Content2.TextColor3 = Color3.fromRGB(220, 220, 220)
Content2.TextSize = 14
Content2.TextWrapped = true
Content2.TextYAlignment = Enum.TextYAlignment.Top
Content2.LayoutOrder = 4

CopyrightLabel.Name = "CopyrightLabel"
CopyrightLabel.Parent = MainFrame
CopyrightLabel.AnchorPoint = Vector2.new(0.5, 1)
CopyrightLabel.BackgroundTransparency = 1
CopyrightLabel.Position = UDim2.new(0.5, 0, 0.95, 0)
CopyrightLabel.Size = UDim2.new(0, 400, 0, 30)
CopyrightLabel.Font = Enum.Font.GothamBold
CopyrightLabel.Text = "© 2024 FRONT EVILL TEAM - All Rights Reserved"
CopyrightLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
CopyrightLabel.TextSize = 16
CopyrightLabel.TextStrokeTransparency = 0.5
CopyrightLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)

InfoFrame.CanvasSize = UDim2.new(0, 0, 0, 400)

local timeLeft = 30
local connection

spawn(function()
   local startTime = tick()
   
   connection = game:GetService("RunService").Heartbeat:Connect(function()
       local elapsed = tick() - startTime
       timeLeft = math.max(0, 30 - elapsed)
       
       if timeLeft > 0 then
           TimerLabel.Text = tostring(math.ceil(timeLeft))
           
           local progress = (30 - timeLeft) / 30
           TimerStroke.Color = Color3.new(progress, 1 - progress, 0.2)
           
           local pulse = math.sin(tick() * 5) * 0.1 + 0.9
           TimerFrame.Size = UDim2.new(0, 200 * pulse, 0, 120 * pulse)
       else
           TimerLabel.Text = "0"
           connection:Disconnect()
           
           MainFrame:TweenSizeAndPosition(
               UDim2.new(0, 0, 0, 0),
               UDim2.new(0.5, 0, 0.5, 0),
               "In", "Back", 0.5, true,
               function()
                   ScreenGui:Destroy()
               end
           )
       end
   end)
end)

spawn(function()
   while timeLeft > 0 do
       for i = 0, 1, 0.1 do
           if timeLeft <= 0 then break end
           TimerLabel.TextTransparency = i * 0.3
           wait(0.1)
       end
       for i = 1, 0, -0.1 do
           if timeLeft <= 0 then break end
           TimerLabel.TextTransparency = i * 0.3
           wait(0.1)
       end
   end
end)

spawn(function()
   while InfoFrame.Parent do
       InfoStroke.Color = Color3.fromHSV((tick() * 0.5) % 1, 0.8, 1)
       wait(0.1)
   end
end)
