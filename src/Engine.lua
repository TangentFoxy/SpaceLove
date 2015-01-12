local class = require "lib.middleclass"

local Engine = class('Engine')

-- have hull limit rotationImpulse? yeah probably (take damage if above Hull's rotationImpulseLimit, but do warn about this so people don't usually do it)
-- have a fuel effeciency multiplayer here
function Engine:initialize(maximumSpeed, spaceDrag, speedLowerLimit, degreeLock, rotationImpulse, rotationDrag, rotationLowerLimit, Thrusters)
	self.maximumSpeed = maximumSpeed or 0 and console.d("Engine created with no maximumSpeed.")
	self.spaceDrag = spaceDrag or 0 and console.d("Engine created with no spaceDrag.")
	self.speedLowerLimit = speedLowerLimit or 0 and console.d("Engine created with no speedLowerLimit.")
	self.degreeLock = degreeLock * math.pi / 180 or 0 and console.d("Engine created with no degreeLock.")
	self.rotationImpulse = rotationImpulse or 0 and console.e("Engine created with no rotationImpulse.")
	self.rotationDrag = rotationDrag or 0 and console.d("Engine created with no rotationDrag.")
	self.rotationLowerLimit = rotationLowerLimit or 0 and console.d("Engine created with no rotationLowerLimit.")

	self.Thrusters = Thrusters or {} and console.d("Engine created with no Thrusters.")
end

--[[
function Thruster:draw(shipX, shipY, shipRotation)
	love.graphics.setColor(self.thrusterColor)
	love.graphics.line(shipX + self.thrusterX*math.cos(shipRotation) - self.thrusterY*math.sin(shipRotation),
		shipY + self.thrusterX*math.sin(shipRotation) + self.thrusterY*math.cos(shipRotation),
		shipX + self.thrusterX*math.cos(shipRotation) - (self.thrusterY+self.thrusterLength)*math.sin(shipRotation),
		shipY + self.thrusterX*math.sin(shipRotation) + (self.thrusterY+self.thrusterLength)*math.cos(shipRotation))
end
]]

return Engine
