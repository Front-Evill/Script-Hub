local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local TitleBar = Instance.new("Frame")
local TitleLabel = Instance.new("TextLabel")
local CloseButton = Instance.new("TextButton")
local MinimizeButton = Instance.new("TextButton")
local ContentFrame = Instance.new("Frame")
local TabContainer = Instance.new("Frame")
local PageContainer = Instance.new("ScrollingFrame")
local CountdownFrame = Instance.new("Frame")
local CountdownLabel = Instance.new("TextLabel")

local sound = Instance.new("Sound")
sound.SoundId = "rbxassetid://"
sound.Volume = 0.3
sound.Looped = true
sound.Parent = game.Workspace
sound:Play()

local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

ScreenGui.Name = "AnimationHubGUI"
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.Size = UDim2.new(0, 650, 0, 500)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Visible = true

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(60, 120, 255)
MainStroke.Thickness = 2
MainStroke.Parent = MainFrame

TitleBar.Name = "TitleBar"
TitleBar.Parent = MainFrame
TitleBar.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
TitleBar.BorderSizePixel = 0
TitleBar.Size = UDim2.new(1, 0, 0, 40)

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 12)
TitleCorner.Parent = TitleBar

TitleLabel.Name = "TitleLabel"
TitleLabel.Parent = TitleBar
TitleLabel.BackgroundTransparency = 1
TitleLabel.Position = UDim2.new(0, 15, 0, 0)
TitleLabel.Size = UDim2.new(0, 300, 1, 0)
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.Text = "🎭 Animation Hub Premium"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 16
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

CloseButton.Name = "CloseButton"
CloseButton.Parent = TitleBar
CloseButton.AnchorPoint = Vector2.new(1, 0)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
CloseButton.BorderSizePixel = 0
CloseButton.Position = UDim2.new(1, -10, 0, 8)
CloseButton.Size = UDim2.new(0, 24, 0, 24)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Text = "✕"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 12

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 6)
CloseCorner.Parent = CloseButton

MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Parent = TitleBar
MinimizeButton.AnchorPoint = Vector2.new(1, 0)
MinimizeButton.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
MinimizeButton.BorderSizePixel = 0
MinimizeButton.Position = UDim2.new(1, -40, 0, 8)
MinimizeButton.Size = UDim2.new(0, 24, 0, 24)
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.Text = "–"
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.TextSize = 14

local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(0, 6)
MinCorner.Parent = MinimizeButton

ContentFrame.Name = "ContentFrame"
ContentFrame.Parent = MainFrame
ContentFrame.BackgroundTransparency = 1
ContentFrame.Position = UDim2.new(0, 0, 0, 40)
ContentFrame.Size = UDim2.new(1, 0, 1, -40)

TabContainer.Name = "TabContainer"
TabContainer.Parent = ContentFrame
TabContainer.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
TabContainer.BorderSizePixel = 0
TabContainer.Size = UDim2.new(0, 150, 1, 0)

local TabCorner = Instance.new("UICorner")
TabCorner.CornerRadius = UDim.new(0, 8)
TabCorner.Parent = TabContainer

PageContainer.Name = "PageContainer"
PageContainer.Parent = ContentFrame
PageContainer.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
PageContainer.BorderSizePixel = 0
PageContainer.Position = UDim2.new(0, 160, 0, 10)
PageContainer.Size = UDim2.new(1, -170, 1, -20)
PageContainer.ScrollBarThickness = 8
PageContainer.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 120)

local PageCorner = Instance.new("UICorner")
PageCorner.CornerRadius = UDim.new(0, 8)
PageCorner.Parent = PageContainer

local PageLayout = Instance.new("UIListLayout")
PageLayout.Parent = PageContainer
PageLayout.FillDirection = Enum.FillDirection.Vertical
PageLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
PageLayout.Padding = UDim.new(0, 8)
PageLayout.SortOrder = Enum.SortOrder.LayoutOrder

local TabLayout = Instance.new("UIListLayout")
TabLayout.Parent = TabContainer
TabLayout.FillDirection = Enum.FillDirection.Vertical
TabLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
TabLayout.Padding = UDim.new(0, 5)
TabLayout.SortOrder = Enum.SortOrder.LayoutOrder

CountdownFrame.Name = "CountdownFrame"
CountdownFrame.Parent = ScreenGui
CountdownFrame.AnchorPoint = Vector2.new(0.5, 0.5)
CountdownFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
CountdownFrame.BackgroundTransparency = 0.5
CountdownFrame.BorderSizePixel = 0
CountdownFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
CountdownFrame.Size = UDim2.new(1, 0, 1, 0)
CountdownFrame.Visible = false

CountdownLabel.Name = "CountdownLabel"
CountdownLabel.Parent = CountdownFrame
CountdownLabel.AnchorPoint = Vector2.new(0.5, 0.5)
CountdownLabel.BackgroundTransparency = 1
CountdownLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
CountdownLabel.Size = UDim2.new(0, 200, 0, 100)
CountdownLabel.Font = Enum.Font.GothamBold
CountdownLabel.Text = "10"
CountdownLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
CountdownLabel.TextSize = 72

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

local danceData = {}
local notifications = {}

local function CreateNotification(title, message, duration)
  local NotifFrame = Instance.new("Frame")
  local NotifCorner = Instance.new("UICorner")
  local NotifTitle = Instance.new("TextLabel")
  local NotifMessage = Instance.new("TextLabel")
  local NotifLayout = Instance.new("UIListLayout")
  
  NotifFrame.Name = "Notification"
  NotifFrame.Parent = ScreenGui
  NotifFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
  NotifFrame.BorderSizePixel = 0
  NotifFrame.Position = UDim2.new(1, 20, 0, 100 + (#notifications * 80))
  NotifFrame.Size = UDim2.new(0, 300, 0, 70)
  
  NotifCorner.CornerRadius = UDim.new(0, 8)
  NotifCorner.Parent = NotifFrame
  
  NotifLayout.Parent = NotifFrame
  NotifLayout.FillDirection = Enum.FillDirection.Vertical
  NotifLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
  NotifLayout.Padding = UDim.new(0, 2)
  
  NotifTitle.Name = "Title"
  NotifTitle.Parent = NotifFrame
  NotifTitle.BackgroundTransparency = 1
  NotifTitle.Size = UDim2.new(1, -10, 0, 25)
  NotifTitle.Font = Enum.Font.GothamBold
  NotifTitle.Text = title
  NotifTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
  NotifTitle.TextSize = 14
  NotifTitle.TextXAlignment = Enum.TextXAlignment.Left
  
  NotifMessage.Name = "Message"
  NotifMessage.Parent = NotifFrame
  NotifMessage.BackgroundTransparency = 1
  NotifMessage.Size = UDim2.new(1, -10, 0, 40)
  NotifMessage.Font = Enum.Font.Gotham
  NotifMessage.Text = message
  NotifMessage.TextColor3 = Color3.fromRGB(200, 200, 200)
  NotifMessage.TextSize = 12
  NotifMessage.TextXAlignment = Enum.TextXAlignment.Left
  NotifMessage.TextWrapped = true
  
  table.insert(notifications, NotifFrame)
  
  NotifFrame:TweenPosition(UDim2.new(1, -320, 0, 100 + ((#notifications - 1) * 80)), "Out", "Back", 0.5, true)
  
  spawn(function()
      wait(duration or 5)
      NotifFrame:TweenPosition(UDim2.new(1, 20, 0, NotifFrame.Position.Y.Offset), "In", "Back", 0.3, true)
      wait(0.3)
      for i, notif in pairs(notifications) do
          if notif == NotifFrame then
              table.remove(notifications, i)
              break
          end
      end
      NotifFrame:Destroy()
  end)
end

local function StartCountdown()
  CountdownFrame.Visible = true
  for i = 10, 1, -1 do
      CountdownLabel.Text = tostring(i)
      wait(1)
  end
  CountdownFrame.Visible = false
end

local function FetchDances()
  spawn(function()
      local success, result = pcall(function()
          return game:HttpGet("https://catalog.roblox.com/v1/search/items/details?Category=12&Subcategory=39&SortType=1&SortAggregation=&limit=30&IncludeNotForSale=true&cursor=")
      end)
      
      if success then
          local data = HttpService:JSONDecode(result)
          for _, item in pairs(data.data) do
              if item.assetType == 61 then
                  table.insert(danceData, {
                      id = tostring(item.id),
                      name = item.name,
                      description = item.description or ""
                  })
              end
          end
          CreateNotification("Success!", .. #danceData .. "Is Done", 3)
      else
          CreateNotification("Error!", "Not Working", 5)
      end
  end)
end

local function PlayDance(danceId)
  local plr = game.Players.LocalPlayer
  local humanoid = plr.Character and plr.Character:FindFirstChild("Humanoid")
  
  if not humanoid then
      CreateNotification("Error!", "Character not found!", 3)
      return
  end
  
  local animation = Instance.new("Animation")
  animation.AnimationId = "rbxassetid://" .. danceId
  
  local animTrack = humanoid:LoadAnimation(animation)
  animTrack:Play()
end

local function ApplyAnimation(animName)
  local plr = game.Players.LocalPlayer
  
  if plr.Character.Humanoid.RigType ~= Enum.HumanoidRigType.R15 then
      CreateNotification("System Front", "You must be R15 to use animations!", 5)
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
  
  CreateNotification("Success!", animName .. " animation applied successfully!", 3)
end

local function CreateAnimButton(name, emoji, color)
  local Button = Instance.new("TextButton")
  local ButtonCorner = Instance.new("UICorner")
  local ButtonGradient = Instance.new("UIGradient")
  local ButtonStroke = Instance.new("UIStroke")
  
  Button.Name = name .. "Button"
  Button.Parent = PageContainer
  Button.BackgroundColor3 = color
  Button.BorderSizePixel = 0
  Button.Size = UDim2.new(1, -20, 0, 45)
  Button.Font = Enum.Font.GothamBold
  Button.Text = emoji .. " " .. name .. " Animation"
  Button.TextColor3 = Color3.fromRGB(255, 255, 255)
  Button.TextSize = 14
  
  ButtonCorner.CornerRadius = UDim.new(0, 8)
  ButtonCorner.Parent = Button
  
  ButtonGradient.Parent = Button
  ButtonGradient.Color = ColorSequence.new{
      ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
      ColorSequenceKeypoint.new(1, Color3.fromRGB(180, 180, 180))
  }
  ButtonGradient.Rotation = 45
  ButtonGradient.Transparency = NumberSequence.new(0.7)
  
  ButtonStroke.Parent = Button
  ButtonStroke.Color = Color3.fromRGB(255, 255, 255)
  ButtonStroke.Transparency = 0.8
  ButtonStroke.Thickness = 1
  
  Button.MouseEnter:Connect(function()
      Button:TweenSize(UDim2.new(1, -15, 0, 50), "Out", "Quad", 0.2, true)
      ButtonStroke.Transparency = 0.5
  end)
  
  Button.MouseLeave:Connect(function()
      Button:TweenSize(UDim2.new(1, -20, 0, 45), "Out", "Quad", 0.2, true)
      ButtonStroke.Transparency = 0.8
  end)
  
  Button.MouseButton1Click:Connect(function()
      ApplyAnimation(name)
  end)
  
  return Button
end

local function CreateDanceButton(danceInfo)
  local Button = Instance.new("TextButton")
  local ButtonCorner = Instance.new("UICorner")
  local ButtonStroke = Instance.new("UIStroke")
  local ImageLabel = Instance.new("ImageLabel")
  local ImageCorner = Instance.new("UICorner")
  
  Button.Name = danceInfo.name .. "Button"
  Button.Parent = PageContainer
  Button.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
  Button.BorderSizePixel = 0
  Button.Size = UDim2.new(1, -20, 0, 80)
  Button.Font = Enum.Font.GothamBold
  Button.Text = "  " .. danceInfo.name
  Button.TextColor3 = Color3.fromRGB(255, 255, 255)
  Button.TextSize = 12
  Button.TextXAlignment = Enum.TextXAlignment.Left
  
  ButtonCorner.CornerRadius = UDim.new(0, 8)
  ButtonCorner.Parent = Button
  
  ButtonStroke.Parent = Button
  ButtonStroke.Color = Color3.fromRGB(80, 80, 100)
  ButtonStroke.Transparency = 0.3
  ButtonStroke.Thickness = 2
  
  ImageLabel.Name = "DanceImage"
  ImageLabel.Parent = Button
  ImageLabel.BackgroundTransparency = 1
  ImageLabel.Position = UDim2.new(0, 10, 0, 10)
  ImageLabel.Size = UDim2.new(0, 60, 0, 60)
  ImageLabel.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
  
  ImageCorner.CornerRadius = UDim.new(0, 6)
  ImageCorner.Parent = ImageLabel
  
  spawn(function()
      local success, result = pcall(function()
          return "https://assetdelivery.roblox.com/v1/asset/?id=" .. danceInfo.id
      end)
      if success then
          ImageLabel.Image = result
      end
  end)
  
  Button.MouseEnter:Connect(function()
      Button.BackgroundColor3 = Color3.fromRGB(60, 120, 255)
      ButtonStroke.Color = Color3.fromRGB(255, 255, 255)
      Button:TweenSize(UDim2.new(1, -15, 0, 85), "Out", "Quad", 0.2, true)
  end)
  
  Button.MouseLeave:Connect(function()
      Button.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
      ButtonStroke.Color = Color3.fromRGB(80, 80, 100)
      Button:TweenSize(UDim2.new(1, -20, 0, 80), "Out", "Quad", 0.2, true)
  end)
  
  Button.MouseButton1Click:Connect(function()
      PlayDance(danceInfo.id)
  end)
  
  return Button
end

local currentTab = nil
local function CreateTab(name, emoji, animations)
  local TabButton = Instance.new("TextButton")
  local TabCorner = Instance.new("UICorner")
  local TabStroke = Instance.new("UIStroke")
  
  TabButton.Name = name .. "Tab"
  TabButton.Parent = TabContainer
  TabButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
  TabButton.BorderSizePixel = 0
  TabButton.Size = UDim2.new(1, -10, 0, 35)
  TabButton.Font = Enum.Font.GothamBold
  TabButton.Text = emoji .. " " .. name
  TabButton.TextColor3 = Color3.fromRGB(200, 200, 200)
  TabButton.TextSize = 12
  
  TabCorner.CornerRadius = UDim.new(0, 6)
  TabCorner.Parent = TabButton
  
  TabStroke.Parent = TabButton
  TabStroke.Color = Color3.fromRGB(0, 0, 0)
  TabStroke.Thickness = 2
  
  TabButton.MouseEnter:Connect(function()
      if currentTab ~= TabButton then
          TabButton.BackgroundColor3 = Color3.fromRGB(60, 120, 255)
          TabStroke.Color = Color3.fromRGB(255, 255, 255)
      end
  end)
  
  TabButton.MouseLeave:Connect(function()
      if currentTab ~= TabButton then
          TabButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
          TabStroke.Color = Color3.fromRGB(0, 0, 0)
      end
  end)
  
  TabButton.MouseButton1Click:Connect(function()
      if currentTab then
          currentTab.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
          currentTab.TextColor3 = Color3.fromRGB(200, 200, 200)
          currentTab:FindFirstChild("UIStroke").Color = Color3.fromRGB(0, 0, 0)
      end
      
      TabButton.BackgroundColor3 = Color3.fromRGB(60, 120, 255)
      TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
      TabStroke.Color = Color3.fromRGB(255, 255, 255)
      currentTab = TabButton
      
      for _, child in pairs(PageContainer:GetChildren()) do
          if child:IsA("TextButton") then
              child:Destroy()
          end
      end
      
      if name == "DANCE R15" then
          StartCountdown()
          wait(10)
          for _, dance in pairs(danceData) do
              CreateDanceButton(dance)
          end
          PageContainer.CanvasSize = UDim2.new(0, 0, 0, (#danceData * 88) + 20)
      else
          for _, anim in pairs(animations) do
              CreateAnimButton(anim.name, anim.emoji, anim.color)
          end
          PageContainer.CanvasSize = UDim2.new(0, 0, 0, (#animations * 53) + 20)
      end
  end)
  
  return TabButton
end

local basicAnims = {
  {name = "Levitation", emoji = "🔮", color = Color3.fromRGB(138, 43, 226)},
  {name = "Astronaut", emoji = "🚀", color = Color3.fromRGB(30, 144, 255)},
  {name = "Toy", emoji = "🧸", color = Color3.fromRGB(255, 182, 193)},
  {name = "Cartoony", emoji = "🎨", color = Color3.fromRGB(255, 165, 0)}
}

local fantasyAnims = {
  {name = "Ninja", emoji = "🥷", color = Color3.fromRGB(75, 75, 75)},
  {name = "Mage", emoji = "🧙", color = Color3.fromRGB(72, 61, 139)},
  {name = "Vampire", emoji = "🧛", color = Color3.fromRGB(139, 0, 0)},
  {name = "Werewolf", emoji = "🐺", color = Color3.fromRGB(139, 90, 0)},
  {name = "Knight", emoji = "⚔️", color = Color3.fromRGB(112, 128, 144)}
}

local characterAnims = {
  {name = "Pirate", emoji = "🏴‍☠️", color = Color3.fromRGB(139, 69, 19)},
  {name = "Cowboy", emoji = "🤠", color = Color3.fromRGB(139, 90, 43)},
  {name = "Princess", emoji = "👑", color = Color3.fromRGB(255, 20, 147)},
  {name = "Patrol", emoji = "👮", color = Color3.fromRGB(0, 100, 0)},
  {name = "Elder", emoji = "👴", color = Color3.fromRGB(139, 137, 112)}
}

local specialAnims = {
  {name = "Sneaky", emoji = "🕵️", color = Color3.fromRGB(47, 79, 79)},
  {name = "Stylish", emoji = "💃", color = Color3.fromRGB(255, 105, 180)},
  {name = "Bubbly", emoji = "💖", color = Color3.fromRGB(255, 182, 193)},
  {name = "Superhero", emoji = "🦸", color = Color3.fromRGB(220, 20, 60)},
  {name = "Stylized", emoji = "✨", color = Color3.fromRGB(186, 85, 211)},
  {name = "Popstar", emoji = "🎤", color = Color3.fromRGB(255, 20, 147)}
}

CreateTab("R15 Animations", "🎭", basicAnims)
CreateTab("Fantasy", "🔮", fantasyAnims)
CreateTab("Character", "👤", characterAnims)
CreateTab("Special", "⭐", specialAnims)
CreateTab("DANCE R15", "💃", {})

local ControlTab = CreateTab("Settings", "rbxassetid://10734950309", {})
ControlTab.MouseButton1Click:Connect(function()
  if currentTab then
      currentTab.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
      currentTab.TextColor3 = Color3.fromRGB(200, 200, 200)
      currentTab:FindFirstChild("UIStroke").Color = Color3.fromRGB(0, 0, 0)
  end
  
  ControlTab.BackgroundColor3 = Color3.fromRGB(60, 120, 255)
  ControlTab.TextColor3 = Color3.fromRGB(255, 255, 255)
  ControlTab:FindFirstChild("UIStroke").Color = Color3.fromRGB(255, 255, 255)
  currentTab = ControlTab
  
  for _, child in pairs(PageContainer:GetChildren()) do
      if child:IsA("TextButton") or child:IsA("Frame") then
          child:Destroy()
      end
  end
  
  local ResetButton = Instance.new("TextButton")
  local ResetCorner = Instance.new("UICorner")
  ResetButton.Name = "ResetButton"
  ResetButton.Parent = PageContainer
  ResetButton.BackgroundColor3 = Color3.fromRGB(255, 75, 75)
  ResetButton.BorderSizePixel = 0
  ResetButton.Size = UDim2.new(1, -20, 0, 45)
  ResetButton.Font = Enum.Font.GothamBold
  ResetButton.Text = "Reset Character"
  ResetButton.TextColor3 = Color3.fromRGB(255, 255, 255)
  ResetButton.TextSize = 14
  ResetCorner.CornerRadius = UDim.new(0, 8)
  ResetCorner.Parent = ResetButton
  ResetButton.MouseButton1Click:Connect(function()
      game.Players.LocalPlayer.Character.Humanoid.Health = 0
  end)
  
  local RefreshButton = Instance.new("TextButton")
  local RefreshCorner = Instance.new("UICorner")
  RefreshButton.Name = "RefreshButton"
  RefreshButton.Parent = PageContainer
  RefreshButton.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
  RefreshButton.BorderSizePixel = 0
  RefreshButton.Size = UDim2.new(1, -20, 0, 45)
  RefreshButton.Font = Enum.Font.GothamBold
  RefreshButton.Text = "Refresh Dances"
  RefreshButton.TextColor3 = Color3.fromRGB(255, 255, 255)
  RefreshButton.TextSize = 14
  RefreshCorner.CornerRadius = UDim.new(0, 8)
  RefreshCorner.Parent = RefreshButton
  RefreshButton.MouseButton1Click:Connect(function()
      danceData = {}
      FetchDances()
  end)
  
  local MusicFrame = Instance.new("Frame")
  local MusicCorner = Instance.new("UICorner")
  local MusicLabel = Instance.new("TextLabel")
  local MusicToggle = Instance.new("TextButton")
  local ToggleCorner = Instance.new("UICorner")
  
  MusicFrame.Name = "MusicFrame"
  MusicFrame.Parent = PageContainer
  MusicFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
  MusicFrame.BorderSizePixel = 0
  MusicFrame.Size = UDim2.new(1, -20, 0, 60)
  MusicCorner.CornerRadius = UDim.new(0, 8)
  MusicCorner.Parent = MusicFrame
  
  MusicLabel.Name = "MusicLabel"
  MusicLabel.Parent = MusicFrame
  MusicLabel.BackgroundTransparency = 1
  MusicLabel.Position = UDim2.new(0, 15, 0, 0)
  MusicLabel.Size = UDim2.new(0, 200, 1, 0)
  MusicLabel.Font = Enum.Font.GothamBold
  MusicLabel.Text = "Background Music"
  MusicLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
  MusicLabel.TextSize = 14
  MusicLabel.TextXAlignment = Enum.TextXAlignment.Left
  
  MusicToggle.Name = "MusicToggle"
  MusicToggle.Parent = MusicFrame
  MusicToggle.AnchorPoint = Vector2.new(1, 0.5)
  MusicToggle.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
  MusicToggle.BorderSizePixel = 0
  MusicToggle.Position = UDim2.new(1, -15, 0.5, 0)
  MusicToggle.Size = UDim2.new(0, 60, 0, 30)
  MusicToggle.Font = Enum.Font.GothamBold
  MusicToggle.Text = "ON"
  MusicToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
  MusicToggle.TextSize = 12
  ToggleCorner.CornerRadius = UDim.new(0, 6)
  ToggleCorner.Parent = MusicToggle
  
  local musicOn = true
  MusicToggle.MouseButton1Click:Connect(function()
      musicOn = not musicOn
      if musicOn then
          sound:Play()
          MusicToggle.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
          MusicToggle.Text = "ON"
      else
          sound:Stop()
          MusicToggle.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
          MusicToggle.Text = "OFF"
      end
  end)
  
  PageContainer.CanvasSize = UDim2.new(0, 0, 0, 220)
end)

local isMinimized = false
MinimizeButton.MouseButton1Click:Connect(function()
  isMinimized = not isMinimized
  if isMinimized then
      MainFrame:TweenSize(UDim2.new(0, 650, 0, 40), "Out", "Quad", 0.3, true)
      ContentFrame.Visible = false
      MinimizeButton.Text = "+"
  else
      MainFrame:TweenSize(UDim2.new(0, 650, 0, 500), "Out", "Quad", 0.3, true)
      ContentFrame.Visible = true
      MinimizeButton.Text = "–"
  end
end)

CloseButton.MouseButton1Click:Connect(function()
  sound:Stop()
  ScreenGui:Destroy()
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
  if gameProcessed then return end
  
  if input.KeyCode == Enum.KeyCode.K then
      MainFrame.Visible = not MainFrame.Visible
  end
end)

MainFrame.Size = UDim2.new(0, 0, 0, 0)
MainFrame:TweenSize(UDim2.new(0, 650, 0, 500), "Out", "Back", 0.5, true)

FetchDances()

CreateNotification("Animation Hub", "Welcome to Animation Hub Premium! Press K to toggle GUI visibility.", 4)

spawn(function()
  while TitleLabel.Parent do
      for i = 1, 3 do
          TitleLabel.Text = "Animation Hub Premium" .. string.rep(".", i)
          wait(0.5)
      end
      TitleLabel.Text = "Animation Hub Premium"
      wait(1)
  end
end)
