getgenv().start = true
repeat wait() until game:IsLoaded()
local plr = game:GetService("Players").LocalPlayer
local TweenService = game:GetService("TweenService")
function tween(speed, destination)
    local rootPart = plr.Character:FindFirstChild("HumanoidRootPart")
    local distance = (rootPart.Position - destination).Magnitude
    local time = distance / speed
    local tweenInfo = TweenInfo.new(time, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
    local tween = TweenService:Create(rootPart, tweenInfo, { CFrame = CFrame.new(destination) })
    tween:Play()
    tween.Completed:Wait()
    return tween
end
local function AutoGrab()
    if not plr.Character or not plr.Character:FindFirstChild("HumanoidRootPart") then
        return
    end
    if plr.TeamColor == BrickColor.new("White") then
        local npcGrab = workspace.NPCs["Giao h\195\160ng"]["npc grab"]
        if npcGrab and npcGrab:FindFirstChild("HumanoidRootPart") then
            plr.Character.HumanoidRootPart.CFrame = npcGrab.HumanoidRootPart.CFrame
            wait(1)
            local npcPrompt = npcGrab:FindFirstChildWhichIsA("ProximityPrompt", true) or workspace.NPCs["Giao h\195\160ng"]:FindFirstChildWhichIsA("ProximityPrompt", true)
            if npcPrompt and npcPrompt.Enabled then
                fireproximityprompt(npcPrompt)
            end
        end
    else
        local hasBox = plr.Backpack:FindFirstChild("Box") or plr.Character:FindFirstChild("Box")
        if not hasBox then
            local boxContainer = workspace.Jobs.Delivery:FindFirstChild("Box")
            if boxContainer and boxContainer:FindFirstChild("Part") then
                local boxPart = boxContainer.Part
                plr.Character.HumanoidRootPart.CFrame = boxPart.CFrame
                wait(0.5)
                local boxPrompt = boxPart:FindFirstChildWhichIsA("ProximityPrompt", true)
                if boxPrompt and boxPrompt.Enabled then
                    fireproximityprompt(boxPrompt)
                end
                wait(0.5)
                if plr.Backpack:FindFirstChild("Box") then
                    plr.Character:FindFirstChildOfClass("Humanoid"):EquipTool(plr.Backpack:FindFirstChild("Box"))
                end
                tween(100,Vector3.new(798.446533, 19.1844006, -522.543762))
                wait(5)
            end
        elseif hasBox then
            local playerBox = workspace:FindFirstChild(plr.Name)
            if playerBox and playerBox:FindFirstChild("Box") and playerBox.Box:FindFirstChild("Address") then
                local targetPathName = playerBox.Box.Address.Value
                local targetPart = workspace.Jobs.Delivery:FindFirstChild(targetPathName)
                if targetPart and targetPart:IsA("Part") then
                    plr.Character.HumanoidRootPart.CFrame = targetPart.CFrame
                    wait(2)
                    local prompt = targetPart:FindFirstChildWhichIsA("ProximityPrompt", true)
                    if prompt and prompt.Enabled then
                        fireproximityprompt(prompt)
                    end
                end
            end
        end
    end
end
plr.Idled:Connect(function()
    game:GetService("VirtualUser"):Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
    wait(1)
    game:GetService("VirtualUser"):Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
end)
spawn(function()
    while getgenv().start and wait() do
        if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            AutoGrab()
        end
    end
end)
