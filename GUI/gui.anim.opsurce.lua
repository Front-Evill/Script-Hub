local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local CloseButton = Instance.new("TextButton")
local ScrollingFrame = Instance.new("ScrollingFrame")
local UIGridLayout = Instance.new("UIGridLayout")
local MinimizedFrame = Instance.new("Frame")
local ShowButton = Instance.new("TextButton")
local DeleteButton = Instance.new("TextButton")

local currentAnimation = nil
local isMinimized = false

function NotifySound ()
local sound = Instance.new("Sound")
sound.SoundId = "rbxassetid://"
sound.Volume = 0.3
sound.Looped = false
sound.Parent = game.Workspace
sound:Play()
end

ScreenGui.Name = "AnimationGUI"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.ResetOnSpawn = false

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.Size = UDim2.new(0, 600, 0, 450)
MainFrame.Active = true
MainFrame.Draggable = true

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = MainFrame

CloseButton.Name = "CloseButton"
CloseButton.Parent = MainFrame
CloseButton.AnchorPoint = Vector2.new(1, 0)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
CloseButton.BorderSizePixel = 0
CloseButton.Position = UDim2.new(1, -10, 0, 10)
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 16

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 8)
CloseCorner.Parent = CloseButton

ScrollingFrame.Name = "ScrollingFrame"
ScrollingFrame.Parent = MainFrame
ScrollingFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
ScrollingFrame.BorderSizePixel = 0
ScrollingFrame.Position = UDim2.new(0, 10, 0, 50)
ScrollingFrame.Size = UDim2.new(1, -20, 1, -60)
ScrollingFrame.ScrollBarThickness = 6
ScrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)

local ScrollCorner = Instance.new("UICorner")
ScrollCorner.CornerRadius = UDim.new(0, 8)
ScrollCorner.Parent = ScrollingFrame

UIGridLayout.Parent = ScrollingFrame
UIGridLayout.CellSize = UDim2.new(0, 180, 0, 50)
UIGridLayout.CellPadding = UDim2.new(0, 10, 0, 10)
UIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder

MinimizedFrame.Name = "MinimizedFrame"
MinimizedFrame.Parent = ScreenGui
MinimizedFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
MinimizedFrame.BorderSizePixel = 0
MinimizedFrame.Position = UDim2.new(0, 20, 0, 20)
MinimizedFrame.Size = UDim2.new(0, 200, 0, 40)
MinimizedFrame.Active = true
MinimizedFrame.Draggable = true
MinimizedFrame.Visible = false

local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(0, 8)
MinCorner.Parent = MinimizedFrame

ShowButton.Name = "ShowButton"
ShowButton.Parent = MinimizedFrame
ShowButton.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
ShowButton.BorderSizePixel = 0
ShowButton.Position = UDim2.new(0, 5, 0, 5)
ShowButton.Size = UDim2.new(0, 150, 0, 30)
ShowButton.Font = Enum.Font.GothamBold
ShowButton.Text = "🎭 Animation GUI"
ShowButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ShowButton.TextSize = 12

local ShowCorner = Instance.new("UICorner")
ShowCorner.CornerRadius = UDim.new(0, 6)
ShowCorner.Parent = ShowButton

DeleteButton.Name = "DeleteButton"
DeleteButton.Parent = MinimizedFrame
DeleteButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
DeleteButton.BorderSizePixel = 0
DeleteButton.Position = UDim2.new(1, -35, 0, 5)
DeleteButton.Size = UDim2.new(0, 30, 0, 30)
DeleteButton.Font = Enum.Font.GothamBold
DeleteButton.Text = "X"
DeleteButton.TextColor3 = Color3.fromRGB(255, 255, 255)
DeleteButton.TextSize = 14

local DelCorner = Instance.new("UICorner")
DelCorner.CornerRadius = UDim.new(0, 6)
DelCorner.Parent = DeleteButton

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
   },
    Wickind = {
       idle1 = "118832222982049", idle2 = "76049494037641", walk = "92072849924640",
       run = "72301599441680", jump = "104325245285198", climb = "121152442762481", fall = "121152442762481"
   }
}

local function ApplyAnimation(animName)
   local plr = game.Players.LocalPlayer
   
   if plr.Character.Humanoid.RigType ~= Enum.HumanoidRigType.R15 then
       game:GetService("StarterGui"):SetCore("SendNotification", {
           Title = "Warning!",
           Text = "You must be R15 to use animations!",
           Duration = 5
       })
       NotifySound()
       return
   end
   
   local data = animationData[animName]
   if not data then return end
   
   currentAnimation = animName
   
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
   
   game:GetService("StarterGui"):SetCore("SendNotification", {
       Title = "Success!",
       Text = animName .. " animation applied!",
       Duration = 3
   })
   NotifySound()
end

local function ReapplyAnimation()
   if currentAnimation then
       ApplyAnimation(currentAnimation)
   end
end

local animations = {
   {name = "Levitation", emoji = "✨", color = Color3.fromRGB(138, 43, 226)},
   {name = "Astronaut", emoji = "🚀", color = Color3.fromRGB(30, 144, 255)},
   {name = "Ninja", emoji = "🥷", color = Color3.fromRGB(75, 75, 75)},
   {name = "Pirate", emoji = "🏴‍☠️", color = Color3.fromRGB(139, 69, 19)},
   {name = "Toy", emoji = "🧸", color = Color3.fromRGB(255, 182, 193)},
   {name = "Cowboy", emoji = "🤠", color = Color3.fromRGB(139, 90, 43)},
   {name = "Princess", emoji = "👸", color = Color3.fromRGB(255, 20, 147)},
   {name = "Knight", emoji = "⚔️", color = Color3.fromRGB(112, 128, 144)},
   {name = "Vampire", emoji = "🧛", color = Color3.fromRGB(139, 0, 0)},
   {name = "Patrol", emoji = "👮", color = Color3.fromRGB(0, 100, 0)},
   {name = "Elder", emoji = "👴", color = Color3.fromRGB(139, 137, 112)},
   {name = "Mage", emoji = "🧙", color = Color3.fromRGB(72, 61, 139)},
   {name = "Werewolf", emoji = "🐺", color = Color3.fromRGB(139, 90, 0)},
   {name = "Cartoony", emoji = "🎨", color = Color3.fromRGB(255, 165, 0)},
   {name = "Sneaky", emoji = "🤫", color = Color3.fromRGB(47, 79, 79)},
   {name = "Stylish", emoji = "💃", color = Color3.fromRGB(255, 105, 180)},
   {name = "Bubbly", emoji = "🫧", color = Color3.fromRGB(255, 182, 193)},
   {name = "Superhero", emoji = "🦸", color = Color3.fromRGB(220, 20, 60)},
   {name = "Stylized", emoji = "🎭", color = Color3.fromRGB(186, 85, 211)},
   {name = "Popstar", emoji = "⭐", color = Color3.fromRGB(255, 20, 147)},
   {name = "Wickind", emoji = "😈", color = Color3.fromRGB(255, 42, 200)}
}

for i, anim in ipairs(animations) do
   local Button = Instance.new("TextButton")
   local ButtonCorner = Instance.new("UICorner")
   
   Button.Name = anim.name .. "Button"
   Button.Parent = ScrollingFrame
   Button.BackgroundColor3 = anim.color
   Button.BorderSizePixel = 0
   Button.Font = Enum.Font.GothamBold
   Button.Text = anim.emoji .. " " .. anim.name
   Button.TextColor3 = Color3.fromRGB(255, 255, 255)
   Button.TextSize = 14
   Button.LayoutOrder = i
   
   ButtonCorner.CornerRadius = UDim.new(0, 6)
   ButtonCorner.Parent = Button
   
   Button.MouseEnter:Connect(function()
       Button.BackgroundColor3 = Color3.fromRGB(
           math.min(255, anim.color.R * 255 + 30),
           math.min(255, anim.color.G * 255 + 30),
           math.min(255, anim.color.B * 255 + 30)
       )
   end)
   
   Button.MouseLeave:Connect(function()
       Button.BackgroundColor3 = anim.color
   end)
   
   Button.MouseButton1Click:Connect(function()
       ApplyAnimation(anim.name)
   end)
end

local contentSize = math.ceil(#animations / 3) * (50 + 10) + 10
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, contentSize)

local UserInputService = game:GetService("UserInputService")

UserInputService.InputBegan:Connect(function(input)
   if input.KeyCode == Enum.KeyCode.K then
       if MainFrame.Visible then
           MainFrame.Visible = false
           if UserInputService.TouchEnabled then
               MinimizedFrame.Visible = true
           end
       else
           MainFrame.Visible = true
           MinimizedFrame.Visible = false
       end
   end
end)

ShowButton.MouseButton1Click:Connect(function()
   MainFrame.Visible = true
   MinimizedFrame.Visible = false
end)

DeleteButton.MouseButton1Click:Connect(function()
   ScreenGui:Destroy()
end)

CloseButton.MouseButton1Click:Connect(function()
   MainFrame.Visible = false
   if UserInputService.TouchEnabled then
       MinimizedFrame.Visible = true
   else
       ScreenGui:Destroy()
   end
end)

game.Players.LocalPlayer.CharacterAdded:Connect(function()
   wait(2)
   ReapplyAnimation()
end)

MainFrame.Size = UDim2.new(0, 0, 0, 0)
MainFrame:TweenSize(UDim2.new(0, 600, 0, 450), "Out", "Back", 0.5, true)
