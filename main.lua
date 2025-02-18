local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/Bendyshechka/fireworkkick/refs/heads/main/Library')))()
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer

local Window = OrionLib:MakeWindow({Name = "Кикер", HidePremium = false, SaveConfig = false})

local SelectedUsername = ""
local Exclusions = {"", "", ""} -- Список исключений
local AutoKickRunning = false -- Флаг, чтобы избежать одновременного кика нескольких игроков

-- Вкладка "Главное"
local MainTab = Window:MakeTab({
    Name = "Главное",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local UsernameBox = MainTab:AddTextbox({
    Name = "Юзернейм:",
    Default = "",
    TextDisappear = false,
    Callback = function(Value)
        SelectedUsername = Value
    end
})

MainTab:AddButton({
    Name = "КИК!",
    Callback = function()
        local targetPlayer = Players:FindFirstChild(SelectedUsername)
        if not targetPlayer or targetPlayer == LocalPlayer then return end

        local leaderstats = LocalPlayer:FindFirstChild("leaderstats")
        if not leaderstats or leaderstats:FindFirstChild("Glove").Value ~= "Firework" then
            OrionLib:MakeNotification({
                Name = "Ошибка",
                Content = "Нужен экипированный фейерверк!",
                Time = 3
            })
            return
        end

        local character = LocalPlayer.Character
        local targetCharacter = targetPlayer.Character
        if character and targetCharacter then
            local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
            local targetRootPart = targetCharacter:FindFirstChild("HumanoidRootPart")
            if humanoidRootPart and targetRootPart then
                local originalPosition = humanoidRootPart.Position
                local targetOriginalPosition = targetRootPart.Position

                humanoidRootPart.Position = Vector3.new(-824.0519, 298.5387, -1.9000)
                targetRootPart.Position = Vector3.new(-818.0519, 298.5387, -1.9000)

                task.wait(0.1)
                humanoidRootPart.Anchored = true
                targetRootPart.Anchored = true

                task.wait(0.3)
                ReplicatedStorage.GeneralAbility:FireServer()

                task.wait(3)
                humanoidRootPart.Anchored = false
                humanoidRootPart.Position = originalPosition

                targetRootPart.Anchored = false
                targetRootPart.Position = targetOriginalPosition
            end
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
else
OrionLib:MakeNotification({Name = "Ошибка!",Content = "Ты должен быть в лобби и у тебя должно быть больше 666 шлепков",Image = "rbxassetid://7733658504",Time = 5})
end
  	end    
})

-- Вкладка "Исключения"
local ExclusionsTab = Window:MakeTab({
    Name = "Исключения",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

for i = 1, 3 do
    ExclusionsTab:AddTextbox({
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

local function StartAutoKick()
    if #Players:GetPlayers() > 1 then
        workspace.Lobby.Firework.ClickDetector.MaxActivationDistance = 1000
        fireclickdetector(workspace.Lobby.Firework.ClickDetector)
        task.spawn(function()
            while true do
                if AutoKickRunning then
					return
                else
                    AutoKickRunning = true
                    for _, player in ipairs(Players:GetPlayers()) do
                        if player ~= LocalPlayer then
                            local leaderstats = LocalPlayer:FindFirstChild("leaderstats")
                            if leaderstats and leaderstats:FindFirstChild("Glove").Value == "Firework" then
                                local character = LocalPlayer.Character
                                local targetCharacter = player.Character
                                if character and targetCharacter then
                                    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
                                    local targetRootPart = targetCharacter:FindFirstChild("HumanoidRootPart")
                                    if humanoidRootPart and targetRootPart then
                                        local originalPosition = humanoidRootPart.Position
                                        local targetOriginalPosition = targetRootPart.CFrame
                                        local originalCFrame = humanoidRootPart.CFrame

                                        -- Телепортируем локального игрока и поворачиваем его на -90 градусов
                                        humanoidRootPart:PivotTo(CFrame.new(-824.0519, 298.5387, -1.9000) * CFrame.Angles(0, math.rad(-90), 0))
                                        targetRootPart:PivotTo(CFrame.new(-818.0519, 298.5387, 0.69000))

                                        task.wait(0.1)
                                        humanoidRootPart.Anchored = true
                                        targetRootPart.Anchored = true

                                        task.wait(0.3)
                                        ReplicatedStorage.GeneralAbility:FireServer()

                                        task.wait(3)
                                        humanoidRootPart.Anchored = false
                                        humanoidRootPart:PivotTo(originalCFrame) -- Возвращаем игрока в исходное положение

                                        targetRootPart.Anchored = false
                                        targetRootPart:PivotTo(targetOriginalPosition)

                                        task.wait(1)
                                    end
                                end
                            end
                        end
                    end
                    AutoKickRunning = false
                end
                task.wait(2)
            end
        end)
    end
end


ImbaTab:AddToggle({
    Name = "Авто-кик всех (по очереди, кроме исключений)",
    Default = false,
    Callback = function(Value)
        if Value then
            StartAutoKick()
        end
    end
})

ImbaTab:AddToggle({
    Name = "Боксёр фарм & Авто-кик",
    Default = false,
    Callback = function(Value)
        if Value then
            task.spawn(function()
                while true do
                    local playersLeft = {}

                    for _, player in ipairs(Players:GetPlayers()) do
                        if player ~= LocalPlayer and not table.find(Exclusions, player.Name) then
                            table.insert(playersLeft, player)
                        end
                    end

                    if #Players:GetPlayers() > 1 then
                        StartAutoKick()
                    elseif #Players:GetPlayers() == 1 then
                        workspace.Lobby.Boxer.ClickDetector.MaxActivationDistance = 1000
                        fireclickdetector(workspace.Lobby.Boxer)
                    end

                    task.wait(1)
                end
            end)
        end
    end
})

OrionLib:Init()
