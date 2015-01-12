local Debug = {}
local debug = {
	-- values to use: above, below, none
	hitRadius = "above",    -- (magenta) where player can be hit
	middleLines = "below",  -- (red) midlines of screen
	playerCenter = "none",  -- (pink) center of player
	fpsCounter = "above",   -- (white) current fps in top left
	fuelNumber = "above",   -- (white) fuel/max fuel in numerical form
}

function Debug:drawAbove()
	for k,v in pairs(debug) do
		if v == "above" then
			Debug[k]()
		end
	end
end

function Debug:drawBelow()
	for k,v in pairs(debug) do
		if v == "below" then
			Debug[k]()
		end
	end
end

function Debug:hitRadius()
	love.graphics.setLineWidth(1)
	love.graphics.setColor(255, 0, 255) -- as much as I love this orange: 188, 128, 90, THIS NEEDS TO STAND OUT
	love.graphics.arc("line", player.Ship.x, player.Ship.y, player.Ship.Hull.hitRadius, 0, math.pi*2, 20)
end

function Debug:middleLines()
	love.graphics.setLineWidth(0.5)
	love.graphics.setColor(200, 0, 0)
	love.graphics.line(love.graphics.getWidth() / 2, 0, love.graphics.getWidth() / 2, love.graphics.getHeight())
	love.graphics.line(0, love.graphics.getHeight() / 2, love.graphics.getWidth(), love.graphics.getHeight() / 2)
end

function Debug:playerCenter()
	love.graphics.setColor(255, 100, 100)
	love.graphics.arc("fill", player.Ship.x, player.Ship.y, 3, 0, math.pi*2, 20)
end

function Debug:fpsCounter()
	love.graphics.setFont(Render.debugFont)
	love.graphics.setColor(255, 255, 255)
	love.graphics.print("FPS: "..love.timer.getFPS(), 3, 2)
end

function Debug:fuelNumber()
	love.graphics.setFont(Render.debugFont)
	local text = "Fuel: "..math.floor(player.Ship.Hull.fuelAmount).."/"..player.Ship.Hull.fuelCapacity
	local width = Render.debugFont:getWidth(text)
	love.graphics.setColor(100, 0, 0)
	love.graphics.rectangle("fill", 1, love.graphics.getHeight() - 13, width+3, love.graphics.getHeight() -2)
	love.graphics.setColor(255, 255, 255)
	love.graphics.print(text, 2, love.graphics.getHeight() - 13)
end

return Debug
