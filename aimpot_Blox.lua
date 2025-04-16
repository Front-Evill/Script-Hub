Get App
Log In

Expand user menu
Skip to NavigationSkip to Right Sidebar

Back
r/robloxhackers icon
Go to robloxhackers
r/robloxhackers
•
6 mo. ago
Failed_cocacola
Profile Badge for the Achievement Top 1% Poster Top 1% Poster

[ Works for any Exploit ] Aim-Lock Script
emoji:release: RELEASE

0:23 / 0:48





Upvote
36

Downvote

46
Go to comments


Share
Share

Add a comment
Sort by:

Top (Default)

Search Comments
Expand comment search
Comments Section
u/Failed_cocacola avatar
Failed_cocacola
MOD
•
6mo ago
•
Stickied comment
•
Edited 6mo ago
Profile Badge for the Achievement Top 1% Poster Top 1% Poster
While i took the src from the Roblox Studio forums, did some fixes since the aimlock was choppy + the binds were broken, this one ended up being real smooth ( YOU NEED TO PRESS E TO LOCK )

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
