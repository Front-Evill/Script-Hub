local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local MarketplaceService = game:GetService("MarketplaceService")
local HttpService = game:GetService("HttpService")

local player = Players.LocalPlayer
local camera = workspace.CurrentCamera

local enabled = true
local currentTarget = nil
local gui = {}
local espEnabled = true
local espBoxes = {}
local isMM2 = false


local function checkIfMM2()
   local placeId = game.PlaceId
   if placeId == 142823291 then
       isMM2 = true
   else
       isMM2 = false
   end
end

local colors = {
  Color3.new(1, 0, 0),
  Color3.new(0, 1, 0),
  Color3.new(0, 0, 1),
  Color3.new(1, 1, 0),
  Color3.new(1, 0, 1),
  Color3.new(0, 1, 1),
  Color3.new(1, 0.5, 0),
  Color3.new(0.5, 0, 1),
  Color3.new(1, 0.5, 0.5),
  Color3.new(0.5, 1, 0.5)
}

local function getPlayerColor(targetPlayer)
  local index = 1
  for i, p in pairs(Players:GetPlayers()) do
      if p == targetPlayer then
          index = i
          break
      end
  end
  return colors[(index % #colors) + 1]
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
--[[
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
--]]
local function createESP(targetPlayer)
  if espBoxes[targetPlayer] then return end
  
  local espGui = Instance.new("BillboardGui")
  espGui.Name = "ESP_" .. targetPlayer.Name
  espGui.Size = UDim2.new(0, 35, 0, 55)
  espGui.StudsOffset = Vector3.new(0, 0, 0)
  espGui.AlwaysOnTop = true
  espGui.LightInfluence = 0
  
  local box = Instance.new("Frame")
  box.Size = UDim2.new(1, 0, 1, 0)
  box.BackgroundTransparency = 1
  box.Parent = espGui
  
  local outline = Instance.new("UIStroke")
  outline.Thickness = 1.5
  outline.Transparency = 0
  outline.Parent = box
  
  local corner = Instance.new("UICorner")
  corner.CornerRadius = UDim.new(0, 3)
  corner.Parent = box
  
  local nameLabel = Instance.new("TextLabel")
  nameLabel.Size = UDim2.new(1, 0, 0, 12)
  nameLabel.Position = UDim2.new(0, 0, 0.5, -6)
  nameLabel.BackgroundTransparency = 1
  nameLabel.Text = string.sub(targetPlayer.Name, 1, 8)
  nameLabel.TextScaled = true
  nameLabel.Font = Enum.Font.GothamMedium
  nameLabel.TextStrokeTransparency = 0.2
  nameLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
  nameLabel.Parent = box
  
  local roleLabel = Instance.new("TextLabel")
  roleLabel.Size = UDim2.new(1, 0, 0, 10)
  roleLabel.Position = UDim2.new(0, 0, 0, 2)
  roleLabel.BackgroundTransparency = 1
  roleLabel.TextScaled = true
  roleLabel.Font = Enum.Font.GothamBold
  roleLabel.TextStrokeTransparency = 0.2
  roleLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
  roleLabel.Parent = box
  
  local distanceLabel = Instance.new("TextLabel")
  distanceLabel.Size = UDim2.new(1, 0, 0, 8)
  distanceLabel.Position = UDim2.new(0, 0, 1, 2)
  distanceLabel.BackgroundTransparency = 1
  distanceLabel.Text = "0m"
  distanceLabel.TextColor3 = Color3.new(0.8, 0.8, 0.8)
  distanceLabel.TextScaled = true
  distanceLabel.Font = Enum.Font.Gotham
  distanceLabel.TextStrokeTransparency = 0.2
  distanceLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
  distanceLabel.Parent = box
  
  local healthBar = Instance.new("Frame")
  healthBar.Size = UDim2.new(0.8, 0, 0, 3)
  healthBar.Position = UDim2.new(0.1, 0, 1, 12)
  healthBar.BackgroundColor3 = Color3.new(0, 1, 0)
  healthBar.BorderSizePixel = 0
  healthBar.Parent = box
  
  local healthCorner = Instance.new("UICorner")
  healthCorner.CornerRadius = UDim.new(0, 2)
  healthCorner.Parent = healthBar
  
  local healthBG = Instance.new("Frame")
  healthBG.Size = UDim2.new(0.8, 0, 0, 3)
  healthBG.Position = UDim2.new(0.1, 0, 1, 12)
  healthBG.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
  healthBG.BorderSizePixel = 0
  healthBG.ZIndex = healthBar.ZIndex - 1
  healthBG.Parent = box
  
  local healthBGCorner = Instance.new("UICorner")
  healthBGCorner.CornerRadius = UDim.new(0, 2)
  healthBGCorner.Parent = healthBG
  
  espBoxes[targetPlayer] = {
      gui = espGui,
      box = box,
      outline = outline,
      nameLabel = nameLabel,
      roleLabel = roleLabel,
      distanceLabel = distanceLabel,
      healthBar = healthBar
  }
end

local function updateESP(targetPlayer)
  if not espBoxes[targetPlayer] or not targetPlayer.Character then return end
  
  local character = targetPlayer.Character
  local humanoid = character:FindFirstChild("Humanoid")
  local rootPart = character:FindFirstChild("HumanoidRootPart")
  
  if humanoid and rootPart then
      local esp = espBoxes[targetPlayer]
      
      if humanoid.Health <= 0 then
          esp.gui.Enabled = false
          return
      else
          esp.gui.Enabled = espEnabled
      end
      
      esp.gui.Adornee = rootPart

      --[[
      if isMM2 then
          local role = getPlayerRole(targetPlayer)
          local roleColor = getRoleColor(role)
          esp.outline.Color = roleColor
          esp.nameLabel.TextColor3 = roleColor
          
          if role == "Murderer" then
              esp.roleLabel.Text = "mur."
          elseif role == "Sheriff" then
              esp.roleLabel.Text = "she."
          elseif role == "Innocent" then
              esp.roleLabel.Text = "inc."
          else
              esp.roleLabel.Text = "unk."
          end
          esp.roleLabel.TextColor3 = roleColor
      else
          local playerColor = getPlayerColor(targetPlayer)
          esp.outline.Color = playerColor
          esp.nameLabel.TextColor3 = playerColor
          esp.roleLabel.Text = "â­گ"
          esp.roleLabel.TextColor3 = playerColor
      end
      --]]
      
      local distance = math.floor((rootPart.Position - camera.CFrame.Position).Magnitude)
      esp.distanceLabel.Text = distance .. "m"
      
      local health = math.floor(humanoid.Health)
      local healthPercent = health / humanoid.MaxHealth
      
      esp.healthBar.Size = UDim2.new(0.8 * healthPercent, 0, 0, 3)
      
      if healthPercent > 0.6 then
          esp.healthBar.BackgroundColor3 = Color3.new(0, 1, 0)
      elseif healthPercent > 0.3 then
          esp.healthBar.BackgroundColor3 = Color3.new(1, 1, 0)
      else
          esp.healthBar.BackgroundColor3 = Color3.new(1, 0, 0)
      end
      
      esp.gui.Parent = character
  end
end

local function removeESP(targetPlayer)
  if espBoxes[targetPlayer] then
      if espBoxes[targetPlayer].gui then
          espBoxes[targetPlayer].gui:Destroy()
      end
      espBoxes[targetPlayer] = nil
  end
end

-- تحديد لاعب  محلي هل هو قاتل او شيرف  | تحديد نوع ايم بوت
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
       local nearest = nil
       local shortestDist = 200
       
       for _, p in pairs(Players:GetPlayers()) do
           if p ~= player and p.Character and p.Character:FindFirstChild("Head") and p.Character:FindFirstChild("Humanoid") then
               if p.Character.Humanoid.Health > 0 then
                   local dist = (p.Character.Head.Position - camera.CFrame.Position).Magnitude
                   if dist < shortestDist then
                       nearest = p
                       shortestDist = dist
                   end
               end
           end
       end
       
       return nearest
   end
end

local function aimAt()
  while true do
      if enabled then
          local target = findTarget()
          if target and target.Character then
              local targetPart = nil
              
              if isMM2 then
                  local myRole = getMyRole()
                  if myRole == "Murderer" then
                      targetPart = target.Character:FindFirstChild("HumanoidRootPart")
                  elseif myRole == "Sheriff" then
                      targetPart = target.Character:FindFirstChild("Head")
                  end
              else
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
  
  local espStatus = Instance.new("TextLabel")
  espStatus.Size = UDim2.new(1, -10, 0, 18)
  espStatus.Position = UDim2.new(0, 5, 0, 55)
  espStatus.BackgroundTransparency = 1
  espStatus.Text = "ESP: ON | T/E Toggle"
  espStatus.TextColor3 = Color3.new(0.3, 0.8, 1)
  espStatus.TextScaled = true
  espStatus.Font = Enum.Font.Gotham
  espStatus.TextStrokeTransparency = 0.7
  espStatus.TextStrokeColor3 = Color3.new(0, 0, 0)
  espStatus.Parent = mainFrame
  
  gui.status = status
  gui.espStatus = espStatus
  gui.glow = glow
  
  if isMM2 then
      local roleStatus = Instance.new("TextLabel")
      roleStatus.Size = UDim2.new(1, -10, 0, 16)
      roleStatus.Position = UDim2.new(0, 5, 0, 75)
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
                  gui.status.Text = currentTarget and ("Targeting: " .. string.sub(currentTarget.Name, 1, 10)) or "Active - Searching"
                  gui.status.TextColor3 = currentTarget and Color3.new(1, 0.2, 0.2) or Color3.new(0, 1, 0.3)
              end
          else
              gui.status.Text = "Disabled"
              gui.status.TextColor3 = Color3.new(0.5, 0.5, 0.5)
          end
      end
      
      if gui.espStatus then
          gui.espStatus.Text = espEnabled and "ESP: ON | T/E Toggle" or "ESP: OFF | T/E Toggle"
          gui.espStatus.TextColor3 = espEnabled and Color3.new(0.3, 0.8, 1) or Color3.new(0.5, 0.5, 0.5)
      end
      
      if isMM2 and gui.roleStatus then
          local myRole = getMyRole()
          local roleColor = getRoleColor(myRole)
          local roleIcon = ""
          
          if myRole == "Murderer" then
              roleIcon = "mur. "
          elseif myRole == "Sheriff" then
              roleIcon = "she. "
          elseif myRole == "Innocent" then
              roleIcon = "inc. "
          end
          
          gui.roleStatus.Text = roleIcon .. myRole
          gui.roleStatus.TextColor3 = roleColor
      end
      
      task.wait()
  end
end

local function manageESP()
  while true do
      for _, targetPlayer in pairs(Players:GetPlayers()) do
          if targetPlayer ~= player then
              if targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
                  if not espBoxes[targetPlayer] then
                      createESP(targetPlayer)
                  end
                  updateESP(targetPlayer)
              else
                  removeESP(targetPlayer)
              end
          end
      end
      
      for targetPlayer, _ in pairs(espBoxes) do
          if not targetPlayer.Parent then
              removeESP(targetPlayer)
          end
      end
      
      task.wait()
  end
end

Players.PlayerRemoving:Connect(function(targetPlayer)
  removeESP(targetPlayer)
end)

player.CharacterAdded:Connect(function()
  task.wait(1)
  if not player.PlayerGui:FindFirstChild("FrontEvilGUI") then
      createGUI()
  end
end)

UserInputService.InputBegan:Connect(function(input)
  if input.KeyCode == Enum.KeyCode.T then
      enabled = not enabled
  elseif input.KeyCode == Enum.KeyCode.E then
      espEnabled = not espEnabled
      for _, esp in pairs(espBoxes) do
          if esp.gui then
              esp.gui.Enabled = espEnabled
          end
      end
  end
end)

checkIfMM2()
createGUI()
task.spawn(aimAt)
task.spawn(updateGUI)
task.spawn(manageESP)
