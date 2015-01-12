local class = require "lib.middleclass"

local Engine = class('Engine')

function Engine:initialize(maximumSpeed, spaceDrag, speedLowerLimit, degreeLock, rotationImpulse, rotationDrag, rotationLowerLimit)
	self.maximumSpeed = maximumSpeed or 0 and console.d("Engine created with no maximumSpeed.")
	self.spaceDrag = spaceDrag or 0 and console.d("Engine created with no spaceDrag.")
	self.speedLowerLimit = speedLowerLimit or 0 and console.d("Engine created with no speedLowerLimit.")
	self.degreeLock = degreeLock * math.pi / 180 or 0 and console.d("Engine created with no degreeLock.")
	self.rotationImpulse = rotationImpulse or 0 and console.e("Engine created with no rotationImpulse.")
	self.rotationDrag = rotationDrag or 0 and console.d("Engine created with no rotationDrag.")
	self.rotationLowerLimit = rotationLowerLimit or 0 and console.d("Engine created with no rotationLowerLimit.")
end

return Engine
