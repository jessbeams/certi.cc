-- source.lua
return {
    Version = "1.01", -- Latest supported version

    Code = function()
        print("✅ Script loaded successfully! Running version 1.01.")
        -- Place your actual script logic here
        -- For example:
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Certi.cc";
            Text = "Loaded version 1.01";
            Duration = 5;
        })
    end
}
