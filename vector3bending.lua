-- Define the mountain properties
local mountainHeight = 10  -- Controls the maximum height of the mountains
local mountainFrequency = 0.1  -- Controls the frequency of the mountain peaks

-- Create the args table
local args = {
    [1] = Vector3.new(),
    [2] = CFrame.new(),
    [3] = 1,
    [4] = ""
}

-- Iterate over the building plot
for x = -25, 25 do
    for z = -25, 25 do
        -- Calculate the height of the current position using a sine function
        local height = mountainHeight * math.sin((x + z) * mountainFrequency)

        -- Set the position and other arguments
        args[1] = Vector3.new(x, height + 15, z)
        args[2] = CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(height), math.rad(x), math.rad(z))  -- Apply rotations using CFrame.Angles
        args[3] = 1
        args[4] = ""

        -- Invoke the remote function
        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("PlaceBIockRegion"):InvokeServer(unpack(args))
    end
end
