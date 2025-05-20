getgenv().FlingingEnabled = false
getgenv().TargetPlayer = nil
getgenv().OldPosition = nil
getgenv().FallenPartsHeight = workspace.FallenPartsDestroyHeight

local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local TopBar = Instance.new("Frame")
local UICorner_TopBar = Instance.new("UICorner")
local Title = Instance.new("TextLabel")
local CloseButton = Instance.new("TextButton")
local UICorner_Close = Instance.new("UICorner")
local MainUICorner = Instance.new("UICorner")
local Shadow = Instance.new("ImageLabel")
local LogoImage = Instance.new("ImageLabel")
local ToggleButton = Instance.new("TextButton")
local UICorner_Toggle = Instance.new("UICorner")
local UIGradient_Toggle = Instance.new("UIGradient")
local TargetInput = Instance.new("TextBox")
local UICorner_Input = Instance.new("UICorner")
local StatusLabel = Instance.new("TextLabel")
local CreditLabel = Instance.new("TextLabel")
local ScriptByLabel = Instance.new("TextLabel")

local TweenService = game:GetService("TweenService")

ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Name = "FlingGUI_FrontEvill"
ScreenGui.ResetOnSpawn = false

Shadow.Name = "Shadow"
Shadow.Parent = ScreenGui
Shadow.AnchorPoint = Vector2.new(0.5, 0.5)
Shadow.BackgroundTransparency = 1
Shadow.Position = UDim2.new(0.5, 5, 0.5, 5)
Shadow.Size = UDim2.new(0, 310, 0, 250)
Shadow.Image = "rbxassetid://6014261993"
Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
Shadow.ImageTransparency = 0.5
Shadow.ScaleType = Enum.ScaleType.Slice
Shadow.SliceCenter = Rect.new(49, 49, 450, 450)

MainFrame.Name = "FlingGUI"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -120)
MainFrame.Size = UDim2.new(0, 300, 0, 240)
MainFrame.ClipsDescendants = true
MainFrame.ZIndex = 2
MainFrame.Draggable = true
MainFrame.Active = true

MainUICorner.Parent = MainFrame
MainUICorner.CornerRadius = UDim.new(0, 10)

TopBar.Name = "TopBar"
TopBar.Parent = MainFrame
TopBar.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
TopBar.Size = UDim2.new(1, 0, 0, 40)
TopBar.ZIndex = 3

UICorner_TopBar.Parent = TopBar
UICorner_TopBar.CornerRadius = UDim.new(0, 10)

Title.Name = "Title"
Title.Parent = TopBar
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 10, 0, 0)
Title.Size = UDim2.new(0.7, 0, 1, 0)
Title.Font = Enum.Font.GothamBold
Title.Text = "Player Flinger Pro"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 18
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.ZIndex = 3

CloseButton.Name = "CloseButton"
CloseButton.Parent = TopBar
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
CloseButton.Position = UDim2.new(1, -35, 0.5, -12)
CloseButton.Size = UDim2.new(0, 25, 0, 25)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 14
CloseButton.ZIndex = 3

UICorner_Close.Parent = CloseButton
UICorner_Close.CornerRadius = UDim.new(0, 8)

LogoImage.Name = "LogoImage"
LogoImage.Parent = MainFrame
LogoImage.BackgroundTransparency = 1
LogoImage.Position = UDim2.new(0.5, -40, 0, 50)
LogoImage.Size = UDim2.new(0, 80, 0, 80)
LogoImage.Image = "rbxassetid://130714468148923"
LogoImage.ImageColor3 = Color3.fromRGB(255, 255, 255)
LogoImage.ZIndex = 2

ToggleButton.Name = "ToggleButton"
ToggleButton.Parent = MainFrame
ToggleButton.BackgroundColor3 = Color3.fromRGB(45, 180, 45)
ToggleButton.Position = UDim2.new(0.5, -75, 0, 145)
ToggleButton.Size = UDim2.new(0, 150, 0, 35)
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.Text = "ENABLE FLING"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.TextSize = 16
ToggleButton.ZIndex = 2

UICorner_Toggle.Parent = ToggleButton
UICorner_Toggle.CornerRadius = UDim.new(0, 8)

UIGradient_Toggle.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(45, 180, 45)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(35, 140, 35))
}
UIGradient_Toggle.Parent = ToggleButton
UIGradient_Toggle.Rotation = 90

TargetInput.Name = "TargetInput"
TargetInput.Parent = MainFrame
TargetInput.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
TargetInput.Position = UDim2.new(0.5, -100, 0, 190)
TargetInput.Size = UDim2.new(0, 200, 0, 30)
TargetInput.Font = Enum.Font.Gotham
TargetInput.PlaceholderText = "Target player name (leave empty for all)"
TargetInput.Text = ""
TargetInput.TextColor3 = Color3.fromRGB(255, 255, 255)
TargetInput.TextSize = 12
TargetInput.ClearTextOnFocus = false
TargetInput.ZIndex = 2

UICorner_Input.Parent = TargetInput
UICorner_Input.CornerRadius = UDim.new(0, 8)

StatusLabel.Name = "StatusLabel"
StatusLabel.Parent = MainFrame
StatusLabel.BackgroundTransparency = 1
StatusLabel.Position = UDim2.new(0, 10, 1, -25)
StatusLabel.Size = UDim2.new(0, 150, 0, 20)
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.Text = "Status: Ready"
StatusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
StatusLabel.TextSize = 14
StatusLabel.TextXAlignment = Enum.TextXAlignment.Left
StatusLabel.ZIndex = 2

CreditLabel.Name = "CreditLabel"
CreditLabel.Parent = MainFrame
CreditLabel.BackgroundTransparency = 1
CreditLabel.Position = UDim2.new(1, -160, 1, -25)
CreditLabel.Size = UDim2.new(0, 150, 0, 20)
CreditLabel.Font = Enum.Font.GothamBold
CreditLabel.Text = "GUI BY: FRONT EVILL"
CreditLabel.TextColor3 = Color3.fromRGB(200, 200, 255)
CreditLabel.TextSize = 12
CreditLabel.TextXAlignment = Enum.TextXAlignment.Right
CreditLabel.ZIndex = 2

ScriptByLabel.Name = "ScriptByLabel"
ScriptByLabel.Parent = MainFrame
ScriptByLabel.BackgroundTransparency = 1
ScriptByLabel.Position = UDim2.new(0.5, -75, 0, 130)
ScriptByLabel.Size = UDim2.new(0, 150, 0, 15)
ScriptByLabel.Font = Enum.Font.Gotham
ScriptByLabel.Text = "SCRIPT BY: FRONT EVILL"
ScriptByLabel.TextColor3 = Color3.fromRGB(180, 180, 200)
ScriptByLabel.TextSize = 11
ScriptByLabel.ZIndex = 2

local function CreateRipple(parent)
    local ripple = Instance.new("Frame")
    local UICorner = Instance.new("UICorner")
    
    ripple.Name = "Ripple"
    ripple.Parent = parent
    ripple.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ripple.BackgroundTransparency = 0.8
    ripple.ZIndex = parent.ZIndex + 1
    ripple.AnchorPoint = Vector2.new(0.5, 0.5)
    ripple.Position = UDim2.new(0.5, 0, 0.5, 0)
    ripple.Size = UDim2.new(0, 0, 0, 0)
    
    UICorner.CornerRadius = UDim.new(1, 0)
    UICorner.Parent = ripple
    
    local targetSize = UDim2.new(2, 0, 2, 0)
    local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    
    local tween = TweenService:Create(ripple, tweenInfo, {
        Size = targetSize,
        BackgroundTransparency = 1
    })
    
    tween:Play()
    
    tween.Completed:Connect(function()
        ripple:Destroy()
    end)
end

ToggleButton.MouseButton1Down:Connect(function()
    CreateRipple(ToggleButton)
end)

CloseButton.MouseButton1Down:Connect(function()
    CreateRipple(CloseButton)
end)

MainFrame.Size = UDim2.new(0, 0, 0, 0)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
Shadow.Size = UDim2.new(0, 0, 0, 0)
Shadow.Position = UDim2.new(0.5, 0, 0.5, 0)

local openTween = TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
    Size = UDim2.new(0, 300, 0, 240),
    Position = UDim2.new(0.5, -150, 0.5, -120)
})

local shadowTween = TweenService:Create(Shadow, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
    Size = UDim2.new(0, 310, 0, 250),
    Position = UDim2.new(0.5, -145, 0.5, -115)
})

openTween:Play()
shadowTween:Play()

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
        StatusLabel.TextColor3 = Color3.fromRGB(255, 150, 0)
        
        local targetName = TargetInput.Text
        if targetName ~= "" then
            local targetPlayer = game.Players:FindFirstChild(targetName)
            if targetPlayer then
                ApplyFlingToPlayer(targetPlayer)
            else
                StatusLabel.Text = "Status: Player Not Found"
                StatusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
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
    StatusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
    workspace.FallenPartsDestroyHeight = getgenv().FallenPartsHeight
end

ToggleButton.MouseButton1Click:Connect(function()
    getgenv().FlingingEnabled = not getgenv().FlingingEnabled
    
    if getgenv().FlingingEnabled then
        UIGradient_Toggle.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, Color3.fromRGB(180, 45, 45)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(140, 35, 35))
        }
        ToggleButton.Text = "STOP FLINGING"
        task.spawn(FlingPlayers)
    else
        UIGradient_Toggle.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, Color3.fromRGB(45, 180, 45)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(35, 140, 35))
        }
        ToggleButton.Text = "ENABLE FLINGING"
    end
end)

CloseButton.MouseButton1Click:Connect(function()
    local closeTween = TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
        Size = UDim2.new(0, 0, 0, 0),
        Position = UDim2.new(0.5, 0, 0.5, 0)
    })
    
    local shadowCloseTween = TweenService:Create(Shadow, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
        Size = UDim2.new(0, 0, 0, 0),
        Position = UDim2.new(0.5, 0, 0.5, 0)
    })
    
    closeTween:Play()
    shadowCloseTween:Play()
    
    closeTween.Completed:Connect(function()
        getgenv().FlingingEnabled = false
        workspace.FallenPartsDestroyHeight = getgenv().FallenPartsHeight
        ScreenGui:Destroy()
    end)
end)

local IsOnMobile = table.find({Enum.Platform.IOS, Enum.Platform.Android}, game:GetService("UserInputService"):GetPlatform())
if IsOnMobile then
    local MobileButton = Instance.new("TextButton")
    local MobileUICorner = Instance.new("UICorner")
    local UIGradient = Instance.new("UIGradient")
    
    MobileButton.Name = "MobileButton"
    MobileButton.Parent = ScreenGui
    MobileButton.Size = UDim2.new(0, 80, 0, 40)
    MobileButton.Position = UDim2.new(0, 10, 0.5, -20)
    MobileButton.BackgroundTransparency = 0.2
    MobileButton.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    MobileButton.Font = Enum.Font.GothamBold
    MobileButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    MobileButton.Text = "GUI"
    MobileButton.TextSize = 18
    MobileButton.Draggable = true
    MobileButton.Active = true
    MobileButton.AutoButtonColor = false
    MobileButton.ZIndex = 10
    
    MobileUICorner.Parent = MobileButton
    MobileUICorner.CornerRadius = UDim.new(0, 8)
    
    UIGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(60, 60, 70)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(40, 40, 50))
    }
    UIGradient.Rotation = 90
    UIGradient.Parent = MobileButton
    
    MobileButton.MouseButton1Down:Connect(function()
        CreateRipple(MobileButton)
    end)
    
    MobileButton.MouseButton1Click:Connect(function()
        MainFrame.Visible = not MainFrame.Visible
        Shadow.Visible = MainFrame.Visible
    end)
end

task.spawn(function()
    while wait(0.1) do
        if not LogoImage or not LogoImage.Parent then break end
        
        local floatTween = TweenService:Create(LogoImage, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            Position = UDim2.new(0.5, -40, 0, 55)
        })
        floatTween:Play()
        wait(1.5)
        
        if not LogoImage or not LogoImage.Parent then break end
        local floatTween2 = TweenService:Create(LogoImage, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            Position = UDim2.new(0.5, -40, 0, 50)
        })
        floatTween2:Play()
        wait(1.5)
    end
end)

task.spawn(function()
    while wait(3) do
        if not TargetInput or not TargetInput.Parent then break end
        
        local glowTween = TweenService:Create(TargetInput, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            BackgroundColor3 = Color3.fromRGB(50, 50, 70)
        })
        glowTween:Play()
        wait(1)
        
        if not TargetInput or not TargetInput.Parent then break end
        local glowTween2 = TweenService:Create(TargetInput, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            BackgroundColor3 = Color3.fromRGB(40, 40, 50)
        })
        glowTween2:Play()
        wait(1)
    end
end)

task.spawn(function()
    while wait(1) do
        if not StatusLabel or not StatusLabel.Parent then break end
        
        local pulseTween = TweenService:Create(StatusLabel, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            TextTransparency = 0.3
        })
        pulseTween:Play()
        wait(1)
        
        if not StatusLabel or not StatusLabel.Parent then break end
        local pulseTween2 = TweenService:Create(StatusLabel, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            TextTransparency = 0
        })
        pulseTween2:Play()
        wait(1)
    end
end)

StatusLabel.Text = "Status: Ready to Fling"
