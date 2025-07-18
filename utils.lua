local utils = {}

local function isInsideRectangle(pointX, pointY, left, right, top, bottom)
    return left < pointX and pointX < right and top < pointY and pointY < bottom
end

local function lerp(a, b, t)
    return a + (b - a) * t
end

utils.isInsideRectangle = isInsideRectangle
utils.lerp = lerp

return utils