push = require('push')

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

-- Define layers with images, scroll positions, and speeds
local layers = {
    { image = love.graphics.newImage('images/1.png'), scroll = 0, speed = 3, loopingPoint = 512 },
    { image = love.graphics.newImage('images/2.png'), scroll = 0, speed = 6, loopingPoint = 512 },
    { image = love.graphics.newImage('images/3.png'), scroll = 0, speed = 10, loopingPoint = 300 },
    { image = love.graphics.newImage('images/4.png'), scroll = 0, speed = 15, loopingPoint = 300 },
    { image = love.graphics.newImage('images/5.png'), scroll = 0, speed = 25, loopingPoint = 300 },
    { image = love.graphics.newImage('images/6.png'), scroll = 0, speed = 40, loopingPoint = 200 }
}

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    love.window.setTitle('Parallax Example')

    -- Set up screen with virtual resolution
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = true,
        fullscreen = false,
        resizable = true
    })
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end

function love.update(dt)
    -- Update scroll for each layer based on its speed
    for _, layer in ipairs(layers) do
        layer.scroll = (layer.scroll + layer.speed * dt) % layer.loopingPoint
    end
end

function love.draw()
    push:start()
    
    -- Draw each layer in the order from farthest to closest
    for _, layer in ipairs(layers) do
        love.graphics.draw(layer.image, -layer.scroll, 0)
    end
    
    push:finish()
end
