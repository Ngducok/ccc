
local AutoSell = {"Ariva (Reaper)", "Ariva"}
for _, unitName in ipairs(AutoSell) do
    game:GetService("ReplicatedStorage").Events.SetAutoSell:FireServer(unitName, true)
    print("Auto-sell is up!!!" .. unitName)
end