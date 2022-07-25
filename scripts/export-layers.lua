local function makesAllLayersVisible(layers, visible)
    for index, layer in ipairs(layers) do
        layer.isVisible = visible
        if layer.isGroup then
            makesAllLayersVisible(layer.layers)
        end
    end
end

function string:startswith(start)
    return self:sub(1, #start) == start
end


local file = app.params['file']
local dir = app.params['dir']

if file and dir then
    local full_path = dir .. '/' .. file
    local sprite = app.open(full_path)

    makesAllLayersVisible(sprite.layers, false)
 
    for _, layer in ipairs(sprite.layers) do
        if not layer.name:startswith('_') then
            print('Exporting layer ' .. layer.name)

            local output = dir .. '/' .. layer.name .. '.png'
            if layer.layers then
                layer.isVisible = true
                makesAllLayersVisible(layer.layers, true)

                app.command.ExportSpriteSheet {
                    type = SpriteSheetType.ROWS,
                    textureFilename = output,
                    trimByGrid = true,
                    ignoreEmpty = true,
                }

                layer.isVisible = false
                makesAllLayersVisible(layer.layers, false)
            else
                app.command.ExportSpriteSheet {
                    type = SpriteSheetType.ROWS,
                    textureFilename = output,
                    layer = layer.name,
                    trim = true, -- TODO: trimByGrid doesn't seem to work the same as CLI
                    ignoreEmpty = true,
                }
            end

        end
    end
end
