-- Definicje usług systemowych
local Players = game:GetService("Players") 
--// GHA LOADING SCREEN UPGRADED
--// GAME HUB ARSENAL

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")

local player = Players.LocalPlayer

-- BLUR EFFECT
local blur = Instance.new("BlurEffect")
blur.Size = 0
blur.Parent = Lighting

TweenService:Create(blur, TweenInfo.new(0.6), {Size = 24}):Play()

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "GHA_Loading"
gui.IgnoreGuiInset = true
gui.ResetOnSpawn = false
gui.DisplayOrder = 999999
gui.Parent = player:WaitForChild("PlayerGui")

local bg = Instance.new("Frame")
bg.Size = UDim2.fromScale(1,1)
bg.BackgroundColor3 = Color3.fromRGB(6,8,14)
bg.BorderSizePixel = 0
bg.Parent = gui

-- STAR BACKGROUND
for i = 1, 60 do
	local s = Instance.new("Frame")
	s.Size = UDim2.new(0,2,0,2)
	s.Position = UDim2.new(math.random(),0,math.random(),0)
	s.BackgroundColor3 = Color3.fromRGB(180,220,255)
	s.BackgroundTransparency = math.random(4,9)/10
	s.BorderSizePixel = 0
	s.Parent = bg

	task.spawn(function()
		while s.Parent do
			s.Position = s.Position + UDim2.new(0,0,0.0003,0)
			if s.Position.Y.Scale > 1 then
				s.Position = UDim2.new(math.random(),0,0,0)
			end
			task.wait()
		end
	end)
end

-- CORNERS (NEON)
local function corner(x,y)
	local a = Instance.new("Frame")
	a.Size = UDim2.new(0,70,0,4)
	a.Position = UDim2.new(x,0,y,0)
	a.BackgroundColor3 = Color3.fromRGB(0,180,255)
	a.BorderSizePixel = 0
	a.Parent = bg

	local b = Instance.new("Frame")
	b.Size = UDim2.new(0,4,0,70)
	b.Position = UDim2.new(x,0,y,0)
	b.BackgroundColor3 = Color3.fromRGB(0,180,255)
	b.BorderSizePixel = 0
	b.Parent = bg
end

corner(0,0)
corner(1,0)
corner(0,1)
corner(1,1)

-- LOGO
local logo = Instance.new("TextLabel")
logo.BackgroundTransparency = 1
logo.Size = UDim2.new(1,0,0,90)
logo.Position = UDim2.new(0,0,0.28,0)
logo.Font = Enum.Font.GothamBlack
logo.Text = "GHA"
logo.TextColor3 = Color3.fromRGB(0,200,255)
logo.TextScaled = true
logo.Parent = bg

-- SPIN EFFECT (fake rotation animation)
task.spawn(function()
	while logo.Parent do
		logo.Rotation = logo.Rotation + 1
		task.wait()
	end
end)

local sub = Instance.new("TextLabel")
sub.BackgroundTransparency = 1
sub.Size = UDim2.new(1,0,0,40)
sub.Position = UDim2.new(0,0,0.41,0)
sub.Font = Enum.Font.GothamBold
sub.Text = "GAME HUB ARSENAL"
sub.TextColor3 = Color3.fromRGB(230,230,230)
sub.TextScaled = true
sub.Parent = bg

-- LOADING BAR
local barBG = Instance.new("Frame")
barBG.Size = UDim2.new(0,420,0,10)
barBG.Position = UDim2.new(0.5,-210,0.60,0)
barBG.BackgroundColor3 = Color3.fromRGB(25,25,35)
barBG.BorderSizePixel = 0
barBG.Parent = bg
Instance.new("UICorner", barBG)

local bar = Instance.new("Frame")
bar.Size = UDim2.new(0,0,1,0)
bar.BackgroundColor3 = Color3.fromRGB(0,200,255)
bar.BorderSizePixel = 0
bar.Parent = barBG
Instance.new("UICorner", bar)

local percent = Instance.new("TextLabel")
percent.BackgroundTransparency = 1
percent.Size = UDim2.new(1,0,0,25)
percent.Position = UDim2.new(0,0,1,5)
percent.Font = Enum.Font.GothamBold
percent.TextColor3 = Color3.fromRGB(255,255,255)
percent.TextScaled = true
percent.Text = "0%"
percent.Parent = barBG

-- TEXT STATUS (krócej + "TRWA")
local status = Instance.new("TextLabel")
status.BackgroundTransparency = 1
status.Size = UDim2.new(1,0,0,30)
status.Position = UDim2.new(0,0,0.52,0)
status.Font = Enum.Font.GothamMedium
status.TextScaled = true
status.TextColor3 = Color3.fromRGB(180,180,180)
status.Text = "TRWA ŁADOWANIE..."
status.Parent = bg

-- FAST LOADING (shorter)
for i = 1, 100 do
	bar.Size = UDim2.new(i/100,0,1,0)
	percent.Text = i.."%"

	if i < 30 then
		status.Text = "TRWA..."
	elseif i < 70 then
		status.Text = "ŁADOWANIE SYSTEMU..."
	else
		status.Text = "KOŃCZENIE..."
	end

	task.wait(0.01) -- krócej
end

status.Text = "GOTOWE"

-- OPEN TEXT
local open = Instance.new("TextLabel")
open.BackgroundTransparency = 1
open.Size = UDim2.new(1,0,0,40)
open.Position = UDim2.new(0,0,0.78,0)
open.Font = Enum.Font.GothamBold
open.Text = "Open [F]"
open.TextColor3 = Color3.fromRGB(0,200,255)
open.TextScaled = true
open.Parent = bg

-- BLINK
task.spawn(function()
	while open.Parent do
		TweenService:Create(open,TweenInfo.new(0.5),{TextTransparency=0.6}):Play()
		task.wait(0.5)
		TweenService:Create(open,TweenInfo.new(0.5),{TextTransparency=0}):Play()
		task.wait(0.5)
	end
end)

-- EXIT ON F
local UIS = game:GetService("UserInputService")
local closing = false

UIS.InputBegan:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.F and not closing then
		closing = true

		TweenService:Create(blur,TweenInfo.new(0.6),{Size=0}):Play()

		for _,v in pairs(bg:GetDescendants()) do
			if v:IsA("TextLabel") then
				TweenService:Create(v,TweenInfo.new(0.4),{TextTransparency=1}):Play()
			elseif v:IsA("Frame") then
				TweenService:Create(v,TweenInfo.new(0.4),{BackgroundTransparency=1}):Play()
			end
		end

		task.wait(0.6)
		gui:Destroy()
		blur:Destroy()
	end
end)

local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

local localPlayer = Players.LocalPlayer
local camera = workspace.CurrentCamera
local localChar = localPlayer.Character or localPlayer.CharacterAdded:Wait()

-- =============================================================================
-- KONFIGURACJA SYSTEMU
-- =============================================================================
local SystemActive = false 
local WallbangActive = false     
local NoclipActive = false       
local FlyActive = false          
local AutoTpActive = false       -- NOWOŚĆ: Stan automatycznego pętlowego TP
local NAZWA_SYSTEMU = "ROBLOX OMNI-SYSTEM v4.1"

local Config = {
    MaxDistance = 1200,         
    Hitbox = "Head",            
    FOVRadius = 200,            
    FlySpeed = 50                
}

local espObjects = {}
local chamsObjects = {}          
local whitelist = {}            
local shooting = false

localPlayer.CharacterAdded:Connect(function(newCharacter)
    localChar = newCharacter
    for _, hl in pairs(chamsObjects) do if hl then hl:Destroy() end end; table.clear(chamsObjects)
end)

-- =============================================================================
-- MENU STATUSU
-- =============================================================================
if CoreGui:FindFirstChild("OmniSystemGuiV4") then CoreGui["OmniSystemGuiV4"]:Destroy() end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "OmniSystemGuiV4"
screenGui.ResetOnSpawn = false 
screenGui.Parent = CoreGui 

local hudFrame = Instance.new("Frame")
hudFrame.Size = UDim2.new(0, 390, 0, 160) 
hudFrame.Position = UDim2.new(0.02, 0, 0.02, 0)
hudFrame.BackgroundColor3 = Color3.fromRGB(12, 14, 20)
hudFrame.BorderSizePixel = 0
hudFrame.Visible = false 
hudFrame.Parent = screenGui

Instance.new("UICorner", hudFrame).CornerRadius = UDim.new(0, 10)

local frameGradient = Instance.new("UIGradient")
frameGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(15, 22, 38)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(8, 10, 18))
})
frameGradient.Rotation = 45
frameGradient.Parent = hudFrame

local frameStroke = Instance.new("UIStroke")
frameStroke.Thickness = 2
frameStroke.Color = Color3.fromRGB(0, 180, 255)
frameStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
frameStroke.Parent = hudFrame

local hudLabel = Instance.new("TextLabel")
hudLabel.Size = UDim2.new(1, -140, 0, 30)
hudLabel.Position = UDim2.new(0, 15, 0, 5)
hudLabel.BackgroundTransparency = 1
hudLabel.Text = NAZWA_SYSTEMU .. " // <font color='rgb(75, 255, 75)'><b>ON</b></font>"
hudLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
hudLabel.Font = Enum.Font.GothamBold
hudLabel.TextSize = 13
hudLabel.RichText = true
hudLabel.TextXAlignment = Enum.TextXAlignment.Left
hudLabel.Parent = hudFrame

local windowControls = Instance.new("TextLabel")
windowControls.Size = UDim2.new(0, 50, 0, 30)
windowControls.Position = UDim2.new(1, -60, 0, 5)
windowControls.BackgroundTransparency = 1
windowControls.Text = "<b>—  ✕</b>"
windowControls.TextColor3 = Color3.fromRGB(120, 135, 155)
windowControls.Font = Enum.Font.GothamMedium
windowControls.TextSize = 14
windowControls.RichText = true
windowControls.TextXAlignment = Enum.TextXAlignment.Right
windowControls.Parent = hudFrame

local statusSubLabel = Instance.new("TextLabel")
statusSubLabel.Size = UDim2.new(1, -160, 0, 115)
statusSubLabel.Position = UDim2.new(0, 15, 0, 35)
statusSubLabel.BackgroundTransparency = 1
statusSubLabel.Text = "• Wallhack (U): <font color='rgb(255, 75, 75)'>OFF</font>\n• NoClip (N): <font color='rgb(255, 75, 75)'>OFF</font>\n• Latanie (X): <font color='rgb(255, 75, 75)'>OFF</font>\n• Auto-TP (T): <font color='rgb(255, 75, 75)'>OFF</font>\n• ESP: <font color='rgb(0, 255, 150)'>DYN. GRADIENT</font>"
statusSubLabel.TextColor3 = Color3.fromRGB(180, 195, 210)
statusSubLabel.Font = Enum.Font.GothamMedium
statusSubLabel.TextSize = 10
statusSubLabel.LineHeight = 1.4
statusSubLabel.RichText = true
statusSubLabel.TextXAlignment = Enum.TextXAlignment.Left
statusSubLabel.Parent = hudFrame

local keysInfoLabel = Instance.new("TextLabel")
keysInfoLabel.Size = UDim2.new(0, 145, 1, -16)
keysInfoLabel.Position = UDim2.new(1, -160, 0, 8)
keysInfoLabel.BackgroundColor3 = Color3.fromRGB(6, 8, 12)
keysInfoLabel.Text = " <b>LISTA KLAWISZY:</b>\n [F] Otwórz / Zamknij\n [P] Ignoruj cel\n [T] Auto TP (Pętla)\n [U] Wallhack (Ściany)\n [N] NoClip (Przenikanie)\n [X] Fly (Latanie)"
keysInfoLabel.TextColor3 = Color3.fromRGB(150, 170, 195)
keysInfoLabel.Font = Enum.Font.GothamMedium
keysInfoLabel.TextSize = 9
keysInfoLabel.LineHeight = 1.4
keysInfoLabel.RichText = true
keysInfoLabel.TextXAlignment = Enum.TextXAlignment.Left
keysInfoLabel.Parent = hudFrame
Instance.new("UICorner", keysInfoLabel).CornerRadius = UDim.new(0, 5)
Instance.new("UIStroke", keysInfoLabel).Color = Color3.fromRGB(25, 35, 50)

local fovCircle = nil
pcall(function()
    fovCircle = Drawing.new("Circle")
    fovCircle.Color = Color3.fromRGB(0, 180, 255)
    fovCircle.Thickness = 1
    fovCircle.Transparency = 0.40
    fovCircle.NumSides = 64
    fovCircle.Radius = Config.FOVRadius
    fovCircle.Filled = false
    fovCircle.Visible = false
end)

local function updateHud()
    if SystemActive then
        hudFrame.Visible = true
        if fovCircle then fovCircle.Visible = true end
    else
        hudFrame.Visible = false
        if fovCircle then fovCircle.Visible = false end
    end
    
    local wallStatus = WallbangActive and "<font color='rgb(75, 255, 75)'><b>AKTYWNY</b></font>" or "<font color='rgb(255, 75, 75)'>OFF</font>"
    local noclipStatus = NoclipActive and "<font color='rgb(75, 255, 75)'>AKTYWNY</font>" or "<font color='rgb(255, 75, 75)'>OFF</font>"
    local flyStatus = FlyActive and "<font color='rgb(75, 255, 75)'>AKTYWNE</font>" or "<font color='rgb(255, 75, 75)'>OFF</font>"
    local tpStatus = AutoTpActive and "<font color='rgb(0, 255, 150)'><b>ŚLEDZENIE</b></font>" or "<font color='rgb(255, 75, 75)'>OFF</font>"
    
    statusSubLabel.Text = "• Wallhack (U): " .. wallStatus .. "\n• NoClip (N): " .. noclipStatus .. "\n• Latanie (X): " .. flyStatus .. "\n• Auto-TP (T): " .. tpStatus .. "\n• ESP: <font color='rgb(0, 255, 150)'>DYN. GRADIENT</font>"
end

-- =============================================================================
-- LOGIKA SILNIKA
-- =============================================================================
local function isTargetVisible(targetPart)
    if WallbangActive then return true end 
    if not localChar then return false end
    local origin = camera.CFrame.Position
    local direction = targetPart.Position - origin
    
    local raycastParams = RaycastParams.new()
    raycastParams.FilterType = Enum.RaycastFilterType.Exclude
    raycastParams.FilterDescendantsInstances = {localChar, targetPart.Parent}
    raycastParams.IgnoreWater = true
    
    local result = workspace:Raycast(origin, direction, raycastParams)
    return result == nil
end

local function getBestTarget()
    local visibleTargets = {}
    local screenCenter = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 2)
    local localRoot = localChar and localChar:FindFirstChild("HumanoidRootPart")
    if not localRoot then return nil end

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= localPlayer and player.Character then
            if localPlayer.Team and player.Team and localPlayer.Team == player.Team then continue end
            if whitelist[player] then continue end
            
            local character = player.Character
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            local targetPart = character:FindFirstChild(Config.Hitbox)

            if humanoid and humanoid.Health > 0 and targetPart then
                local distance = (targetPart.Position - localRoot.Position).Magnitude
                if distance <= Config.MaxDistance then
                    local screenPos, onScreen = camera:WorldToViewportPoint(targetPart.Position)
                    
                    if onScreen or WallbangActive then
                        if isTargetVisible(targetPart) then
                            local mouseDist = (Vector2.new(screenPos.X, screenPos.Y) - screenCenter).Magnitude
                            local score = (mouseDist * 0.6) + (distance * 0.4)
                            table.insert(visibleTargets, {Part = targetPart, PriorityScore = score})
                        end
                    end
                end
            end
        end
    end

    if #visibleTargets > 0 then
        table.sort(visibleTargets, function(a, b) return a.PriorityScore < b.PriorityScore end)
        return visibleTargets[1].Part
    end
    return nil
end

-- Zwraca najbliższego żywego wroga do ciągłego TP
local function getNearestEnemyRoot()
    local localRoot = localChar and localChar:FindFirstChild("HumanoidRootPart")
    if not localRoot then return nil end
    local nearestRoot = nil
    local shortestDistance = math.huge

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= localPlayer and player.Character then
            if localPlayer.Team and player.Team and localPlayer.Team == player.Team then continue end
            if whitelist[player] then continue end
            local character = player.Character
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            local enemyRoot = character:FindFirstChild("HumanoidRootPart")
            if humanoid and humanoid.Health > 0 and enemyRoot then
                local distance = (enemyRoot.Position - localRoot.Position).Magnitude
                if distance < shortestDistance then
                    shortestDistance = distance
                    nearestRoot = enemyRoot
                end
            end
        end
    end
    return nearestRoot
end

local function applyChams(player, targetPart, isClosest)
    if not chamsObjects[player] then
        local highlight = Instance.new("Highlight")
        highlight.Name = "SystemChams"
        highlight.FillTransparency = 0.5
        highlight.OutlineTransparency = 0.2
        highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        chamsObjects[player] = highlight
    end

    local hl = chamsObjects[player]
    if player.Character and player.Character:IsA("Model") then
        hl.Parent = player.Character
        if whitelist[player] then
            hl.FillColor = Color3.fromRGB(180, 50, 255)   
        elseif isClosest then
            hl.FillColor = Color3.fromRGB(0, 230, 255)    
        else
            hl.FillColor = Color3.fromRGB(255, 40, 40)    
        end
        hl.Enabled = true
    end
end

local function updateESP(closestTargetPart)
    if not SystemActive then
        for _, hl in pairs(chamsObjects) do if hl then hl:Destroy() end end; table.clear(chamsObjects)
        for _, obj in pairs(espObjects) do
            if obj.Box then obj.Box.Visible = false end
            if obj.Line then obj.Line.Visible = false end
            if obj.HealthBarBg then obj.HealthBarBg.Visible = false end
            if obj.HealthBar then obj.HealthBar.Visible = false end
        end
        return
    end

    local screenCenter = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 2)
    local localRoot = localChar and localChar:FindFirstChild("HumanoidRootPart")

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= localPlayer and player.Character then
            local isTeammate = localPlayer.Team and player.Team and localPlayer.Team == player.Team

            if not isTeammate then
                if not espObjects[player] then
                    pcall(function()
                        espObjects[player] = {
                            Box = Drawing.new("Square"),
                            Line = Drawing.new("Line"),
                            HealthBarBg = Drawing.new("Square"),
                            HealthBar = Drawing.new("Square")
                        }
                    end)
                end

                local esp = espObjects[player]
                local rootPart = player.Character:FindFirstChild("HumanoidRootPart")
                local humanoid = player.Character:FindFirstChildOfClass("Humanoid")

                if esp and rootPart and humanoid and humanoid.Health > 0 and localRoot then
                    local isClosest = (closestTargetPart and closestTargetPart.Parent == player.Character)
                    applyChams(player, closestTargetPart, isClosest)

                    local screenPos, onScreen = camera:WorldToViewportPoint(rootPart.Position)
                    if onScreen then
                        local distance = (rootPart.Position - localRoot.Position).Magnitude
                        local factor = math.clamp(distance / Config.MaxDistance, 0, 1)
                        
                        local dynamicColor = Color3.fromRGB(
                            255 * factor, 
                            180 * (1 - factor), 
                            255 * (1 - factor)
                        )
                        
                        if whitelist[player] then dynamicColor = Color3.fromRGB(180, 50, 255) end
                        local thickness = isClosest and 2 or 1

                        local boxSize = Vector2.new(1200 / screenPos.Z, 1800 / screenPos.Z)
                        local boxPos = Vector2.new(screenPos.X - boxSize.X / 2, screenPos.Y - boxSize.Y / 2)

                        if esp.Box then
                            esp.Box.Size = boxSize
                            esp.Box.Position = boxPos
                            esp.Box.Color = dynamicColor
                            esp.Box.Thickness = thickness
                            esp.Box.Visible = true
                        end

                        if esp.HealthBarBg then
                            esp.HealthBarBg.Size = Vector2.new(4, boxSize.Y)
                            esp.HealthBarBg.Position = Vector2.new(boxPos.X - 6, boxPos.Y)
                            esp.HealthBarBg.Color = Color3.fromRGB(40, 40, 40)
                            esp.HealthBarBg.Filled = true
                            esp.HealthBarBg.Visible = true
                        end

                        if esp.HealthBar then
                            local healthPercent = math.clamp(humanoid.Health / humanoid.MaxHealth, 0, 1)
                            esp.HealthBar.Size = Vector2.new(4, boxSize.Y * healthPercent)
                            esp.HealthBar.Position = Vector2.new(boxPos.X - 6, boxPos.Y + (boxSize.Y * (1 - healthPercent)))
                            esp.HealthBar.Color = Color3.fromRGB(0, 255, 100)
                            esp.HealthBar.Filled = true
                            esp.HealthBar.Visible = true
                        end

                        if esp.Line then
                            esp.Line.From = screenCenter
                            esp.Line.To = Vector2.new(screenPos.X, screenPos.Y)
                            esp.Line.Color = dynamicColor
                            esp.Line.Thickness = thickness
                            esp.Line.Visible = not whitelist[player]
                        end
                    else
                        if esp.Box then esp.Box.Visible = false end
                        if esp.Line then esp.Line.Visible = false end
                        if esp.HealthBarBg then esp.HealthBarBg.Visible = false end
                        if esp.HealthBar then esp.HealthBar.Visible = false end
                    end
                end
            else
                if espObjects[player] then
                    espObjects[player].Box.Visible = false
                    espObjects[player].Line.Visible = false
                    espObjects[player].HealthBarBg.Visible = false
                    espObjects[player].HealthBar.Visible = false
                end
            end
        end
    end
end

local function getPlayerUnderMouse()
    local mousePos = UserInputService:GetMouseLocation()
    local ray = camera:ViewportPointToRay(mousePos.X, mousePos.Y)
    local raycastParams = RaycastParams.new()
    raycastParams.FilterType = Enum.RaycastFilterType.Exclude
    raycastParams.FilterDescendantsInstances = {localChar}
    local result = workspace:Raycast(ray.Origin, ray.Direction * 1000, raycastParams)
    if result and result.Instance then
        local model = result.Instance:FindFirstAncestorOfClass("Model")
        if model then return Players:GetPlayerFromCharacter(model) end
    end
    return nil
end

-- =============================================================================
-- KLAWISZE
-- =============================================================================
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == Enum.KeyCode.F then
        SystemActive = not SystemActive
        if not SystemActive then
            WallbangActive = false
            NoclipActive = false
            FlyActive = false
            AutoTpActive = false
            for _, hl in pairs(chamsObjects) do if hl then hl:Destroy() end end; table.clear(chamsObjects)
        end
        updateHud()
    end 
    
    if not SystemActive then return end

    if input.KeyCode == Enum.KeyCode.P then
        local targetPlayer = getPlayerUnderMouse()
        if targetPlayer then
            if whitelist[targetPlayer] then whitelist[targetPlayer] = nil else whitelist[targetPlayer] = true end
        end
    elseif input.KeyCode == Enum.KeyCode.T then -- Klawisz T: Włącza/Wyłącza pętlowe automatyczne TP
        AutoTpActive = not AutoTpActive
        updateHud()
    elseif input.KeyCode == Enum.KeyCode.U then
        WallbangActive = not WallbangActive
        updateHud()
    elseif input.KeyCode == Enum.KeyCode.N then
        NoclipActive = not NoclipActive
        updateHud()
    elseif input.KeyCode == Enum.KeyCode.X then 
        FlyActive = not FlyActive
        updateHud()
    end
end)

-- =============================================================================
-- FIZYKA & AKTUALIZACJA CO KLATKĘ (NOCLIP, FLY, AUTOMATYCZNE TP)
-- =============================================================================
RunService.Stepped:Connect(function()
    if not SystemActive or not localChar then return end
    
    local root = localChar:FindFirstChild("HumanoidRootPart")
    local humanoid = localChar:FindFirstChildOfClass("Humanoid")
    if not root or not humanoid then return end

    -- NOWOŚĆ: Logika automatycznego TP (Pętla) - Ma najwyższy priorytet nad ruchem
    if AutoTpActive then
        local targetEnemyRoot = getNearestEnemyRoot()
        if targetEnemyRoot then
            -- Przykleja Cię dokładnie 3 jednostki za plecami wroga, patrząc w tę samą stronę
            root.CFrame = targetEnemyRoot.CFrame * CFrame.new(0, 0, 3)
            root.Velocity = Vector3.zero -- Reset prędkości, żeby nie rzucało postacią
        end
    end

    -- Fizyka NoClip (Aktywna automatycznie również podczas Auto-TP, żeby nie blokować się w ścianach)
    if NoclipActive or AutoTpActive then
        for _, part in ipairs(localChar:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
    end
    
    -- Mechanika Fly (Działa tylko, gdy Auto-TP jest wyłączone)
    if FlyActive and not AutoTpActive then
        humanoid.PlatformStand = true
        local moveDirection = Vector3.zero
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDirection = moveDirection + camera.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDirection = moveDirection - camera.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDirection = moveDirection - camera.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDirection = moveDirection + camera.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then moveDirection = moveDirection + Vector3.new(0, 1, 0) end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then moveDirection = moveDirection - Vector3.new(0, 1, 0) end
        root.Velocity = moveDirection.Unit * Config.FlySpeed
        if moveDirection == Vector3.zero then root.Velocity = Vector3.zero end
    else
        if not AutoTpActive and humanoid.PlatformStand then humanoid.PlatformStand = false end
    end
end)

-- Główna pętla wykonawcza (Aimbot)
RunService.RenderStepped:Connect(function()
    local screenCenter = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 2)
    if fovCircle then fovCircle.Position = screenCenter end
    
    if SystemActive then
        local targetPart = getBestTarget()
        updateESP(targetPart)
        
        if shooting and camera then
            camera.CoordinateFrame = CFrame.new(camera.Focus.Position) * (camera.CoordinateFrame - camera.CoordinateFrame.Position)
        end
        
        if targetPart then
            camera.CFrame = CFrame.new(camera.CFrame.Position, targetPart.Position)
            if not shooting then
                shooting = true
                task.spawn(function()
                    VirtualInputManager:SendMouseButtonEvent(screenCenter.X, screenCenter.Y, 0, true, game, 0)
                    task.wait(0.01)
                    VirtualInputManager:SendMouseButtonEvent(screenCenter.X, screenCenter.Y, 0, false, game, 0)
                    shooting = false
                end)
            end
        end
    else
        updateESP(nil)
    end
end)
