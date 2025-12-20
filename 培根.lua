local function loadScript()
    if not game:IsLoaded() then game.Loaded:Wait() end
    
    -- 获取服务
    local Services = {
        Players = game:GetService("Players"),
        RunService = game:GetService("RunService"), 
        UserInputService = game:GetService("UserInputService"),
        TweenService = game:GetService("TweenService"),
        Workspace = game:GetService("Workspace"),
        CoreGui = game:GetService("CoreGui"),
        Lighting = game:GetService("Lighting"),
        SoundService = game:GetService("SoundService")
    }
    
    local Players, RunService, UserInputService, TweenService, Workspace, CoreGui, Lighting, SoundService = 
        Services.Players, Services.RunService, Services.UserInputService, Services.TweenService, 
        Services.Workspace, Services.CoreGui, Services.Lighting, Services.SoundService
    
    local LocalPlayer = Players.LocalPlayer
    if not LocalPlayer then
        Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
        LocalPlayer = Players.LocalPlayer
    end

    -- 创建UI
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "BaconScriptGUI_" .. math.random(10000,99999)
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.Parent = CoreGui
    
    -- 主窗口（改小尺寸）
    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 700, 0, 450) -- 改小尺寸
    MainFrame.Position = UDim2.new(0.5, -350, 0.5, -225)
    MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 60)
    MainFrame.BackgroundTransparency = 0.1
    MainFrame.BorderSizePixel = 0
    MainFrame.Active = true
    MainFrame.Draggable = true
    MainFrame.Visible = false
    MainFrame.Parent = ScreenGui
    
    -- 添加阴影效果
    local Shadow = Instance.new("ImageLabel")
    Shadow.Size = UDim2.new(1, 20, 1, 20)
    Shadow.Position = UDim2.new(0, -10, 0, -10)
    Shadow.BackgroundTransparency = 1
    Shadow.Image = "rbxassetid://5554236805"
    Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    Shadow.ImageTransparency = 0.7
    Shadow.ScaleType = Enum.ScaleType.Slice
    Shadow.SliceCenter = Rect.new(10, 10, 118, 118)
    Shadow.Parent = MainFrame
    
    -- 增强圆角效果
    local MainCorner = Instance.new("UICorner", MainFrame)
    MainCorner.CornerRadius = UDim.new(0, 16) -- 增强圆角
    
    local MainStroke = Instance.new("UIStroke", MainFrame)
    MainStroke.Color = Color3.fromRGB(0, 150, 255)
    MainStroke.Thickness = 2
    
    -- 背景图片（保留原本UI背景）
    local BackgroundImage = Instance.new("ImageLabel")
    BackgroundImage.Size = UDim2.new(1, 0, 1, 0)
    BackgroundImage.BackgroundTransparency = 1
    BackgroundImage.Image = "rbxassetid://89036103941643"
    BackgroundImage.ImageTransparency = 0.3
    BackgroundImage.ScaleType = Enum.ScaleType.Crop
    BackgroundImage.ZIndex = 1
    Instance.new("UICorner", BackgroundImage).CornerRadius = UDim.new(0, 16)
    BackgroundImage.Parent = MainFrame
    
    -- 标题栏
    local TitleBar = Instance.new("Frame")
    TitleBar.Size = UDim2.new(1, 0, 0, 40) -- 稍微减小高度
    TitleBar.BackgroundColor3 = Color3.fromRGB(20, 20, 40)
    TitleBar.BackgroundTransparency = 0.2
    TitleBar.BorderSizePixel = 0
    TitleBar.ZIndex = 5
    Instance.new("UICorner", TitleBar).CornerRadius = UDim.new(0, 16)
    TitleBar.Parent = MainFrame
    
    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Size = UDim2.new(1, -100, 1, 0)
    TitleLabel.Position = UDim2.new(0, 15, 0, 0)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = "培根脚本 v6.3"
    TitleLabel.TextColor3 = Color3.fromRGB(0, 255, 255)
    TitleLabel.TextSize = 20 -- 稍微减小字体
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.ZIndex = 6
    TitleLabel.Parent = TitleBar
    
    -- 控制按钮
    local MinimizeButton = Instance.new("TextButton")
    MinimizeButton.Size = UDim2.new(0, 30, 0, 30) -- 改小按钮
    MinimizeButton.Position = UDim2.new(1, -70, 0, 5)
    MinimizeButton.BackgroundColor3 = Color3.fromRGB(0, 150, 200)
    MinimizeButton.BackgroundTransparency = 0.2
    MinimizeButton.Text = "_"
    MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    MinimizeButton.TextSize = 16
    MinimizeButton.Font = Enum.Font.GothamBold
    MinimizeButton.ZIndex = 6
    Instance.new("UICorner", MinimizeButton).CornerRadius = UDim.new(0, 8)
    MinimizeButton.Parent = TitleBar

    local CloseButton = Instance.new("TextButton")
    CloseButton.Size = UDim2.new(0, 30, 0, 30) -- 改小按钮
    CloseButton.Position = UDim2.new(1, -35, 0, 5)
    CloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    CloseButton.BackgroundTransparency = 0.2
    CloseButton.Text = "X"
    CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseButton.TextSize = 14
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.ZIndex = 6
    Instance.new("UICorner", CloseButton).CornerRadius = UDim.new(0, 8)
    CloseButton.Parent = TitleBar
    
    -- 选项卡区域（左侧）
    local TabFrame = Instance.new("Frame")
    TabFrame.Size = UDim2.new(0, 150, 1, -40) -- 改小宽度
    TabFrame.Position = UDim2.new(0, 0, 0, 40)
    TabFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 50)
    TabFrame.BackgroundTransparency = 0.2
    TabFrame.ZIndex = 3
    Instance.new("UICorner", TabFrame).CornerRadius = UDim.new(0, 16)
    TabFrame.Parent = MainFrame
    
    -- 主内容区域（右侧）
    local MainContent = Instance.new("Frame")
    MainContent.Size = UDim2.new(1, -150, 1, -40)
    MainContent.Position = UDim2.new(0, 150, 0, 40)
    MainContent.BackgroundTransparency = 1
    MainContent.ZIndex = 3
    MainContent.Parent = MainFrame
    
    -- 选项卡
    local Tabs = {"基础功能", "移动功能", "玩家交互", "外观功能", "世界功能", "FE功能", "黑洞功能", "其他整合脚本"}
    local TabButtons = {}
    local CurrentTab = "基础功能"
    
    local TabLayout = Instance.new("UIListLayout", TabFrame)
    TabLayout.Padding = UDim.new(0, 5)
    Instance.new("UIPadding", TabFrame).PaddingTop = UDim.new(0, 10)
    Instance.new("UIPadding", TabFrame).PaddingLeft = UDim.new(0, 5)
    Instance.new("UIPadding", TabFrame).PaddingRight = UDim.new(0, 5)

    for i, tabName in ipairs(Tabs) do
        local tabButton = Instance.new("TextButton")
        tabButton.Size = UDim2.new(1, -10, 0, 35) -- 改小按钮
        tabButton.BackgroundColor3 = Color3.fromRGB(40, 40, 80)
        tabButton.BackgroundTransparency = 0.3
        tabButton.Text = tabName
        tabButton.TextColor3 = Color3.fromRGB(200, 200, 255)
        tabButton.TextSize = 12 -- 减小字体
        tabButton.Font = Enum.Font.Gotham
        tabButton.ZIndex = 4
        tabButton.AutoButtonColor = false
        Instance.new("UICorner", tabButton).CornerRadius = UDim.new(0, 10) -- 增强圆角
        tabButton.Parent = TabFrame
        TabButtons[tabName] = tabButton
    end
    
    -- 内容区域（使用列表布局，单列按钮）
    local ContentScrolling = Instance.new("ScrollingFrame")
    ContentScrolling.Size = UDim2.new(1, -10, 1, -10)
    ContentScrolling.Position = UDim2.new(0, 5, 0, 5)
    ContentScrolling.BackgroundTransparency = 1
    ContentScrolling.ScrollBarThickness = 6 -- 减小滚动条
    ContentScrolling.ScrollBarImageColor3 = Color3.fromRGB(0, 150, 255)
    ContentScrolling.CanvasSize = UDim2.new(0, 0, 0, 0)
    ContentScrolling.AutomaticCanvasSize = Enum.AutomaticSize.Y
    ContentScrolling.ZIndex = 4
    ContentScrolling.Parent = MainContent
    
    -- 使用UIListLayout
    local ContentList = Instance.new("UIListLayout", ContentScrolling)
    ContentList.Padding = UDim.new(0, 8) -- 减小间距
    ContentList.SortOrder = Enum.SortOrder.LayoutOrder
    
    Instance.new("UIPadding", ContentScrolling).PaddingLeft = UDim.new(0, 5)
    Instance.new("UIPadding", ContentScrolling).PaddingRight = UDim.new(0, 5)
    Instance.new("UIPadding", ContentScrolling).PaddingTop = UDim.new(0, 5)
    
    -- 创建按钮函数（单列按钮）
    local function createButton(text, description)
        local buttonFrame = Instance.new("Frame")
        buttonFrame.Size = UDim2.new(1, -10, 0, 45) -- 减小高度
        buttonFrame.BackgroundTransparency = 1
        buttonFrame.LayoutOrder = #ContentScrolling:GetChildren()
        
        local button = Instance.new("TextButton")
        button.Size = UDim2.new(1, 0, 1, 0)
        button.BackgroundColor3 = Color3.fromRGB(50, 50, 100)
        button.BackgroundTransparency = 0.3
        button.Text = text
        button.TextColor3 = Color3.fromRGB(200, 200, 255)
        button.TextSize = 12 -- 减小字体
        button.Font = Enum.Font.Gotham
        button.AutoButtonColor = false
        button.ZIndex = 5
        button.TextWrapped = true
        Instance.new("UICorner", button).CornerRadius = UDim.new(0, 12) -- 增强圆角
        local buttonStroke = Instance.new("UIStroke", button)
        buttonStroke.Color = Color3.fromRGB(100, 100, 200)
        button.Parent = buttonFrame
        
        if description then
            button.MouseEnter:Connect(function()
                local tooltip = Instance.new("TextLabel")
                tooltip.Size = UDim2.new(0, 160, 0, 0)
                tooltip.Position = UDim2.new(0, -80, 1, 5)
                tooltip.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
                tooltip.BackgroundTransparency = 0.1
                tooltip.Text = description
                tooltip.TextColor3 = Color3.fromRGB(200, 200, 255)
                tooltip.TextSize = 11
                tooltip.TextWrapped = true
                tooltip.ZIndex = 100
                tooltip.Visible = false
                Instance.new("UICorner", tooltip).CornerRadius = UDim.new(0, 8)
                Instance.new("UIStroke", tooltip).Color = Color3.fromRGB(0, 150, 255)
                tooltip.Parent = buttonFrame
                
                tooltip.Visible = true
                TweenService:Create(tooltip, TweenInfo.new(0.2), {Size = UDim2.new(0, 160, 0, 50)}):Play()
            end)
            
            button.MouseLeave:Connect(function()
                local tooltip = buttonFrame:FindFirstChildWhichIsA("TextLabel")
                if tooltip then
                    TweenService:Create(tooltip, TweenInfo.new(0.2), {Size = UDim2.new(0, 160, 0, 0)}):Play()
                    wait(0.2)
                    tooltip:Destroy()
                end
            end)
        end
        
        button.MouseEnter:Connect(function()
            button.BackgroundTransparency = 0.1
            buttonStroke.Thickness = 2
        end)
        
        button.MouseLeave:Connect(function()
            button.BackgroundTransparency = 0.3
            buttonStroke.Thickness = 1
        end)
        
        return buttonFrame, button
    end

    -- 重新组织功能分类
    local FunctionTabs = {
        ["基础功能"] = {
            {name = "NoclipButton", text = "穿墙模式 [关闭]", desc = "穿透所有墙壁和物体"},
            {name = "InfiniteJumpButton", text = "无限跳跃 [关闭]", desc = "在空中也能无限跳跃"},
            {name = "SpeedButton", text = "移动速度: 16", desc = "点击切换移动速度"},
            {name = "JumpButton", text = "跳跃高度: 50", desc = "点击切换跳跃高度"},
            {name = "PlayerButton", text = "选择玩家: 无", desc = "选择目标玩家"},
            {name = "ClimbWallButton", text = "爬墙模式 [关闭]", desc = "碰到墙自动上升"},
            {name = "AntiFallButton", text = "防摔(多点几次)", desc = "防止从高处掉落受伤"},
            {name = "SuicideButton", text = "自杀", desc = "立即死亡"}
        },
        ["移动功能"] = {
            {name = "SpinButton", text = "人物旋转 [关闭]", desc = "让人物持续旋转"},
            {name = "SpinSpeedButton", text = "旋转速度: 10", desc = "调整旋转速度"},
            {name = "AutoMoveButton", text = "自动移动 [关闭]", desc = "自动向前移动"}
        },
        ["玩家交互"] = {
            {name = "KillAllButton", text = "秒杀所有人", desc = "瞬间击败所有其他玩家"},
            {name = "TeleportAllButton", text = "传送所有人到我", desc = "把所有玩家传送到你身边"},
            {name = "SitSpinButton", text = "坐在头上旋转 [关闭]", desc = "坐在目标玩家头上旋转"},
            {name = "RideHeadButton", text = "骑在玩家头上 [关闭]", desc = "骑在目标玩家头上跟随移动"},
            {name = "ViewBackpackButton", text = "查看玩家背包", desc = "查看并偷取其他玩家的物品"},
            {name = "ClickTeleportButton", text = "点击传送", desc = "加载点击传送工具脚本"}
        },
        ["外观功能"] = {
            {name = "PlayerSizeButton", text = "玩家大小: 1", desc = "调整玩家体型大小"},
            {name = "RainbowButton", text = "彩虹模式 [关闭]", desc = "全身彩虹颜色变化"},
            {name = "GlobalRainbowButton", text = "全局彩虹 [关闭]", desc = "所有物体和建筑彩虹变色"},
            {name = "GhostButton", text = "幽灵模式 [关闭]", desc = "半透明幽灵效果"}
        },
        ["世界功能"] = {
            {name = "GravityButton", text = "重力设置: 196.2", desc = "修改游戏重力"},
            {name = "NightVisionButton", text = "夜视模式 [关闭]", desc = "开启夜视功能，黑暗环境变亮"},
            {name = "HackButton", text = "黑客入侵", desc = "客户端特效：改变贴图、天空盒、火焰效果等"},
            {name = "UIColorButton", text = "UI颜色调节", desc = "随机改变UI颜色主题"}
        },
        ["FE功能"] = {
            {name = "FEFacialButton", text = "FE表情", desc = "加载FE表情脚本"},
            {name = "FEHugButton", text = "fe拥抱", desc = "加载FE拥抱脚本"},
            {name = "FECrouchButton", text = "fe蹲下", desc = "加载FE蹲下脚本"},
            {name = "FESkyboxButton", text = "FE天空盒", desc = "加载FE天空盒脚本"},
            {name = "FESwordButton", text = "fe圣剑", desc = "加载FE圣剑脚本"},
            {name = "FECarButton", text = "FE人物变车", desc = "将人物变成汽车形态"},
            {name = "FESpiderManButton", text = "FE蜘蛛侠", desc = "加载FE蜘蛛侠脚本"},
            {name = "FER6AnimationsButton", text = "FER6动作", desc = "加载R6角色动作菜单"},
            {name = "FEHamsterBallButton", text = "FE滚蛋", desc = "加载FE仓鼠球脚本"},
            {name = "FEAutoPianoButton", text = "FE自动弹钢琴", desc = "自动弹奏钢琴"},
            {name = "FEControlNPCButton", text = "FE控制NPC", desc = "加载FE控制NPC脚本"},
            {name = "FEForsakenAnimButton", text = "FE被遗弃动作", desc = "加载FE被遗弃动作脚本"},
            {name = "FE096Button", text = "fe合集", desc = "加载FE合集脚本"},
            {name = "FEHam00dButton", text = "fe ham00d菜单", desc = "加载FE ham00d菜单脚本"},
            {name = "CatAnimButton", text = "猫动作", desc = "加载猫动作脚本"},
            {name = "InvincibleButton", text = "无敌", desc = "加载无敌脚本"},
            {name = "FEAK47Button", text = "FE AK47", desc = "加载FE AK47脚本"},
            {name = "FESniperButton", text = "FE 狙击枪", desc = "加载FE狙击枪脚本"}
        },
        ["黑洞功能"] = {
            {name = "BlackHoleV6Button", text = "黑洞v6", desc = "加载黑洞v6脚本"},
            {name = "BlackHoleV4Button", text = "黑洞v4", desc = "加载黑洞v4脚本"},
            {name = "BlackHoleV1Button", text = "黑洞v1", desc = "加载黑洞v1脚本"}
        },
        ["其他整合脚本"] = {
            {name = "FlyButton", text = "ARCEUS飞行脚本", desc = "点击加载ARCEUS X FLY V2飞行脚本"},
            {name = "InvincibleFlyButton", text = "无敌苍蝇飞行", desc = "加载无敌苍蝇飞行脚本"},
            {name = "FakeLagButton", text = "假延迟", desc = "加载假延迟脚本"},
            {name = "DayunButton", text = "大运", desc = "加载大运脚本"},
            {name = "CrawlButton", text = "在地上爬", desc = "加载在地上爬脚本"},
            {name = "FEFighterButton", text = "强行装备物品", desc = "强行装备物品脚本"},
            {name = "YeScriptButton", text = "叶脚本", desc = "加载叶脚本"},
            {name = "WalkAirButton", text = "踏空行走", desc = "加载踏空行走脚本"},
            {name = "InvisibleButton", text = "人物隐形脚本", desc = "加载人物隐形脚本"},
            {name = "FakeFriendButton", text = "假朋友", desc = "生成假朋友NPC"},
            {name = "ChatDrawButton", text = "在聊天框画画", desc = "在聊天框中绘制图案"},
            {name = "TrainEffectButton", text = "火车头效果", desc = "加载火车头效果脚本"},
            {name = "FreePrivateServerButton", text = "免费私服", desc = "加载免费私服脚本"},
            {name = "PiScriptButton", text = "皮脚本", desc = "加载皮脚本"},
            {name = "CaodanButton", text = "操蛋", desc = "加载操蛋脚本"},
            {name = "ScriptCenterButton", text = "脚本中心", desc = "加载脚本中心"},
            {name = "ShaScriptButton", text = "沙脚本", desc = "加载沙脚本"},
            {name = "StealBrainRedButton", text = "偷走脑红", desc = "加载偷走脑红脚本"},
            {name = "GardenButton", text = "种植花园", desc = "加载种植花园脚本"},
            {name = "OhioButton", text = "俄亥俄州脚本", desc = "加载俄亥俄州脚本"},
            {name = "ForsakenButton", text = "被遗弃脚本", desc = "加载被遗弃脚本"},
            {name = "ThrowFlyButton", text = "甩飞脚本", desc = "加载甩飞脚本"},
            {name = "BeatDogButton", text = "悦服循环打狗", desc = "加载悦服循环打狗脚本"},
            {name = "ChenScriptButton", text = "辰脚本", desc = "加载辰脚本"}
        }
    }

    -- 创建按钮
    local ButtonInstances = {}
    local ButtonFrames = {}
    
    for tabName, functions in pairs(FunctionTabs) do
        for _, func in ipairs(functions) do
            local buttonFrame, button = createButton(func.text, func.desc)
            buttonFrame.Parent = ContentScrolling
            buttonFrame.Visible = (tabName == "基础功能")
            ButtonInstances[func.name] = button
            ButtonFrames[func.name] = buttonFrame
        end
    end

    -- 选项卡切换
    for tabName, tabButton in pairs(TabButtons) do
        tabButton.MouseButton1Click:Connect(function()
            CurrentTab = tabName
            for name, frame in pairs(ButtonFrames) do
                frame.Visible = false
            end
            for _, func in ipairs(FunctionTabs[tabName]) do
                ButtonFrames[func.name].Visible = true
            end
            for tName, tButton in pairs(TabButtons) do
                if tName == tabName then
                    tButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
                    tButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                else
                    tButton.BackgroundColor3 = Color3.fromRGB(40, 40, 80)
                    tButton.TextColor3 = Color3.fromRGB(200, 200, 255)
                end
            end
        end)
    end

    TabButtons["基础功能"].BackgroundColor3 = Color3.fromRGB(0, 150, 255)
    TabButtons["基础功能"].TextColor3 = Color3.fromRGB(255, 255, 255)

    -- 功能变量
    local noclip, infiniteJump, spinning, walkAir = false, false, false, false
    local rainbow, globalRainbow, ghost, sitSpinning, ridingHead = false, false, false, false, false
    local climbing, autoMove, nightVision = false, false, false
    local walkSpeed, jumpPower, spinSpeed, playerSize, gravity, sitSpinSpeed = 16, 50, 10, 1, 196.2, 5
    local selectedPlayer = nil
    local connections = {}
    local originalTransparency, originalColors = {}
    local originalLightingSettings = {}

    -- 播放点击音效函数
    local function playClickSound()
        local sound = Instance.new("Sound")
        sound.SoundId = "rbxassetid://82845990304289"
        sound.Volume = 0.5
        sound.Parent = Workspace
        sound:Play()
        game:GetService("Debris"):AddItem(sound, 2)
    end

    -- 通知函数
    local function showNotification(message, color)
        local notification = Instance.new("Frame")
        notification.Size = UDim2.new(0, 300, 0, 60)
        notification.Position = UDim2.new(0.5, -150, 0.1, 0)
        notification.BackgroundColor3 = color
        notification.BackgroundTransparency = 0.2
        notification.ZIndex = 100
        Instance.new("UICorner", notification).CornerRadius = UDim.new(0, 12)
        Instance.new("UIStroke", notification).Color = Color3.fromRGB(255, 255, 255)
        notification.Parent = ScreenGui
        
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, -20, 1, -10)
        label.Position = UDim2.new(0, 10, 0, 5)
        label.BackgroundTransparency = 1
        label.Text = message
        label.TextColor3 = Color3.fromRGB(255, 255, 255)
        label.TextSize = 16
        label.Font = Enum.Font.GothamBold
        label.TextWrapped = true
        label.Parent = notification
        
        notification.Position = UDim2.new(0.5, -150, 0, -70)
        TweenService:Create(notification, TweenInfo.new(0.5), {Position = UDim2.new(0.5, -150, 0.1, 0)}):Play()
        
        wait(3)
        TweenService:Create(notification, TweenInfo.new(0.5), {Position = UDim2.new(0.5, -150, 0, -70)}):Play()
        wait(0.5)
        notification:Destroy()
    end

    -- UI控制
    local minimized = false
    local function toggleMinimize()
        playClickSound()
        minimized = not minimized
        if minimized then
            TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 180, 0, 40)}):Play()
            wait(0.3)
            TabFrame.Visible = false
            MainContent.Visible = false
            MinimizeButton.Text = "+"
        else
            TabFrame.Visible = true
            MainContent.Visible = true
            TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 700, 0, 450)}):Play()
            MinimizeButton.Text = "_"
        end
    end

    -- 选择玩家
    local function selectPlayer()
        playClickSound()
        local playerList = Players:GetPlayers()
        local currentIndex = 0
        
        if selectedPlayer then
            for i, player in ipairs(playerList) do
                if player == selectedPlayer then
                    currentIndex = i
                    break
                end
            end
        end
        
        selectedPlayer = playerList[(currentIndex % #playerList) + 1]
        ButtonInstances.PlayerButton.Text = "选择玩家: " .. selectedPlayer.Name
        showNotification("已选择玩家: " .. selectedPlayer.Name, Color3.fromRGB(0, 150, 200))
    end

    -- 脚本加载函数
    local function loadExternalScript(url, name)
        playClickSound()
        loadstring(game:HttpGet(url))()
        showNotification(name .. "已加载!", Color3.fromRGB(0, 200, 0))
    end

    -- 新增功能函数
    local function loadStealBrainRed()
        playClickSound()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/hdjsjjdgrhj/script-hub/refs/heads/main/偷走脑红"))()
        showNotification("偷走脑红脚本已加载!", Color3.fromRGB(0, 200, 0))
    end

    local function loadGarden()
        playClickSound()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/thantzy/thanhub/refs/heads/main/thanv1"))()
        showNotification("种植花园脚本已加载!", Color3.fromRGB(0, 200, 0))
    end

    local function loadOhio()
        playClickSound()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/jiankeQWQ/jiankeV3/main/ehaiezhou"))()
        showNotification("俄亥俄州脚本已加载!", Color3.fromRGB(0, 200, 0))
    end

    local function loadForsaken()
        playClickSound()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/BobJunior1/ForsakenBoi/refs/heads/main/B0bbyHub"))()
        showNotification("被遗弃脚本已加载!", Color3.fromRGB(0, 200, 0))
    end

    local function loadThrowFly()
        playClickSound()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/3LD4D0/Crazy-Man-R6/36ec60d16bf8d208c40807aa0fd2662af76a5385/Crazy%20Man%20R6"))()
        showNotification("甩飞脚本已加载!", Color3.fromRGB(0, 200, 0))
    end

    local function loadCatAnim()
        playClickSound()
        loadstring(game:HttpGet("https://pastebin.com/raw/Y1MkBRn3"))()
        showNotification("猫动作脚本已加载!", Color3.fromRGB(0, 200, 0))
    end

    local function loadInvincible()
        playClickSound()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/5twh2hsf9j-byte/BowenPrime67/refs/heads/main/Python"))()
        showNotification("无敌脚本已加载!", Color3.fromRGB(0, 200, 0))
    end

    local function loadBeatDog()
        playClickSound()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ke9460394-dot/ugik/refs/heads/main/KENNY爆打黄油.txt"))()
        showNotification("悦服循环打狗脚本已加载!", Color3.fromRGB(0, 200, 0))
    end

    local function loadFEAK47()
        playClickSound()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/GenesisFE/Genesis/main/Obfuscations/AK-47"))()
        showNotification("FE AK47脚本已加载!", Color3.fromRGB(0, 200, 0))
    end

    local function loadFESniper()
        playClickSound()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/GenesisFE/Genesis/main/Obfuscations/Sniper"))()
        showNotification("FE 狙击枪脚本已加载!", Color3.fromRGB(0, 200, 0))
    end

    local function loadChenScript()
        playClickSound()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/qwrt5589/eododo/main/XG_SYNB.txt"))()
        showNotification("辰脚本已加载!", Color3.fromRGB(0, 200, 0))
    end

    -- 防摔功能
    local function loadAntiFall()
        playClickSound()
        loadstring([[
local Player = game:GetService("Players").LocalPlayer

local function setupSafeImmunity()
    local character = Player.Character
    if not character then return end
    
    local humanoid = character:FindFirstChild("Humanoid")
    if not humanoid then return end
    
    humanoid.HealthChanged:Connect(function(newHealth)
        if newHealth < humanoid.MaxHealth then
            humanoid.Health = humanoid.MaxHealth
        end
    end)
    
    humanoid.Died:Connect(function()
        wait(0.1)
        if character and character:FindFirstChild("Humanoid") then
            character.Humanoid.Health = character.Humanoid.MaxHealth
        end
    end)
end

setupSafeImmunity()
Player.CharacterAdded:Connect(function()
    wait(1)
    setupSafeImmunity()
end)

print("安全版自然灾害免疫已激活")
]])()
        showNotification("防摔已激活", Color3.fromRGB(0, 200, 0))
    end

    -- 穿墙功能
    local function toggleNoclip()
        playClickSound()
        noclip = not noclip
        ButtonInstances.NoclipButton.Text = "穿墙模式 [" .. (noclip and "开启]" or "关闭]")
        ButtonInstances.NoclipButton.TextColor3 = noclip and Color3.fromRGB(0, 255, 150) or Color3.fromRGB(200, 200, 255)
        
        if noclip then
            connections.noclip = RunService.Stepped:Connect(function()
                local character = LocalPlayer.Character
                if character and noclip then
                    for _, part in pairs(character:GetDescendants()) do
                        if part:IsA("BasePart") then part.CanCollide = false end
                    end
                end
            end)
            showNotification("穿墙模式已开启", Color3.fromRGB(0, 150, 200))
        else
            if connections.noclip then connections.noclip:Disconnect() end
            showNotification("穿墙模式已关闭", Color3.fromRGB(150, 150, 150))
        end
    end

    -- 无限跳跃
    local function toggleInfiniteJump()
        playClickSound()
        infiniteJump = not infiniteJump
        ButtonInstances.InfiniteJumpButton.Text = "无限跳跃 [" .. (infiniteJump and "开启]" or "关闭]")
        ButtonInstances.InfiniteJumpButton.TextColor3 = infiniteJump and Color3.fromRGB(0, 255, 150) or Color3.fromRGB(200, 200, 255)
        showNotification("无限跳跃" .. (infiniteJump and "已开启" or "已关闭"), Color3.fromRGB(0, 150, 200))
    end

    UserInputService.JumpRequest:Connect(function()
        if infiniteJump and LocalPlayer.Character then
            local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then humanoid:ChangeState(Enum.HumanoidStateType.Jumping) end
        end
    end)

    -- 移动速度
    local function changeSpeed()
        playClickSound()
        walkSpeed = (walkSpeed % 100) + 8
        local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then humanoid.WalkSpeed = walkSpeed end
        ButtonInstances.SpeedButton.Text = "移动速度: " .. walkSpeed
        showNotification("移动速度设置为: " .. walkSpeed, Color3.fromRGB(0, 150, 200))
    end

    -- 跳跃高度
    local function changeJump()
        playClickSound()
        jumpPower = (jumpPower % 200) + 25
        local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then humanoid.JumpPower = jumpPower end
        ButtonInstances.JumpButton.Text = "跳跃高度: " .. jumpPower
        showNotification("跳跃高度设置为: " .. jumpPower, Color3.fromRGB(0, 150, 200))
    end

    -- 爬墙功能
    local function toggleClimbWall()
        playClickSound()
        climbing = not climbing
        ButtonInstances.ClimbWallButton.Text = "爬墙模式 [" .. (climbing and "开启]" or "关闭]")
        ButtonInstances.ClimbWallButton.TextColor3 = climbing and Color3.fromRGB(0, 255, 150) or Color3.fromRGB(200, 200, 255)
        
        if climbing then
            connections.climb = RunService.Heartbeat:Connect(function()
                local character = LocalPlayer.Character
                if character and character:FindFirstChild("HumanoidRootPart") and climbing then
                    local root = character.HumanoidRootPart
                    local directions = {root.CFrame.LookVector, -root.CFrame.LookVector, root.CFrame.RightVector, -root.CFrame.RightVector}
                    
                    for _, direction in pairs(directions) do
                        local ray = Ray.new(root.Position, direction * 3)
                        if Workspace:FindPartOnRayWithIgnoreList(ray, {character}) then
                            root.Velocity = Vector3.new(root.Velocity.X, 20, root.Velocity.Z)
                            break
                        end
                    end
                end
            end)
            showNotification("爬墙模式已开启! 碰到墙会自动上升", Color3.fromRGB(0, 150, 200))
        else
            if connections.climb then connections.climb:Disconnect() end
            showNotification("爬墙模式已关闭", Color3.fromRGB(150, 150, 150))
        end
    end

    -- 人物旋转
    local function toggleSpin()
        playClickSound()
        spinning = not spinning
        ButtonInstances.SpinButton.Text = "人物旋转 [" .. (spinning and "开启]" or "关闭]")
        ButtonInstances.SpinButton.TextColor3 = spinning and Color3.fromRGB(0, 255, 150) or Color3.fromRGB(200, 200, 255)
        
        if spinning then
            connections.spin = RunService.Heartbeat:Connect(function()
                local character = LocalPlayer.Character
                if character and character:FindFirstChild("HumanoidRootPart") and spinning then
                    character.HumanoidRootPart.CFrame = character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(spinSpeed), 0)
                end
            end)
            showNotification("人物旋转已开启", Color3.fromRGB(0, 150, 200))
        else
            if connections.spin then connections.spin:Disconnect() end
            showNotification("人物旋转已关闭", Color3.fromRGB(150, 150, 150))
        end
    end

    -- 旋转速度
    local function changeSpinSpeed()
        playClickSound()
        spinSpeed = (spinSpeed % 50) + 5
        ButtonInstances.SpinSpeedButton.Text = "旋转速度: " .. spinSpeed
        showNotification("旋转速度设置为: " .. spinSpeed, Color3.fromRGB(0, 150, 200))
    end

    -- 自动移动
    local function toggleAutoMove()
        playClickSound()
        autoMove = not autoMove
        ButtonInstances.AutoMoveButton.Text = "自动移动 [" .. (autoMove and "开启]" or "关闭]")
        ButtonInstances.AutoMoveButton.TextColor3 = autoMove and Color3.fromRGB(0, 255, 150) or Color3.fromRGB(200, 200, 255)
        
        if autoMove then
            connections.autoMove = RunService.Heartbeat:Connect(function()
                local character = LocalPlayer.Character
                if character and character:FindFirstChild("HumanoidRootPart") and autoMove then
                    character.HumanoidRootPart.Velocity = character.HumanoidRootPart.CFrame.LookVector * 20
                end
            end)
            showNotification("自动移动已开启", Color3.fromRGB(0, 150, 200))
        else
            if connections.autoMove then connections.autoMove:Disconnect() end
            showNotification("自动移动已关闭", Color3.fromRGB(150, 150, 150))
        end
    end

    -- 秒杀所有人
    local function killAllPlayers()
        playClickSound()
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
                if humanoid then humanoid.Health = 0 end
            end
        end
        showNotification("已秒杀所有玩家", Color3.fromRGB(255, 50, 50))
    end

    -- 传送所有人到我
    local function teleportAllToMe()
        playClickSound()
        local myCharacter = LocalPlayer.Character
        if myCharacter and myCharacter:FindFirstChild("HumanoidRootPart") then
            local myPosition = myCharacter.HumanoidRootPart.Position
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer then
                    local character = player.Character
                    if character and character:FindFirstChild("HumanoidRootPart") then
                        character.HumanoidRootPart.CFrame = CFrame.new(myPosition + Vector3.new(math.random(-5, 5), 0, math.random(-5, 5)))
                    end
                end
            end
            showNotification("已传送所有玩家", Color3.fromRGB(0, 200, 0))
        end
    end

    -- 坐在头上旋转
    local function toggleSitSpin()
        playClickSound()
        if not selectedPlayer then
            showNotification("请先选择一个玩家!", Color3.fromRGB(255, 50, 50))
            return
        end
        
        sitSpinning = not sitSpinning
        ButtonInstances.SitSpinButton.Text = "坐在头上旋转 [" .. (sitSpinning and "开启]" or "关闭]")
        ButtonInstances.SitSpinButton.TextColor3 = sitSpinning and Color3.fromRGB(0, 255, 150) or Color3.fromRGB(200, 200, 255)
        
        if sitSpinning then
            local myCharacter, targetCharacter = LocalPlayer.Character, selectedPlayer.Character
            local myRoot, targetRoot = myCharacter and myCharacter:FindFirstChild("HumanoidRootPart"), targetCharacter and targetCharacter:FindFirstChild("HumanoidRootPart")
            
            if myRoot and targetRoot then
                myRoot.CFrame = targetRoot.CFrame + Vector3.new(0, 5, 0)
                local angle = 0
                
                connections.sitSpin = RunService.Heartbeat:Connect(function()
                    if sitSpinning and targetRoot then
                        angle = angle + math.rad(sitSpinSpeed)
                        local x, z = math.cos(angle) * 3, math.sin(angle) * 3
                        myRoot.CFrame = CFrame.new(targetRoot.Position + Vector3.new(x, 5, z), targetRoot.Position)
                    end
                end)
                showNotification("正在" .. selectedPlayer.Name .. "头上旋转!", Color3.fromRGB(0, 150, 200))
            end
        else
            if connections.sitSpin then connections.sitSpin:Disconnect() end
            showNotification("停止坐在头上旋转", Color3.fromRGB(150, 150, 150))
        end
    end

    -- 骑在玩家头上
    local function toggleRideHead()
        playClickSound()
        if not selectedPlayer then
            showNotification("请先选择一个玩家!", Color3.fromRGB(255, 50, 50))
            return
        end
        
        ridingHead = not ridingHead
        ButtonInstances.RideHeadButton.Text = "骑在玩家头上 [" .. (ridingHead and "开启]" or "关闭]")
        ButtonInstances.RideHeadButton.TextColor3 = ridingHead and Color3.fromRGB(0, 255, 150) or Color3.fromRGB(200, 200, 255)
        
        if ridingHead then
            local myCharacter, targetCharacter = LocalPlayer.Character, selectedPlayer.Character
            local myRoot, targetRoot = myCharacter and myCharacter:FindFirstChild("HumanoidRootPart"), targetCharacter and targetCharacter:FindFirstChild("HumanoidRootPart")
            
            if myRoot and targetRoot then
                connections.ride = RunService.Heartbeat:Connect(function()
                    if ridingHead and targetRoot then
                        myRoot.CFrame = CFrame.new(targetRoot.Position + Vector3.new(0, 3, 0))
                    end
                end)
                showNotification("正在骑在" .. selectedPlayer.Name .. "头上!", Color3.fromRGB(0, 150, 200))
            end
        else
            if connections.ride then connections.ride:Disconnect() end
            showNotification("停止骑在玩家头上", Color3.fromRGB(150, 150, 150))
        end
    end

    -- 查看玩家背包
    local function viewPlayerBackpack()
        playClickSound()
        if not selectedPlayer then
            showNotification("请先选择一个玩家!", Color3.fromRGB(255, 50, 50))
            return
        end

        -- 创建背包查看窗口
        local backpackFrame = Instance.new("Frame")
        backpackFrame.Size = UDim2.new(0, 400, 0, 500)
        backpackFrame.Position = UDim2.new(0.5, -200, 0.5, -250)
        backpackFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 80)
        backpackFrame.BackgroundTransparency = 0.1
        backpackFrame.BorderSizePixel = 2
        backpackFrame.BorderColor3 = Color3.fromRGB(0, 150, 255)
        backpackFrame.Active = true
        backpackFrame.Draggable = true
        backpackFrame.ZIndex = 50
        Instance.new("UICorner", backpackFrame).CornerRadius = UDim.new(0, 15)
        Instance.new("UIStroke", backpackFrame).Color = Color3.fromRGB(0, 150, 255)
        backpackFrame.Parent = ScreenGui

        -- 标题栏
        local titleBar = Instance.new("Frame")
        titleBar.Size = UDim2.new(1, 0, 0, 40)
        titleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 60)
        titleBar.BackgroundTransparency = 0.1
        titleBar.BorderSizePixel = 0
        titleBar.ZIndex = 51
        Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0, 15)
        titleBar.Parent = backpackFrame

        local titleLabel = Instance.new("TextLabel")
        titleLabel.Size = UDim2.new(1, -50, 1, 0)
        titleLabel.Position = UDim2.new(0, 15, 0, 0)
        titleLabel.BackgroundTransparency = 1
        titleLabel.Text = selectedPlayer.Name .. "的背包"
        titleLabel.TextColor3 = Color3.fromRGB(0, 255, 255)
        titleLabel.TextSize = 18
        titleLabel.TextXAlignment = Enum.TextXAlignment.Left
        titleLabel.Font = Enum.Font.GothamBold
        titleLabel.ZIndex = 52
        titleLabel.Parent = titleBar

        local closeButton = Instance.new("TextButton")
        closeButton.Size = UDim2.new(0, 30, 0, 30)
        closeButton.Position = UDim2.new(1, -35, 0, 5)
        closeButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        closeButton.BackgroundTransparency = 0.2
        closeButton.Text = "X"
        closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        closeButton.TextSize = 16
        closeButton.Font = Enum.Font.GothamBold
        closeButton.ZIndex = 52
        Instance.new("UICorner", closeButton).CornerRadius = UDim.new(0, 8)
        closeButton.Parent = titleBar

        -- 内容区域
        local contentFrame = Instance.new("ScrollingFrame")
        contentFrame.Size = UDim2.new(1, -20, 1, -60)
        contentFrame.Position = UDim2.new(0, 10, 0, 50)
        contentFrame.BackgroundTransparency = 1
        contentFrame.ScrollBarThickness = 8
        contentFrame.ScrollBarImageColor3 = Color3.fromRGB(0, 150, 255)
        contentFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
        contentFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
        contentFrame.ZIndex = 51
        contentFrame.Parent = backpackFrame

        local contentLayout = Instance.new("UIListLayout", contentFrame)
        contentLayout.Padding = UDim.new(0, 10)
        Instance.new("UIPadding", contentFrame).PaddingTop = UDim.new(0, 5)

        -- 获取目标玩家的背包和角色中的工具
        local targetBackpack = selectedPlayer:FindFirstChildOfClass("Backpack")
        local targetCharacter = selectedPlayer.Character
        local tools = {}

        -- 从背包获取工具
        if targetBackpack then
            for _, tool in ipairs(targetBackpack:GetChildren()) do
                if tool:IsA("Tool") then
                    table.insert(tools, tool)
                end
            end
        end

        -- 从角色获取工具
        if targetCharacter then
            for _, tool in ipairs(targetCharacter:GetChildren()) do
                if tool:IsA("Tool") then
                    table.insert(tools, tool)
                end
            end
        end

        -- 显示工具列表
        if #tools == 0 then
            local noItemsLabel = Instance.new("TextLabel")
            noItemsLabel.Size = UDim2.new(1, 0, 0, 50)
            noItemsLabel.BackgroundTransparency = 1
            noItemsLabel.Text = "背包为空"
            noItemsLabel.TextColor3 = Color3.fromRGB(150, 150, 200)
            noItemsLabel.TextSize = 16
            noItemsLabel.Font = Enum.Font.Gotham
            noItemsLabel.ZIndex = 52
            noItemsLabel.Parent = contentFrame
        else
            for _, tool in ipairs(tools) do
                local itemFrame = Instance.new("Frame")
                itemFrame.Size = UDim2.new(1, 0, 0, 60)
                itemFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 100)
                itemFrame.BackgroundTransparency = 0.3
                itemFrame.ZIndex = 52
                Instance.new("UICorner", itemFrame).CornerRadius = UDim.new(0, 10)
                Instance.new("UIStroke", itemFrame).Color = Color3.fromRGB(100, 100, 200)
                itemFrame.Parent = contentFrame

                local itemName = Instance.new("TextLabel")
                itemName.Size = UDim2.new(0.6, -10, 0.5, -5)
                itemName.Position = UDim2.new(0, 10, 0, 5)
                itemName.BackgroundTransparency = 1
                itemName.Text = tool.Name
                itemName.TextColor3 = Color3.fromRGB(200, 200, 255)
                itemName.TextSize = 16
                itemName.TextXAlignment = Enum.TextXAlignment.Left
                itemName.Font = Enum.Font.Gotham
                itemName.ZIndex = 53
                itemName.Parent = itemFrame

                local stealButton = Instance.new("TextButton")
                stealButton.Size = UDim2.new(0.35, -10, 0.5, -5)
                stealButton.Position = UDim2.new(0.6, 5, 0, 5)
                stealButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
                stealButton.BackgroundTransparency = 0.2
                stealButton.Text = "偷取"
                stealButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                stealButton.TextSize = 14
                stealButton.Font = Enum.Font.GothamBold
                stealButton.ZIndex = 53
                Instance.new("UICorner", stealButton).CornerRadius = UDim.new(0, 8)
                stealButton.Parent = itemFrame

                local itemDesc = Instance.new("TextLabel")
                itemDesc.Size = UDim2.new(1, -20, 0.5, -5)
                itemDesc.Position = UDim2.new(0, 10, 0.5, 0)
                itemDesc.BackgroundTransparency = 1
                itemDesc.Text = "工具类物品"
                itemDesc.TextColor3 = Color3.fromRGB(150, 150, 200)
                itemDesc.TextSize = 12
                itemDesc.TextXAlignment = Enum.TextXAlignment.Left
                itemDesc.Font = Enum.Font.Gotham
                itemDesc.ZIndex = 53
                itemDesc.Parent = itemFrame

                -- 偷取功能
                stealButton.MouseButton1Click:Connect(function()
                    playClickSound()
                    local clone = tool:Clone()
                    if LocalPlayer.Backpack then
                        clone.Parent = LocalPlayer.Backpack
                        showNotification("已偷取: " .. tool.Name, Color3.fromRGB(0, 200, 0))
                    else
                        showNotification("无法偷取物品: 背包不存在", Color3.fromRGB(255, 50, 50))
                    end
                end)

                -- 按钮悬停效果
                stealButton.MouseEnter:Connect(function()
                    stealButton.BackgroundTransparency = 0
                end)
                
                stealButton.MouseLeave:Connect(function()
                    stealButton.BackgroundTransparency = 0.2
                end)
            end
        end

        -- 关闭按钮事件
        closeButton.MouseButton1Click:Connect(function()
            playClickSound()
            backpackFrame:Destroy()
        end)

        showNotification("正在查看" .. selectedPlayer.Name .. "的背包", Color3.fromRGB(0, 150, 200))
    end

    -- 玩家大小
    local function changePlayerSize()
        playClickSound()
        playerSize = (playerSize % 3) + 0.5
        local character = LocalPlayer.Character
        if character then
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") then part.Size = part.Size * playerSize end
            end
        end
        ButtonInstances.PlayerSizeButton.Text = "玩家大小: " .. playerSize
        showNotification("玩家大小设置为: " .. playerSize, Color3.fromRGB(0, 150, 200))
    end

    -- 彩虹模式
    local function toggleRainbow()
        playClickSound()
        rainbow = not rainbow
        ButtonInstances.RainbowButton.Text = "彩虹模式 [" .. (rainbow and "开启]" or "关闭]")
        ButtonInstances.RainbowButton.TextColor3 = rainbow and Color3.fromRGB(0, 255, 150) or Color3.fromRGB(200, 200, 255)
        
        if rainbow then
            local hue = 0
            connections.rainbow = RunService.Heartbeat:Connect(function()
                if rainbow then
                    hue = (hue + 0.01) % 1
                    local color = Color3.fromHSV(hue, 1, 1)
                    local character = LocalPlayer.Character
                    if character then
                        for _, part in pairs(character:GetDescendants()) do
                            if part:IsA("BasePart") then part.BrickColor = BrickColor.new(color) end
                        end
                    end
                end
            end)
            showNotification("彩虹模式已开启", Color3.fromRGB(0, 150, 200))
        else
            if connections.rainbow then connections.rainbow:Disconnect() end
            showNotification("彩虹模式已关闭", Color3.fromRGB(150, 150, 150))
        end
    end

    -- 全局彩虹
    local function toggleGlobalRainbow()
        playClickSound()
        globalRainbow = not globalRainbow
        ButtonInstances.GlobalRainbowButton.Text = "全局彩虹 [" .. (globalRainbow and "开启]" or "关闭]")
        ButtonInstances.GlobalRainbowButton.TextColor3 = globalRainbow and Color3.fromRGB(0, 255, 150) or Color3.fromRGB(200, 200, 255)
        
        if globalRainbow then
            originalColors = {}
            for _, obj in pairs(Workspace:GetDescendants()) do
                if obj:IsA("BasePart") then originalColors[obj] = obj.BrickColor end
            end
            
            local hue = 0
            connections.globalRainbow = RunService.Heartbeat:Connect(function()
                if globalRainbow then
                    hue = (hue + 0.005) % 1
                    local color = Color3.fromHSV(hue, 1, 1)
                    for _, obj in pairs(Workspace:GetDescendants()) do
                        if obj:IsA("BasePart") then obj.BrickColor = BrickColor.new(color) end
                    end
                end
            end)
            showNotification("全局彩虹模式已开启!", Color3.fromRGB(0, 150, 200))
        else
            if connections.globalRainbow then connections.globalRainbow:Disconnect() end
            for obj, originalColor in pairs(originalColors) do
                if obj and obj.Parent then obj.BrickColor = originalColor end
            end
            originalColors = {}
            showNotification("全局彩虹模式已关闭", Color3.fromRGB(150, 150, 150))
        end
    end

    -- 幽灵模式
    local function toggleGhost()
        playClickSound()
        ghost = not ghost
        ButtonInstances.GhostButton.Text = "幽灵模式 [" .. (ghost and "开启]" or "关闭]")
        ButtonInstances.GhostButton.TextColor3 = ghost and Color3.fromRGB(0, 255, 150) or Color3.fromRGB(200, 200, 255)
        
        local character = LocalPlayer.Character
        if character then
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    if ghost then
                        originalTransparency[part] = part.Transparency
                        part.Transparency = 0.7
                    else
                        part.Transparency = originalTransparency[part] or 0
                    end
                end
            end
        end
        showNotification("幽灵模式" .. (ghost and "已开启" or "已关闭"), Color3.fromRGB(0, 150, 200))
    end

    -- 重力设置
    local function changeGravity()
        playClickSound()
        gravity = (gravity == 196.2) and 0 or (gravity + 50)
        if gravity > 196.2 then gravity = 196.2 end
        Workspace.Gravity = gravity
        ButtonInstances.GravityButton.Text = "重力设置: " .. gravity
        showNotification("重力设置为: " .. gravity, Color3.fromRGB(0, 150, 200))
    end

    -- 夜视功能
    local function toggleNightVision()
        playClickSound()
        nightVision = not nightVision
        ButtonInstances.NightVisionButton.Text = "夜视模式 [" .. (nightVision and "开启]" or "关闭]")
        ButtonInstances.NightVisionButton.TextColor3 = nightVision and Color3.fromRGB(0, 255, 150) or Color3.fromRGB(200, 200, 255)
        
        if nightVision then
            -- 保存原始设置
            originalLightingSettings.Ambient = Lighting.Ambient
            originalLightingSettings.Brightness = Lighting.Brightness
            originalLightingSettings.ClockTime = Lighting.ClockTime
            originalLightingSettings.GlobalShadows = Lighting.GlobalShadows
            
            -- 应用夜视效果
            Lighting.Ambient = Color3.fromRGB(128, 128, 128) -- 增加环境光
            Lighting.Brightness = 2 -- 增加亮度
            Lighting.ClockTime = 12 -- 设置为白天
            Lighting.GlobalShadows = false -- 禁用阴影
            
            showNotification("夜视模式已开启", Color3.fromRGB(0, 150, 200))
        else
            -- 恢复原始设置
            if originalLightingSettings.Ambient then
                Lighting.Ambient = originalLightingSettings.Ambient
            end
            if originalLightingSettings.Brightness then
                Lighting.Brightness = originalLightingSettings.Brightness
            end
            if originalLightingSettings.ClockTime then
                Lighting.ClockTime = originalLightingSettings.ClockTime
            end
            if originalLightingSettings.GlobalShadows ~= nil then
                Lighting.GlobalShadows = originalLightingSettings.GlobalShadows
            end
            
            showNotification("夜视模式已关闭", Color3.fromRGB(150, 150, 150))
        end
    end

    -- 黑客入侵特效
    local function applyHackEffects()
        playClickSound()
        showNotification("黑客入侵特效启动中...", Color3.fromRGB(255, 0, 0))
        
        -- 音乐
        local sound = Instance.new("Sound")
        sound.SoundId = "rbxassetid://128934903242385"
        sound.Looped = true
        sound.Volume = 0.5
        sound.Parent = SoundService
        sound:Play()
        game:GetService("Debris"):AddItem(sound, 2)

        -- 天空盒
        local sky = Instance.new("Sky")
        for _, property in pairs({"SkyboxBk", "SkyboxDn", "SkyboxFt", "SkyboxLf", "SkyboxRt", "SkyboxUp"}) do
            sky[property] = "rbxassetid://89036103941643"
        end
        sky.Parent = Lighting

        -- 修改贴图和添加特效
        for _, obj in pairs(Workspace:GetDescendants()) do
            if obj:IsA("Decal") or obj:IsA("Texture") then
                obj.Texture = "rbxassetid://89036103941643"
            elseif obj:IsA("BasePart") and obj.Name ~= "Handle" then
                -- 添加火焰效果
                local fire = Instance.new("Fire")
                fire.Size = math.random(5, 15)
                fire.Heat = math.random(5, 15)
                fire.Color = Color3.new(1, 0.3, 0)
                fire.SecondaryColor = Color3.new(1, 0.8, 0)
                fire.Parent = obj
                
                -- 添加粒子发射器
                local particle = Instance.new("ParticleEmitter")
                particle.Texture = "rbxassetid://89036103941643"
                particle.Lifetime = NumberRange.new(1, 3)
                particle.Rate = 50
                particle.SpreadAngle = Vector2.new(45, 45)
                particle.Speed = NumberRange.new(5, 15)
                particle.Parent = obj
            end
        end
        
        -- 处理新添加的对象
        Workspace.DescendantAdded:Connect(function(descendant)
            wait(0.1)
            if descendant:IsA("Decal") or descendant:IsA("Texture") then
                descendant.Texture = "rbxassetid://89036103941643"
            elseif descendant:IsA("BasePart") and descendant.Name ~= "Handle" then
                local fire = Instance.new("Fire")
                fire.Size = math.random(5, 15)
                fire.Heat = math.random(5, 15)
                fire.Color = Color3.new(1, 0.3, 0)
                fire.SecondaryColor = Color3.new(1, 0.8, 0)
                fire.Parent = descendant
                
                local particle = Instance.new("ParticleEmitter")
                particle.Texture = "rbxassetid://89036103941643"
                particle.Lifetime = NumberRange.new(1, 3)
                particle.Rate = 50
                particle.SpreadAngle = Vector2.new(45, 45)
                particle.Speed = NumberRange.new(5, 15)
                particle.Parent = descendant
            end
        end)
        
        showNotification("黑客入侵特效已应用!", Color3.fromRGB(0, 200, 0))
    end

    -- UI颜色调节
    local function changeUIColor()
        playClickSound()
        local colors = {
            Color3.fromRGB(0, 150, 255), -- 蓝色
            Color3.fromRGB(255, 0, 100),
            Color3.fromRGB(0, 255, 150), 
            Color3.fromRGB(255, 150, 0),
            Color3.fromRGB(150, 0, 255), 
            Color3.fromRGB(255, 255, 0),
            Color3.fromRGB(0, 255, 255)
        }
        local color = colors[math.random(1, #colors)]
        
        MainFrame.BackgroundColor3 = Color3.new(color.R * 0.2, color.G * 0.2, color.B * 0.2)
        MainStroke.Color = color
        TitleBar.BackgroundColor3 = Color3.new(color.R * 0.3, color.G * 0.3, color.B * 0.3)
        ContentScrolling.ScrollBarImageColor3 = color
        
        for _, button in pairs(ButtonInstances) do
            button.BackgroundColor3 = Color3.new(color.R * 0.3, color.G * 0.3, color.B * 0.3)
            if button:FindFirstChild("UIStroke") then button.UIStroke.Color = color end
        end
        
        for tabName, tabButton in pairs(TabButtons) do
            tabButton.BackgroundColor3 = (tabName == CurrentTab) and color or Color3.new(color.R * 0.3, color.G * 0.3, color.B * 0.3)
        end
        
        showNotification("UI颜色已更改", color)
    end

    -- 自杀
    local function suicide()
        playClickSound()
        local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.Health = 0
            showNotification("已自杀!", Color3.fromRGB(255, 0, 0))
        end
    end

    -- 绑定按钮事件
    MinimizeButton.MouseButton1Click:Connect(toggleMinimize)
    CloseButton.MouseButton1Click:Connect(function()
        playClickSound()
        ScreenGui:Destroy()
        showNotification("脚本已关闭", Color3.fromRGB(255, 0, 0))
    end)

    -- 为选项卡按钮添加点击音效
    for _, tabButton in pairs(TabButtons) do
        tabButton.MouseButton1Click:Connect(playClickSound)
    end

    -- 绑定功能按钮
    local buttonActions = {
        FlyButton = function() loadExternalScript("\108\111\97\100\115\116\114\105\110\103\40\103\97\109\101\58\72\116\116\112\71\101\116\40\40\39\104\116\116\112\115\58\47\47\103\105\115\116\46\103\105\116\104\117\98\117\115\101\114\99\111\110\116\101\110\116\46\99\111\109\47\109\101\111\122\111\110\101\89\84\47\98\102\48\51\55\100\102\102\57\102\48\97\55\48\48\49\55\51\48\52\100\100\100\54\55\102\100\99\100\51\55\48\47\114\97\119\47\101\49\52\101\55\52\102\52\50\53\98\48\54\48\100\102\53\50\51\51\52\51\99\102\51\48\98\55\56\55\48\55\52\101\98\51\99\53\100\50\47\97\114\99\101\117\115\37\50\53\50\48\120\37\50\53\50\48\102\108\121\37\50\53\50\48\50\37\50\53\50\48\111\98\102\108\117\99\97\116\111\114\39\41\44\116\114\117\101\41\41\40\41\10\10", "ARCEUS飞行") end,
        InvincibleFlyButton = function() loadExternalScript("https://rawscripts.net/raw/Universal-Script-Invinicible-Flight-R15-45414", "无敌苍蝇飞行") end,
        FakeLagButton = function() loadExternalScript("https://raw.githubusercontent.com/RENZXW/RENZXW-SCRIPTS/main/fakeLAGRENZXW.txt", "假延迟") end,
        DayunButton = function() loadExternalScript("https://raw.githubusercontent.com/3LD4D0/Crazy-Man-R6/36ec60d16bf8d208c40807aa0fd2662af76a5385/Crazy%20Man%20R6", "大运") end,
        CrawlButton = function() loadExternalScript('https://raw.githubusercontent.com/0Ben1/fe/main/obf_vZDX8j5ggfAf58QhdJ59BVEmF6nmZgq4Mcjt2l8wn16CiStIW2P6EkNc605qv9K4.lua.txt', "在地上爬") end,
        FEFacialButton = function() loadExternalScript("https://rawscripts.net/raw/Universal-Script-AFEM-14048", "FE表情") end,
        FEFighterButton = function() loadExternalScript("https://raw.githubusercontent.com/ke9460394-dot/ugik/refs/heads/main/%E5%BC%BA%E8%A1%8C%E4%B8%A2%E5%BC%83.txt", "强行装备物品") end,
        YeScriptButton = function() loadExternalScript("https://raw.githubusercontent.com/roblox-ye/QQ515966991/refs/heads/main/ROBLOX-CNVIP-XIAOYE.lua", "叶脚本") end,
        NoclipButton = toggleNoclip,
        InfiniteJumpButton = toggleInfiniteJump,
        SpeedButton = changeSpeed,
        JumpButton = changeJump,
        PlayerButton = selectPlayer,
        ClimbWallButton = toggleClimbWall,
        AntiFallButton = loadAntiFall,
        ShaScriptButton = function() loadExternalScript("https://raw.githubusercontent.com/114514lzkill/SaHUB/refs/heads/main/SaHUB", "沙脚本") end,
        FESkyboxButton = function() loadExternalScript("https://rawscripts.net/raw/Universal-Script-Fe-Emote-Player-51936", "FE天空盒") end,
        FESwordButton = function() loadExternalScript("https://raw.githubusercontent.com/GenesisFE/Genesis/main/Obfuscations/Neptunian%20V", "FE圣剑") end,
        SpinButton = toggleSpin,
        SpinSpeedButton = changeSpinSpeed,
        WalkAirButton = function() loadExternalScript("https://protected-roblox-scripts.onrender.com/2b33f845cf5c751e52c06abacaeb27e1", "踏空行走") end,
        AutoMoveButton = toggleAutoMove,
        FECrouchButton = function() loadExternalScript("https://raw.githubusercontent.com/Azizanzz0/Scripts/refs/heads/main/Crouching.txt", "FE蹲下") end,
        ClickTeleportButton = function() loadExternalScript("https://rawscripts.net/raw/Universal-Script-Teleport-Tool-25249", "点击传送") end,
        KillAllButton = killAllPlayers,
        TeleportAllButton = teleportAllToMe,
        SitSpinButton = toggleSitSpin,
        RideHeadButton = toggleRideHead,
        ViewBackpackButton = viewPlayerBackpack,
        FEHugButton = function() loadExternalScript("https://raw.githubusercontent.com/ExploitFin/Animations/refs/heads/main/Front%20and%20Back%20Hug%20Tool", "FE拥抱") end,
        PlayerSizeButton = changePlayerSize,
        RainbowButton = toggleRainbow,
        GlobalRainbowButton = toggleGlobalRainbow,
        GhostButton = toggleGhost,
        InvisibleButton = function() loadExternalScript('https://pastebin.com/raw/3Rnd9rHf', "人物隐形") end,
        GravityButton = changeGravity,
        NightVisionButton = toggleNightVision,
        FECarButton = function() loadExternalScript("https://rawscripts.net/raw/Universal-Script-FE-SILLY-CAR-V1-48227", "FE人物变车") end,
        FESpiderManButton = function() loadExternalScript("https://raw.githubusercontent.com/ke9460394-dot/ugik/refs/heads/main/%E8%9C%98%E8%9B%9B%E4%BE%A0.txt", "FE蜘蛛侠") end,
        FakeFriendButton = function() loadExternalScript("https://raw.githubusercontent.com/sigmaboy123z/MYFRIENDSCRIPT/refs/heads/main/MYNEWFRIENDSPAWNER", "假朋友") end,
        FER6AnimationsButton = function() loadExternalScript("https://rawscripts.net/raw/Universal-Script-R6-Animations-Menu-By-Me-19427", "FER6动作") end,
        FEHamsterBallButton = function() loadExternalScript("https://raw.githubusercontent.com/KaterHub-Inc/scripts/refs/heads/main/unofficial-Projects/FEHamsterBall.lua", "FE滚蛋") end,
        FEAutoPianoButton = function() loadExternalScript("https://rawscripts.net/raw/Tac's-Piano-Stuff-Talentless-script-made-by-hellohellohell012321-44088", "FE自动弹钢琴") end,
        BlackHoleV6Button = function() loadExternalScript("https://raw.githubusercontent.com/ke9460394-dot/ugik/refs/heads/main/V6.txt", "黑洞v6") end,
        BlackHoleV4Button = function() loadExternalScript("https://raw.githubusercontent.com/ke9460394-dot/ugik/refs/heads/main/V4.txt", "黑洞v4") end,
        BlackHoleV1Button = function() loadExternalScript("https://raw.githubusercontent.com/ke9460394-dot/ugik/refs/heads/main/V1.lua.txt", "黑洞v1") end,
        FEControlNPCButton = function() loadExternalScript("https://raw.githubusercontent.com/randomstring0/fe-source/refs/heads/main/NPC/source/main.Luau", "FE控制NPC") end,
        FEForsakenAnimButton = function() loadExternalScript("https://raw.githubusercontent.com/CyberNinja103/brodwa/refs/heads/main/ForsakationHub", "FE被遗弃动作") end,
        ChatDrawButton = function() loadExternalScript("https://raw.githubusercontent.com/ocfi/_/refs/heads/main/a", "聊天框画画") end,
        FE096Button = function() loadExternalScript("https://github.com/Sinister-Scripts/Roblox-Exploits/raw/refs/heads/main/FE-Animation-GUI-R6", "FE合集") end,
        FEHam00dButton = function() loadExternalScript("https://rawscripts.net/raw/Universal-Script-sb-56309", "fe ham00d菜单") end,
        TrainEffectButton = function() loadExternalScript("https://raw.githubusercontent.com/ke9460394-dot/ugik/refs/heads/main/%E8%B6%8A%E8%B7%91%E8%B6%8A%E5%BF%AB.txt", "火车头效果") end,
        FreePrivateServerButton = function() loadExternalScript("https://raw.githubusercontent.com/ke9460394-dot/ugik/refs/heads/main/Kenny免费私服.lua", "免费私服") end,
        PiScriptButton = function() 
            playClickSound()
            getgenv().XiaoPi = "皮脚本QQ群1002100032"
            loadstring(game:HttpGet("https://raw.githubusercontent.com/xiaopi77/xiaopi77/main/QQ1002100032-Roblox-Pi-script.lua"))()
            showNotification("皮脚本已加载!", Color3.fromRGB(0, 200, 0))
        end,
        CaodanButton = function() loadExternalScript("https://pastebin.com/raw/hkyuHQ7Y", "操蛋脚本") end,
        ScriptCenterButton = function() 
            playClickSound()
            loadstring(utf8.char((function() return table.unpack({108,111,97,100,115,116,114,105,110,103,40,103,97,109,101,58,72,116,116,112,71,101,116,40,34,104,116,116,112,115,58,47,47,114,97,119,46,103,105,116,104,117,98,117,115,101,114,99,111,110,116,101,110,116,46,99,111,109,47,67,104,105,110,97,81,89,47,45,47,109,97,105,110,47,37,69,54,37,56,51,37,56,53,37,69,52,37,66,65,37,57,49,34,41,41,40,41})end)()))()
            showNotification("脚本中心已加载!", Color3.fromRGB(0, 200, 0))
        end,
        HackButton = applyHackEffects,
        UIColorButton = changeUIColor,
        SuicideButton = suicide,
        StealBrainRedButton = loadStealBrainRed,
        GardenButton = loadGarden,
        OhioButton = loadOhio,
        ForsakenButton = loadForsaken,
        ThrowFlyButton = loadThrowFly,
        CatAnimButton = loadCatAnim,
        InvincibleButton = loadInvincible,
        BeatDogButton = loadBeatDog,
        FEAK47Button = loadFEAK47,
        FESniperButton = loadFESniper,
        ChenScriptButton = loadChenScript
    }

    for buttonName, action in pairs(buttonActions) do
        if ButtonInstances[buttonName] then
            ButtonInstances[buttonName].MouseButton1Click:Connect(action)
        end
    end

    -- 启动动画（透明背景）
    local startupFrame = Instance.new("Frame")
    startupFrame.Size = UDim2.new(1, 0, 1, 0)
    startupFrame.BackgroundTransparency = 1 -- 透明背景
    startupFrame.ZIndex = 100
    startupFrame.Parent = ScreenGui
    
    local startupLabel = Instance.new("TextLabel")
    startupLabel.Size = UDim2.new(0, 300, 0, 100) -- 改小尺寸
    startupLabel.Position = UDim2.new(0.5, -150, 0.5, -50)
    startupLabel.BackgroundTransparency = 1
    startupLabel.Text = "培根脚本 v6.3\n加载中..."
    startupLabel.TextColor3 = Color3.fromRGB(0, 255, 255)
    startupLabel.TextSize = 24 -- 减小字体
    startupLabel.Font = Enum.Font.GothamBold
    startupLabel.ZIndex = 101
    startupLabel.Parent = startupFrame

    spawn(function()
        for i = 1, 5 do
            startupLabel.Text = "培根脚本 v6.3\n加载中" .. string.rep(".", i)
            wait(0.5)
        end
        startupLabel.Text = "培根脚本 v6.3\n加载完成!"
        TweenService:Create(startupLabel, TweenInfo.new(1.5), {TextTransparency = 1}):Play()
        wait(1.5)
        startupFrame:Destroy()
        
        MainFrame.Visible = true
        MainFrame.Position = UDim2.new(1.5, -350, 0.5, -225)
        TweenService:Create(MainFrame, TweenInfo.new(0.8), {Position = UDim2.new(0.5, -350, 0.5, -225)}):Play()
        
        showNotification("培根脚本 v6.3 已加载!", Color3.fromRGB(0, 200, 255))
        
        -- 初始设置
        local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = walkSpeed
            humanoid.JumpPower = jumpPower
        end
        
        selectPlayer()
    end)

    -- 角色重生处理
    LocalPlayer.CharacterAdded:Connect(function()
        wait(2)
        local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = walkSpeed
            humanoid.JumpPower = jumpPower
        end
    end)
end

-- 安全执行
local success, err = pcall(loadScript)
if not success then
    warn("脚本加载错误: " .. err)
end
