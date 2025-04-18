local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

local Window = Fluent:CreateWindow({
    Title = "mm2" .. Fluent.Version,
    SubTitle = "by dawid",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true, 
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl 
})

-- Fluent provides Lucide Icons, they are optional
local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "user" }),
}

local DanceHub3 = Tabs.Main:AddSection("DANCE FREE")

DanceHub3:AddButton({
    Title = "Floss Dance",
    Description = nil,
    Callback = function()
        local args = {
            [1] = "Floss",
            [2] = 16488431869
        }
        game:GetService("ReplicatedStorage").PlayEmote:Fire(unpack(args))
    end
})

DanceHub3:AddButton({
    Title = "Zombie Dance",
    Description = nil,
    Callback = function()
        local args = {
            [1] = "Zombie",
            [2] = 4212499637
        }
        game:GetService("ReplicatedStorage").PlayEmote:Fire(unpack(args))
    end
})

DanceHub3:AddButton({
    Title = "Dab Dance",
    Description = nil,
    Callback = function()
        local args = {
            [1] = "Dab",
            [2] = 4212499189
        }
        game:GetService("ReplicatedStorage").PlayEmote:Fire(unpack(args))
    end
})

DanceHub3:AddButton({
    Title = "Ninja Dance",
    Description = nil,
    Callback = function()
        local args = {
            [1] = "Ninja",
            [2] = 4212500292
        }
        game:GetService("ReplicatedStorage").PlayEmote:Fire(unpack(args))
    end
})

DanceHub3:AddButton({
    Title = "Groove Dance",
    Description = nil,
    Callback = function()
        local args = {
            [1] = "Groove",
            [2] = 4212506118
        }
        game:GetService("ReplicatedStorage").PlayEmote:Fire(unpack(args))
    end
})

-- Basic Roblox Dances
DanceHub3:AddButton({
    Title = "Hip Hop Dance",
    Description = nil,
    Callback = function()
        local args = {
            [1] = "Hip Hop",
            [2] = 3695500161
        }
        game:GetService("ReplicatedStorage").PlayEmote:Fire(unpack(args))
    end
})

DanceHub3:AddButton({
    Title = "Disco Dance",
    Description = nil,
    Callback = function()
        local args = {
            [1] = "Disco",
            [2] = 3695493465
        }
        game:GetService("ReplicatedStorage").PlayEmote:Fire(unpack(args))
    end
})

DanceHub3:AddButton({
    Title = "Robot Dance",
    Description = nil,
    Callback = function()
        local args = {
            [1] = "Robot",
            [2] = 3695525251
        }
        game:GetService("ReplicatedStorage").PlayEmote:Fire(unpack(args))
    end
})

DanceHub3:AddButton({
    Title = "Twirl Dance",
    Description = nil,
    Callback = function()
        local args = {
            [1] = "Twirl",
            [2] = 3695486745
        }
        game:GetService("ReplicatedStorage").PlayEmote:Fire(unpack(args))
    end
})

DanceHub3:AddButton({
    Title = "Silly Dance",
    Description = nil,
    Callback = function()
        local args = {
            [1] = "Silly Dance",
            [2] = 4212499771
        }
        game:GetService("ReplicatedStorage").PlayEmote:Fire(unpack(args))
    end
})

-- Adding more popular dances
DanceHub3:AddButton({
    Title = "Breakdance",
    Description = nil,
    Callback = function()
        local args = {
            [1] = "Breakdance",
            [2] = 5915648917
        }
        game:GetService("ReplicatedStorage").PlayEmote:Fire(unpack(args))
    end
})

DanceHub3:AddButton({
    Title = "Electro Shuffle",
    Description = nil,
    Callback = function()
        local args = {
            [1] = "Electro Shuffle",
            [2] = 3695333486
        }
        game:GetService("ReplicatedStorage").PlayEmote:Fire(unpack(args))
    end
})

DanceHub3:AddButton({
    Title = "Orange Justice",
    Description = nil,
    Callback = function()
        local args = {
            [1] = "Orange Justice",
            [2] = 3695342270
        }
        game:GetService("ReplicatedStorage").PlayEmote:Fire(unpack(args))
    end
})

DanceHub3:AddButton({
    Title = "Take The L",
    Description = nil,
    Callback = function()
        local args = {
            [1] = "Take The L",
            [2] = 4049646104
        }
        game:GetService("ReplicatedStorage").PlayEmote:Fire(unpack(args))
    end
})

DanceHub3:AddButton({
    Title = "Hype Dance",
    Description = nil,
    Callback = function()
        local args = {
            [1] = "Hype",
            [2] = 3695373233
        }
        game:GetService("ReplicatedStorage").PlayEmote:Fire(unpack(args))
    end
})

DanceHub3:AddButton({
    Title = "Default Dance",
    Description = nil,
    Callback = function()
        local args = {
            [1] = "Default Dance",
            [2] = 4212499637
        }
        game:GetService("ReplicatedStorage").PlayEmote:Fire(unpack(args))
    end
})

DanceHub3:AddButton({
    Title = "Macarena",
    Description = nil,
    Callback = function()
        local args = {
            [1] = "Macarena",
            [2] = 4235834241
        }
        game:GetService("ReplicatedStorage").PlayEmote:Fire(unpack(args))
    end
})

DanceHub3:AddButton({
    Title = "Gangnam Style",
    Description = nil,
    Callback = function()
        local args = {
            [1] = "Gangnam Style",
            [2] = 4235835055
        }
        game:GetService("ReplicatedStorage").PlayEmote:Fire(unpack(args))
    end
})

DanceHub3:AddButton({
    Title = "Moonwalk",
    Description = nil,
    Callback = function()
        local args = {
            [1] = "Moonwalk",
            [2] = 4212500834
        }
        game:GetService("ReplicatedStorage").PlayEmote:Fire(unpack(args))
    end
})

DanceHub3:AddButton({
    Title = "Carlton Dance",
    Description = nil,
    Callback = function()
        local args = {
            [1] = "Carlton",
            [2] = 4235823281
        }
        game:GetService("ReplicatedStorage").PlayEmote:Fire(unpack(args))
    end
})
