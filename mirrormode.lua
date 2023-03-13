-- Credits: Samet Çetinkaya#1447

local replicatedStorage = game:GetService("ReplicatedStorage")
local placeBlockRegionRemote = replicatedStorage.Remotes.PlaceBIockRegion
loadstring(game:HttpGet("https://github.com/exxtremestuffs/SimpleSpySource/raw/master/SimpleSpy.lua"))()

local isMirroredPlacement = false


local function mirrorBlockPlacement(args)

    if isMirroredPlacement then
        -- If it is, reset the flag and do nothing (to prevent endless mirroring)
        isMirroredPlacement = false
        return
    end


    local blockPosition = args[1]
    local blockRotation = args[2]


    local mirroredPosition = Vector3.new(-blockPosition.X, blockPosition.Y, blockPosition.Z)


local mirroredRotation = blockRotation * CFrame.Angles(0, 0, 0)



    local mirroredArgs = {
        mirroredPosition,
        mirroredRotation,
        args[3], -- Block ID
        args[4] -- Extra data
    }


    isMirroredPlacement = true
    placeBlockRegionRemote:InvokeServer(unpack(mirroredArgs))
end


SimpleSpy:GetRemoteFiredSignal(placeBlockRegionRemote):Connect(mirrorBlockPlacement)
