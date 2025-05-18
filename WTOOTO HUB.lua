local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

repeat wait() until LocalPlayer:FindFirstChild("PlayerGui")

local gui = Instance.new("ScreenGui")
gui.Name = "WTOOTO_GUI"
gui.IgnoreGuiInset = true
gui.ZIndexBehavior = Enum.ZIndexBehavior.Global
gui.ResetOnSpawn = false
gui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 400, 0, 300)
frame.Position = UDim2.new(0.5, -200, 0.5, -150)
frame.BackgroundColor3 = Color3.fromRGB(20, 60, 20)
frame.BorderColor3 = Color3.fromRGB(120, 255, 120)
frame.BorderSizePixel = 3
frame.Active = true
frame.Draggable = false
frame.Parent = gui

local dragging = false
local dragStart, startPos

frame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = frame.Position
	end
end)

frame.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch then
		dragging = false
	end
end)

UIS.InputChanged:Connect(function(input)
	if dragging and input.UserInputType == Enum.UserInputType.Touch then
		local delta = input.Position - dragStart
		frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)

local restoreBtn = Instance.new("ImageButton")
restoreBtn.Size = UDim2.new(0, 50, 0, 50)
restoreBtn.Position = UDim2.new(0.5, -25, 1, -120)
restoreBtn.Image = "rbxassetid://92134671694304"
restoreBtn.BackgroundTransparency = 1
restoreBtn.Visible = false
restoreBtn.Parent = gui

local draggingBtn = false
restoreBtn.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch then
		draggingBtn = true
		dragStart = input.Position
		startPos = restoreBtn.Position
	end
end)

restoreBtn.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch then
		draggingBtn = false
	end
end)

UIS.InputChanged:Connect(function(input)
	if draggingBtn and input.UserInputType == Enum.UserInputType.Touch then
		local delta = input.Position - dragStart
		restoreBtn.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.Position = UDim2.new(0, 0, 0, 0)
title.Text = "WTOOTO"
title.Font = Enum.Font.SourceSansBold
title.TextSize = 20
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextStrokeTransparency = 0.5
title.BackgroundColor3 = Color3.fromRGB(40, 80, 40)
title.BorderSizePixel = 0
title.Parent = frame

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 0)
closeBtn.Text = "X"
closeBtn.Font = Enum.Font.SourceSansBold
closeBtn.TextSize = 20
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.BackgroundColor3 = Color3.fromRGB(90, 30, 30)
closeBtn.BorderSizePixel = 0
closeBtn.Parent = frame

closeBtn.MouseButton1Click:Connect(function()
	frame.Visible = false
	restoreBtn.Visible = true
end)

restoreBtn.MouseButton1Click:Connect(function()
	frame.Visible = true
	restoreBtn.Visible = false
end)

local tabList = Instance.new("Frame")
tabList.Size = UDim2.new(0, 120, 1, -30)
tabList.Position = UDim2.new(0, 0, 0, 30)
tabList.BackgroundColor3 = Color3.fromRGB(30, 80, 30)
tabList.BorderSizePixel = 0
tabList.Parent = frame

local function createTab(name, order, callback)
	local button = Instance.new("TextButton")
	button.Size = UDim2.new(1, 0, 0, 30)
	button.Position = UDim2.new(0, 0, 0, (order - 1) * 30)
	button.Text = name
	button.TextColor3 = Color3.fromRGB(255, 255, 255)
	button.BackgroundColor3 = Color3.fromRGB(40, 100, 40)
	button.Font = Enum.Font.SourceSansBold
	button.TextSize = 18
	button.Parent = tabList
	button.MouseButton1Click:Connect(callback)
	return button
end

local contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(1, -120, 1, -30)
contentFrame.Position = UDim2.new(0, 120, 0, 30)
contentFrame.BackgroundTransparency = 1
contentFrame.Parent = frame

local function clearContent()
	for _, v in pairs(contentFrame:GetChildren()) do
		if v:IsA("GuiObject") then
			v:Destroy()
		end
	end
end

local function createToggle(text, default, parent, callback)
	local toggleFrame = Instance.new("Frame")
	toggleFrame.Size = UDim2.new(1, -20, 0, 40)
	toggleFrame.Position = UDim2.new(0, 0, 0, #parent:GetChildren() * 45)
	toggleFrame.BackgroundTransparency = 1
	toggleFrame.Parent = parent

	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(0.7, 0, 1, 0)
	label.Position = UDim2.new(0, 10, 0, 0)
	label.Text = text
	label.Font = Enum.Font.SourceSans
	label.TextSize = 18
	label.TextColor3 = Color3.fromRGB(255, 255, 255)
	label.BackgroundTransparency = 1
	label.Parent = toggleFrame

	local toggle = Instance.new("Frame")
	toggle.Size = UDim2.new(0, 60, 0, 24)
	toggle.Position = UDim2.new(1, -70, 0.5, -12)
	toggle.BackgroundColor3 = Color3.fromRGB(60, 100, 60)
	toggle.BorderSizePixel = 0
	toggle.Parent = toggleFrame

	local circle = Instance.new("Frame")
	circle.Size = UDim2.new(0, 20, 0, 20)
	circle.Position = UDim2.new(default and 1 or 0, default and -22 or 2, 0.5, -10)
	circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	circle.BorderSizePixel = 0
	circle.ZIndex = 2
	circle.Parent = toggle

	local state = default

	toggle.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
			state = not state
			TweenService:Create(circle, TweenInfo.new(0.25), {
				Position = UDim2.new(state and 1 or 0, state and -22 or 2, 0.5, -10)
			}):Play()
			callback(state)
		end
	end)
end

local aimbotEnabled = false
local espEnabled = false

local function updateESP()
	for _, player in pairs(Players:GetPlayers()) do
		if player ~= LocalPlayer and player.Character then
			local highlight = player.Character:FindFirstChild("Highlight")
			if espEnabled and not highlight then
				highlight = Instance.new("Highlight")
				highlight.FillColor = Color3.fromRGB(0, 255, 0)
				highlight.OutlineColor = Color3.new(1, 1, 1)
				highlight.Parent = player.Character
			elseif not espEnabled and highlight then
				highlight:Destroy()
			end
		end
	end
end

RunService.RenderStepped:Connect(function()
	if aimbotEnabled then
		local closestPlayer = nil
		local shortestDistance = math.huge
		for _, player in pairs(Players:GetPlayers()) do
			if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Head") then
				local screenPos, onScreen = Camera:WorldToViewportPoint(player.Character.Head.Position)
				if onScreen then
					local dist = (Vector2.new(screenPos.X, screenPos.Y) - UIS:GetMouseLocation()).Magnitude
					if dist < shortestDistance then
						shortestDistance = dist
						closestPlayer = player
					end
				end
			end
		end
		if closestPlayer and closestPlayer.Character and closestPlayer.Character:FindFirstChild("Head") then
			Camera.CFrame = CFrame.new(Camera.CFrame.Position, closestPlayer.Character.Head.Position)
		end
	end
end)

createTab("ESP & Aimbot", 1, function()
	clearContent()
	createToggle("Highlight (ESP)", false, contentFrame, function(state)
		espEnabled = state
		updateESP()
	end)
	wait(0.1)
	createToggle("Aimbot", false, contentFrame, function(state)
		aimbotEnabled = state
	end)
end)

for i = 2, 5 do
	createTab("Tab " .. i, i, function()
		clearContent()
		local label = Instance.new("TextLabel")
		label.Size = UDim2.new(1, 0, 1, 0)
		label.Position = UDim2.new(0, 0, 0, 0)
		label.Text = "Coming Soon..."
		label.Font = Enum.Font.SourceSansBold
		label.TextSize = 28
		label.TextColor3 = Color3.new(1, 1, 1)
		label.BackgroundTransparency = 1
		label.Parent = contentFrame
	end)
end
