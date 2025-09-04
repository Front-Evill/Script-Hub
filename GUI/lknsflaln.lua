local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local SoundService = game:GetService("SoundService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AssetDetector"
screenGui.Parent = playerGui
screenGui.ResetOnSpawn = false

local notificationSound = Instance.new("Sound")
notificationSound.SoundId = "rbxassetid://3398620867"
notificationSound.Volume = 0.5
notificationSound.Parent = SoundService

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 650, 0, 620)
mainFrame.Position = UDim2.new(0.5, -325, 0.5, -310)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = mainFrame

local shadow = Instance.new("ImageLabel")
shadow.Name = "Shadow"
shadow.Parent = screenGui
shadow.AnchorPoint = Vector2.new(0.5, 0.5)
shadow.BackgroundTransparency = 1
shadow.Position = mainFrame.Position
shadow.Size = mainFrame.Size + UDim2.new(0, 20, 0, 20)
shadow.Image = "rbxasset://textures/ui/Controls/DropShadow/DropShadow.png"
shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
shadow.ImageTransparency = 0.5
shadow.ScaleType = Enum.ScaleType.Slice
shadow.SliceCenter = Rect.new(12, 12, 256 - 12, 256 - 12)
shadow.ZIndex = mainFrame.ZIndex - 1

local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 45)
titleBar.Position = UDim2.new(0, 0, 0, 0)
titleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 12)
titleCorner.Parent = titleBar

local titleLine = Instance.new("Frame")
titleLine.Size = UDim2.new(1, -20, 0, 2)
titleLine.Position = UDim2.new(0, 10, 1, -2)
titleLine.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
titleLine.BorderSizePixel = 0
titleLine.Parent = titleBar

local lineCorner = Instance.new("UICorner")
lineCorner.CornerRadius = UDim.new(0, 1)
lineCorner.Parent = titleLine

local logoFrame = Instance.new("Frame")
logoFrame.Size = UDim2.new(0, 35, 0, 35)
logoFrame.Position = UDim2.new(0, 8, 0, 5)
logoFrame.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
logoFrame.BorderSizePixel = 0
logoFrame.Parent = titleBar

local logoCorner = Instance.new("UICorner")
logoCorner.CornerRadius = UDim.new(0, 8)
logoCorner.Parent = logoFrame

local logoIcon = Instance.new("TextLabel")
logoIcon.Size = UDim2.new(1, 0, 1, 0)
logoIcon.Position = UDim2.new(0, 0, 0, 0)
logoIcon.BackgroundTransparency = 1
logoIcon.Text = "FE"
logoIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
logoIcon.TextSize = 16
logoIcon.Font = Enum.Font.GothamBold
logoIcon.Parent = logoFrame

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, -250, 1, 0)
titleLabel.Position = UDim2.new(0, 50, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "FRONT EVILL Asset Detector v4.0"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextSize = 16
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = titleBar

local hideButton = Instance.new("TextButton")
hideButton.Size = UDim2.new(0, 35, 0, 35)
hideButton.Position = UDim2.new(1, -80, 0, 5)
hideButton.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
hideButton.BorderSizePixel = 0
hideButton.Text = "-"
hideButton.TextColor3 = Color3.fromRGB(255, 255, 255)
hideButton.TextSize = 18
hideButton.Font = Enum.Font.GothamBold
hideButton.Parent = titleBar

local hideCorner = Instance.new("UICorner")
hideCorner.CornerRadius = UDim.new(0, 8)
hideCorner.Parent = hideButton

local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 35, 0, 35)
closeButton.Position = UDim2.new(1, -40, 0, 5)
closeButton.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
closeButton.BorderSizePixel = 0
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.TextSize = 16
closeButton.Font = Enum.Font.GothamBold
closeButton.Parent = titleBar

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 8)
closeCorner.Parent = closeButton

local assetsFrame = Instance.new("Frame")
assetsFrame.Size = UDim2.new(1, -20, 1, -55)
assetsFrame.Position = UDim2.new(0, 10, 0, 45)
assetsFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
assetsFrame.BorderSizePixel = 0
assetsFrame.Parent = mainFrame

local assetsCorner = Instance.new("UICorner")
assetsCorner.CornerRadius = UDim.new(0, 10)
assetsCorner.Parent = assetsFrame

local assetsTitle = Instance.new("TextLabel")
assetsTitle.Size = UDim2.new(1, 0, 0, 30)
assetsTitle.Position = UDim2.new(0, 0, 0, 0)
assetsTitle.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
assetsTitle.BorderSizePixel = 0
assetsTitle.Text = "ASSETS DETECTOR"
assetsTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
assetsTitle.TextSize = 14
assetsTitle.Font = Enum.Font.GothamBold
assetsTitle.Parent = assetsFrame

local assetsTitleCorner = Instance.new("UICorner")
assetsTitleCorner.CornerRadius = UDim.new(0, 10)
assetsTitleCorner.Parent = assetsTitle

local statsFrame = Instance.new("Frame")
statsFrame.Size = UDim2.new(1, -20, 0, 50)
statsFrame.Position = UDim2.new(0, 10, 0, 35)
statsFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
statsFrame.BorderSizePixel = 0
statsFrame.Parent = assetsFrame

local statsCorner = Instance.new("UICorner")
statsCorner.CornerRadius = UDim.new(0, 8)
statsCorner.Parent = statsFrame

local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, -10, 0, 20)
statusLabel.Position = UDim2.new(0, 5, 0, 5)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "Status: Active - Monitoring New Assets"
statusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
statusLabel.TextSize = 11
statusLabel.Font = Enum.Font.Gotham
statusLabel.TextXAlignment = Enum.TextXAlignment.Left
statusLabel.Parent = statsFrame

local countLabel = Instance.new("TextLabel")
countLabel.Size = UDim2.new(1, -10, 0, 20)
countLabel.Position = UDim2.new(0, 5, 0, 25)
countLabel.BackgroundTransparency = 1
countLabel.Text = "Found: 0 assets"
countLabel.TextColor3 = Color3.fromRGB(255, 255, 100)
countLabel.TextSize = 11
countLabel.Font = Enum.Font.Gotham
countLabel.TextXAlignment = Enum.TextXAlignment.Left
countLabel.Parent = statsFrame

local buttonFrame = Instance.new("Frame")
buttonFrame.Size = UDim2.new(1, -20, 0, 70)
buttonFrame.Position = UDim2.new(0, 10, 0, 90)
buttonFrame.BackgroundTransparency = 1
buttonFrame.Parent = assetsFrame

local clearButton = Instance.new("TextButton")
clearButton.Size = UDim2.new(0, 100, 0, 30)
clearButton.Position = UDim2.new(0, 0, 0, 0)
clearButton.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
clearButton.BorderSizePixel = 0
clearButton.Text = "Clear Screen"
clearButton.TextColor3 = Color3.fromRGB(255, 255, 255)
clearButton.TextSize = 11
clearButton.Font = Enum.Font.GothamBold
clearButton.Parent = buttonFrame

local clearCorner = Instance.new("UICorner")
clearCorner.CornerRadius = UDim.new(0, 8)
clearCorner.Parent = clearButton

local saveButton = Instance.new("TextButton")
saveButton.Size = UDim2.new(0, 100, 0, 30)
saveButton.Position = UDim2.new(0, 110, 0, 0)
saveButton.BackgroundColor3 = Color3.fromRGB(100, 255, 100)
saveButton.BorderSizePixel = 0
saveButton.Text = "Save File"
saveButton.TextColor3 = Color3.fromRGB(0, 0, 0)
saveButton.TextSize = 11
saveButton.Font = Enum.Font.GothamBold
saveButton.Parent = buttonFrame

local saveCorner = Instance.new("UICorner")
saveCorner.CornerRadius = UDim.new(0, 8)
saveCorner.Parent = saveButton

local deleteFileButton = Instance.new("TextButton")
deleteFileButton.Size = UDim2.new(0, 120, 0, 30)
deleteFileButton.Position = UDim2.new(0, 220, 0, 0)
deleteFileButton.BackgroundColor3 = Color3.fromRGB(255, 150, 50)
deleteFileButton.BorderSizePixel = 0
deleteFileButton.Text = "Delete All ID (File)"
deleteFileButton.TextColor3 = Color3.fromRGB(255, 255, 255)
deleteFileButton.TextSize = 11
deleteFileButton.Font = Enum.Font.GothamBold
deleteFileButton.Parent = buttonFrame

local deleteFileCorner = Instance.new("UICorner")
deleteFileCorner.CornerRadius = UDim.new(0, 8)
deleteFileCorner.Parent = deleteFileButton

local controlToolButton = Instance.new("TextButton")
controlToolButton.Size = UDim2.new(0, 150, 0, 30)
controlToolButton.Position = UDim2.new(0, 350, 0, 0)
controlToolButton.BackgroundColor3 = Color3.fromRGB(150, 100, 255)
controlToolButton.BorderSizePixel = 0
controlToolButton.Text = "Targting Player"
controlToolButton.TextColor3 = Color3.fromRGB(255, 255, 255)
controlToolButton.TextSize = 11
controlToolButton.Font = Enum.Font.GothamBold
controlToolButton.Parent = buttonFrame

local controlToolCorner = Instance.new("UICorner")
controlToolCorner.CornerRadius = UDim.new(0, 8)
controlToolCorner.Parent = controlToolButton

local assetScrollFrame = Instance.new("ScrollingFrame")
assetScrollFrame.Size = UDim2.new(1, -20, 1, -170)
assetScrollFrame.Position = UDim2.new(0, 10, 0, 165)
assetScrollFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 65)
assetScrollFrame.BorderSizePixel = 0
assetScrollFrame.ScrollBarThickness = 8
assetScrollFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 150, 255)
assetScrollFrame.Parent = assetsFrame

local assetScrollCorner = Instance.new("UICorner")
assetScrollCorner.CornerRadius = UDim.new(0, 8)
assetScrollCorner.Parent = assetScrollFrame

local assetListLayout = Instance.new("UIListLayout")
assetListLayout.Padding = UDim.new(0, 5)
assetListLayout.SortOrder = Enum.SortOrder.LayoutOrder
assetListLayout.Parent = assetScrollFrame

local detectedAssets = {}
local savedAssets = {}
local assetCount = 0
local isVisible = true
local existingGUIs = {}
local isScanning = false
local playerConnections = {}
local permanentlyDetectedAssets = {}
local monitoredPlayers = {}

local assetTypes = {
  ["Sound"] = {color = Color3.fromRGB(255, 150, 100), patterns = {"SoundId"}},
  ["Image/Decal"] = {color = Color3.fromRGB(100, 255, 150), patterns = {"Image", "Texture", "ImageRectOffset", "ImageRectSize"}},
  ["Animation"] = {color = Color3.fromRGB(255, 100, 255), patterns = {"AnimationId"}},
  ["Mesh"] = {color = Color3.fromRGB(100, 150, 255), patterns = {"MeshId", "TextureId"}},
  ["Skybox"] = {color = Color3.fromRGB(255, 255, 100), patterns = {"SkyboxBk", "SkyboxDn", "SkyboxFt", "SkyboxLf", "SkyboxRt", "SkyboxUp"}},
  ["Shirt/Pants"] = {color = Color3.fromRGB(150, 255, 255), patterns = {"ShirtTemplate", "PantsTemplate"}},
  ["Other"] = {color = Color3.fromRGB(200, 200, 200), patterns = {}}
}

local animationTypes = {
    ["fall"] = {name = "Fall Animation", color = Color3.fromRGB(255, 100, 100)},
    ["climb"] = {name = "Climb Animation", color = Color3.fromRGB(150, 100, 255)},
    ["jump"] = {name = "Jump Animation", color = Color3.fromRGB(100, 255, 100)},
    ["run"] = {name = "Run Animation", color = Color3.fromRGB(255, 200, 100)},
    ["walk"] = {name = "Walk Animation", color = Color3.fromRGB(100, 200, 255)},
    ["idle"] = {name = "Idle Animation", color = Color3.fromRGB(200, 200, 200)},
}

local assetPatterns = {
  "rbxassetid://([%d,]+)",
  "http://www%.roblox%.com/asset/%?id=([%d,]+)",
  "https://www%.roblox%.com/asset/%?id=([%d,]+)",
  "rbxasset://([%S]+)",
  "content://([%S]+)"
}

local function getAssetType(propertyName, value)
  for typeName, typeData in pairs(assetTypes) do
      for _, pattern in pairs(typeData.patterns) do
          if string.find(propertyName, pattern) then
              return typeName, typeData.color
          end
      end
  end
  return "Other", assetTypes["Other"].color
end

local function getAnimationType(animationId, animType)
    if animType and animationTypes[animType] then
        return animationTypes[animType].name, animationTypes[animType].color
    end
    return "Custom Animation", Color3.fromRGB(255, 100, 255)
end

local function extractFullId(text)
  local patterns = {
      "rbxassetid://([%d,]+)",
      "http://www%.roblox%.com/asset/%?id=([%d,]+)", 
      "https://www%.roblox%.com/asset/%?id=([%d,]+)"
  }
  
  for _, pattern in pairs(patterns) do
      local match = string.match(text, pattern)
      if match then
          return match
      end
  end
  return nil
end

local function extractAssets(text)
  local foundAssets = {}
  for _, pattern in pairs(assetPatterns) do
      for match in string.gmatch(text, pattern) do
          if match and match ~= "" then
              local baseId = string.match(match, "(%d+)")
              if baseId and not permanentlyDetectedAssets[baseId] then
                  table.insert(foundAssets, match)
              end
          end
      end
  end
  return foundAssets
end

local function saveAssetToFile(assetData)
  local fileName = "FRONT_EVILL_Assets.lua"
  local assetInfo = {
      id = assetData.url,
      type = assetData.assetType,
      object = assetData.objectName,
      property = assetData.propertyName,
      path = assetData.fullPath,
      originalText = assetData.originalText,
      timestamp = os.date("%Y-%m-%d %H:%M:%S"),
      animationType = assetData.animationType or nil
  }
  
  table.insert(savedAssets, assetInfo)
  
  local content = "-- FRONT EVILL Asset Detector Log\n"
  content = content .. "-- Generated on: " .. os.date("%Y-%m-%d %H:%M:%S") .. "\n\n"
  content = content .. "local detectedAssets = {\n"
  
  for i, asset in pairs(savedAssets) do
      content = content .. "    [" .. i .. "] = {\n"
      content = content .. "        id = \"" .. asset.id .. "\",\n"
      content = content .. "        type = \"" .. asset.type .. "\",\n"
      content = content .. "        object = \"" .. asset.object .. "\",\n"
      content = content .. "        property = \"" .. asset.property .. "\",\n"
      content = content .. "        path = \"" .. asset.path .. "\",\n"
      content = content .. "        originalText = \"" .. asset.originalText .. "\",\n"
      if asset.animationType then
          content = content .. "        animationType = \"" .. asset.animationType .. "\",\n"
      end
      content = content .. "        timestamp = \"" .. asset.timestamp .. "\"\n"
      content = content .. "    }"
      if i < #savedAssets then
          content = content .. ","
      end
      content = content .. "\n"
  end
  
  content = content .. "}\n\n"
  content = content .. "return detectedAssets"
  
  writefile(fileName, content)
end

local function createAssetEntry(assetUrl, propertyName, objectName, fullPath, assetType, typeColor, originalText, animationType)
  local entryFrame = Instance.new("Frame")
  entryFrame.Size = UDim2.new(1, -10, 0, 110)
  entryFrame.BackgroundColor3 = Color3.fromRGB(50, 60, 75)
  entryFrame.BorderSizePixel = 0
  entryFrame.Parent = assetScrollFrame
  
  local entryCorner = Instance.new("UICorner")
  entryCorner.CornerRadius = UDim.new(0, 8)
  entryCorner.Parent = entryFrame
  
  local highlight = Instance.new("Frame")
  highlight.Size = UDim2.new(0, 4, 1, 0)
  highlight.Position = UDim2.new(0, 0, 0, 0)
  highlight.BackgroundColor3 = typeColor
  highlight.BorderSizePixel = 0
  highlight.Parent = entryFrame
  
  local highlightCorner = Instance.new("UICorner")
  highlightCorner.CornerRadius = UDim.new(0, 8)
  highlightCorner.Parent = highlight
  
  local typeLabel = Instance.new("TextLabel")
  typeLabel.Size = UDim2.new(0, 90, 0, 20)
  typeLabel.Position = UDim2.new(0, 8, 0, 5)
  typeLabel.BackgroundColor3 = typeColor
  typeLabel.BorderSizePixel = 0
  typeLabel.Text = animationType or assetType
  typeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
  typeLabel.TextSize = 10
  typeLabel.Font = Enum.Font.GothamBold
  typeLabel.Parent = entryFrame
  
  local typeLabelCorner = Instance.new("UICorner")
  typeLabelCorner.CornerRadius = UDim.new(0, 4)
  typeLabelCorner.Parent = typeLabel
  
  local urlLabel = Instance.new("TextLabel")
  urlLabel.Size = UDim2.new(1, -200, 0, 16)
  urlLabel.Position = UDim2.new(0, 8, 0, 28)
  urlLabel.BackgroundTransparency = 1
  urlLabel.Text = "ID: " .. assetUrl
  urlLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
  urlLabel.TextSize = 10
  urlLabel.Font = Enum.Font.GothamBold
  urlLabel.TextXAlignment = Enum.TextXAlignment.Left
  urlLabel.TextTruncate = Enum.TextTruncate.AtEnd
  urlLabel.Parent = entryFrame
  
  local objectLabel = Instance.new("TextLabel")
  objectLabel.Size = UDim2.new(1, -200, 0, 14)
  objectLabel.Position = UDim2.new(0, 8, 0, 46)
  objectLabel.BackgroundTransparency = 1
  objectLabel.Text = "Object: " .. objectName
  objectLabel.TextColor3 = Color3.fromRGB(200, 200, 255)
  objectLabel.TextSize = 9
  objectLabel.Font = Enum.Font.Gotham
  objectLabel.TextXAlignment = Enum.TextXAlignment.Left
  objectLabel.TextTruncate = Enum.TextTruncate.AtEnd
  objectLabel.Parent = entryFrame
  
  local propertyLabel = Instance.new("TextLabel")
  propertyLabel.Size = UDim2.new(1, -200, 0, 14)
  propertyLabel.Position = UDim2.new(0, 8, 0, 62)
  propertyLabel.BackgroundTransparency = 1
  propertyLabel.Text = "Property: " .. propertyName
  propertyLabel.TextColor3 = Color3.fromRGB(255, 255, 150)
  propertyLabel.TextSize = 9
  propertyLabel.Font = Enum.Font.Gotham
  propertyLabel.TextXAlignment = Enum.TextXAlignment.Left
  propertyLabel.TextTruncate = Enum.TextTruncate.AtEnd
  propertyLabel.Parent = entryFrame
  
  local timeLabel = Instance.new("TextLabel")
  timeLabel.Size = UDim2.new(1, -200, 0, 14)
  timeLabel.Position = UDim2.new(0, 8, 0, 78)
  timeLabel.BackgroundTransparency = 1
  timeLabel.Text = "Found: " .. os.date("%H:%M:%S")
  timeLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
  timeLabel.TextSize = 8
  timeLabel.Font = Enum.Font.Gotham
  timeLabel.TextXAlignment = Enum.TextXAlignment.Left
  timeLabel.Parent = entryFrame
  
  local buttonWidth = 55
  local buttonHeight = 20
  local buttonSpacing = 5
  
  local copyIdButton = Instance.new("TextButton")
  copyIdButton.Size = UDim2.new(0, buttonWidth, 0, buttonHeight)
  copyIdButton.Position = UDim2.new(1, -(buttonWidth * 2 + buttonSpacing + 10), 0, 8)
  copyIdButton.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
  copyIdButton.BorderSizePixel = 0
  copyIdButton.Text = "Copy ID"
  copyIdButton.TextColor3 = Color3.fromRGB(255, 255, 255)
  copyIdButton.TextSize = 8
  copyIdButton.Font = Enum.Font.GothamBold
  copyIdButton.Parent = entryFrame
  
  local copyIdCorner = Instance.new("UICorner")
  copyIdCorner.CornerRadius = UDim.new(0, 4)
  copyIdCorner.Parent = copyIdButton
  
  local copyFullIdButton = Instance.new("TextButton")
  copyFullIdButton.Size = UDim2.new(0, buttonWidth, 0, buttonHeight)
  copyFullIdButton.Position = UDim2.new(1, -(buttonWidth + 10), 0, 8)
  copyFullIdButton.BackgroundColor3 = Color3.fromRGB(255, 150, 255)
  copyFullIdButton.BorderSizePixel = 0
  copyFullIdButton.Text = "Full ID"
  copyFullIdButton.TextColor3 = Color3.fromRGB(255, 255, 255)
  copyFullIdButton.TextSize = 8
  copyFullIdButton.Font = Enum.Font.GothamBold
  copyFullIdButton.Parent = entryFrame
  
  local copyFullIdCorner = Instance.new("UICorner")
  copyFullIdCorner.CornerRadius = UDim.new(0, 4)
  copyFullIdCorner.Parent = copyFullIdButton
  
  local copyLineButton = Instance.new("TextButton")
  copyLineButton.Size = UDim2.new(0, buttonWidth, 0, buttonHeight)
  copyLineButton.Position = UDim2.new(1, -(buttonWidth * 2 + buttonSpacing + 10), 0, 33)
  copyLineButton.BackgroundColor3 = Color3.fromRGB(255, 150, 100)
  copyLineButton.BorderSizePixel = 0
  copyLineButton.Text = "Line"
  copyLineButton.TextColor3 = Color3.fromRGB(255, 255, 255)
  copyLineButton.TextSize = 8
  copyLineButton.Font = Enum.Font.GothamBold
  copyLineButton.Parent = entryFrame
  
  local copyLineCorner = Instance.new("UICorner")
  copyLineCorner.CornerRadius = UDim.new(0, 4)
  copyLineCorner.Parent = copyLineButton
  
  local copyPathButton = Instance.new("TextButton")
  copyPathButton.Size = UDim2.new(0, buttonWidth, 0, buttonHeight)
  copyPathButton.Position = UDim2.new(1, -(buttonWidth + 10), 0, 33)
  copyPathButton.BackgroundColor3 = Color3.fromRGB(150, 255, 150)
  copyPathButton.BorderSizePixel = 0
  copyPathButton.Text = "Path"
  copyPathButton.TextColor3 = Color3.fromRGB(0, 0, 0)
  copyPathButton.TextSize = 8
  copyPathButton.Font = Enum.Font.GothamBold
  copyPathButton.Parent = entryFrame
  
  local copyPathCorner = Instance.new("UICorner")
  copyPathCorner.CornerRadius = UDim.new(0, 4)
  copyPathCorner.Parent = copyPathButton
  
  copyIdButton.MouseButton1Click:Connect(function()
      local baseId = string.match(assetUrl, "(%d+)")
      setclipboard(baseId or assetUrl)
      copyIdButton.Text = "Done"
      copyIdButton.BackgroundColor3 = Color3.fromRGB(100, 255, 100)
      spawn(function()
          wait(1.5)
          if copyIdButton and copyIdButton.Parent then
              copyIdButton.Text = "Copy ID"
              copyIdButton.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
          end
      end)
  end)
  
  copyFullIdButton.MouseButton1Click:Connect(function()
      local fullId = extractFullId(originalText) or assetUrl
      setclipboard(fullId)
      copyFullIdButton.Text = "Done"
      copyFullIdButton.BackgroundColor3 = Color3.fromRGB(100, 255, 100)
      spawn(function()
          wait(1.5)
          if copyFullIdButton and copyFullIdButton.Parent then
              copyFullIdButton.Text = "Full ID"
              copyFullIdButton.BackgroundColor3 = Color3.fromRGB(255, 150, 255)
         end
     end)
 end)
 
 copyLineButton.MouseButton1Click:Connect(function()
     setclipboard(originalText)
     copyLineButton.Text = "Done"
     copyLineButton.BackgroundColor3 = Color3.fromRGB(100, 255, 100)
     spawn(function()
         wait(1.5)
         if copyLineButton and copyLineButton.Parent then
             copyLineButton.Text = "Line"
             copyLineButton.BackgroundColor3 = Color3.fromRGB(255, 150, 100)
         end
     end)
 end)
 
 copyPathButton.MouseButton1Click:Connect(function()
     setclipboard(fullPath)
     copyPathButton.Text = "Done"
     copyPathButton.BackgroundColor3 = Color3.fromRGB(100, 255, 100)
     spawn(function()
         wait(1.5)
         if copyPathButton and copyPathButton.Parent then
             copyPathButton.Text = "Path"
             copyPathButton.BackgroundColor3 = Color3.fromRGB(150, 255, 150)
         end
     end)
 end)
 
 return entryFrame
end

local function clearAllAssets()
 for _, child in pairs(assetScrollFrame:GetChildren()) do
     if child:IsA("Frame") and child ~= assetListLayout then
         child:Destroy()
     end
 end
 detectedAssets = {}
 assetCount = 0
 countLabel.Text = "Found: 0 assets"
 assetScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
end

local function saveAllAssets()
 if #savedAssets > 0 then
     local fileName = "FRONT_EVILL_Assets.lua"
     local content = "-- FRONT EVILL Asset Detector Log\n"
     content = content .. "-- Generated on: " .. os.date("%Y-%m-%d %H:%M:%S") .. "\n"
     content = content .. "-- Total Assets: " .. #savedAssets .. "\n\n"
     content = content .. "local detectedAssets = {\n"
     
     for i, asset in pairs(savedAssets) do
         content = content .. "    [" .. i .. "] = {\n"
         content = content .. "        id = \"" .. asset.id .. "\",\n"
         content = content .. "        type = \"" .. asset.type .. "\",\n"
         content = content .. "        object = \"" .. asset.object .. "\",\n"
         content = content .. "        property = \"" .. asset.property .. "\",\n"
         content = content .. "        path = \"" .. asset.path .. "\",\n"
         content = content .. "        originalText = \"" .. asset.originalText .. "\",\n"
         if asset.animationType then
             content = content .. "        animationType = \"" .. asset.animationType .. "\",\n"
         end
         content = content .. "        timestamp = \"" .. asset.timestamp .. "\"\n"
         content = content .. "    }"
         if i < #savedAssets then
             content = content .. ","
         end
         content = content .. "\n"
     end
     
     content = content .. "}\n\n"
     content = content .. "-- Copyright FRONT EVILL\n"
     content = content .. "return detectedAssets"
     
     writefile(fileName, content)
     
     saveButton.Text = "Saved"
     saveButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
     spawn(function()
         wait(2)
         if saveButton and saveButton.Parent then
             saveButton.Text = "Save File"
             saveButton.BackgroundColor3 = Color3.fromRGB(100, 255, 100)
         end
     end)
 end
end

local function deleteAllFiles()
 savedAssets = {}
 local fileName = "FRONT_EVILL_Assets.lua"
 if isfile(fileName) then
     delfile(fileName)
 end
 
 deleteFileButton.Text = "Deleted"
 deleteFileButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
 spawn(function()
     wait(2)
     if deleteFileButton and deleteFileButton.Parent then
         deleteFileButton.Text = "Delete All ID (File)"
         deleteFileButton.BackgroundColor3 = Color3.fromRGB(255, 150, 50)
     end
 end)
end

local function updateAssetScrollSize()
 assetScrollFrame.CanvasSize = UDim2.new(0, 0, 0, assetListLayout.AbsoluteContentSize.Y + 15)
end

local function showNotification(message, color)
 spawn(function()
     notificationSound:Play()
     
     local notification = Instance.new("Frame")
     notification.Size = UDim2.new(0, 350, 0, 80)
     notification.Position = UDim2.new(1, 0, 0, 20)
     notification.BackgroundColor3 = color or Color3.fromRGB(100, 150, 255)
     notification.BorderSizePixel = 0
     notification.Parent = screenGui
     
     local notifCorner = Instance.new("UICorner")
     notifCorner.CornerRadius = UDim.new(0, 10)
     notifCorner.Parent = notification
     
     local notifLabel = Instance.new("TextLabel")
     notifLabel.Size = UDim2.new(1, -20, 1, -10)
     notifLabel.Position = UDim2.new(0, 10, 0, 5)
     notifLabel.BackgroundTransparency = 1
     notifLabel.Text = message
     notifLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
     notifLabel.TextSize = 12
     notifLabel.Font = Enum.Font.GothamBold
     notifLabel.TextWrapped = true
     notifLabel.Parent = notification
     
     local slideIn = TweenService:Create(notification, TweenInfo.new(0.4, Enum.EasingStyle.Back), {Position = UDim2.new(1, -370, 0, 20)})
     slideIn:Play()
     
     wait(3.5)
     
     if notification and notification.Parent then
         local slideOut = TweenService:Create(notification, TweenInfo.new(0.4, Enum.EasingStyle.Back), {Position = UDim2.new(1, 0, 0, 20)})
         slideOut:Play()
         slideOut.Completed:Wait()
         notification:Destroy()
     end
 end)
end

local function showDownloadConfirmation(playerName, playerAnimations)
    local confirmFrame = Instance.new("Frame")
    confirmFrame.Size = UDim2.new(0, 400, 0, 200)
    confirmFrame.Position = UDim2.new(0.5, -200, 0.5, -100)
    confirmFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
    confirmFrame.BorderSizePixel = 0
    confirmFrame.Parent = screenGui
    confirmFrame.ZIndex = 10
    
    local confirmCorner = Instance.new("UICorner")
    confirmCorner.CornerRadius = UDim.new(0, 12)
    confirmCorner.Parent = confirmFrame
    
    local confirmTitle = Instance.new("TextLabel")
    confirmTitle.Size = UDim2.new(1, -20, 0, 40)
    confirmTitle.Position = UDim2.new(0, 10, 0, 10)
    confirmTitle.BackgroundTransparency = 1
    confirmTitle.Text = "Are you sure?"
    confirmTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    confirmTitle.TextSize = 16
    confirmTitle.Font = Enum.Font.GothamBold
    confirmTitle.Parent = confirmFrame
    
    local confirmText = Instance.new("TextLabel")
    confirmText.Size = UDim2.new(1, -20, 0, 80)
    confirmText.Position = UDim2.new(0, 10, 0, 50)
    confirmText.BackgroundTransparency = 1
    confirmText.Text = "Do YOu need download Player targting Animation:\n" .. playerName .. "؟"
    confirmText.TextColor3 = Color3.fromRGB(200, 200, 200)
    confirmText.TextSize = 12
    confirmText.Font = Enum.Font.Gotham
    confirmText.TextWrapped = true
    confirmText.Parent = confirmFrame
    
    local yesButton = Instance.new("TextButton")
    yesButton.Size = UDim2.new(0, 80, 0, 35)
    yesButton.Position = UDim2.new(0, 50, 0, 140)
    yesButton.BackgroundColor3 = Color3.fromRGB(100, 255, 100)
    yesButton.BorderSizePixel = 0
    yesButton.Text = "Yas"
    yesButton.TextColor3 = Color3.fromRGB(0, 0, 0)
    yesButton.TextSize = 14
    yesButton.Font = Enum.Font.GothamBold
    yesButton.Parent = confirmFrame
    
    local yesCorner = Instance.new("UICorner")
    yesCorner.CornerRadius = UDim.new(0, 8)
    yesCorner.Parent = yesButton
    
    local noButton = Instance.new("TextButton")
    noButton.Size = UDim2.new(0, 80, 0, 35)
    noButton.Position = UDim2.new(0, 150, 0, 140)
    noButton.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
    noButton.BorderSizePixel = 0
    noButton.Text = "No"
    noButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    noButton.TextSize = 14
    noButton.Font = Enum.Font.GothamBold
    noButton.Parent = confirmFrame
    
    local noCorner = Instance.new("UICorner")
    noCorner.CornerRadius = UDim.new(0, 8)
    noCorner.Parent = noButton
    
    yesButton.MouseButton1Click:Connect(function()
        confirmFrame:Destroy()
        
        local fileName = "Player_" .. playerName .. "_Animations.lua"
        local content = "-- Player " .. playerName .. " Animations\n"
        content = content .. "-- Generated on: " .. os.date("%Y-%m-%d %H:%M:%S") .. "\n\n"
        content = content .. "local playerAnimations = {\n"
        content = content .. "    playerName = \"" .. playerName .. "\",\n"
        content = content .. "    animations = {\n"
        
        for animType, animData in pairs(playerAnimations) do
            if animData.id then
                content = content .. "        " .. animType .. " = {\n"
                content = content .. "            id = \"" .. animData.id .. "\",\n"
                content = content .. "            name = \"" .. animData.name .. "\",\n"
                content = content .. "            timestamp = \"" .. os.date("%Y-%m-%d %H:%M:%S") .. "\"\n"
                content = content .. "        },\n"
            end
        end
        
        content = content .. "    }\n"
        content = content .. "}\n\n"
        content = content .. "-- Copyright FRONT EVILL\n"
        content = content .. "return playerAnimations"
        
        writefile(fileName, content)
    end)
    
    noButton.MouseButton1Click:Connect(function()
        confirmFrame:Destroy()
    end)
end

local function getFullPath(obj)
 local path = obj.Name
 local current = obj.Parent
 while current and current ~= game do
     path = current.Name .. "." .. path
     current = current.Parent
 end
 return path
end

local function scanObjectForContent(obj)
 local foundAssets = {}
 
 local propertiesToCheck = {
     "Image", "Texture", "Decal", "SoundId", "MeshId", "TextureId", 
     "SkyboxBk", "SkyboxDn", "SkyboxFt", "SkyboxLf", "SkyboxRt", "SkyboxUp",
     "ShirtTemplate", "PantsTemplate", "AnimationId", "Text", "Value"
 }
 
 for _, property in pairs(propertiesToCheck) do
     local success, value = pcall(function() return obj[property] end)
     if success and typeof(value) == "string" and value ~= "" then
         local assets = extractAssets(value)
         for _, asset in pairs(assets) do
             local assetType, typeColor = getAssetType(property, value)
             local fullPath = getFullPath(obj)
             table.insert(foundAssets, {
                 url = asset,
                 propertyName = property,
                 objectName = obj.Name,
                 fullPath = fullPath,
                 assetType = assetType,
                 typeColor = typeColor,
                 originalText = value
             })
         end
     end
 end
 
 return foundAssets
end

local function addAsset(assetData)
 local baseId = string.match(assetData.url, "(%d+)")
 if baseId and not permanentlyDetectedAssets[baseId] and isScanning then
     permanentlyDetectedAssets[baseId] = true
     detectedAssets[baseId] = true
     assetCount = assetCount + 1
     countLabel.Text = "Found: " .. assetCount .. " assets"
     
     createAssetEntry(
         assetData.url,
         assetData.propertyName,
         assetData.objectName,
         assetData.fullPath,
         assetData.assetType,
         assetData.typeColor,
         assetData.originalText,
         assetData.animationType
     )
     
     local saveData = {
         url = assetData.url,
         assetType = assetData.assetType,
         objectName = assetData.objectName,
         propertyName = assetData.propertyName,
         fullPath = assetData.fullPath,
         originalText = assetData.originalText,
         animationType = assetData.animationType
     }
     saveAssetToFile(saveData)
     
     updateAssetScrollSize()
     
     local notificationText = "New " .. (assetData.animationType or assetData.assetType) .. " Found!\nObject: " .. assetData.objectName
     showNotification(notificationText, assetData.typeColor)
 end
end

local function monitorPlayerAnimations()
    local animationPaths = {
        "fall.FallAnim",
        "climb.ClimbAnim", 
        "jump.JumpAnim",
        "run.RunAnim",
        "walk.WalkAnim",
        "idle.Animation1",
        "idle.Animation2"
    }
    
    spawn(function()
        while isScanning do
            for _, targetPlayer in pairs(Players:GetPlayers()) do
                if targetPlayer.Character then
                    local humanoid = targetPlayer.Character:FindFirstChild("Humanoid")
                    if humanoid then
                        local animate = targetPlayer.Character:FindFirstChild("Animate")
                        if animate then
                            for _, path in pairs(animationPaths) do
                                local pathParts = string.split(path, ".")
                                local current = animate
                                local animType = pathParts[1]
                                
                                for i, part in pairs(pathParts) do
                                    if current then
                                        current = current:FindFirstChild(part)
                                    end
                                end
                                
                                if current and current:IsA("Animation") then
                                    local animId = current.AnimationId
                                    if animId and animId ~= "" then
                                        local baseId = string.match(animId, "(%d+)")
                                        if baseId and not permanentlyDetectedAssets[baseId] then
                                            local assets = extractAssets(animId)
                                            for _, asset in pairs(assets) do
                                                local animName, animColor = getAnimationType(animId, animType)
                                                local assetData = {
                                                    url = asset,
                                                    propertyName = "AnimationId",
                                                    objectName = targetPlayer.Name .. "_" .. animType,
                                                    fullPath = "Players." .. targetPlayer.Name .. ".Character.Animate." .. path,
                                                    assetType = "Animation",
                                                    typeColor = animColor,
                                                    originalText = animId,
                                                    animationType = animName
                                                }
                                                addAsset(assetData)
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
            wait(1)
        end
    end)
end

local function createControlTool()
    for _,P in ipairs(player.Backpack:GetChildren()) do 
        if P.Name == "ClickTarget" then 
            P:Destroy() 
        end 
    end
    
    if player.Character then
        for _,P in ipairs(player.Character:GetChildren()) do 
            if P.Name == "ClickTarget" then 
                P:Destroy() 
            end 
        end
    end
    
    local GetTargetTool = Instance.new("Tool")
    GetTargetTool.Name = "ClickTarget"
    GetTargetTool.RequiresHandle = false
    GetTargetTool.TextureId = "rbxassetid://13769558274"
    GetTargetTool.ToolTip = "Choose Player for Animation Download"
    
    local function ActivateTool()
        local Hit = player:GetMouse().Target
        local Person = nil
        
        if Hit and Hit.Parent then
            if Hit.Parent:IsA("Model") then
                Person = Players:GetPlayerFromCharacter(Hit.Parent)
            elseif Hit.Parent:IsA("Accessory") then
                Person = Players:GetPlayerFromCharacter(Hit.Parent.Parent)
            end
            
            if Person and Person ~= player then
                local playerAnimations = {}
                
                if Person.Character then
                    local animate = Person.Character:FindFirstChild("Animate")
                    if animate then
                        local animationPaths = {
                            fall = "fall.FallAnim",
                            climb = "climb.ClimbAnim",
                            jump = "jump.JumpAnim",
                            run = "run.RunAnim", 
                            walk = "walk.WalkAnim",
                            idle1 = "idle.Animation1",
                            idle2 = "idle.Animation2"
                        }
                        
                        for animKey, path in pairs(animationPaths) do
                            local pathParts = string.split(path, ".")
                            local current = animate
                            
                            for _, part in pairs(pathParts) do
                                if current then
                                    current = current:FindFirstChild(part)
                                end
                            end
                            
                            if current and current:IsA("Animation") then
                                local animId = current.AnimationId
                                if animId and animId ~= "" then
                                    local baseId = string.match(animId, "(%d+)")
                                    if baseId then
                                        local animType = string.split(path, ".")[1]
                                        local animName, _ = getAnimationType(animId, animType)
                                        playerAnimations[animKey] = {
                                            id = baseId,
                                            name = animName,
                                            fullId = animId
                                        }
                                    end
                                end
                            end
                        end
                    end
                end
                
                if next(playerAnimations) then
                    showDownloadConfirmation(Person.Name, playerAnimations)
                else
                    showNotification("Not Found Player Animation" .. Person.Name, Color3.fromRGB(255, 150, 100))
                end
            elseif Person == player then
                showNotification("don't targting you", Color3.fromRGB(255, 100, 100))
            end
        end
    end
    
    GetTargetTool.Activated:Connect(function()
        ActivateTool()
    end)
    
    GetTargetTool.Parent = player.Backpack
end

local function toggleVisibility()
 if isVisible then
     local fadeOut = TweenService:Create(mainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quad), {Position = UDim2.new(0.5, -325, -1, 0)})
     local shadowOut = TweenService:Create(shadow, TweenInfo.new(0.4, Enum.EasingStyle.Quad), {Position = UDim2.new(0.5, -325, -1, 0)})
     fadeOut:Play()
     shadowOut:Play()
     isVisible = false
 else
     mainFrame.Position = UDim2.new(0.5, -325, -1, 0)
     shadow.Position = UDim2.new(0.5, -325, -1, 0)
     local fadeIn = TweenService:Create(mainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back), {Position = UDim2.new(0.5, -325, 0.5, -310)})
     local shadowIn = TweenService:Create(shadow, TweenInfo.new(0.4, Enum.EasingStyle.Back), {Position = UDim2.new(0.5, -325, 0.5, -310)})
     fadeIn:Play()
     shadowIn:Play()
     isVisible = true
 end
end

local function onGuiAdded(gui)
 if gui:IsA("ScreenGui") or gui:IsA("GuiBase") then
     if existingGUIs[gui] then
         return
     end
     
     spawn(function()
         wait(0.5)
         
         local function scanNewGui(obj)
             if not isScanning then
                 return
             end
             
             local assets = scanObjectForContent(obj)
             
             for _, asset in pairs(assets) do
                 addAsset(asset)
             end
             
             for _, child in pairs(obj:GetChildren()) do
                 if child then
                     scanNewGui(child)
                 end
             end
         end
         
         scanNewGui(gui)
         
         gui.DescendantAdded:Connect(function(descendant)
             if isScanning then
                 local assets = scanObjectForContent(descendant)
                 
                 for _, asset in pairs(assets) do
                     addAsset(asset)
                 end
             end
         end)
     end)
 end
end

local function registerExistingGUIs()
 for _, gui in pairs(playerGui:GetChildren()) do
     if gui:IsA("ScreenGui") then
         existingGUIs[gui] = true
     end
 end
end

spawn(function()
 statusLabel.Text = "Waiting 2 seconds before scanning..."
 statusLabel.TextColor3 = Color3.fromRGB(255, 255, 100)
 
 wait(2)
 
 isScanning = true
 statusLabel.Text = "Status: Active - Monitoring All Player Animations"
 statusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
 
 monitorPlayerAnimations()
 
 showNotification("FRONT EVILL Asset Detector Started!\nPress 'B' to hide/show\nAll Player Animation Detection: ON", Color3.fromRGB(100, 255, 100))
end)

registerExistingGUIs()
playerGui.ChildAdded:Connect(onGuiAdded)

if CoreGui then
 for _, gui in pairs(CoreGui:GetChildren()) do
     if gui:IsA("ScreenGui") then
         existingGUIs[gui] = true
     end
 end
 CoreGui.ChildAdded:Connect(onGuiAdded)
end

clearButton.MouseButton1Click:Connect(clearAllAssets)
saveButton.MouseButton1Click:Connect(saveAllAssets)
deleteFileButton.MouseButton1Click:Connect(deleteAllFiles)
controlToolButton.MouseButton1Click:Connect(createControlTool)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
 if not gameProcessed and input.KeyCode == Enum.KeyCode.B then
     toggleVisibility()
 end
end)

local dragToggle = nil
local dragSpeed = 0.15
local dragStart = nil
local startPos = nil

local function updateInput(input)
 local delta = input.Position - dragStart
 local newPosition = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
 TweenService:Create(mainFrame, TweenInfo.new(dragSpeed), {Position = newPosition}):Play()
 TweenService:Create(shadow, TweenInfo.new(dragSpeed), {Position = newPosition}):Play()
end

titleBar.InputBegan:Connect(function(input)
 if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
     dragToggle = true
     dragStart = input.Position
     startPos = mainFrame.Position
     input.Changed:Connect(function()
         if input.UserInputState == Enum.UserInputState.End then
             dragToggle = false
         end
     end)
 end
end)

UserInputService.InputChanged:Connect(function(input)
 if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
     if dragToggle then
         updateInput(input)
     end
 end
end)

hideButton.MouseButton1Click:Connect(toggleVisibility)

closeButton.MouseButton1Click:Connect(function()
 local fadeOut = TweenService:Create(screenGui, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
     BackgroundTransparency = 1
 })
 fadeOut:Play()
 fadeOut.Completed:Wait()
 screenGui:Destroy()
end)

local function addButtonEffects(button)
 button.MouseEnter:Connect(function()
     TweenService:Create(button, TweenInfo.new(0.2), {Size = button.Size + UDim2.new(0, 2, 0, 2)}):Play()
 end)
 
 button.MouseLeave:Connect(function()
     TweenService:Create(button, TweenInfo.new(0.2), {Size = button.Size - UDim2.new(0, 2, 0, 2)}):Play()
 end)
end

addButtonEffects(hideButton)
addButtonEffects(closeButton)
addButtonEffects(clearButton)
addButtonEffects(saveButton)
addButtonEffects(deleteFileButton)
addButtonEffects(controlToolButton)
