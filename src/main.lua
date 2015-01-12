--very very temporary
console = {
	e = function() end,
	d = function() end
}

-- Classes
local Player = require "Player"
local Ship = require "Ship"
local Hull = require "Hull"
local Shield = require "Shield"
local Engine = require "Engine"
local Thruster = require "Thruster"

local Debug = require "Debug"

-- GLOBALS
Render = {
	jitter = false,
	jitterLevel = 2,
	debugFont = love.graphics.newFont(10),
	hudFont = love.graphics.newFont("fonts/Audimat Mono Regular.ttf", 16),
}

player = Player(Ship(
	Hull("images/fighter1.png", 1.5, 16, 10000),
	Shield("images/shieldhit1.png", 1.6),
	Engine(40000, 0.95, 10, 7.5, 33, 0.93, 0.5),
	{
		Thruster(1300, "forward", -8.5, 16.5, {160, 250, 255}, 2.4, 0.7),
		Thruster(1300, "forward", 8.5, 16.5, {160, 250, 255}, 2.4, 0.7),
		Thruster(650, "backward", -13, 1.8, {200, 240, 255}, 1.8, 0.8),
		Thruster(650, "backward", 13, 1.8, {200, 240, 255}, 1.8, 0.8),
		Thruster(320, "left", 6, -4.4, {220, 230, 250}, 0.6, 1),
		Thruster(540, "left", 17.5, 5.5, {220, 230, 250}, 1.2, 0.9),
		Thruster(320, "right", -6, -4.4, {220, 230, 250}, 0.6, 1),
		Thruster(540, "right", -17.5, 5.5, {220, 230, 250}, 1.2, 0.9),
		Thruster(90, "rotateleft", 4.4, -16, {250, 200, 200}, 0.4, 1.1),
		Thruster(110, "rotateleft", -11, 14.3, {255, 230, 230}, 0.6, 1),
		Thruster(110, "rotateleft", 13, 11, {250, 200, 200}, 0.6, 1),
		Thruster(90, "rotateright", -4.8, -16, {250, 200, 200}, 0.4, 1.1),
		Thruster(110, "rotateright", 10.4, 14.3, {255, 230, 230}, 0.6, 1),
		Thruster(110, "rotateright", -13.6, 11, {250, 200, 200}, 0.6, 1),
	},
	{
		x = love.graphics.getWidth() / 2,
		y = love.graphics.getHeight() / 2,
		v = {
			x = 0,
			y = 0
		},
		currentRotation = 0,
		rotationSpeed = 0
	}
))

function love.update(dt)
	-- player rotation input
	if love.keyboard.isDown('q') or love.keyboard.isDown('a') then
		player.Ship:rotate("rotateleft", dt)
	elseif love.keyboard.isDown('e') or love.keyboard.isDown('d') then
		player.Ship:rotate("rotateright", dt)
	end

	-- player rotationSpeed adjustment
	player.Ship.rotationSpeed = player.Ship.rotationSpeed * player.Ship.Engine.rotationDrag
	if player.Ship.rotationSpeed < player.Ship.Engine.rotationLowerLimit and player.Ship.rotationSpeed > 0 then player.Ship.rotationSpeed = 0 end
	if player.Ship.rotationSpeed > -player.Ship.Engine.rotationLowerLimit and player.Ship.rotationSpeed < 0 then player.Ship.rotationSpeed = 0 end

	-- player currentRotation applied
	player.Ship.currentRotation = player.Ship.currentRotation + player.Ship.rotationSpeed * dt

	-- player movement input
	if love.keyboard.isDown('w') then
		player.Ship:accelerate("forward", dt)
	elseif love.keyboard.isDown('s') then
		player.Ship:accelerate("backward", dt)
	end
	if love.keyboard.isDown('j') then
		player.Ship:accelerate("left", dt)
	elseif love.keyboard.isDown('l') then
		player.Ship:accelerate("right", dt)
	end

	-- player current speed adjustment
	player.Ship.v.x = player.Ship.v.x * player.Ship.Engine.spaceDrag
	player.Ship.v.y = player.Ship.v.y * player.Ship.Engine.spaceDrag
	local speed = math.sqrt(player.Ship.v.x * player.Ship.v.x + player.Ship.v.y * player.Ship.v.y)
	--player.accelerate(math.tan(player.v.y, player.v.x) + math.pi, speed * player.spaceDrag, dt)
	--[[
	if player.v.x < player.speedLowerLimit and player.v.x > 0 then player.v.x = 0 end
	if player.v.x > -player.speedLowerLimit and player.v.x < 0 then player.v.x = 0 end
	if player.v.y < player.speedLowerLimit and player.v.y > 0 then player.v.y = 0 end
	if player.v.y > -player.speedLowerLimit and player.v.y < 0 then player.v.y = 0 end
	--]]
	if speed < player.Ship.Engine.speedLowerLimit then
		--player.accelerate(math.tan(player.v.y, player.v.x) + math.pi, speed, dt)
		player.Ship.v.x = 0
		player.Ship.v.y = 0
	end

	-- player current speed applied
	player.Ship.x = player.Ship.x + player.Ship.v.x * dt
	player.Ship.y = player.Ship.y + player.Ship.v.y * dt

	-- emergency exit
	if love.keyboard.isDown('escape') then love.event.quit() end
end

function love.draw()
	-- Debug below!
	Debug:drawBelow()

	-- Ship draw
	love.graphics.setColor(255, 255, 255)
	if Render.jitter then
		love.graphics.draw(player.Ship.Hull.image, player.Ship.x - (player.Ship.x % Render.jitterLevel), player.Ship.y - (player.Ship.y % Render.jitterLevel), player.Ship.currentRotation - (player.Ship.currentRotation % player.Ship.Engine.degreeLock), player.Ship.Hull.imgScale, player.Ship.Hull.imgScale, player.Ship.Hull.imgHalfWidth, player.Ship.Hull.imgHalfHeight)
	else
		love.graphics.draw(player.Ship.Hull.image, player.Ship.x, player.Ship.y, player.Ship.currentRotation - (player.Ship.currentRotation % player.Ship.Engine.degreeLock), player.Ship.Hull.imgScale, player.Ship.Hull.imgScale, player.Ship.Hull.imgHalfWidth, player.Ship.Hull.imgHalfHeight)
	end

	-- Shield draw
	-- below is not correct, update for new system, should look like ship draw except Shield instead of Hull
	--love.graphics.draw(player.shieldhit, player.x - player.shieldHalfWidth, player.y - player.shieldHalfHeight, player.currentRotation - (player.currentRotation % player.degreeLock), player.shieldScale, player.shieldScale, player.shieldHalfWidth, player.shieldHalfHeight)

	-- Thruster draws
	if love.keyboard.isDown('w') and player.Ship.Hull.fuelAmount > 0 then
		for i=1,#player.Ship.Thrusters do
			if player.Ship.Thrusters[i].direction == "forward" then
				player.Ship.Thrusters[i]:draw(player.Ship.x, player.Ship.y, player.Ship.currentRotation - (player.Ship.currentRotation % player.Ship.Engine.degreeLock))
			end
		end
	elseif love.keyboard.isDown('s') and player.Ship.Hull.fuelAmount > 0 then
		for i=1,#player.Ship.Thrusters do
			if player.Ship.Thrusters[i].direction == "backward" then
				player.Ship.Thrusters[i]:draw(player.Ship.x, player.Ship.y, player.Ship.currentRotation - (player.Ship.currentRotation % player.Ship.Engine.degreeLock))
			end
		end
	end
	if love.keyboard.isDown('j') and player.Ship.Hull.fuelAmount > 0 then
		for i=1,#player.Ship.Thrusters do
			if player.Ship.Thrusters[i].direction == "left" then
				player.Ship.Thrusters[i]:draw(player.Ship.x, player.Ship.y, player.Ship.currentRotation - (player.Ship.currentRotation % player.Ship.Engine.degreeLock))
			end
		end
	elseif love.keyboard.isDown('l') and player.Ship.Hull.fuelAmount > 0 then
		for i=1,#player.Ship.Thrusters do
			if player.Ship.Thrusters[i].direction == "right" then
				player.Ship.Thrusters[i]:draw(player.Ship.x, player.Ship.y, player.Ship.currentRotation - (player.Ship.currentRotation % player.Ship.Engine.degreeLock))
			end
		end
	end
	if love.keyboard.isDown('q') and player.Ship.Hull.fuelAmount > 0 or love.keyboard.isDown('a') and player.Ship.Hull.fuelAmount > 0 then
		for i=1,#player.Ship.Thrusters do
			if player.Ship.Thrusters[i].direction == "rotateleft" then
				player.Ship.Thrusters[i]:draw(player.Ship.x, player.Ship.y, player.Ship.currentRotation - (player.Ship.currentRotation % player.Ship.Engine.degreeLock))
			end
		end
	elseif love.keyboard.isDown('e') and player.Ship.Hull.fuelAmount > 0 or love.keyboard.isDown('d') and player.Ship.Hull.fuelAmount > 0 then
		for i=1,#player.Ship.Thrusters do
			if player.Ship.Thrusters[i].direction == "rotateright" then
				player.Ship.Thrusters[i]:draw(player.Ship.x, player.Ship.y, player.Ship.currentRotation - (player.Ship.currentRotation % player.Ship.Engine.degreeLock))
			end
		end
	end

	-- Fuel UI draw
	love.graphics.setColor(175, 255, 255)
	love.graphics.setFont(Render.hudFont)
	love.graphics.print("FUEL", 3, love.graphics.getHeight() - 30)
	love.graphics.setLineWidth(2)
	love.graphics.rectangle("line", 3, love.graphics.getHeight() - 13, 125, 10)
	love.graphics.setColor(175, 255, 25) --change to be based on fuel amount
	love.graphics.rectangle("fill", 4, love.graphics.getHeight() - 12, player.Ship.Hull.fuelAmount / player.Ship.Hull.fuelCapacity * 123, 8) --max width is 123

	-- Debug above!
	Debug:drawAbove()
end
