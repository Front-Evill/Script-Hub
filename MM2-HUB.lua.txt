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
    Icon = "rbxassetid://103167069627270" 
})

Main:AddSection({
        Name = "Auro Farm"
})

Main:AddButton({
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


local Esp = window:MakeTab({
    Title = "Esp",
    Icon = "rbxassetid://123456789"
})


Esp:AddSection({
    Name = "ESP"
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


Esp:AddSection({
    Name = "Gun Esp"
})


local Telepord = window:MakeTab({
    Title = "Teleport", --name
    Icon = "rbxassetid://139926030461097" -- icons 
})



local seting = window:MakeTab({
    Title = "Seting Script", --name
    Icon = "rbxassetid://10709810948" -- icons 
})



local Server = window:MakeTab({
    Title = "Server", -- name
    Icon = "rbxassetid://93989683556149" -- icoon
})

Server:AddSection({
    Name = "Server"
})

-- زر الانتقال إلى سيرفر آخر
Server:AddButton({
    Name = "New Server",
    Desc = "الانتقال إلى سيرفر مختلف",
    Callback = function()
        window:Dialog({
            Title = "تأكيد الانتقال | are you sure ?",
            Content = "هل أنت متأكد أنك تريد الانتقال إلى سيرفر آخر؟",
            Buttons = {
                {
                    Title = "نعم | Yes",
                    Callback = function()
                        local TeleportService = game:GetService("TeleportService")
                        local PlaceId = game.PlaceId
                        
                        local function joinDifferentServer()
                            -- الحصول على قائمة السيرفرات المتاحة
                            local servers = {}
                            local pageSize = 100
                            local success, errorMessage = pcall(function()
                                -- استخدام GetGlobalInstances() للحصول على قائمة بالسيرفرات المتاحة
                                local res = game:GetService("HttpService"):JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..PlaceId.."/servers/Public?sortOrder=Asc&limit="..pageSize))
                                for _, server in ipairs(res.data) do
                                    if server.playing < server.maxPlayers and server.id ~= game.JobId then
                                        table.insert(servers, server)
                                    end
                                end
                            end)
                            
                            if #servers > 0 then
                                -- اختيار سيرفر عشوائي واستبعاد السيرفر الحالي
                                local selectedServer = servers[math.random(1, #servers)]
                                TeleportService:TeleportToPlaceInstance(PlaceId, selectedServer.id, game.Players.LocalPlayer)
                            else
                                -- إذا لم يتم العثور على سيرفرات، قم بإنشاء سيرفر جديد
                                TeleportService:Teleport(PlaceId, game.Players.LocalPlayer)
                            end
                        end
                        
                        Functions.Notify("جارٍ الانتقال", "جارٍ البحث عن سيرفر متاح...")
                        joinDifferentServer()
                    end
                },
                {
                    Title = "No | لا"
                }
            }
        })
    end
})

-- زر إعادة الاتصال بنفس السيرفر (Rejoin)
Server:AddButton({
    Name = "Rejoin",
    Desc = "الخروج و الدخول ب نفس سيرفر",
    Callback = function()
        window:Dialog({
            Title = "تأكيد إعادة الاتصال | are you sure ?",
            Content = "هل أنت متأكد أنك تريد إعادة الاتصال بنفس السيرفر؟ | are yoou sure?",
            Buttons = {
                {
                    Title = "نعم | yes",
                    Callback = function()
                        local TeleportService = game:GetService("TeleportService")
                        local Players = game:GetService("Players")
                        local LocalPlayer = Players.LocalPlayer
                        
                        Functions.Notify("جارٍ إعادة الاتصال", "سيتم إعادة الاتصال بالسيرفر حالاً...")
                        
                        -- إلغاء أي عمليات جارية قبل إعادة الاتصال
                        Functions.StopAllTweens()
                        
                        if getgenv().FlyConnection then
                            getgenv().FlyConnection:Disconnect()
                        end
                        
                        if getgenv().FlyPart then
                            getgenv().FlyPart:Destroy()
                        end
                        
                        -- إعادة الاتصال بنفس السيرفر باستخدام معرف السيرفر الحالي
                        TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
                    end
                },
                {
                    Title = "لا | No"
                }
            }
        })
    end
})

Server:AddParagraph({
    Title = "كيف استعله؟", -- example 
    Text = [[
        - new server; يقوم ب نقلك الئ سيرفر جديد
        - rejoin ; يجعلك تخرج و تدخل الئ نفس سيرفر
        - ما فائده rejoin ? ; تحتاجه اذا كان لديك خطاء في العبه او شيء لاك (lag)
    ]]
})


Server:AddSection({
    Name = "mnpuer"
})

-- الوصول إلى خدمة اللاعبين
local Players = game:GetService("Players")

-- إنشاء فقرة لعرض عدد اللاعبين
local playerCountParagraph = Server:AddParagraph({
    Title = "Number of players",
    Text = "عدد لاعبين ..."
})

-- دالة لتحديث معلومات اللاعبين
function updatePlayerCount()
    local playerCount = #Players:GetPlayers()
    local maxPlayers = Players.MaxPlayers
    
    -- تحديث عدد اللاعبين
    playerCountParagraph:SetText(playerCount .. " / " .. maxPlayers .. " لاعب")
end

-- تحديث المعلومات عند تشغيل السكربت
updatePlayerCount()

-- تحديث المعلومات كل 5 ثوانٍ
spawn(function()
    while wait(5) do
        updatePlayerCount()
    end
end)

-- تحديث فوري عند انضمام أو مغادرة لاعب
Players.PlayerAdded:Connect(updatePlayerCount)
Players.PlayerRemoving:Connect(updatePlayerCount)
