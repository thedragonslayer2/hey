local shit = {}

function shit:GO(pos)
	local PathfindingService = game:GetService"PathfindingService"
	local Players = game:GetService"Players"
	local player = Players.LocalPlayer
	local character = player.Character
	local humanoid = character:WaitForChild"Humanoid"
	local path = PathfindingService:CreatePath()
	path:ComputeAsync(character.PrimaryPart.Position, pos)
	local waypoints = path:GetWaypoints()
	for i, v in next, waypoints do
		if v.Action == Enum.PathWaypointAction.Jump then humanoid:ChangeState(Enum.HumanoidStateType.Jumping) end
		humanoid:MoveTo(v.Position)
		humanoid.MoveToFinished:Wait()
	end
end

return shit
