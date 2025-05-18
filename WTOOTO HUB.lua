-- Roblox GUI Menu Script
local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local uis = game:GetService("UserInputService")

-- Helper
local function create(name, class, parent, props)
	local obj = Instance.new(class)
	obj.Name = name
	for k, v in pairs(props or {}) do obj[k] = v end
	obj.Parent = parent
	return obj
end

-- GUI
local gui = create("WTOOTO_GUI", "ScreenGui", player:WaitForChild("PlayerGui"), {ResetOnSpawn = false})

-- Menu Frame
local menu = create("MainMenu", "Frame", gui, {
	Size = UDim2.new(0, 400, 0, 300),
	Position = UDim2.new(0.3, 0, 0.3, 0),
	BackgroundColor3 = Color3.fromRGB(0, 100, 0),
	BorderColor3 = Color3.fromRGB(0, 255, 0),
	BorderSizePixel = 3,
	Draggable = true,
	Active = true
})

local title = create("Title", "TextLabel", menu, {
	Text = "WTOOTO",
	Size = UDim2.new(1, 0, 0, 30),
	BackgroundTransparency = 1,
	TextColor3 = Color3.new(1, 1, 1),
	TextStrokeTransparency = 0.5,
	Font = Enum.Font.GothamBold,
	TextSize = 20
})

-- Restore Button
local restore = create("Restore", "TextButton", gui, {
	Text = "+",
	Size = UDim2.new(0, 40, 0, 40),
	Position = UDim2.new(0.5, -20, 0, 40), -- ขยับขึ้นเล็กน้อย
	BackgroundColor3 = Color3.fromRGB(0, 255, 0),
	Visible = false,
	Draggable = true,
	Active = true
})

-- Close Button
local close = create("Close", "TextButton", menu, {
	Text = "X",
	Size = UDim2.new(0, 30, 0, 30),
	Position = UDim2.new(1, -30, 0, 0),
	BackgroundColor3 = Color3.fromRGB(255, 0, 0)
})

close.MouseButton1Click:Connect(function()
	menu.Visible = false
	restore.Visible = true
end)

restore.MouseButton1Click:Connect(function()
	menu.Visible = true
	restore.Visible = false
end)

-- Tab Panel
local sidePanel = create("SidePanel", "Frame", menu, {
	Size = UDim2.new(0, 120, 1, -30),
	Position = UDim2.new(0, 0, 0, 30),
	BackgroundColor3 = Color3.fromRGB(0, 80, 0)
})

local tabs = {}
local tabFrames = {}
local selected = 1

local function switchTab(i)
	for j = 1, 5 do
		tabFrames[j].Visible = false
	end
	tabFrames[i].Visible = true
	selected = i
end

-- ESP & Aimbot States
local espOn, aimbotOn = false, false

for i = 1, 5 do
	tabs[i] = create("TabBtn" .. i, "TextButton", sidePanel, {
		Text = (i == 1 and "ESP & Aimbot" or "Tab " .. i),
		Size = UDim2.new(1, -10, 0, 40),
		Position = UDim2.new(0, 5, 0, (i - 1) * 45),
		BackgroundColor3 = Color3.fromRGB(0, 120, 0),
		TextColor3 = Color3.new(1, 1, 1)
	})

	tabFrames[i] = create("TabFrame" .. i, "Frame", menu, {
		Size = UDim2.new(1, -130, 1, -30),
		Position = UDim2.new(0, 130, 0, 30),
		BackgroundColor3 = Color3.fromRGB(0, 60, 0),
		Visible = i == 1
	})

	if i == 1 then
		local espBtn = create("ESP", "TextButton", tabFrames[i], {
			Text = "ESP: OFF",
			Size = UDim2.new(0, 200, 0, 40),
			Position = UDim2.new(0, 10, 0, 10),
			BackgroundColor3 = Color3.fromRGB(0, 150, 0)
		})
		local aimBtn = create("Aimbot", "TextButton", tabFrames[i], {
			Text = "Aimbot: OFF",
			Size = UDim2.new(0, 200, 0, 40),
			Position = UDim2.new(0, 10, 0, 60),
			BackgroundColor3 = Color3.fromRGB(0, 150, 0)
		})

		espBtn.MouseButton1Click:Connect(function()
			espOn = not espOn
			espBtn.Text = "ESP: " .. (espOn and "ON" or "OFF")
			-- ใส่โค้ดไฮไลต์ ESP ที่นี่
		end)

		aimBtn.MouseButton1Click:Connect(function()
			aimbotOn = not aimbotOn
			aimBtn.Text = "Aimbot: " .. (aimbotOn and "ON" or "OFF")
			-- ใส่โค้ด Aimbot ที่นี่
		end)
	else
		local label = create("ComingSoon", "TextLabel", tabFrames[i], {
			Text = "Coming Soon...",
			Size = UDim2.new(1, 0, 1, 0),
			TextColor3 = Color3.new(1, 1, 1),
			BackgroundTransparency = 1,
			Font = Enum.Font.GothamBold,
			TextScaled = true
		})
	end

	tabs[i].MouseButton1Click:Connect(function()
		switchTab(i)
	end)
end

-- สถานะปุ่มยังอยู่เมื่อกลับมา Tab 1
game:GetService("RunService").RenderStepped:Connect(function()
	if selected == 1 then
		local t1 = tabFrames[1]
		t1.ESP.Text = "ESP: " .. (espOn and "ON" or "OFF")
		t1.Aimbot.Text = "Aimbot: " .. (aimbotOn and "ON" or "OFF")
	end
end)
