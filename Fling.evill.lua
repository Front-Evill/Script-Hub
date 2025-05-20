getgenv().FlingingEnabled = false
getgenv().TargetPlayer = nil
getgenv().OldPosition = nil
getgenv().FallenPartsHeight = workspace.FallenPartsDestroyHeight

local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local Title = Instance.new("TextLabel")
local ToggleButton = Instance.new("TextButton")
local TargetInput = Instance.new("TextBox")
local StatusLabel = Instance.new("TextLabel")

ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

MainFrame.Name = "FlingGUI"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
MainFrame.Position = UDim2.new(0.75, 0, 0.2, 0)
MainFrame.Size = UDim2.new(0, 200, 0, 170)
MainFrame.Draggable = true
MainFrame.Active = true

UICorner.Parent = MainFrame
UICorner.CornerRadius = UDim.new(0, 10)

Title.Name = "Title"
Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 0, 0, 10)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Font = Enum.Font.GothamBold
Title.Text = "Player Flinger"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 18

ToggleButton.Name = "ToggleButton"
ToggleButton.Parent = MainFrame
ToggleButton.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
ToggleButton.Position = UDim2.new(0.5, -60, 0, 50)
ToggleButton.Size = UDim2.new(0, 120, 0, 35)
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.Text = "Enable Fling"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.TextSize = 14

local ButtonUICorner = Instance.new("UICorner")
ButtonUICorner.Parent = ToggleButton
ButtonUICorner.CornerRadius = UDim.new(0, 8)

TargetInput.Name = "TargetInput"
TargetInput.Parent = MainFrame
TargetInput.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
TargetInput.Position = UDim2.new(0.5, -80, 0, 100)
TargetInput.Size = UDim2.new(0, 160, 0, 30)
TargetInput.Font = Enum.Font.Gotham
TargetInput.PlaceholderText = "Target player name (leave empty for all)"
TargetInput.Text = ""
TargetInput.TextColor3 = Color3.fromRGB(255, 255, 255)
TargetInput.TextSize = 12
TargetInput.ClearTextOnFocus = false

local InputUICorner = Instance.new("UICorner")
InputUICorner.Parent = TargetInput
InputUICorner.CornerRadius = UDim.new(0, 8)

StatusLabel.Name = "StatusLabel"
StatusLabel.Parent = MainFrame
StatusLabel.BackgroundTransparency = 1
StatusLabel.Position = UDim2.new(0, 0, 0, 140)
StatusLabel.Size = UDim2.new(1, 0, 0, 20)
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.Text = "Status: Ready"
StatusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
StatusLabel.TextSize = 12

local function IsPlayerValid(player)
    return player and player.Parent == game.Players and player.Character and 
           player.Character:FindFirstChild("Humanoid") and 
           player.Character:FindFirstChild("HumanoidRootPart")
end

local function ApplyFlingToPlayer(targetPlayer)
    if not IsPlayerValid(targetPlayer) or not IsPlayerValid(game.Players.LocalPlayer) then
        return false
    end
    
    getgenv().OldPosition = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
    workspace.FallenPartsDestroyHeight = 0/0
    
    local BV = Instance.new("BodyVelocity")
    BV.Name = "Flinger"
    BV.Parent = game.Players.LocalPlayer.Character.HumanoidRootPart
    BV.Velocity = Vector3.new(9e8, 9e8, 9e8)
    BV.MaxForce = Vector3.new(1/0, 1/0, 1/0)
    
    game.Players.LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
    
    local function FlingAction()
        if not IsPlayerValid(targetPlayer) or not IsPlayerValid(game.Players.LocalPlayer) then
            return false
        end
        
        local targetRoot = targetPlayer.Character.HumanoidRootPart
        workspace.CurrentCamera.CameraSubject = targetRoot
        
        local angleIncrement = 0
        
        for i = 1, 10 do
            angleIncrement = angleIncrement + 45
            
            local offsets = {
                Vector3.new(0, 1.5, 0),
                Vector3.new(0, -1.5, 0),
                Vector3.new(2, 1.5, -2),
                Vector3.new(-2, -1.5, 2),
                Vector3.new(0, 1.5, 2),
                Vector3.new(0, -1.5, -2)
            }
            
            for _, offset in ipairs(offsets) do
                pcall(function()
                    local newCFrame = CFrame.new(targetRoot.Position + offset) * CFrame.Angles(math.rad(angleIncrement), 0, 0)
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = newCFrame
                    game.Players.LocalPlayer.Character:SetPrimaryPartCFrame(newCFrame)
                    game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(9e7, 9e7, 9e7)
                    game.Players.LocalPlayer.Character.HumanoidRootPart.RotVelocity = Vector3.new(9e8, 9e8, 9e8)
                end)
                task.wait()
                
                if not getgenv().FlingingEnabled then
                    return false
                end
            end
            
            task.wait(0.05)
        end
        
        return true
    end
    
    FlingAction()
    
    if BV and BV.Parent then
        BV:Destroy()
    end
    
    game.Players.LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
    workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character.Humanoid
    
    local attempts = 0
    repeat
        pcall(function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = getgenv().OldPosition * CFrame.new(0, 0.5, 0)
            game.Players.LocalPlayer.Character:SetPrimaryPartCFrame(getgenv().OldPosition * CFrame.new(0, 0.5, 0))
            game.Players.LocalPlayer.Character.Humanoid:ChangeState("GettingUp")
            
            for _, part in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
                if part:IsA("BasePart") then
                    part.Velocity = Vector3.new(0, 0, 0)
                    part.RotVelocity = Vector3.new(0, 0, 0)
                end
            end
        end)
        task.wait()
        attempts = attempts + 1
    until (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - getgenv().OldPosition.p).Magnitude < 25 or attempts > 50
    
    return true
end

local function FlingPlayers()
    while getgenv().FlingingEnabled do
        StatusLabel.Text = "Status: Flinging"
        
        local targetName = TargetInput.Text
        if targetName ~= "" then
            local targetPlayer = game.Players:FindFirstChild(targetName)
            if targetPlayer then
                ApplyFlingToPlayer(targetPlayer)
            else
                StatusLabel.Text = "Status: Player Not Found"
                task.wait(1)
            end
        else
            for _, player in pairs(game.Players:GetPlayers()) do
                if player ~= game.Players.LocalPlayer and IsPlayerValid(player) then
                    ApplyFlingToPlayer(player)
                    if not getgenv().FlingingEnabled then break end
                    task.wait(0.5)
                end
            end
        end
        
        task.wait(0.1)
    end
    
    StatusLabel.Text = "Status: Stopped"
    workspace.FallenPartsDestroyHeight = getgenv().FallenPartsHeight
end

ToggleButton.MouseButton1Click:Connect(function()
    getgenv().FlingingEnabled = not getgenv().FlingingEnabled
    
    if getgenv().FlingingEnabled then
        ToggleButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
        ToggleButton.Text = "Stop Flinging"
        task.spawn(FlingPlayers)
    else
        ToggleButton.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
        ToggleButton.Text = "Enable Flinging"
    end
end)

local IsOnMobile = table.find({Enum.Platform.IOS, Enum.Platform.Android}, game:GetService("UserInputService"):GetPlatform())
if IsOnMobile then
    local MobileButton = Instance.new("TextButton")
    local MobileUICorner = Instance.new("UICorner")
    
    MobileButton.Name = "MobileButton"
    MobileButton.Parent = ScreenGui
    MobileButton.Size = UDim2.new(0, 80, 0, 40)
    MobileButton.Position = UDim2.new(0, 10, 0.5, -20)
    MobileButton.BackgroundTransparency = 0.5
    MobileButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    MobileButton.Font = Enum.Font.GothamBold
    MobileButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    MobileButton.Text = "Toggle GUI"
    MobileButton.TextScaled = true
    MobileButton.Draggable = true
    MobileButton.AutoButtonColor = false
    
    MobileUICorner.Parent = MobileButton
    MobileUICorner.CornerRadius = UDim.new(0, 8)
    
    MobileButton.MouseButton1Click:Connect(function()
        MainFrame.Visible = not MainFrame.Visible
    end)
end

StatusLabel.Text = "Status: Ready to use"
