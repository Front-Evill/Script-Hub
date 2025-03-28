local Library = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

local Window = Fluent:CreateWindow({
    Title = "Dead Rails",
    SubTitle = "By front_evill",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

local Tabs = {
    Main = Window:AddTab({ Title = "الرئيسية", Icon = "home" })
}

local MainSection = Tabs.Main:AddSection("التحكم الرئيسي")

local themeColors = {
    {Name = "White", Theme = "White"},
    {Name = "Dark", Theme = "Dark"},
    {Name = "Darker", Theme = "Darker"},
    {Name = "Pink", Theme = "Pink"}
}

for _, themeData in ipairs(themeColors) do
    MainSection:AddButton({
        Title = themeData.Name,
        Callback = function()
            Fluent:SetTheme(themeData.Theme)
        end
    })
end

MainSection:AddButton({
    Title = "تبديل النهار والليل",
    Callback = function()
        local Lighting = game:GetService("Lighting")
        
        local isNightMode = Lighting.ClockTime <= 6 or Lighting.ClockTime >= 18
        
        if isNightMode then
            Lighting.Brightness = 2
            Lighting.ClockTime = 14
            Lighting.FogEnd = 100000
            Lighting.GlobalShadows = true
        else
            Lighting.Brightness = 0
            Lighting.ClockTime = 0
            Lighting.FogEnd = 50000
            Lighting.GlobalShadows = false
        end
    end
})

MainSection:AddButton({
    Title = "Aim Bot",
    Callback = function()
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
        
        local zombies = {}
        for _, zombie in pairs(workspace:GetChildren()) do
            if zombie:FindFirstChild("Zombie") and zombie ~= character then
                table.insert(zombies, zombie)
            end
        end
        
        if #zombies > 0 then
            local closestZombie = zombies[1]
            local shortestDistance = (closestZombie.HumanoidRootPart.Position - humanoidRootPart.Position).Magnitude
            
            for _, zombie in pairs(zombies) do
                local distance = (zombie.HumanoidRootPart.Position - humanoidRootPart.Position).Magnitude
                if distance < shortestDistance then
                    closestZombie = zombie
                    shortestDistance = distance
                end
            end
            
            humanoidRootPart.CFrame = CFrame.new(humanoidRootPart.Position, closestZombie.HumanoidRootPart.Position)
        end
    end
})
