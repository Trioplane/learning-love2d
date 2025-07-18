local utils = require "utils"

local defaultColor = {0.05, 0.05, 0.1, 1}
local player = {
    x = 0,
    y = 0,
    size = 20,
    velX = 0,
    velY = 0,
}
local mouseX, mouseY = 0, 0

function love.load()
    love.window.setMode(500, 500, {resizable = true})
    player.x = love.graphics.getWidth() / 2
    player.y = love.graphics.getHeight() / 2

    love.graphics.setBackgroundColor(defaultColor)

    love.graphics.circle("fill", player.x, player.y, player.size)

    print("loaded")
end

local direction = {0, 0, 0, 0}
function love.keypressed(key)
    if key == "w" then direction[1] = 1 end
    if key == "s" then direction[2] = 1 end
    if key == "a" then direction[3] = 1 end
    if key == "d" then direction[4] = 1 end
end

function love.keyreleased(key)
    if key == "w" then direction[1] = 0 end
    if key == "s" then direction[2] = 0 end
    if key == "a" then direction[3] = 0 end
    if key == "d" then direction[4] = 0 end
end

function love.update(dt)
    local dx = direction[4] - direction[3]
    local dy = direction[2] - direction[1]

    player.velX = (player.velX + dx * 20) * 0.95
    player.velY = (player.velY + dy * 20) * 0.95

    player.x = player.x + (player.velX * dt)
    player.y = player.y + (player.velY * dt)

    if player.x > love.graphics.getWidth() then player.x = 0 end
    if player.y > love.graphics.getHeight() then player.y = 0 end
    if player.x < 0 then player.x = love.graphics.getWidth() end
    if player.y < 0 then player.y = love.graphics.getHeight() end

    mouseX, mouseY = love.mouse.getPosition()
end

function love.draw()
    love.graphics.circle("fill", player.x, player.y, player.size)

    local dirVectorX = mouseX - player.x
    local dirVectorY = mouseY - player.y
    local theta = math.atan2(dirVectorY, dirVectorX)
    local dx = math.cos(theta)
    local dy = math.sin(theta)

    love.graphics.circle("fill", player.x, player.y, player.size)
    love.graphics.circle("fill", player.x + dx * 40, player.y + dy * 40, 10)
end
