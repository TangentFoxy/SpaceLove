local class = require "lib.middleclass"

local Hat = class('Hat')

function Hat:initialize(imgFile, imgScale, offset, imgColor)
	-- image stuff
	self.image = love.graphics.newImage(imgFile) or love.graphics.newImage("images/no_hat.png") and console.e("Hat created with no image.")
	self.imgHalfWidth = self.image:getWidth() / 2
	self.imgHalfHeight = self.image:getHeight() / 2
	self.imgScale = imgScale or 1 and console.d("Hat created with no scale.")
	self.imgColor = imgColor or {255, 255, 255} and console.d("Hat created with no color (this is fine and normal).")

	self.offset = offset or 0 and console.d("Hat created with no offset.")
end

function Hat:draw(x, y)
	love.graphics.setColor(self.imgColor)
	love.graphics.draw(self.image, x + player.Ship.x, y + player.Ship.y + self.offset, 0, self.imgScale, self.imgScale, self.imgHalfWidth, self.imgHalfHeight)
end

return Hat
