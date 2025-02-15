getgenv().Config = { ["Delays"] = 0.05 }
getgenv().start = true
repeat wait() until game:IsLoaded()

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local plr = Players.LocalPlayer
local services    = ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services")
local teamSelect  = services.TeamService.RE:WaitForChild("Select")
local ballSlide   = services.BallService.RE:WaitForChild("Slide")
local ballShoot   = services.BallService.RE:WaitForChild("Shoot")
local goals       = workspace:WaitForChild("Goals")
local playerGui       = plr:WaitForChild("PlayerGui")
local hud             = playerGui:WaitForChild("HUD")
local top             = hud:WaitForChild("Top")
local frame           = top:WaitForChild("Frame")
local lobbyStatus     = frame:WaitForChild("LobbyStatus")
local lobbyStatusText = lobbyStatus:WaitForChild("Text")
local hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
if hrp and not hrp:FindFirstChild("BodyVelocity") then
    local bv = Instance.new("BodyVelocity", hrp)
    bv.Velocity = Vector3.new(0, 0, 0)
end
local function SelectRandomTeam()
    if plr.TeamColor == BrickColor.new("White") then
        local teams = {"Home", "Away"}
        local positions = {"GK", "CM", "CF", "RW", "LW"}
        teamSelect:FireServer(teams[math.random(#teams)], positions[math.random(#positions)])
        if plr.PlayerGui.PostMatch and plr.PlayerGui.PostMatch.Enabled then
            plr.PlayerGui.PostMatch.Enabled = false
        end
    end
end
local function getFootball()
    local ball = workspace:FindFirstChild("Football")
    if ball and ball:FindFirstChild("BallAnims") then
        return ball
    end
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj.Name == "Football" and obj:FindFirstChild("BallAnims") then
            return obj
        end
    end
    return nil
end

local function AutoGoal()
    local ball = getFootball() or workspace:WaitForChild("Football")
    if ball then
        local rootPart = ball:FindFirstChild("BallAnims") and ball.BallAnims:FindFirstChild("RootPart")
        if not ball:IsDescendantOf(plr.Character) and rootPart then
            ball.Hitbox.Size = Vector3.new(100,100,100)
            plr.Character.HumanoidRootPart.CFrame = rootPart.CFrame
            ballSlide:FireServer()
            local timeout, elapsed = getgenv().Config["Delays"], 0
            repeat
                wait(0.01)
                elapsed = elapsed + 0.01
            until ball:IsDescendantOf(plr.Character) or elapsed >= timeout
        end
        if ball:IsDescendantOf(plr.Character) then
            ballShoot:FireServer(200, nil, nil, Vector3.new())
            wait(0.5)
            local goalName = plr.TeamColor == BrickColor.new("Electric blue") and "Goal2" or "Goal"
            ball.CFrame = goals:WaitForChild(goalName).WorldPivot
            wait(1.5)
        end
    end
end
plr.Idled:connect(function()
    game:GetService("VirtualUser"):Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
    wait(1)
    game:GetService("VirtualUser"):Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
end)
spawn(function()
    while getgenv().start and wait() do
        if lobbyStatusText.ContentText == "Join Match!" then
            if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                pcall(function()
                    SelectRandomTeam()
                    AutoGoal()
                end)
            end
        end
    end
end)
