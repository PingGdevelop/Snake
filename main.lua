local SceneManager = require("module.SceneManager")
local GameScene = require("Scene.GameScene")
local MenuScene = require("Scene.MenuScene")

function love.load()
    SceneManager:addScene("GameScene", GameScene)
    SceneManager:addScene("MenuScene", MenuScene)
    SceneManager:load("MenuScene")
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
