-- how to use 
-- put a seat to ur plot and type the target's name on the code after you launch ur plot execute the code it will make the seat move to target and move to the position  you can modify position to make it somewhere like a jail etc or a cave 
-- todo list first get name without typing whole name second a decent gui to not switch between tabs everyime you want to jail someone third jail all players at once :troll:
local targetName = "samet_gazi"  -- Replace with the actual target's name

local player = game.Players.LocalPlayer
local target = game.Players:FindFirstChild(targetName)

if target then
    local targetCharacter = target.Character
    local targetHumanoid = targetCharacter:FindFirstChild("Humanoid")
    
    if targetCharacter and targetHumanoid then
        local chair = workspace:WaitForChild("samet_gaziAircraft"):WaitForChild("PilotSeat"):WaitForChild("Seat")
        
        -- Move the chair to the target
        chair.CFrame = targetCharacter.HumanoidRootPart.CFrame
        
        -- Listen for the target's state changes
        local seatedConnection
        local jumpingConnection
        
        seatedConnection = targetHumanoid.Seated:Connect(function(_, seat)
            if seat == chair then
                chair.CFrame = CFrame.new(-1035.953857421875, 56.08818817138672, 1965.0611572265625)
                jumpingConnection = targetHumanoid.StateChanged:Connect(function(_, newState)
                    if newState == Enum.HumanoidStateType.Physics and chair.Parent then
                        chair.CFrame = targetCharacter.HumanoidRootPart.CFrame
                    end
                end)
            end
        end)
        
        -- Clean up connections when target leaves the seat
        targetHumanoid:GetPropertyChangedSignal("SeatPart"):Connect(function()
            if not targetHumanoid.SeatPart then
                seatedConnection:Disconnect()
                if jumpingConnection then
                    jumpingConnection:Disconnect()
                end
                chair.CFrame = CFrame.new(-1035.953857421875, 56.08818817138672, 1965.0611572265625)
            end
        end)
    else
        print("Target does not have a valid character or humanoid.")
    end
else
    print("Target not found.")
end
