local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/Bendyshechka/fireworkkick/refs/heads/main/Library')))()
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer

local Window = OrionLib:MakeWindow({Name = "Кикер", HidePremium = false, SaveConfig = false})

local SelectedUsername = ""
local Exclusions = {"", "", ""} -- Список исключений
local AutoKickEnabled = false -- Флаг для авто-кика
local AutoKickRunning = false -- Флаг, чтобы избежать одновременного кика нескольких игроков

-- Вкладка "Главное"
local MainTab = Window:MakeTab({
    Name = "Главное",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

MainTab:AddTextbox({
    Name = "Юзернейм:",
    Default = "",
    TextDisappear = false,
    Callback = function(Value)
        for _, player in ipairs(Players:GetPlayers()) do
            if string.find(string.lower(player.Name), string.lower(Value), 1, true) == 1 then
                SelectedUsername = player.Name
                break
            end
        end
    end
})

MainTab:AddButton({
    Name = "КИК!",
    Callback = function()
        local function kickPlayer(targetPlayer)
            if not targetPlayer then return end

            local leaderstats = LocalPlayer:FindFirstChild("leaderstats")
            if not leaderstats or leaderstats:FindFirstChild("Glove").Value ~= "Firework" then
                OrionLib:MakeNotification({
                    Name = "Ошибка!",
                    Content = "Нужен экипированный Firework!",
                    Time = 3
                })
                return
            end

            local character = LocalPlayer.Character
            local targetCharacter = targetPlayer.Character
            if not character or not targetCharacter then return end

            local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
            local targetRootPart = targetCharacter:FindFirstChild("HumanoidRootPart")
            if not humanoidRootPart or not targetRootPart then return end

            local originalPosition = humanoidRootPart.Position
            local targetOriginalPosition = targetRootPart.Position

            humanoidRootPart:PivotTo(CFrame.new(-824.0519, 298.5387, -1.9000) * CFrame.Angles(0, math.rad(-90), 0))
            targetRootPart:PivotTo(CFrame.new(-818.0519, 298.5387, -1.9000))

            task.wait(0.1)

            humanoidRootPart.Anchored = true
            targetRootPart.Anchored = true

            task.wait(0.3)
            ReplicatedStorage.GeneralAbility:FireServer()

            task.wait(3)
            humanoidRootPart.Anchored = false
            humanoidRootPart:PivotTo(CFrame.new(originalPosition))

            targetRootPart.Anchored = false
            targetRootPart:PivotTo(CFrame.new(targetOriginalPosition))
        end

        local targetPlayer = Players:FindFirstChild(SelectedUsername)
        if targetPlayer then
            kickPlayer(targetPlayer)
        else
            OrionLib:MakeNotification({
                Name = "Ошибка!",
                Content = "Игрок не найден!",
                Time = 3
            })
        end
    end
})

MainTab:AddButton({
	Name = "Невидимость😶‍🌫️",
	Callback = function()
if game.Players.LocalPlayer.Character:FindFirstChild("entered") == nil and game.Players.LocalPlayer.leaderstats.Slaps.Value >= 666 then
OGlove = game.Players.LocalPlayer.leaderstats.Glove.Value
fireclickdetector(workspace.Lobby.Ghost.ClickDetector)
game.ReplicatedStorage.Ghostinvisibilityactivated:FireServer()
fireclickdetector(workspace.Lobby[OGlove].ClickDetector)
task.wait(1)
for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
if v.Name  ~= "Humanoid" then
v.Transparency = 0
end
end
else
OrionLib:MakeNotification({Name = "Ошибка!",Content = "Ты должен быть в лобби и у тебя должно быть больше 666 шлепков",Image = "rbxassetid://7733658504",Time = 5})
end
  	end    
})


-- Вкладка "Исключения"
local ExclusionTab = Window:MakeTab({
    Name = "Исключения",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

for i = 1, 3 do
    ExclusionTab:AddTextbox({
        Name = "Исключение #" .. i,
        Default = "",
        TextDisappear = false,
        Callback = function(Value)
            Exclusions[i] = Value
        end
    })
end

-- Вкладка "ИМБА"
local ImbaTab = Window:MakeTab({
    Name = "ИМБА",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

ImbaTab:AddToggle({
    Name = "Авто-кик всех (по очереди, кроме исключений)",
    Default = false,
    Callback = function(Value)
        AutoKickEnabled = Value

        if AutoKickEnabled then
            task.spawn(function()
                while AutoKickEnabled do
                    if AutoKickRunning then 
                        task.wait(1) -- Ждём, если кик уже выполняется
                    else
                        AutoKickRunning = true
                        for _, player in ipairs(Players:GetPlayers()) do
                            if player ~= LocalPlayer and not table.find(Exclusions, player.Name) then
                                local leaderstats = LocalPlayer:FindFirstChild("leaderstats")
                                if leaderstats and leaderstats:FindFirstChild("Glove").Value == "Firework" then
                                    local character = LocalPlayer.Character
                                    local targetCharacter = player.Character
                                    if character and targetCharacter then
                                        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
                                        local targetRootPart = targetCharacter:FindFirstChild("HumanoidRootPart")
                                        if humanoidRootPart and targetRootPart then
                                            local originalPosition = humanoidRootPart.Position
                                            local targetOriginalPosition = targetRootPart.Position

                                            humanoidRootPart:PivotTo(CFrame.new(-824.0519, 298.5387, -1.9000) * CFrame.Angles(0, math.rad(-90), 0))
                                            targetRootPart:PivotTo(CFrame.new(-818.0519, 298.5387, -1.9000))

                                            task.wait(0.1)

                                            humanoidRootPart.Anchored = true
                                            targetRootPart.Anchored = true

                                            task.wait(0.3)
                                            ReplicatedStorage.GeneralAbility:FireServer()

                                            task.wait(3)
                                            humanoidRootPart.Anchored = false
                                            humanoidRootPart:PivotTo(CFrame.new(originalPosition))

                                            targetRootPart.Anchored = false
                                            targetRootPart:PivotTo(CFrame.new(targetOriginalPosition))

                                            task.wait(1) -- Немного ждем перед следующим киком
                                        end
                                    end
                                end
                            end
                        end
                        AutoKickRunning = false
                    end
                    task.wait(2) -- Ждем перед новой проверкой
                end
            end)
        end
    end
})
