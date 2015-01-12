local class = require "lib.middleclass"

local Hull = class('Hull')

function Hull:initialize(imgFile, imgScale, hitRadius, fuelCapacity, imgColor)
	-- image stuff
	self.image = love.graphics.newImage(imgFile) or love.graphics.newImage("images/no_hull.png") and console.e("Hull created with no image.")
	self.imgHalfWidth = self.image:getWidth() / 2
	self.imgHalfHeight = self.image:getHeight() / 2
	self.imgScale = imgScale or 1 and console.d("Hull created with no scale.")
	self.imgColor = imgColor or {255, 255, 255} and console.d("Hull created with no color (this is fine and normal).")

	-- physics stuff
	self.hitRadius = hitRadius or self.image:getWidth() * 0.9 and console.d("Hull created with no hitRadius.") --defaults to 90% imgWidth
	self.fuelCapacity = fuelCapacity or 1000 and console.d("Hull created with no fuelCapacity.")
	self.fuelAmount = fuelCapacity or 1000
end

return Hull
