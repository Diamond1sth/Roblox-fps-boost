-- EXTREME FPS BOOSTER (OWNER / ADMIN)
-- Kills 90–100% of VFX for mobile performance

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local Terrain = workspace:FindFirstChildOfClass("Terrain")

-- Lighting nuke
Lighting.GlobalShadows = false
Lighting.FogEnd = 1e9
Lighting.Brightness = 1
Lighting.EnvironmentDiffuseScale = 0
Lighting.EnvironmentSpecularScale = 0

for _,v in ipairs(Lighting:GetChildren()) do
	if v:IsA("PostEffect") then
		v.Enabled = false
	end
end

-- Water & terrain
if Terrain then
	Terrain.WaterWaveSize = 0
	Terrain.WaterWaveSpeed = 0
	Terrain.WaterReflectance = 0
	Terrain.WaterTransparency = 1
end

-- Strip function
local function strip(obj)
	if obj:IsA("ParticleEmitter")
	or obj:IsA("Trail")
	or obj:IsA("Beam")
	or obj:IsA("Fire")
	or obj:IsA("Smoke")
	or obj:IsA("Sparkles") then
		obj.Enabled = false
	end

	if obj:IsA("BillboardGui")
	or obj:IsA("SurfaceGui") then
		obj:Destroy()
	end

	if obj:IsA("Decal") or obj:IsA("Texture") then
		obj.Transparency = 1
	end

	if obj:IsA("BasePart") then
		obj.Material = Enum.Material.Plastic
		obj.Reflectance = 0
		obj.CastShadow = false
	end
end

-- Initial cleanup
for _,obj in ipairs(workspace:GetDescendants()) do
	pcall(strip, obj)
end

-- Block re-added effects
workspace.DescendantAdded:Connect(function(obj)
	task.wait()
	pcall(strip, obj)
end)

-- Characters
local function optimizeChar(char)
	for _,obj in ipairs(char:GetDescendants()) do
		pcall(strip, obj)
	end
end

for _,plr in ipairs(Players:GetPlayers()) do
	if plr.Character then
		optimizeChar(plr.Character)
	end
	plr.CharacterAdded:Connect(optimizeChar)
end

pcall(function()
	setfpscap(60)
end)

print("🔥 EXTREME FPS MODE ENABLED")
