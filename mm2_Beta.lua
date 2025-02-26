local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer
local RenderStepped = RunService.RenderStepped
local Heartbeat = RunService.Heartbeat

-- تعاريف و فنش

--تعرف سكربت طيران 
local flyScript = loadstring(game:HttpGet("https://raw.githubusercontent.com/PROG-404/front-script/refs/heads/main/Source.lua"))()

-- استدعاء مكتبه ريدز الخرا 
local redzlib = loadstring(game:HttpGet("https://raw.githubusercontent.com/realredz/RedzLibV5/refs/heads/main/Source.lua"))()

local window = redzlib:MakeWindow({
    Name = "Script Mm2",
    SubTitle = "by Front_9",
    SaveFolder = "MM2Script",
    icon = "rbxassetid://10709752906"
})

--قسم ديسكورد

local discordTab = window:MakeTab({
    Title = "acount fruit",
    Icon = "rbxassetid://10709752906"
})

discordTab:AddSection({
    Name = "Discord"
})


discordTab:AddDiscordInvite({
    Name = "Join Our Community", -- نص الدعوة
    Logo = "rbxassetid://10709752906",
    Invite = "https://discord.gg/vr7", -- رابط الدعوة الخاص بك
    Desc = "Click to join our Discord server!" -- وصف صغير
})

discordTab:AddSection({
    Name = "guns.lol"
})


discordTab:AddDiscordInvite({
    Name = "Join Our Community", -- نص الدعوة
    Logo = "rbxassetid://10709769508",
    Invite = "https://guns.lol/front_evill", -- رابط الدعوة الخاص بك
    Desc = "Click an butto" -- وصف صغير
})
--نهايه

-- قسم رئيسي
local mainTab = window:MakeTab({
    Title = "Main",
    Icon = "rbxassetid://10709752906"
})

mainTab:AddButton({
    Name = "Activate Flight",
    Desc = "Click to enable flight",
    Callback = function()
        flyScript() -- تنفيذ سكربت الطيران
        print("Flight script activated!")
    end
})

-- قسم لاعبين
local playerTab = window:MakeTab({
    Title = "Player", -- اسم التبويب
    Icon = "rbxassetid://10709752906" 
})


playerTab:AddSection({
    Name = "jump & speed"
})

playerTab:AddToggle({
    Name = "High Jump", -- اسم التبديل
    Default = false, -- القيمة الافتراضية (غير مفعل)
    Flag = "highJumpToggle", -- معرف التبديل
    Callback = function(Value)
        if Value then
            -- تفعيل القفز العالي
            game.Players.LocalPlayer.Character.Humanoid.JumpHeight = 100 -- يمكنك تغيير القيمة
            print("High Jump enabled!")
        else
            -- إعادة القفز إلى القيمة الافتراضية
            game.Players.LocalPlayer.Character.Humanoid.JumpHeight = 50 -- القيمة الافتراضية
            print("High Jump disabled!")
        end
    end
})

playerTab:AddToggle({
    Name = "Speed Boost", -- اسم التبديل
    Default = false, -- القيمة الافتراضية (غير مفعل)
    Flag = "speedBoostToggle", -- معرف التبديل
    Callback = function(Value)
        if Value then
            -- تفعيل السرعة العالية
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 100 -- يمكنك تغيير القيمة
            print("Speed Boost enabled!")
        else
            -- إعادة السرعة إلى القيمة الافتراضية
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16 -- القيمة الافتراضية
            print("Speed Boost disabled!")
        end
    end
})

local infiniteJumpEnabled = false

playerTab:AddToggle({
    Name = "Infinite Jump",
    Default = false,
    Flag = "infiniteJumpToggle",
    Callback = function(Value)
        infiniteJumpEnabled = Value
        if Value then
            print("Infinite Jump enabled!")
        else
            print("Infinite Jump disabled!")
        end
    end
})


game:GetService("UserInputService").JumpRequest:Connect(function()
    if infiniteJumpEnabled then
        local player = game.Players.LocalPlayer
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)


playerTab:AddSection({
    Name = "moodess"
})

local invisibilityEnabled = false
playerTab:AddToggle({
    Name = "Invisibility",
    Default = false,
    Flag = "invisibilityToggle",
    Callback = function(Value)
        invisibilityEnabled = Value
        if Value then
            -- تفعيل الإخفاء
            for _, part in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.Transparency = 1 -- جعل الأجزاء شفافة
                end
            end
            print("Invisibility enabled!")
       else
            -- إعادة الظهور
            for _, part in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.Transparency = 0 -- إعادة الأجزاء إلى حالتها الأصلية
                end
            end
            print("Invisibility disabled!")
        end
    end
})

playerTab:AddSection({
    Name = "copy ..."
})

local playerList = {}
local dropdown = playerTab:AddDropdown({
    Name = "Select Player",
    Options = playerList,
    Default = "None",
    Flag = "playerDropdown",
    Callback = function(Value)
        print("Selected Player: " .. Value)
    end
})

local function updatePlayerList()
    playerList = {}
    for _, player in pairs(game.Players:GetPlayers()) do
        if player ~= game.Players.LocalPlayer then
            table.insert(playerList, player.Name)
        end
    end
    dropdown:UpdateOptions(playerList) -- تحديث القائمة
end

-- تحديث القائمة كل 5 ثواني
spawn(function()
    while true do
        updatePlayerList()
        wait(5)
    end
end)

playerTab:AddButton({
    Name = "Copy Player Skin",
    Desc = "Copy the selected player's skin",
    Callback = function()
        local selectedPlayerName = redzlib:GetFlag("playerDropdown")
        local selectedPlayer = game.Players:FindFirstChild(selectedPlayerName)
        
        if selectedPlayer and selectedPlayer.Character then
            -- حذف السكن الحالي للاعب
            for _, part in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                if part:IsA("BasePart") or part:IsA("Decal") then
                    part:Destroy()
                end
            end
                for _, part in pairs(selectedPlayer.Character:GetDescendants()) do
                if part:IsA("BasePart") or part:IsA("Decal") then
                    local clone = part:Clone()
                    clone.Parent = game.Players.LocalPlayer.Character
                end
            end

            print("Copied skin of: " .. selectedPlayerName)
        else
            print("Player not found or has no character!")
        end
    end
})
-- قسم تنقل

-- قسم اعدادات 

local function SaveSettings()
    local settings = {
        flight = redzlib:GetFlag("flightToggle")
    }
    
    print("Settings saved:", settings)
end

spawn(function()
    while wait(60) do
        SaveSettings()
    end
end)


game:GetService("CoreGui").ChildRemoved:Connect(function(child)
    if child.Name == "Script Mm2" then
        SaveSettings()
        print("Script closed")
    end
end)
