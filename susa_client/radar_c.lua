local screenx, screeny = guiGetScreenSize()
local sW, sH =  (screenx/1280), (screeny/960)
local barHeight = 6*sH
local edge = 3*sW
local width = 320*sW
local height = 210*sH
local startwidth = 25.6*sW
local startheight = 720*sH
local blipsize = 16
local blipr, blipg, blipb
local totalsize = 1600
local theTarget
local t
local myRenderTarget1 = dxCreateRenderTarget( width, height, true )


local function getCameraRotation ()
    px, py, pz, lx, ly, lz = getCameraMatrix()
    local rotz = 6.2831853071796 - math.atan2 ( ( lx - px ), ( ly - py ) ) % 6.2831853071796
    local rotx = math.atan2 ( lz - pz, getDistanceBetweenPoints2D ( lx, ly, px, py ) )
    --Convert to degrees
    rotx = math.deg(rotx)
    rotz = math.deg(rotz)
    return rotz
end

function findRotation(x1,y1,x2,y2)

  local t = -math.deg(math.atan2(x2-x1,y2-y1))
  if t < 0 then t = t + 360 end;
  return t;

end

function getPointFromDistanceRotation(x, y, dist, angle)

    local a = math.rad(90 - angle);
    local dx = math.cos(a) * dist;
    local dy = math.sin(a) * dist;
    return x+dx, y+dy;

end


function drawRadar()
	--background
  local theTarget = getLocalPlayer()
  showPlayerHudComponent("radar",false)
	dxDrawRectangle ( startwidth, startheight, width, height, tocolor ( 52, 152, 219, 80 ) )
	dxDrawRectangle ( startwidth, startheight, width, edge, tocolor (255,255,255,180 ) )
	dxDrawRectangle ( startwidth, startheight, edge, height+barHeight+edge, tocolor (255,255,255,180 ) )
	dxDrawRectangle ( startwidth, startheight+height, width, edge, tocolor (255,255,255,180) )
	dxDrawRectangle ( startwidth+width-edge, startheight, edge, height+barHeight+edge, tocolor (255,255,255,180 ) )

	local rotation = getCameraRotation()


	local xp, yp, zp = getElementPosition(theTarget)
	widthmap = (totalsize/2)+((totalsize/2)/2998)*xp
	heightmap = (totalsize/2)-((totalsize/2)/2998)*yp

    dxSetRenderTarget( myRenderTarget1, true )
		dxDrawImage( -widthmap+(width/2), -heightmap+(height/2), totalsize, totalsize, "susa_data/map.png", rotation, ((totalsize/2)/2998)*xp, -((totalsize/2)/2998)*yp, tocolor ( 255, 255, 255, 255 ))
    dxSetRenderTarget()

    dxDrawImage ( startwidth+edge, startheight+edge, width-edge*2, height-edge, myRenderTarget1, 0, 0, 0, tocolor ( 255, 255, 255, 255 ), false )


    --players
	for i, p in ipairs(getElementsByType("player")) do
					local x, y, z = getElementPosition(p)

							local name = getPlayerName(p)
							local c1, c2 = string.find(name, '#%x%x%x%x%x%x')
							if c1 then
							blipr, blipg, blipb = getColorFromString(string.sub(name, c1, c2))
							else
								blipr = 255
								blipg = 255
								blipb = 255
							end

							local distance = getDistanceBetweenPoints2D(x, y, xp,yp)
							local rotation2 = findRotation(x,y,xp,yp)
							local xd, yd = getPointFromDistanceRotation(startwidth+(width/2), startheight+(height/2), distance/4, rotation2-rotation)

							if xd < startwidth+edge then
								xd = startwidth+edge
							elseif xd > startwidth+width-edge then
								xd = startwidth+width-edge
							end

							if yd < startheight+edge then
								yd = startheight+edge
							elseif yd > startheight+height then
								yd = startheight+height
							end

							dxDrawRectangle ( xd-4, yd-4, 8, 8, tocolor ( 0, 0, 0, 255 ) )
							dxDrawRectangle (xd-3, yd-3, 6, 6, tocolor (blipr, blipg, blipb, 255 ) )
	end
	if theTarget then

		local health = getElementHealth(theTarget)*10
		local armor = getPedArmor(theTarget)*10

		health = math.max(health - 250, 0)/750
		local p = -510*(health^2)
		local r,g = math.max(math.min(p + 255*health + 255, 255), 0), math.max(math.min(p + 765*health, 255), 0)
		local armor = math.max(armor - 250, 0)/750


		dxDrawRectangle ( startwidth, startheight+height+edge, width, barHeight+edge, tocolor (255,255,255,180 ))

		--health
		dxDrawRectangle(startwidth+edge, startheight+height+edge, width/2-edge*2+edge/2, barHeight, tocolor(r,g,0,0.5*255) )
		dxDrawRectangle(startwidth+edge, startheight+height+edge, health*(width/2-edge*2+edge/2), barHeight, tocolor(r,g,0,255) )

		--armor
		dxDrawRectangle(startwidth+width/2+edge/2, startheight+height+edge, width/2-edge*2+edge/2, barHeight, tocolor(0,150,220,0.5*255) )
		dxDrawRectangle(startwidth+width/2+edge/2, startheight+height+edge, armor*(width/2-edge*2+edge/2), barHeight, tocolor(0,50,255,255) )

	end
	local xr,yr,zr = getElementRotation(theTarget)
    dxDrawImage ( startwidth+(width/2)-blipsize/2, startheight+(height/2)-blipsize/2, blipsize, blipsize, "susa_data/blip.png", -zr+rotation, 0, 0, tocolor ( 255, 255, 255, 255 ), false )
	


end
addEventHandler("onClientRender", root, drawRadar)
