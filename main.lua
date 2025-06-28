

local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/Articles-Hub/ROBLOXScript/refs/heads/main/Library/Orion/Source.lua')))()
local Window = OrionLib:MakeWindow({IntroText = "Slap Battles 👏", IntroIcon = "rbxassetid://15315284749",Name = ("ZybasHub - Slap Battles 👏".." | ".. identifyexecutor()),IntroToggleIcon = "rbxassetid://7734091286", HidePremium = false, SaveConfig = false, IntroEnabled = true, ConfigFolder = "slap battles"})

local function EquipGlove(Glove)
	for i, v in pairs(game:GetService("ReplicatedStorage")._NETWORK:GetChildren()) do
      -- Check if the name contains the character '{'
      if v.Name:find("{") then
          local args = {
              [1] = Glove,
			  [2] = true
          }
  
          -- Check if v is a RemoteEvent and can FireServer
          if v:IsA("RemoteEvent") then
              v:FireServer(unpack(args))
          elseif v:IsA("RemoteFunction") then
              -- If it's a RemoteFunction, use InvokeServer
              local result = v:InvokeServer(unpack(args))
              print("Result from InvokeServer:", result)  -- Optional: Print the result
          else
              print("v is neither a RemoteEvent nor a RemoteFunction.")
          end
      end
  end
end


local Tab = Window:MakeTab({
	Name = "Информация",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

Tab:AddLabel("Новый лучший скрипт!")
Tab:AddLabel("Милена шлюха")

Tab:AddButton({
	Name = "Закрыть меню",
	Callback = function()
      		OrionLib:Destroy()
  	end    
})
local Tab1 = Window:MakeTab({
	Name = "Перчи без бейджа",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})
local Section = Tab1:AddSection({
	Name = "Одиночные"
})
Tab1:AddTextbox({
    Name = "Перчатка: ",
    Default = "Glove",
    TextDisappear = false,
    Callback = function(Value)
        local targetAbbreviation = Value
        local GlovesDatabase = require(game.ReplicatedStorage.FRONTEND.Databases.Gloves) -- Загружаем базу данных перчаток
        foundGlove = nil

        for gloveName, gloveData in pairs(GlovesDatabase) do
            -- Проверяем, что AbilityType подходит и имя перчатки начинается с введённого текста
            if (gloveData.Type == "Badge") and
               string.sub(gloveName, 1, #targetAbbreviation):lower() == targetAbbreviation:lower() then
                foundGlove = gloveName
                break
            end
        end

        if foundGlove then
            OrionLib:MakeNotification({
                Name = "Успешно",
                Content = "Найдена перчатка: " .. foundGlove,
                Image = "rbxassetid://7733658504",
                Time = 5
            })
        else
            OrionLib:MakeNotification({
                Name = "Ошибка",
                Content = "Перчатка не найдена!",
                Image = "rbxassetid://7733658504",
                Time = 5
            })
        end
    end
})

Tab1:AddButton({
	Name = "Выдать перчатку",
	Callback = function()
      		EquipGlove(foundGlove)
  	end    
})
local Section1 = Tab1:AddSection({
	Name = "Все"
})
Tab1:AddButton({
	Name = "Выдать все бейдж перчатки",
	Callback = function()
      	local GlovesDatabase1 = require(game.ReplicatedStorage.FRONTEND.Databases.Gloves)
		for gloveName1, gloveData1 in pairs(GlovesDatabase1) do
            -- Проверяем, что AbilityType подходит и имя перчатки начинается с введённого текста
            if gloveData1.Type == "Badge" then
               EquipGlove(gloveName1)
            end
        end
  	end    
})

local Tab2 = Window:MakeTab({
	Name = "Феерверк кик",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})
local Section2 = Tab2:AddSection({
	Name = "Одиночный кик"
})

Tab2:AddTextbox({
	Name = "Юзернейм: ",
	Default = "Username",
	TextDisappear = false,
	Callback = function(Value)
local targetAbbreviation = Value
local targetPlayer
for _, v in pairs(game.Players:GetPlayers()) do
if string.sub(v.Name, 1, #targetAbbreviation):lower() == targetAbbreviation:lower() then
targetPlayer = v
break
end
end
if targetPlayer then
PlayerKickFirework = targetPlayer.Name
OrionLib:MakeNotification({Name = "Успешно",Content = "Найден игрок [ "..PlayerKickFirework.." ]",Image = "rbxassetid://7733658504",Time = 5})
else
OrionLib:MakeNotification({Name = "Ошибка",Content = "Игрок не найден",Image = "rbxassetid://7733658504",Time = 5})
end
	end	  
})
local AlreadyKicking = false
Tab2:AddButton({
	Name = "Кикнуть игрока",
	Callback = function()
      	if game.Players.LocalPlayer.leaderstats.Glove.Value == "Firework" then
			if game.Players:FindFirstChild(PlayerKickFirework) ~= nil then
			if AlreadyKicking == false then
				AlreadyKicking = true
				local portal = workspace.Lobby.brazil.portal
				portal.CanTouch = false

				local character = game.Players.LocalPlayer.Character
				local targetcharacter = game.Players:FindFirstChild(PlayerKickFirework).Character
				local targethrp = targetcharacter:FindFirstChild("HumanoidRootPart")
				local hrp = character:FindFirstChild("HumanoidRootPart")
				local originalhrp = hrp.CFrame
				local originaltargethrp = targethrp.CFrame


				task.spawn(function()
					hrp.CFrame = CFrame.new(portal.Position + Vector3.new(-5, -5, 0)) * CFrame.Angles(0, math.rad(-86.581), 0)
					wait(0.1)
					hrp.Anchored = true
				end)
				task.spawn(function()
					targethrp.CFrame = CFrame.new(portal.Position + Vector3.new(3, -5, 0)) * CFrame.Angles(0, math.rad(-86.581), 0)
					wait(0.1)
					targethrp.Anchored = true
				end)
				task.wait(0.3)
                game.ReplicatedStorage.GeneralAbility:FireServer()
				wait(3)
				hrp.Anchored = false
				targethrp.Anchored = false
				hrp.CFrame = originalhrp
				targethrp.CFrame = originaltargethrp
				AlreadyKicking = false
			else
				OrionLib:MakeNotification({Name = "Ошибка",Content = "Вы уже в процессе кика",Image = "rbxassetid://7733658504",Time = 5})
			end  
		else
			OrionLib:MakeNotification({Name = "Ошибка",Content = "Игрока нет на сервере",Image = "rbxassetid://7733658504",Time = 5})
		end
		else
			OrionLib:MakeNotification({Name = "Ошибка",Content = "У вас должен быть экипирован феерверк",Image = "rbxassetid://7733658504",Time = 5})
		end
  	end    
})

