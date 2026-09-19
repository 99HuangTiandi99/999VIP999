local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local HttpService = game:GetService("HttpService")

local SAVE_FILE_NAME = "DeltaOriginal.json"

local function isKeyValid()
	if writefile and readfile and isfile and isfile(SAVE_FILE_NAME) then
		local success, data = pcall(function()
			return HttpService:JSONDecode(readfile(SAVE_FILE_NAME))
		end)
		if success and data and data.expireTime then
			if os.time() < data.expireTime then
				return true
			end
		end
	end
	return false
end

local function saveKeySession()
	if writefile then
		local data = {
			expireTime = os.time() + 43200
		}
		pcall(function()
			writefile(SAVE_FILE_NAME, HttpService:JSONEncode(data))
		end)
	end
end

if isKeyValid() then
	loadstring(game:HttpGet("https://raw.githubusercontent.com/KingSoloooNeverDie/ScriptOverPower/refs/heads/main/V3.lua"))()
	return
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ZorVexKeySystem"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 390, 0, 180)
mainFrame.Position = UDim2.new(0.5, -195, 0.5, -90)
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
mainFrame.BackgroundTransparency = 0.1
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 16)
mainCorner.Parent = mainFrame

local UIShadowSafe85 = Instance.new("UIStroke")
UIShadowSafe85.Thickness = 6.000
UIShadowSafe85.Transparency = 0.900
UIShadowSafe85.Color = Color3.fromRGB(0, 0, 0)
UIShadowSafe85.Parent = mainFrame

local UIShadowSafe65 = Instance.new("UIStroke")
UIShadowSafe65.Thickness = 5.000
UIShadowSafe65.Transparency = 0.900
UIShadowSafe65.Color = Color3.fromRGB(0, 0, 0)
UIShadowSafe65.Parent = mainFrame

local UIShadowSafe50 = Instance.new("UIStroke")
UIShadowSafe50.Thickness = 4.000
UIShadowSafe50.Transparency = 0.900
UIShadowSafe50.Color = Color3.fromRGB(0, 0, 0)
UIShadowSafe50.Parent = mainFrame

local UIShadowSafe45 = Instance.new("UIStroke")
UIShadowSafe45.Thickness = 3.000
UIShadowSafe45.Transparency = 0.900
UIShadowSafe45.Color = Color3.fromRGB(0, 0, 0)
UIShadowSafe45.Parent = mainFrame

local closeBtn = Instance.new("TextButton")
closeBtn.Name = "CloseButton"
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 10)
closeBtn.BackgroundTransparency = 1
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(150, 150, 150)
closeBtn.TextSize = 16
closeBtn.Parent = mainFrame

closeBtn.MouseEnter:Connect(function()
	TweenService:Create(closeBtn, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(255, 50, 50)}):Play()
end)

closeBtn.MouseLeave:Connect(function()
	TweenService:Create(closeBtn, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(150, 150, 150)}):Play()
end)

closeBtn.MouseButton1Click:Connect(function()
	local duration = 0.5
	TweenService:Create(mainFrame, TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
	
	local function fadeOutRecursive(parent)
		for _, child in ipairs(parent:GetChildren()) do
			if child:IsA("GuiObject") then
				TweenService:Create(child, TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
				if child:IsA("TextLabel") or child:IsA("TextBox") or child:IsA("TextButton") then
					TweenService:Create(child, TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 1, TextStrokeTransparency = 1}):Play()
				elseif child:IsA("ImageLabel") then
					TweenService:Create(child, TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageTransparency = 1}):Play()
				end
				fadeOutRecursive(child)
			elseif child:IsA("UIStroke") then
				TweenService:Create(child, TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Transparency = 1}):Play()
			end
		end
	end
	
	fadeOutRecursive(mainFrame)
	task.wait(duration)
	screenGui:Destroy()
end)

local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "TitleLabel"
titleLabel.Size = UDim2.new(0, 220, 0, 40)
titleLabel.Position = UDim2.new(0, 130, 0, 20)
titleLabel.BackgroundTransparency = 1
titleLabel.Font = Enum.Font.GothamBold
titleLabel.Text = "Key System ZorVex"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextSize = 20
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = mainFrame

local textGradient = Instance.new("UIGradient")
textGradient.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(200, 200, 200)),
	ColorSequenceKeypoint.new(0.5, Color3.fromRGB(10, 10, 10)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(200, 200, 200))
})
textGradient.Offset = Vector2.new(-1, 0)
textGradient.Parent = titleLabel

task.spawn(function()
	local offset = -1
	while true do
		offset = offset + 0.01
		if offset > 1 then
			offset = -1
		end
		textGradient.Offset = Vector2.new(offset, 0)
		RunService.RenderStepped:Wait()
	end
end)

local logoPlaceholder = Instance.new("ImageLabel")
logoPlaceholder.Name = "Logo"
logoPlaceholder.Size = UDim2.new(0, 80, 0, 80)
logoPlaceholder.Position = UDim2.new(0, 35, 0, -1)
logoPlaceholder.BackgroundTransparency = 1
logoPlaceholder.Image = "rbxassetid://91981940230704"
logoPlaceholder.Parent = mainFrame

local logoCorner = Instance.new("UICorner")
logoCorner.CornerRadius = UDim.new(0, 8)
logoCorner.Parent = logoPlaceholder

local textBox = Instance.new("TextBox")
textBox.Name = "KeyTextBox"
textBox.Size = UDim2.new(0, 340, 0, 40)
textBox.Position = UDim2.new(0, 25, 0, 80)
textBox.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
textBox.BackgroundTransparency = 0.5
textBox.BorderSizePixel = 0
textBox.Font = Enum.Font.Gotham
textBox.PlaceholderText = "Enter Key"
textBox.PlaceholderColor3 = Color3.fromRGB(120, 120, 120)
textBox.Text = ""
textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
textBox.TextSize = 16
textBox.Parent = mainFrame

local textCorner = Instance.new("UICorner")
textCorner.CornerRadius = UDim.new(0, 8)
textCorner.Parent = textBox

local getKeyBtn = Instance.new("TextButton")
getKeyBtn.Name = "GetKeyButton"
getKeyBtn.Size = UDim2.new(0, 165, 0, 40)
getKeyBtn.Position = UDim2.new(0, 25, -0.03, 135)
getKeyBtn.BackgroundColor3 = Color3.fromRGB(180, 180, 180)
getKeyBtn.BorderSizePixel = 0
getKeyBtn.Font = Enum.Font.GothamBold
getKeyBtn.Text = "Get Key"
getKeyBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
getKeyBtn.TextSize = 16
getKeyBtn.Parent = mainFrame

local getKeyCorner = Instance.new("UICorner")
getKeyCorner.CornerRadius = UDim.new(0, 8)
getKeyCorner.Parent = getKeyBtn

local submitBtn = Instance.new("TextButton")
submitBtn.Name = "SubmitButton"
submitBtn.Size = UDim2.new(0, 165, 0, 40)
submitBtn.Position = UDim2.new(0, 200, -0.03, 135)
submitBtn.BackgroundColor3 = Color3.fromRGB(180, 180, 180)
submitBtn.BorderSizePixel = 0
submitBtn.Font = Enum.Font.GothamBold
submitBtn.Text = "Sumbit"
submitBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
submitBtn.TextSize = 16
submitBtn.Parent = mainFrame

local submitCorner = Instance.new("UICorner")
submitCorner.CornerRadius = UDim.new(0, 8)
submitCorner.Parent = submitBtn

local activeNotifications = {}

local function showNotification(notifTitleText, notifContentText)
	local padding = 10
	local startY = 20

	local dummyLabel = Instance.new("TextLabel")
	dummyLabel.Font = Enum.Font.GothamBold
	dummyLabel.TextSize = 14
	dummyLabel.Text = notifContentText
	local textService = game:GetService("TextService")
	local bounds = textService:GetTextSize(notifContentText, 14, Enum.Font.GothamBold, Vector2.new(1000, 30))
	dummyLabel:Destroy()

	local minWidth = 240
	local calculatedWidth = math.max(minWidth, bounds.X + 75)
	local notifHeight = 55

	local index = #activeNotifications + 1
	local targetY = startY + (index - 1) * (notifHeight + padding)

	local notificationFrame = Instance.new("Frame")
	notificationFrame.Name = "NotificationFrame"
	notificationFrame.Size = UDim2.new(0, calculatedWidth, 0, notifHeight)
	notificationFrame.Position = UDim2.new(1, calculatedWidth + 20, 0, targetY)
	notificationFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
	notificationFrame.BackgroundTransparency = 0.1
	notificationFrame.BorderSizePixel = 0
	notificationFrame.Parent = screenGui

	local notifCorner = Instance.new("UICorner")
	notifCorner.CornerRadius = UDim.new(0, 10)
	notifCorner.Parent = notificationFrame

	local notifStroke85 = Instance.new("UIStroke")
	notifStroke85.Thickness = 5.000
	notifStroke85.Transparency = 0.900
	notifStroke85.Color = Color3.fromRGB(0, 0, 0)
	notifStroke85.Parent = notificationFrame

	local notifStroke65 = Instance.new("UIStroke")
	notifStroke65.Thickness = 4.000
	notifStroke65.Transparency = 0.900
	notifStroke65.Color = Color3.fromRGB(0, 0, 0)
	notifStroke65.Parent = notificationFrame

	local notifStroke50 = Instance.new("UIStroke")
	notifStroke50.Thickness = 3.000
	notifStroke50.Transparency = 0.900
	notifStroke50.Color = Color3.fromRGB(0, 0, 0)
	notifStroke50.Parent = notificationFrame

	local notifStroke45 = Instance.new("UIStroke")
	notifStroke45.Thickness = 2.000
	notifStroke45.Transparency = 0.900
	notifStroke45.Color = Color3.fromRGB(0, 0, 0)
	notifStroke45.Parent = notificationFrame

	local notifLogo = Instance.new("ImageLabel")
	notifLogo.Name = "NotifLogo"
	notifLogo.Size = UDim2.new(0, 32, 0, 32)
	notifLogo.Position = UDim2.new(0, 12, 0.5, -16)
	notifLogo.BackgroundTransparency = 1
	notifLogo.Image = "rbxassetid://91981940230704"
	notifLogo.Parent = notificationFrame

	local notifTitle = Instance.new("TextLabel")
	notifTitle.Name = "NotificationTitle"
	notifTitle.Size = UDim2.new(1, -56, 0, 18)
	notifTitle.Position = UDim2.new(0, 52, 0, 9)
	notifTitle.BackgroundTransparency = 1
	notifTitle.Font = Enum.Font.GothamBold
	notifTitle.Text = notifTitleText
	notifTitle.TextColor3 = Color3.fromRGB(220, 220, 220)
	notifTitle.TextSize = 13
	notifTitle.TextXAlignment = Enum.TextXAlignment.Left
	notifTitle.Parent = notificationFrame

	local notifText = Instance.new("TextLabel")
	notifText.Name = "NotificationText"
	notifText.Size = UDim2.new(1, -56, 0, 18)
	notifText.Position = UDim2.new(0, 52, 0, 27)
	notifText.BackgroundTransparency = 1
	notifText.Font = Enum.Font.Gotham
	notifText.Text = notifContentText
	notifText.TextColor3 = Color3.fromRGB(255, 255, 255)
	notifText.TextSize = 12
	notifText.TextXAlignment = Enum.TextXAlignment.Left
	notifText.Parent = notificationFrame

	table.insert(activeNotifications, notificationFrame)

	local showTween = TweenService:Create(notificationFrame, TweenInfo.new(0.9, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
		Position = UDim2.new(1, -(calculatedWidth + 20), 0, targetY)
	})
	showTween:Play()

	task.delay(4, function()
		if not notificationFrame.Parent then return end

		local hideTween = TweenService:Create(notificationFrame, TweenInfo.new(0.7, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
			Position = UDim2.new(1, calculatedWidth + 20, 0, notificationFrame.Position.Y.Offset)
		})
		hideTween:Play()
		
		hideTween.Completed:Connect(function()
			notificationFrame:Destroy()
			
			for i, frame in ipairs(activeNotifications) do
				if frame == notificationFrame then
					table.remove(activeNotifications, i)
					break
				end
			end

			for i, frame in ipairs(activeNotifications) do
				local newY = startY + (i - 1) * (notifHeight + padding)
				local currentW = frame.AbsoluteSize.X
				TweenService:Create(frame, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
					Position = UDim2.new(1, -(currentW + 20), 0, newY)
				}):Play()
			end
		end)
	end)
end

local originalSizes = {
	[getKeyBtn] = getKeyBtn.Size,
	[submitBtn] = submitBtn.Size
}
local originalPositions = {
	[getKeyBtn] = getKeyBtn.Position,
	[submitBtn] = submitBtn.Position
}
local activeTweens = {}

local function animateButtonClick(btn)
	if activeTweens[btn] then
		activeTweens[btn]:Cancel()
	end
	
	local origSize = originalSizes[btn]
	local origPos = originalPositions[btn]
	
	btn.Size = origSize
	btn.Position = origPos
	
	local targetSize = UDim2.new(origSize.X.Scale, origSize.X.Offset - 6, origSize.Y.Scale, origSize.Y.Offset - 4)
	local targetPos = UDim2.new(origPos.X.Scale, origPos.X.Offset + 3, origPos.Y.Scale, origPos.Y.Offset + 2)
	
	local tweenInfo = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	local tween1 = TweenService:Create(btn, tweenInfo, {Size = targetSize, Position = targetPos})
	local tween2 = TweenService:Create(btn, tweenInfo, {Size = origSize, Position = origPos})
	
	activeTweens[btn] = tween1
	tween1:Play()
	tween1.Completed:Connect(function()
		if activeTweens[btn] == tween1 then
			activeTweens[btn] = tween2
			tween2:Play()
		end
	end)
end

submitBtn.MouseButton1Click:Connect(function()
	animateButtonClick(submitBtn)
	local enteredKey = textBox.Text
	
	if enteredKey == "ZorVex" then
		local success, pastebinData = pcall(function()
			return game:HttpGet("https://pastebin.com/raw/N89CEe6M")
		end)
		
		if success and pastebinData then
			local userIdString = tostring(player.UserId)
			if string.find(pastebinData, userIdString) then
				showNotification("Success", "VIP Script Loaded...")
				loadstring(game:HttpGet('https://raw.githubusercontent.com/doushengg/VIP/refs/heads/main/ZvX.lua'))()
				
				task.spawn(function()
					local duration = 2.0
					
					TweenService:Create(mainFrame, TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
					
					local function fadeOutRecursive(parent)
						for _, child in ipairs(parent:GetChildren()) do
							if child:IsA("GuiObject") then
								TweenService:Create(child, TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
								if child:IsA("TextLabel") or child:IsA("TextBox") or child:IsA("TextButton") then
									TweenService:Create(child, TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 1, TextStrokeTransparency = 1}):Play()
								elseif child:IsA("ImageLabel") then
									TweenService:Create(child, TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageTransparency = 1}):Play()
								end
								fadeOutRecursive(child)
							elseif child:IsA("UIStroke") then
								TweenService:Create(child, TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Transparency = 1}):Play()
							end
						end
					end
					
					fadeOutRecursive(mainFrame)

					task.wait(duration)
					screenGui:Destroy()
				end)
			else
				showNotification("Error", "Buy Premium Script on Discord")
				task.wait(0.4)
				showNotification("Get Key", "To Get Discord Link!!")
			end
		else
			showNotification("Error", "!!Whitelist Problems!!")
		end
		
	elseif enteredKey == "Zor_Vip" then
		saveKeySession()
		
		showNotification("Success", "Vip Script Loaded...")
		loadstring(game:HttpGet("https://raw.githubusercontent.com/KingSoloooNeverDie/ScriptOverPower/refs/heads/main/V3.lua"))()
		
		task.spawn(function()
			local duration = 2.0
			
			TweenService:Create(mainFrame, TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
			
			local function fadeOutRecursive(parent)
				for _, child in ipairs(parent:GetChildren()) do
					if child:IsA("GuiObject") then
						TweenService:Create(child, TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
						if child:IsA("TextLabel") or child:IsA("TextBox") or child:IsA("TextButton") then
							TweenService:Create(child, TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 1, TextStrokeTransparency = 1}):Play()
						elseif child:IsA("ImageLabel") then
							TweenService:Create(child, TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageTransparency = 1}):Play()
						end
						fadeOutRecursive(child)
					elseif child:IsA("UIStroke") then
						TweenService:Create(child, TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Transparency = 1}):Play()
					end
				end
			end
			
			fadeOutRecursive(mainFrame)

			task.wait(duration)
			screenGui:Destroy()
		end)
	elseif enteredKey ~= "" then
		showNotification("Error", "Join Discord To Get Key!!")
		task.wait(0.6)
		showNotification("Get Key", "To Get Discord Link!!")
	else
		showNotification("Error", "Buy Premium Script on Discord")
		task.wait(0.6)
		showNotification("Get Key", "To Get Discord Link!!")
	end
end)
		
getKeyBtn.MouseButton1Click:Connect(function()
	animateButtonClick(getKeyBtn)
	
	local success = pcall(function()
		setclipboard("https://discord.gg/cGk3KZrSa8")
	end)
	
	if success then
		showNotification("Link Discord", "Link Copied To Clipboard!")
	else
		showNotification("Link Discord", "https://discord.gg/cGk3KZrSa8")
	end
end)
