local client, shit = game:GetService"Players".LocalPlayer, {
	WalkSpeed = false,
	WalkSpeedValue = nil,
	JumpPower = false,
	JumpPowerValue = nil
}
if hookfunction then
	local old
	old = hookfunction(getrawmetatable(game).__newindex, function(t, k, v)
		if t == client.Character.Humanoid and k == "WalkSpeed" then
			v = shit.WalkSpeedValue or client.Character.Humanoid.WalkSpeed
		elseif t == client.Character.Humanoid and k == "JumpPower" then
			v = shit.JumpPowerValue or client.Character.Humanoid.JumpPower
		end
		return old(t, k, v)
	end)
else
	client:GetPropertyChangedSignal"WalkSpeed":Connect(function()
		if shit.WalkSpeed then
			client.Character.Humanoid.WalkSpeed = shit.WalkSpeedValue or client.Character.Humanoid.WalkSpeed
		end
	end)
	client:GetPropertyChangedSignal"JumpPower":Connect(function()
		if shit.JumpPower then
			client.Character.Humanoid.JumpPower = shit.JumpPowerValue or client.Character.Humanoid.JumpPower
		end
	end)
end
return shit