--TestLOADER
local CURRENT_VERSION = "1.01" -- Version you're currently running

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer or Players:GetPropertyChangedSignal("LocalPlayer"):Wait()

-- Get source.lua from GitHub
local success, response = pcall(function()
    return game:HttpGet("https://raw.githubusercontent.com/jessbeams/certi.cc/refs/heads/main/source.lua")
end)

if not success then
    warn("❌ Failed to fetch remote script:\n" .. tostring(response))
    return
end

-- Load the fetched source.lua code
local fetched
local successLoad, result = pcall(function()
    return loadstring(response)()
end)

if not successLoad then
    warn("❌ Failed to load fetched script:\n" .. tostring(result))
    return
end

fetched = result

-- Version check logic
if fetched and fetched.Version then
    if fetched.Version ~= CURRENT_VERSION then
        warn("❌ Outdated version detected!\nYour version: " .. CURRENT_VERSION .. "\nRequired: " .. fetched.Version)
        -- Attempt to kick the player
        if LocalPlayer and LocalPlayer:Kick() then
            pcall(function()
                LocalPlayer:Kick("❌ Your version is outdated.\nPlease get the latest script.")
            end)
        else
            -- Fallback if .Kick() fails (some executors block it)
            game:Shutdown()
        end
        return
    end

    -- If valid, execute the code block
    if fetched.Code and typeof(fetched.Code) == "function" then
        fetched.Code()
    else
        warn("❌ No valid code block found in source.")
    end
else
    warn("❌ Failed to verify version info from source script.")
end
