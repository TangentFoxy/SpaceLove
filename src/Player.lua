local class = require "lib.middleclass"
local Ship = require "Ship"

local Player = class('Player')

function Player:initialize(Ship)
	-- Ship
	self.Ship = Ship or console.e("Player created with no Ship.")

	-- TEMPORARY VALUES TO KEEP EVERYTHING FROM BREAKING RIGHT NOW
	--Hull
	self.image = self.Ship.Hull.image
	self.imgHalfWidth = self.Ship.Hull.imgHalfWidth
	self.imgHalfHeight = self.Ship.Hull.imgHalfHeight
	self.imgScale = self.Ship.Hull.imgScale
	--Shield
	self.shieldhit = self.Ship.Shield.image
	self.shieldHalfWidth = self.Ship.Shield.imgHalfWidth
	self.shieldHalfHeight = self.Ship.Shield.imgHalfHeight
	self.shieldScale = self.Ship.Shield.imgScale
	--Engine
	self.maximumSpeed = self.Ship.Engine.maximumSpeed
	self.spaceDrag = self.Ship.Engine.spaceDrag
	self.speedLowerLimit = self.Ship.Engine.speedLowerLimit
	self.degreeLock = self.Ship.Engine.degreeLock
	self.rotationImpulse = self.Ship.Engine.rotationImpulse
	self.rotationDrag = self.Ship.Engine.rotationDrag
	self.rotationLowerLimit = self.Ship.Engine.rotationLowerLimit
	--Thrusters
	self.forwardThrust = 2600
	self.reverseThrust = 1300
	self.sideThrust = 800
	--Location
	self.x = self.Ship.x
	self.y = self.Ship.y
	self.v = {
		x = self.Ship.v.x,
		y = self.Ship.v.y
	}
	self.currentRotation = self.Ship.currentRotation
	self.rotationSpeed = self.Ship.rotationSpeed
end

return Player
