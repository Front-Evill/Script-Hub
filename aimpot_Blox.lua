local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local Aiming = false

function AimLock()
	local target
	local lastMagnitude = math.huge -- Start with a high value for comparison
	for _, v in pairs(game.Players:GetPlayers()) do
		if v ~= player and v.Character and v.Character.PrimaryPart then
			local charPos = v.Character.PrimaryPart.Position
			local mousePos = mouse.Hit.p
			if (charPos - mousePos).Magnitude < lastMagnitude then
				lastMagnitude = (charPos - mousePos).Magnitude
				target = v
			end
		end
	end

	if target and target.Character and target.Character.PrimaryPart then
		local charPos = target.Character.PrimaryPart.Position
		local cam = workspace.CurrentCamera
		local pos = cam.CFrame.Position

		-- Set the camera CFrame to aim at the target
		workspace.CurrentCamera.CFrame = CFrame.new(pos, charPos) -- Update camera orientation
	end
end

local UserInputService = game:GetService("UserInputService")

-- Toggle aiming with "E"
UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if not gameProcessed and input.KeyCode == Enum.KeyCode.E then
		Aiming = not Aiming -- Toggle aiming state
	end
end)

-- Run AimLock while Aiming is true
game:GetService("RunService").RenderStepped:Connect(function()
	if Aiming then
		AimLock()
	end
end)
