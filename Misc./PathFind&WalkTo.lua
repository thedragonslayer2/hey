local shit = {}

function shit:GO(pos)
	local PathfindingService = game:GetService"PathfindingService"
	local Players = game:GetService"Players"
	local path = PathfindingService:CreatePath()
	local player = Players.LocalPlayer
	local character = player.Character
	local humanoid = character:WaitForChild"Humanoid"
	local waypoints
	local nextWaypointIndex
	local reachedConnection
	local blockedConnection

	local function followPath(destination)
		local success, errorMessage = pcall(function()
			path:ComputeAsync(character.PrimaryPart.Position, destination)
		end)
		if success and path.Status == Enum.PathStatus.Success then
			waypoints = path:GetWaypoints()
			blockedConnection = path.Blocked:Connect(function(blockedWaypointIndex)
				if blockedWaypointIndex >= nextWaypointIndex then
					blockedConnection:Disconnect()
					followPath(destination)
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
			if waypoints[nextWaypointIndex].Action == Enum.PathWaypointAction.Jump then humanoid:ChangeState(Enum.HumanoidStateType.Jumping) end
			humanoid:MoveTo(waypoints[nextWaypointIndex].Position)
		else warn("Path not computed!", errorMessage) end
	end

	followPath(pos)
end

return shit
