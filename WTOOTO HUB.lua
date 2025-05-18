local Players = game:GetService("Players")
local player = Players.LocalPlayer
local mouse = player:GetMouse()
local uis = game:GetService("UserInputService")

-- GUI สร้างด้วย Code
local ScreenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
ScreenGui.Name = "WTOOTO_GUI"

local menuFrame = Instance.new("Frame", ScreenGui)
menuFrame.Size = UDim2.new(0, 400, 0, 300)
menuFrame.Position = UDim2.new(0.3, 0, 0.3, 0)
menuFrame.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
menuFrame.BorderSizePixel = 2
menuFrame.BorderColor3 = Color3.fromRGB(0, 255, 0)

local titleLabel = Instance.new("TextLabel", menuFrame)
titleLabel.Text = "WTOOTO"
titleLabel.Size = UDim2.new(1, 0, 0, 30)
titleLabel.BackgroundTransparency = 1
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextStrokeTransparency = 0.5
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 20

-- ปุ่ม Restore ( + )
local restoreBtn = Instance.new("TextButton", ScreenGui)
restoreBtn.Text = "+"
restoreBtn.Size = UDim2.new(0, 40, 0, 40)
restoreBtn.Position = UDim2.new(0.5, -20, 0, 20) -- สูงขึ้น 20
restoreBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
restoreBtn.Visible = false

-- Drag System
local dragging, dragInput, dragStart, startPos

local function updateDrag(input)
	local delta = input.Position - dragStart
	menuFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

menuFrame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = menuFrame.Position

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

menuFrame.InputChanged:Connect(function(input)
	if dragging and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement) then
		updateDrag(input)
	end
end)

-- Tab System
local tabs = {}
local currentTab = nil

local sidePanel = Instance.new("Frame", menuFrame)
sidePanel.Size = UDim2.new(0, 120, 1, -30)
sidePanel.Position = UDim2.new(0, 0, 0, 30)
sidePanel.BackgroundTransparency = 0.1
sidePanel.BackgroundColor3 = Color3.fromRGB(0, 80, 0)

for i = 1, 5 do
	local tabBtn = Instance.new("TextButton", sidePanel)
	tabBtn.Size = UDim2.new(1, -10, 0, 40)
	tabBtn.Position = UDim2.new(0, 5, 0, (i - 1) * 45)
	tabBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 0)
	tabBtn.TextColor3 = Color3.new(1, 1, 1)
	tabBtn.Text = (i == 1 and "ESP & Aimbot" or "Tab " .. i)
	tabBtn.Name = "Tab" .. i
	
	local tabFrame = Instance.new("Frame", menuFrame)
	tabFrame.Size = UDim2.new(1, -130, 1, -30)
	tabFrame.Position = UDim2.new(0, 130, 0, 30)
	tabFrame.Visible = i == 1
	tabFrame.Name = "TabFrame" .. i
	tabFrame.BackgroundColor3 = Color3.fromRGB(0, 60, 0)
	
	if i == 1 then
		local espToggle = Instance.new("TextButton", tabFrame)
		espToggle.Size = UDim2.new(0, 200, 0, 40)
		espToggle.Position = UDim2.new(0, 10, 0, 10)
		espToggle.Text = "ESP: OFF"
		espToggle.BackgroundColor3 = Color3.fromRGB(0, 150, 0)

		local aimbotToggle = Instance.new("TextButton", tabFrame)
		aimbotToggle.Size = UDim2.new(0, 200, 0, 40)
		aimbotToggle.Position = UDim2.new(0, 10, 0, 60)
		aimbotToggle.Text = "Aimbot: OFF"
		aimbotToggle.BackgroundColor3 = Color3.fromRGB(0, 150, 0)

		local espEnabled = false
		local aimbotEnabled = false

		espToggle.MouseButton1Click:Connect(function()
			espEnabled = not espEnabled
			espToggle.Text = "ESP: " .. (espEnabled and "ON" or "OFF")
			-- เพิ่ม ESP โค้ดตรงนี้
		end)

		aimbotToggle.MouseButton1Click:Connect(function()
			aimbotEnabled = not aimbotEnabled
			aimbotToggle.Text = "Aimbot: " .. (aimbotEnabled and "ON" or "OFF")
			-- เพิ่ม Aimbot โค้ดตรงนี้
		end)
	else
		local comingLabel = Instance.new("TextLabel", tabFrame)
		comingLabel.Size = UDim2.new(1, 0, 1, 0)
		comingLabel.Text = "Coming Soon..."
		comingLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		comingLabel.BackgroundTransparency = 1
	end

	tabBtn.MouseButton1Click:Connect(function()
		for j = 1, 5 do
			menuFrame:FindFirstChild("TabFrame" .. j).Visible = false
		end
		tabFrame.Visible = true
	end)
end

-- ปุ่มปิดเมนู
local closeBtn = Instance.new("TextButton", menuFrame)
closeBtn.Text = "X"
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -30, 0, 0)
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)

closeBtn.MouseButton1Click:Connect(function()
	menuFrame.Visible = false
	restoreBtn.Visible = true
end)

restoreBtn.MouseButton1Click:Connect(function()
	menuFrame.Visible = true
	restoreBtn.Visible = false
end)
