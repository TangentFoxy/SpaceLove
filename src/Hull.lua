local class = require "lib.middleclass"

local Hull = class('Hull')

function Hull:initialize(imgFile, imgScale, imgColor)
	self.image = love.graphics.newImage(imgFile) or love.graphics.newImage("images/no_hull.png") and console.e("Hull created with no image.")
	self.imgHalfWidth = self.image:getWidth() / 2
	self.imgHalfHeight = self.image:getHeight() / 2
	self.imgScale = imgScale or 1 and console.d("Hull created with no scale.")
	self.imgColor = imgColor or {255, 255, 255} and console.d("Hull created with no color (this is fine and normal).")
end

return Hull
