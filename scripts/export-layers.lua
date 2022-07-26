-- Export each layer as sprite sheet
-- Ignoring layers starting with "_"
--
-- Group layers will be exported as one sprite
-- except then it starts with ">" then it's exported like there isn't a group layer

function string:startswith(start)
    return self:sub(1, #start) == start
end

local function makesAllLayersVisible(layers, visible)
    for index, layer in ipairs(layers) do
        layer.isVisible = visible
        if layer.isGroup then
            makesAllLayersVisible(layer.layers)
        end
    end
end

local function exportLayer(layer, output)
    app.command.ExportSpriteSheet {
        type = SpriteSheetType.ROWS,
        textureFilename = output,
        layer = layer.name,
        trim = true, -- TODO: trimByGrid doesn't seem to work the same as CLI
        ignoreEmpty = true,
    }
end

local function exportGroupLayer(layer, output)
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
end

local function tryExportLayers(layers, dir)
    for _, layer in ipairs(layers) do
        if not layer.name:startswith('_') then
            print('Exporting layer ' .. layer.name)

            local output = dir .. '/' .. layer.name .. '.png'
            if layer.layers then
                if layer.name:startswith('>') then
                    tryExportLayers(layer.layers, dir)
                else
                    exportGroupLayer(layer, output)
                end
            else
                exportLayer(layer, output)
            end
        end
    end
end


local file = app.params['file']
local dir = app.params['dir']

if file and dir then
    local full_path = dir .. '/' .. file
    local sprite = app.open(full_path)

    makesAllLayersVisible(sprite.layers, false)
    tryExportLayers(sprite.layers, dir)
end
