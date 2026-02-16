local SceneManager = require("module.SceneManager")
local GameScene = require("Scene.GameScene")

function love.load()
    SceneManager.load(GameScene)
end

function love.update(dt)
    SceneManager.update(dt)
end

function love.draw()
    SceneManager.draw()
end

function love.keypressed(key)
    SceneManager.keypressed(key)
end
