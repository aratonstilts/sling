if not game:IsLoaded() then
game.Loaded:Wait()
end

local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local Character = Player.Character or Player.Character:Wait()
local HR = Character:WaitForChild("HumanoidRootPart")

local PlayerGui = Player.PlayerGui
local mainGui = PlayerGui:WaitForChild("MainGui")
local otherFrames = mainGui:WaitForChild("OtherFrames")
local fullGui = otherFrames:WaitForChild("FullPopup")
local backgroundFrame = mainGui:WaitForChild("BackgroundFrame")

local lighting = game:GetService("Lighting")
local blur = lighting:WaitForChild("Blur")

local GetM = game.Players.LocalPlayer:GetMouse() 
repeat wait() until GetM

local RS = game:GetService("ReplicatedStorage")
local events = RS:WaitForChild("Events")
local uiAction = events:WaitForChild("UIAction")
local requestShoot = events:WaitForChild("RequestShoot")
local cancel = events:WaitForChild("RequestCancelShoot")
local hatchEgg = events:WaitForChild("RequestEggHatch")

local amountToHatch = "Single"
local autoSelling = false

local oldGui = game.CoreGui:FindFirstChild("sling")
if oldGui then
    oldGui:Destroy()
end

local function shoot()
    requestShoot:InvokeServer(HR.CFrame)
end

local function cancelShot()
    cancel:FireServer()
end

local function openEgg(eggName)
    hatchEgg:FireServer(eggName,amountToHatch)
end

local function fillEggsBackground(background)
	
	if background:FindFirstChildWhichIsA("TextButton") then return end

	for _,egg in pairs(game:GetService("ReplicatedStorage"):WaitForChild("Models"):WaitForChild("Eggs"):GetChildren()) do
		local button = Instance.new("TextButton")
		button.Name = egg.Name
		button.Position = UDim2.new(0,1,0,21)
		button.Size = UDim2.new(.98,0,0.2,0)
		button.BackgroundColor3 = Color3.fromRGB(100,100,50)
		button.BackgroundTransparency = 0.8
		button.BorderColor3 = Color3.new(1,1,1)
		button.ZIndex = 2
		button.Text = egg.Name
		button.TextColor3 = Color3.new(1,1,1)
		button.TextStrokeTransparency = 0
		button.TextScaled = true
		button.Parent = background
		button.MouseButton1Click:Connect(function()
			if button.Text == egg.Name then
				button.Text = "Opening "..egg.Name
				repeat
					openEgg(egg.Name)
					task.wait()
				until button.Text == egg.Name
			else
				button.Text = egg.Name
			end
		end)
	end
end
        
CmdGui = Instance.new("ScreenGui")
CmdGui.Name = "sling"
CmdGui.Parent = game:GetService("CoreGui")

Background = Instance.new("Frame")
Background.Name = "Background"
Background.Parent = CmdGui
Background.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Background.Transparency = 0.5
Background.BorderSizePixel = 0
Background.BorderColor3 = Color3.new(1,0,1)
Background.Position = UDim2.new(0.05, 0, 0.5, 0)
Background.Size = UDim2.new(0.15, 0, 0.4, 0)
Background.Active = true

CmdName = Instance.new("TextButton")
CmdName.Name = "CmdName"
CmdName.AutoButtonColor = false
CmdName.Parent = Background
CmdName.BackgroundColor3 = Color3.fromRGB(250, 100, 100)
CmdName.BorderSizePixel = 0
CmdName.Size = UDim2.new(1, 0, .1, 0)
CmdName.Font = Enum.Font.GothamBlack
CmdName.Text = "SLING"
CmdName.TextColor3 = Color3.fromRGB(255, 255, 255)
CmdName.TextScaled = true
CmdName.TextSize = 14.000
CmdName.TextWrapped = true
Dragg = false
CmdName.MouseButton1Down:Connect(function()Dragg = true while Dragg do game.TweenService:Create(Background, TweenInfo.new(.06), {Position = UDim2.new(0,GetM.X-60,0,GetM.Y-15)}):Play()wait()end end)
CmdName.MouseButton1Up:Connect(function()Dragg = false end)

local cmdStroke = Instance.new("UIStroke")
cmdStroke.Thickness = 2
cmdStroke.Parent = CmdName

local cmdStroke = Instance.new("UIStroke")
cmdStroke.Thickness = 2
cmdStroke.Parent = CmdName

Close = Instance.new("TextButton")
Close.Name = "Close"
Close.Parent = Background
Close.BackgroundColor3 = Color3.fromRGB(155, 0, 0)
Close.BorderSizePixel = 0
Close.AnchorPoint = Vector2.new(1,0)
Close.Position = UDim2.new(1, 0, 0, 0)
Close.Size = UDim2.new(.2, 0, 0.1, 0)
Close.Font = Enum.Font.SourceSans
Close.Text = "X"
Close.TextStrokeTransparency = 0
Close.TextColor3 = Color3.fromRGB(255, 255, 255)
Close.TextSize = 14.000
Close.MouseButton1Click:Connect(function()
	CmdGui:Destroy()
end)


local Background2 = Instance.new("ScrollingFrame")
Background2.Name = "Eggs"
Background2.Parent = Background
Background2.AutomaticCanvasSize = "Y"
Background2.ScrollBarThickness = 3
Background2.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Background2.Transparency = 0.5
Background2.BorderSizePixel = 0
Background2.BorderColor3 = Color3.new(1,0,1)
Background2.Position = UDim2.new(1, 0, 0, 0)
Background2.Size = UDim2.new(1, 0, 1, 0)
Background2.Visible = false
Background2.Active = true

local listLayout = Instance.new("UIListLayout")
listLayout.HorizontalAlignment = 0
listLayout.Parent = Background2

eggsButton = Instance.new("TextButton")
eggsButton.Position = UDim2.new(0,0,0.1,0)
eggsButton.Size = UDim2.new(.98,0,0.2,0)
eggsButton.BackgroundColor3 = Color3.fromRGB(100,100,50)
eggsButton.BackgroundTransparency = 0.8
eggsButton.BorderColor3 = Color3.new(1,1,1)
eggsButton.ZIndex = 2
eggsButton.Parent = Background
eggsButton.Text = "Eggs >"
eggsButton.TextStrokeTransparency = 0
eggsButton.TextColor3 = Color3.new(1,1,1)
eggsButton.TextScaled = true
eggsButton.MouseButton1Click:Connect(function()
	if eggsButton.Text == "Eggs >" then
		eggsButton.Text = "Eggs <"
		if Background2.Visible == false then
		
			if game:GetService("Players").LocalPlayer.PlayerGui.MainGui.OtherFrames.RobuxStore.Frame.ScrollingFrame.Passes_Frame1.MultiHatch.ImageButton.Owned.Visible == true then
				amountToHatch = "Multi"
			else
				amountToHatch = "Single"
			end
			
			fillEggsBackground(Background2)
			Background2.Visible = true
		end
	else
		eggsButton.Text = "Eggs >"
		if Background2.Visible == true then
			Background2.Visible = false
		end
	end
end)

autoShoot = Instance.new("TextButton")
autoShoot.Name = "autoShoot"
autoShoot.Position = UDim2.new(0,0,0.6,0)
autoShoot.Size = UDim2.new(0.98,0,0.2,0)
autoShoot.BackgroundColor3 = Color3.fromRGB(50,100,50)
autoShoot.BackgroundTransparency = 0.8
autoShoot.BorderColor3 = Color3.new(1,1,1)
autoShoot.ZIndex = 2
autoShoot.Parent = Background
autoShoot.Text = "Shoot Faced Direction"
autoShoot.TextStrokeTransparency = 0
autoShoot.TextColor3 = Color3.new(1,1,1)
autoShoot.TextScaled = true
autoShoot.MouseButton1Click:Connect(function()
	if autoShoot.Text == "Shoot Faced Direction" then
		autoShoot.Text = "Shooting"
		repeat
			shoot()
			task.wait(0.5)
		until autoShoot.Text ~= "Shooting"
	else
		autoShoot.Text = "Shoot Faced Direction"
		cancelShot()
	end
end)

autoSell = Instance.new("TextButton")
autoSell.Name = "autoShoot"
autoSell.Position = UDim2.new(0,0,0.33,0)
autoSell.Size = UDim2.new(0.98,0,0.2,0)
autoSell.BackgroundColor3 = Color3.fromRGB(50,100,50)
autoSell.BackgroundTransparency = 0.8
autoSell.BorderColor3 = Color3.new(1,1,1)
autoSell.ZIndex = 2
autoSell.Parent = Background
autoSell.Text = "Auto Sell when full"
autoSell.TextStrokeTransparency = 0
autoSell.TextColor3 = Color3.new(1,1,1)
autoSell.TextScaled = true
autoSell.MouseButton1Click:Connect(function()
	if autoSelling == false then
		autoSell.Text = "Selling when full"
		autoSelling = true
	else
		autoSell.Text = "Auto Sell when full"
		autoSelling = false
	end
end)

local function sellBlocks()
	uiAction:FireServer("Sell")
end

local function sellAndHideGui()
    if fullGui.Visible == true and autoSelling == true then
        sellBlocks()
        fullGui.Visible = false
        backgroundFrame.Visible = false
        blur.Enabled = false
    end
end 

fullGui:GetPropertyChangedSignal("Visible"):Connect(sellAndHideGui)
