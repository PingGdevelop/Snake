local MenuScene = {}

local selectedOption = 1
local options = {"Play", "Quit"}
local fonts = {}

function MenuScene:enter()
    selectedOption = 1
    -- Pre-create fonts at native resolution
    if not fonts.title then
        fonts.title = love.graphics.newFont("Assets/font.ttf", 48)
        fonts.small = love.graphics.newFont("Assets/font.ttf", 20)
        fonts.menu = love.graphics.newFont("Assets/font.ttf", 32)
    end
end

function MenuScene:update(dt)
end

function MenuScene:draw()
    local width = love.graphics.getWidth()
    local height = love.graphics.getHeight()
    
    -- Match gameplay background color
    love.graphics.setBackgroundColor(0.608, 0.737, 0.059)
    
    -- Draw title
    love.graphics.setFont(fonts.title)
    love.graphics.setColor(0.18, 0.24, 0.02)
    love.graphics.printf("SNAKE", 0, height * 0.2, width, "center")
    
    -- Draw high score
    love.graphics.setFont(fonts.small)
    love.graphics.setColor(0.18, 0.24, 0.02)
    local highScore = love.filesystem.read("highscore.txt") or "0"
    love.graphics.printf("HI-SCORE: " .. highScore, 0, height * 0.38, width, "center")
    
    -- Draw menu options
    love.graphics.setFont(fonts.menu)
    for i, option in ipairs(options) do
        local yPos = height * 0.55 + (i - 1) * 50
        
        if i == selectedOption then
            love.graphics.setColor(0.18, 0.24, 0.02)
            love.graphics.printf("> " .. option .. " <", 0, yPos, width, "center")
        else
            love.graphics.setColor(0.557, 0.694, 0.051)
            love.graphics.printf(option, 0, yPos, width, "center")
        end
    end
    
    -- Reset color
    love.graphics.setColor(1, 1, 1)
end

function MenuScene:keypressed(key)
    if key == "up" then
        selectedOption = selectedOption - 1
        if selectedOption < 1 then
            selectedOption = #options
        end
    elseif key == "down" then
        selectedOption = selectedOption + 1
        if selectedOption > #options then
            selectedOption = 1
        end
    elseif key == "return" or key == "space" then
        if selectedOption == 1 then
            SceneManager:switch("GameScene")
        elseif selectedOption == 2 then
            love.event.quit()
        end
    end
end

return MenuScene
