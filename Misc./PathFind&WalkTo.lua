local shit = { toggle = true }
local CAS = game:GetService"ContextActionService"
local FREEZE_COMMAND = "Stunned"

local function nomove()
	CAS:BindActionAtPriority(FREEZE_COMMAND, function() return Enum.ContextActionResult.Sink end, false, Enum.ContextActionPriority.High.Value, Enum.KeyCode.W, Enum.KeyCode.S, Enum.KeyCode.A, Enum.KeyCode.D, Enum.KeyCode.Up, Enum.KeyCode.Space, Enum.KeyCode.Down)
end

function shit:Find(part)
	nomove()
	local PathfindingService = game:GetService"PathfindingService"
	local Players = game:GetService"Players"
	local player = Players.LocalPlayer
	local character = player.Character
	local humanoid = character:WaitForChild"Humanoid"
	local path = PathfindingService:CreatePath()
	path:ComputeAsync(character.PrimaryPart.Position, part.Position)
	local waypoints = path:GetWaypoints()
	spawn(function()
		pcall(function()
			while wait() and waypoints and shit.toggle and part:IsDescendantOf(workspace) do
				humanoid.Sit = false
				humanoid.Jump = true
			end
		end)
	end)
	pcall(function()
		for i, v in next, waypoints do
			if not shit.toggle or not part:IsDescendantOf(workspace) then break end
			humanoid:MoveTo(v.Position)
			humanoid.MoveToFinished:Wait()
		end
	end)
	waypoints = nil
	CAS:UnbindAction(FREEZE_COMMAND)
end

return shit
