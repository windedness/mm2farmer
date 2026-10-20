local P=game:GetService("Players")local U=game:GetService("UserInputService")local TS=game:GetService("TweenService")local LP=P.LocalPlayer
local T={bg=Color3.fromRGB(22,22,24),panel=Color3.fromRGB(30,30,34),btn=Color3.fromRGB(38,38,44),hov=Color3.fromRGB(50,50,58),on=Color3.fromRGB(58,58,68),bd=Color3.fromRGB(50,50,58),tx=Color3.fromRGB(240,240,245),dim=Color3.fromRGB(140,140,150),ac=Color3.fromRGB(255,255,255),dg=Color3.fromRGB(210,65,65)}
local F,FB=Enum.Font.GothamMedium,Enum.Font.GothamBold
local SPD=25
local farm=false conn=nil mini=false pulse=nil
local C=LP.Character or LP.CharacterAdded:Wait()
local H=C:WaitForChild("HumanoidRootPart")
local Hu=C:WaitForChild("Humanoid")
local function cr(p,r)local c=Instance.new("UICorner")c.CornerRadius=UDim.new(0,r or 8)c.Parent=p return c end
local function st(p,c,t,tr)local s=Instance.new("UIStroke")s.Color=c or T.bd s.Thickness=t or 1 s.Transparency=tr or 0 s.Parent=p return s end
local g=Instance.new("ScreenGui")g.Name="DarkMenu"g.ResetOnSpawn=false g.Parent=LP:WaitForChild("PlayerGui")
local W,H1,B=260,42,100
local w=Instance.new("Frame")w.Size=UDim2.fromOffset(W,H1+B)w.Position=UDim2.new(.5,-W/2,.5,-80)w.BackgroundColor3=T.bg w.BorderSizePixel=0 w.Parent=g cr(w,12)st(w,T.bd,1)
local hd=Instance.new("Frame")hd.Size=UDim2.new(1,0,0,H1)hd.BackgroundColor3=T.panel hd.BorderSizePixel=0 hd.Parent=w cr(hd,12)
local hf=Instance.new("Frame")hf.Size=UDim2.new(1,0,0,12)hf.Position=UDim2.new(0,0,1,-12)hf.BackgroundColor3=T.panel hf.BorderSizePixel=0 hf.Parent=hd
local td=Instance.new("TextLabel")td.Size=UDim2.new(0,12,1,0)td.Position=UDim2.new(0,14,0,0)td.BackgroundTransparency=1 td.Text="•"td.TextColor3=T.ac td.Font=FB td.TextSize=20 td.TextXAlignment=Enum.TextXAlignment.Center td.Parent=hd
local ti=Instance.new("TextLabel")ti.Size=UDim2.new(.6,0,1,0)ti.Position=UDim2.new(0,28,0,0)ti.BackgroundTransparency=1 ti.Text="DARK MENU"ti.TextColor3=T.tx ti.Font=FB ti.TextSize=14 ti.TextXAlignment=Enum.TextXAlignment.Left ti.Parent=hd
local function hb(s,x)local b=Instance.new("TextButton")b.Size=UDim2.fromOffset(24,24)b.Position=UDim2.new(1,x,.5,-12)b.BackgroundColor3=T.btn b.Text=s b.TextColor3=T.dim b.Font=FB b.TextSize=15 b.AutoButtonColor=false b.Parent=hd cr(b,6)
b.MouseEnter:Connect(function()TS:Create(b,TweenInfo.new(.12),{BackgroundColor3=T.hov,TextColor3=T.tx}):Play()end)
b.MouseLeave:Connect(function()TS:Create(b,TweenInfo.new(.12),{BackgroundColor3=T.btn,TextColor3=T.dim}):Play()end)return b end
local mb=hb("−",-58)local cb=hb("×",-30)
cb.MouseEnter:Connect(function()TS:Create(cb,TweenInfo.new(.12),{BackgroundColor3=T.dg,TextColor3=T.tx}):Play()end)
cb.MouseLeave:Connect(function()TS:Create(cb,TweenInfo.new(.12),{BackgroundColor3=T.btn,TextColor3=T.dim}):Play()end)
local ct=Instance.new("Frame")ct.Size=UDim2.new(1,0,0,B)ct.Position=UDim2.new(0,0,0,H1)ct.BackgroundTransparency=1 ct.Parent=w
local pd=Instance.new("UIPadding")pd.PaddingTop=UDim.new(0,10)pd.PaddingBottom=UDim.new(0,10)pd.PaddingLeft=UDim.new(0,12)pd.PaddingRight=UDim.new(0,12)pd.Parent=ct
local sr=Instance.new("Frame")sr.Size=UDim2.new(1,0,0,20)sr.BackgroundTransparency=1 sr.Parent=ct
local sd=Instance.new("TextLabel")sd.Size=UDim2.new(0,14,1,0)sd.BackgroundTransparency=1 sd.Text="•"sd.TextColor3=T.dim sd.Font=FB sd.TextSize=16 sd.TextXAlignment=Enum.TextXAlignment.Center sd.Parent=sr
local sx=Instance.new("TextLabel")sx.Size=UDim2.new(1,-20,1,0)sx.Position=UDim2.new(0,18,0,0)sx.BackgroundTransparency=1 sx.Text="Готов к работе"sx.TextColor3=T.dim sx.Font=F sx.TextSize=12 sx.TextXAlignment=Enum.TextXAlignment.Left sx.Parent=sr
local ab=Instance.new("TextButton")ab.Size=UDim2.new(1,0,0,42)ab.Position=UDim2.new(0,0,0,28)ab.BackgroundColor3=T.btn ab.BorderSizePixel=0 ab.Text="ЗАПУСТИТЬ"ab.TextColor3=T.tx ab.Font=FB ab.TextSize=13 ab.AutoButtonColor=false ab.Parent=ct cr(ab,9)st(ab,T.bd,1,.5)
ab.MouseEnter:Connect(function()if not farm then TS:Create(ab,TweenInfo.new(.12),{BackgroundColor3=T.hov}):Play()end end)
ab.MouseLeave:Connect(function()if not farm then TS:Create(ab,TweenInfo.new(.12),{BackgroundColor3=T.btn}):Play()end end)
-- ==== ПОЛЁТ / ФАРМ ====
local function map()while true do for _,o in ipairs(workspace:GetChildren())do if o:GetAttribute("MapID")and o:FindFirstChild("CoinContainer")then return o end end task.wait()end end
local function near()local m=map()local b,bd=nil,math.huge for _,c in ipairs(m.CoinContainer:GetChildren())do local v=c:FindFirstChild("CoinVisual")if v and not v:GetAttribute("Collected")then local d=(H.Position-c.Position).Magnitude if d<bd then b,bd=c,d end end end return b end
local function tpp(hp)Hu:ChangeState(11)local d=(H.Position-hp.Position).Magnitude local t=TS:Create(H,TweenInfo.new(d/SPD,Enum.EasingStyle.Linear),{CFrame=hp.CFrame})t:Play()t.Completed:Wait()end
local function sFarm()if conn then return end conn=task.spawn(function()while farm do local t=near()if t and LP:GetAttribute("Alive")then tpp(t)local v=t:FindFirstChild("CoinVisual")while v and not v:GetAttribute("Collected")and v.Parent and farm do if not LP:GetAttribute("Alive")then break end local n=near()if n and n~=t then break end task.wait()end else task.wait(.5)end end end)end
local function eFarm()farm=false conn=nil if pulse then pulse:Disconnect()pulse=nil end end
-- ==== СТАТУС / ПУЛЬС ====
local function sStat(txt,c)sx.Text=txt sx.TextColor3=c sd.TextColor3=c end
local function sPulse()if pulse then return end pulse=task.spawn(function()while farm do TS:Create(ab,TweenInfo.new(.9,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut),{BackgroundColor3=T.hov}):Play()task.wait(.9)if not farm then break end TS:Create(ab,TweenInfo.new(.9,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut),{BackgroundColor3=T.on}):Play()task.wait(.9)end end)end
-- ==== ПЕРЕКЛЮЧАТЕЛЬ ====
local function tog()farm=not farm if farm then ab.Text="ОСТАНОВИТЬ"TS:Create(ab,TweenInfo.new(.15),{BackgroundColor3=T.on}):Play()sStat("Фарм активен",T.ac)sFarm()sPulse()else ab.Text="ЗАПУСТИТЬ"TS:Create(ab,TweenInfo.new(.15),{BackgroundColor3=T.btn}):Play()sStat("Остановлено",T.dim)eFarm()end end
ab.MouseButton1Click:Connect(tog)
-- ==== СВЕРНУТЬ / ЗАКРЫТЬ ====
mb.MouseButton1Click:Connect(function()mini=not mini ct.Visible=not mini mb.Text=mini and "+"or"−"ti.Text=mini and LP.Name or"DARK MENU"TS:Create(w,TweenInfo.new(.22,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Size=mini and UDim2.fromOffset(W,H1)or UDim2.fromOffset(W,H1+B)}):Play()end)
cb.MouseButton1Click:Connect(function()eFarm()TS:Create(w,TweenInfo.new(.2,Enum.EasingStyle.Quad,Enum.EasingDirection.In),{Size=UDim2.fromOffset(0,0)}):Play()task.wait(.2)g:Destroy()end)
-- ==== ПЕРЕТАСКИВАНИЕ ====
local dr,ds,ws=false,nil,nil
hd.InputBegan:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dr=true ds=i.Position ws=w.Position i.Changed:Connect(function()if i.UserInputState==Enum.UserInputState.End then dr=false end end)end end)
U.InputChanged:Connect(function(i)if dr and(i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch)then local d=i.Position-ds w.Position=UDim2.new(ws.X.Scale,ws.X.Offset+d.X,ws.Y.Scale,ws.Y.Offset+d.Y)end end)
-- ==== РЕСПАВН ====
LP.CharacterAdded:Connect(function(c)C=c H=c:WaitForChild("HumanoidRootPart")Hu=c:WaitForChild("Humanoid")end)
