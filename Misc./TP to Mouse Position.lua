local shit = { Bind = Enum.KeyCode.LeftAlt }
local Imput = game:GetService"UserInputService"
local Plr = game.Players.LocalPlayer
local Mouse = Plr:GetMouse()

function To(position)
	local Chr = Plr.Character
	if Chr ~= nil then Chr:MoveTo(position) end
end

Imput.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 and Imput:IsKeyDown(shit.Bind) then To(Mouse.Hit.p) end
end)
return shit
