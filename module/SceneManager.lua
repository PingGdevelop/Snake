local SceneManager = {
    current = nil,
    scenes = {}
}

function SceneManager:addScene(name, scene)
    self.scenes[name] = scene
end

function SceneManager:load(sceneName)
    local scene = self.scenes[sceneName]
    if scene then
        SceneManager.current = scene
        if scene.load then scene:load() end
        if scene.enter then scene:enter() end
    end
end

function SceneManager:switch(sceneName)
    local scene = self.scenes[sceneName]
    if scene and SceneManager.current ~= scene then
        if SceneManager.current and SceneManager.current.exit then
            SceneManager.current:exit()
        end
        SceneManager.current = scene
        if scene.enter then scene:enter() end
    end
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
