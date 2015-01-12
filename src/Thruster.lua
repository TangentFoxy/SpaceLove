local class = require "lib.middleclass"

local Thruster = class('Thruster')

function Thruster:initialize(thrust, direction, thrusterX, thrusterY, thrusterColor, thrusterLength, fuelEfficiency)
	self.thrust = thrust or 0 and console.e("Thruster created with no thrust.")
	self.direction = direction or 0 and console.d("Thruster created with no direction.")

	self.thrusterX = thrusterX or nil and console.e("Thruster created with incomplete location.")
	self.thrusterY = thrusterY or nil and console.e("Thruster created with incomplete location.")
	self.thrusterColor = thrusterColor or {255, 255, 255} and console.d("Thruster created with no color.")
	self.thrusterLength = thrusterLength or 2 and console.d("Thruster created with no length.")

	self.fuelEfficiency = fuelEfficiency or 1 and console.d("Thruster created with no fuelEfficiency.")
end

function Thruster:draw(shipX, shipY, shipRotation)
	love.graphics.setColor(self.thrusterColor)
	love.graphics.setLineWidth(2)
	if self.direction == "forward" then
		love.graphics.line(shipX + self.thrusterX*math.cos(shipRotation) - self.thrusterY*math.sin(shipRotation),
			shipY + self.thrusterX*math.sin(shipRotation) + self.thrusterY*math.cos(shipRotation),
			shipX + self.thrusterX*math.cos(shipRotation) - (self.thrusterY+self.thrusterLength)*math.sin(shipRotation),
			shipY + self.thrusterX*math.sin(shipRotation) + (self.thrusterY+self.thrusterLength)*math.cos(shipRotation))
	elseif self.direction == "backward" then
		love.graphics.line(shipX + self.thrusterX*math.cos(shipRotation) - (self.thrusterY-self.thrusterLength)*math.sin(shipRotation),
			shipY + self.thrusterX*math.sin(shipRotation) + (self.thrusterY-self.thrusterLength)*math.cos(shipRotation),
			shipX + self.thrusterX*math.cos(shipRotation) - self.thrusterY*math.sin(shipRotation),
			shipY + self.thrusterX*math.sin(shipRotation) + self.thrusterY*math.cos(shipRotation))
	elseif self.direction == "left" then
		love.graphics.line(shipX + self.thrusterX*math.cos(shipRotation) - self.thrusterY*math.sin(shipRotation),
			shipY + self.thrusterX*math.sin(shipRotation) + self.thrusterY*math.cos(shipRotation),
			shipX + (self.thrusterX+self.thrusterLength)*math.cos(shipRotation) - self.thrusterY*math.sin(shipRotation),
			shipY + (self.thrusterX+self.thrusterLength)*math.sin(shipRotation) + self.thrusterY*math.cos(shipRotation))
	elseif self.direction == "right" then
		love.graphics.line(shipX + (self.thrusterX-self.thrusterLength)*math.cos(shipRotation) - self.thrusterY*math.sin(shipRotation),
			shipY + (self.thrusterX-self.thrusterLength)*math.sin(shipRotation) + self.thrusterY*math.cos(shipRotation),
			shipX + self.thrusterX*math.cos(shipRotation) - self.thrusterY*math.sin(shipRotation),
			shipY + self.thrusterX*math.sin(shipRotation) + self.thrusterY*math.cos(shipRotation))
	elseif self.direction == "rotateleft" then
		--note: same as "left"
		love.graphics.line(shipX + self.thrusterX*math.cos(shipRotation) - self.thrusterY*math.sin(shipRotation),
			shipY + self.thrusterX*math.sin(shipRotation) + self.thrusterY*math.cos(shipRotation),
			shipX + (self.thrusterX+self.thrusterLength)*math.cos(shipRotation) - self.thrusterY*math.sin(shipRotation),
			shipY + (self.thrusterX+self.thrusterLength)*math.sin(shipRotation) + self.thrusterY*math.cos(shipRotation))
	elseif self.direction == "rotateright" then
		--note: same as "left"
		love.graphics.line(shipX + self.thrusterX*math.cos(shipRotation) - self.thrusterY*math.sin(shipRotation),
			shipY + self.thrusterX*math.sin(shipRotation) + self.thrusterY*math.cos(shipRotation),
			shipX + (self.thrusterX+self.thrusterLength)*math.cos(shipRotation) - self.thrusterY*math.sin(shipRotation),
			shipY + (self.thrusterX+self.thrusterLength)*math.sin(shipRotation) + self.thrusterY*math.cos(shipRotation))
	else
		console.e("Thruster 'drawn' with invalid direction.")
	end
end

return Thruster
