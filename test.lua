if not _G.config then
    _G.config = {
        disconnect = {30} -- Thời gian đứng yên trước khi ngắt kết nối (giây)
    }
end

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local playerGui = LocalPlayer:WaitForChild("PlayerGui")
local screenGui = playerGui:FindFirstChild("ScreenGui")
if not screenGui then
    screenGui = Instance.new("ScreenGui")
    screenGui.Parent = playerGui
end

local lastPosition = LocalPlayer.Character.HumanoidRootPart.Position
local stationaryTime = 0
local timerLabel = Instance.new("TextLabel")
timerLabel.Parent = screenGui 
timerLabel.Position = UDim2.new(0.5, 0, 0.5, 0) 
timerLabel.Size = UDim2.new(0, 200, 0, 50)
timerLabel.BackgroundTransparency = 0.5
timerLabel.TextColor3 = Color3.new(1, 1, 1)
timerLabel.Text = "0"

local lobbyStatusLabel = Instance.new("TextLabel")
lobbyStatusLabel.Parent = screenGui
lobbyStatusLabel.Position = UDim2.new(0.5, 0, 0.6, 0)
lobbyStatusLabel.Size = UDim2.new(0, 200, 0, 30)
lobbyStatusLabel.BackgroundTransparency = 0.5
lobbyStatusLabel.TextColor3 = Color3.new(1, 1, 1)
lobbyStatusLabel.Text = "Lobby: false" 


local function isInLobby()
    return workspace:FindFirstChild("Lobby") ~= nil
end

game:GetService("RunService").Heartbeat:Connect(function()
    local currentPosition = LocalPlayer.Character.HumanoidRootPart.Position
    if (currentPosition - lastPosition).Magnitude < 0.1 then 
        stationaryTime += 1/60 
    else
        stationaryTime = 0 
        lastPosition = currentPosition 
    end

    timerLabel.Text = string.format("Đứng yên: %.1f giây", stationaryTime)

    lobbyStatusLabel.Text = "Lobby: " .. tostring(isInLobby())

    if stationaryTime >= _G.config.disconnect[1] and isInLobby() then 
        game:Shutdown() 
    end
end)
