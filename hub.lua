local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TextChatService = game:GetService("TextChatService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- 🔥 [Xeno / Delta 전용] UI 튕김 완벽 방지 안전 할당
local UI_Parent = LocalPlayer:WaitForChild("PlayerGui")
pcall(function()
    local hui = (gethui and gethui()) or game:GetService("CoreGui")
    if hui then UI_Parent = hui end
end)

-- 기존 UI 안전하게 삭제
for _, v in pairs(UI_Parent:GetChildren()) do
    if v.Name == "Launcher_Hub" or v.Name == "ValoStyle_Hub" or v.Name == "ValoStyle_Min" or v.Name == "WordChain_Hub" or v.Name == "TeleportGunGui" or v.Name == "AutoShootGui" or v.Name == "GunDropNotify" then
        v:Destroy()
    end
end

--------------------------------------------------------------------
-- 🚀 1. 최초 실행 런처 UI (검/빨 Wave 애니메이션)
--------------------------------------------------------------------
local launcherGui = Instance.new("ScreenGui")
launcherGui.Name = "Launcher_Hub"
launcherGui.ResetOnSpawn = false
launcherGui.IgnoreGuiInset = true
launcherGui.DisplayOrder = 999999
launcherGui.Parent = UI_Parent

local LauncherFrame = Instance.new("Frame", launcherGui)
LauncherFrame.Size = UDim2.new(0, 300, 0, 180)
LauncherFrame.AnchorPoint = Vector2.new(0.5, 0.5)
LauncherFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
LauncherFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
LauncherFrame.BorderSizePixel = 0
Instance.new("UICorner", LauncherFrame).CornerRadius = UDim.new(0, 8)
local lStroke = Instance.new("UIStroke", LauncherFrame)
lStroke.Color = Color3.fromRGB(255, 0, 0)
lStroke.Thickness = 2

local lGradient = Instance.new("UIGradient", LauncherFrame)
lGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(15, 0, 0)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(150, 0, 0)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 0, 0))
}
lGradient.Rotation = 45

RunService.RenderStepped:Connect(function()
    if lGradient then
        lGradient.Offset = Vector2.new(math.sin(tick() * 2) * 0.5, 0)
    end
end)

local LTitle = Instance.new("TextLabel", launcherGui) -- 수정
LTitle.Size = UDim2.new(1, 0, 0, 40)
LTitle.Parent = LauncherFrame
LTitle.BackgroundTransparency = 1
LTitle.Text = "SELECT YOUR CHEAT"
LTitle.TextColor3 = Color3.fromRGB(255, 180, 180)
LTitle.Font = Enum.Font.GothamBlack
LTitle.TextSize = 16

local BtnMurder = Instance.new("TextButton", launcherGui)
BtnMurder.Size = UDim2.new(0.8, 0, 0, 45)
BtnMurder.Position = UDim2.new(0.1, 0, 0, 55)
BtnMurder.Parent = LauncherFrame
BtnMurder.BackgroundColor3 = Color3.fromRGB(20, 0, 0)
BtnMurder.Text = "🔪 MURDER MYSTERY 2"
BtnMurder.TextColor3 = Color3.fromRGB(255, 50, 50)
BtnMurder.Font = Enum.Font.GothamBold
BtnMurder.TextSize = 14
Instance.new("UICorner", BtnMurder).CornerRadius = UDim.new(0, 6)
Instance.new("UIStroke", BtnMurder).Color = Color3.fromRGB(200, 0, 0)

local BtnWord = Instance.new("TextButton", launcherGui)
BtnWord.Size = UDim2.new(0.8, 0, 0, 45)
BtnWord.Position = UDim2.new(0.1, 0, 0, 115)
BtnWord.Parent = LauncherFrame
BtnWord.BackgroundColor3 = Color3.fromRGB(20, 0, 0)
BtnWord.Text = "💬 AUTO WORD CHAIN"
BtnWord.TextColor3 = Color3.fromRGB(255, 80, 80)
BtnWord.Font = Enum.Font.GothamBold
BtnWord.TextSize = 14
Instance.new("UICorner", BtnWord).CornerRadius = UDim.new(0, 6)
Instance.new("UIStroke", BtnWord).Color = Color3.fromRGB(200, 0, 0)

local LClose = Instance.new("TextButton", launcherGui)
LClose.Size = UDim2.new(0, 30, 0, 30)
LClose.Position = UDim2.new(1, -30, 0, 0)
LClose.Parent = LauncherFrame
LClose.BackgroundTransparency = 1
LClose.Text = "✕"
LClose.TextColor3 = Color3.fromRGB(255, 255, 255)
LClose.Font = Enum.Font.GothamBold
LClose.TextSize = 12
LClose.MouseButton1Click:Connect(function() launcherGui:Destroy() end)

--------------------------------------------------------------------
-- 💬 2. 끝말잇기 (Word Chain) 완벽 복구
--------------------------------------------------------------------
local function LoadWordChain()
    local wcGui = Instance.new("ScreenGui")
    wcGui.Name = "WordChain_Hub"
    wcGui.ResetOnSpawn = false
    wcGui.DisplayOrder = 999999
    wcGui.Parent = UI_Parent

    local WCFrame = Instance.new("Frame", wcGui)
    WCFrame.Size = UDim2.new(0, 350, 0, 250)
    WCFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    WCFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    WCFrame.BackgroundColor3 = Color3.fromRGB(15, 0, 0)
    Instance.new("UICorner", WCFrame).CornerRadius = UDim.new(0, 6)
    Instance.new("UIStroke", WCFrame).Color = Color3.fromRGB(255, 0, 0)

    local WTitle = Instance.new("TextLabel", WCFrame)
    WTitle.Size = UDim2.new(1, 0, 0, 30)
    WTitle.BackgroundTransparency = 1
    WTitle.Text = " 💬 AUTO ONE-HIT WORD BOT"
    WTitle.TextColor3 = Color3.fromRGB(255, 100, 100)
    WTitle.Font = Enum.Font.GothamBlack
    WTitle.TextSize = 13
    WTitle.TextXAlignment = Enum.TextXAlignment.Left

    local WClose = Instance.new("TextButton", WCFrame)
    WClose.Size = UDim2.new(0, 30, 0, 30)
    WClose.Position = UDim2.new(1, -30, 0, 0)
    WClose.BackgroundTransparency = 1
    WClose.Text = "✕"
    WClose.TextColor3 = Color3.fromRGB(255, 80, 80)
    WClose.Font = Enum.Font.GothamBold
    WClose.MouseButton1Click:Connect(function() wcGui:Destroy() end)

    local InputBox = Instance.new("TextBox", WCFrame)
    InputBox.Size = UDim2.new(0.9, 0, 0, 40)
    InputBox.Position = UDim2.new(0.05, 0, 0, 40)
    InputBox.BackgroundColor3 = Color3.fromRGB(30, 10, 10)
    InputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    InputBox.PlaceholderText = "수동 발사: 첫 글자 입력 (예: 륨, 슘, 녘)"
    InputBox.Font = Enum.Font.GothamBold
    InputBox.TextSize = 13
    Instance.new("UICorner", InputBox).CornerRadius = UDim.new(0, 6)

    local AutoWordBot = false
    local AutoToggleBtn = Instance.new("TextButton", WCFrame)
    AutoToggleBtn.Size = UDim2.new(0.9, 0, 0, 40)
    AutoToggleBtn.Position = UDim2.new(0.05, 0, 0, 90)
    AutoToggleBtn.BackgroundColor3 = Color3.fromRGB(30, 10, 10)
    AutoToggleBtn.Text = "🤖 채팅 자동 감지 봇 [OFF]"
    AutoToggleBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
    AutoToggleBtn.Font = Enum.Font.GothamBlack
    AutoToggleBtn.TextSize = 14
    Instance.new("UICorner", AutoToggleBtn).CornerRadius = UDim.new(0, 6)

    local SendBtn = Instance.new("TextButton", WCFrame)
    SendBtn.Size = UDim2.new(0.9, 0, 0, 40)
    SendBtn.Position = UDim2.new(0.05, 0, 0, 140)
    SendBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    SendBtn.Text = "⚡ 수동으로 한방단어 발사"
    SendBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    SendBtn.Font = Enum.Font.GothamBlack
    SendBtn.TextSize = 14
    Instance.new("UICorner", SendBtn).CornerRadius = UDim.new(0, 6)

    local OutputLog = Instance.new("TextLabel", WCFrame)
    OutputLog.Size = UDim2.new(0.9, 0, 0, 25)
    OutputLog.Position = UDim2.new(0.05, 0, 0, 190)
    OutputLog.BackgroundTransparency = 1
    OutputLog.Text = "대사전 로드 완료 (수만 개 단어 대기 중)"
    OutputLog.TextColor3 = Color3.fromRGB(200, 150, 150)
    OutputLog.Font = Enum.Font.Gotham
    OutputLog.TextSize = 11

    local OneShotDict = {
        ["쁨"] = {"쁨나무", "쁨새", "쁨이", "쁨내", "쁨루", "쁨쁨이", "쁨다"},
        ["슭"] = {"슭곰", "슭곰발", "슭막이", "슭배기", "슭산"},
        ["녘"] = {"녘새발", "녘노을", "녘놀", "녘바람", "녘해"},
        ["껑"] = {"껑충껑충", "껑질", "껑술", "껑정거리다", "껑충이"},
        ["늄"] = {"늄바리", "늄장", "늄창", "늄본", "늄침"},
        ["윰"] = {"윰차", "윰키밀", "윰라대왕", "윰니", "윰보"},
        ["욤"] = {"욤욤", "욤뇸뇸", "욤마", "욤차", "욤미"},
        ["밭"] = {"밭두렁", "밭고랑", "밭이랑", "밭작물", "밭농사", "밭갈이", "밭마늘", "밭지숡"},
        ["엌"] = {"엌소리", "엌사리", "엌장", "엌지", "엌풀"},
        ["승"] = {"승리", "승용차", "승무원", "승강기", "승패"},
        ["튬"] = {"튬바리", "튬스톤", "튬장", "튬본", "튬석", "라듐"},
        ["탉"] = {"탉발", "탉고기", "탉새", "탉장", "탉싸움"},
        ["꿑"] = {"꿑머리", "꿑바리", "꿑동", "꿑산", "꿑점"},
        ["앗"] = {"앗시리아", "앗싸리", "앗아", "앗뜨거", "앗차"},
        ["슘"] = {"슘페터", "슘바리", "슘장", "슘창", "슘당", "칼슘"},
        ["범"] = {"범죄자", "범인", "범고래", "범선", "범람"},
        ["즈"] = {"즈믄", "즈봉", "즈크", "즈음", "즈려밟다", "즘슉"},
        ["른"] = {"른자", "른소리", "른쪽", "른바리", "른상"},
        ["택"] = {"택조", "택시", "택배", "택지", "택일"},
        ["형"] = {"형광펜", "형제", "형사", "형무소", "형벌"},
        ["가"] = {"가린긿", "가돌리늄", "가뫼", "가쿄", "가매솣", "가래틋", "가믐", "가도멸괵", "가웨", "가른웨", "가게비참웨"},
        ["묏"] = {"묏긿"}, ["앏"] = {"앏긿"}, ["큰"] = {"큰긿"}, ["긿"] = {"긿다"},
        ["다"] = {"다봊", "다이아뎀", "다이조늄", "다름슈타튬", "다래쨤", "다적", "다뤠", "다시마숲"},
        ["수"] = {"수톹", "수갏", "수탉", "수땽", "수수땽", "수제비태껸", "수산화나트륨"},
        ["암"] = {"암톹", "암수갏", "암탉"},
        ["귀"] = {"귀썀"}, ["상"] = {"상추썀"},
        ["게"] = {"게르마늄", "게훽"}, ["넵"] = {"넵투늄"}, ["니"] = {"니호늄", "니오븀"},
        ["더"] = {"더브늄"}, ["데"] = {"데카메토늄", "데릭스텝", "데엋"},
        ["디"] = {"디아조늄", "디디뮴"}, ["라"] = {"라디오악티늄", "라듐"}, ["란"] = {"란타늄"},
        ["레"] = {"레늄", "레티큘"}, ["몰"] = {"몰리브데넘산암모늄", "몰래왙"},
        ["륀"] = {"륀트게늄"}, ["루"] = {"루테늄", "루비듐"}, ["싱"] = {"싱고늄"}, ["숭"] = {"숭늄"},
        ["셀"] = {"셀레늄"}, ["베"] = {"베크로늄", "베릴륨"}, ["무"] = {"무늬제라늄", "무뤂"},
        ["뚫"] = {"뚫음무늬"}, ["련"] = {"련꽃무늬", "련속무늬"}, ["룡"] = {"룡무늬"},
        ["깃"] = {"깃무늬"}, ["잎"] = {"잎점무늬"}, ["축"] = {"축복무늬"},
        ["톱"] = {"톱날무늬", "톱니무늬"}, ["격"] = {"격자무늬"}, ["귤"] = {"귤껍질무늬"},
        ["릉"] = {"릉형무늬"}, ["땅"] = {"땅붤"}, ["저"] = {"저꼇", "저우커우뎬", "저쭘"},
        ["바"] = {"바꼇", "바릊", "바다곬", "바나듐"}, ["돌"] = {"돌꼇"}, ["뜨"] = {"뜨꺼븡"},
        ["나"] = {"나이오븀", "나사렛", "나준녘", "나른", "나가오카쿄", "나트륨"},
        ["이"] = {"이터븀", "이깞", "이오포데이트소듐", "이붖", "이웆", "이윶", "이쭘", "이테르븀"},
        ["터"] = {"터븀"}, ["테"] = {"테르븀"}, ["에"] = {"에르븀", "에이쿄"},
        ["어"] = {"어븀", "어렷두렷"}, ["아"] = {"아스트롤라븀", "아랫입숡", "아르꿑", "아랫눈쎂", "알루미늄"},
        ["안"] = {"안뒤꼍", "안녘", "안찱"}, ["모"] = {"모스코븀", "모롶"},
        ["멘"] = {"멘델레븀"}, ["플"] = {"플레로븀", "플루토늄"}, ["첫"] = {"첫긑", "첫밗"},
        ["법"] = {"법딍"}, ["시"] = {"시냏", "시욱갇", "시루볜", "시쿄", "시톄", "시앗"},
        ["그"] = {"그븜", "그쯤"}, ["따"] = {"따듬돍"}, ["입"] = {"입숡"},
        ["쇠"] = {"쇠꿑"}, ["잠"] = {"잠꽌"}, ["장"] = {"장꽌", "장냔", "장닼", "장잘볌"},
        ["쌍"] = {"쌍결", "쌍히읗"}, ["배"] = {"배고픔", "배아픔"}, ["혼"] = {"혼숡"},
        ["갇"] = {"갇긴"}, ["구"] = {"구녝", "구읫잫", "구듨곬"}, ["뉘"] = {"뉘우춤"},
        ["춤"] = {"춤꾼"}, ["제"] = {"제꼇"}, ["정"] = {"정녝"}, ["황"] = {"황제펭귄", "황촨"},
        ["네"] = {"네오디뮴", "네오머스캇", "네트웤"}, ["홀"] = {"홀뮴"},
        ["피"] = {"피토크로뮴", "피읖"}, ["히"] = {"히읗"}, ["프"] = {"프라세오디뮴", "프로큠"},
        ["오"] = {"오스뮴"}, ["카"] = {"카드뮴"}, ["마"] = {"마즙", "마웉", "마그네슘"},
        ["기"] = {"기띰", "기왕이믄", "기듕", "기록"}, ["자"] = {"자녜", "자르코늄"},
        ["사"] = {"사태막이숲", "사과쨤", "사마륨"}, ["면"] = {"면플란넬"}, ["슨"] = {"슨몽"},
        ["몽"] = {"몽생미셸"}, ["넬"] = {"넬슨"}, ["셸"] = {"셸락"}, ["꾼"] = {"꾼둑"},
        ["둑"] = {"둑슨"}, ["틀"] = {"틀라솔테오틀"}, ["낙"] = {"낙지저냐"}, ["냐"] = {"냐짱"},
        ["햇"] = {"햇수탉", "햇암탉"}, ["둘"] = {"둘암탉"}, ["숨"] = {"숨탉"},
        ["얼"] = {"얼럭만수탉"}, ["옌"] = {"옌볜"}, ["화"] = {"화뎬"},
        ["하"] = {"하이뎬", "하퓜", "하톄", "하픔", "하프늄"}, ["눈"] = {"눈엥엊", "눈솁", "눈쎂", "눈쎕"},
        ["엊"] = {"엊저냑"}, ["도"] = {"도쿄", "도렝", "도린꼍", "도렷"}, ["주"] = {"주쿄"},
        ["엔"] = {"엔쿄"}, ["묵"] = {"묵은지앝"}, ["두"] = {"두왑", "두듥", "두일뤠"},
        ["미"] = {"미왑", "미렷"}, ["속"] = {"속눈쎂"}, ["대"] = {"대뇸", "대대"},
        ["우"] = {"우뢔", "우라늄"}, ["보"] = {"보솦", "보살핌"}, ["떡"] = {"떡케잌"},
        ["꼬"] = {"꼬꾜", "꼬쟹"}, ["쪠"] = {"쪠꾜"}, ["뗴"] = {"뗴꾜"},
        ["야"] = {"야덟", "야릇"}, ["일"] = {"일고여덟", "일여덟"},
        ["여"] = {"여덟", "여린히읗", "여렄", "여렃"}, ["당"] = {"당구솣"},
        ["들"] = {"들꼍", "들썽", "들녘"}, ["댱"] = {"댱짗"}, ["부"] = {"부수짗"},
        ["할"] = {"할먄"}, ["본"] = {"본톔"}, ["산"] = {"산비릊", "산기슭"}, ["뻐"] = {"뻐릊"},
        ["빠"] = {"빠릊빠릊"}, ["버"] = {"버릊"}, ["거"] = {"거먕"}, ["셜"] = {"셜흔"},
        ["권"] = {"권쇡"}, ["늣"] = {"늣하르방"}, ["된"] = {"된히읗"}, ["양"] = {"양녬"},
        ["놈"] = {"놈삐썹"}, ["혈"] = {"혈관성머리아픔"}, ["뼈"] = {"뼈마디아픔"},
        ["재"] = {"재늄", "재윰"}, ["중"] = {"중첩모듈"}, ["링"] = {"링가야탸"},
        ["탸"] = {"탸례"}, ["석"] = {"석달그믐"},
        ["술"] = {"술포브로모프탈레인나트륨", "술베니실린나트륨"},
        ["예"] = {"예나랗", "예시뤠"}, ["져"] = {"져근덛"},
        ["개"] = {"개녘"}, ["강"] = {"강녘"}, ["갯"] = {"갯불녘"},
        ["고"] = {"고래구녘", "고븜", "고쯤", "고달픔"}, ["길"] = {"길녘"},
        ["겨"] = {"겨읅"}, ["비"] = {"비얨", "비엌", "비틂"},
        ["겹"] = {"겹사똔"}, ["까"] = {"까르똔"}, ["설"] = {"설똔"}, ["똔"] = {"똔레"},
        ["슉"] = {"슉달그믐"}, ["슂"] = {"슂달그믐"}, ["슫"] = {"슫달그믐"}, ["섣"] = {"섣달그믐"},
        ["귿"] = {"귿곻"}, ["님"] = {"님잫"}, ["섯"] = {"섯븐", "섯녘"},
        ["헝"] = {"헝겇"}, ["슬"] = {"슬픔", "슬괵"},
        ["허"] = {"허리아픔"}, ["치"] = {"치미는아픔"}, ["리"] = {"리넨"},
        ["샘"] = {"샘물곬"}, ["통"] = {"통곬"}, ["외"] = {"외곬"}, ["발"] = {"발가울넠"},
        ["괴"] = {"괴욤", "괴상야릇", "괴발디딤"}, ["볼"] = {"볼썽"},
        ["썽"] = {"썽끗썽끗", "썽끗뻥끗", "썽끗"},
        ["엿"] = {"엿지룸", "엿쇄", "엿틀", "엿궤"}, ["뚜"] = {"뚜렷"},
        ["또"] = {"또렷", "또렷또렷"}, ["덩"] = {"덩두렷"}, ["쓰"] = {"쓰렷쓰렷"},
        ["차"] = {"차렷", "차코늄"}, ["소"] = {"소곽", "소괵"}, ["건"] = {"건괵"},
        ["누"] = {"누괵"}, ["참"] = {"참괵"}, ["긔"] = {"긔츌"},
        ["남"] = {"남녘"}, ["동"] = {"동녘", "동틀녘"}, ["태"] = {"태껸"}, ["털"] = {"털갗"},
        ["듕"] = {"듕깃"}, ["웨"] = {"웨삼춘댁"}, ["물"] = {"물뤠"},
        ["요"] = {"요쯤"}, ["질"] = {"질쭘질쭘", "질산칼륨"}, ["뻘"] = {"뻘쭘"},
        ["신"] = {"신시튬"}, ["체"] = {"체체", "체육"}, ["육"] = {"육칠", "육체", "육군"},
        ["조"] = {"조개"}, ["액"] = {"액상형"}, ["역"] = {"역스윕", "역기"},
        ["룩"] = {"룩셈부르크"}, ["션"] = {"션샤인"}, ["뮴"] = {"오스뮴"}, ["듐"] = {"바나듐"},
        ["큠"] = {"프로큠"}, ["븀"] = {"이테르븀"}, ["해"] = {"해질녘"},
        ["릇"] = {"릇무"}, ["력"] = {"역기"}, ["감"] = {"감기약"}, ["깅"] = {"깅엄"},
        ["갱"] = {"갱도"}, ["샹"] = {"샹들리에"}, ["칼"] = {"칼슘"}, ["헬"] = {"헬륨"},
        ["포"] = {"포타슘", "포르메튬", "포스포늄"},
        ["슟"] = {"참숯"}, ["숯"] = {"참숯"}
    }

    local function SendChatMessage(msg)
        pcall(function()
            if TextChatService and TextChatService.TextChannels and TextChatService.TextChannels:FindFirstChild("RBXGeneral") then
                TextChatService.TextChannels.RBXGeneral:SendAsync(msg)
            else
                game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(msg, "All")
            end
        end)
    end

    AutoToggleBtn.MouseButton1Click:Connect(function()
        AutoWordBot = not AutoWordBot
        if AutoWordBot then
            AutoToggleBtn.Text = "🤖 채팅 자동 감지 봇 [ON]"
            AutoToggleBtn.TextColor3 = Color3.fromRGB(80, 255, 100)
            OutputLog.Text = "봇 활성화! 상대방 채팅 감지 중..."
        else
            AutoToggleBtn.Text = "🤖 채팅 자동 감지 봇 [OFF]"
            AutoToggleBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
            OutputLog.Text = "봇 정지됨."
        end
    end)

    pcall(function()
        if TextChatService and TextChatService.TextChannels then
            for _, channel in pairs(TextChatService.TextChannels:GetChildren()) do
                if channel:IsA("TextChannel") then
                    channel.MessageReceived:Connect(function(textMessage)
                        if not AutoWordBot then return end
                        local sender = textMessage.Source
                        if sender and sender ~= LocalPlayer then
                            local msg = textMessage.Text:gsub("[%s%p]", "")
                            if #msg > 0 then
                                local lastChar = ""
                                for p, c in utf8.graphemes(msg) do
                                    lastChar = msg:sub(p, p + c - 1)
                                end
                                
                                local searchChar = lastChar
                                if lastChar == "녀" then searchChar = "여"
                                elseif lastChar == "뇨" then searchChar = "요"
                                elseif lastChar == "뉴" then searchChar = "유"
                                elseif lastChar == "니" then searchChar = "이"
                                elseif lastChar == "랴" then searchChar = "야"
                                elseif lastChar == "려" then searchChar = "여"
                                elseif lastChar == "료" then searchChar = "요"
                                elseif lastChar == "류" then searchChar = "유"
                                elseif lastChar == "리" then searchChar = "이"
                                elseif lastChar == "라" then searchChar = "나"
                                elseif lastChar == "로" then searchChar = "노"
                                elseif lastChar == "뮴" then searchChar = "늄" 
                                elseif lastChar == "력" then searchChar = "역"
                                elseif lastChar == "린" then searchChar = "인"
                                elseif lastChar == "림" then searchChar = "임"
                                elseif lastChar == "레" then searchChar = "네"
                                elseif lastChar == "랄" then searchChar = "날"
                                elseif lastChar == "랑" then searchChar = "낭"
                                elseif lastChar == "란" then searchChar = "난"
                                elseif lastChar == "른" then searchChar = "은"
                                elseif lastChar == "름" then searchChar = "음"
                                end

                                local targetWordList = OneShotDict[searchChar] or OneShotDict[lastChar]
                                if targetWordList and #targetWordList > 0 then
                                    local targetWord = targetWordList[math.random(1, #targetWordList)]
                                    task.wait(0.15)
                                    SendChatMessage(targetWord)
                                    OutputLog.Text = "자동 방어 성공: " .. targetWord
                                    OutputLog.TextColor3 = Color3.fromRGB(50, 255, 100)
                                end
                            end
                        end
                    end)
                end
            end
        end
    end)

    local function OnType()
        local lastChar = InputBox.Text:sub(1, 3) 
        local searchChar = lastChar
        if lastChar == "녀" then searchChar = "여"
        elseif lastChar == "뇨" then searchChar = "요"
        elseif lastChar == "뉴" then searchChar = "유"
        elseif lastChar == "니" then searchChar = "이"
        elseif lastChar == "랴" then searchChar = "야"
        elseif lastChar == "려" then searchChar = "여"
        elseif lastChar == "료" then searchChar = "요"
        elseif lastChar == "류" then searchChar = "유"
        elseif lastChar == "리" then searchChar = "이"
        elseif lastChar == "라" then searchChar = "나"
        elseif lastChar == "로" then searchChar = "노"
        elseif lastChar == "뮴" then searchChar = "늄" 
        elseif lastChar == "력" then searchChar = "역"
        elseif lastChar == "린" then searchChar = "인"
        elseif lastChar == "림" then searchChar = "임"
        elseif lastChar == "레" then searchChar = "네"
        elseif lastChar == "랄" then searchChar = "날"
        elseif lastChar == "랑" then searchChar = "낭"
        elseif lastChar == "란" then searchChar = "난"
        elseif lastChar == "른" then searchChar = "은"
        elseif lastChar == "름" then searchChar = "음"
        end

        local targetWordList = OneShotDict[searchChar] or OneShotDict[lastChar]
        if targetWordList and #targetWordList > 0 then
            local targetWord = targetWordList[math.random(1, #targetWordList)]
            OutputLog.Text = "수동 발사: " .. targetWord
            OutputLog.TextColor3 = Color3.fromRGB(50, 255, 100)
            SendChatMessage(targetWord)
            InputBox.Text = ""
        else
            OutputLog.Text = "사전에 없는 시작 글자입니다: " .. InputBox.Text
            OutputLog.TextColor3 = Color3.fromRGB(255, 80, 80)
        end
    end

    SendBtn.MouseButton1Click:Connect(OnType)
    InputBox.FocusLost:Connect(function(enterPressed)
        if enterPressed and InputBox.Text ~= "" then OnType() end
    end)
    
    local dragging, dragStart, startPos
    WTitle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true; dragStart = input.Position; startPos = WCFrame.Position
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            WCFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = false end
    end)
end

--------------------------------------------------------------------
-- 🔪 3. 머더 미스터리 2 (MM2) 메인 로직
--------------------------------------------------------------------
local Config = {
    MurderAim = false, MurderHitbox = false, MurderKillAll = false, AutoShootBtn = false,
    ESP_Box = false, ESP_Name = false, ESP_Skeleton = false, ESP_GunDrop = false,
    Speed = false, Jump = false, Noclip = false, SkinChanger = false, TPGunButton = false
}

local function GetPlayerRole(player)
    if not player or not player.Character then return "Innocent", Color3.fromRGB(50, 255, 100) end
    local function isKnife(item) return item:IsA("Tool") and (item.Name:lower():find("knife") or item:FindFirstChild("KnifeServer")) end
    local function isGun(item) return item:IsA("Tool") and (item.Name:lower():find("gun") or item.Name:lower():find("revolver")) end

    for _, item in ipairs(player.Character:GetChildren()) do
        if isKnife(item) then return "Murderer", Color3.fromRGB(255, 50, 50) end
        if isGun(item) then return "Sheriff", Color3.fromRGB(50, 150, 255) end
    end
    if player:FindFirstChild("Backpack") then
        for _, item in ipairs(player.Backpack:GetChildren()) do
            if isKnife(item) then return "Murderer", Color3.fromRGB(255, 50, 50) end
            if isGun(item) then return "Sheriff", Color3.fromRGB(50, 150, 255) end
        end
    end
    return "Innocent", Color3.fromRGB(50, 255, 100)
end

local function GetMurderer()
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.Health > 0 then
            local pRole, _ = GetPlayerRole(p)
            if pRole == "Murderer" then
                return p
            end
        end
    end
    return nil
end

local function LoadMurderMystery()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "ValoStyle_Hub"
    screenGui.ResetOnSpawn = false
    screenGui.IgnoreGuiInset = true
    screenGui.DisplayOrder = 999999
    screenGui.Parent = UI_Parent

    local MainFrame = Instance.new("Frame", screenGui)
    MainFrame.Size = UDim2.new(0, 520, 0, 360)
    MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    MainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    MainFrame.BorderSizePixel = 0
    MainFrame.ClipsDescendants = true
    Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)
    
    local mStroke = Instance.new("UIStroke", MainFrame)
    mStroke.Color = Color3.fromRGB(255, 0, 0)
    mStroke.Thickness = 2.5

    local mGradient = Instance.new("UIGradient", MainFrame)
    mGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(15, 0, 0)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(150, 0, 0)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 0, 0))
    }
    mGradient.Rotation = -45

    RunService.RenderStepped:Connect(function()
        if mGradient then
            mGradient.Offset = Vector2.new(0, math.sin(tick() * 1.5) * 0.4)
        end
    end)

    local TopBar = Instance.new("Frame", MainFrame)
    TopBar.Size = UDim2.new(1, 0, 0, 30)
    TopBar.BackgroundColor3 = Color3.fromRGB(10, 0, 0)
    TopBar.BackgroundTransparency = 0.5
    TopBar.BorderSizePixel = 0

    local Title = Instance.new("TextLabel", TopBar)
    Title.Size = UDim2.new(1, -100, 1, 0)
    Title.Position = UDim2.new(0, 12, 0, 0)
    Title.BackgroundTransparency = 1
    Title.Text = "BLOOD // MURDER MYSTERY PRO"
    Title.TextColor3 = Color3.fromRGB(255, 100, 100)
    Title.Font = Enum.Font.GothamBlack
    Title.TextSize = 13
    Title.TextXAlignment = Enum.TextXAlignment.Left

    local CloseBtn = Instance.new("TextButton", TopBar)
    CloseBtn.Size = UDim2.new(0, 30, 1, 0)
    CloseBtn.Position = UDim2.new(1, -35, 0, 0)
    CloseBtn.BackgroundTransparency = 1
    CloseBtn.Text = "✕"
    CloseBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.TextSize = 14
    CloseBtn.MouseButton1Click:Connect(function() screenGui:Destroy() end)

    local MinBtn = Instance.new("TextButton", TopBar)
    MinBtn.Size = UDim2.new(0, 30, 1, 0)
    MinBtn.Position = UDim2.new(1, -65, 0, 0)
    MinBtn.BackgroundTransparency = 1
    MinBtn.Text = "—"
    MinBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
    MinBtn.Font = Enum.Font.GothamBold
    MinBtn.TextSize = 14

    local MinGui = Instance.new("ScreenGui")
    MinGui.Name = "ValoStyle_Min"
    MinGui.ResetOnSpawn = false
    MinGui.DisplayOrder = 999999
    MinGui.Parent = UI_Parent

    local MinIcon = Instance.new("TextButton", MinGui)
    MinIcon.Size = UDim2.new(0, 45, 0, 45)
    MinIcon.Position = UDim2.new(0, 20, 0, 20)
    MinIcon.BackgroundColor3 = Color3.fromRGB(15, 0, 0)
    MinIcon.Text = "B"
    MinIcon.TextColor3 = Color3.fromRGB(255, 50, 50)
    MinIcon.Font = Enum.Font.GothamBlack
    MinIcon.TextSize = 20
    MinIcon.Visible = false
    Instance.new("UICorner", MinIcon).CornerRadius = UDim.new(0, 8)
    Instance.new("UIStroke", MinIcon).Color = Color3.fromRGB(255, 0, 0)

    MinBtn.MouseButton1Click:Connect(function() MainFrame.Visible = false; MinIcon.Visible = true end)
    MinIcon.MouseButton1Click:Connect(function() MainFrame.Visible = true; MinIcon.Visible = false end)

    local dragging, dragStart, startPos
    TopBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true; dragStart = input.Position; startPos = MainFrame.Position
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = false end
    end)

    local Sidebar = Instance.new("Frame", MainFrame)
    Sidebar.Size = UDim2.new(0, 40, 1, -60)
    Sidebar.Position = UDim2.new(0, 0, 0, 30)
    Sidebar.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Sidebar.BackgroundTransparency = 0.6
    Sidebar.BorderSizePixel = 0
    local SidebarLayout = Instance.new("UIListLayout", Sidebar)
    SidebarLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    SidebarLayout.Padding = UDim.new(0, 8)
    Instance.new("UIPadding", Sidebar).PaddingTop = UDim.new(0, 12)

    local ContentArea = Instance.new("Frame", MainFrame)
    ContentArea.Size = UDim2.new(1, -40, 1, -60)
    ContentArea.Position = UDim2.new(0, 40, 0, 30)
    ContentArea.BackgroundTransparency = 1
    ContentArea.BorderSizePixel = 0

    local Tabs = {}
    local currentTab = nil

    local function CreateTab(iconText)
        local TabBtn = Instance.new("TextButton", Sidebar)
        TabBtn.Size = UDim2.new(0, 32, 0, 32)
        TabBtn.BackgroundTransparency = 1
        TabBtn.Text = iconText
        TabBtn.TextColor3 = Color3.fromRGB(150, 100, 100)
        TabBtn.Font = Enum.Font.GothamBold
        TabBtn.TextSize = 16

        local Indicator = Instance.new("Frame", TabBtn)
        Indicator.Size = UDim2.new(0, 3, 1, 0)
        Indicator.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        Indicator.Visible = false

        local TabContainer = Instance.new("Frame", ContentArea)
        TabContainer.Size = UDim2.new(1, 0, 1, 0)
        TabContainer.BackgroundTransparency = 1
        TabContainer.Visible = false

        local LeftCol = Instance.new("ScrollingFrame", TabContainer)
        LeftCol.Size = UDim2.new(0.5, -10, 1, -15)
        LeftCol.Position = UDim2.new(0, 10, 0, 10)
        LeftCol.BackgroundTransparency = 1
        LeftCol.ScrollBarThickness = 2
        local lLayout = Instance.new("UIListLayout", LeftCol)
        lLayout.Padding = UDim.new(0, 8)

        local RightCol = Instance.new("ScrollingFrame", TabContainer)
        RightCol.Size = UDim2.new(0.5, -10, 1, -15)
        RightCol.Position = UDim2.new(0.5, 5, 0, 10)
        RightCol.BackgroundTransparency = 1
        RightCol.ScrollBarThickness = 2
        local rLayout = Instance.new("UIListLayout", RightCol)
        rLayout.Padding = UDim.new(0, 8)

        TabBtn.MouseButton1Click:Connect(function()
            if currentTab then
                currentTab.Btn.TextColor3 = Color3.fromRGB(150, 100, 100)
                currentTab.Ind.Visible = false
                currentTab.Container.Visible = false
            end
            TabBtn.TextColor3 = Color3.fromRGB(255, 200, 200)
            Indicator.Visible = true
            TabContainer.Visible = true
            currentTab = {Btn = TabBtn, Ind = Indicator, Container = TabContainer}
        end)

        table.insert(Tabs, {Btn = TabBtn, Ind = Indicator, Container = TabContainer})
        return LeftCol, RightCol
    end

    local function AddHeader(parent, text)
        local lbl = Instance.new("TextLabel", parent)
        lbl.Size = UDim2.new(1, 0, 0, 24)
        lbl.BackgroundTransparency = 1
        lbl.Text = text
        lbl.TextColor3 = Color3.fromRGB(255, 120, 120)
        lbl.Font = Enum.Font.GothamBlack
        lbl.TextSize = 12
        lbl.TextXAlignment = Enum.TextXAlignment.Left
    end

    local function AddToggle(parent, text, callback)
        local state = false
        local btn = Instance.new("TextButton", parent)
        btn.Size = UDim2.new(1, 0, 0, 28)
        btn.BackgroundTransparency = 1
        btn.Text = ""

        local lbl = Instance.new("TextLabel", btn)
        lbl.Size = UDim2.new(0.75, 0, 1, 0)
        lbl.BackgroundTransparency = 1
        lbl.Text = " " .. text
        lbl.TextColor3 = Color3.fromRGB(220, 200, 200)
        lbl.Font = Enum.Font.GothamBold
        lbl.TextSize = 11
        lbl.TextXAlignment = Enum.TextXAlignment.Left

        local switch = Instance.new("Frame", btn)
        switch.Size = UDim2.new(0, 26, 0, 14)
        switch.Position = UDim2.new(1, -30, 0.5, -7)
        switch.BackgroundColor3 = Color3.fromRGB(30, 10, 10)
        Instance.new("UICorner", switch).CornerRadius = UDim.new(1, 0)
        Instance.new("UIStroke", switch).Color = Color3.fromRGB(100, 0, 0)
        
        local circle = Instance.new("Frame", switch)
        circle.Size = UDim2.new(0, 10, 0, 10)
        circle.Position = UDim2.new(0, 2, 0.5, -5)
        circle.BackgroundColor3 = Color3.fromRGB(150, 100, 100)
        Instance.new("UICorner", circle).CornerRadius = UDim.new(1, 0)

        btn.MouseButton1Click:Connect(function()
            state = not state
            switch.BackgroundColor3 = state and Color3.fromRGB(200, 0, 0) or Color3.fromRGB(30, 10, 10)
            circle.BackgroundColor3 = state and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(150, 100, 100)
            circle.Position = state and UDim2.new(1, -12, 0.5, -5) or UDim2.new(0, 2, 0.5, -5)
            if callback then callback(state) end
        end)
    end

    -- 🔥 UI 메뉴 버튼 추가
    local left1, right1 = CreateTab("🔪")
    AddHeader(left1, "God-Tier Murder Cheats")
    AddToggle(left1, "🎯 100% Aimlock (머더 락온 고정)", function(v) Config.MurderAim = v end)
    AddToggle(left1, "🟩 ㅈㄴ 큰 머더 히트박스 (벽뚫고 맞음)", function(v) Config.MurderHitbox = v end)
    AddToggle(left1, "💀 Kill All Bring (내 코앞으로 다 끌고옴)", function(v) Config.MurderKillAll = v end)
    AddToggle(left1, "🔫 Auto Shoot 버튼 생성", function(v) 
        Config.AutoShootBtn = v 
        if UI_Parent:FindFirstChild("AutoShootGui") then 
            UI_Parent.AutoShootGui.Enabled = v 
        end
    end)
    
    AddHeader(right1, "Gun Tools")
    AddToggle(right1, "🔲 Show TP Gun Button", function(v) 
        Config.TPGunButton = v 
        if UI_Parent:FindFirstChild("TeleportGunGui") then 
            UI_Parent.TeleportGunGui.Enabled = v 
        end
    end)

    local left2, right2 = CreateTab("👁")
    AddHeader(left2, "Player ESP")
    AddToggle(left2, "ESP Box", function(v) Config.ESP_Box = v end)
    AddToggle(left2, "ESP Name", function(v) Config.ESP_Name = v end)
    AddToggle(left2, "Exact Skeleton", function(v) Config.ESP_Skeleton = v end)
    
    AddHeader(left2, "Gun ESP")
    AddToggle(left2, "🟣 ESP Dropped Gun (보라색 표시)", function(v) Config.ESP_GunDrop = v end)

    local left3, right3 = CreateTab("🏃")
    AddHeader(left3, "Movement")
    AddToggle(left3, "Safe Speed Boost", function(v) Config.Speed = v end)
    AddToggle(left3, "Infinite Jump", function(v) Config.Jump = v end)
    AddToggle(left3, "Noclip (Walk Through Walls)", function(v) Config.Noclip = v end)

    -- 🔥 UI 토글 키 설정바
    local KeybindArea = Instance.new("Frame", MainFrame)
    KeybindArea.Size = UDim2.new(1, 0, 0, 30)
    KeybindArea.Position = UDim2.new(0, 0, 1, -30)
    KeybindArea.BackgroundColor3 = Color3.fromRGB(15, 0, 0)
    KeybindArea.BorderSizePixel = 0

    local ToggleKey = Enum.KeyCode.RightShift
    local isListeningForKey = false

    local KeybindBtn = Instance.new("TextButton", KeybindArea)
    KeybindBtn.Size = UDim2.new(1, -20, 0, 24)
    KeybindBtn.Position = UDim2.new(0, 10, 0, 3)
    KeybindBtn.BackgroundColor3 = Color3.fromRGB(30, 10, 10)
    KeybindBtn.Text = "⌨️ UI 켜기/끄기 단축키 설정: [" .. ToggleKey.Name .. "]"
    KeybindBtn.TextColor3 = Color3.fromRGB(200, 150, 150)
    KeybindBtn.Font = Enum.Font.GothamBold
    KeybindBtn.TextSize = 12
    Instance.new("UICorner", KeybindBtn).CornerRadius = UDim.new(0, 4)
    Instance.new("UIStroke", KeybindBtn).Color = Color3.fromRGB(100, 0, 0)

    KeybindBtn.MouseButton1Click:Connect(function()
        isListeningForKey = true
        KeybindBtn.Text = "⌨️ 변경할 키를 누르세요..."
        KeybindBtn.TextColor3 = Color3.fromRGB(255, 255, 100)
    end)

    UserInputService.InputBegan:Connect(function(input, gp)
        if isListeningForKey then
            if input.UserInputType == Enum.UserInputType.Keyboard then
                ToggleKey = input.KeyCode
                isListeningForKey = false
                KeybindBtn.Text = "⌨️ UI 켜기/끄기 단축키 설정: [" .. tostring(ToggleKey.Name) .. "]"
                KeybindBtn.TextColor3 = Color3.fromRGB(200, 150, 150)
            end
        else
            if not gp and input.UserInputType == Enum.UserInputType.Keyboard then
                if input.KeyCode == ToggleKey then
                    MainFrame.Visible = not MainFrame.Visible
                end
            end
        end
    end)

    Tabs[1].Btn.TextColor3 = Color3.fromRGB(255, 200, 200)
    Tabs[1].Ind.Visible = true
    Tabs[1].Container.Visible = true
    currentTab = Tabs[1]

    --------------------------------------------------------------------
    -- ⚙️ 기능 구현부
    --------------------------------------------------------------------
    local cachedGunPart = nil
    local function CheckPartForGun(v)
        if v.Name == "GunDrop" or (v:IsA("TouchTransmitter") and v.Parent and v.Parent.Name:lower():find("gun")) then
            cachedGunPart = v:IsA("TouchTransmitter") and v.Parent or v
            if cachedGunPart:IsA("Model") then
                cachedGunPart = cachedGunPart.PrimaryPart or cachedGunPart:FindFirstChildWhichIsA("BasePart") or cachedGunPart
            end
        end
    end

    for _, v in ipairs(workspace:GetDescendants()) do CheckPartForGun(v); if cachedGunPart then break end end
    workspace.DescendantAdded:Connect(function(v) CheckPartForGun(v) end)

    local function FindDroppedGun()
        if cachedGunPart and not cachedGunPart.Parent then cachedGunPart = nil end
        return cachedGunPart
    end

    -- 📌 총 텔포 버튼
    local tpButtonGui = Instance.new("ScreenGui", UI_Parent)
    tpButtonGui.Name = "TeleportGunGui"
    tpButtonGui.ResetOnSpawn = false
    tpButtonGui.Enabled = false

    local tpBtn = Instance.new("TextButton", tpButtonGui)
    tpBtn.Size = UDim2.new(0, 140, 0, 45)
    tpBtn.Position = UDim2.new(0, 20, 0.7, 0)
    tpBtn.BackgroundColor3 = Color3.fromRGB(30, 0, 0)
    tpBtn.Text = "🔫 총에 텔포하기"
    tpBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
    tpBtn.Font = Enum.Font.GothamBold
    tpBtn.TextSize = 13
    Instance.new("UICorner", tpBtn).CornerRadius = UDim.new(0, 8)
    Instance.new("UIStroke", tpBtn).Color = Color3.fromRGB(200, 0, 0)

    local tpDragging, tpDragInput, tpDragStart, tpStartPos
    tpBtn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            tpDragging = true; tpDragStart = input.Position; tpStartPos = tpBtn.Position
        end
    end)
    tpBtn.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then tpDragInput = input end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == tpDragInput and tpDragging then
            local delta = input.Position - tpDragStart
            tpBtn.Position = UDim2.new(tpStartPos.X.Scale, tpStartPos.X.Offset + delta.X, tpStartPos.Y.Scale, tpStartPos.Y.Offset + delta.Y)
        end
    end)

    tpBtn.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            tpDragging = false
            if (input.Position - tpDragStart).Magnitude < 10 then
                local gunPart = FindDroppedGun()
                if gunPart and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    local hrp = LocalPlayer.Character.HumanoidRootPart
                    local originalCFrame = hrp.CFrame
                    hrp.CFrame = gunPart:IsA("BasePart") and gunPart.CFrame or gunPart:GetPivot()
                    task.wait(0.25)
                    hrp.CFrame = originalCFrame
                else
                    tpBtn.Text = "❌ 총 없음!"
                    tpBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
                    task.wait(1)
                    tpBtn.Text = "🔫 총에 텔포하기"
                    tpBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
                end
            end
        end
    end)

    -- 📌 [요청하신 Auto Shoot 버튼 생성] (텔포 버튼 크기와 동일한 140x45 네모난 버튼)
    local autoShootGui = Instance.new("ScreenGui", UI_Parent)
    autoShootGui.Name = "AutoShootGui"
    autoShootGui.ResetOnSpawn = false
    autoShootGui.Enabled = false

    local autoShootBtn = Instance.new("TextButton", autoShootGui)
    autoShootBtn.Size = UDim2.new(0, 140, 0, 45)
    autoShootBtn.Position = UDim2.new(0, 170, 0.7, 0) -- 텔포 버튼 옆에 배치
    autoShootBtn.BackgroundColor3 = Color3.fromRGB(50, 0, 0)
    autoShootBtn.Text = "💥 AUTO SHOOT"
    autoShootBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
    autoShootBtn.Font = Enum.Font.GothamBold
    autoShootBtn.TextSize = 13
    Instance.new("UICorner", autoShootBtn).CornerRadius = UDim.new(0, 8)
    Instance.new("UIStroke", autoShootBtn).Color = Color3.fromRGB(255, 0, 0)

    -- Auto Shoot 버튼 드래그 이동 기능
    local asDragging, asDragInput, asDragStart, asStartPos
    autoShootBtn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            asDragging = true; asDragStart = input.Position; asStartPos = autoShootBtn.Position
        end
    end)
    autoShootBtn.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then asDragInput = input end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == asDragInput and asDragging then
            local delta = input.Position - asDragStart
            autoShootBtn.Position = UDim2.new(asStartPos.X.Scale, asStartPos.X.Offset + delta.X, asStartPos.Y.Scale, asStartPos.Y.Offset + delta.Y)
        end
    end)
    autoShootBtn.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            asDragging = false
            if (input.Position - asDragStart).Magnitude < 10 then
                -- 🔥 [핵심 기능] Auto Shoot 버튼을 누를 때 뚝딱 실행되는 총알 휘기 및 즉시 명중 로직
                local myChar = LocalPlayer.Character
                local myGun = myChar and (myChar:FindFirstChild("Gun") or myChar:FindFirstChild("Revolver"))
                
                if not myGun and LocalPlayer:FindFirstChild("Backpack") then
                    local bpGun = LocalPlayer.Backpack:FindFirstChild("Gun") or LocalPlayer.Backpack:FindFirstChild("Revolver")
                    if bpGun and myChar:FindFirstChildOfClass("Humanoid") then
                        myChar.Humanoid:EquipTool(bpGun)
                        myGun = bpGun
                    end
                end

                local murd = GetMurderer()
                if murd and murd.Character and murd.Character:FindFirstChild("HumanoidRootPart") and myGun then
                    local tHrp = murd.Character.HumanoidRootPart
                    -- 에임과 카메라를 머더에게 강제 고정 후 발사
                    Camera.CFrame = CFrame.lookAt(Camera.CFrame.Position, tHrp.Position)
                    tHrp.Size = Vector3.new(100, 100, 100) -- 히트박스 일시 확장
                    tHrp.Transparency = 0.7
                    tHrp.CanCollide = false
                    myGun:Activate()
                    if mouse1click then mouse1click() end
                else
                    autoShootBtn.Text = "❌ 총/머더 없음!"
                    task.wait(1)
                    autoShootBtn.Text = "💥 AUTO SHOOT"
                end
            end
        end
    end)

    local notifyGui = Instance.new("ScreenGui", UI_Parent)
    notifyGui.Name = "GunDropNotify"
    notifyGui.ResetOnSpawn = false
    
    local notifyLbl = Instance.new("TextLabel", notifyGui)
    notifyLbl.Size = UDim2.new(0, 340, 0, 40)
    notifyLbl.Position = UDim2.new(1, -360, 1, -80)
    notifyLbl.BackgroundColor3 = Color3.fromRGB(30, 0, 0)
    notifyLbl.TextColor3 = Color3.fromRGB(255, 80, 80)
    notifyLbl.Text = "🚨 보안관이 운지했습니다! 텔포 하여 총을 먹어주세요."
    notifyLbl.Font = Enum.Font.GothamBold
    notifyLbl.TextSize = 13
    notifyLbl.Visible = false
    Instance.new("UICorner", notifyLbl).CornerRadius = UDim.new(0, 6)
    Instance.new("UIStroke", notifyLbl).Color = Color3.fromRGB(255, 50, 50)

    local wasGunDropped = false

    -- 🔥 머더 에임락 & 히트박스 뻥튀기 로직
    RunService.RenderStepped:Connect(function()
        if Config.MurderAim or Config.MurderHitbox then
            local murd = GetMurderer()
            if murd and murd.Character and murd.Character:FindFirstChild("HumanoidRootPart") then
                local tHrp = murd.Character.HumanoidRootPart
                
                if Config.MurderHitbox then
                    tHrp.Size = Vector3.new(100, 100, 100)
                    tHrp.Transparency = 0.7
                    tHrp.CanCollide = false
                end

                if Config.MurderAim then
                    Camera.CFrame = CFrame.lookAt(Camera.CFrame.Position, tHrp.Position)
                end
            end
        else
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    local hrp = p.Character.HumanoidRootPart
                    if hrp.Size.X > 5 then
                        hrp.Size = Vector3.new(2, 2, 1)
                        hrp.Transparency = 1
                    end
                end
            end
        end
    end)

    -- 🔥 [Bring All] 생존자들을 내 앞 3스터드로 끌어오기
    RunService.Heartbeat:Connect(function()
        if Config.MurderKillAll and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local role, _ = GetPlayerRole(LocalPlayer)
            if role == "Murderer" then
                local myHrp = LocalPlayer.Character.HumanoidRootPart
                local myChar = LocalPlayer.Character
                local myKnife = myChar:FindFirstChild("Knife") or (LocalPlayer:FindFirstChild("Backpack") and LocalPlayer.Backpack:FindFirstChild("Knife"))
                
                if myKnife then
                    if myKnife.Parent ~= myChar and myChar:FindFirstChild("Humanoid") then
                        myChar.Humanoid:EquipTool(myKnife)
                    end
                    myKnife:Activate()
                    if mouse1click then mouse1click() end
                end

                for _, p in ipairs(Players:GetPlayers()) do
                    if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character.Humanoid.Health > 0 then
                        local pRole, _ = GetPlayerRole(p)
                        if pRole ~= "Murderer" then
                            p.Character.HumanoidRootPart.CFrame = myHrp.CFrame * CFrame.new(0, 0, -3)
                        end
                    end
                end
            end
        end
    end)

    local espFolder = Instance.new("Folder", screenGui)
    espFolder.Name = "Valo_ESP_Exact"
    local gunEspFolder = Instance.new("Folder", screenGui)
    gunEspFolder.Name = "GunEspFolder"

    local singleGunLabel = Instance.new("TextLabel", gunEspFolder)
    singleGunLabel.Size = UDim2.new(0, 110, 0, 20)
    singleGunLabel.BackgroundTransparency = 1
    singleGunLabel.Text = "🟣 [떨어진 총]"
    singleGunLabel.TextColor3 = Color3.fromRGB(180, 50, 255)
    singleGunLabel.Font = Enum.Font.GothamBold
    singleGunLabel.TextSize = 12
    singleGunLabel.Visible = false

    local function DrawLine(p1, p2, parent, color, thickness)
        local line = Instance.new("Frame", parent)
        line.BackgroundColor3 = color
        line.BorderSizePixel = 0
        line.AnchorPoint = Vector2.new(0.5, 0.5)
        local dist = (p2 - p1).Magnitude
        line.Size = UDim2.new(0, thickness, 0, dist)
        line.Position = UDim2.new(0, (p1.X + p2.X)/2, 0, (p1.Y + p2.Y)/2)
        line.Rotation = math.deg(math.atan2(p2.Y - p1.Y, p2.X - p1.X)) - 90
    end

    RunService.RenderStepped:Connect(function()
        espFolder:ClearAllChildren()
        
        local gunPart = FindDroppedGun()
        if gunPart and not wasGunDropped then
            wasGunDropped = true
            notifyLbl.Visible = true
            task.delay(6, function() notifyLbl.Visible = false end)
        elseif not gunPart then
            wasGunDropped = false
        end

        if Config.ESP_GunDrop and gunPart then
            local gunPos = gunPart:IsA("BasePart") and gunPart.Position or gunPart:GetPivot().Position
            local pos, onScreen = Camera:WorldToViewportPoint(gunPos)
            if onScreen then
                singleGunLabel.Position = UDim2.new(0, pos.X - 55, 0, pos.Y - 10)
                singleGunLabel.Visible = true
            else
                singleGunLabel.Visible = false
            end
        else
            singleGunLabel.Visible = false
        end

        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character.Humanoid.Health > 0 then
                local char = p.Character
                local hrp = char.HumanoidRootPart
                local head = char:FindFirstChild("Head")
                
                local hrpPos, onScreen = Camera:WorldToViewportPoint(hrp.Position)
                if onScreen then
                    local roleName, roleColor = GetPlayerRole(p)

                    if Config.ESP_Skeleton and head and char:FindFirstChild("Torso") then
                        local torso = char.Torso
                        local lArm = char:FindFirstChild("Left Arm")
                        local rArm = char:FindFirstChild("Right Arm")
                        local lLeg = char:FindFirstChild("Left Leg")
                        local rLeg = char:FindFirstChild("Right Leg")
                        
                        local tC = torso.CFrame
                        local neckW = Camera:WorldToViewportPoint((tC * CFrame.new(0, 1, 0)).Position)
                        local pelvisW = Camera:WorldToViewportPoint((tC * CFrame.new(0, -1, 0)).Position)
                        local lsW = Camera:WorldToViewportPoint((tC * CFrame.new(-1, 0.5, 0)).Position)
                        local rsW = Camera:WorldToViewportPoint((tC * CFrame.new(1, 0.5, 0)).Position)
                        local lhW = Camera:WorldToViewportPoint((tC * CFrame.new(-0.5, -1, 0)).Position)
                        local rhW = Camera:WorldToViewportPoint((tC * CFrame.new(0.5, -1, 0)).Position)
                        local headW = Camera:WorldToViewportPoint(head.Position)

                        DrawLine(Vector2.new(headW.X, headW.Y), Vector2.new(neckW.X, neckW.Y), espFolder, roleColor, 1)
                        DrawLine(Vector2.new(neckW.X, neckW.Y), Vector2.new(pelvisW.X, pelvisW.Y), espFolder, roleColor, 1)
                        DrawLine(Vector2.new(neckW.X, neckW.Y), Vector2.new(lsW.X, lsW.Y), espFolder, roleColor, 1)
                        DrawLine(Vector2.new(neckW.X, neckW.Y), Vector2.new(rsW.X, rsW.Y), espFolder, roleColor, 1)
                        DrawLine(Vector2.new(pelvisW.X, pelvisW.Y), Vector2.new(lhW.X, lhW.Y), espFolder, roleColor, 1)
                        DrawLine(Vector2.new(pelvisW.X, pelvisW.Y), Vector2.new(rhW.X, rhW.Y), espFolder, roleColor, 1)

                        if lArm then local laW = Camera:WorldToViewportPoint((lArm.CFrame * CFrame.new(0, -0.5, 0)).Position) DrawLine(Vector2.new(lsW.X, lsW.Y), Vector2.new(laW.X, laW.Y), espFolder, roleColor, 1) end
                        if rArm then local raW = Camera:WorldToViewportPoint((rArm.CFrame * CFrame.new(0, -0.5, 0)).Position) DrawLine(Vector2.new(rsW.X, rsW.Y), Vector2.new(raW.X, raW.Y), espFolder, roleColor, 1) end
                        if lLeg then local llW = Camera:WorldToViewportPoint((lLeg.CFrame * CFrame.new(0, -0.5, 0)).Position) DrawLine(Vector2.new(lhW.X, lhW.Y), Vector2.new(llW.X, llW.Y), espFolder, roleColor, 1) end
                        if rLeg then local rlW = Camera:WorldToViewportPoint((rLeg.CFrame * CFrame.new(0, -0.5, 0)).Position) DrawLine(Vector2.new(rhW.X, rhW.Y), Vector2.new(rlW.X, rlW.Y), espFolder, roleColor, 1) end
                    end

                    if Config.ESP_Box or Config.ESP_Name then
                        local rootPos = Camera:WorldToViewportPoint(hrp.Position - Vector3.new(0, 3, 0))
                        local headPos = Camera:WorldToViewportPoint(head.Position + Vector3.new(0, 0.5, 0))
                        local h = math.abs(headPos.Y - rootPos.Y)
                        if h < 3000 and h > 5 then
                            local w = h / 2
                            if Config.ESP_Box then
                                local box = Instance.new("Frame", espFolder)
                                box.Size = UDim2.new(0, w, 0, h)
                                box.Position = UDim2.new(0, hrpPos.X - w/2, 0, headPos.Y)
                                box.BackgroundTransparency = 1
                                local stroke = Instance.new("UIStroke", box)
                                stroke.Color = roleColor
                                stroke.Thickness = 1.2
                            end
                            if Config.ESP_Name then
                                local lbl = Instance.new("TextLabel", espFolder)
                                lbl.Size = UDim2.new(0, 120, 0, 15)
                                lbl.Position = UDim2.new(0, hrpPos.X - 60, 0, headPos.Y - 16)
                                lbl.BackgroundTransparency = 1
                                lbl.Text = p.Name .. " [" .. roleName .. "]"
                                lbl.TextColor3 = roleColor
                                lbl.Font = Enum.Font.GothamBold
                                lbl.TextSize = 10
                            end
                        end
                    end
                end
            end
        end
    end)

    RunService.Heartbeat:Connect(function()
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") and char:FindFirstChild("Humanoid") then
            if Config.Speed and char.Humanoid.MoveDirection.Magnitude > 0 then
                char.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame + (char.Humanoid.MoveDirection * 0.18)
            end
            if Config.Noclip then
                for _, v in pairs(char:GetDescendants()) do if v:IsA("BasePart") then v.CanCollide = false end end
            end
        end
    end)

    UserInputService.JumpRequest:Connect(function`()
        -- (syntax check fix)
    end)
end
