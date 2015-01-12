local class = require "lib.middleclass"
local Ship = require "Ship"

local Player = class('Player')

function Player:initialize(Ship)
	-- Ship
	self.Ship = Ship or console.e("Player created with no Ship.")
end

return Player
