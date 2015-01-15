local Player = require "Player"
local Ship = require "Ship"
local Hull = require "Hull"
local Shield = require "Shield"
local Engine = require "Engine"
local Thruster = require "Thruster"

Ship = Player(Ship(
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

return Ship
