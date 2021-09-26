local shit = {}
local PathfindingService = game:GetService"PathfindingService"
local Players = game:GetService"Players"
local path = PathfindingService:CreatePath()
local player = Players.LocalPlayer
local character = player.Character
local humanoid = character:WaitForChild"Humanoid"
local TEST_DESTINATION = Vector3.new(100, 0, 100)
local waypoints
local nextWaypointIndex
local reachedConnection
local blockedConnection

function shit:followPath(destination)
	local success, errorMessage = pcall(function()
		path:ComputeAsync(character.PrimaryPart.Position, destination)
	end)
	if success and path.Status == Enum.PathStatus.Success then
		waypoints = path:GetWaypoints()
		blockedConnection = path.Blocked:Connect(function(blockedWaypointIndex)
			if blockedWaypointIndex >= nextWaypointIndex then
				blockedConnection:Disconnect()
				shit:followPath(destination)
			end
		end)
		if not reachedConnection then
			reachedConnection = humanoid.MoveToFinished:Connect(function(reached)
				if reached and nextWaypointIndex < #waypoints then
					nextWaypointIndex = nextWaypointIndex + 1
					humanoid:MoveTo(waypoints[nextWaypointIndex].Position)
				else
					reachedConnection:Disconnect()
					blockedConnection:Disconnect()
				end
			end)
		end
		nextWaypointIndex = 2
		humanoid:MoveTo(waypoints[nextWaypointIndex].Position)
	else warn("Path not computed!", errorMessage) end
end

return shit
