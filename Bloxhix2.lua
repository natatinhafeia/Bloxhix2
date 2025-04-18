-- Função de introdução já mantida conforme solicitado

local introText = "BY HIXDOW"
local gui = Instance.new("ScreenGui")
gui.Name = "CustomGUI"
gui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Função para mostrar a animação de introdução
local function showIntro()
    local introLabel = Instance.new("TextLabel")
    introLabel.Text = introText
    introLabel.Font = Enum.Font.GothamBold
    introLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
    introLabel.BackgroundTransparency = 1
    introLabel.Size = UDim2.new(0, 500, 0, 100)
    introLabel.Position = UDim2.new(0.5, -250, 0.5, -50)
    introLabel.Parent = gui

    -- Animação
    for i = 1, 3 do
        introLabel.TextColor3 = Color3.fromRGB(255, math.random(0, 255), math.random(0, 255))
        wait(0.5)
    end
    introLabel:TweenPosition(UDim2.new(0.5, -250, 0.5, -150), "Out", "Sine", 1, true)
    wait(1)
    introLabel:Destroy()
end

-- Chama a função de introdução ao iniciar
showIntro()

-- Função para criar botões
local function createButton(name, position, size, callback)
    local button = Instance.new("TextButton")
    button.Name = name
    button.Text = name
    button.Size = size
    button.Position = position
    button.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    button.TextColor3 = Color3.fromRGB(0, 255, 255)
    button.Font = Enum.Font.Gotham
    button.Parent = gui

    button.MouseButton1Click:Connect(callback)
    return button
end

-- Função de Teleporte para Ilha (sem alterações)
local function teleportToIsland(islandName)
    -- Dicionário de ilhas e suas posições
    local islands = {
        ["Starter Island"] = CFrame.new(100, 50, 100),
        ["Blox Fruits Island"] = CFrame.new(200, 50, 200),
        ["Sky Island"] = CFrame.new(300, 50, 300),
        ["Frozen Island"] = CFrame.new(400, 50, 400),
        ["Magma Island"] = CFrame.new(500, 50, 500),
    }

    if islands[islandName] then
        game.Players.LocalPlayer.Character:SetPrimaryPartCFrame(islands[islandName])
        print("Teleportando para " .. islandName)
    else
        print("Ilha não encontrada.")
    end
end

-- Função de Auto Farm
local function autoFarm()
    autoFarmEnabled = not autoFarmEnabled
    local button = script.Parent:FindFirstChild("Auto Farm")
    button.BackgroundColor3 = autoFarmEnabled and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)

    if autoFarmEnabled then
        -- Lógica para farm automático de NPCs
        while autoFarmEnabled do
            local npc = game.Workspace:FindFirstChild("NPC_Name") -- Troque "NPC_Name" pelo nome do NPC
            if npc then
                -- Se o NPC for encontrado, atacar e farmar
                game.Players.LocalPlayer.Character:FindFirstChild("Humanoid"):MoveTo(npc.Position)
                
                -- Aumentando a hitbox do NPC (dependendo da lógica do jogo, talvez seja necessário um ajuste na hitbox)
                local npcHumanoid = npc:FindFirstChild("Humanoid")
                if npcHumanoid then
                    npcHumanoid.HipWidth = 5  -- Exemplo de aumento da hitbox
                    npcHumanoid.HipHeight = 5
                end

                -- Clicar no botão 1 para dar socos (supondo que a habilidade de soco é associada à tecla "1")
                local player = game.Players.LocalPlayer
                local mouse = player:GetMouse()

                -- Clicar no botão 1 automaticamente
                while autoFarmEnabled and npc.Parent do
                    mouse.KeyDown:Connect(function(key)
                        if key == "1" then
                            -- Executar o soco
                            local humanoid = player.Character:FindFirstChild("Humanoid")
                            if humanoid then
                                humanoid:MoveTo(npc.Position)
                            end
                        end
                    end)
                    wait(1)
                end
            end
            wait(1)
        end
    else
        print("Auto Farm Desativado")
    end
end

-- Função de Auto Kill Boss (sem alterações)
local function autoKillBoss()
    autoKillBossEnabled = not autoKillBossEnabled
    local button = script.Parent:FindFirstChild("Auto Kill Boss")
    button.BackgroundColor3 = autoKillBossEnabled and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)

    if autoKillBossEnabled then
        -- Lógica de Auto Kill Boss
        while autoKillBossEnabled do
            local boss = game.Workspace:FindFirstChild("Boss_Name") -- Troque "Boss_Name" pelo nome do boss
            if boss then
                -- Se o boss for encontrado, move até ele e começa a lutar
                game.Players.LocalPlayer.Character:FindFirstChild("Humanoid"):MoveTo(boss.Position)
                -- Ataque repetido até derrotar o boss
                repeat
                    -- Implementação de dano
                    game.Players.LocalPlayer.Character:FindFirstChild("Humanoid"):TakeDamage(10) -- Exemplo de dano
                    wait(1)
                until not boss.Parent
            end
            wait(1)
        end
    else
        print("Auto Kill Boss Desativado")
    end
end

-- Função de Auto Fruit Spin (sem alterações)
local function autoFruitSpin()
    autoFruitSpinEnabled = not autoFruitSpinEnabled
    local button = script.Parent:FindFirstChild("Auto Fruit Spin")
    button.BackgroundColor3 = autoFruitSpinEnabled and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)

    if autoFruitSpinEnabled then
        -- Lógica para girar frutas automaticamente
        while autoFruitSpinEnabled do
            game.ReplicatedStorage.Remotes.SpinFruit:FireServer()
            wait(5) -- Aguarda 5 segundos entre as tentativas de girar
        end
    else
        print("Auto Fruit Spin Desativado")
    end
end

-- Função para tornar a GUI móvel e adicionar a barra de título "BY HIXDOW"
local function makeGuiDraggable()
    local dragging = false
    local dragInput, mousePos, framePos

    -- Detectando eventos de toque para dispositivos móveis
    gui.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragInput = input
            mousePos = input.Position
            framePos = gui.Position
        end
    end)

    gui.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - mousePos
            gui.Position = UDim2.new(framePos.X.Scale, framePos.X.Offset + delta.X, framePos.Y.Scale, framePos.Y.Offset + delta.Y)
        end
    end)

    gui.InputEnded:Connect(function(input)
        if input == dragInput then
            dragging = false
        end
    end)
end

-- Criando a barra de título "BY HIXDOW"
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 30)
titleBar.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
titleBar.BackgroundTransparency = 0.5
titleBar.Position = UDim2.new(0, 0, 0, 0)
titleBar.Parent = gui

local titleLabel = Instance.new("TextLabel")
titleLabel.Text = "BY HIXDOW"
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
titleLabel.Size = UDim2.new(1, 0, 1, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Parent = titleBar

-- Criando os botões na GUI
createButton("Auto Kill Boss", UDim2.new(0.5, -150, 0.4, -25), UDim2.new(0, 300, 0, 50), autoKillBoss)
createButton("Auto Farm", UDim2.new(0.5, -150, 0.5, -25), UDim2.new(0, 300, 0, 50), autoFarm)
createButton("Auto Fruit Spin", UDim2.new(0.5, -150, 0.6, -25), UDim2.new(0, 300, 0, 50), autoFruitSpin)

-- Tornando a GUI móvel
makeGuiDraggable()
