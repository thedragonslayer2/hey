local shit = { toggle = true }

function shit:Find(part)
	local PathfindingService = game:GetService"PathfindingService"
	local Players = game:GetService"Players"
	local player = Players.LocalPlayer
	local character = player.Character
	local humanoid = character:WaitForChild"Humanoid"
	local path = PathfindingService:CreatePath()
	path:ComputeAsync(character.PrimaryPart.Position, part.Position)
	local waypoints = path:GetWaypoints()
	spawn(function()
		while wait() and waypoints and shit.toggle and part:IsDescendantOf(workspace) do
			humanoid.Sit = false
			humanoid.Jump = true
		end
	end)
	pcall(function()
		for i, v in next, waypoints do
			if not shit.toggle or not part:IsDescendantOf(workspace) then break end
			pcall(function()
				humanoid:MoveTo(v.Position)
				humanoid.MoveToFinished:Wait()
			end)
		end
	end)
	waypoints = nil
end

return shit
