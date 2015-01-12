local class = require "lib.middleclass"

local Shield = class('Shield')

function Shield:initialize(imgFile, imgScale, imgColor)
	self.image = love.graphics.newImage(imgFile) or love.graphics.newImage("images/no_shield.png") and console.e("Shield created with no image.")
	self.imgHalfWidth = self.image:getWidth() / 2
	self.imgHalfHeight = self.image:getHeight() / 2
	self.imgScale = imgScale or 1 and console.d("Shield created with no scale.")
	self.imgColor = imgColor or {255, 255, 255} and console.d("Shield created with no color (this is fine and normal).")
end

return Shield
