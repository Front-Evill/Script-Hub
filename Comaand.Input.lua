-- Command Functions
local ActiveCommands = {}
function ExecuteBringCircleCommand()
    if ActiveCommands["BringAllCircle"] then
        print("Bring Circle command is already active!")
        return
    end
    
    getgenv().BringAllCircle = true
    ActiveCommands["BringAllCircle"] = true
    print("Bring All In Circle activated!")
    
    spawn(function()
        local Players = game:GetService("Players")
        local player = Players.LocalPlayer
        local angle = 0
        
        while getgenv().BringAllCircle do
            local allPlayers = {}
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= player and CheckCharacter(p) then
                    table.insert(allPlayers, p)
                end
            end
            
            if #allPlayers > 0 and CheckCharacter(player) then
                local radius = 10
                local angleStep = (2 * math.pi) / #allPlayers
                
                for i, targetPlayer in ipairs(allPlayers) do
                    local currentAngle = angle + (angleStep * (i - 1))
                    local offsetX = math.cos(currentAngle) * radius
                    local offsetZ = math.sin(currentAngle) * radius
                    
                    local targetCFrame = player.Character.HumanoidRootPart.CFrame * CFrame.new(offsetX, 0, offsetZ)
                    targetPlayer.Character.HumanoidRootPart.CFrame = targetCFrame
                    targetPlayer.Character.HumanoidRootPart.CFrame = targetPlayer.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, currentAngle + math.pi/2, 0)
                end
            end
            
            angle = angle + 0.15
            wait(0.05)
        end
        
        ActiveCommands["BringAllCircle"] = nil
        print("Bring Circle command stopped!")
    end)
end

function ExecuteGiantCommand()
    if ActiveCommands["GiantAllPlayers"] then
        print("Giant command is already active!")
        return
    end
    
    getgenv().GiantAllPlayers = true
    ActiveCommands["GiantAllPlayers"] = true
    print("Make All Players Giant activated!")
    
    spawn(function()
        local Players = game:GetService("Players")
        local player = Players.LocalPlayer
        
        for _, targetPlayer in ipairs(Players:GetPlayers()) do
            if targetPlayer ~= player and CheckCharacter(targetPlayer) then
                local humanoid = targetPlayer.Character:FindFirstChild("Humanoid")
                if humanoid then
                    humanoid.HipHeight = humanoid.HipHeight + 10
                    for _, part in ipairs(targetPlayer.Character:GetChildren()) do
                        if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                            part.Size = part.Size * 3
                            if part.Name == "Head" then
                                local mesh = part:FindFirstChild("Mesh")
                                if mesh then
                                    mesh.Scale = mesh.Scale * 3
                                end
                            end
                        elseif part:IsA("Accessory") then
                            local handle = part:FindFirstChild("Handle")
                            if handle then
                                handle.Size = handle.Size * 3
                                local mesh = handle:FindFirstChild("SpecialMesh")
                                if mesh then
                                    mesh.Scale = mesh.Scale * 3
                                end
                            end
                        end
                    end
                    
                    targetPlayer.Character.HumanoidRootPart.CanCollide = true
                    targetPlayer.Character.HumanoidRootPart.Material = Enum.Material.ForceField
                end
            end
        end
        
        ActiveCommands["GiantAllPlayers"] = nil
        print("Giant command executed!")
    end)
end

function ExecuteAntiMurdererCommand()
    if ActiveCommands["AntiMurdererKill"] then
        print("Anti Murderer command is already active!")
        return
    end
    
    getgenv().AntiMurdererKill = true
    ActiveCommands["AntiMurdererKill"] = true
    print("Anti Murderer Kill activated!")
    
    spawn(function()
        local player = game.Players.LocalPlayer
        
        while getgenv().AntiMurdererKill do
            if CheckCharacter(player) then
                local murderer = GetMurder()
                
                if murderer and CheckCharacter(murderer) and murderer ~= player then
                    local playerPos = player.Character.HumanoidRootPart.Position
                    local murdererPos = murderer.Character.HumanoidRootPart.Position
                    local distance = (playerPos - murdererPos).Magnitude
                    
                    if distance < 40 and getgenv().IsSafe then
                        getgenv().OriginalPosition = player.Character.HumanoidRootPart.CFrame
                        getgenv().IsSafe = false
                        
                        local safePos = playerPos + Vector3.new(
                            math.random(-150, 150),
                            100,
                            math.random(-150, 150)
                        )
                        
                        if getgenv().SafePlatform then
                            getgenv().SafePlatform:Destroy()
                        end
                        
                        getgenv().SafePlatform = Instance.new("Part")
                        getgenv().SafePlatform.Name = "SafePlatform"
                        getgenv().SafePlatform.Size = Vector3.new(50, 3, 50)
                        getgenv().SafePlatform.Position = safePos - Vector3.new(0, 3, 0)
                        getgenv().SafePlatform.Anchored = true
                        getgenv().SafePlatform.CanCollide = true
                        getgenv().SafePlatform.Material = Enum.Material.Neon
                        getgenv().SafePlatform.BrickColor = BrickColor.new("Bright green")
                        getgenv().SafePlatform.Transparency = 0.3
                        getgenv().SafePlatform.Parent = workspace
                        player.Character.HumanoidRootPart.CFrame = CFrame.new(safePos)
                        
                    elseif distance > 30 and not getgenv().IsSafe and getgenv().OriginalPosition then
                        wait(0.4)
                        local newDistance = (murderer.Character.HumanoidRootPart.Position - getgenv().OriginalPosition.Position).Magnitude
                        if newDistance > 30 then
                            player.Character.HumanoidRootPart.CFrame = getgenv().OriginalPosition
                            getgenv().IsSafe = true
                            getgenv().OriginalPosition = nil
                            if getgenv().SafePlatform then
                                getgenv().SafePlatform:Destroy()
                                getgenv().SafePlatform = nil
                            end
                        end
                    end
                else
                    if not getgenv().IsSafe and getgenv().OriginalPosition then
                        player.Character.HumanoidRootPart.CFrame = getgenv().OriginalPosition
                        getgenv().IsSafe = true
                        getgenv().OriginalPosition = nil
                        
                        if getgenv().SafePlatform then
                            getgenv().SafePlatform:Destroy()
                            getgenv().SafePlatform = nil
                        end
                    end
                end
            end
            wait(0.2)
        end
        
        ActiveCommands["AntiMurdererKill"] = nil
        print("Anti Murderer command stopped!")
    end)
end

function ExecuteAntiFlingCommand()
    if ActiveCommands["AntiFling"] then
        print("Anti Fling command is already active!")
        return
    end
    
    getgenv().AntiFling = true
    ActiveCommands["AntiFling"] = true
    print("Anti Fling activated!")
    
    spawn(function()
        local player = game.Players.LocalPlayer
        while getgenv().AntiFling do
            if CheckCharacter(player) then
                local humanoidRootPart = player.Character.HumanoidRootPart
                local bodyVelocity = humanoidRootPart.Velocity
                
                if bodyVelocity.Magnitude > 50 then
                    humanoidRootPart.Velocity = Vector3.new(0, 0, 0)
                    humanoidRootPart.AngularVelocity = Vector3.new(0, 0, 0)
                end
                
                humanoidRootPart.AssemblyLinearVelocity = Vector3.new(
                    math.clamp(humanoidRootPart.AssemblyLinearVelocity.X, -50, 50),
                    math.clamp(humanoidRootPart.AssemblyLinearVelocity.Y, -50, 50),
                    math.clamp(humanoidRootPart.AssemblyLinearVelocity.Z, -50, 50)
                )
            end
            wait(0.1)
        end
        
        ActiveCommands["AntiFling"] = nil
        print("Anti Fling command stopped!")
    end)
end

function ExecuteAntiRideCommand()
    if ActiveCommands["AntiRide"] then
        print("Anti Ride command is already active!")
        return
    end
    
    getgenv().AntiRide = true
    ActiveCommands["AntiRide"] = true
    print("Anti Ride activated!")
    
    spawn(function()
        local player = game.Players.LocalPlayer
        while getgenv().AntiRide do
            if CheckCharacter(player) then
                local head = player.Character:FindFirstChild("Head")
                if head then
                    for _, otherPlayer in ipairs(game.Players:GetPlayers()) do
                        if otherPlayer ~= player and CheckCharacter(otherPlayer) then
                            local otherHRP = otherPlayer.Character.HumanoidRootPart
                            local distance = (head.Position - otherHRP.Position).Magnitude
                           
                            if distance < 5 and otherHRP.Position.Y > head.Position.Y then
                                otherHRP.CFrame = otherHRP.CFrame + Vector3.new(
                                    math.random(-10, 10),
                                    0,
                                    math.random(-10, 10)
                                )
                                otherHRP.Velocity = Vector3.new(0, -50, 0)
                            end
                        end
                    end
                end
            end
            wait(0.2)
        end
        
        ActiveCommands["AntiRide"] = nil
        print("Anti Ride command stopped!")
    end)
end
