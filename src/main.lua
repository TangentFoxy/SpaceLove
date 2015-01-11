local Player = {
	image = nil,
	shieldhit = nil,
	imgHalfWidth = nil,
	imgHalfHeight = nil,
	x = nil,
	y = nil,
	v = {
		x = nil, y = nil,
	},
	currentRotation = nil,
	rotationSpeed = nil,
	rotationImpulse = nil,
	rotationDrag = nil,
	rotationLowerLimit = nil,
	degreeLock = nil,
	forwardThrust = nil,
	reverseThrust = nil,
	sideThrust = nil,
	maximumSpeed = nil,
	accelerate = nil,
}

function Player.accelerate(direction, amount, dt)
	-- apply acceleration
	Player.v.x = Player.v.x + amount * math.cos(direction) * dt
	Player.v.y = Player.v.y + amount * math.sin(direction) * dt

	-- check if above maximum speed
	local magnitude = math.sqrt(Player.v.x * Player.v.x + Player.v.y * Player.v.y)
	if magnitude > Player.maximumSpeed then
		Player.accelerate(math.tan(Player.v.y, Player.v.x) + math.pi, magnitude - Player.maximumSpeed, dt)
	end
end

function love.load()
	--position and speed
	Player.x = love.graphics.getWidth() / 2
	Player.y = love.graphics.getHeight() / 2
	Player.v.x = 0
	Player.v.y = 0
	Player.currentRotation = 0
	Player.rotationSpeed = 0

	--image
	Player.image = love.graphics.newImage("images/fighter1.png")
	Player.imgHalfWidth = Player.image:getWidth() / 2
	Player.imgHalfHeight = Player.image:getHeight() / 2
	Player.imgScale = 1.5
	--shieldhit image
	Player.shieldhit = love.graphics.newImage("images/shieldhit1.png")
	Player.shieldHalfWidth = Player.shieldhit:getWidth() / 2
	Player.shieldHalfHeight = Player.shieldhit:getHeight() / 2
	Player.shieldScale = 1.6

	--engine
	Player.forwardThrust = 2600
	Player.reverseThrust = 1300
	Player.sideThrust = 800
	Player.spaceDrag = 0.95
	Player.speedLowerLimit = 20
	Player.maximumSpeed = 40000

	--maneuverability
	Player.rotationImpulse = 33
	Player.rotationDrag = 0.93
	Player.rotationLowerLimit = 0.5
	Player.degreeLock = 7.5 * math.pi / 180

	--font!
	love.graphics.setNewFont("fonts/Audimat Mono Regular.ttf", 16)

	--line width!
	love.graphics.setLineWidth(2)
end

function love.update(dt)
	-- Player rotation input
	if love.keyboard.isDown('q') or love.keyboard.isDown('a') then
		Player.rotationSpeed = Player.rotationSpeed - Player.rotationImpulse * dt
	elseif love.keyboard.isDown('e') or love.keyboard.isDown('d') then
		Player.rotationSpeed = Player.rotationSpeed + Player.rotationImpulse * dt
	end

	-- Player rotationSpeed adjustment
	Player.rotationSpeed = Player.rotationSpeed * Player.rotationDrag
	if Player.rotationSpeed < Player.rotationLowerLimit and Player.rotationSpeed > 0 then Player.rotationSpeed = 0 end
	if Player.rotationSpeed > -Player.rotationLowerLimit and Player.rotationSpeed < 0 then Player.rotationSpeed = 0 end

	-- Player currentRotation applied
	Player.currentRotation = Player.currentRotation + Player.rotationSpeed * dt

	-- Player movement input
	if love.keyboard.isDown('w') then
		--Player.accelerate(Player.currentRotation - (Player.currentRotation % Player.degreeLock) - math.pi/2, Player.forwardThrust, dt)
	elseif love.keyboard.isDown('s') then
		Player.accelerate(Player.currentRotation - (Player.currentRotation % Player.degreeLock) + math.pi/2, Player.reverseThrust, dt)
	end
	if love.keyboard.isDown('j') then
		Player.accelerate(Player.currentRotation - (Player.currentRotation % Player.degreeLock) - math.pi, Player.sideThrust, dt)
	elseif love.keyboard.isDown('l') then
		Player.accelerate(Player.currentRotation - (Player.currentRotation % Player.degreeLock), Player.sideThrust, dt)
	end

	-- Player current speed adjustment
	Player.v.x = Player.v.x * Player.spaceDrag
	Player.v.y = Player.v.y * Player.spaceDrag
	local speed = math.sqrt(Player.v.x * Player.v.x + Player.v.y * Player.v.y)
	--Player.accelerate(math.tan(Player.v.y, Player.v.x) + math.pi, speed * Player.spaceDrag, dt)
	--[[
	if Player.v.x < Player.speedLowerLimit and Player.v.x > 0 then Player.v.x = 0 end
	if Player.v.x > -Player.speedLowerLimit and Player.v.x < 0 then Player.v.x = 0 end
	if Player.v.y < Player.speedLowerLimit and Player.v.y > 0 then Player.v.y = 0 end
	if Player.v.y > -Player.speedLowerLimit and Player.v.y < 0 then Player.v.y = 0 end
	--]]
	if speed < Player.speedLowerLimit then
		Player.accelerate(math.tan(Player.v.y, Player.v.x) + math.pi, speed, dt)
	end

	-- Player current speed applied
	Player.x = Player.x + Player.v.x * dt
	Player.y = Player.y + Player.v.y * dt

	-- emergency exit
	if love.keyboard.isDown('escape') then love.event.quit() end
end

function love.draw()
	-- Ship draw
	love.graphics.setColor(255, 255, 255)
	love.graphics.draw(Player.image, Player.x - Player.imgHalfWidth, Player.y - Player.imgHalfHeight, Player.currentRotation - (Player.currentRotation % Player.degreeLock), Player.imgScale, Player.imgScale, Player.imgHalfWidth, Player.imgHalfHeight)

	-- Shield draw
	--love.graphics.draw(Player.shieldhit, Player.x - Player.shieldHalfWidth, Player.y - Player.shieldHalfHeight, Player.currentRotation - (Player.currentRotation % Player.degreeLock), Player.shieldScale, Player.shieldScale, Player.shieldHalfWidth, Player.shieldHalfHeight)

	-- Thruster draws
	if love.keyboard.isDown('w') then
		--https://www.dropbox.com/s/9kdnaldhmnu2kge/SpaceLoveDemo.zip?dl=0
		local thrusterOffsetHorizontal = -20
		local thrusterOffsetVertical = -8
		local thrusterLength = 3
		local thrusterColor = {160, 250, 255}
		love.graphics.setColor(thrusterColor)
		love.graphics.line(Player.x + thrusterOffsetHorizontal, Player.y + Player.imgHalfHeight + thrusterOffsetVertical, Player.x + thrusterOffsetHorizontal, Player.y + Player.imgHalfHeight + thrusterOffsetVertical + thrusterLength)
	end

	-- Fuel UI draw
	love.graphics.setColor(175, 255, 255)
	love.graphics.print("FUEL", 3, love.graphics.getHeight() - 30)
	love.graphics.rectangle("line", 3, love.graphics.getHeight() - 13, 125, 10)
	love.graphics.setColor(175, 255, 25) --change to be based on fuel amount
	love.graphics.rectangle("fill", 4, love.graphics.getHeight() - 12, 120, 8) --max width is 123
end
