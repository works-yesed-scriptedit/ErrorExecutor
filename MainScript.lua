--MainScript

--サーバー接続後のスクリプト
local success, err = pcall(function()  
	local scriptUrl = ""  
	queueonteleport("loadstring(game:HttpGet('" .. scriptUrl .. "'))()")  
end)
--ローディング
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local loadingGui = Instance.new("ScreenGui")
loadingGui.Name = "LoadingGui"
loadingGui.ResetOnSpawn = false
loadingGui.Parent = playerGui

-- Frameで中央に寄せる
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 200, 0, 60)
frame.Position = UDim2.new(0.5, -100, 0.5, -30)
frame.BackgroundTransparency = 1
frame.Parent = loadingGui

-- タイトル（赤文字）
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0.5, 0)
titleLabel.Position = UDim2.new(0, 0, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "Error Executor"
titleLabel.TextColor3 = Color3.fromRGB(255, 50, 50)
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 20
titleLabel.TextStrokeTransparency = 0.5
titleLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
titleLabel.Parent = frame

-- Loading...（白文字）
local loadingLabel = Instance.new("TextLabel")
loadingLabel.Size = UDim2.new(1, 0, 0.5, 0)
loadingLabel.Position = UDim2.new(0, 0, 0.5, 0)
loadingLabel.BackgroundTransparency = 1
loadingLabel.Text = "Loading."
loadingLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
loadingLabel.Font = Enum.Font.Gotham
loadingLabel.TextSize = 18
loadingLabel.Parent = frame

-- アニメーション表示
local dots = {".", "..", "..."}
local startTime = tick()
local index = 1
while tick() - startTime < 5 do
	loadingLabel.Text = "Loading" .. dots[index]
	index = index % #dots + 1
	task.wait(0.5)
end

-- 表示終了して削除
loadingGui:Destroy()

-- 1秒待って本体処理へ
task.wait(1)

-- ← ここからGUI生成コードなどを実行
-- GUIの親（StarterGuiなどに入れる用）
local ScreenGui = Instance.new("ScreenGui", game.Players.LocalPlayer:WaitForChild("PlayerGui"))
ScreenGui.ResetOnSpawn = false
ScreenGui.Name = "ErrorExecutorGUI"

-- メインフレーム
local mainFrame = Instance.new("Frame", ScreenGui)
mainFrame.Size = UDim2.new(0, 500, 0, 280)
mainFrame.Position = UDim2.new(0.5, -250, 0.5, -140)
mainFrame.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Name = "MainFrame"

local mainCorner = Instance.new("UICorner", mainFrame)
mainCorner.CornerRadius = UDim.new(0, 12)

-- トップバー
local topBar = Instance.new("Frame", mainFrame)
topBar.Size = UDim2.new(1, 0, 0, 30)
topBar.BackgroundTransparency = 1
topBar.Name = "TopBar"

-- タイトルラベル
local title = Instance.new("TextLabel", topBar)
title.Size = UDim2.new(1, -60, 1, 0)
title.Position = UDim2.new(0, 10, 0, 0)
title.BackgroundTransparency = 1
title.Text = "Error Executor"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.TextXAlignment = Enum.TextXAlignment.Left

-- 閉じるボタン（×）
local closeButton = Instance.new("TextButton", topBar)
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -30, 0, 0)
closeButton.BackgroundTransparency = 1
closeButton.Text = "×"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.Font = Enum.Font.GothamBold
closeButton.TextSize = 20
closeButton.Name = "CloseButton"

closeButton.MouseButton1Click:Connect(function()
	ScreenGui:Destroy()
end)

-- 最小化ボタン
local minimizeButton = Instance.new("TextButton", topBar)
minimizeButton.Size = UDim2.new(0, 30, 0, 30)
minimizeButton.Position = UDim2.new(1, -60, 0, 0)
minimizeButton.BackgroundTransparency = 1
minimizeButton.Text = "-"
minimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
minimizeButton.Font = Enum.Font.GothamBold
minimizeButton.TextSize = 20
minimizeButton.Name = "MinimizeButton"

-- 中身を格納するFrame
local contentFrame = Instance.new("Frame", mainFrame)
contentFrame.Size = UDim2.new(1, 0, 1, -30)
contentFrame.Position = UDim2.new(0, 0, 0, 30)
contentFrame.BackgroundTransparency = 1
contentFrame.Name = "ContentFrame"

-- スクロール付きスクリプト入力欄
local scrollingFrame = Instance.new("ScrollingFrame", contentFrame)
scrollingFrame.Size = UDim2.new(1, -20, 0, 160)
scrollingFrame.Position = UDim2.new(0, 10, 0, 10)
scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
scrollingFrame.ScrollBarThickness = 8
scrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
scrollingFrame.BackgroundTransparency = 1
scrollingFrame.Name = "ScriptScrollFrame"
scrollingFrame.ClipsDescendants = true

-- 行番号ラベル
local lineNumbers = Instance.new("TextLabel", scrollingFrame)
lineNumbers.Size = UDim2.new(0, 40, 0, 160)
lineNumbers.Position = UDim2.new(0, 0, 0, 0)
lineNumbers.BackgroundTransparency = 1
lineNumbers.TextColor3 = Color3.fromRGB(200, 200, 200)
lineNumbers.Font = Enum.Font.Code
lineNumbers.TextSize = 16
lineNumbers.TextXAlignment = Enum.TextXAlignment.Left
lineNumbers.TextYAlignment = Enum.TextYAlignment.Top
lineNumbers.TextWrapped = false
lineNumbers.Text = "1| "
lineNumbers.Name = "LineNumbers"
lineNumbers.AutomaticSize = Enum.AutomaticSize.Y

-- スクリプト TextBox
local inputBox = Instance.new("TextBox", scrollingFrame)
inputBox.Position = UDim2.new(0, 45, 0, 0)
inputBox.Size = UDim2.new(1, -45, 0, 160)
inputBox.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
inputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
inputBox.Text = "Enter your script"
inputBox.ClearTextOnFocus = false
inputBox.Font = Enum.Font.Code
inputBox.TextSize = 16
inputBox.TextXAlignment = Enum.TextXAlignment.Left
inputBox.TextYAlignment = Enum.TextYAlignment.Top
inputBox.MultiLine = true
inputBox.TextWrapped = false
inputBox.TextEditable = true
inputBox.Name = "InputBox"

local inputCorner = Instance.new("UICorner", inputBox)
inputCorner.CornerRadius = UDim.new(0, 6)

-- 行番号更新関数
local function updateLineNumbers()
	local lines = inputBox.Text:split("\n")
	local newText = ""
	for i = 1, #lines do
		newText = newText .. i .. "| \n"
	end
	if #lines == 0 then
		newText = "1| "
	end
	lineNumbers.Text = newText

	-- 行数に応じて高さ調整
	local lineCount = math.max(1, #lines)
	local height = lineCount * 20
	inputBox.Size = UDim2.new(1, -45, 0, height)
	scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, inputBox.AbsoluteSize.Y)
end
inputBox:GetPropertyChangedSignal("Text"):Connect(updateLineNumbers)
updateLineNumbers()

-- 実行ボタン
local executeButton = Instance.new("TextButton", contentFrame)
executeButton.Size = UDim2.new(0, 100, 0, 30)
executeButton.Position = UDim2.new(0.5, -110, 1, -35)
executeButton.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
executeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
executeButton.Font = Enum.Font.GothamBold
executeButton.TextSize = 16
executeButton.Text = "実行"
executeButton.Name = "ExecuteButton"

local execCorner = Instance.new("UICorner", executeButton)
execCorner.CornerRadius = UDim.new(0, 6)

executeButton.MouseButton1Click:Connect(function()
	local code = inputBox.Text
	local func, err = loadstring(code)
	if func then
		pcall(func)
	else
		warn("実行エラー: " .. tostring(err))
	end
end)

-- Clearボタン
local clearButton = Instance.new("TextButton", contentFrame)
clearButton.Size = UDim2.new(0, 80, 0, 26)
clearButton.Position = UDim2.new(0.5, 20, 1, -33)
clearButton.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
clearButton.TextColor3 = Color3.fromRGB(255, 255, 255)
clearButton.Font = Enum.Font.GothamBold
clearButton.TextSize = 14
clearButton.Text = "Clear"
clearButton.Name = "ClearButton"

local clearCorner = Instance.new("UICorner", clearButton)
clearCorner.CornerRadius = UDim.new(0, 6)

clearButton.MouseButton1Click:Connect(function()
	inputBox.Text = ""
end)

-- 最小化処理
local isMinimized = false
minimizeButton.MouseButton1Click:Connect(function()
	isMinimized = not isMinimized
	contentFrame.Visible = not isMinimized
	minimizeButton.Text = isMinimized and "+" or "-"
	if isMinimized then
		mainFrame.Size = UDim2.new(0, 500, 0, 30)
	else
		mainFrame.Size = UDim2.new(0, 500, 0, 280)
	end
end)
