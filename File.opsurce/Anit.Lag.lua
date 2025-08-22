-- Enhanced Anti-Lag Performance Booster
-- Auto-enabled with Discord integration
-- FRONT EVILL needs to eat people's brains to get deadly ideas for LAG.

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")


local antiLagEnabled = false
local originalSettings = {}
local descendantConnection = nil

local function notify(title, text)
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = title,
            Text = text,
            Duration = 4
        })
    end)
end
local function copyToClipboard(text)
    local success = false
    
    pcall(function()
        if setclipboard then
            setclipboard(text)
            success = true
        elseif toclipboard then
            toclipboard(text)
            success = true
        elseif writeclipboard then
            writeclipboard(text)
            success = true
        end
    end)
    
    return success
end
local function isPlayerObject(obj)
    local ancestor = obj
    while ancestor do
        if ancestor.Parent == workspace then
            for _, player in pairs(Players:GetPlayers()) do
                if player.Character and ancestor == player.Character then
                    return true
                end
            end
            break
        end
        ancestor = ancestor.Parent
    end
    return false
end
local function optimizeObject(obj)
    if isPlayerObject(obj) then
        return
    end
    pcall(function()
        if obj:IsA("Texture") or obj:IsA("Decal") then
            if not originalSettings[obj] then
                originalSettings[obj] = {
                    Texture = obj.Texture,
                    Transparency = obj.Transparency
                }
                obj.Texture = ""
                obj.Transparency = 1
            end
            
        elseif obj:IsA("SurfaceGui") then
            if not originalSettings[obj] then
                originalSettings[obj] = {Enabled = obj.Enabled}
                obj.Enabled = false
            end
            
        elseif obj:IsA("ParticleEmitter") then
            if not originalSettings[obj] then
                originalSettings[obj] = {Enabled = obj.Enabled}
                obj.Enabled = false
            end
            
        elseif obj:IsA("Beam") or obj:IsA("Trail") then
            if not originalSettings[obj] then
                originalSettings[obj] = {Enabled = obj.Enabled}
                obj.Enabled = false
            end
            
        elseif obj:IsA("Fire") or obj:IsA("Smoke") or obj:IsA("Sparkles") then
            if not originalSettings[obj] then
                originalSettings[obj] = {Enabled = obj.Enabled}
                obj.Enabled = false
            end
            
        elseif obj:IsA("MeshPart") or obj:IsA("Part") then
            if obj.Material ~= Enum.Material.Plastic then
                if not originalSettings[obj] then
                    originalSettings[obj] = {Material = obj.Material}
                    obj.Material = Enum.Material.Plastic
                end
            end
            
            local mesh = obj:FindFirstChildOfClass("SpecialMesh")
            if mesh and mesh.TextureId ~= "" then
                if not originalSettings[mesh] then
                    originalSettings[mesh] = {TextureId = mesh.TextureId}
                    mesh.TextureId = ""
                end
            end
            
        elseif obj:IsA("Sound") then
            if not originalSettings[obj] then
                originalSettings[obj] = {Volume = obj.Volume}
                obj.Volume = obj.Volume * 0.2
            end
        end
    end)
end
local function restoreObject(obj, settings)
    if not obj or not obj.Parent then return end
    
    pcall(function()
        if obj:IsA("Texture") or obj:IsA("Decal") then
            obj.Texture = settings.Texture or ""
            obj.Transparency = settings.Transparency or 0
            
        elseif obj:IsA("SurfaceGui") or obj:IsA("ParticleEmitter") or 
               obj:IsA("Beam") or obj:IsA("Trail") or obj:IsA("Fire") or 
               obj:IsA("Smoke") or obj:IsA("Sparkles") then
            obj.Enabled = settings.Enabled
            
        elseif obj:IsA("MeshPart") or obj:IsA("Part") then
            if settings.Material then
                obj.Material = settings.Material
            end
            
        elseif obj:IsA("SpecialMesh") then
            obj.TextureId = settings.TextureId or ""
            
        elseif obj:IsA("Sound") then
            obj.Volume = settings.Volume or 0.5
        end
    end)
end
local function optimizeLighting()
    originalSettings["Lighting"] = {
        GlobalShadows = Lighting.GlobalShadows,
        FogEnd = Lighting.FogEnd,
        FogStart = Lighting.FogStart,
        Brightness = Lighting.Brightness,
        EnvironmentDiffuseScale = Lighting.EnvironmentDiffuseScale,
        EnvironmentSpecularScale = Lighting.EnvironmentSpecularScale,
        ShadowSoftness = Lighting.ShadowSoftness
    }
    
    Lighting.GlobalShadows = false
    Lighting.FogEnd = 9e9
    Lighting.FogStart = 0
    Lighting.Brightness = 2
    Lighting.EnvironmentDiffuseScale = 0.1
    Lighting.EnvironmentSpecularScale = 0.1
    Lighting.ShadowSoftness = 0
    
    for _, effect in pairs(Lighting:GetChildren()) do
        if effect:IsA("BloomEffect") or effect:IsA("BlurEffect") or 
           effect:IsA("ColorCorrectionEffect") or effect:IsA("SunRaysEffect") or
           effect:IsA("DepthOfFieldEffect") or effect:IsA("AtmosphereEffect") then
            if not originalSettings[effect] then
                originalSettings[effect] = {Enabled = effect.Enabled}
                effect.Enabled = false
            end
        end
    end
end
local function restoreLighting()
    if originalSettings["Lighting"] then
        local settings = originalSettings["Lighting"]
        Lighting.GlobalShadows = settings.GlobalShadows
        Lighting.FogEnd = settings.FogEnd
        Lighting.FogStart = settings.FogStart
        Lighting.Brightness = settings.Brightness
        Lighting.EnvironmentDiffuseScale = settings.EnvironmentDiffuseScale
        Lighting.EnvironmentSpecularScale = settings.EnvironmentSpecularScale
        Lighting.ShadowSoftness = settings.ShadowSoftness
        originalSettings["Lighting"] = nil
    end
    
    for _, effect in pairs(Lighting:GetChildren()) do
        if originalSettings[effect] then
            effect.Enabled = originalSettings[effect].Enabled
            originalSettings[effect] = nil
        end
    end
end
-- Camera Optimization
local function optimizeCamera()
    if workspace.CurrentCamera then
        originalSettings["Camera"] = {
            FieldOfView = workspace.CurrentCamera.FieldOfView
        }
        workspace.CurrentCamera.FieldOfView = 90
    end
end
-- Camera Restoration
local function restoreCamera()
    if originalSettings["Camera"] and workspace.CurrentCamera then
        workspace.CurrentCamera.FieldOfView = originalSettings["Camera"].FieldOfView
        originalSettings["Camera"] = nil
    end
end

local function setAntiLag(state)
    antiLagEnabled = state
    if state then
        local objectCount = 0
        local function optimizeChunk(objects, startIndex, chunkSize)
            local endIndex = math.min(startIndex + chunkSize - 1, #objects)
            for i = startIndex, endIndex do
                optimizeObject(objects[i])
                objectCount = objectCount + 1
            end
            if endIndex < #objects then
                RunService.Heartbeat:Wait()
                optimizeChunk(objects, endIndex + 1, chunkSize)
            else
                optimizeLighting()
                optimizeCamera()
                descendantConnection = workspace.DescendantAdded:Connect(function(obj)
                    if antiLagEnabled then
                        task.wait(0.1)
                        optimizeObject(obj)
                    end
                end)
            end
        end
        local allObjects = workspace:GetDescendants()
        optimizeChunk(allObjects, 1, 150)
    else
        if descendantConnection then
            descendantConnection:Disconnect()
            descendantConnection = nil
        end
        local restoredCount = 0
        for obj, settings in pairs(originalSettings) do
            if typeof(obj) == "string" then
                if obj == "Lighting" then
                    restoreLighting()
                elseif obj == "Camera" then
                    restoreCamera()
                end
            else
                restoreObject(obj, settings)
                restoredCount = restoredCount + 1
            end
            
            if restoredCount % 100 == 0 then
                RunService.Heartbeat:Wait()
            end
        end
        originalSettings = {}
    end
end

-- Public API
_G.AntiLag = {
    Enable = function() setAntiLag(true) end,
    Disable = function() setAntiLag(false) end,
    Toggle = function() setAntiLag(not antiLagEnabled) end,
    IsEnabled = function() return antiLagEnabled end,
    GetStats = function() 
        local count = 0
        for _ in pairs(originalSettings) do count = count + 1 end
        return {
            OptimizedObjects = count,
            IsEnabled = antiLagEnabled
        }
    end
}
_G.AntiLag.Enable()

return _G.AntiLag
