local utils = {}

local function isInsideRectangle(pointX, pointY, left, right, top, bottom)
    return left < pointX and pointX < right and top < pointY and pointY < bottom
end

return utils