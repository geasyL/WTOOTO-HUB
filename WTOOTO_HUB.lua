-- Roblox GUI Script - WTOOTO Full System (Final Version)
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

repeat wait() until LocalPlayer:FindFirstChild("PlayerGui")

local gui = Instance.new("ScreenGui")
gui.Name = "WTOOTO_GUI"
gui.IgnoreGuiInset = true
gui.ZIndexBehavior = Enum.ZIndexBehavior.Global
gui.ResetOnSpawn = false
gui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- Restore Button (เข้าเมนู)
local restoreBtn = Instance.new("TextButton")
restoreBtn.Size = UDim2.new(0, 60, 0, 60)
restoreBtn.Position = UDim2.new(0.5, -30, 1, -100)
restoreBtn.Text = ""
restoreBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
restoreBtn.BorderColor3 = Color3.fromRGB(255, 255, 255)
restoreBtn.BorderSizePixel = 3
restoreBtn.AutoButtonColor = false
restoreBtn.Visible = false
restoreBtn.Parent = gui

local icon = Instance.new("ImageLabel", restoreBtn)
icon.Size = UDim2.new(1, 0, 1, 0)
icon.BackgroundTransparency = 1
icon.Image = "rbxassetid://92134671694304"

local draggingBtn = false
local dragStart, startPos
restoreBtn.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch then
		draggingBtn = true
		dragStart = input.Position
		startPos = restoreBtn.Position
	end
end)
restoreBtn.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch then draggingBtn = false end
end)
UIS.InputChanged:Connect(function(input)
	if draggingBtn and input.UserInputType == Enum.UserInputType.Touch then
		local delta = input.Position - dragStart
		restoreBtn.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)

-- Frame Menu
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 450, 0, 300)
frame.Position = UDim2.new(0.5, -225, 0.5, -150)
frame.BackgroundColor3 = Color3.fromRGB(0, 50, 0)
frame.BorderColor3 = Color3.fromRGB(144, 255, 136)
frame.BorderSizePixel = 4
frame.Visible = true
frame.Active = true
frame.Draggable = true
frame.Parent = gui

restoreBtn.MouseButton1Click:Connect(function()
	frame.Visible = true
	restoreBtn.Visible = false
end)

-- Title and Close
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 25)
title.Text = "WTOOTO"
title.Font = Enum.Font.SourceSansBold
title.TextSize = 18
title.TextColor3 = Color3.new(1, 1, 1)
title.BackgroundColor3 = Color3.fromRGB(0, 70, 0)
title.Parent = frame

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 30, 0, 25)
closeBtn.Position = UDim2.new(1, -35, 0, 0)
closeBtn.Text = "X"
closeBtn.Font = Enum.Font.SourceSansBold
closeBtn.TextSize = 18
closeBtn.TextColor3 = Color3.new(1, 1, 1)
closeBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
closeBtn.Parent = frame
closeBtn.MouseButton1Click:Connect(function()
	frame.Visible = false
	restoreBtn.Visible = true
end)

-- Tab UI
local tabFrame = Instance.new("Frame")
tabFrame.Size = UDim2.new(0, 100, 1, -25)
tabFrame.Position = UDim2.new(0, 0, 0, 25)
tabFrame.BackgroundColor3 = Color3.fromRGB(40, 80, 40)
tabFrame.Parent = frame

local contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(1, -100, 1, -25)
contentFrame.Position = UDim2.new(0, 100, 0, 25)
contentFrame.BackgroundColor3 = Color3.fromRGB(50, 100, 50)
contentFrame.Parent = frame

local tabs = {}
local function switchTab(name)
	for tabName, data in pairs(tabs) do
		data.Content.Visible = (tabName == name)
	end
end

local function createTab(name, order)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1, 0, 0, 30)
	btn.Position = UDim2.new(0, 0, 0, 30 * (order - 1))
	btn.Text = name
	btn.Font = Enum.Font.SourceSans
	btn.TextSize = 16
	btn.BackgroundColor3 = Color3.fromRGB(60, 120, 60)
	btn.TextColor3 = Color3.new(1, 1, 1)
	btn.Parent = tabFrame

	local content = Instance.new("Frame")
	content.Size = UDim2.new(1, 0, 1, 0)
	content.BackgroundTransparency = 1
	content.Visible = false
	content.Parent = contentFrame

	btn.MouseButton1Click:Connect(function()
		switchTab(name)
	end)

	tabs[name] = { Button = btn, Content = content }
end

createTab("ESP and Aimbot", 1)
tabs["ESP and Aimbot"].Content.Visible = true
createTab("Coming Soon 1", 2)
createTab("Coming Soon 2", 3)
createTab("Coming Soon 3", 4)

-- Toggle System
local function createToggle(parent, labelText, posY, callback)
	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(0, 150, 0, 30)
	label.Position = UDim2.new(0, 10, 0, posY)
	label.Text = labelText
	label.Font = Enum.Font.SourceSansBold
	label.TextSize = 16
	label.TextColor3 = Color3.new(1, 1, 1)
	label.BackgroundTransparency = 1
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Parent = parent

	local toggleBtn = Instance.new("TextButton")
	toggleBtn.Size = UDim2.new(0, 50, 0, 25)
	toggleBtn.Position = UDim2.new(0, 170, 0, posY + 2)
	toggleBtn.BorderColor3 = Color3.fromRGB(255, 255, 255)
	toggleBtn.BorderSizePixel = 2
	toggleBtn.Text = ""
	toggleBtn.AutoButtonColor = false
	toggleBtn.Parent = parent

	local circle = Instance.new("Frame")
	circle.Size = UDim2.new(0, 20, 0, 20)
	circle.Position = UDim2.new(0, 3, 0, 2)
	circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	circle.BorderSizePixel = 0
	circle.Parent = toggleBtn

	local enabled = false
	local function updateColor()
		toggleBtn.BackgroundColor3 = enabled and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
	end

	updateColor()
	toggleBtn.MouseButton1Click:Connect(function()
		enabled = not enabled
		circle:TweenPosition(UDim2.new(0, enabled and 27 or 3, 0, 2), "Out", "Quad", 0.2, true)
		updateColor()
		callback(enabled)
	end)
end

-- ESP System
local ESPEnabled = false
local function applyESP(player)
	if player.Character and not player.Character:FindFirstChild("Highlight") then
		local highlight = Instance.new("Highlight")
		highlight.Name = "Highlight"
		highlight.FillColor = Color3.fromRGB(0, 255, 0)
		highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
		highlight.FillTransparency = 0.5
		highlight.OutlineTransparency = 0
		highlight.Adornee = player.Character
		highlight.Parent = player.Character
	end
end

local function removeESP(player)
	if player.Character and player.Character:FindFirstChild("Highlight") then
		player.Character.Highlight:Destroy()
	end
end

createToggle(tabs["ESP and Aimbot"].Content, "ESP", 10, function(enabled)
	ESPEnabled = enabled
	for _, player in pairs(Players:GetPlayers()) do
		if player ~= LocalPlayer then
			if ESPEnabled then
				applyESP(player)
			else
				removeESP(player)
			end
		end
	end
end)

Players.PlayerAdded:Connect(function(p)
	p.CharacterAdded:Connect(function()
		wait(1)
		if ESPEnabled then applyESP(p) end
	end)
end)

-- Aimbot System
local AimbotEnabled = false
createToggle(tabs["ESP and Aimbot"].Content, "Aimbot", 50, function(enabled)
	AimbotEnabled = enabled
end)

RunService.RenderStepped:Connect(function()
	if AimbotEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Head") then
		local closest, dist = nil, math.huge
		local myPos = LocalPlayer.Character.Head.Position
		for _, player in ipairs(Players:GetPlayers()) do
			if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Head") then
				local targetPos = player.Character.Head.Position
				local d = (myPos - targetPos).Magnitude
				if d < dist then
					dist = d
					closest = player
				end
			end
		end
		if closest and closest.Character and closest.Character:FindFirstChild("Head") then
			local cam = workspace.CurrentCamera
			cam.CFrame = CFrame.new(cam.CFrame.Position, closest.Character.Head.Position)
		end
	end
end)
