rotation = 0
dont_mousemove = 0

old_loveupdate = love.update
function love.update( dt )
  old_loveupdate( dt )

  rotation = rotation + dt
end

old_lovedraw = love.draw
function love.draw()
  old_lovedraw()

  local mouse_x = love.mouse.getX()
  local mouse_y = love.mouse.getY()

  local sin = math.sin(rotation)
  local cos = math.cos(rotation)

  love.graphics.setLineWidth(4)

  love.graphics.setColor(1, 0, 0, 1)
  love.graphics.line(mouse_x, mouse_y, mouse_x + cos * 32, mouse_y - sin * 32)
  love.graphics.setColor(0, 1, 1, 1)
  love.graphics.line(mouse_x, mouse_y, mouse_x - sin * 32, mouse_y - cos * 32)

  -- love.graphics.print(mouse_x .. ", " .. mouse_y, 64, 64)
  -- love.graphics.print(mouse_vx .. ", " .. mouse_vy, 64, 96)
end

old_lovemousemoved = love.mousemoved
function love.mousemoved ( x, y, dx, dy, istouch )
  if dont_mousemove > 0 then
    dont_mousemove = dont_mousemove - 1
  else
    local sin = math.sin(rotation)
    local cos = math.cos(rotation)
    dont_mousemove = dont_mousemove + 1
    love.mouse.setPosition(
      x - dx + dx * cos + dy * sin,
      y - dy - dx * sin + dy * cos
    )
  
    if old_lovemousemoved ~= nil then
      old_lovemousemoved( x, y, dx, dy, istouch )
    end
  end
end
