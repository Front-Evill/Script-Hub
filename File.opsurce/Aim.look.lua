local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local camera = workspace.CurrentCamera

local enabled = true
local currentTarget = nil
local gui = {}
local isMM2 = false

local function checkIfMM2()
   local placeId = game.PlaceId
   if placeId == 142823291 then
       isMM2 = true
   else
       isMM2 = false
   end
end

local function getPlayerRole(targetPlayer)
   if not isMM2 then return "Player" end
   
   if targetPlayer.Character then
       local backpack = targetPlayer:FindFirstChild("Backpack")
       local character = targetPlayer.Character
       
       if character:FindFirstChild("Knife") or (backpack and backpack:FindFirstChild("Knife")) then
           return "Murderer"
       elseif character:FindFirstChild("Gun") or (backpack and backpack:FindFirstChild("Gun")) then
           return "Sheriff"
       else
           return "Innocent"
       end
   end
   return "Unknown"
end

local function getMyRole()
   return getPlayerRole(player)
end

local function getRoleColor(role)
   if role == "Murderer" then
       return Color3.new(1, 0, 0)
   elseif role == "Sheriff" then
       return Color3.new(0, 0.5, 1)
   elseif role == "Innocent" then
       return Color3.new(0, 1, 0.3)
   else
       return Color3.new(1, 1, 1)
   end
end

local function findTarget()
   if isMM2 then
       local myRole = getMyRole()
       if myRole == "Innocent" then
           return nil
       end
       
       local nearest = nil
       local shortestDist = 200
       
       for _, p in pairs(Players:GetPlayers()) do
           if p ~= player and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character:FindFirstChild("Humanoid") then
               if p.Character.Humanoid.Health > 0 then
                   local playerRole = getPlayerRole(p)
                   local shouldTarget = false
                   
                   if myRole == "Sheriff" and playerRole == "Murderer" then
                       shouldTarget = true
                   elseif myRole == "Murderer" and playerRole ~= "Murderer" then
                       shouldTarget = true
                   end
                   
                   if shouldTarget then
                       local dist = (p.Character.HumanoidRootPart.Position - camera.CFrame.Position).Magnitude
                       if dist < shortestDist then
                           nearest = p
                           shortestDist = dist
                       end
                   end
               end
           end
       end
       
       return nearest
   else
       return nil -- لن يعمل الـ aimbot خارج MM2
   end
end

local function aimAt()
  while true do
      if enabled and isMM2 then
          local target = findTarget()
          if target and target.Character then
              local targetPart = nil
              
              local myRole = getMyRole()
              if myRole == "Murderer" then
                  targetPart = target.Character:FindFirstChild("HumanoidRootPart")
              elseif myRole == "Sheriff" then
                  targetPart = target.Character:FindFirstChild("Head")
              end
              
              if targetPart and target.Character:FindFirstChild("Humanoid") and target.Character.Humanoid.Health > 0 then
                  currentTarget = target
                  local targetPos = targetPart.Position
                  local newCFrame = CFrame.lookAt(camera.CFrame.Position, targetPos)
                  camera.CFrame = camera.CFrame:Lerp(newCFrame, 0.2)
              else
                  currentTarget = nil
              end
          else
              currentTarget = nil
          end
      end
      task.wait()
  end
end

local function createGUI()
  local screenGui = Instance.new("ScreenGui")
  screenGui.Name = "FrontEvilGUI"
  screenGui.Parent = player.PlayerGui
  screenGui.ResetOnSpawn = false
  
  local mainFrame = Instance.new("Frame")
  mainFrame.Size = UDim2.new(0, 280, 0, isMM2 and 100 or 80)
  mainFrame.Position = UDim2.new(0.5, -140, 0, 15)
  mainFrame.BackgroundColor3 = Color3.new(0.08, 0.08, 0.12)
  mainFrame.BackgroundTransparency = 0.1
  mainFrame.BorderSizePixel = 0
  mainFrame.Parent = screenGui
  
  local corner = Instance.new("UICorner")
  corner.CornerRadius = UDim.new(0, 8)
  corner.Parent = mainFrame
  
  local glow = Instance.new("UIStroke")
  glow.Color = Color3.new(0.3, 0.3, 0.8)
  glow.Thickness = 1
  glow.Transparency = 0.3
  glow.Parent = mainFrame
  
  local titleFrame = Instance.new("Frame")
  titleFrame.Size = UDim2.new(1, 0, 0, 35)
  titleFrame.Position = UDim2.new(0, 0, 0, 0)
  titleFrame.BackgroundTransparency = 1
  titleFrame.Parent = mainFrame
  
  local front = Instance.new("TextLabel")
  front.Size = UDim2.new(0.5, 0, 1, 0)
  front.Position = UDim2.new(0, 0, 0, 0)
  front.BackgroundTransparency = 1
  front.Text = "FRONT"
  front.TextColor3 = Color3.new(1, 0.2, 0.2)
  front.TextScaled = true
  front.Font = Enum.Font.GothamBold
  front.TextStrokeTransparency = 0.5
  front.TextStrokeColor3 = Color3.new(0, 0, 0)
  front.Parent = titleFrame
  
  local evil = Instance.new("TextLabel")
  evil.Size = UDim2.new(0.5, 0, 1, 0)
  evil.Position = UDim2.new(0.5, 0, 0, 0)
  evil.BackgroundTransparency = 1
  evil.Text = "EVIL"
  evil.TextColor3 = Color3.new(0.8, 0, 1)
  evil.TextScaled = true
  evil.Font = Enum.Font.GothamBold
  evil.TextStrokeTransparency = 0.5
  evil.TextStrokeColor3 = Color3.new(0, 0, 0)
  evil.Parent = titleFrame
  
  local status = Instance.new("TextLabel")
  status.Size = UDim2.new(1, -10, 0, 20)
  status.Position = UDim2.new(0, 5, 0, 35)
  status.BackgroundTransparency = 1
  status.Text = "Active"
  status.TextColor3 = Color3.new(0, 1, 0.3)
  status.TextScaled = true
  status.Font = Enum.Font.Gotham
  status.TextStrokeTransparency = 0.7
  status.TextStrokeColor3 = Color3.new(0, 0, 0)
  status.Parent = mainFrame
  
  gui.status = status
  gui.glow = glow
  
  if isMM2 then
      local roleStatus = Instance.new("TextLabel")
      roleStatus.Size = UDim2.new(1, -10, 0, 16)
      roleStatus.Position = UDim2.new(0, 5, 0, 55)
      roleStatus.BackgroundTransparency = 1
      roleStatus.Text = "Role: Unknown"
      roleStatus.TextColor3 = Color3.new(1, 1, 0.3)
      roleStatus.TextScaled = true
      roleStatus.Font = Enum.Font.GothamMedium
      roleStatus.TextStrokeTransparency = 0.7
      roleStatus.TextStrokeColor3 = Color3.new(0, 0, 0)
      roleStatus.Parent = mainFrame
      
      gui.roleStatus = roleStatus
  end
  
  local colorCycle1 = {
      Color3.new(1, 0, 0),
      Color3.new(1, 0.5, 0),
      Color3.new(1, 1, 0),
      Color3.new(0, 1, 0),
      Color3.new(0, 1, 1),
      Color3.new(0, 0, 1),
      Color3.new(0.5, 0, 1),
      Color3.new(1, 0, 1)
  }
  
  local colorCycle2 = {
      Color3.new(0.8, 0, 1),
      Color3.new(0, 0.8, 1),
      Color3.new(0, 1, 0.8),
      Color3.new(0.8, 1, 0),
      Color3.new(1, 0.8, 0),
      Color3.new(1, 0, 0.8),
      Color3.new(1, 0.2, 0.2),
      Color3.new(0.2, 1, 0.2)
  }
  
  local glowCycle = {
      Color3.new(1, 0.2, 0.2),
      Color3.new(0.2, 0.2, 1),
      Color3.new(0.2, 1, 0.2),
      Color3.new(1, 0.2, 1),
      Color3.new(1, 1, 0.2),
      Color3.new(0.2, 1, 1)
  }
  
  task.spawn(function()
      local index = 1
      while true do
          local tweenInfo = TweenInfo.new(1.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
          TweenService:Create(front, tweenInfo, {TextColor3 = colorCycle1[index]}):Play()
          TweenService:Create(evil, tweenInfo, {TextColor3 = colorCycle2[index]}):Play()
          TweenService:Create(glow, tweenInfo, {Color = glowCycle[(index % #glowCycle) + 1]}):Play()
          
          index = (index % #colorCycle1) + 1
          task.wait(1.2)
      end
  end)
end

local function updateGUI()
  while true do
      if gui.status then
          if enabled then
              if isMM2 then
                  local myRole = getMyRole()
                  if myRole == "Innocent" then
                      gui.status.Text = "Disabled (Innocent)"
                      gui.status.TextColor3 = Color3.new(0.5, 0.5, 0.5)
                  elseif currentTarget then
                      gui.status.Text = "Targeting: " .. string.sub(currentTarget.Name, 1, 10)
                      gui.status.TextColor3 = Color3.new(1, 0.2, 0.2)
                  else
                      gui.status.Text = "Active - Searching"
                      gui.status.TextColor3 = Color3.new(0, 1, 0.3)
                  end
              else
                  gui.status.Text = "MM2 Only"
                  gui.status.TextColor3 = Color3.new(0.5, 0.5, 0.5)
              end
          else
              gui.status.Text = "Disabled"
              gui.status.TextColor3 = Color3.new(0.5, 0.5, 0.5)
          end
      end
      
      if isMM2 and gui.roleStatus then
          local myRole = getMyRole()
          local roleColor = getRoleColor(myRole)
          local roleIcon = ""
          
          if myRole == "Murderer" then
              roleIcon = "🔪 "
          elseif myRole == "Sheriff" then
              roleIcon = "🔫 "
          elseif myRole == "Innocent" then
              roleIcon = "👤 "
          end
          
          gui.roleStatus.Text = roleIcon .. myRole
          gui.roleStatus.TextColor3 = roleColor
      end
      
      task.wait()
  end
end

player.CharacterAdded:Connect(function()
  task.wait(1)
  if not player.PlayerGui:FindFirstChild("FrontEvilGUI") then
      createGUI()
  end
end)

UserInputService.InputBegan:Connect(function(input)
  if input.KeyCode == Enum.KeyCode.T then
      enabled = not enabled
  end
end)

checkIfMM2()
createGUI()
task.spawn(aimAt)
task.spawn(updateGUI)
