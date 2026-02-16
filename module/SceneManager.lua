local SceneManager = {
    current = nil
}

function SceneManager.load(scene)
    SceneManager.current = scene
    if scene.load then scene:load() end
end

function SceneManager.update(dt)
    if SceneManager.current and SceneManager.current.update then
        SceneManager.current:update(dt)
    end
end

function SceneManager.draw()
    if SceneManager.current and SceneManager.current.draw then
        SceneManager.current:draw()
    end
end

function SceneManager.keypressed(key)
    if SceneManager.current and SceneManager.current.keypressed then
        SceneManager.current:keypressed(key)
    end
end

function SceneManager.mousepressed(x, y, button)
    if SceneManager.current and SceneManager.current.mousepressed then
        SceneManager.current:mousepressed(x, y, button)
    end
end

return SceneManager
