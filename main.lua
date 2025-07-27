local utils = require "utils"

local default_color = {0.05, 0.05, 0.1, 1}
local objects = {}
local grid_size = {x = 100,y = 100}
local grid_cell_size = {x = 0, y = 0}

local function grid_to_window_coords(x,y)
    local window_width, window_height = love.graphics.getDimensions()
    return math.floor(window_width / grid_size.x * x), math.floor(window_height / grid_size.y * y)
end

local function window_to_grid_coords(x,y)
    local window_width, window_height = love.graphics.getDimensions()
    return math.floor(x * grid_size.x / window_width), math.floor(y * grid_size.y / window_height)
end

local function get_object(x,y)
    for i=1, #objects do
        local selected_object = objects[i]
        if selected_object.x == x and selected_object.y == y then
            return selected_object, i
        end
    end
    return nil
end

local Sand = {x = 0, y = 0}

function Sand:tick()

    if (self.x ~= 0 or self.x ~= grid_size.x - 1) and get_object(self.x, self.y + 1) ~= nil and get_object(self.x + 1, self.y + 1) ~= nil and get_object(self.x - 1, self.y + 1) ~= nil then
        return
    end

    if self.x ~= 0 and get_object(self.x, self.y + 1) ~= nil and get_object(self.x - 1, self.y + 1) ~= nil then
        if self.x <= grid_size.x - 1 and self.x ~= grid_size.x - 1 then
            self.x = self.x + 1
        else
            self.x = grid_size.x - 1
        end

        return
    end

    if get_object(self.x, self.y + 1) ~= nil then
        if self.x >= 0 and self.x ~= 0 then
            self.x = self.x - 1
        else
            self.x = 0
        end

        return
    end

    if self.y >= grid_size.y - 1 then
        self.y = grid_size.y - 1
        return
    end
    self.y = self.y + 1
end

function Sand:new()
    local o = {}
    setmetatable(o, self)
    self.__index = self
    objects[#objects+1] = o
    return o
end

function love.load()
    love.window.setMode(600, 600, {resizable = true})
    love.graphics.setBackgroundColor(default_color)

    local window_width, window_height = love.graphics.getDimensions()
    grid_cell_size.x = window_width / grid_size.x
    grid_cell_size.y = window_height / grid_size.y

    print("loaded")
end

function love.mousepressed(x,y, button)
    local object = Sand:new()
    object.x, object.y = window_to_grid_coords(x,y)
    objects[#objects+1] = object
end

local time = 0
function love.update(dt)
    time = time + 1
    if time % 5 == 0 then
        -- for i=1,10 do
        --     local sand = Sand:new()
        --     sand.x = math.random(grid_size.y)
        --     sand.y = 3
        --     objects[#objects+1] = sand
        -- end

        for i=1, #objects do
            local selected_object = objects[i]
            
            selected_object:tick()
        end
    end
end

function love.draw()
    for i=1, #objects do
        local selected_object = objects[i]
        love.graphics.setColor({1,1,1,1})

        local x, y = grid_to_window_coords(selected_object.x, selected_object.y)
        love.graphics.rectangle("fill", x, y, grid_cell_size.x, grid_cell_size.y)
    end
end