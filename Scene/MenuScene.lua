local MenuScene = {}

local selectedOption = 1
local options = {"Play", "Quit"}

function MenuScene:enter()
    selectedOption = 1
end

function MenuScene:update(dt)
end

function MenuScene:draw()
    local width = love.graphics.getWidth()
    local height = love.graphics.getHeight()
    
    -- Match gameplay background color
    love.graphics.setBackgroundColor(0.608, 0.737, 0.059)
    
    -- Draw title
    love.graphics.setFont(love.graphics.newFont(48))
    love.graphics.setColor(0.18, 0.24, 0.02) -- Match snake body color
    love.graphics.printf("SNAKE", 0, height * 0.2, width, "center")
    
    -- Draw high score
    love.graphics.setFont(love.graphics.newFont(24))
    love.graphics.setColor(0.18, 0.24, 0.02)
    local highScore = love.filesystem.read("highscore.txt") or "0"
    love.graphics.printf("High Score: " .. highScore, 0, height * 0.35, width, "center")
    
    -- Draw menu options
    love.graphics.setFont(love.graphics.newFont(32))
    for i, option in ipairs(options) do
        local yPos = height * 0.5 + (i - 1) * 60
        
        if i == selectedOption then
            love.graphics.setColor(0.18, 0.24, 0.02)
            love.graphics.printf("> " .. option .. " <", 0, yPos, width, "center")
        else
            love.graphics.setColor(0.557, 0.694, 0.051) -- Match lighter green from gameplay
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