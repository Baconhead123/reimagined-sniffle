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
        SoundService = game:GetService("SoundService"),
        HttpService = game:GetService("HttpService")
    }
    
    local Players, RunService, UserInputService, TweenService, Workspace, CoreGui, Lighting, SoundService, HttpService = 
        Services.Players, Services.RunService, Services.UserInputService, Services.TweenService, 
        Services.Workspace, Services.CoreGui, Services.Lighting, Services.SoundService, Services.HttpService
    
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
    
    -- 主窗口（减小三分之一）
    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 467, 0, 300)
    MainFrame.Position = UDim2.new(0.5, -233.5, 0.5, -150)
    MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 60)
    MainFrame.BackgroundTransparency = 0.1
    MainFrame.BorderSizePixel = 0
    MainFrame.Active = true
    MainFrame.Draggable = true
    MainFrame.Visible = false
    MainFrame.Parent = ScreenGui
    
    -- 添加阴影效果
    local Shadow = Instance.new("ImageLabel")
    Shadow.Size = UDim2.new(1, 13, 1, 13)
    Shadow.Position = UDim2.new(0, -6.5, 0, -6.5)
    Shadow.BackgroundTransparency = 1
    Shadow.Image = "rbxassetid://5554236805"
    Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    Shadow.ImageTransparency = 0.7
    Shadow.ScaleType = Enum.ScaleType.Slice
    Shadow.SliceCenter = Rect.new(10, 10, 118, 118)
    Shadow.Parent = MainFrame
    
    -- 增强圆角效果
    local MainCorner = Instance.new("UICorner", MainFrame)
    MainCorner.CornerRadius = UDim.new(0, 11)
    
    local MainStroke = Instance.new("UIStroke", MainFrame)
    MainStroke.Color = Color3.fromRGB(0, 150, 255)
    MainStroke.Thickness = 1.3
    
    -- 背景图片（保留原本UI背景）
    local BackgroundImage = Instance.new("ImageLabel")
    BackgroundImage.Size = UDim2.new(1, 0, 1, 0)
    BackgroundImage.BackgroundTransparency = 1
    BackgroundImage.Image = "rbxassetid://78752306566484"
    BackgroundImage.ImageTransparency = 0.3
    BackgroundImage.ScaleType = Enum.ScaleType.Crop
    BackgroundImage.ZIndex = 1
    Instance.new("UICorner", BackgroundImage).CornerRadius = UDim.new(0, 11)
    BackgroundImage.Parent = MainFrame
    
    -- 标题栏
    local TitleBar = Instance.new("Frame")
    TitleBar.Size = UDim2.new(1, 0, 0, 27)
    TitleBar.BackgroundColor3 = Color3.fromRGB(20, 20, 40)
    TitleBar.BackgroundTransparency = 0.2
    TitleBar.BorderSizePixel = 0
    TitleBar.ZIndex = 5
    Instance.new("UICorner", TitleBar).CornerRadius = UDim.new(0, 11)
    TitleBar.Parent = MainFrame
    
    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Size = UDim2.new(1, -67, 1, 0)
    TitleLabel.Position = UDim2.new(0, 10, 0, 0)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = "培根脚本 v6.4"
    TitleLabel.TextColor3 = Color3.fromRGB(0, 255, 255)
    TitleLabel.TextSize = 20
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.ZIndex = 6
    TitleLabel.Parent = TitleBar
    
    -- 控制按钮
    local MinimizeButton = Instance.new("TextButton")
    MinimizeButton.Size = UDim2.new(0, 20, 0, 20)
    MinimizeButton.Position = UDim2.new(1, -47, 0, 3.5)
    MinimizeButton.BackgroundColor3 = Color3.fromRGB(0, 150, 200)
    MinimizeButton.BackgroundTransparency = 0.2
    MinimizeButton.Text = "_"
    MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    MinimizeButton.TextSize = 16
    MinimizeButton.Font = Enum.Font.GothamBold
    MinimizeButton.ZIndex = 6
    Instance.new("UICorner", MinimizeButton).CornerRadius = UDim.new(0, 5.3)
    MinimizeButton.Parent = TitleBar

    local CloseButton = Instance.new("TextButton")
    CloseButton.Size = UDim2.new(0, 20, 0, 20)
    CloseButton.Position = UDim2.new(1, -23.5, 0, 3.5)
    CloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    CloseButton.BackgroundTransparency = 0.2
    CloseButton.Text = "X"
    CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseButton.TextSize = 14
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.ZIndex = 6
    Instance.new("UICorner", CloseButton).CornerRadius = UDim.new(0, 5.3)
    CloseButton.Parent = TitleBar
    
    -- 选项卡区域（左侧）- 修改为可滚动
    local TabFrame = Instance.new("Frame")
    TabFrame.Size = UDim2.new(0, 100, 1, -27)
    TabFrame.Position = UDim2.new(0, 0, 0, 27)
    TabFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 50)
    TabFrame.BackgroundTransparency = 0.2
    TabFrame.ZIndex = 3
    Instance.new("UICorner", TabFrame).CornerRadius = UDim.new(0, 11)
    TabFrame.Parent = MainFrame
    
    -- 主内容区域（右侧）
    local MainContent = Instance.new("Frame")
    MainContent.Size = UDim2.new(1, -100, 1, -27)
    MainContent.Position = UDim2.new(0, 100, 0, 27)
    MainContent.BackgroundTransparency = 1
    MainContent.ZIndex = 3
    MainContent.Parent = MainFrame
    
    -- 选项卡（重新组织，按你的要求重新排序）
    local Tabs = {
        "公告", "搜索功能", "基础功能", "移动功能", "玩家交互", "外观功能", "世界功能", 
        "FE功能", "黑洞功能", "其他脚本", "doors", "偷走脑红", "种植花园", 
        "其他脚本整合", "免费r币", "死亡之死", "被遗弃", "无敌少侠飞行"
    }
    local TabButtons = {}
    local CurrentTab = "公告"
    
    -- 创建可滚动的选项卡容器
    local TabScrolling = Instance.new("ScrollingFrame")
    TabScrolling.Size = UDim2.new(1, 0, 1, 0)
    TabScrolling.Position = UDim2.new(0, 0, 0, 0)
    TabScrolling.BackgroundTransparency = 1
    TabScrolling.BorderSizePixel = 0
    TabScrolling.ScrollBarThickness = 4
    TabScrolling.ScrollBarImageColor3 = Color3.fromRGB(0, 150, 255)
    TabScrolling.CanvasSize = UDim2.new(0, 0, 0, 0)
    TabScrolling.AutomaticCanvasSize = Enum.AutomaticSize.Y
    TabScrolling.ZIndex = 4
    TabScrolling.Parent = TabFrame
    
    local TabLayout = Instance.new("UIListLayout", TabScrolling)
    TabLayout.Padding = UDim.new(0, 3.3)
    
    Instance.new("UIPadding", TabScrolling).PaddingTop = UDim.new(0, 6.7)
    Instance.new("UIPadding", TabScrolling).PaddingLeft = UDim.new(0, 3.3)
    Instance.new("UIPadding", TabScrolling).PaddingRight = UDim.new(0, 3.3)
    Instance.new("UIPadding", TabScrolling).PaddingBottom = UDim.new(0, 6.7)

    for i, tabName in ipairs(Tabs) do
        local tabButton = Instance.new("TextButton")
        tabButton.Size = UDim2.new(1, -6.7, 0, 23.3)
        tabButton.BackgroundColor3 = Color3.fromRGB(40, 40, 80)
        tabButton.BackgroundTransparency = 0.3
        tabButton.Text = tabName
        tabButton.TextColor3 = Color3.fromRGB(200, 200, 255)
        tabButton.TextSize = 12
        tabButton.Font = Enum.Font.Gotham
        tabButton.ZIndex = 5
        tabButton.AutoButtonColor = false
        Instance.new("UICorner", tabButton).CornerRadius = UDim.new(0, 6.7)
        tabButton.Parent = TabScrolling
        TabButtons[tabName] = tabButton
    end
    
    -- 内容区域（使用列表布局，单列按钮）
    local ContentScrolling = Instance.new("ScrollingFrame")
    ContentScrolling.Size = UDim2.new(1, -6.7, 1, -6.7)
    ContentScrolling.Position = UDim2.new(0, 3.3, 0, 3.3)
    ContentScrolling.BackgroundTransparency = 1
    ContentScrolling.ScrollBarThickness = 4
    ContentScrolling.ScrollBarImageColor3 = Color3.fromRGB(0, 150, 255)
    ContentScrolling.CanvasSize = UDim2.new(0, 0, 0, 0)
    ContentScrolling.AutomaticCanvasSize = Enum.AutomaticSize.Y
    ContentScrolling.ZIndex = 4
    ContentScrolling.Parent = MainContent
    
    -- 使用UIListLayout
    local ContentList = Instance.new("UIListLayout", ContentScrolling)
    ContentList.Padding = UDim.new(0, 5.3)
    ContentList.SortOrder = Enum.SortOrder.LayoutOrder
    
    Instance.new("UIPadding", ContentScrolling).PaddingLeft = UDim.new(0, 3.3)
    Instance.new("UIPadding", ContentScrolling).PaddingRight = UDim.new(0, 3.3)
    Instance.new("UIPadding", ContentScrolling).PaddingTop = UDim.new(0, 3.3)
    
    -- 创建按钮函数（单列按钮）
    local function createButton(text, description)
        local buttonFrame = Instance.new("Frame")
        buttonFrame.Size = UDim2.new(1, -6.7, 0, 30)
        buttonFrame.BackgroundTransparency = 1
        buttonFrame.LayoutOrder = #ContentScrolling:GetChildren()
        
        local button = Instance.new("TextButton")
        button.Size = UDim2.new(1, 0, 1, 0)
        button.BackgroundColor3 = Color3.fromRGB(50, 50, 100)
        button.BackgroundTransparency = 0.3
        button.Text = text
        button.TextColor3 = Color3.fromRGB(200, 200, 255)
        button.TextSize = 12
        button.Font = Enum.Font.Gotham
        button.AutoButtonColor = false
        button.ZIndex = 5
        button.TextWrapped = true
        Instance.new("UICorner", button).CornerRadius = UDim.new(0, 8)
        local buttonStroke = Instance.new("UIStroke", button)
        buttonStroke.Color = Color3.fromRGB(100, 100, 200)
        button.Parent = buttonFrame
        
        if description then
            button.MouseEnter:Connect(function()
                local tooltip = Instance.new("TextLabel")
                tooltip.Size = UDim2.new(0, 107, 0, 0)
                tooltip.Position = UDim2.new(0, -53.5, 1, 3.3)
                tooltip.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
                tooltip.BackgroundTransparency = 0.1
                tooltip.Text = description
                tooltip.TextColor3 = Color3.fromRGB(200, 200, 255)
                tooltip.TextSize = 11
                tooltip.TextWrapped = true
                tooltip.ZIndex = 100
                tooltip.Visible = false
                Instance.new("UICorner", tooltip).CornerRadius = UDim.new(0, 5.3)
                Instance.new("UIStroke", tooltip).Color = Color3.fromRGB(0, 150, 255)
                tooltip.Parent = buttonFrame
                
                tooltip.Visible = true
                TweenService:Create(tooltip, TweenInfo.new(0.2), {Size = UDim2.new(0, 107, 0, 33.3)}):Play()
            end)
            
            button.MouseLeave:Connect(function()
                local tooltip = buttonFrame:FindFirstChildWhichIsA("TextLabel")
                if tooltip then
                    TweenService:Create(tooltip, TweenInfo.new(0.2), {Size = UDim2.new(0, 107, 0, 0)}):Play()
                    wait(0.2)
                    tooltip:Destroy()
                end
            end)
        end
        
        button.MouseEnter:Connect(function()
            button.BackgroundTransparency = 0.1
            buttonStroke.Thickness = 1.3
        end)
        
        button.MouseLeave:Connect(function()
            button.BackgroundTransparency = 0.3
            buttonStroke.Thickness = 0.7
        end)
        
        return buttonFrame, button
    end

    -- 重新组织功能分类（按照你的要求）
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
            {name = "FlyButton", text = "飞行v2 [关闭]", desc = "点击开启/关闭飞行模式"},
            {name = "InvincibleButton", text = "无敌 [关闭]", desc = "开启无敌模式"},
            {name = "CollisionBoxButton", text = "显示碰撞箱 [关闭]", desc = "显示物体碰撞箱"},
            {name = "WalkAirButton", text = "踏空行走 [关闭]", desc = "在空中行走"}
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
            {name = "ClickTeleportButton", text = "点击传送", desc = "加载点击传送工具脚本"},
            {name = "AimbotButton", text = "可关闭的自瞄 [关闭]", desc = "自动瞄准最近玩家，可选头部/身体"}
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
            {name = "FESkyboxButton", text = "FE天空盒 (要买UGC卡密：113633503026070)", desc = "加载FE天空盒脚本"},
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
            {name = "FEAK47Button", text = "FE AK47", desc = "加载FE AK47脚本"},
            {name = "FESniperButton", text = "FE 狙击枪", desc = "加载FE狙击枪脚本"},
            {name = "FER6DeerCanButton", text = "FEr6鹿罐", desc = "加载FEr6鹿罐脚本"},
            {name = "FER15DeerCanButton", text = "FEr15鹿罐", desc = "加载FEr15鹿罐脚本"},
            {name = "FECoolKidButton", text = "FE酷小孩", desc = "加载FE酷小孩脚本"},
            {name = "FEJasonButton", text = "FE杰森", desc = "加载FE杰森脚本"},
            {name = "FESnakeButton", text = "FE蛇", desc = "加载FE蛇脚本"},
            {name = "FEBaseballPlayerButton", text = "FE棒球手", desc = "加载FE棒球手脚本"},
            {name = "FEVRButton", text = "FE vr", desc = "加载FE vr脚本"}
        },
        ["黑洞功能"] = {
            {name = "BlackHoleV6Button", text = "黑洞v6", desc = "加载黑洞v6脚本"},
            {name = "BlackHoleV5Button", text = "黑洞v5", desc = "加载黑洞v5脚本"},
            {name = "BlackHoleV4Button", text = "黑洞v4", desc = "加载黑洞v4脚本"},
            {name = "BlackHoleV3Button", text = "黑洞v3", desc = "加载黑洞v3脚本"},
            {name = "BlackHoleV2Button", text = "黑洞v2", desc = "加载黑洞v2脚本"},
            {name = "BlackHoleV1Button", text = "黑洞v1", desc = "加载黑洞v1脚本"}
        },
        ["其他脚本"] = {
            {name = "FakeLagButton", text = "假延迟", desc = "加载假延迟脚本"},
            {name = "DayunButton", text = "大运", desc = "加载大运脚本"},
            {name = "CrawlButton", text = "在地上爬", desc = "加载在地上爬脚本"},
            {name = "FEFighterButton", text = "强行装备物品", desc = "强行装备物品脚本"},
            {name = "InvisibleButton", text = "人物隐形脚本", desc = "加载人物隐形脚本"},
            {name = "FakeFriendButton", text = "假朋友", desc = "生成假朋友NPC"},
            {name = "ChatDrawButton", text = "在聊天框画画", desc = "在聊天框中绘制图案"},
            {name = "TrainEffectButton", text = "火车头效果", desc = "加载火车头效果脚本"},
            {name = "FreePrivateServerButton", text = "免费私服", desc = "加载免费私服脚本"},
            {name = "CaodanButton", text = "操蛋", desc = "加载操蛋脚本"},
            {name = "OhioButton", text = "俄亥俄州脚本", desc = "加载俄亥俄州脚本"},
            {name = "ThrowFlyButton", text = "甩飞脚本", desc = "加载甩飞脚本"},
            {name = "BeatDogButton", text = "Kenny悦服循环打狗", desc = "加载Kenny悦服循环打狗脚本"},
            {name = "WitherStormButton", text = "凋零风暴", desc = "加载凋零风暴脚本"},
            {name = "BurstScriptButton", text = "爆燃脚本", desc = "加载爆燃脚本"},
            {name = "BootCheckButton", text = "开机检测", desc = "加载开机检测脚本"},
            {name = "CalculatorButton", text = "计算器", desc = "加载计算器脚本"},
            {name = "ChatBubbleBeautifyButton", text = "聊天气泡美化", desc = "加载聊天气泡美化脚本"},
            {name = "C00lkidBlackShellButton", text = "c00lkid黑壳", desc = "加载c00lkid黑壳脚本"},
            {name = "ChatTranslatorButton", text = "聊天翻译器", desc = "加载聊天翻译器脚本"},
            {name = "KennyAutoTranslateButton", text = "kenny自动汉化", desc = "加载kenny自动汉化脚本"},
            {name = "MindPullButton", text = "心灵牵引", desc = "加载心灵牵引脚本"},
            {name = "TelepathyButton", text = "心灵感应", desc = "加载心灵感应脚本"},
            {name = "FishScriptButton", text = "鱼脚本", desc = "加载鱼脚本"},
            {name = "Forest99NightDiamondButton", text = "森林99夜刷钻石", desc = "加载森林99夜刷钻石脚本"},
            {name = "NicoNextbotButton", text = "nico' Nextbot", desc = "加载nico' Nextbot脚本"},
            {name = "ShipTreasureButton", text = "造船寻宝", desc = "加载造船寻宝脚本"},
            {name = "SpeedLegendButton", text = "极速传奇", desc = "加载极速传奇脚本"},
            {name = "WallRunButton", text = "飞檐走壁", desc = "加载飞檐走壁脚本"},
            {name = "NaturalDisasterButton", text = "自然灾害", desc = "加载自然灾害脚本"},
            {name = "MuscleLegendButton", text = "力量传奇", desc = "加载力量传奇脚本"},
            {name = "MuscleLegendChangeButton", text = "力量传奇改力量", desc = "加载力量传奇改力量脚本"}
        },
        ["doors"] = {
            {name = "DoorsButton", text = "doors", desc = "加载doors脚本"},
            {name = "DoorsModeButton", text = "doors模式", desc = "加载doors模式脚本"},
            {name = "DoorsHardcoreModeButton", text = "doors硬核模式", desc = "加载doors硬核模式脚本"},
            {name = "DoorsAutoAvoidButton", text = "doors自动躲怪全图高亮", desc = "加载doors自动躲怪全图高亮脚本"},
            {name = "DoorsExtremeModeButton", text = "doors极端模式", desc = "加载doors极端模式脚本"}
        },
        ["偷走脑红"] = {
            {name = "StealBrainRedButton", text = "偷走脑红", desc = "加载偷走脑红脚本"},
            {name = "StealBrainRedRainbowButton", text = "偷走脑红彩虹板", desc = "加载偷走脑红彩虹板脚本"},
            {name = "StealBrainRedBigBoardButton", text = "偷走脑红大板子", desc = "加载偷走脑红大板子脚本"}
        },
        ["种植花园"] = {
            {name = "GardenButton", text = "种植花园", desc = "加载种植花园脚本"}
        },
        ["其他脚本整合"] = {
            {name = "PiScriptButton", text = "皮脚本", desc = "加载皮脚本"},
            {name = "YeScriptButton", text = "叶脚本", desc = "加载叶脚本"},
            {name = "ChuScriptButton", text = "初脚本", desc = "加载初脚本"},
            {name = "DingScriptButton", text = "丁脚本", desc = "加载丁脚本"},
            {name = "ScriptCenterButton", text = "脚本中心", desc = "加载脚本中心"},
            {name = "ChenScriptButton", text = "辰脚本", desc = "加载辰脚本"},
            {name = "ShaScriptButton", text = "沙脚本", desc = "加载沙脚本"}
        },
        ["免费r币"] = {
            {name = "Free80RButton", text = "免费80r培根独家", desc = "点击获取免费80r币奖励"},
            {name = "Free120RButton", text = "免费120r培根独家", desc = "点击获取免费120r币奖励"},
            {name = "Free240RButton", text = "免费240r培根独家", desc = "点击获取免费240r币奖励"},
            {name = "Free400RButton", text = "免费400r培根独家", desc = "点击获取免费400r币奖励"},
            {name = "Free500RButton", text = "免费500r培根独家", desc = "点击获取免费500r币奖励"},
            {name = "Free1000RButton", text = "免费1000r培根独家", desc = "点击获取免费1000r币奖励"},
            {name = "Free450RPlusButton", text = "免费450r+一个月会员培根独家", desc = "点击获取免费450r币+一个月会员"},
            {name = "Free1200RPlusButton", text = "免费1200r+一个月会员培根独家", desc = "点击获取免费1200r币+一个月会员"}
        },
        ["死亡之死"] = {
            {name = "DeathOfDeathButton", text = "死亡之死", desc = "加载死亡之死脚本"}
        },
        ["被遗弃"] = {
            {name = "ForsakenButton", text = "被遗弃脚本", desc = "加载被遗弃脚本"},
            {name = "ForsakenScript2Button", text = "被遗弃脚本二", desc = "加载被遗弃脚本二"}
        },
        ["无敌少侠飞行"] = {
            {name = "InvincibleFlyR15Button", text = "无敌少侠飞行r15 [关闭]", desc = "R15角色无敌飞行模式"},
            {name = "InvincibleFlyR6Button", text = "无敌少侠飞行r6 [关闭]", desc = "R6角色无敌飞行模式"}
        },
        ["搜索功能"] = {
            -- 搜索功能将在后面特殊处理
        }
    }

    -- 创建按钮
    local ButtonInstances = {}
    local ButtonFrames = {}
    
    for tabName, functions in pairs(FunctionTabs) do
        for _, func in ipairs(functions) do
            local buttonFrame, button = createButton(func.text, func.desc)
            buttonFrame.Parent = ContentScrolling
            buttonFrame.Visible = false
            ButtonInstances[func.name] = button
            ButtonFrames[func.name] = buttonFrame
        end
    end

    -- 搜索功能界面
    local SearchContent = Instance.new("Frame")
    SearchContent.Size = UDim2.new(1, 0, 1, 0)
    SearchContent.BackgroundTransparency = 1
    SearchContent.Visible = false
    SearchContent.ZIndex = 4
    SearchContent.Parent = MainContent
    
    -- 搜索框
    local SearchBox = Instance.new("TextBox")
    SearchBox.Size = UDim2.new(1, -13.3, 0, 30)
    SearchBox.Position = UDim2.new(0, 6.7, 0, 3.3)
    SearchBox.BackgroundColor3 = Color3.fromRGB(40, 40, 80)
    SearchBox.BackgroundTransparency = 0.2
    SearchBox.TextColor3 = Color3.fromRGB(200, 200, 255)
    SearchBox.PlaceholderText = "输入关键字搜索功能..."
    SearchBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 200)
    SearchBox.TextSize = 12
    SearchBox.Font = Enum.Font.Gotham
    SearchBox.ZIndex = 5
    Instance.new("UICorner", SearchBox).CornerRadius = UDim.new(0, 8)
    Instance.new("UIStroke", SearchBox).Color = Color3.fromRGB(0, 150, 255)
    SearchBox.Parent = SearchContent
    
    -- 搜索按钮
    local SearchButton = Instance.new("TextButton")
    SearchButton.Size = UDim2.new(0, 60, 0, 30)
    SearchButton.Position = UDim2.new(1, -66.7, 0, 3.3)
    SearchButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
    SearchButton.BackgroundTransparency = 0.2
    SearchButton.Text = "搜索"
    SearchButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    SearchButton.TextSize = 12
    SearchButton.Font = Enum.Font.GothamBold
    SearchButton.ZIndex = 5
    Instance.new("UICorner", SearchButton).CornerRadius = UDim.new(0, 8)
    SearchButton.Parent = SearchContent
    
    -- 搜索结果区域
    local SearchResultsScrolling = Instance.new("ScrollingFrame")
    SearchResultsScrolling.Size = UDim2.new(1, -6.7, 1, -40)
    SearchResultsScrolling.Position = UDim2.new(0, 3.3, 0, 40)
    SearchResultsScrolling.BackgroundTransparency = 1
    SearchResultsScrolling.ScrollBarThickness = 4
    SearchResultsScrolling.ScrollBarImageColor3 = Color3.fromRGB(0, 150, 255)
    SearchResultsScrolling.CanvasSize = UDim2.new(0, 0, 0, 0)
    SearchResultsScrolling.AutomaticCanvasSize = Enum.AutomaticSize.Y
    SearchResultsScrolling.ZIndex = 4
    SearchResultsScrolling.Parent = SearchContent
    
    local SearchResultsList = Instance.new("UIListLayout", SearchResultsScrolling)
    SearchResultsList.Padding = UDim.new(0, 5.3)
    
    Instance.new("UIPadding", SearchResultsScrolling).PaddingLeft = UDim.new(0, 3.3)
    Instance.new("UIPadding", SearchResultsScrolling).PaddingRight = UDim.new(0, 3.3)
    Instance.new("UIPadding", SearchResultsScrolling).PaddingTop = UDim.new(0, 3.3)

    -- 公告内容框架
    local AnnouncementScrolling = Instance.new("ScrollingFrame")
    AnnouncementScrolling.Size = UDim2.new(1, -6.7, 1, -6.7)
    AnnouncementScrolling.Position = UDim2.new(0, 3.3, 0, 3.3)
    AnnouncementScrolling.BackgroundTransparency = 1
    AnnouncementScrolling.ScrollBarThickness = 4
    AnnouncementScrolling.ScrollBarImageColor3 = Color3.fromRGB(0, 150, 255)
    AnnouncementScrolling.CanvasSize = UDim2.new(0, 0, 0, 0)
    AnnouncementScrolling.AutomaticCanvasSize = Enum.AutomaticSize.Y
    AnnouncementScrolling.ZIndex = 4
    AnnouncementScrolling.Parent = MainContent
    
    local AnnouncementList = Instance.new("UIListLayout", AnnouncementScrolling)
    AnnouncementList.Padding = UDim.new(0, 8)
    AnnouncementList.SortOrder = Enum.SortOrder.LayoutOrder
    
    Instance.new("UIPadding", AnnouncementScrolling).PaddingLeft = UDim.new(0, 5)
    Instance.new("UIPadding", AnnouncementScrolling).PaddingRight = UDim.new(0, 5)
    Instance.new("UIPadding", AnnouncementScrolling).PaddingTop = UDim.new(0, 5)
    
    -- 获取玩家账户年龄
    local playerAge = "未知"
    local success, ageResult = pcall(function()
        return LocalPlayer.AccountAge
    end)
    if success then
        playerAge = tostring(ageResult) .. " 天"
    end
    
    -- 公告文本内容
    local announcementLines = {
        "此脚本为缝合完全免费，禁止倒卖，倒卖死全家全家操逼",
        "",
        "玩家名字: " .. LocalPlayer.Name,
        "",
        "玩家账户年龄: " .. playerAge,
        "脚本加载延迟或者加载不出来不是我的问题",
        ""
    }
    
    -- 创建公告文本
    for i, line in ipairs(announcementLines) do
        local textLabel = Instance.new("TextLabel")
        textLabel.Size = UDim2.new(1, 0, 0, 20)
        textLabel.BackgroundTransparency = 1
        textLabel.Text = line
        textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        textLabel.TextSize = 14
        textLabel.Font = Enum.Font.GothamBold
        textLabel.TextWrapped = true
        textLabel.ZIndex = 5
        textLabel.Parent = AnnouncementScrolling
    end
    
    -- 创建神秘猫图片框架
    local catImageFrame = Instance.new("Frame")
    catImageFrame.Size = UDim2.new(1, 0, 0, 90)
    catImageFrame.BackgroundTransparency = 1
    catImageFrame.LayoutOrder = #AnnouncementScrolling:GetChildren()
    catImageFrame.Parent = AnnouncementScrolling
    
    -- 神秘猫图片
    local catImage = Instance.new("ImageLabel")
    catImage.Size = UDim2.new(1, 0, 0, 70)
    catImage.BackgroundColor3 = Color3.fromRGB(50, 50, 100)
    catImage.BackgroundTransparency = 0.3
    catImage.Image = "rbxassetid://131184246499429"
    catImage.ScaleType = Enum.ScaleType.Crop
    catImage.ZIndex = 5
    Instance.new("UICorner", catImage).CornerRadius = UDim.new(0, 8)
    local catStroke = Instance.new("UIStroke", catImage)
    catStroke.Color = Color3.fromRGB(100, 100, 200)
    catImage.Parent = catImageFrame
    
    -- 图片底下的文字
    local catText = Instance.new("TextLabel")
    catText.Size = UDim2.new(1, 0, 0, 20)
    catText.Position = UDim2.new(0, 0, 0, 70)
    catText.BackgroundTransparency = 1
    catText.Text = "神秘的猫"
    catText.TextColor3 = Color3.fromRGB(200, 200, 255)
    catText.TextSize = 12
    catText.Font = Enum.Font.GothamBold
    catText.ZIndex = 5
    catText.Parent = catImageFrame
    
    -- 最后一行文本
    local lastText = Instance.new("TextLabel")
    lastText.Size = UDim2.new(1, 0, 0, 20)
    lastText.BackgroundTransparency = 1
    lastText.Text = "脚本作者: Bacon head"
    lastText.TextColor3 = Color3.fromRGB(255, 255, 255)
    lastText.TextSize = 14
    lastText.Font = Enum.Font.GothamBold
    lastText.TextWrapped = true
    lastText.ZIndex = 5
    lastText.Parent = AnnouncementScrolling
    
    -- 选项卡切换
    for tabName, tabButton in pairs(TabButtons) do
        tabButton.MouseButton1Click:Connect(function()
            CurrentTab = tabName
            
            if tabName == "公告" then
                AnnouncementScrolling.Visible = true
                ContentScrolling.Visible = false
                SearchContent.Visible = false
            elseif tabName == "搜索功能" then
                AnnouncementScrolling.Visible = false
                ContentScrolling.Visible = false
                SearchContent.Visible = true
                SearchBox:CaptureFocus()
            else
                AnnouncementScrolling.Visible = false
                ContentScrolling.Visible = true
                SearchContent.Visible = false
                
                -- 隐藏所有按钮
                for name, frame in pairs(ButtonFrames) do
                    frame.Visible = false
                end
                
                -- 显示当前选项卡的按钮
                if FunctionTabs[tabName] then
                    for _, func in ipairs(FunctionTabs[tabName]) do
                        if ButtonFrames[func.name] then
                            ButtonFrames[func.name].Visible = true
                        end
                    end
                end
            end
            
            -- 更新选项卡按钮颜色
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

    -- 默认显示公告
    TabButtons["公告"].BackgroundColor3 = Color3.fromRGB(0, 150, 255)
    TabButtons["公告"].TextColor3 = Color3.fromRGB(255, 255, 255)
    AnnouncementScrolling.Visible = true
    ContentScrolling.Visible = false
    SearchContent.Visible = false

    -- 功能变量
    local noclip, infiniteJump, spinning, walkAir, flying, invincible, showCollision = false, false, false, false, false, false, false
    local rainbow, globalRainbow, ghost, sitSpinning, ridingHead = false, false, false, false, false
    local climbing, autoMove, nightVision, aimbotEnabled = false, false, false, false
    local walkSpeed, jumpPower, spinSpeed, playerSize, gravity, sitSpinSpeed = 16, 50, 10, 1, 196.2, 5
    local selectedPlayer = nil
    local connections = {}
    local originalTransparency, originalColors = {}
    local originalLightingSettings = {}
    local aimbotTarget = nil
    local aimToHead = true -- 默认瞄准头部

    -- 播放点击音效函数
    local function playClickSound()
        local sound = Instance.new("Sound")
        sound.SoundId = "rbxassetid://82845990304289"
        sound.Volume = 0.5
        sound.Parent = Workspace
        sound:Play()
        game:GetService("Debris"):AddItem(sound, 2)
    end

    -- 通知函数（减小通知尺寸）
    local function showNotification(message, color)
        local notification = Instance.new("Frame")
        notification.Size = UDim2.new(0, 200, 0, 40)
        notification.Position = UDim2.new(0.5, -100, 0.1, 0)
        notification.BackgroundColor3 = color
        notification.BackgroundTransparency = 0.2
        notification.ZIndex = 100
        Instance.new("UICorner", notification).CornerRadius = UDim.new(0, 8)
        Instance.new("UIStroke", notification).Color = Color3.fromRGB(255, 255, 255)
        notification.Parent = ScreenGui
        
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, -13.3, 1, -6.7)
        label.Position = UDim2.new(0, 6.7, 0, 3.3)
        label.BackgroundTransparency = 1
        label.Text = message
        label.TextColor3 = Color3.fromRGB(255, 255, 255)
        label.TextSize = 16
        label.Font = Enum.Font.GothamBold
        label.TextWrapped = true
        label.Parent = notification
        
        notification.Position = UDim2.new(0.5, -100, 0, -46.7)
        TweenService:Create(notification, TweenInfo.new(0.5), {Position = UDim2.new(0.5, -100, 0.1, 0)}):Play()
        
        wait(3)
        TweenService:Create(notification, TweenInfo.new(0.5), {Position = UDim2.new(0.5, -100, 0, -46.7)}):Play()
        wait(0.5)
        notification:Destroy()
    end

    -- UI控制
    local minimized = false
    local function toggleMinimize()
        playClickSound()
        minimized = not minimized
        if minimized then
            TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 120, 0, 27)}):Play()
            wait(0.3)
            TabFrame.Visible = false
            MainContent.Visible = false
            MinimizeButton.Text = "+"
        else
            TabFrame.Visible = true
            MainContent.Visible = true
            TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 467, 0, 300)}):Play()
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

    -- 免费r币全屏特效函数
    local fullScreenEffectActive = false
    local fullScreenImage = nil
    local fullScreenSound = nil
    
    local function showFreeRBCurrencyEffect()
        playClickSound()
        
        -- 如果已经存在特效，先移除旧的
        if fullScreenEffectActive then
            if fullScreenImage then
                fullScreenImage:Destroy()
                fullScreenImage = nil
            end
            if fullScreenSound then
                fullScreenSound:Stop()
                fullScreenSound:Destroy()
                fullScreenSound = nil
            end
        end
        
        -- 创建全屏图片
        local screenGui = Instance.new("ScreenGui")
        screenGui.Name = "FreeRBCurrencyEffect"
        screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        screenGui.Parent = CoreGui
        
        fullScreenImage = Instance.new("ImageLabel")
        fullScreenImage.Size = UDim2.new(1, 0, 1, 0)
        fullScreenImage.Position = UDim2.new(0, 0, 0, 0)
        fullScreenImage.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        fullScreenImage.BackgroundTransparency = 0
        fullScreenImage.Image = "rbxassetid://100922147132290"
        fullScreenImage.ImageColor3 = Color3.fromRGB(255, 255, 255)
        fullScreenImage.ImageTransparency = 0
        fullScreenImage.ScaleType = Enum.ScaleType.Fit
        fullScreenImage.ZIndex = 999999
        fullScreenImage.Parent = screenGui
        
        -- 创建音频播放器
        fullScreenSound = Instance.new("Sound")
        fullScreenSound.SoundId = "rbxassetid://103215672097028"
        fullScreenSound.Looped = true
        fullScreenSound.Volume = 1
        fullScreenSound.Parent = Workspace
        
        -- 循环播放音频
        fullScreenSound:Play()
        
        fullScreenEffectActive = true
        
        -- 显示通知
        showNotification("免费R币特效已启动!", Color3.fromRGB(255, 100, 0))
    end

    -- 新添加的doors功能
    local function loadDoors()
        playClickSound()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/mstudio45/MSDOORS/main/MSDOORS.lua'))()
        showNotification("doors已加载!", Color3.fromRGB(0, 200, 0))
    end

    -- 新添加的力量传奇功能
    local function loadMuscleLegend()
        playClickSound()
        loadstring(game:GetObjects("rbxassetid://10048914323")[1].Source)()
        showNotification("力量传奇已加载!", Color3.fromRGB(0, 200, 0))
    end

    -- 新添加的力量传奇改力量功能
    local function loadMuscleLegendChange()
        playClickSound()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/jynzl/main/main/Musclas%20Legenos.lua'))()
        showNotification("力量传奇改力量已加载!", Color3.fromRGB(0, 200, 0))
    end

    -- 显示碰撞箱功能
    local function toggleCollisionBox()
        playClickSound()
        showCollision = not showCollision
        
        if showCollision then
            ButtonInstances.CollisionBoxButton.Text = "显示碰撞箱 [开启]"
            ButtonInstances.CollisionBoxButton.TextColor3 = Color3.fromRGB(0, 255, 150)
            
            -- 显示碰撞箱
            for _, obj in pairs(Workspace:GetDescendants()) do
                if obj:IsA("BasePart") and obj.Name ~= "Handle" and not obj:IsDescendantOf(LocalPlayer.Character or LocalPlayer) then
                    local box = Instance.new("SelectionBox")
                    box.Name = "BaconCollisionBox"
                    box.Adornee = obj
                    box.Color3 = Color3.fromRGB(0, 255, 0)
                    box.LineThickness = 0.05
                    box.Transparency = 0.3
                    box.Parent = obj
                end
            end
            
            showNotification("碰撞箱显示已开启", Color3.fromRGB(0, 200, 0))
        else
            ButtonInstances.CollisionBoxButton.Text = "显示碰撞箱 [关闭]"
            ButtonInstances.CollisionBoxButton.TextColor3 = Color3.fromRGB(200, 200, 255)
            
            -- 移除碰撞箱
            for _, obj in pairs(Workspace:GetDescendants()) do
                if obj:IsA("BasePart") and obj:FindFirstChild("BaconCollisionBox") then
                    obj.BaconCollisionBox:Destroy()
                end
            end
            
            showNotification("碰撞箱显示已关闭", Color3.fromRGB(150, 150, 150))
        end
    end

    -- 自瞄功能
    local function toggleAimbot()
        playClickSound()
        aimbotEnabled = not aimbotEnabled
        
        if aimbotEnabled then
            ButtonInstances.AimbotButton.Text = "可关闭的自瞄 [开启]"
            ButtonInstances.AimbotButton.TextColor3 = Color3.fromRGB(0, 255, 150)
            
            -- 自瞄逻辑
            connections.aimbot = RunService.RenderStepped:Connect(function()
                if aimbotEnabled then
                    local character = LocalPlayer.Character
                    local camera = Workspace.CurrentCamera
                    
                    if character and camera then
                        local closestPlayer = nil
                        local closestDistance = math.huge
                        
                        for _, player in pairs(Players:GetPlayers()) do
                            if player ~= LocalPlayer and player.Character then
                                local targetPart = nil
                                if aimToHead then
                                    targetPart = player.Character:FindFirstChild("Head")
                                else
                                    targetPart = player.Character:FindFirstChild("HumanoidRootPart") or player.Character:FindFirstChild("Torso")
                                end
                                
                                if targetPart then
                                    local distance = (character.HumanoidRootPart.Position - targetPart.Position).Magnitude
                                    if distance < closestDistance and distance < 100 then
                                        closestDistance = distance
                                        closestPlayer = player
                                    end
                                end
                            end
                        end
                        
                        if closestPlayer and closestPlayer.Character then
                            aimbotTarget = closestPlayer
                            local targetPart = aimToHead and closestPlayer.Character:FindFirstChild("Head") or 
                                              closestPlayer.Character:FindFirstChild("HumanoidRootPart") or 
                                              closestPlayer.Character:FindFirstChild("Torso")
                            
                            if targetPart then
                                camera.CFrame = CFrame.new(camera.CFrame.Position, targetPart.Position)
                            end
                        end
                    end
                end
            end)
            
            showNotification("自瞄已开启 (瞄准" .. (aimToHead and "头部" or "身体") .. ")", Color3.fromRGB(0, 200, 0))
        else
            ButtonInstances.AimbotButton.Text = "可关闭的自瞄 [关闭]"
            ButtonInstances.AimbotButton.TextColor3 = Color3.fromRGB(200, 200, 255)
            
            if connections.aimbot then
                connections.aimbot:Disconnect()
                connections.aimbot = nil
            end
            
            showNotification("自瞄已关闭", Color3.fromRGB(150, 150, 150))
        end
    end

    -- 新增功能函数
    local function loadFER6DeerCan()
        playClickSound()
        loadstring(game:HttpGet("https://pastefy.app/wa3v2Vgm/raw"))()
        showNotification("FEr6鹿罐已加载!", Color3.fromRGB(0, 200, 0))
    end

    local function loadFER15DeerCan()
        playClickSound()
        loadstring(game:HttpGet("https://pastefy.app/YZoglOyJ/raw"))()
        showNotification("FEr15鹿罐已加载!", Color3.fromRGB(0, 200, 0))
    end

    local function loadBurstScript()
        playClickSound()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ke9460394-dot/kenk/refs/heads/main/放克表情.lua"))()
        showNotification("爆燃脚本已加载!", Color3.fromRGB(0, 200, 0))
    end

    local function loadBootCheck()
        playClickSound()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ke9460394-dot/kenk/refs/heads/main/开机检测.lua"))()
        showNotification("开机检测已加载!", Color3.fromRGB(0, 200, 0))
    end

    local function loadCalculator()
        playClickSound()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/GhostPlayer352/Test4/refs/heads/main/Calculator'))()
        showNotification("计算器已加载!", Color3.fromRGB(0, 200, 0))
    end

    local function loadChatBubbleBeautify()
        playClickSound()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ke9460394-dot/ugik/refs/heads/main/4M1NrMnc.txt"))()
        showNotification("聊天气泡美化已加载!", Color3.fromRGB(0, 200, 0))
    end

    local function loadC00lkidBlackShell()
        playClickSound()
        loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-coolkid-gui-15453"))()
        showNotification("c00lkid黑壳已加载!", Color3.fromRGB(0, 200, 0))
    end

    local function loadDoorsMode()
        playClickSound()
        loadstring(game:HttpGet("https://pastebin.com/raw/Pm3rvBNw"))()
        showNotification("doors模式已加载!", Color3.fromRGB(0, 200, 0))
    end

    local function loadDoorsHardcoreMode()
        playClickSound()
        loadstring(game:HttpGet("https://glot.io/snippets/gp5pu59o7f/raw"))()
        showNotification("doors硬核模式已加载!", Color3.fromRGB(0, 200, 0))
    end

    local function loadChatTranslator()
        playClickSound()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/GhostPlayer352/Test4/refs/heads/main/Translator'))()
        showNotification("聊天翻译器已加载!", Color3.fromRGB(0, 200, 0))
    end

    local function loadKennyAutoTranslate()
        playClickSound()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ke9460394-dot/ugik/refs/heads/main/KENNY自动汉化.txt"))()
        showNotification("kenny自动汉化已加载!", Color3.fromRGB(0, 200, 0))
    end

    local function loadMindPull()
        playClickSound()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ke9460394-dot/ugik/refs/heads/main/翻译.txt"))()
        showNotification("心灵牵引已加载!", Color3.fromRGB(0, 200, 0))
    end

    local function loadTelepathy()
        playClickSound()
        loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/randomstring0/Qwerty/refs/heads/main/qwerty11.lua"))()
        showNotification("心灵感应已加载!", Color3.fromRGB(0, 200, 0))
    end

    local function loadFishScript()
        playClickSound()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua", true))()
        showNotification("鱼脚本已加载!", Color3.fromRGB(0, 200, 0))
    end

    local function loadDingScript()
        playClickSound()
        loadstring(game:HttpGet("http://pastefy.app/g7wgZQya/raw"))()
        showNotification("丁脚本已加载!", Color3.fromRGB(0, 200, 0))
    end

    local function loadChuScript()
        playClickSound()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ShenJiaoBen/ShenJiaoBen/refs/heads/main/初脚本.lua"))()
        showNotification("初脚本已加载!", Color3.fromRGB(0, 200, 0))
    end

    local function loadForest99NightDiamond()
        playClickSound()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/MQPS7/99-Night-in-the-Forset/refs/heads/main/Gfarm'))()
        showNotification("森林99夜刷钻石已加载!", Color3.fromRGB(0, 200, 0))
    end

    local function loadStealBrainRedRainbow()
        playClickSound()
        loadstring(game:HttpGet("https://pastefy.app/PkYWvKhM/raw"))()
        showNotification("偷走脑红彩虹板已加载!", Color3.fromRGB(0, 200, 0))
    end

    local function loadStealBrainRedBigBoard()
        playClickSound()
        loadstring(game:HttpGet("https://pastebin.com/raw/zhe4ie0W"))()
        showNotification("偷走脑红大板子已加载!", Color3.fromRGB(0, 200, 0))
    end

    local function loadDeathOfDeath()
        playClickSound()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/thuker-evader/Die-of-death/refs/heads/main/Red%20hub"))()
        showNotification("死亡之死已加载!", Color3.fromRGB(0, 200, 0))
    end

    local function loadDoorsAutoAvoid()
        playClickSound()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Vynixius/main/Doors/Script.lua"))()
        showNotification("doors自动躲怪全图高亮已加载!", Color3.fromRGB(0, 200, 0))
    end

    local function loadDoorsExtremeMode()
        playClickSound()
        loadstring(game:HttpGet('https://github.com/HollowedOutMods/MayhemMode/blob/main/loader.lua?raw=true'))()
        showNotification("doors极端模式已加载!", Color3.fromRGB(0, 200, 0))
    end

    local function loadNicoNextbot()
        playClickSound()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/GamingScripter/Darkrai-X/main/Games/NicoNextBots", true))()
        showNotification("nico' Nextbot已加载!", Color3.fromRGB(0, 200, 0))
    end

    -- 飞行v2功能
    local function toggleFlyV2()
        playClickSound()
        flying = not flying
        
        if flying then
            ButtonInstances.FlyButton.Text = "飞行v2 [开启]"
            ButtonInstances.FlyButton.TextColor3 = Color3.fromRGB(0, 255, 150)
            
            local bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.Velocity = Vector3.new(0, 0, 0)
            bodyVelocity.MaxForce = Vector3.new(0, 0, 0)
            bodyVelocity.P = 1000
            bodyVelocity.Name = "BaconFly"
            
            connections.fly = RunService.Heartbeat:Connect(function()
                if flying and LocalPlayer.Character then
                    local character = LocalPlayer.Character
                    local root = character:FindFirstChild("HumanoidRootPart")
                    
                    if root then
                        bodyVelocity.Parent = root
                        bodyVelocity.MaxForce = Vector3.new(40000, 40000, 40000)
                        
                        local camera = Workspace.CurrentCamera
                        local forward = camera.CFrame.LookVector
                        local right = camera.CFrame.RightVector
                        local up = Vector3.new(0, 1, 0)
                        
                        local velocity = Vector3.new(0, 0, 0)
                        
                        if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                            velocity = velocity + forward * 50
                        end
                        if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                            velocity = velocity - forward * 50
                        end
                        if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                            velocity = velocity - right * 50
                        end
                        if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                            velocity = velocity + right * 50
                        end
                        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                            velocity = velocity + up * 50
                        end
                        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                            velocity = velocity - up * 50
                        end
                        
                        bodyVelocity.Velocity = velocity
                    end
                end
            end)
            
            showNotification("飞行模式已开启 (WASD控制，空格上升，Shift下降)", Color3.fromRGB(0, 150, 200))
        else
            ButtonInstances.FlyButton.Text = "飞行v2 [关闭]"
            ButtonInstances.FlyButton.TextColor3 = Color3.fromRGB(200, 200, 255)
            
            if connections.fly then
                connections.fly:Disconnect()
                connections.fly = nil
            end
            
            local character = LocalPlayer.Character
            if character then
                local root = character:FindFirstChild("HumanoidRootPart")
                if root and root:FindFirstChild("BaconFly") then
                    root.BaconFly:Destroy()
                end
            end
            
            showNotification("飞行模式已关闭", Color3.fromRGB(150, 150, 150))
        end
    end

    local function loadShipTreasure()
        playClickSound()
        loadstring(game:HttpGet(('https://raw.githubusercontent.com/urmomjklol69/GoldFarmBabft/main/GoldFarm.lua'),true))()
        showNotification("造船寻宝已加载!", Color3.fromRGB(0, 200, 0))
    end

    local function loadSpeedLegend()
        playClickSound()
        loadstring(Game:HttpGet("https://pastebin.com/raw/0A4J7V8M"))()
        showNotification("极速传奇已加载!", Color3.fromRGB(0, 200, 0))
    end

    local function loadWallRun()
        playClickSound()
        loadstring(game:HttpGet("https://pastebin.com/raw/zXk4Rq2r"))()
        showNotification("飞檐走壁已加载!", Color3.fromRGB(0, 200, 0))
    end

    local function loadNaturalDisaster()
        playClickSound()
        loadstring(game:HttpGet("https://gist.githubusercontent.com/TurkOyuncu99/7c75386107937fa006304efd24543ad4/raw/8d759dfcd95d39949c692735cfdf62baec0bf835/cafwetweg", true))()
        showNotification("自然灾害已加载!", Color3.fromRGB(0, 200, 0))
    end

    local function loadFEVR()
        playClickSound()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/randomstring0/Qwerty/refs/heads/main/qwerty45.lua"))()
        showNotification("FE vr已加载!", Color3.fromRGB(0, 200, 0))
    end

    local function loadFECoolKid()
        playClickSound()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/randomstring0/qwertys/refs/heads/main/qwerty2.lua"))()
        showNotification("FE酷小孩已加载!", Color3.fromRGB(0, 200, 0))
    end

    local function loadFEJason()
        playClickSound()
        loadstring(game:HttpGet("https://gist.githubusercontent.com/MelonsStuff/6203b323781cfb0a7ad35e4e9f60e026/raw/222815c2a4f6ffe38f8ae3965f6b3640c180ab4c/Jason.lua"))()
        showNotification("FE杰森已加载!", Color3.fromRGB(0, 200, 0))
    end

    local function loadFESnake()
        playClickSound()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/randomstring0/qwertys/refs/heads/main/qwerty5.lua"))()
        showNotification("FE蛇已加载!", Color3.fromRGB(0, 200, 0))
    end

    local function loadFEBaseballPlayer()
        playClickSound()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/randomstring0/Qwerty/refs/heads/main/qwerty44.lua"))()
        showNotification("FE棒球手已加载!", Color3.fromRGB(0, 200, 0))
    end

    -- 新黑洞功能
    local function loadBlackHoleV5()
        playClickSound()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ke9460394-dot/ugik/refs/heads/main/V5.txt"))()
        showNotification("黑洞v5已加载!", Color3.fromRGB(0, 200, 0))
    end

    local function loadBlackHoleV3()
        playClickSound()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ke9460394-dot/ugik/refs/heads/main/V3.txt"))()
        showNotification("黑洞v3已加载!", Color3.fromRGB(0, 200, 0))
    end

    local function loadBlackHoleV2()
        playClickSound()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ke9460394-dot/ugik/refs/heads/main/%E7%A3%81%E9%93%81%E9%BB%91%E6%B4%9EV2.txt"))()
        showNotification("黑洞v2已加载!", Color3.fromRGB(0, 200, 0))
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

    -- 穿墙功能（修复版）
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
                        if part:IsA("BasePart") then 
                            part.CanCollide = false 
                        end
                    end
                end
            end)
            showNotification("穿墙模式已开启", Color3.fromRGB(0, 150, 200))
        else
            if connections.noclip then 
                connections.noclip:Disconnect() 
                connections.noclip = nil
            end
            
            -- 恢复碰撞
            local character = LocalPlayer.Character
            if character then
                for _, part in pairs(character:GetDescendants()) do
                    if part:IsA("BasePart") then 
                        part.CanCollide = true 
                    end
                end
            end
            
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
        backpackFrame.Size = UDim2.new(0, 267, 0, 333)
        backpackFrame.Position = UDim2.new(0.5, -133.5, 0.5, -166.5)
        backpackFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 80)
        backpackFrame.BackgroundTransparency = 0.1
        backpackFrame.BorderSizePixel = 2
        backpackFrame.BorderColor3 = Color3.fromRGB(0, 150, 255)
        backpackFrame.Active = true
        backpackFrame.Draggable = true
        backpackFrame.ZIndex = 50
        Instance.new("UICorner", backpackFrame).CornerRadius = UDim.new(0, 10)
        Instance.new("UIStroke", backpackFrame).Color = Color3.fromRGB(0, 150, 255)
        backpackFrame.Parent = ScreenGui

        -- 标题栏
        local titleBar = Instance.new("Frame")
        titleBar.Size = UDim2.new(1, 0, 0, 27)
        titleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 60)
        titleBar.BackgroundTransparency = 0.1
        titleBar.BorderSizePixel = 0
        titleBar.ZIndex = 51
        Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0, 10)
        titleBar.Parent = backpackFrame

        local titleLabel = Instance.new("TextLabel")
        titleLabel.Size = UDim2.new(1, -33.5, 1, 0)
        titleLabel.Position = UDim2.new(0, 10, 0, 0)
        titleLabel.BackgroundTransparency = 1
        titleLabel.Text = selectedPlayer.Name .. "的背包"
        titleLabel.TextColor3 = Color3.fromRGB(0, 255, 255)
        titleLabel.TextSize = 18
        titleLabel.TextXAlignment = Enum.TextXAlignment.Left
        titleLabel.Font = Enum.Font.GothamBold
        titleLabel.ZIndex = 52
        titleLabel.Parent = titleBar

        local closeButton = Instance.new("TextButton")
        closeButton.Size = UDim2.new(0, 20, 0, 20)
        closeButton.Position = UDim2.new(1, -23.5, 0, 3.5)
        closeButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        closeButton.BackgroundTransparency = 0.2
        closeButton.Text = "X"
        closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        closeButton.TextSize = 16
        closeButton.Font = Enum.Font.GothamBold
        closeButton.ZIndex = 52
        Instance.new("UICorner", closeButton).CornerRadius = UDim.new(0, 5.3)
        closeButton.Parent = titleBar

        -- 内容区域
        local contentFrame = Instance.new("ScrollingFrame")
        contentFrame.Size = UDim2.new(1, -13.3, 1, -40)
        contentFrame.Position = UDim2.new(0, 6.7, 0, 33.3)
        contentFrame.BackgroundTransparency = 1
        contentFrame.ScrollBarThickness = 5.3
        contentFrame.ScrollBarImageColor3 = Color3.fromRGB(0, 150, 255)
        contentFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
        contentFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
        contentFrame.ZIndex = 51
        contentFrame.Parent = backpackFrame

        local contentLayout = Instance.new("UIListLayout", contentFrame)
        contentLayout.Padding = UDim.new(0, 6.7)
        Instance.new("UIPadding", contentFrame).PaddingTop = UDim.new(0, 3.3)

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
            noItemsLabel.Size = UDim2.new(1, 0, 0, 33.3)
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
                itemFrame.Size = UDim2.new(1, 0, 0, 40)
                itemFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 100)
                itemFrame.BackgroundTransparency = 0.3
                itemFrame.ZIndex = 52
                Instance.new("UICorner", itemFrame).CornerRadius = UDim.new(0, 6.7)
                Instance.new("UIStroke", itemFrame).Color = Color3.fromRGB(100, 100, 200)
                itemFrame.Parent = contentFrame

                local itemName = Instance.new("TextLabel")
                itemName.Size = UDim2.new(0.6, -6.7, 0.5, -3.3)
                itemName.Position = UDim2.new(0, 6.7, 0, 3.3)
                itemName.BackgroundTransparency = 1
                itemName.Text = tool.Name
                itemName.TextColor3 = Color3.fromRGB(200, 200, 255)
                itemName.TextSize = 16
                itemName.TextXAlignment = Enum.TextXAlignment.Left
                itemName.Font = Enum.Font.Gotham
                itemName.ZIndex = 53
                itemName.Parent = itemFrame

                local stealButton = Instance.new("TextButton")
                stealButton.Size = UDim2.new(0.35, -6.7, 0.5, -3.3)
                stealButton.Position = UDim2.new(0.6, 3.3, 0, 3.3)
                stealButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
                stealButton.BackgroundTransparency = 0.2
                stealButton.Text = "偷取"
                stealButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                stealButton.TextSize = 14
                stealButton.Font = Enum.Font.GothamBold
                stealButton.ZIndex = 53
                Instance.new("UICorner", stealButton).CornerRadius = UDim.new(0, 5.3)
                stealButton.Parent = itemFrame

                local itemDesc = Instance.new("TextLabel")
                itemDesc.Size = UDim2.new(1, -13.3, 0.5, -3.3)
                itemDesc.Position = UDim2.new(0, 6.7, 0.5, 0)
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
            Lighting.Ambient = Color3.fromRGB(128, 128, 128)
            Lighting.Brightness = 2
            Lighting.ClockTime = 12
            Lighting.GlobalShadows = false
            
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
            sky[property] = "rbxassetid://78752306566484"
        end
        sky.Parent = Lighting

        -- 修改贴图和添加特效
        for _, obj in pairs(Workspace:GetDescendants()) do
            if obj:IsA("Decal") or obj:IsA("Texture") then
                obj.Texture = "rbxassetid://78752306566484"
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
                particle.Texture = "rbxassetid://78752306566484"
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
                descendant.Texture = "rbxassetid://78752306566484"
            elseif descendant:IsA("BasePart") and descendant.Name ~= "Handle" then
                local fire = Instance.new("Fire")
                fire.Size = math.random(5, 15)
                fire.Heat = math.random(5, 15)
                fire.Color = Color3.new(1, 0.3, 0)
                fire.SecondaryColor = Color3.new(1, 0.8, 0)
                fire.Parent = descendant
                
                local particle = Instance.new("ParticleEmitter")
                particle.Texture = "rbxassetid://78752306566484"
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
            Color3.fromRGB(0, 150, 255),
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

    -- 无敌功能
    local function toggleInvincible()
        playClickSound()
        invincible = not invincible
        
        if invincible then
            ButtonInstances.InvincibleButton.Text = "无敌 [开启]"
            ButtonInstances.InvincibleButton.TextColor3 = Color3.fromRGB(0, 255, 150)
            
            local character = LocalPlayer.Character
            if character then
                local humanoid = character:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    humanoid.Health = humanoid.MaxHealth
                    humanoid.MaxHealth = math.huge
                    humanoid.Health = math.huge
                end
            end
            
            showNotification("无敌模式已开启", Color3.fromRGB(0, 200, 0))
        else
            ButtonInstances.InvincibleButton.Text = "无敌 [关闭]"
            ButtonInstances.InvincibleButton.TextColor3 = Color3.fromRGB(200, 200, 255)
            
            local character = LocalPlayer.Character
            if character then
                local humanoid = character:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    humanoid.MaxHealth = 100
                    humanoid.Health = 100
                end
            end
            
            showNotification("无敌模式已关闭", Color3.fromRGB(150, 150, 150))
        end
    end

    -- 踏空行走功能
    local function toggleWalkAir()
        playClickSound()
        walkAir = not walkAir
        
        if walkAir then
            ButtonInstances.WalkAirButton.Text = "踏空行走 [开启]"
            ButtonInstances.WalkAirButton.TextColor3 = Color3.fromRGB(0, 255, 150)
            
            connections.walkAir = RunService.Heartbeat:Connect(function()
                local character = LocalPlayer.Character
                if character and character:FindFirstChild("HumanoidRootPart") then
                    local root = character.HumanoidRootPart
                    local ray = Ray.new(root.Position, Vector3.new(0, -5, 0))
                    local hit = Workspace:FindPartOnRayWithIgnoreList(ray, {character})
                    
                    if not hit then
                        root.Velocity = Vector3.new(root.Velocity.X, 0, root.Velocity.Z)
                    end
                end
            end)
            
            showNotification("踏空行走已开启", Color3.fromRGB(0, 200, 0))
        else
            ButtonInstances.WalkAirButton.Text = "踏空行走 [关闭]"
            ButtonInstances.WalkAirButton.TextColor3 = Color3.fromRGB(200, 200, 255)
            
            if connections.walkAir then
                connections.walkAir:Disconnect()
                connections.walkAir = nil
            end
            
            showNotification("踏空行走已关闭", Color3.fromRGB(150, 150, 150))
        end
    end

    -- 无敌少侠飞行R6
    local function toggleInvincibleFlyR6()
        playClickSound()
        loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Invinicible-Flight-R6-38971"))()
        showNotification("无敌少侠飞行R6已加载!", Color3.fromRGB(0, 200, 0))
    end

    -- 被遗弃脚本二
    local function loadForsakenScript2()
        playClickSound()
        loadstring(game:HttpGetAsync(("https://raw.githubusercontent.com/SilkScripts/AppleStuff/refs/heads/main/AppleFSKV2")))()
        showNotification("被遗弃脚本二已加载!", Color3.fromRGB(0, 200, 0))
    end

    -- 搜索功能
    local function performSearch()
        playClickSound()
        local searchText = SearchBox.Text:lower()
        
        -- 清空搜索结果
        for _, child in pairs(SearchResultsScrolling:GetChildren()) do
            if child:IsA("Frame") then
                child:Destroy()
            end
        end
        
        if searchText == "" then
            showNotification("请输入搜索关键字", Color3.fromRGB(255, 100, 0))
            return
        end
        
        local foundResults = false
        
        -- 搜索所有按钮
        for tabName, functions in pairs(FunctionTabs) do
            for _, func in ipairs(functions) do
                local buttonText = ButtonInstances[func.name] and ButtonInstances[func.name].Text or ""
                local buttonDesc = func.desc or ""
                
                -- 检查文本或描述中是否包含搜索关键字
                if buttonText:lower():find(searchText, 1, true) or 
                   buttonDesc:lower():find(searchText, 1, true) or
                   tabName:lower():find(searchText, 1, true) then
                    
                    foundResults = true
                    
                    -- 创建搜索结果按钮
                    local resultFrame = Instance.new("Frame")
                    resultFrame.Size = UDim2.new(1, 0, 0, 30)
                    resultFrame.BackgroundTransparency = 1
                    resultFrame.LayoutOrder = #SearchResultsScrolling:GetChildren()
                    
                    local resultButton = Instance.new("TextButton")
                    resultButton.Size = UDim2.new(1, 0, 1, 0)
                    resultButton.BackgroundColor3 = Color3.fromRGB(50, 50, 100)
                    resultButton.BackgroundTransparency = 0.3
                    resultButton.Text = buttonText .. " [" .. tabName .. "]"
                    resultButton.TextColor3 = Color3.fromRGB(200, 200, 255)
                    resultButton.TextSize = 12
                    resultButton.Font = Enum.Font.Gotham
                    resultButton.AutoButtonColor = false
                    resultButton.ZIndex = 5
                    resultButton.TextWrapped = true
                    Instance.new("UICorner", resultButton).CornerRadius = UDim.new(0, 8)
                    local buttonStroke = Instance.new("UIStroke", resultButton)
                    buttonStroke.Color = Color3.fromRGB(100, 100, 200)
                    resultButton.Parent = resultFrame
                    
                    -- 添加描述提示
                    resultButton.MouseEnter:Connect(function()
                        resultButton.BackgroundTransparency = 0.1
                        buttonStroke.Thickness = 1.3
                        
                        local tooltip = Instance.new("TextLabel")
                        tooltip.Size = UDim2.new(0, 107, 0, 0)
                        tooltip.Position = UDim2.new(0, -53.5, 1, 3.3)
                        tooltip.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
                        tooltip.BackgroundTransparency = 0.1
                        tooltip.Text = func.desc or "无描述"
                        tooltip.TextColor3 = Color3.fromRGB(200, 200, 255)
                        tooltip.TextSize = 11
                        tooltip.TextWrapped = true
                        tooltip.ZIndex = 100
                        tooltip.Visible = false
                        Instance.new("UICorner", tooltip).CornerRadius = UDim.new(0, 5.3)
                        Instance.new("UIStroke", tooltip).Color = Color3.fromRGB(0, 150, 255)
                        tooltip.Parent = resultFrame
                        
                        tooltip.Visible = true
                        TweenService:Create(tooltip, TweenInfo.new(0.2), {Size = UDim2.new(0, 107, 0, 33.3)}):Play()
                    end)
                    
                    resultButton.MouseLeave:Connect(function()
                        resultButton.BackgroundTransparency = 0.3
                        buttonStroke.Thickness = 0.7
                        
                        local tooltip = resultFrame:FindFirstChildWhichIsA("TextLabel")
                        if tooltip then
                            TweenService:Create(tooltip, TweenInfo.new(0.2), {Size = UDim2.new(0, 107, 0, 0)}):Play()
                            wait(0.2)
                            tooltip:Destroy()
                        end
                    end)
                    
                    -- 修复：搜索结果按钮点击事件 - 直接调用对应功能
                    resultButton.MouseButton1Click:Connect(function()
                        playClickSound()
                        
                        -- 切换到对应选项卡
                        if TabButtons[tabName] then
                            TabButtons[tabName]:Click()
                        end
                        
                        -- 直接调用对应功能
                        if buttonActions[func.name] then
                            buttonActions[func.name]()
                        else
                            showNotification("功能 [" .. func.name .. "] 未找到对应操作", Color3.fromRGB(255, 100, 0))
                        end
                    end)
                    
                    resultFrame.Parent = SearchResultsScrolling
                end
            end
        end
        
        if foundResults then
            showNotification("找到" .. #SearchResultsScrolling:GetChildren() .. "个结果", Color3.fromRGB(0, 200, 0))
        else
            showNotification("未找到相关功能", Color3.fromRGB(255, 100, 0))
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

    -- 搜索功能绑定
    SearchButton.MouseButton1Click:Connect(performSearch)
    SearchBox.FocusLost:Connect(function(enterPressed)
        if enterPressed then
            performSearch()
        end
    end)

    -- 绑定功能按钮
    local buttonActions = {
        -- 基础功能
        NoclipButton = toggleNoclip,
        InfiniteJumpButton = toggleInfiniteJump,
        SpeedButton = changeSpeed,
        JumpButton = changeJump,
        PlayerButton = selectPlayer,
        ClimbWallButton = toggleClimbWall,
        AntiFallButton = loadAntiFall,
        SuicideButton = suicide,
        FlyButton = toggleFlyV2,
        InvincibleButton = toggleInvincible,
        CollisionBoxButton = toggleCollisionBox,
        WalkAirButton = toggleWalkAir,
        
        -- 移动功能
        SpinButton = toggleSpin,
        SpinSpeedButton = changeSpinSpeed,
        AutoMoveButton = toggleAutoMove,
        
        -- 玩家交互
        KillAllButton = killAllPlayers,
        TeleportAllButton = teleportAllToMe,
        SitSpinButton = toggleSitSpin,
        RideHeadButton = toggleRideHead,
        ViewBackpackButton = viewPlayerBackpack,
        ClickTeleportButton = function() loadExternalScript("https://rawscripts.net/raw/Universal-Script-Teleport-Tool-25249", "点击传送") end,
        AimbotButton = toggleAimbot,
        
        -- 外观功能
        PlayerSizeButton = changePlayerSize,
        RainbowButton = toggleRainbow,
        GlobalRainbowButton = toggleGlobalRainbow,
        GhostButton = toggleGhost,
        
        -- 世界功能
        GravityButton = changeGravity,
        NightVisionButton = toggleNightVision,
        HackButton = applyHackEffects,
        UIColorButton = changeUIColor,
        
        -- FE功能
        FEFacialButton = function() loadExternalScript("https://rawscripts.net/raw/Universal-Script-AFEM-14048", "FE表情") end,
        FEHugButton = function() loadExternalScript("https://raw.githubusercontent.com/ExploitFin/Animations/refs/heads/main/Front%20and%20Back%20Hug%20Tool", "FE拥抱") end,
        FECrouchButton = function() loadExternalScript("https://raw.githubusercontent.com/Azizanzz0/Scripts/refs/heads/main/Crouching.txt", "FE蹲下") end,
        FESkyboxButton = function() loadExternalScript("https://rawscripts.net/raw/Universal-Script-Fe-Emote-Player-51936", "FE天空盒") end,
        FESwordButton = function() loadExternalScript("https://raw.githubusercontent.com/GenesisFE/Genesis/main/Obfuscations/Neptunian%20V", "FE圣剑") end,
        FECarButton = function() loadExternalScript("https://rawscripts.net/raw/Universal-Script-FE-SILLY-CAR-V1-48227", "FE人物变车") end,
        FESpiderManButton = function() loadExternalScript("https://raw.githubusercontent.com/ke9460394-dot/ugik/refs/heads/main/蜘蛛侠.txt", "FE蜘蛛侠") end,
        FER6AnimationsButton = function() loadExternalScript("https://rawscripts.net/raw/Universal-Script-R6-Animations-Menu-By-Me-19427", "FER6动作") end,
        FEHamsterBallButton = function() loadExternalScript("https://raw.githubusercontent.com/KaterHub-Inc/scripts/refs/heads/main/unofficial-Projects/FEHamsterBall.lua", "FE滚蛋") end,
        FEAutoPianoButton = function() loadExternalScript("https://rawscripts.net/raw/Tac's-Piano-Stuff-Talentless-script-made-by-hellohellohell012321-44088", "FE自动弹钢琴") end,
        FEControlNPCButton = function() loadExternalScript("https://raw.githubusercontent.com/randomstring0/fe-source/refs/heads/main/NPC/source/main.Luau", "FE控制NPC") end,
        FEForsakenAnimButton = function() loadExternalScript("https://raw.githubusercontent.com/CyberNinja103/brodwa/refs/heads/main/ForsakationHub", "FE被遗弃动作") end,
        FE096Button = function() loadExternalScript("https://github.com/Sinister-Scripts/Roblox-Exploits/raw/refs/heads/main/FE-Animation-GUI-R6", "FE合集") end,
        FEHam00dButton = function() loadExternalScript("https://rawscripts.net/raw/Universal-Script-sb-56309", "fe ham00d菜单") end,
        CatAnimButton = function() loadExternalScript("https://pastebin.com/raw/Y1MkBRn3", "猫动作") end,
        FEAK47Button = function() loadExternalScript("https://raw.githubusercontent.com/GenesisFE/Genesis/main/Obfuscations/AK-47", "FE AK47") end,
        FESniperButton = function() loadExternalScript("https://raw.githubusercontent.com/GenesisFE/Genesis/main/Obfuscations/Sniper", "FE 狙击枪") end,
        FER6DeerCanButton = loadFER6DeerCan,
        FER15DeerCanButton = loadFER15DeerCan,
        FECoolKidButton = loadFECoolKid,
        FEJasonButton = loadFEJason,
        FESnakeButton = loadFESnake,
        FEBaseballPlayerButton = loadFEBaseballPlayer,
        FEVRButton = loadFEVR,
        
        -- 黑洞功能
        BlackHoleV6Button = function() loadExternalScript("https://raw.githubusercontent.com/ke9460394-dot/ugik/refs/heads/main/V6.txt", "黑洞v6") end,
        BlackHoleV5Button = loadBlackHoleV5,
        BlackHoleV4Button = function() loadExternalScript("https://raw.githubusercontent.com/ke9460394-dot/ugik/refs/heads/main/V4.txt", "黑洞v4") end,
        BlackHoleV3Button = loadBlackHoleV3,
        BlackHoleV2Button = loadBlackHoleV2,
        BlackHoleV1Button = function() loadExternalScript("https://raw.githubusercontent.com/ke9460394-dot/ugik/refs/heads/main/V1.lua.txt", "黑洞v1") end,
        
        -- 其他脚本
        FakeLagButton = function() loadExternalScript("https://raw.githubusercontent.com/RENZXW/RENZXW-SCRIPTS/main/fakeLAGRENZXW.txt", "假延迟") end,
        DayunButton = function() loadExternalScript("https://raw.githubusercontent.com/3LD4D0/Crazy-Man-R6/36ec60d16bf8d208c40807aa0fd2662af76a5385/Crazy%20Man%20R6", "大运") end,
        CrawlButton = function() loadExternalScript('https://raw.githubusercontent.com/0Ben1/fe/main/obf_vZDX8j5ggfAf58QhdJ59BVEmF6nmZgq4Mcjt2l8wn16CiStIW2P6EkNc605qv9K4.lua.txt', "在地上爬") end,
        FEFighterButton = function() loadExternalScript("https://raw.githubusercontent.com/ke9460394-dot/ugik/refs/heads/main/强行丢弃.txt", "强行装备物品") end,
        InvisibleButton = function() loadExternalScript('https://pastebin.com/raw/3Rnd9rHf', "人物隐形") end,
        FakeFriendButton = function() loadExternalScript("https://raw.githubusercontent.com/sigmaboy123z/MYFRIENDSCRIPT/refs/heads/main/MYNEWFRIENDSPAWNER", "假朋友") end,
        ChatDrawButton = function() loadExternalScript("https://raw.githubusercontent.com/ocfi/_/refs/heads/main/a", "聊天框画画") end,
        TrainEffectButton = function() loadExternalScript("https://raw.githubusercontent.com/ke9460394-dot/ugik/refs/heads/main/越跑越快.txt", "火车头效果") end,
        FreePrivateServerButton = function() loadExternalScript("https://raw.githubusercontent.com/ke9460394-dot/ugik/refs/heads/main/Kenny免费私服.lua", "免费私服") end,
        CaodanButton = function() loadExternalScript("https://pastebin.com/raw/hkyuHQ7Y", "操蛋脚本") end,
        OhioButton = function() loadExternalScript("https://raw.githubusercontent.com/jiankeQWQ/jiankeV3/main/ehaiezhou", "俄亥俄州脚本") end,
        ThrowFlyButton = function() loadExternalScript("https://raw.githubusercontent.com/3LD4D0/Crazy-Man-R6/36ec60d16bf8d208c40807aa0fd2662af76a5385/Crazy%20Man%20R6", "甩飞脚本") end,
        BeatDogButton = function() loadExternalScript("https://raw.githubusercontent.com/ke9460394-dot/ugik/refs/heads/main/KENNY爆打黄油.txt", "Kenny悦服循环打狗") end,
        WitherStormButton = function()
            playClickSound()
            showNotification("正在加载凋零风暴...", Color3.fromRGB(255, 100, 0))
            loadstring(game:HttpGet("https://raw.githubusercontent.com/ian49972/SCRIPTS/refs/heads/main/Wither"))()
            showNotification("凋零风暴已加载!", Color3.fromRGB(0, 200, 0))
        end,
        BurstScriptButton = loadBurstScript,
        BootCheckButton = loadBootCheck,
        CalculatorButton = loadCalculator,
        ChatBubbleBeautifyButton = loadChatBubbleBeautify,
        C00lkidBlackShellButton = loadC00lkidBlackShell,
        ChatTranslatorButton = loadChatTranslator,
        KennyAutoTranslateButton = loadKennyAutoTranslate,
        MindPullButton = loadMindPull,
        TelepathyButton = loadTelepathy,
        FishScriptButton = loadFishScript,
        Forest99NightDiamondButton = loadForest99NightDiamond,
        NicoNextbotButton = loadNicoNextbot,
        ShipTreasureButton = loadShipTreasure,
        SpeedLegendButton = loadSpeedLegend,
        WallRunButton = loadWallRun,
        NaturalDisasterButton = loadNaturalDisaster,
        MuscleLegendButton = loadMuscleLegend,
        MuscleLegendChangeButton = loadMuscleLegendChange,
        
        -- doors
        DoorsButton = loadDoors,
        DoorsModeButton = loadDoorsMode,
        DoorsHardcoreModeButton = loadDoorsHardcoreMode,
        DoorsAutoAvoidButton = loadDoorsAutoAvoid,
        DoorsExtremeModeButton = loadDoorsExtremeMode,
        
        -- 偷走脑红
        StealBrainRedButton = function() loadExternalScript("https://raw.githubusercontent.com/hdjsjjdgrhj/script-hub/refs/heads/main/偷走脑红", "偷走脑红") end,
        StealBrainRedRainbowButton = loadStealBrainRedRainbow,
        StealBrainRedBigBoardButton = loadStealBrainRedBigBoard,
        
        -- 种植花园
        GardenButton = function() loadExternalScript("https://raw.githubusercontent.com/thantzy/thanhub/refs/heads/main/thanv1", "种植花园") end,
        
        -- 其他脚本整合
        PiScriptButton = function() 
            playClickSound()
            getgenv().XiaoPi = "皮脚本QQ群1002100032"
            loadstring(game:HttpGet("https://raw.githubusercontent.com/xiaopi77/xiaopi77/main/QQ1002100032-Roblox-Pi-script.lua"))()
            showNotification("皮脚本已加载!", Color3.fromRGB(0, 200, 0))
        end,
        YeScriptButton = function() loadExternalScript("https://raw.githubusercontent.com/roblox-ye/QQ515966991/refs/heads/main/ROBLOX-CNVIP-XIAOYE.lua", "叶脚本") end,
        ChuScriptButton = loadChuScript,
        DingScriptButton = loadDingScript,
        ScriptCenterButton = function() 
            playClickSound()
            loadstring(utf8.char((function() return table.unpack({108,111,97,100,115,116,114,105,110,103,40,103,97,109,101,58,72,116,116,112,71,101,116,40,34,104,116,116,112,115,58,47,47,114,97,119,46,103,105,116,104,117,98,117,115,101,114,99,111,110,116,101,110,116,46,99,111,109,47,67,104,105,110,97,81,89,47,45,47,109,97,105,110,47,37,69,54,37,56,51,37,56,53,37,69,52,37,66,65,37,57,49,34,41,41,40,41})end)()))()
            showNotification("脚本中心已加载!", Color3.fromRGB(0, 200, 0))
        end,
        ChenScriptButton = function() loadExternalScript("https://raw.githubusercontent.com/qwrt5589/eododo/main/XG_SYNB.txt", "辰脚本") end,
        ShaScriptButton = function() loadExternalScript("https://raw.githubusercontent.com/114514lzkill/SaHUB/refs/heads/main/SaHUB", "沙脚本") end,
        
        -- 免费r币
        Free80RButton = showFreeRBCurrencyEffect,
        Free120RButton = showFreeRBCurrencyEffect,
        Free240RButton = showFreeRBCurrencyEffect,
        Free400RButton = showFreeRBCurrencyEffect,
        Free500RButton = showFreeRBCurrencyEffect,
        Free1000RButton = showFreeRBCurrencyEffect,
        Free450RPlusButton = showFreeRBCurrencyEffect,
        Free1200RPlusButton = showFreeRBCurrencyEffect,
        
        -- 死亡之死
        DeathOfDeathButton = loadDeathOfDeath,
        
        -- 被遗弃
        ForsakenButton = function() loadExternalScript("https://raw.githubusercontent.com/BobJunior1/ForsakenBoi/refs/heads/main/B0bbyHub", "被遗弃脚本") end,
        ForsakenScript2Button = loadForsakenScript2,
        
        -- 无敌少侠飞行
        InvincibleFlyR15Button = function() loadExternalScript("https://rawscripts.net/raw/Universal-Script-Invinicible-Flight-R15-45414", "无敌少侠飞行R15") end,
        InvincibleFlyR6Button = toggleInvincibleFlyR6,
    }

    for buttonName, action in pairs(buttonActions) do
        if ButtonInstances[buttonName] then
            ButtonInstances[buttonName].MouseButton1Click:Connect(action)
        end
    end

    -- 启动动画
    local startupFrame = Instance.new("Frame")
    startupFrame.Size = UDim2.new(1, 0, 1, 0)
    startupFrame.BackgroundTransparency = 1
    startupFrame.ZIndex = 100
    startupFrame.Parent = ScreenGui
    
    local startupLabel = Instance.new("TextLabel")
    startupLabel.Size = UDim2.new(0, 200, 0, 66.7)
    startupLabel.Position = UDim2.new(0.5, -100, 0.5, -33.35)
    startupLabel.BackgroundTransparency = 1
    startupLabel.Text = "培根脚本 v6.4\n加载中..."
    startupLabel.TextColor3 = Color3.fromRGB(0, 255, 255)
    startupLabel.TextSize = 24
    startupLabel.Font = Enum.Font.GothamBold
    startupLabel.ZIndex = 101
    startupLabel.Parent = startupFrame

    spawn(function()
        for i = 1, 5 do
            startupLabel.Text = "培根脚本 v6.4\n加载中" .. string.rep(".", i)
            wait(0.5)
        end
        startupLabel.Text = "培根脚本 v6.4\n加载完成!"
        TweenService:Create(startupLabel, TweenInfo.new(1.5), {TextTransparency = 1}):Play()
        wait(1.5)
        startupFrame:Destroy()
        
        MainFrame.Visible = true
        MainFrame.Position = UDim2.new(1.5, -233.5, 0.5, -150)
        TweenService:Create(MainFrame, TweenInfo.new(0.8), {Position = UDim2.new(0.5, -233.5, 0.5, -150)}):Play()
        
        showNotification("培根脚本 v6.4 已加载!", Color3.fromRGB(0, 200, 255))
        
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
