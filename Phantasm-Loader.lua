if game.GameId == 3808081382 then
  loadstring(game:HttpGet("https://raw.githubusercontent.com/ATrainz/main/main/TSB.lua"))()
elseif game.GameId == 5868588140 then
  loadstring(game:HttpGet("https://raw.githubusercontent.com/ATrainz/main/main/RealmRampage.lua"))()
else
  game:GetService("StarterGui"):SetCore("SendNotification", {Title = "(PHANTASM)", Text = "This game is not supported.", Duration = 10})
end