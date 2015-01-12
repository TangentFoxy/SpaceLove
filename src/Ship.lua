local class = require "lib.middleclass"

local Ship = class('Ship')

function Ship:initialize(Hull, Shield, Engine, Thrusters, Location)
	-- Location
	self.x = Location.x or 0 and console.d("Ship created with incomplete location.")
	self.y = Location.y or 0 and console.d("Ship created with incomplete location.")
	self.v = {
		x = Location.v.x or 0 and console.d("Ship created with incomplete location."),
		y = Location.v.y or 0 and console.d("Ship created with incomplete location.")
	}
	self.currentRotation = Location.currentRotation or 0 and console.d("Ship created with incomplete location.")
	self.rotationSpeed = Location.rotationSpeed or 0 and console.d("Ship created with incomplete location.")

	-- Hull
	self.Hull = Hull or console.e("Ship created with no Hull.")

	-- Shield
	self.Shield = Shield or nil and console.d("Ship created with no Shield.")

	-- Engine
	self.Engine = Engine or nil and console.e("Ship created with no Engine.")

	-- Thrusters
	self.Thrusters = Thrusters or {} and console.e("Ship created with no Thrusters.")
end

local directions = {
	forward = -math.pi/2,
	backward = math.pi/2,
	left = math.pi,
	right = 0
}

function Ship:accelerate(direction, dt)
	local thrust = Ship.static:fireThrusters(self, direction)
	if not thrust then return end -- if false, exit, out of fuel

	-- here is where we actually apply acceleration
	self.v.x = self.v.x + thrust * math.cos(self.currentRotation - (self.currentRotation % self.Engine.degreeLock) + directions[direction]) * dt
	self.v.y = self.v.y + thrust * math.sin(self.currentRotation - (self.currentRotation % self.Engine.degreeLock) + directions[direction]) * dt

	-- check if above maximum speed and fix if needed
	local magnitude = math.sqrt(self.v.x * self.v.x + self.v.y * self.v.y)
	if magnitude > self.Engine.maximumSpeed then
		-- do thrust backwards
		local reverseDirection = math.tan(self.v.y, self.v.x) + math.pi
		local reverseMagnitude = magnitude - self.Engine.maximumSpeed
		self.v.x = self.v.x + reverseMagnitude * math.cos(reverseDirection) * dt
		self.v.y = self.v.y + reverseMagnitude * math.sin(reverseDirection) * dt
	end
end

function Ship:rotate(direction, dt)
	local haveFuel = Ship.static:fireThrusters(self, direction)
	if direction == "rotateleft" and haveFuel then
		self.rotationSpeed = self.rotationSpeed - self.Engine.rotationImpulse * dt
	elseif direction == "rotateright" and haveFuel then
		self.rotationSpeed = self.rotationSpeed + self.Engine.rotationImpulse * dt
	end
end

-- Returns thrust generated or FALSE if ran out of fuel.
function Ship.static:fireThrusters(self, direction)
	-- get amount of thrust and fuel usage based on which Thrusters fire in direction
	local thrust, fuelUsage = 0, 0
	--if direction == "rotateleft" or direction == "rotateright" then
		--look in the Engine..why do we need to do that?
	--else
	for i=1,#self.Thrusters do
		if self.Thrusters[i].direction == direction then
			thrust = thrust + self.Thrusters[i].thrust
			fuelUsage = fuelUsage + self.Thrusters[i].thrust * self.Thrusters[i].fuelEfficiency / 600 --60 for framerate, and 1/10 a 'unit'
		end
	end

	-- use fuel, then check if out
	self.Hull.fuelAmount = self.Hull.fuelAmount - fuelUsage
	if self.Hull.fuelAmount < 0 then
		self.Hull.fuelAmount = 0
		console.d("Ran out of fuel!")
		return false
	end

	-- finally return thrust amount
	return thrust
end

return Ship
