local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local TimerLabel = Instance.new("TextLabel")
local InfoFrame = Instance.new("ScrollingFrame")
local Title1 = Instance.new("TextLabel")
local Content1 = Instance.new("TextLabel")
local Title2 = Instance.new("TextLabel")
local Content2 = Instance.new("TextLabel")

ScreenGui.Name = "CountdownGui"
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0, 0, 0, 0)
MainFrame.Size = UDim2.new(1, 0, 1, 0)

TimerLabel.Name = "TimerLabel"
TimerLabel.Parent = MainFrame
TimerLabel.BackgroundTransparency = 1
TimerLabel.Position = UDim2.new(0, 0, 0, 0)
TimerLabel.Size = UDim2.new(1, 0, 0, 100)
TimerLabel.Font = Enum.Font.GothamBold
TimerLabel.Text = "30"
TimerLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TimerLabel.TextScaled = true
TimerLabel.TextSize = 48
TimerLabel.TextStrokeTransparency = 0
TimerLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)

InfoFrame.Name = "InfoFrame"
InfoFrame.Parent = MainFrame
InfoFrame.BackgroundTransparency = 1
InfoFrame.BorderSizePixel = 0
InfoFrame.Position = UDim2.new(0.1, 0, 0.2, 0)
InfoFrame.Size = UDim2.new(0.8, 0, 0.7, 0)
InfoFrame.ScrollBarThickness = 8
InfoFrame.ScrollBarImageColor3 = Color3.fromRGB(255, 255, 255)

Title1.Name = "Title1"
Title1.Parent = InfoFrame
Title1.BackgroundTransparency = 1
Title1.Position = UDim2.new(0, 0, 0, 0)
Title1.Size = UDim2.new(1, 0, 0, 40)
Title1.Font = Enum.Font.GothamBold
Title1.Text = "تعريف عن سكربت ومطورين"
Title1.TextColor3 = Color3.fromRGB(255, 255, 255)
Title1.TextSize = 18
Title1.TextXAlignment = Enum.TextXAlignment.Center

Content1.Name = "Content1"
Content1.Parent = InfoFrame
Content1.BackgroundTransparency = 1
Content1.Position = UDim2.new(0, 0, 0, 50)
Content1.Size = UDim2.new(1, 0, 0, 120)
Content1.Font = Enum.Font.Gotham
Content1.Text = "\ngui - ui : Fluent \nscript by : 7son - front \nv : 3.8 \nuser discord front : f18a \nuser discord 7son : 7sone \nserver discord front : https://discord.gg/5TnWvNBcSJ"
Content1.TextColor3 = Color3.fromRGB(200, 200, 200)
Content1.TextSize = 14
Content1.TextWrapped = true
Content1.TextYAlignment = Enum.TextYAlignment.Top

Title2.Name = "Title2"
Title2.Parent = InfoFrame
Title2.BackgroundTransparency = 1
Title2.Position = UDim2.new(0, 0, 0, 180)
Title2.Size = UDim2.new(1, 0, 0, 40)
Title2.Font = Enum.Font.GothamBold
Title2.Text = "تواصل اجتماعي و معلومات سكربت"
Title2.TextColor3 = Color3.fromRGB(255, 255, 255)
Title2.TextSize = 18
Title2.TextXAlignment = Enum.TextXAlignment.Center

Content2.Name = "Content2"
Content2.Parent = InfoFrame
Content2.BackgroundTransparency = 1
Content2.Position = UDim2.new(0, 0, 0, 230)
Content2.Size = UDim2.new(1, 0, 0, 100)
Content2.Font = Enum.Font.Gotham
Content2.Text = "\nKye research in executor : VF9 \nweb script : https://front-evill.github.io/NANO/ \nguns.lol front : https://guns.lol/front_evill \nguns.lol 7sone : https://guns.lol/hm5"
Content2.TextColor3 = Color3.fromRGB(200, 200, 200)
Content2.TextSize = 14
Content2.TextWrapped = true
Content2.TextYAlignment = Enum.TextYAlignment.Top

InfoFrame.CanvasSize = UDim2.new(0, 0, 0, 350)

local timeLeft = 30
local connection

connection = game:GetService("RunService").Heartbeat:Connect(function()
    if timeLeft > 0 then
        TimerLabel.Text = tostring(math.ceil(timeLeft))
        timeLeft = timeLeft - (1/60)
        local alpha = (timeLeft % 1)
        TimerLabel.TextTransparency = alpha * 0.3
    else
        connection:Disconnect()
        ScreenGui:Destroy()
    end
end)

spawn(function()
    while timeLeft > 0 do
        for i = 1, 10 do
            if timeLeft <= 0 then break end
            TimerLabel.TextTransparency = i * 0.05
            wait(0.05)
        end
        for i = 10, 1, -1 do
            if timeLeft <= 0 then break end
            TimerLabel.TextTransparency = i * 0.05
            wait(0.05)
        end
    end
end)
