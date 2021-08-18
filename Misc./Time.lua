local shit = { values = "Off", "Day", "Night" }
game:GetService"RunService".RenderStepped:Connect(function()
	if game:GetService"Lighting" and game:GetService"Lighting".ClockTime then
		if shit.Night == true then game:GetService"Lighting".ClockTime = 3
		elseif shit.Day == true then game:GetService"Lighting".ClockTime = 14 end
	end
end)

function shit:Change(value)
	if value == "Off" then
		shit.Night = false
		shit.Day = false
	elseif value == "Day" then
		shit.Night = false
		shit.Day = true
	elseif value == "Night" then
		shit.Night = true
		shit.Day = false
	end
end

return shit
