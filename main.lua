push = require('push')

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

local IMAGE_WIDTH = 576 -- Current width of each background image

-- Define layers with images, scroll positions, and speeds
local layers = {
    { image = love.graphics.newImage('images/1.png'), scroll = 0, speed = 2 },
    { image = love.graphics.newImage('images/2.png'), scroll = 0, speed = 5 },
    { image = love.graphics.newImage('images/3.png'), scroll = 0, speed = 10 },
    { image = love.graphics.newImage('images/4.png'), scroll = 0, speed = 15 },
    { image = love.graphics.newImage('images/5.png'), scroll = 0, speed = 25 },
    { image = love.graphics.newImage('images/6.png'), scroll = 0, speed = 40 }
}

local backgroundMusic

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    love.window.setTitle('Parallax Example')

    -- Set up screen with virtual resolution
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = true,
        fullscreen = false,
        resizable = true
    })

    -- Load and play background music
    backgroundMusic = love.audio.newSource('audio/lofi_music.mp3', 'stream')
    backgroundMusic:setLooping(true) -- Set it to loop
    backgroundMusic:setVolume(0.5)   -- Adjust volume as needed (0.0 to 1.0)
    backgroundMusic:play()
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
        layer.scroll = (layer.scroll + layer.speed * dt) % IMAGE_WIDTH
    end
end

function love.draw()
    push:start()
    
    -- Draw each layer in the order from farthest to closest
    for _, layer in ipairs(layers) do
        -- Draw the image twice to create a seamless loop effect
        love.graphics.draw(layer.image, -layer.scroll, 0)
        love.graphics.draw(layer.image, -layer.scroll + IMAGE_WIDTH, 0)
    end
    
    push:finish()
end
