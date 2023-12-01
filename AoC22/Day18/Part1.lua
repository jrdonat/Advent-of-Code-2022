local inputFile = assert(io.open("AoC22\\Day18\\input.txt", "r"),"File failed to read")
local blocks = {}
local total = 0
for line in inputFile:lines() do
    blocks[line] = true
    total = total + 6
end

local function checkFor3DAdjacents(coords)
    local x, y, z = coords:match("(%d+),(%d+),(%d+)")
    x, y, z = tonumber(x), tonumber(y), tonumber(z)
    local adjacents = {
        {x-1, y, z},
        {x+1, y, z},
        {x, y-1, z},
        {x, y+1, z},
        {x, y, z-1},
        {x, y, z+1}
    }
    local count = 0
    for _, v in ipairs(adjacents) do
        if blocks[tostring(v[1])..","..tostring(v[2])..","..tostring(v[3])] then
            count = count + 1
        end
    end
    total = total - (count)
end
for i, v in pairs(blocks) do
    checkFor3DAdjacents(i)
end
print(total)