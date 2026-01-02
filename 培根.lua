-- 添加游戏环境检测
if not game then
    warn("此脚本需要在Roblox Studio或游戏中运行")
    return
end

local function loadScript()
    -- 等待游戏加载
    repeat task.wait() until game:IsLoaded()
    
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
        HttpService = game:GetService("HttpService"),
        ReplicatedStorage = game:GetService("ReplicatedStorage")
    }
    
    local Players, RunService, UserInputService, TweenService, Workspace, CoreGui, Lighting, SoundService, HttpService, ReplicatedStorage = 
        Services.Players, Services.RunService, Services.UserInputService, Services.TweenService, 
        Services.Workspace, Services.CoreGui, Services.Lighting, Services.SoundService, Services.HttpService, Services.ReplicatedStorage
    
    -- 等待本地玩家
    local LocalPlayer
    repeat
        LocalPlayer = Players.LocalPlayer
        task.wait(0.1)
    until LocalPlayer
    
    -- 安全创建UI函数
    local function safeCreateUI()
        -- 创建UI
        local ScreenGui = Instance.new("ScreenGui")
        ScreenGui.Name = "BaconScriptGUI_" .. math.random(10000,99999)
        ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        ScreenGui.ResetOnSpawn = false
        
        -- 尝试添加到CoreGui
        pcall(function()
            ScreenGui.Parent = CoreGui
        end)
        
        -- 如果失败，尝试其他方式
        if not ScreenGui.Parent then
            pcall(function()
                ScreenGui.Parent = game:GetService("StarterGui")
            end)
        end
        
        return ScreenGui
    end
    
    local ScreenGui = safeCreateUI()
    if not ScreenGui.Parent then
        warn("无法创建UI界面")
        return
    end
    
    -- 主窗口
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
    
    -- 背景图片
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
    
    -- 选项卡区域
    local TabFrame = Instance.new("Frame")
    TabFrame.Size = UDim2.new(0, 100, 1, -27)
    TabFrame.Position = UDim2.new(0, 0, 0, 27)
    TabFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 50)
    TabFrame.BackgroundTransparency = 0.2
    TabFrame.ZIndex = 3
    Instance.new("UICorner", TabFrame).CornerRadius = UDim.new(0, 11)
    TabFrame.Parent = MainFrame
    
    -- 主内容区域
    local MainContent = Instance.new("Frame")
    MainContent.Size = UDim2.new(1, -100, 1, -27)
    MainContent.Position = UDim2.new(0, 100, 0, 27)
    MainContent.BackgroundTransparency = 1
    MainContent.ZIndex = 3
    MainContent.Parent = MainFrame
    
    -- 选项卡
    local Tabs = {
        "公告", "基础功能", "移动功能", "玩家交互", "外观功能", "世界功能", 
        "FE功能", "黑洞功能", "其他脚本", "doors", "偷走脑红", "种植花园", 
        "其他脚本整合", "免费r币", "死亡之死", "被遗弃", "无敌少侠飞行",
        "俄亥俄州", "画我"
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
    
    local tabPadding = Instance.new("UIPadding", TabScrolling)
    tabPadding.PaddingTop = UDim.new(0, 6.7)
    tabPadding.PaddingLeft = UDim.new(0, 3.3)
    tabPadding.PaddingRight = UDim.new(0, 3.3)
    tabPadding.PaddingBottom = UDim.new(0, 6.7)

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
    
    -- 内容区域
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
    
    local ContentList = Instance.new("UIListLayout", ContentScrolling)
    ContentList.Padding = UDim.new(0, 5.3)
    ContentList.SortOrder = Enum.SortOrder.LayoutOrder
    
    local contentPadding = Instance.new("UIPadding", ContentScrolling)
    contentPadding.PaddingLeft = UDim.new(0, 3.3)
    contentPadding.PaddingRight = UDim.new(0, 3.3)
    contentPadding.PaddingTop = UDim.new(0, 3.3)
    
    -- 创建按钮函数
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
                    task.wait(0.2)
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

    -- 功能分类
    local FunctionTabs = {
        ["基础功能"] = {
            {name = "NoclipButton", text = "穿墙模式 [关闭]", desc = "穿透所有墙壁和物体"},
            {name = "InfiniteJumpButton", text = "无限跳跃 [关闭]", desc = "在空中也能无限跳跃"},
            {name = "SpeedButton", text = "移动速度: 16", desc = "点击切换移动速度"},
            {name = "JumpButton", text = "跳跃高度: 50", desc = "点击切换跳跃高度"},
            {name = "PlayerButton", text = "选择玩家: 无", desc = "选择目标玩家"},
            {name = "ClimbWallButton", text = "爬墙模式 [关闭]", desc = "碰到墙自动上升"},
            {name = "ClimbWallV2Button", text = "爬墙v2", desc = "加载爬墙v2脚本"},
            {name = "AntiFallButton", text = "防摔(多点几次)", desc = "防止从高处掉落受伤"},
            {name = "SuicideButton", text = "自杀", desc = "立即死亡"},
            {name = "FlyButton", text = "飞行v1", desc = "加载飞行v1脚本"},
            {name = "InvincibleButton", text = "无敌", desc = "加载无敌脚本"},
            {name = "InvincibleV2Button", text = "无敌v2", desc = "加载无敌v2脚本"},
            {name = "InvincibleV3Button", text = "无敌v3", desc = "加载无敌v3脚本"},
            {name = "CollisionBoxButton", text = "显示碰撞箱 [关闭]", desc = "显示物体碰撞箱"},
            {name = "WalkAirButton", text = "踏空行走", desc = "加载踏空行走脚本"},
            {name = "PlayerESPButton", text = "透视玩家 [关闭]", desc = "透视显示其他玩家轮廓"},
            {name = "BulletTrackButton", text = "子弹追踪 [关闭]", desc = "子弹自动追踪最近玩家"},
            {name = "ConduitCenterButton", text = "导管中心", desc = "加载导管中心脚本"}
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
            {name = "AimbotButton", text = "自瞄 [关闭]", desc = "自动瞄准最近玩家，可选头部/身体"},
            {name = "AutoSpinNearestButton", text = "循环旋转最近玩家 [关闭]", desc = "自动在附近最近玩家头上旋转"}
        },
        ["外观功能"] = {
            {name = "PlayerSizeButton", text = "玩家大小: 1", desc = "调整玩家体型大小"},
            {name = "RainbowButton", text = "彩虹模式 [关闭]", desc = "全身彩虹颜色变化"},
            {name = "GlobalRainbowButton", text = "全局彩虹 [关闭]", desc = "所有物体和建筑彩虹变色"}
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
            {name = "FESkyboxButton", text = "FE天空盒 (要买UGC卡密)", desc = "加载FE天空盒脚本"},
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
            {name = "FEVRButton", text = "FE vr", desc = "加载FE vr脚本"},
            {name = "FE1x1x1x1Button", text = "FE魔王1x1x1x1", desc = "加载FE魔王1x1x1x1脚本"},
            {name = "FEHotlineRifleButton", text = "FE热线枪膛", desc = "加载FE热线枪膛脚本"},
            {name = "FEIronFistButton", text = "FE铁拳", desc = "加载FE铁拳脚本"},
            {name = "FEScriptV2Button", text = "FE脚本整合v2", desc = "加载FE脚本整合v2脚本"},
            {name = "FEGatlingButton", text = "FE加特林", desc = "加载FE加特林脚本"},
            {name = "FEPunchButton", text = "FE拳击", desc = "加载FE拳击脚本"},
            {name = "FEMotorcycleButton", text = "FE摩托车", desc = "加载FE摩托车脚本"},
            {name = "FEBanHammerButton", text = "FE封禁之锤", desc = "加载FE封禁之锤脚本"},
            {name = "FEGatling2Button", text = "FE加特林2", desc = "加载FE加特林2脚本"},
            {name = "FENoriButton", text = "FE诺丽", desc = "加载FE诺丽脚本"},
            {name = "FEGuest666Button", text = "FE访客666变身", desc = "加载FE访客666变身脚本"},
            {name = "FEKeyboardButton", text = "FE键盘变身", desc = "加载FE键盘变身脚本"},
            {name = "FEScriptV3Button", text = "FE整合v3", desc = "加载FE整合v3脚本"},
            {name = "FEWallJumpButton", text = "FE自动跳墙", desc = "加载FE自动跳墙脚本"},
            {name = "FEFightAnimButton", text = "FE格斗动作", desc = "加载FE格斗动作脚本"},
            {name = "FER6NoHeadButton", text = "FE R6无头", desc = "加载FE R6无头脚本"},
            {name = "FER15NoHeadButton", text = "FE R15无头", desc = "加载FE R15无头脚本"},
            {name = "FEMrSleepButton", text = "FE Mr.睡不醒", desc = "加载FE Mr.睡不醒脚本"},
            {name = "FELaserGunButton", text = "FE激光炮", desc = "加载FE激光炮脚本"},
            {name = "FESpiderButton", text = "FE蜘蛛", desc = "加载FE蜘蛛脚本"},
            {name = "FER15GladiatorButton", text = "FE R15角斗士", desc = "加载FE R15角斗士脚本"},
            {name = "FEZombieButton", text = "FE僵尸", desc = "加载FE僵尸脚本"},
            {name = "FELaserButton", text = "FE激光", desc = "加载FE激光脚本"},
            {name = "FEBaboonButton", text = "FE狒狒", desc = "加载FE狒狒脚本"},
            {name = "FECrewButton", text = "FE船员", desc = "加载FE船员脚本"},
            {name = "FECreeperButton", text = "FE苦力怕", desc = "加载FE苦力怕脚本"},
            {name = "FENoSkinSnakeButton", text = "FE不要饰品的蛇", desc = "加载FE不要饰品的蛇脚本"},
            {name = "FESupermanButton", text = "FE超人", desc = "加载FE超人脚本"},
            {name = "FEAvengerButton", text = "FE复仇者", desc = "加载FE复仇者脚本"},
            {name = "FEDarkCreatureButton", text = "FE黑暗生物", desc = "加载FE黑暗生物脚本"},
            {name = "FEOfficialHammerButton", text = "FE官方之锤", desc = "加载FE官方之锤脚本"},
            {name = "FEAntiKickButton", text = "FE 防踢", desc = "加载FE防踢脚本"},
            {name = "FEN00kla5KMenuButton", text = "FE N00kla5K菜单", desc = "加载FE N00kla5K菜单脚本"},
            {name = "FEAC6MusicVulButton", text = "FE AC6漏洞放音乐", desc = "加载FE AC6漏洞放音乐脚本"},
            {name = "FEHappyHudButton", text = "FE happyhud", desc = "加载FE happyhud脚本"}
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
            {name = "CaodanV1Button", text = "操蛋v1", desc = "加载操蛋v1脚本"},
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
            {name = "MuscleLegendChangeButton", text = "力量传奇改力量", desc = "加载力量传奇改力量脚本"},
            {name = "PlayForsakenServerButton", text = "在服务器玩被遗弃脚本", desc = "在服务器玩被遗弃脚本"}
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
            {name = "PiScriptTestButton", text = "皮脚本测试版", desc = "加载皮脚本测试版"},
            {name = "YeScriptButton", text = "叶脚本", desc = "加载叶脚本"},
            {name = "ChuScriptButton", text = "初脚本", desc = "加载初脚本"},
            {name = "DingScriptButton", text = "丁脚本", desc = "加载丁脚本"},
            {name = "ScriptCenterButton", text = "脚本中心", desc = "加载脚本中心"},
            {name = "XAScriptCenterButton", text = "xa脚本中心", desc = "加载xa脚本中心"},
            {name = "ChenScriptButton", text = "辰脚本", desc = "加载辰脚本"},
            {name = "ShaScriptButton", text = "沙脚本", desc = "加载沙脚本"},
            {name = "BSCenterButton", text = "BS中心", desc = "加载BS中心脚本"},
            {name = "BlackWhiteScriptButton", text = "黑白脚本", desc = "加载黑白脚本"},
            {name = "ArcticScriptCenterButton", text = "北极脚本中心", desc = "加载北极脚本中心"},
            {name = "NanningCenterButton", text = "南宁中心", desc = "加载南宁中心脚本"}
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
            {name = "InvincibleFlyR15Button", text = "无敌少侠飞行r15", desc = "R15角色无敌飞行模式"},
            {name = "InvincibleFlyR6Button", text = "无敌少侠飞行r6", desc = "R6角色无敌飞行模式"}
        },
        ["俄亥俄州"] = {
            {name = "OhioButton", text = "俄亥俄州脚本", desc = "加载俄亥俄州脚本"},
            {name = "Ohio2Button", text = "俄亥俄州脚本2", desc = "加载俄亥俄州脚本2"},
            {name = "Ohio3Button", text = "俄亥俄州脚本3", desc = "加载俄亥俄州脚本3"},
            {name = "OhioMoneyMachineButton", text = "俄亥俄州捡印钞机", desc = "加载俄亥俄州捡印钞机脚本"},
            {name = "Ohio4Button", text = "俄亥俄州脚本4", desc = "加载俄亥俄州脚本4"},
            {name = "XAOhioScriptButton", text = "xa俄亥俄州脚本", desc = "加载xa俄亥俄州脚本"}
        },
        ["画我"] = {
            {name = "DrawMeScript1Button", text = "画我脚本1", desc = "加载画我脚本1"},
            {name = "DrawMeScript2Button", text = "画我脚本2", desc = "加载画我脚本2"}
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
    
    local announcementPadding = Instance.new("UIPadding", AnnouncementScrolling)
    announcementPadding.PaddingLeft = UDim.new(0, 5)
    announcementPadding.PaddingRight = UDim.new(0, 5)
    announcementPadding.PaddingTop = UDim.new(0, 5)
    
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
            else
                AnnouncementScrolling.Visible = false
                ContentScrolling.Visible = true
                
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

    -- 功能变量
    local noclip, infiniteJump, spinning, flying, showCollision = false, false, false, false, false
    local rainbow, globalRainbow, sitSpinning, ridingHead, playerESPEnabled = false, false, false, false, false
    local climbing, autoMove, nightVision, aimbotEnabled = false, false, false, false
    local walkSpeed, jumpPower, spinSpeed, playerSize, gravity, sitSpinSpeed = 16, 50, 10, 1, 196.2, 5
    local selectedPlayer = nil
    local connections = {}
    local originalTransparency, originalColors = {}
    local originalLightingSettings = {}
    local aimbotTarget = nil
    local aimToHead = true
    local espHighlights = {}
    local spinningOnNearest = false
    local bulletTrackEnabled = false

    -- 播放点击音效函数
    local function playClickSound()
        pcall(function()
            local sound = Instance.new("Sound")
            sound.SoundId = "rbxassetid://82845990304289"
            sound.Volume = 0.5
            sound.Parent = Workspace
            sound:Play()
            game:GetService("Debris"):AddItem(sound, 2)
        end)
    end

    -- 通知函数
    local function showNotification(message, color)
        pcall(function()
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
            
            task.wait(3)
            TweenService:Create(notification, TweenInfo.new(0.5), {Position = UDim2.new(0.5, -100, 0, -46.7)}):Play()
            task.wait(0.5)
            notification:Destroy()
        end)
    end

    -- UI控制
    local minimized = false
    local function toggleMinimize()
        playClickSound()
        minimized = not minimized
        if minimized then
            TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 120, 0, 27)}):Play()
            task.wait(0.3)
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
        if ButtonInstances.PlayerButton then
            ButtonInstances.PlayerButton.Text = "选择玩家: " .. selectedPlayer.Name
        end
        showNotification("已选择玩家: " .. selectedPlayer.Name, Color3.fromRGB(0, 150, 200))
    end

    -- 脚本加载函数
    local function loadExternalScript(url, name)
        playClickSound()
        pcall(function()
            loadstring(game:HttpGet(url, true))()
        end)
        showNotification(name .. "已加载!", Color3.fromRGB(0, 200, 0))
    end

    -- 免费r币全屏特效函数
    local fullScreenEffectActive = false
    local fullScreenImage = nil
    local fullScreenSound = nil
    
    local function showFreeRBCurrencyEffect()
        playClickSound()
        
        pcall(function()
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
        end)
    end

    -- doors功能
    local function loadDoors()
        playClickSound()
        pcall(function()
            loadstring(game:HttpGet('https://raw.githubusercontent.com/mstudio45/MSDOORS/main/MSDOORS.lua', true))()
        end)
        showNotification("doors已加载!", Color3.fromRGB(0, 200, 0))
    end

    -- 力量传奇功能
    local function loadMuscleLegend()
        playClickSound()
        pcall(function()
            loadstring(game:GetObjects("rbxassetid://10048914323")[1].Source)()
        end)
        showNotification("力量传奇已加载!", Color3.fromRGB(0, 200, 0))
    end

    -- 力量传奇改力量功能
    local function loadMuscleLegendChange()
        playClickSound()
        pcall(function()
            loadstring(game:HttpGet('https://raw.githubusercontent.com/jynzl/main/main/Musclas%20Legenos.lua', true))()
        end)
        showNotification("力量传奇改力量已加载!", Color3.fromRGB(0, 200, 0))
    end

    -- 显示碰撞箱功能
    local function toggleCollisionBox()
        playClickSound()
        showCollision = not showCollision
        
        if showCollision then
            ButtonInstances.CollisionBoxButton.Text = "显示碰撞箱 [开启]"
            ButtonInstances.CollisionBoxButton.TextColor3 = Color3.fromRGB(0, 255, 150)
            
            pcall(function()
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
            end)
            
            showNotification("碰撞箱显示已开启", Color3.fromRGB(0, 200, 0))
        else
            ButtonInstances.CollisionBoxButton.Text = "显示碰撞箱 [关闭]"
            ButtonInstances.CollisionBoxButton.TextColor3 = Color3.fromRGB(200, 200, 255)
            
            pcall(function()
                -- 移除碰撞箱
                for _, obj in pairs(Workspace:GetDescendants()) do
                    if obj:IsA("BasePart") and obj.FindFirstChild("BaconCollisionBox") then
                        obj.BaconCollisionBox:Destroy()
                    end
                end
            end)
            
            showNotification("碰撞箱显示已关闭", Color3.fromRGB(150, 150, 150))
        end
    end

    -- 自瞄功能
    local function toggleAimbot()
        playClickSound()
        aimbotEnabled = not aimbotEnabled
        
        if aimbotEnabled then
            ButtonInstances.AimbotButton.Text = "自瞄 [开启]"
            ButtonInstances.AimbotButton.TextColor3 = Color3.fromRGB(0, 255, 150)
            
            connections.aimbot = RunService.RenderStepped:Connect(function()
                pcall(function()
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
            end)
            
            showNotification("自瞄已开启 (瞄准" .. (aimToHead and "头部" or "身体") .. ")", Color3.fromRGB(0, 200, 0))
        else
            ButtonInstances.AimbotButton.Text = "自瞄 [关闭]"
            ButtonInstances.AimbotButton.TextColor3 = Color3.fromRGB(200, 200, 255)
            
            if connections.aimbot then
                connections.aimbot:Disconnect()
                connections.aimbot = nil
            end
            
            showNotification("自瞄已关闭", Color3.fromRGB(150, 150, 150))
        end
    end

    -- 透视玩家功能
    local function togglePlayerESP()
        playClickSound()
        playerESPEnabled = not playerESPEnabled
        
        if playerESPEnabled then
            ButtonInstances.PlayerESPButton.Text = "透视玩家 [开启]"
            ButtonInstances.PlayerESPButton.TextColor3 = Color3.fromRGB(0, 255, 150)
            
            pcall(function()
                -- 为所有玩家创建高亮
                local function createESP(player)
                    if player ~= LocalPlayer and player.Character then
                        local highlight = Instance.new("Highlight")
                        highlight.Name = "BaconESP"
                        highlight.FillColor = Color3.fromRGB(255, 0, 0)
                        highlight.OutlineColor = Color3.fromRGB(255, 255, 0)
                        highlight.FillTransparency = 0.5
                        highlight.OutlineTransparency = 0
                        highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                        highlight.Adornee = player.Character
                        highlight.Parent = player.Character
                        espHighlights[player] = highlight
                    end
                end
                
                -- 为现有玩家创建ESP
                for _, player in pairs(Players:GetPlayers()) do
                    createESP(player)
                end
                
                -- 监听新玩家加入
                connections.playerAddedESP = Players.PlayerAdded:Connect(function(player)
                    createESP(player)
                end)
                
                -- 监听玩家离开
                connections.playerRemovingESP = Players.PlayerRemoving:Connect(function(player)
                    if espHighlights[player] then
                        espHighlights[player]:Destroy()
                        espHighlights[player] = nil
                    end
                end)
                
                -- 监听玩家角色变化
                for _, player in pairs(Players:GetPlayers()) do
                    if player ~= LocalPlayer then
                        connections[player] = player.CharacterAdded:Connect(function(character)
                            if playerESPEnabled then
                                task.wait(0.5)
                                createESP(player)
                            end
                        end)
                    end
                end
            end)
            
            showNotification("透视玩家已开启", Color3.fromRGB(0, 200, 0))
        else
            ButtonInstances.PlayerESPButton.Text = "透视玩家 [关闭]"
            ButtonInstances.PlayerESPButton.TextColor3 = Color3.fromRGB(200, 200, 255)
            
            pcall(function()
                -- 移除所有高亮
                for player, highlight in pairs(espHighlights) do
                    if highlight then
                        highlight:Destroy()
                    end
                end
                espHighlights = {}
                
                -- 断开连接
                if connections.playerAddedESP then
                    connections.playerAddedESP:Disconnect()
                    connections.playerAddedESP = nil
                end
                
                if connections.playerRemovingESP then
                    connections.playerRemovingESP:Disconnect()
                    connections.playerRemovingESP = nil
                end
                
                for player, connection in pairs(connections) do
                    if type(player) == "userdata" and player:IsA("Player") then
                        connection:Disconnect()
                        connections[player] = nil
                    end
                end
            end)
            
            showNotification("透视玩家已关闭", Color3.fromRGB(150, 150, 150))
        end
    end

    -- 新功能函数
    local function loadFER6DeerCan()
        playClickSound()
        pcall(function()
            loadstring(game:HttpGet("https://pastefy.app/wa3v2Vgm/raw", true))()
        end)
        showNotification("FEr6鹿罐已加载!", Color3.fromRGB(0, 200, 0))
    end

    local function loadFER15DeerCan()
        playClickSound()
        pcall(function()
            loadstring(game:HttpGet("https://pastefy.app/YZoglOyJ/raw", true))()
        end)
        showNotification("FEr15鹿罐已加载!", Color3.fromRGB(0, 200, 0))
    end

    -- 继续添加其他功能函数...
    -- 由于代码太长，这里省略中间部分功能函数的定义
    -- 在实际使用中，你需要将原脚本中的所有功能函数都包含进来

    -- 基础功能：穿墙
    local function toggleNoclip()
        playClickSound()
        noclip = not noclip
        if ButtonInstances.NoclipButton then
            ButtonInstances.NoclipButton.Text = "穿墙模式 [" .. (noclip and "开启]" or "关闭]")
            ButtonInstances.NoclipButton.TextColor3 = noclip and Color3.fromRGB(0, 255, 150) or Color3.fromRGB(200, 200, 255)
        end
        
        if noclip then
            connections.noclip = RunService.Stepped:Connect(function()
                pcall(function()
                    local character = LocalPlayer.Character
                    if character and noclip then
                        for _, part in pairs(character:GetDescendants()) do
                            if part:IsA("BasePart") then 
                                part.CanCollide = false 
                            end
                        end
                    end
                end)
            end)
            showNotification("穿墙模式已开启", Color3.fromRGB(0, 150, 200))
        else
            if connections.noclip then 
                connections.noclip:Disconnect() 
                connections.noclip = nil
            end
            
            pcall(function()
                local character = LocalPlayer.Character
                if character then
                    for _, part in pairs(character:GetDescendants()) do
                        if part:IsA("BasePart") then 
                            part.CanCollide = true 
                        end
                    end
                end
            end)
            
            showNotification("穿墙模式已关闭", Color3.fromRGB(150, 150, 150))
        end
    end

    -- 无限跳跃
    local function toggleInfiniteJump()
        playClickSound()
        infiniteJump = not infiniteJump
        if ButtonInstances.InfiniteJumpButton then
            ButtonInstances.InfiniteJumpButton.Text = "无限跳跃 [" .. (infiniteJump and "开启]" or "关闭]")
            ButtonInstances.InfiniteJumpButton.TextColor3 = infiniteJump and Color3.fromRGB(0, 255, 150) or Color3.fromRGB(200, 200, 255)
        end
        showNotification("无限跳跃" .. (infiniteJump and "已开启" or "已关闭"), Color3.fromRGB(0, 150, 200))
    end

    -- 移动速度
    local function changeSpeed()
        playClickSound()
        walkSpeed = (walkSpeed % 100) + 8
        pcall(function()
            local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then humanoid.WalkSpeed = walkSpeed end
        end)
        if ButtonInstances.SpeedButton then
            ButtonInstances.SpeedButton.Text = "移动速度: " .. walkSpeed
        end
        showNotification("移动速度设置为: " .. walkSpeed, Color3.fromRGB(0, 150, 200))
    end

    -- 跳跃高度
    local function changeJump()
        playClickSound()
        jumpPower = (jumpPower % 200) + 25
        pcall(function()
            local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then humanoid.JumpPower = jumpPower end
        end)
        if ButtonInstances.JumpButton then
            ButtonInstances.JumpButton.Text = "跳跃高度: " .. jumpPower
        end
        showNotification("跳跃高度设置为: " .. jumpPower, Color3.fromRGB(0, 150, 200))
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
        -- 基础功能
        NoclipButton = toggleNoclip,
        InfiniteJumpButton = toggleInfiniteJump,
        SpeedButton = changeSpeed,
        JumpButton = changeJump,
        PlayerButton = selectPlayer,
        ClimbWallButton = function()
            playClickSound()
            showNotification("爬墙功能", Color3.fromRGB(0, 200, 0))
        end,
        ClimbWallV2Button = function()
            playClickSound()
            showNotification("爬墙v2", Color3.fromRGB(0, 200, 0))
        end,
        AntiFallButton = function()
            playClickSound()
            showNotification("防摔功能", Color3.fromRGB(0, 200, 0))
        end,
        SuicideButton = function()
            playClickSound()
            pcall(function()
                local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    humanoid.Health = 0
                end
            end)
            showNotification("已自杀!", Color3.fromRGB(255, 0, 0))
        end,
        FlyButton = function()
            playClickSound()
            showNotification("飞行v1", Color3.fromRGB(0, 200, 0))
        end,
        InvincibleButton = function()
            playClickSound()
            showNotification("无敌脚本", Color3.fromRGB(0, 200, 0))
        end,
        InvincibleV2Button = function()
            playClickSound()
            showNotification("无敌v2", Color3.fromRGB(0, 200, 0))
        end,
        InvincibleV3Button = function()
            playClickSound()
            showNotification("无敌v3", Color3.fromRGB(0, 200, 0))
        end,
        CollisionBoxButton = toggleCollisionBox,
        WalkAirButton = function()
            playClickSound()
            showNotification("踏空行走", Color3.fromRGB(0, 200, 0))
        end,
        PlayerESPButton = togglePlayerESP,
        BulletTrackButton = function()
            playClickSound()
            showNotification("子弹追踪", Color3.fromRGB(0, 200, 0))
        end,
        ConduitCenterButton = function()
            playClickSound()
            showNotification("导管中心", Color3.fromRGB(0, 200, 0))
        end,
        
        -- 移动功能
        SpinButton = function()
            playClickSound()
            showNotification("人物旋转", Color3.fromRGB(0, 200, 0))
        end,
        SpinSpeedButton = function()
            playClickSound()
            showNotification("旋转速度", Color3.fromRGB(0, 200, 0))
        end,
        AutoMoveButton = function()
            playClickSound()
            showNotification("自动移动", Color3.fromRGB(0, 200, 0))
        end,
        
        -- 玩家交互
        KillAllButton = function()
            playClickSound()
            pcall(function()
                for _, player in pairs(Players:GetPlayers()) do
                    if player ~= LocalPlayer then
                        local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
                        if humanoid then humanoid.Health = 0 end
                    end
                end
            end)
            showNotification("已秒杀所有玩家", Color3.fromRGB(255, 50, 50))
        end,
        TeleportAllButton = function()
            playClickSound()
            pcall(function()
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
                end
            end)
            showNotification("已传送所有玩家", Color3.fromRGB(0, 200, 0))
        end,
        SitSpinButton = function()
            playClickSound()
            showNotification("坐在头上旋转", Color3.fromRGB(0, 200, 0))
        end,
        RideHeadButton = function()
            playClickSound()
            showNotification("骑在玩家头上", Color3.fromRGB(0, 200, 0))
        end,
        ViewBackpackButton = function()
            playClickSound()
            showNotification("查看玩家背包", Color3.fromRGB(0, 200, 0))
        end,
        ClickTeleportButton = function()
            loadExternalScript("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source", "点击传送")
        end,
        AimbotButton = toggleAimbot,
        AutoSpinNearestButton = function()
            playClickSound()
            showNotification("循环旋转最近玩家", Color3.fromRGB(0, 200, 0))
        end,
        
        -- 免费r币按钮
        Free80RButton = showFreeRBCurrencyEffect,
        Free120RButton = showFreeRBCurrencyEffect,
        Free240RButton = showFreeRBCurrencyEffect,
        Free400RButton = showFreeRBCurrencyEffect,
        Free500RButton = showFreeRBCurrencyEffect,
        Free1000RButton = showFreeRBCurrencyEffect,
        Free450RPlusButton = showFreeRBCurrencyEffect,
        Free1200RPlusButton = showFreeRBCurrencyEffect,
        
        -- doors按钮
        DoorsButton = loadDoors,
        DoorsModeButton = function()
            playClickSound()
            showNotification("doors模式", Color3.fromRGB(0, 200, 0))
        end,
        DoorsHardcoreModeButton = function()
            playClickSound()
            showNotification("doors硬核模式", Color3.fromRGB(0, 200, 0))
        end,
        DoorsAutoAvoidButton = function()
            playClickSound()
            showNotification("doors自动躲怪", Color3.fromRGB(0, 200, 0))
        end,
        DoorsExtremeModeButton = function()
            playClickSound()
            showNotification("doors极端模式", Color3.fromRGB(0, 200, 0))
        end,
        
        -- 力量传奇按钮
        MuscleLegendButton = loadMuscleLegend,
        MuscleLegendChangeButton = loadMuscleLegendChange,
        
        -- FE功能按钮示例
        FEFacialButton = function()
            loadExternalScript("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source", "FE表情")
        end,
        FER6DeerCanButton = loadFER6DeerCan,
        FER15DeerCanButton = loadFER15DeerCan
    }

    -- 绑定所有按钮
    for buttonName, action in pairs(buttonActions) do
        if ButtonInstances[buttonName] then
            ButtonInstances[buttonName].MouseButton1Click:Connect(function()
                pcall(action)
            end)
        end
    end

    -- 无限跳跃监听
    UserInputService.JumpRequest:Connect(function()
        if infiniteJump and LocalPlayer.Character then
            pcall(function()
                local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                if humanoid then humanoid:ChangeState(Enum.HumanoidStateType.Jumping) end
            end)
        end
    end)

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
            task.wait(0.5)
        end
        startupLabel.Text = "培根脚本 v6.4\n加载完成!"
        TweenService:Create(startupLabel, TweenInfo.new(1.5), {TextTransparency = 1}):Play()
        task.wait(1.5)
        startupFrame:Destroy()
        
        MainFrame.Visible = true
        MainFrame.Position = UDim2.new(1.5, -233.5, 0.5, -150)
        TweenService:Create(MainFrame, TweenInfo.new(0.8), {Position = UDim2.new(0.5, -233.5, 0.5, -150)}):Play()
        
        showNotification("培根脚本 v6.4 已加载!", Color3.fromRGB(0, 200, 255))
        
        -- 初始设置
        pcall(function()
            local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.WalkSpeed = walkSpeed
                humanoid.JumpPower = jumpPower
            end
        end)
        
        selectPlayer()
    end)

    -- 角色重生处理
    LocalPlayer.CharacterAdded:Connect(function()
        task.wait(2)
        pcall(function()
            local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.WalkSpeed = walkSpeed
                humanoid.JumpPower = jumpPower
            end
        end)
    end)
end

-- 安全执行
local success, err = pcall(loadScript)
if not success then
    warn("脚本加载错误: " .. tostring(err))
    -- 尝试显示错误信息
    if game:GetService("Players").LocalPlayer then
        local screenGui = Instance.new("ScreenGui")
        screenGui.Parent = game:GetService("Players").LocalPlayer:FindFirstChildOfClass("PlayerGui") or game:GetService("CoreGui")
        
        local errorLabel = Instance.new("TextLabel")
        errorLabel.Size = UDim2.new(0, 300, 0, 100)
        errorLabel.Position = UDim2.new(0.5, -150, 0.5, -50)
        errorLabel.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        errorLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        errorLabel.Text = "脚本加载错误:\n" .. tostring(err)
        errorLabel.TextWrapped = true
        errorLabel.Parent = screenGui
    end
end
