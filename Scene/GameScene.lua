local GameScene = {
    CELL = 15,
    COLS = 20,
    ROWS = 20,
    TICK = 0.12
}

local snake, dir, nextDir, food, timer, score, state, highScore

local function loadHighScore()
    if love.filesystem.getInfo("highscore.txt") then
        local data = love.filesystem.read("highscore.txt")
        highScore = tonumber(data) or 0
    else
        highScore = 0
    end
end

local function saveHighScore()
    if score > highScore then
        highScore = score
        love.filesystem.write("highscore.txt", tostring(highScore))
    end
end

local function placeFood()
    local free = {}
    for x = 1, GameScene.COLS do
        for y = 1, GameScene.ROWS do
            local occupied = false
            for _, s in ipairs(snake) do
                if s[1] == x and s[2] == y then occupied = true; break end
            end
            if not occupied then free[#free + 1] = {x, y} end
        end
    end
    if #free > 0 then
        food = free[love.math.random(#free)]
    end
end

local function reset()
    snake = {{10, 10}, {9, 10}, {8, 10}}
    dir = {1, 0}
    nextDir = {1, 0}
    food = nil
    timer = 0
    score = 0
    state = "play"
    placeFood()
end

function GameScene:load()
    love.graphics.setDefaultFilter("nearest", "nearest")
    love.graphics.setBackgroundColor(0.608, 0.737, 0.059)
    loadHighScore()
    reset()
end

function GameScene:keypressed(key)
    if state == "dead" then
        if key == "return" or key == "space" then reset() end
        return
    end
    if key == "up"    and dir[2] ~= 1  then nextDir = {0, -1}
    elseif key == "down"  and dir[2] ~= -1 then nextDir = {0, 1}
    elseif key == "left"  and dir[1] ~= 1  then nextDir = {-1, 0}
    elseif key == "right" and dir[1] ~= -1 then nextDir = {1, 0}
    end
end

function GameScene:update(dt)
    if state ~= "play" then return end
    timer = timer + dt
    if timer < GameScene.TICK then return end
    timer = timer - GameScene.TICK

    dir = nextDir
    local head = {snake[1][1] + dir[1], snake[1][2] + dir[2]}

    if head[1] < 1 or head[1] > GameScene.COLS or head[2] < 1 or head[2] > GameScene.ROWS then
        state = "dead"
        saveHighScore()
        return
    end
    for i = 1, #snake do
        if snake[i][1] == head[1] and snake[i][2] == head[2] then
            state = "dead"
            saveHighScore()
            return
        end
    end

    table.insert(snake, 1, head)

    if food and head[1] == food[1] and head[2] == food[2] then
        score = score + 1
        placeFood()
    else
        table.remove(snake)
    end
end

function GameScene:draw()
    local ox = 0
    local oy = 0

    love.graphics.setColor(0.557, 0.694, 0.051)
    for x = 1, GameScene.COLS do
        for y = 1, GameScene.ROWS do
            love.graphics.rectangle("fill", ox + (x-1)*GameScene.CELL + 1, oy + (y-1)*GameScene.CELL + 1, GameScene.CELL - 1, GameScene.CELL - 1)
        end
    end

    if food then
        love.graphics.setColor(0.18, 0.24, 0.02)
        local fx = ox + (food[1]-1)*GameScene.CELL
        local fy = oy + (food[2]-1)*GameScene.CELL
        love.graphics.rectangle("fill", fx + 2, fy + 2, GameScene.CELL - 3, GameScene.CELL - 3)
        love.graphics.setColor(0.557, 0.694, 0.051)
        love.graphics.rectangle("fill", fx + 4, fy + 4, GameScene.CELL - 7, GameScene.CELL - 7)
    end

    for i, s in ipairs(snake) do
        love.graphics.setColor(0.18, 0.24, 0.02)
        local sx = ox + (s[1]-1)*GameScene.CELL
        local sy = ox + (s[2]-1)*GameScene.CELL
        love.graphics.rectangle("fill", sx + 1, sy + 1, GameScene.CELL - 1, GameScene.CELL - 1)
        if i == 1 then
            love.graphics.setColor(0.557, 0.694, 0.051)
            local ex, ey = 0, 0
            if dir[1] == 1  then ex = 3 end
            if dir[1] == -1 then ex = -1 end
            if dir[2] == 1  then ey = 3 end
            if dir[2] == -1 then ey = -1 end
            love.graphics.rectangle("fill", sx + 4 + ex, sy + 4 + ey, 2, 2)
            love.graphics.rectangle("fill", sx + 9 + ex, sy + 4 + ey, 2, 2)
        end
    end

    love.graphics.setColor(0.18, 0.24, 0.02)
    love.graphics.print("Score: " .. score, 4, GameScene.ROWS * GameScene.CELL + 2)

    if state == "dead" then
        love.graphics.setColor(0.18, 0.24, 0.02)
        love.graphics.printf("GAME OVER\nPress Enter", 0, 120, 300, "center")
    end
end

return GameScene
