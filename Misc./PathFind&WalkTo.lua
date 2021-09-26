local shit = {}

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
		while wait() and waypoints do
			humanoid.Sit = false
			humanoid.Jump = true
		end
	end)
	for i, v in next, waypoints do
		humanoid:MoveTo(v.Position)
		humanoid.MoveToFinished:Wait()
	end
	waypoints = nil
end

return shit
