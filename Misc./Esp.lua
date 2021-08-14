local shit = { enabled = false, Color = Color3.new(1, 0, 0) }

local function round(n) return math.floor(tonumber(n) + 0.5) end

function UpdatePlayerChams()
	for i, v in next, game:GetService"Players":GetChildren() do
		pcall(function()
			if game:GetService"Players".LocalPlayer ~= v then
				if v.Character then
					if v.Character:FindFirstChild"Head" and not v.Character.Head:FindFirstChild"NameEsp" and shit.enabled then
						local bill = Instance.new("BillboardGui", v.Character.Head)
						bill.Name = "NameEsp"
						bill.Size = UDim2.new(1, 200, 1, 30)
						bill.Adornee = v.Character.Head
						bill.AlwaysOnTop = true
						local name = Instance.new("TextLabel", bill)
						name.TextWrapped = true
						name.Font = "ArialBold"
						name.Size = UDim2.new(1, 0, 1, 0)
						name.TextSize = 12
						name.TextTransparency = 0.2
						name.TextStrokeTransparency = 0.5
						name.TextYAlignment = "Top"
						name.TextColor3 = shit.Color
						name.BackgroundTransparency = 1
						if v.DisplayName == v.Name then
							name.Text = v.Name .. " " .. round((game:GetService"Players".LocalPlayer.Character.Head.Position - v.Character.Head.Position).Magnitude / 3) .. "m"
						else
							name.Text = v.DisplayName .. "\n" .. v.Name .. " " .. round((game:GetService"Players".LocalPlayer.Character.Head.Position - v.Character.Head.Position).Magnitude / 3) .. "m"
						end
					elseif shit.enabled and v.Character.Head:FindFirstChild"NameEsp" then
						v.Character.Head.NameEsp.TextLabel.Visible = true
						v.Character.Head.NameEsp.TextLabel.TextColor3 = shit.Color
						v.Character.Humanoid.NameDisplayDistance = 0
						if v.DisplayName == v.Name then
							v.Character.Head.NameEsp.TextLabel.Text = v.Name .. " " .. round((game:GetService"Players".LocalPlayer.Character.Head.Position - v.Character.Head.Position).Magnitude / 3) .. "m"
						else
							v.Character.Head.NameEsp.TextLabel.Text = v.DisplayName .. "\n" .. v.Name .. " " .. round((game:GetService"Players".LocalPlayer.Character.Head.Position - v.Character.Head.Position).Magnitude / 3) .. "m"
						end
					elseif not shit.enabled and v.Character.Head:FindFirstChild"NameEsp" then v.Character.Head.NameEsp.TextLabel.Visible = false end
				end
			end
		end)
	end
end

spawn(function() while wait() do pcall(UpdatePlayerChams) end end)
return shit
