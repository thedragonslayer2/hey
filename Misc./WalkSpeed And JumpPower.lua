local client, shit = game:GetService"Players".LocalPlayer, { WalkSpeedValue = nil, JumpPowerValue = nil }
if hookfunction then
	local old
	old = hookfunction(getrawmetatable(game).__newindex, function(t, k, v)
		if k == "WalkSpeed" and t == client.Character.Humanoid then
			v = shit.WalkSpeedValue or client.Character.Humanoid.WalkSpeed
		elseif k == "JumpPower" and t == client.Character.Humanoid then
			v = shit.JumpPowerValue or client.Character.Humanoid.JumpPower
		end
		return old(t, k, v)
	end)
else
	client:GetPropertyChangedSignal"WalkSpeed":Connect(function()
		client.Character.Humanoid.WalkSpeed = shit.WalkSpeedValue or client.Character.Humanoid.WalkSpeed
	end)
	client:GetPropertyChangedSignal"JumpPower":Connect(function()
		client.Character.Humanoid.JumpPower = shit.JumpPowerValue or client.Character.Humanoid.JumpPower
	end)
end

function shit:WS(Value)
	shit.WalkSpeedValue = Value
	pcall(function() client.Character.Humanoid.WalkSpeed = Value end)
end

function shit:JP(Value)
	shit.JumpPowerValue = Value
	pcall(function() client.Character.Humanoid.JumpPower = Value end)
end

return shit
