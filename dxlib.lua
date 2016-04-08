dxElement = { }
dxElement_mt = { __index = dxElement }
local visibleElements = { }
local x,y = guiGetScreenSize()
local defaultDXSettings = {
  px = x/2,
  py = y/2,
  sx = x,
  sy = y,	
  text = "",
  color = {255,255,255,255},
  scale = 1,
  font = "default-bold",
  colorize = false,
  shadow = false,
  active = true,
  type = "text",
  renderTarget = false,
  list = { },
  selected = 0,
  offset = 0,
  tick = 0,
  main = 0,
  now = 0,
  togo = 0,
  bg = {0,0,0,255},
  selectionColor = {255,255,255,70},
  textBGColor = {255,255,255,220},
  borderColor = {255,255,255,255},
}

function dxElement:create(typ,text,tx,ty,sx,sy,color,scale,font,colorize,shadow,list,bg,selectionColor,textBGColor,borderColor)
  if not tonumber(x) or not tonumber(y) then
    outputDebugString("Bad position argument ("..tostring(x)..", "..tostring(y)..")",0,255,0,0)
    return false
  end
  local info = { }
  setmetatable(info,dxElement_mt)
  for i,v in pairs(defaultDXSettings) do
    info[i] = v
  end
  info.text = text or defaultDXSettings.text
  info.px = tx or defaultDXSettings.px
  info.py = ty or defaultDXSettings.py
  info.sx = sx or defaultDXSettings.sx
  info.sy = sy or defaultDXSettings.sy
  info.color = color or defaultDXSettings.color
  info.scale = scale or defaultDXSettings.scale
  info.font = font or defaultDXSettings.font
  info.colorize = colorize or defaultDXSettings.colorize
  info.shadow = shadow or defaultDXSettings.shadow
  info.active = true
  info.type = typ or defaultDXSettings.type
  info.hidden = false
  info.wordbreak = false
  info.bg = bg or defaultDXSettings.bg
  info.selectionColor = selectionColor or defaultDXSettings.selectionColor
  info.textBGColor = textBGColor or defaultDXSettings.textBGColor
  info.borderColor = borderColor or defaultDXSettings.borderColor
  if info.type == "gridlist" then
    info.renderTarget = dxCreateRenderTarget(info.sx,info.sy,true)
    if type(list) == "table" then
      info.list = list
    end
  elseif info.type == "edit" then
    info.list = { }
    for v in info.text:gmatch"." do 
      table.insert(info.list,v)
    end
  end
  visibleElements[info] = true
  return info

end

function dxElement:remove()
  visibleElements[self] = nil
  self.active = false
  if self.renderTarget then
    destroyElement(self.renderTarget)
    self.renderTarget = nil
  end
  setmetatable(self,self)
  --outputChatBox("REMOVED")
  return true
end

function dxElement:setVisibility(tp)
  if not (type(tp) == "boolean" or tp == nil) then return visibleElements[self] end
  visibleElements[self] = tp
end

function dxElement:setScale(num)
  if not tonumber(num) then return self.scale end
  self.scale = num
end

function dxElement:setPosition(px,py)
  if not tonumber(px) or not tonumber(py) then return {self.px,self.py} end
  self.px = px
  self.py = py
end

function dxElement:setSize(sx,sy)
  if not tonumber(sx) or not tonumber(sy) then return {self.sx,self.sy} end
  self.sx = sx
  self.sy = sy
end

function dxElement:setShadow(sh)
  if not sh then return self.shadow end
  self.shadow = sh
end

function dxElement:setFont(ft)
  if not ft then return self.font end
  self.font = ft
end

function dxElement:setColor(tbl)
  if not (type(tbl) == "table") then return self.color end
  self.color = tbl
end

function dxElement:setAlpha(num)
  if not tonumber(num) then return self.color[4] end
  self.color[4] = num
end

function dxElement:setBorderColor(tbl)
  if not (type(tbl) == "table") then return self.borderColor end
  self.borderColor = tbl
end

function dxElement:setBackgroundColor(tbl)
  if not (type(tbl) == "table") then return self.bg end
  self.bg = tbl
end

function dxElement:setFunction(func)
  if not (type(func) == "string") then return self.func end
  self.func = func
end

function dxElement:setSelectionColor(tbl)
  if not (type(tbl) == "table") then return self.selectionColor end
  self.selectionColor = tbl
end

function dxElement:setTextBGColor(tbl)
  if not (type(tbl) == "table") then return self.textBGColor end
  self.textBGColor = tbl
end

function dxElement:setTextBGColor(tbl)
  if not (type(tbl) == "table") then return self.textBGColor end
  self.textBGColor = tbl
end

function dxElement:setList(tbl)
  if not (type(tbl) == "table") then return self.list end
  if self.type == "gridlist" then
    self.selected = 0
  end
  self.list = tbl
end

function dxElement:setText(str)
  if not (type(str) == "string") then return self.text end
  self.text = str
end


function dxElement:setHidden(bool)
  if not (type(bool) == "boolean") then return self.hidden end
  self.hidden = bool
end

function dxElement:setWordbreak(bool)
  if not (type(bool) == "boolean") then return self.wordbreak end
  self.wordbreak = bool
end

function dxElement:setProgress(num)
  if not tonumber(num) then return self.progress end
  self.progress = num
end

local function renderElements()
  for dx,v in pairs(visibleElements) do
    while true do
      if not (dx.active == true) or not (v == true) then break end
      if dx.type == "text" then
	local colorless = string.gsub(dx.text,"#%x%x%x%x%x%x","")
	if dx.shadow == "shadow" then
	  dxDrawText(colorless,dx.px-1,dx.py-1,dx.sx,dx.sy,tocolor(0,0,0,dx.color[4]),dx.scale,dx.font,"left","top",false,dx.wordbreak,false,false)
	elseif dx.shadow == "border" or dx.shadow == "stroke" then
	  dxDrawText(colorless,dx.px-1,dx.py-1,dx.sx,dx.sy,tocolor(0,0,0,dx.color[4]),dx.scale,dx.font,"left","top",false,dx.wordbreak,false,false)
	  dxDrawText(colorless,dx.px-1,dx.py+1,dx.sx,dx.sy,tocolor(0,0,0,dx.color[4]),dx.scale,dx.font,"left","top",false,dx.wordbreak,false,false)
	  dxDrawText(colorless,dx.px+1,dx.py-1,dx.sx,dx.sy,tocolor(0,0,0,dx.color[4]),dx.scale,dx.font,"left","top",false,dx.wordbreak,false,false)
	  dxDrawText(colorless,dx.px+1,dx.py+1,dx.sx,dx.sy,tocolor(0,0,0,dx.color[4]),dx.scale,dx.font,"left","top",false,dx.wordbreak,false,false)
	end
	dxDrawText(dx.text,dx.px,dx.py,dx.sx,dx.sy,tocolor(unpack(dx.color)),dx.scale,dx.font,"left","top",false,dx.wordbreak,false,dx.colorize)
      elseif dx.type == "rectangle" then
	dxDrawRectangle(dx.px,dx.py,dx.sx*dx.scale,dx.sy*dx.scale,tocolor(unpack(dx.color)))
      elseif dx.type == "gridlist" then
	if not dx.renderTarget then break end
	local now = getTickCount()
	local endTime = dx.tick + 200
	local elapsedTime = now - dx.tick
	local duration = endTime - dx.tick
	local progress = elapsedTime / duration
	dx.now = interpolateBetween(dx.main,0,0,dx.togo,0,0,progress,"OutQuad")
	dxSetRenderTarget(dx.renderTarget)
	dxSetBlendMode("modulate_add")
	dxDrawRectangle(0,0,dx.sx,dx.sy,tocolor(unpack(dx.bg)))
	if dx.shadow == "border" then
	  drawBorder(dx.sx,dx.sy,2,tocolor(unpack(dx.borderColor)))
	end
	if dx.selected > 0 then
	  dxDrawRectangle(0,5+15*(dx.selected-1)+dx.now,dx.sx,15,tocolor(unpack(dx.selectionColor)))
	end
	for i,t in ipairs(dx.list) do
	  if 5+15*i+dx.now-dxGetFontHeight(1,dx.font) <= dx.sy and 5+15*i+dx.now >= 0 then
	    dxDrawText(t,5,5+15*(i-1)+dx.now,dx.sy,15,tocolor(unpack(dx.textBGColor)),1,dx.font,"left","top",false,false,false,dx.colorize)
	  end
	end
	dxSetBlendMode("blend")
	dxSetRenderTarget()
	dxDrawImage(dx.px,dx.py,dx.sx*dx.scale,dx.sy*dx.scale,dx.renderTarget,0,0,0,tocolor(unpack(dx.color)),true)
      elseif dx.type == "edit" then
	dxDrawRectangle(dx.px,dx.py,dx.sx*dx.scale,dx.sy*dx.scale,tocolor(dx.bg[1],dx.bg[2],dx.bg[3],dx.bg[4]/255*dx.color[4]))
	if dx.shadow == "border" then
	  drawBorder(dx.sx*dx.scale,dx.sy*dx.scale,2,tocolor(dx.borderColor[1],dx.borderColor[2],dx.borderColor[3],dx.borderColor[4]/255*dx.color[4]),{dx.px,dx.py})
	end
	local todraw = dx.text
	if dx.hidden == true then
	  local nletters = string.len(dx.text)
	  if nletters >= 1 then
	    local vals = { }
	    for q=1,nletters do
	      table.insert(vals,"*")
	    end
	    todraw = table.concat(vals,"")
	  end
	end
	local fheight = dxGetFontHeight(dx.scale*2/40*dx.sy/dx.scale,dx.font)
	dxDrawText(todraw,dx.px+dx.sx*0.03,dx.py+dx.sy/2-fheight/2,dx.px+dx.sx*dx.scale-dx.sx*dx.scale*0.03,dx.py+dx.sy*dx.scale,tocolor(unpack(dx.color)),dx.scale*2/40*dx.sy,dx.font,"left","top",true,false,false,false)
	if dx.selected == 1 then
	  local length = dxGetTextWidth(todraw,dx.scale*2/40*dx.sy,dx.font)
	  if not dx.tickval then
	    dx.tickval = getTickCount()
	  end
	  if dx.needlestate == nil then
	    dx.needlestate = true
	  end
	  local tick = getTickCount()
	  if tick-dx.tickval >= 1000 then
	    dx.tickval = getTickCount()
	    dx.needlestate = not dx.needlestate
	  end
	  if dx.needlestate == true then
	    dxDrawRectangle(dx.px+dx.sx*0.03+length+2,dx.py+dx.sy/2-fheight/2,1*dx.scale,fheight,tocolor(dx.selectionColor[1],dx.selectionColor[2],dx.selectionColor[3],dx.selectionColor[4]/255*dx.color[4]))
	  end
	end
      elseif dx.type == "image" then
	dxDrawImage(dx.px,dx.py,dx.sx*dx.scale,dx.sy*dx.scale,dx.text,0,0,0,tocolor(dx.bg[1],dx.bg[2],dx.bg[3],dx.bg[4]/255*dx.color[4]))
      elseif dx.type == "button" then
	if fileExists(dx.text) then
	  local str = dx.text:split(".")
	  local ntext = { }
	  for q,t in ipairs(str) do
	    if q == #str then
	      table.insert(ntext,"-hover.")
	    end
	    table.insert(ntext,t)
	  end
	  str = table.concat(ntext,"")
	  if isMouseOverElement(dx.px,dx.sx,dx.py,dx.sy) and fileExists(str) then
	    dxDrawImage(dx.px,dx.py,dx.sx*dx.scale,dx.sy*dx.scale,str,0,0,0,tocolor(dx.bg[1],dx.bg[2],dx.bg[3],dx.bg[4]/255*dx.color[4]))

	  else
	    dxDrawImage(dx.px,dx.py,dx.sx*dx.scale,dx.sy*dx.scale,dx.text,0,0,0,tocolor(dx.bg[1],dx.bg[2],dx.bg[3],dx.bg[4]/255*dx.color[4]))
	  end
	else
	  dxDrawRectangle(dx.px,dx.py,dx.sx*dx.scale,dx.sy*dx.scale,tocolor(dx.bg[1],dx.bg[2],dx.bg[3],dx.bg[4]/255*dx.color[4]))
	end
      elseif dx.type == "progressbar" then
	local progress = dx.progress or 0
	dxDrawRectangle(dx.px,dx.py,dx.sx*dx.scale,dx.sy*dx.scale,tocolor(dx.bg[1],dx.bg[2],dx.bg[3],dx.bg[4]/255*dx.color[4]))
	dxDrawRectangle(dx.px,dx.py,dx.sx*dx.scale*progress,dx.sy*dx.scale,tocolor(dx.color[1],dx.color[2],dx.color[3],dx.color[4]/255*dx.color[4]))
      end
      break
    end
  end
end
addEventHandler("onClientRender",getRootElement(),renderElements,true,"low")

function drawBorder(sx,sy,size,color,REL)
  local sposx,sposy = 0,0
  if type(REL) == "table" then
    sposx = REL[1]
    sposy = REL[2]
  end
  dxDrawRectangle(sposx+0,sposy+0,sx,size,color,true)
  dxDrawRectangle(sposx+0,sposy+0,size,sy,color,true)
  dxDrawRectangle(sposx+sx-size,sposy+0,size,sy,color,true)
  dxDrawRectangle(sposx+0,sposy+sy-size,sx,size,color,true)
end

function scrollTargets(side)
  if isCursorShowing() == false then
    return false
  end
  for dx,v in pairs(visibleElements) do
    while true do
      if not (dx.active == true) or not (v == true) then break end
      if side == "down" then
	if isMouseOverElement(dx.px,dx.sx*dx.scale,dx.py,dx.sy*dx.scale) then
	  dx.tick = getTickCount()
	  dx.main = dx.now
	  dx.togo = dx.togo - 45
	  if dx.togo < 0-(5+15*(#dx.list)-dx.sy) then
	    dx.togo = 0-(5+15*(#dx.list)-dx.sy)
	  end
	end
      elseif side == "up" then
	if isMouseOverElement(dx.px,dx.sx*dx.scale,dx.py,dx.sy*dx.scale) then
	  dx.tick = getTickCount()
	  dx.main = dx.now
	  dx.togo = dx.togo + 45
	  if dx.togo + 45 > 0 then
	    dx.togo = 0
	  end
	end
      end
      break
    end
  end
end
function scrollWithoutMouse(side)
  for dx,v in pairs(visibleElements) do
    while true do
      if not (dx.active == true) or not (v == true) then break end
      if side == "down" then
	if showingtab then
	  dx.tick = getTickCount()
	  dx.main = dx.now
	  dx.togo = dx.togo - 45
	  if dx.togo < 0-(5+15*(#dx.list)-dx.sy) then
	    dx.togo = 0-(5+15*(#dx.list)-dx.sy)
	  end
	end
      elseif side == "up" then
	if showingtab then
	  dx.tick = getTickCount()
	  dx.main = dx.now
	  dx.togo = dx.togo + 45
	  if dx.togo + 45 > 0 then
	    dx.togo = 0
	  end
	end
      end
      break
    end
  end
end


local function onClick(b,state,ax,ay)
  if not (state == "down") or not (b == "left") then
    return false
  end
  if isCursorShowing() == false then
    return false
  end
  for dx,v in pairs(visibleElements) do
    while true do
      if not (dx.active == true) or not (v == true) then break end
      if dx.type == "gridlist" then
	local isRange,cx,cy = isMouseOverElement(dx.px,dx.sx*dx.scale,dx.py,dx.sy*dx.scale)
	if isRange then
	  local cdloc = (cy-(dx.py)-dx.now+3)
	  local pos = math.round(cdloc/15/dx.scale)
	  local res = dx.list[pos]
	  if res then
	    outputDebugString(res)
	    if not (dx.selected == pos) then
	      triggerEvent("dxLib.onGridSelectionChange",getRootElement(),pos,res)
	    end
	    triggerEvent("dxLib.onGridSelect",getRootElement(),pos,res)
	    dx.selected = pos
	  end
	end
      elseif dx.type == "edit" then
	local isRange,cx,cy = isMouseOverElement(dx.px,dx.sx*dx.scale,dx.py,dx.sy*dx.scale)
	local slt = dx.selected
	if isRange then
	  dx.selected = 1
	  dx.tickval = getTickCount()
	  triggerEvent("dxLib.onEditSelect",getRootElement(),dx)
	else
	  if dx.selected == 1 then
	    triggerEvent("dxLib.onEditDeselect",getRootElement(),dx)
	  end
	  dx.selected = 0
	end
	if not (dx.selected == slt) then
	  local selected = (dx.selected == 1)
	  triggerEvent("dxLib.onEditSelectionChange",getRootElement(),dx,selected)
	end
      elseif dx.type == "button" then
	local isRange,cx,cy = isMouseOverElement(dx.px,dx.sx*dx.scale,dx.py,dx.sy*dx.scale)
	if isRange then
	  local func = dx.func
	  if func then
	    loadstring(func.."()")()
	  end
	end
      end
      break
    end
  end
end
addEventHandler("onClientClick",getRootElement(),onClick)

local fkeys = { "F1", "F2", "F3", "F4", "F5", "F6", "F7", "F8", "F9" }
local backTimer = false
function changeSearch(key,state)
  if isCursorShowing() == false then
    return false
  end
  for dx,v in pairs(visibleElements) do
    while true do
      if not (dx.selected == 1) or not (dx.type == "edit") then break end
      if not (dx.active == true) or not (v == true) then break end
      local isin = false
      local kz = { }
      key = key:gsub("num_","")
      for v in key:gmatch"." do 
	table.insert(kz,v)
      end
      if #kz >= 1 and #kz <= 2 and not fkeys[string.lower(kz[1])] then
	isin = true
      end
      if isin == false then break end
      table.insert(dx.list,key)
      dx.text = table.concat(dx.list,"")
      triggerEvent("dxLib.onEditChange",getRootElement(),dx.list,key)
      break
    end
  end
end
addEventHandler("onClientCharacter",getRootElement(),changeSearch)

function backTrigger(key,state,fast)
  if isCursorShowing() == false then
    return false
  end
  for dx,v in pairs(visibleElements) do
    while true do
      if not (dx.selected == 1) or not (dx.type == "edit") then break end
      if not (dx.active == true) or not (v == true) then break end
      if state == "up" then
	if isTimer(backTimer) then
	  killTimer(backTimer)
	end
      elseif state == "down" then
	table.remove(dx.list,#dx.list)
	dx.text = table.concat(dx.list,"")
	triggerEvent("dxLib.onEditChange",getRootElement(),dx.list,"rm")
	if isTimer(backTimer) then
	  killTimer(backTimer)
	end
	if fast == true then
	  backTimer = setTimer(backTrigger,50,1,"backspace","down",true)
	else
	  backTimer = setTimer(backTrigger,200,1,"backspace","down",true)
	end
      end
      break
    end
  end
end
bindKey("backspace","both",backTrigger)

local function scrollUp()
  scrollTargets("up")
end

local function scrollDown()
  scrollTargets("down")
end

bindKey("mouse_wheel_up","down",scrollUp)
bindKey("mouse_wheel_down","down",scrollDown)

function isMouseOverElement(psx,pssx,psy,pssy)
  if isCursorShowing() == false then
    return false
  end
  local cx,cy = getCursorPosition()
  cx,cy = cx*x,cy*y
  if cx >= psx and cx <= psx+pssx and cy >= psy and cy <= psy+pssy then
    return true,cx,cy
  else
    return false
  end
end

function math.round(num)
  local under = math.floor(num)
  local upper = math.floor(num) + 1
  local underV = 0-(under - num)
  local upperV = upper - num
  if (upperV > underV) then
    return under
  else
    return upper
  end
end

function string:split(separator)
  if separator == '.' then
    separator = '%.'
  end
  local result = {}
  for part in self:gmatch('(.-)' .. separator) do
    result[#result+1] = part
  end
  result[#result+1] = self:match('.*' .. separator .. '(.*)$') or self
  return result
end

function table.find(f, l) 
  for _, v in ipairs(l) do
    if f(v) then
      return v
    end
  end
  return nil
end