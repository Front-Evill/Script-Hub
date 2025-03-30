local redzlib = loadstring(game:HttpGet("https://raw.githubusercontent.com/newredz/RedzLibV5/refs/heads/main/Source.lua"))()

local window = redzlib:MakeWindow({
    Name = "MM2 ", 
    SubTitle = "By FRONNT / VR7",
    SaveFolder = "/...F...V...R...A.../"
})

local Discord = window:MakeTab({
    Title = "Discord",
    Icon = "rbxassetid://123456789" -- icons 
})

Discoord:AddSection({
    Name = "Discoord FRONT"
})


Discord:AddDiscordInvite({
    Name = "Welcome to Server FRONT",
    Logo = "rbxassetid://131460145238951",
    Invite = "https://discord.gg/3rfd8aKree"
})

Discoord:AddSection({
    Name = "Discord VR7"
})

Discord:AddDiscordInvite({
    Name = "Welcome to Server VR7",
    Logo = "rbxassetid://109526300453521",
    Invite = "https://discord.gg/vr7"
})


local Main = window:MakeTab({
    Title = "Main",
    Icon = "rbxassetid://" -- id icons 
})

Main:AddSection({
    Name = "FARM"
})


-- داخل Tab3 (الفارم)
local Section = Tab3:AddSection({
    Name = "أدوات القتل"
})

Tab3:AddButton({
    Name = "Kill all",
    Default = "قتل الجميع",
    Callback = function()
        if game.Players.LocalPlayer.Backpack:FindFirstChild("Knife") or game.Players.LocalPlayer.Character:FindFirstChild("Knife") then
            local Players = game:GetService("Players")
            for _, Victim in pairs(Players:GetPlayers()) do
                if Victim ~= game.Players.LocalPlayer and Victim.Character then
                    -- حفظ الموقع الأصلي
                    local originalCFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                    
                    -- الانتقال للضحية
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Victim.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 1)
                    
                    -- التأكد من القتل
                    repeat
                        task.wait()
                    until not Victim.Character or Victim.Character.Humanoid.Health <= 0
                    
                    -- العودة للموقع الأصلي
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = originalCFrame
                end
            end
          else
            tab:AddParagraph({
                Title = "Ez",
                Text = "All mnuper is dead"
            })
          end    
        else    
            Main:AddParagraph({
                Title = "Error",
                Text = "you is not murdyer"
            })
        end
    end
})


Main:AddSection({
    Name = ""
})

-- داخل Tab4 (كشف الاماكن)
local Section = Tab4:AddSection({
    Name = "كشف اللاعبين (ESP)"
})

local ESPEnabled = false
local ESPBoxes = {}

Main:AddToggle({
    Name = "Esp All",
    Default = "كشف جميع لاعبين موجودين",
    Callback = function(value)
        ESPEnabled = value
        
        if ESPEnabled then
            -- تفعيل ESP
            for _, player in pairs(game.Players:GetPlayers()) do
                if player ~= game.Players.LocalPlayer and player.Character then
                    createESP(player)
                end
            end
            
            -- إضافة ESP للاعبين الجدد
            game.Players.PlayerAdded:Connect(function(player)
                player.CharacterAdded:Connect(function(character)
                    if ESPEnabled then
                        createESP(player)
                    end
                end)
            end)
        else
            -- إيقاف ESP وإزالة الصناديق
            for _, box in pairs(ESPBoxes) do
                if box then
                    box:Destroy()
                end
            end
            ESPBoxes = {}
        end
    end
})

-- دالة إنشاء ESP
function createESP(player)
    if not player.Character then return end
    
    local character = player.Character
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    
    -- إنشاء صندوق ESP
    local espBox = Instance.new("BoxHandleAdornment")
    espBox.Name = player.Name .. "_ESP"
    espBox.Adornee = humanoidRootPart
    espBox.AlwaysOnTop = true
    espBox.ZIndex = 10
    espBox.Size = Vector3.new(2, 3, 1)
    espBox.Transparency = 0.5
    
    -- تحديد لون ESP حسب الدور
    if player.Backpack:FindFirstChild("Knife") or character:FindFirstChild("Knife") then
        espBox.Color3 = Color3.fromRGB(255, 0, 0) -- أحمر للقاتل
    elseif player.Backpack:FindFirstChild("Gun") or character:FindFirstChild("Gun") then
        espBox.Color3 = Color3.fromRGB(0, 0, 255) -- أزرق للشريف
    else
        espBox.Color3 = Color3.fromRGB(0, 255, 0) -- أخضر للأبرياء
    end
    
    espBox.Parent = game.CoreGui
    table.insert(ESPBoxes, espBox)
    
    -- تحديث ESP عند تغيير الدور
    character.ChildAdded:Connect(function(child)
        if child.Name == "Knife" or child.Name == "Gun" then
            if child.Name == "Knife" then
                espBox.Color3 = Color3.fromRGB(255, 0, 0)
            else
                espBox.Color3 = Color3.fromRGB(0, 0, 255)
            end
        end
    end)
    
    -- إزالة ESP عند موت اللاعب
    character:WaitForChild("Humanoid").Died:Connect(function()
        if espBox then
            espBox:Destroy()
        end
    end)
end
