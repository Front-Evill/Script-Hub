local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

local Window = Fluent:CreateWindow({
    Title = "Script mm2",
    SubTitle = "By Front",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true, -- The blur may be detectable, setting this to false disables blur entirely
    Theme = "Darker", -- Light or Darker or Rose
    MinimizeKey = Enum.KeyCode.LeftControl -- Used when theres no MinimizeKeybind
})

-- Fluent provides Lucide Icons, they are optional
local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "rbxassetid://131460145238951" })
}

local Section = Main:AddSection("Section Name")
Section:AddParagraph({
    Title = "Fly"
})

Tab:AddButton({
    Title = "Button",
    Description = "Very important button",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Front-Evill/Script-Hub/refs/heads/main/Fly.lua.txt"))()
    end
})
