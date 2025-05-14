local Settings = {
    FpsBoost = true,
    RemoveFog = true,
    DisableShadows = true,
    LowQualityGraphics = true,
    RemoveTextures = true,
    RemoveParticles = true
}

local Lighting = game:GetService("Lighting")
local Terrain = workspace:FindFirstChildOfClass("Terrain")
local RunService = game:GetService("RunService")

local function BoostFPS()
    settings().Rendering.QualityLevel = 1
    
    if Settings.DisableShadows then
        Lighting.GlobalShadows = false
        Lighting.ShadowSoftness = 0
    end
    
    if Settings.LowQualityGraphics then
        settings().Rendering.QualityLevel = 1
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("Part") or v:IsA("MeshPart") or v:IsA("Union") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then
                v.Material = Enum.Material.SmoothPlastic
                v.Reflectance = 0
            end
        end
    end
    
    if Settings.RemoveTextures then
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("Decal") or v:IsA("Texture") then
                v.Transparency = 1
            end
        end
    end
    
    if Settings.RemoveParticles then
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("ParticleEmitter") or v:IsA("Fire") or v:IsA("Sparkles") or v:IsA("Smoke") then
                v.Enabled = false
            end
        end
    end
end

local function RemoveFog()
    if Settings.RemoveFog then
        Lighting.FogStart = 0
        Lighting.FogEnd = 9999999
        Lighting.Atmosphere.Density = 0
        
        if Terrain then
            Terrain.Decoration = false
            Terrain.WaterWaveSize = 0
            Terrain.WaterWaveSpeed = 0
            Terrain.WaterReflectance = 0
            Terrain.WaterTransparency = 0
        end
    end
end

BoostFPS()
RemoveFog()

workspace.DescendantAdded:Connect(function(descendant)
    if Settings.LowQualityGraphics then
        if descendant:IsA("Union") or descendant:IsA("CornerWedgePart") or descendant:IsA("TrussPart") then
            descendant.Material = Enum.Material.SmoothPlastic
            descendant.Reflectance = 0
        end
    end
    
    if Settings.RemoveTextures then
        if descendant:IsA("Decal") or descendant:IsA("Texture") then
            descendant.Transparency = 1
        end
    end
    
    if Settings.RemoveParticles then
        if descendant:IsA("ParticleEmitter") or descendant:IsA("Fire") or descendant:IsA("Sparkles") or descendant:IsA("Smoke") then
            descendant.Enabled = false
        end
    end
end)
