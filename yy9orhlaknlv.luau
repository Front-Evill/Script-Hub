local screenGui = Instance.new("ScreenGui")
screenGui.Name = "FRONT_EVILL_GUI"
screenGui.Parent = game.CoreGui
screenGui.ResetOnSpawn = false

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")

local localPlayer = Players.LocalPlayer

local MovementController = {}
MovementController.__index = MovementController

function MovementController.new()
    local self = setmetatable({}, MovementController)
    self.originalPosition = nil
    self.isRandomTeleporting = false
    self.teleportConnection = nil
    self.lastTeleportPosition = nil
    return self
end

function MovementController:saveOriginalPosition()
    if localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
        self.originalPosition = localPlayer.Character.HumanoidRootPart.CFrame
    end
end

function MovementController:getRandomGroundPosition()
    if not localPlayer.Character or not localPlayer.Character:FindFirstChild("HumanoidRootPart") then
        return Vector3.new(0, 10, 0)
    end
    
    local currentPos = localPlayer.Character.HumanoidRootPart.Position
    local randomX = currentPos.X + math.random(-50, 50)
    local randomZ = currentPos.Z + math.random(-50, 50)
    
    local rayOrigin = Vector3.new(randomX, currentPos.Y + 100, randomZ)
    local rayDirection = Vector3.new(0, -200, 0)
    
    local raycastParams = RaycastParams.new()
    raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
    raycastParams.FilterDescendantsInstances = {localPlayer.Character}
    
    local raycastResult = workspace:Raycast(rayOrigin, rayDirection, raycastParams)
    
    if raycastResult then
        return raycastResult.Position + Vector3.new(0, 3, 0)
    else
        return Vector3.new(randomX, currentPos.Y, randomZ)
    end
end

function MovementController:startRandomTeleport()
    if self.isRandomTeleporting then return end
    
    self:saveOriginalPosition()
    self.isRandomTeleporting = true
    
    self.teleportConnection = RunService.Heartbeat:Connect(function()
        if localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local randomPos = self:getRandomGroundPosition()
            localPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(randomPos)
            self.lastTeleportPosition = randomPos
        end
        wait(0.05)
    end)
end

function MovementController:stopRandomTeleport()
    if not self.isRandomTeleporting then return end
    
    self.isRandomTeleporting = false
    
    if self.teleportConnection then
        self.teleportConnection:Disconnect()
        self.teleportConnection = nil
    end
    
    wait(0.1)
    
    if self.originalPosition and localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
        localPlayer.Character.HumanoidRootPart.CFrame = self.originalPosition
    end
end

function MovementController:isActive()
    return self.isRandomTeleporting
end

local ProtectionController = {}
ProtectionController.__index = ProtectionController

function ProtectionController.new()
    local self = setmetatable({}, ProtectionController)
    self.isProtecting = false
    self.protectionConnection = nil
    self.targetPlayer = nil
    return self
end

function ProtectionController:setTarget(player)
    self.targetPlayer = player
end

function ProtectionController:startProtection()
    if self.isProtecting then return end
    if not self.targetPlayer then return end
    
    self.isProtecting = true
    
    self.protectionConnection = RunService.Heartbeat:Connect(function()
        if not self.targetPlayer or not self.targetPlayer.Character then
            self:stopProtection()
            return
        end
        
        local targetRoot = self.targetPlayer.Character:FindFirstChild("HumanoidRootPart")
        local myRoot = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")
        
        if targetRoot and myRoot then
            local behindPosition = targetRoot.Position - (targetRoot.CFrame.LookVector * 3)
            myRoot.CFrame = CFrame.new(behindPosition, targetRoot.Position)
        end
    end)
end

function ProtectionController:stopProtection()
    self.isProtecting = false
    
    if self.protectionConnection then
        self.protectionConnection:Disconnect()
        self.protectionConnection = nil
    end
end

function ProtectionController:toggle()
    if self.isProtecting then
        self:stopProtection()
    else
        self:startProtection()
    end
    return self.isProtecting
end

function ProtectionController:isActive()
    return self.isProtecting
end

local BombDetector = {}
BombDetector.__index = BombDetector

function BombDetector.new()
    local self = setmetatable({}, BombDetector)
    return self
end

function BombDetector:getBomb()
    if not localPlayer.Character then return nil end
    
    for _, item in pairs(localPlayer.Character:GetChildren()) do
        if item:IsA("Tool") then
            return item
        end
    end
    
    for _, item in pairs(localPlayer.Backpack:GetChildren()) do
        if item:IsA("Tool") then
            return item
        end
    end
    
    return nil
end

local BombTransferController = {}
BombTransferController.__index = BombTransferController

function BombTransferController.new(bombDetector)
    local self = setmetatable({}, BombTransferController)
    self.bombDetector = bombDetector
    self.autoTransferEnabled = false
    self.transferConnection = nil
    self.targetPlayer = nil
    self.originalPosition = nil
    return self
end

function BombTransferController:setTarget(player)
    self.targetPlayer = player
end

function BombTransferController:savePosition()
    if localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
        self.originalPosition = localPlayer.Character.HumanoidRootPart.CFrame
    end
end

function BombTransferController:returnToOriginalPosition()
    if self.originalPosition and localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
        localPlayer.Character.HumanoidRootPart.CFrame = self.originalPosition
    end
end

function BombTransferController:teleportToPlayer(player)
    if not localPlayer.Character or not localPlayer.Character:FindFirstChild("HumanoidRootPart") then
        return
    end
    
    if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local targetPosition = player.Character.HumanoidRootPart.Position
        local targetCFrame = player.Character.HumanoidRootPart.CFrame
        
        local frontPosition = targetPosition + targetCFrame.LookVector * -1.5
        localPlayer.Character.HumanoidRootPart.CFrame = CFrame.lookAt(frontPosition, targetPosition)
        
        wait(0.1)
    end
end

function BombTransferController:directBombTransfer(player)
    if not player or not player.Character then return false end
    
    local bombTool = self.bombDetector:getBomb()
    if not bombTool then return false end
    
    bombTool.Parent = player.Character
    
    spawn(function()
        wait(0.1)
        if bombTool and bombTool.Parent == player.Character then
            if bombTool:FindFirstChild("Handle") then
                bombTool.Handle.CanTouch = true
                bombTool.Handle.Touched:Connect(function(hit)
                    if hit.Parent == player.Character then
                        bombTool.Parent = player.Character
                    end
                end)
            end
        end
    end)
    
    return true
end

function BombTransferController:transferBomb(player)
    if not player or not player.Character then return end
    
    self:savePosition()
    self:teleportToPlayer(player)
    
    local success = self:directBombTransfer(player)
    
    if not success then
        for i = 1, 10 do
            local bombTool = self.bombDetector:getBomb()
            if bombTool then
                bombTool.Parent = player.Character
                wait(0.1)
            else
                break
            end
        end
    end
    
    wait(0.3)
    self:returnToOriginalPosition()
end

function BombTransferController:getClosestPlayer()
    if self.targetPlayer and self.targetPlayer.Character and self.targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
        return self.targetPlayer
    end
    
    if not localPlayer.Character or not localPlayer.Character:FindFirstChild("HumanoidRootPart") then
        return nil
    end
    
    local closestPlayer = nil
    local closestDistance = math.huge
    local myPosition = localPlayer.Character.HumanoidRootPart.Position
    
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= localPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local distance = (player.Character.HumanoidRootPart.Position - myPosition).Magnitude
            if distance < closestDistance then
                closestDistance = distance
                closestPlayer = player
            end
        end
    end
    
    return closestPlayer
end

function BombTransferController:giveBombToClosest()
    local targetPlayer = self:getClosestPlayer()
    if targetPlayer then
        self:transferBomb(targetPlayer)
    end
end

function BombTransferController:toggleAutoTransfer()
    self.autoTransferEnabled = not self.autoTransferEnabled
    
    if self.autoTransferEnabled then
        self.transferConnection = RunService.Heartbeat:Connect(function()
            wait(1.2)
            if self.bombDetector:getBomb() then
                self:giveBombToClosest()
                wait(2)
            end
        end)
    else
        if self.transferConnection then
            self.transferConnection:Disconnect()
            self.transferConnection = nil
        end
    end
    
    return self.autoTransferEnabled
end

local ESPController = {}
ESPController.__index = ESPController

function ESPController.new()
    local self = setmetatable({}, ESPController)
    self.espEnabled = false
    self.espConnections = {}
    return self
end

function ESPController:createESP(player)
    if not player or not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then
        return
    end
    
    local character = player.Character
    
    if character:FindFirstChild("WireframeESP") then
        return
    end
    
    local espFolder = Instance.new("Folder")
    espFolder.Name = "WireframeESP"
    espFolder.Parent = character
    
    local bodyParts = {"Head", "Torso", "Left Arm", "Right Arm", "Left Leg", "Right Leg", "HumanoidRootPart"}
    
    if character:FindFirstChild("UpperTorso") then
        bodyParts = {"Head", "UpperTorso", "LowerTorso", "LeftUpperArm", "LeftLowerArm", "LeftHand", "RightUpperArm", "RightLowerArm", "RightHand", "LeftUpperLeg", "LeftLowerLeg", "LeftFoot", "RightUpperLeg", "RightLowerLeg", "RightFoot"}
    end
    
    for _, partName in ipairs(bodyParts) do
        local part = character:FindFirstChild(partName)
        if part and part:IsA("BasePart") then
            local selectionBox = Instance.new("SelectionBox")
            selectionBox.Name = "ESP_" .. partName
            selectionBox.Adornee = part
            selectionBox.Color3 = Color3.fromRGB(255, 0, 0)
            selectionBox.LineThickness = 0.1
            selectionBox.Transparency = 0.1
            selectionBox.Parent = espFolder
        end
    end
    
    local connection = character.AncestryChanged:Connect(function()
        if not character.Parent then
            espFolder:Destroy()
            connection:Disconnect()
        end
    end)
    
    self.espConnections[player] = {folder = espFolder, connection = connection}
end

function ESPController:toggleESP()
    self.espEnabled = not self.espEnabled
    
    if self.espEnabled then
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= localPlayer then
                if player.Character then
                    self:createESP(player)
                end
                player.CharacterAdded:Connect(function()
                    wait(0.3)
                    if self.espEnabled then
                        self:createESP(player)
                    end
                end)
            end
        end
        
        Players.PlayerAdded:Connect(function(player)
            if self.espEnabled then
                player.CharacterAdded:Connect(function()
                    wait(0.3)
                    if self.espEnabled then
                        self:createESP(player)
                    end
                end)
            end
        end)
    else
        for player, data in pairs(self.espConnections) do
            if data.folder then
                data.folder:Destroy()
            end
            if data.connection then
                data.connection:Disconnect()
            end
        end
        self.espConnections = {}
    end
    
    return self.espEnabled
end

local PlayerSearcher = {}
PlayerSearcher.__index = PlayerSearcher

function PlayerSearcher.new()
    local self = setmetatable({}, PlayerSearcher)
    return self
end

function PlayerSearcher:findByName(searchName)
    if searchName == "" then
        return nil
    end
    
    local searchLower = searchName:lower()
    local bestMatch = nil
    local shortestDistance = math.huge
    
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= localPlayer then
            local playerNameLower = player.Name:lower()
            local displayNameLower = (player.DisplayName or ""):lower()
            
            if playerNameLower:find(searchLower, 1, true) or displayNameLower:find(searchLower, 1, true) then
                local distance = math.abs(#playerNameLower - #searchLower)
                if distance < shortestDistance then
                    shortestDistance = distance
                    bestMatch = player
                end
            end
        end
    end
    
    return bestMatch
end

local IceFixController = {}
IceFixController.__index = IceFixController

function IceFixController.new()
    local self = setmetatable({}, IceFixController)
    self.iceFixEnabled = false
    self.iceFixConnection = nil
    return self
end

function IceFixController:fixIceParts()
    if not localPlayer.Character then return end
    
    local character = localPlayer.Character
    local humanoid = character:FindFirstChild("Humanoid")
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    
    if humanoid and rootPart then
        humanoid.WalkSpeed = 16
        humanoid.JumpPower = 50
        
        rootPart.AssemblyLinearVelocity = Vector3.new(0, rootPart.AssemblyLinearVelocity.Y, 0)
        rootPart.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
        
        for _, part in pairs(character:GetChildren()) do
            if part:IsA("BasePart") then
                part.AssemblyLinearVelocity = Vector3.new(0, part.AssemblyLinearVelocity.Y, 0)
                part.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
                
                if part.Material == Enum.Material.Ice then
                    part.CustomPhysicalProperties = PhysicalProperties.new(0.7, 0.5, 0, 1, 1)
                end
            end
        end
    end
    
    for _, obj in pairs(Workspace:GetDescendants()) do
        if obj:IsA("BasePart") and obj.Name:lower():find("ice") then
            obj.CanTouch = false
            obj.CustomPhysicalProperties = PhysicalProperties.new(0.7, 1, 0, 1, 1)
        end
    end
end

function IceFixController:toggle()
    self.iceFixEnabled = not self.iceFixEnabled
    
    if self.iceFixEnabled then
        self.iceFixConnection = RunService.Heartbeat:Connect(function()
            self:fixIceParts()
        end)
    else
        if self.iceFixConnection then
            self.iceFixConnection:Disconnect()
            self.iceFixConnection = nil
        end
    end
    
    return self.iceFixEnabled
end

local TargetToolController = {}
TargetToolController.__index = TargetToolController

function TargetToolController.new()
    local self = setmetatable({}, TargetToolController)
    return self
end

function TargetToolController:giveTool(onTargetSelected)
    for _, tool in pairs(localPlayer.Backpack:GetChildren()) do
        if tool.Name == "ClickTarget" then
            tool:Destroy()
        end
    end
    
    for _, tool in pairs(localPlayer.Character:GetChildren()) do
        if tool.Name == "ClickTarget" then
            tool:Destroy()
        end
    end
    
    local targetTool = Instance.new("Tool")
    targetTool.Name = "ClickTarget"
    targetTool.RequiresHandle = false
    targetTool.TextureId = "rbxassetid://13769558274"
    targetTool.ToolTip = "Choose Player"
    
    targetTool.Activated:Connect(function()
        local mouse = localPlayer:GetMouse()
        local hit = mouse.Target
        local person = nil
        
        if hit and hit.Parent then
            if hit.Parent:IsA("Model") then
                person = Players:GetPlayerFromCharacter(hit.Parent)
            elseif hit.Parent:IsA("Accessory") then
                person = Players:GetPlayerFromCharacter(hit.Parent.Parent)
            end
            
            if person and person ~= localPlayer then
                onTargetSelected(person)
                targetTool:Destroy()
            end
        end
    end)
    
    targetTool.Parent = localPlayer.Backpack
end

local MapDetector = {}
MapDetector.__index = MapDetector

function MapDetector.new()
    local self = setmetatable({}, MapDetector)
    return self
end

function MapDetector:detectType()
    local workspace = game.Workspace
    if workspace:FindFirstChild("TimeBomb") or workspace:FindFirstChild("Bomb") or workspace:FindFirstChild("Map") then
        return "TimeBomb"
    else
        return "Detected"
    end
end

local ClipboardController = {}
ClipboardController.__index = ClipboardController

function ClipboardController.new()
    local self = setmetatable({}, ClipboardController)
    return self
end

function ClipboardController:copyToClipboard(text)
    if setclipboard then
        setclipboard(text)
    elseif syn and syn.write_clipboard then
        syn.write_clipboard(text)
    end
end

local Application = {}
Application.__index = Application

function Application.new()
    local self = setmetatable({}, Application)
    
    self.targetPlayer = nil
    self.targetPlayerName = ""
    
    self.bombDetector = BombDetector.new()
    self.bombTransfer = BombTransferController.new(self.bombDetector)
    self.espController = ESPController.new()
    self.playerSearcher = PlayerSearcher.new()
    self.iceFixController = IceFixController.new()
    self.targetTool = TargetToolController.new()
    self.mapDetector = MapDetector.new()
    self.movementController = MovementController.new()
    self.protectionController = ProtectionController.new()
    self.clipboardController = ClipboardController.new()
    
    return self
end

function Application:setTarget(player)
    self.targetPlayer = player
    self.targetPlayerName = player and player.Name or ""
    self.bombTransfer:setTarget(player)
    self.protectionController:setTarget(player)
end

function Application:createGUI()
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Parent = screenGui
    mainFrame.Size = UDim2.new(0, 300, 0, 580)
    mainFrame.Position = UDim2.new(0.5, -150, 0.5, -290)
    mainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    mainFrame.BackgroundTransparency = 0.3
    mainFrame.BorderSizePixel = 0
    mainFrame.Active = true
    mainFrame.Draggable = true
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = mainFrame
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "TitleLabel"
    titleLabel.Parent = mainFrame
    titleLabel.Size = UDim2.new(1, 0, 0, 40)
    titleLabel.Position = UDim2.new(0, 0, 0, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = "FRONT EVILL - " .. self.mapDetector:detectType()
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.TextSize = 18
    titleLabel.TextScaled = true
    titleLabel.Font = Enum.Font.GothamBold
    
    local inputFrame = Instance.new("Frame")
    inputFrame.Size = UDim2.new(0.9, 0, 0, 35)
    inputFrame.Position = UDim2.new(0.05, 0, 0, 50)
    inputFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    inputFrame.BorderSizePixel = 0
    inputFrame.Parent = mainFrame
    
    local inputCorner = Instance.new("UICorner")
    inputCorner.CornerRadius = UDim.new(0, 8)
    inputCorner.Parent = inputFrame
    
    local playerInput = Instance.new("TextBox")
    playerInput.Size = UDim2.new(0.7, 0, 1, 0)
    playerInput.Position = UDim2.new(0, 5, 0, 0)
    playerInput.BackgroundTransparency = 1
    playerInput.Text = ""
    playerInput.PlaceholderText = "Enter player name..."
    playerInput.TextColor3 = Color3.fromRGB(255, 255, 255)
    playerInput.TextSize = 14
    playerInput.Font = Enum.Font.Gotham
    playerInput.Parent = inputFrame
    
    local searchButton = Instance.new("TextButton")
    searchButton.Size = UDim2.new(0.25, 0, 0.8, 0)
    searchButton.Position = UDim2.new(0.72, 0, 0.1, 0)
    searchButton.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
    searchButton.BorderSizePixel = 0
    searchButton.Text = "Set Target"
    searchButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    searchButton.TextSize = 12
    searchButton.Font = Enum.Font.Gotham
    searchButton.Parent = inputFrame
    
    local searchCorner = Instance.new("UICorner")
    searchCorner.CornerRadius = UDim.new(0, 6)
    searchCorner.Parent = searchButton
    
    searchButton.MouseButton1Click:Connect(function()
        local inputText = playerInput.Text:gsub("%s+", "")
        if inputText == "" then
            self:setTarget(nil)
        else
            local foundPlayer = self.playerSearcher:findByName(inputText)
            if foundPlayer then
                self:setTarget(foundPlayer)
                playerInput.Text = foundPlayer.Name
            end
        end
    end)
    
    local buttonData = {
        {name = "ESP Players", func = function() self.espController:toggleESP() end, color = Color3.fromRGB(255, 100, 100)},
        {name = "Give Bomb", func = function() self.bombTransfer:giveBombToClosest() end, color = Color3.fromRGB(255, 150, 50)},
        {name = "Auto Transfer", func = function() self.bombTransfer:toggleAutoTransfer() end, color = Color3.fromRGB(100, 255, 150)},
        {name = "Fix Ice Parts", func = function() self.iceFixController:toggle() end, color = Color3.fromRGB(100, 200, 255)},
        {name = "Target Tool", func = function() self.targetTool:giveTool(function(player) self:setTarget(player) end) end, color = Color3.fromRGB(200, 100, 255)},
        {name = "Anit Bomb", func = function() self.protectionController:toggle() end, color = Color3.fromRGB(255, 200, 0)},
        {name = "Random Teleport", func = function() 
            if self.movementController:isActive() then
                self.movementController:stopRandomTeleport()
            else
                self.movementController:startRandomTeleport()
            end
        end, color = Color3.fromRGB(0, 255, 200)}
    }
    
    for i, data in ipairs(buttonData) do
        local button = Instance.new("TextButton")
        button.Name = "Button" .. i
        button.Parent = mainFrame
        button.Size = UDim2.new(0.9, 0, 0, 40)
        button.Position = UDim2.new(0.05, 0, 0, 100 + (i - 1) * 50)
        button.BackgroundColor3 = data.color
        button.BackgroundTransparency = 0.2
        button.BorderSizePixel = 0
        button.Text = data.name
        button.TextColor3 = Color3.fromRGB(255, 255, 255)
        button.TextSize = 14
        button.Font = Enum.Font.Gotham
        
        local buttonCorner = Instance.new("UICorner")
        buttonCorner.CornerRadius = UDim.new(0, 8)
        buttonCorner.Parent = button
        
        button.MouseEnter:Connect(function()
            local tween = TweenService:Create(button, TweenInfo.new(0.2), {BackgroundTransparency = 0.1})
            tween:Play()
        end)
        
        button.MouseLeave:Connect(function()
            local tween = TweenService:Create(button, TweenInfo.new(0.2), {BackgroundTransparency = 0.2})
            tween:Play()
        end)
        
        button.MouseButton1Click:Connect(function()
            spawn(data.func)
        end)
    end
    
    local statusLabel = Instance.new("TextLabel")
    statusLabel.Size = UDim2.new(0.9, 0, 0, 25)
    statusLabel.Position = UDim2.new(0.05, 0, 0, 460)
    statusLabel.BackgroundTransparency = 1
    statusLabel.Text = "Target: None"
    statusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    statusLabel.TextSize = 12
    statusLabel.Font = Enum.Font.Gotham
    statusLabel.Parent = mainFrame
    
    local discordFrame = Instance.new("Frame")
    discordFrame.Size = UDim2.new(0.9, 0, 0, 35)
    discordFrame.Position = UDim2.new(0.05, 0, 0, 490)
    discordFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    discordFrame.BorderSizePixel = 0
    discordFrame.Parent = mainFrame
    
    local discordCorner = Instance.new("UICorner")
    discordCorner.CornerRadius = UDim.new(0, 8)
    discordCorner.Parent = discordFrame
    
    local discordLabel = Instance.new("TextLabel")
    discordLabel.Size = UDim2.new(0.7, 0, 1, 0)
    discordLabel.Position = UDim2.new(0, 5, 0, 0)
    discordLabel.BackgroundTransparency = 1
    discordLabel.Text = "https://discord.gg/q8JccR5jyc"
    discordLabel.TextColor3 = Color3.fromRGB(100, 149, 237)
    discordLabel.TextSize = 11
    discordLabel.Font = Enum.Font.Gotham
    discordLabel.TextXAlignment = Enum.TextXAlignment.Left
    discordLabel.Parent = discordFrame
    
    local copyButton = Instance.new("TextButton")
    copyButton.Size = UDim2.new(0.25, 0, 0.8, 0)
    copyButton.Position = UDim2.new(0.72, 0, 0.1, 0)
    copyButton.BackgroundColor3 = Color3.fromRGB(100, 149, 237)
    copyButton.BorderSizePixel = 0
    copyButton.Text = "Copy"
    copyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    copyButton.TextSize = 12
    copyButton.Font = Enum.Font.Gotham
    copyButton.Parent = discordFrame
    
    local copyCorner = Instance.new("UICorner")
    copyCorner.CornerRadius = UDim.new(0, 6)
    copyCorner.Parent = copyButton
    
    copyButton.MouseButton1Click:Connect(function()
        self.clipboardController:copyToClipboard("https://discord.gg/q8JccR5jyc")
       copyButton.Text = "Copied!"
       wait(1)
       copyButton.Text = "Copy"
   end)
   
   RunService.Heartbeat:Connect(function()
       if self.targetPlayer then
           statusLabel.Text = "Target: " .. self.targetPlayer.Name
           if not self.targetPlayer.Parent then
               self:setTarget(nil)
           end
       else
           statusLabel.Text = "Target: None"
       end
   end)
   
   local toggleButton = Instance.new("TextButton")
   toggleButton.Name = "ToggleButton"
   toggleButton.Parent = screenGui
   toggleButton.Size = UDim2.new(0, 120, 0, 35)
   toggleButton.Position = UDim2.new(0, 10, 0, 10)
   toggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
   toggleButton.BackgroundTransparency = 0.2
   toggleButton.BorderSizePixel = 0
   toggleButton.Text = "FRONT EVILL"
   toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
   toggleButton.TextSize = 14
   toggleButton.Font = Enum.Font.GothamBold
   toggleButton.Active = true
   toggleButton.Draggable = true
   
   local toggleCorner = Instance.new("UICorner")
   toggleCorner.CornerRadius = UDim.new(0, 8)
   toggleCorner.Parent = toggleButton
   
   local isVisible = true
   
   toggleButton.MouseButton1Click:Connect(function()
       isVisible = not isVisible
       if isVisible then
           mainFrame:TweenPosition(UDim2.new(0.5, -150, 0.5, -290), "Out", "Quad", 0.3, true)
           mainFrame.Visible = true
       else
           mainFrame:TweenPosition(UDim2.new(0.5, -150, 1.2, 0), "In", "Quad", 0.3, true, function()
               mainFrame.Visible = false
           end)
       end
   end)
   
   toggleButton.MouseEnter:Connect(function()
       local tween = TweenService:Create(toggleButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(70, 70, 70)})
       tween:Play()
   end)
   
   toggleButton.MouseLeave:Connect(function()
       local tween = TweenService:Create(toggleButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 50, 50)})
       tween:Play()
   end)
end

function Application:initialize()
   self:createGUI()
end

local app = Application.new()
app:initialize()
