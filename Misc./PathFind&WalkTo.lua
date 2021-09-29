local shit = { toggle = true }

function shit:Find(pos)
	local PathfindingService = game:GetService"PathfindingService"
	local Players = game:GetService"Players"
	local player = Players.LocalPlayer
	local character = player.Character
	local humanoid = character:WaitForChild"Humanoid"
	local path = PathfindingService:CreatePath()
	path:ComputeAsync(character.PrimaryPart.Position, pos)
	local waypoints = path:GetWaypoints()
	spawn(function()
		while wait() and waypoints and shit.toggle do
			humanoid.Sit = false
			humanoid.Jump = true
		end
	end)
	pcall(function()
		for i, v in next, waypoints do
			if not shit.toggle then break end
			humanoid:MoveTo(v.Position)
			humanoid.MoveToFinished:Wait()
		end
	end)
	waypoints = nil
end

return shit
