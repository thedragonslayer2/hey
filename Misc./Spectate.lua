if not IrisNotificationMrJack then
	loadstring(game:HttpGet"https://raw.githubusercontent.com/thedragonslayer2/hey/main/Misc./iris%20notification%20function")()
elseif IrisNotificationUserMrJack then IrisNotificationUserMrJack.ClearAllNotifications() end
local bruh = { CurrentPlayerIndex = 1, CurrentPlayer = nil }

local function ChangeCameraSubject(Player)
	if Player then
		local Humanoid = Player.Character:FindFirstChildOfClass"Humanoid"
		if Player.Character and Humanoid then workspace.CurrentCamera.CameraSubject = Humanoid end
		bruh.CurrentPlayer = Player
	end
end

game:GetService"RunService".Heartbeat:Connect(function()
	local PlayersChildren = game:GetService"Players":GetChildren()
	if bruh.CurrentPlayerIndex <= 1 then
		workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
		bruh.CurrentPlayer = game:GetService"Players".LocalPlayer
		ChangeCameraSubject(game:GetService"Players".LocalPlayer)
	elseif bruh.CurrentPlayerIndex >= 2 and PlayersChildren[bruh.CurrentPlayerIndex] then
		ChangeCameraSubject(PlayersChildren[bruh.CurrentPlayerIndex])
	else
		bruh.CurrentPlayerIndex = 1
		bruh.CurrentPlayer = game:GetService"Players".LocalPlayer
	end
end)

function bruh:next()
	local NewIndex = bruh.CurrentPlayerIndex + 1
	if NewIndex > #game:GetService"Players":GetChildren() then bruh.CurrentPlayerIndex = 1
	else bruh.CurrentPlayerIndex = NewIndex end
end

function bruh:prev()
	local NewIndex = bruh.CurrentPlayerIndex - 1
	if NewIndex <= 0 then
		bruh.CurrentPlayerIndex = #game:GetService"Players":GetChildren()
	else bruh.CurrentPlayerIndex = NewIndex end
end

function bruh:self()
	bruh.CurrentPlayer = game:GetService"Players".LocalPlayer
	bruh.CurrentPlayerIndex = 1
	ChangeCameraSubject(game:GetService"Players".LocalPlayer)
end

function bruh:finplayer(target)
	if target ~= "" then
		local yeahidk = tostring(target)
		for i, v in pairs(game:GetService"Players":GetChildren()) do
			if v.DisplayName:sub(1, #yeahidk):lower() == yeahidk:lower() or v.Name:sub(1, #yeahidk):lower() == yeahidk:lower() then
				yeahidk = v
				bruh.CurrentPlayerIndex = i
				IrisNotificationMrJack(1, "Spectating", "DisplayName: " .. v.DisplayName, 1)
				return
			end
		end
	end
end

return bruh
