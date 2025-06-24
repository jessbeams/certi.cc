local HttpService = game:GetService("HttpService")

local CURRENT_VERSION = "1.01" -- The version this loader expects to be valid

local success, response = pcall(function()
    return HttpService:GetAsync("https://raw.githubusercontent.com/jessbeams/certi.cc/refs/heads/main/source.lua")
end)

if not success then
    warn("❌ Failed to check version: " .. tostring(response))
    return
end

local fetched = nil
local successLoad, result = pcall(function()
    return loadstring(response)()
end)

if not successLoad then
    warn("❌ Failed to load fetched script: " .. tostring(result))
    return
end

fetched = result

if fetched and fetched.Version then
    if fetched.Version ~= CURRENT_VERSION then
        warn("❌ Your version is outdated.\nInstalled: " .. CURRENT_VERSION .. "\nRequired: " .. fetched.Version)
        return
    end

    if fetched.Code and typeof(fetched.Code) == "function" then
        fetched.Code()
    else
        warn("❌ Fetched script does not contain valid code to execute.")
    end
else
    warn("❌ Version information missing or invalid in fetched script.")
end
