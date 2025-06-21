local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/Articles-Hub/ROBLOXScript/refs/heads/main/Library/Orion/Source.lua')))()
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer

local Window = OrionLib:MakeWindow({Name = "Кикер v767", HidePremium = false, SaveConfig = false})

local SelectedUsername = ""
local Exclusions = {} -- Список исключений
local AutoKickRunning = false -- Флаг, чтобы избежать одновременного кика нескольких игроков

local url = "https://raw.githubusercontent.com/Bendyshechka/fireworkkick/refs/heads/main/players.lua"
local success, response = pcall(function()
    return loadstring(game:HttpGet(url))()
end)

if success then
    Exclusions = response
    print("Список исключённых игроков загружен!")
    for _, player in pairs(Exclusions) do
        print("Исключённый игрок:", player)
        OrionLib:MakeNotification({
            Name = "Загружено исключение",
            Content = "Игрок " .. player .. " добавлен в исключения",
            Time = 5
        })
    end
else
    warn("Ошибка загрузки исключений:", response)
    OrionLib:MakeNotification({
        Name = "Ошибка загрузки",
        Content = "Не удалось загрузить исключённые имена!",
        Time = 5
    })
end

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
               local originalCFrame = humanoidRootPart.CFrame
                                        local targetOriginalCFrame = targetRootPart.CFrame

                                        humanoidRootPart:PivotTo(CFrame.new(-930.0519, 298.5387, -1.9000) * CFrame.Angles(0, math.rad(-90), 0))
                                        targetRootPart:PivotTo(CFrame.new(-926.0519, 298.5387, -1) * CFrame.Angles(0, math.rad(-90), 0))

                                        task.wait(0.1)
                                        humanoidRootPart.Anchored = true
                                        targetRootPart.Anchored = true

                                        task.wait(0.3)
                                        ReplicatedStorage.GeneralAbility:FireServer()

                                        task.wait(3)
                                        humanoidRootPart.Anchored = false
                                        humanoidRootPart:PivotTo(originalCFrame)

                                        targetRootPart.Anchored = false
                                        targetRootPart:PivotTo(targetOriginalCFrame)
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
            OrionLib:MakeNotification({
                Name = "Ошибка!",
                Content = "Ты должен быть в лобби и у тебя должно быть больше 666 шлепков",
                Image = "rbxassetid://7733658504",
                Time = 5
            })
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
    if AutoKickRunning then return end
    AutoKickRunning = true 

    if #Players:GetPlayers() > 1 then
        workspace.Lobby.Firework.ClickDetector.MaxActivationDistance = 1000
        fireclickdetector(workspace.Lobby.Firework.ClickDetector)
        task.spawn(function()
            while AutoKickRunning do
                for _, player in ipairs(Players:GetPlayers()) do
                    if player ~= LocalPlayer then
                        local isExcluded = false
                        for _, name in ipairs(Exclusions) do
                            if string.lower(player.Name) == string.lower(name) then
                                isExcluded = true
                                break
                            end
                        end

                        if not isExcluded then
                            local leaderstats = LocalPlayer:FindFirstChild("leaderstats")
                            if leaderstats and leaderstats:FindFirstChild("Glove").Value == "Firework" then
                                local character = LocalPlayer.Character
                                local targetCharacter = player.Character
                                if character and targetCharacter then
                                    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
                                    local targetRootPart = targetCharacter:FindFirstChild("HumanoidRootPart")
                                    if humanoidRootPart and targetRootPart then
                                        local originalCFrame = humanoidRootPart.CFrame
                                        local targetOriginalCFrame = targetRootPart.CFrame

                                        humanoidRootPart:PivotTo(CFrame.new(-822.0519, 298.5387, -1.9000) * CFrame.Angles(0, math.rad(-90), 0))
                                        targetRootPart:PivotTo(CFrame.new(-818.0519, 298.5387, -1) * CFrame.Angles(0, math.rad(-90), 0))

                                        task.wait(0.1)
                                        humanoidRootPart.Anchored = true
                                        targetRootPart.Anchored = true

                                        task.wait(0.3)
                                        ReplicatedStorage.GeneralAbility:FireServer()

                                        task.wait(3)
                                        humanoidRootPart.Anchored = false
                                        humanoidRootPart:PivotTo(originalCFrame)

                                        targetRootPart.Anchored = false
                                        targetRootPart:PivotTo(targetOriginalCFrame)

                                        task.wait(2)
                                    end
                                end
                            end
                        end
                    end
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
        else
            AutoKickRunning = false
        end
    end
})

ImbaTab:AddToggle({
    Name = "Боксёр фарм & Авто-кик",
    Default = false,
    Callback = function(Value)
        if Value then
            task.spawn(function()
                local alreadySwitched = false
                local boxingLoopRunning = false

                while true do
                    local playersLeft = {}

                    for _, player in ipairs(Players:GetPlayers()) do
                        local isExcluded = false
                        for _, name in ipairs(Exclusions) do
                            if string.lower(player.Name) == string.lower(name) then
                                isExcluded = true
                                break
                            end
                        end

                        if player ~= LocalPlayer and not isExcluded then
                            table.insert(playersLeft, player)
                        end
                    end

                    if #playersLeft > 0 then
                        -- Если есть игроки (кроме исключений), проверяем, что у нас Firework
                        if LocalPlayer.leaderstats.Glove.Value ~= "Firework" then
                            repeat
                                workspace.Lobby.Firework.ClickDetector.MaxActivationDistance = 1000
                                fireclickdetector(workspace.Lobby.Firework.ClickDetector)
                                task.wait(1)
                            until LocalPlayer.leaderstats.Glove.Value == "Firework"
                        end
                        StartAutoKick()
                        alreadySwitched = false
                        
                        -- Останавливаем цикл удара боксёром, если он работал
                        boxingLoopRunning = false
                    elseif #playersLeft == 0 and not alreadySwitched then
                        -- Если остался только я и исключённые игроки, переключаемся на "Боксёр"
                        repeat
                            workspace.Lobby.Boxer.ClickDetector.MaxActivationDistance = 1000
                            fireclickdetector(workspace.Lobby.Boxer.ClickDetector)
                            task.wait(1)
                        until LocalPlayer.leaderstats.Glove.Value == "Boxer"

                        alreadySwitched = true
                        
                        -- Запускаем бесконечный цикл удара, если он ещё не работает
                        if not boxingLoopRunning then
                            boxingLoopRunning = true
                            task.spawn(function()
                                while boxingLoopRunning do
                                    game:GetService("ReplicatedStorage").Events.Boxing:FireServer(game.Players.LocalPlayer.Character.HumanoidRootPart)
                                    task.wait(0.001)
                                end
                            end)
                        end
                    end

                    task.wait(1)
                end
            end)
        end
    end
})



OrionLib:Init()
