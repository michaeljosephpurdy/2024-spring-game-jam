function love.load()
	love.graphics.setDefaultFilter("nearest", "nearest")
	love.window.setMode(640, 360)
end

function love.draw()
	love.graphics.print("2024 spring game jam", 20, 20)
end
