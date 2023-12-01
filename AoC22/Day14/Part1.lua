-- Read input file
local inputfile = assert(io.open("D:\\AoC22\\Advent-of-Code-2022\\AoC22\\Day14\\input.txt", "r"), "File failed to read")
local MasterTable = {}
local function string_to_coordinates(str)
    local coordinates = {}

    -- Iterate over the pairs of coordinates in the string
    for x, y in str:gmatch("(%d+),(%d+)") do
        coordinates[#coordinates + 1] = { x = tonumber(x), y = tonumber(y) }
    end

    return coordinates
end

-- Calculates the Euclidean distance between two points (x1, y1) and (x2, y2)
local function distance(x1, y1, x2, y2)
    local dx = x2 - x1
    local dy = y2 - y1
    return math.sqrt(dx * dx + dy * dy)
end

-- Connects the points in the given array of points by adding the missing in-between points and returns a new array of points with the missing points added.
local function connect_points(points)
    local result = {}

    for i = 1, #points - 1 do
        local x1, y1 = points[i].x, points[i].y
        local x2, y2 = points[i + 1].x, points[i + 1].y
        local d = distance(x1, y1, x2, y2)

        -- Add the starting point
        table.insert(result, { x = x1, y = y1 })

        -- Calculate the missing in-between points
        local num_points = math.ceil(d) - 1
        local dx = (x2 - x1) / (num_points + 1)
        local dy = (y2 - y1) / (num_points + 1)
        for k = 1, num_points do
            local x = x1 + k * dx
            local y = y1 + k * dy
            table.insert(result, { x = x, y = y })
        end
    end

    -- Add the last point
    table.insert(result, { x = points[#points].x, y = points[#points].y })

    return result
end

local function flatten_coordinates(coord_table)
    local flat_table = {}

    -- Loop through each table of coordinates
    for _, coord_subtable in ipairs(coord_table) do
        -- Loop through each coordinate in the subtable
        for _, coord in ipairs(coord_subtable) do
            -- Add the coordinate to the flat table, indexed by its x and y values
            flat_table[coord.x] = flat_table[coord.x] or {}
            flat_table[coord.x][coord.y] = coord
        end
    end

    return flat_table
end

for line in inputfile:lines() do
    -- Split the line into a table of coordinates
    local coordinates = string_to_coordinates(line)

    -- Connect the points in the table of coordinates
    local connected_coordinates = connect_points(coordinates)

    -- Add the connected coordinates to the master table
    table.insert(MasterTable, connected_coordinates)
end
inputfile:close()
-- Flatten the master table
local flat_table = flatten_coordinates(MasterTable)

-- Done this, don't want to run it again

-- Get the highest x and y value from the master table
local max_x, max_y = 0, 0
for x, y_table in pairs(flat_table) do
    max_x = math.max(max_x, x)
    for y in pairs(y_table) do
        max_y = math.max(max_y, y)
    end
end
--[[
local viewingFile = assert(io.open("D:\\AoC22\\Advent-of-Code-2022\\AoC22\\Day14\\viewing.txt", "w"),"Failed to open a writeable file")

-- Loop through each coordinate in the flat table and write them to form a visual grid. Fill in gaps with '.'
for y = 0, max_y do
    for x = 0, max_x do
        if flat_table[x] and flat_table[x][y] then
            viewingFile:write("#")
        else
            viewingFile:write(".")
        end
    end
    viewingFile:write("\n")
end
viewingFile:close()
]]

local stopSpawning = false
local sand_table = {}
local i = 0
repeat -- Up = Down in the Y direction. Weird like that
    i = i + 1
    local sand = { x = 500, y = 0 }
    ::falling::
    while (not flat_table[sand.x] or not flat_table[sand.x][sand.y + 1]) and
        (not sand_table[sand.x] or not sand_table[sand.x][sand.y + 1]) and (sand.y < max_y) do --   + = -
        sand.y = sand.y + 1
        --print(sand.x,sand.y)
    end
    if sand.y >= max_y then
        stopSpawning = true
        break
    end
    if sand_table[sand.x] and sand_table[sand.x][sand.y + 1] then
        if (not flat_table[sand.x - 1] or not flat_table[sand.x - 1][sand.y + 1]) and (not sand_table[sand.x - 1] or not sand_table[sand.x - 1][sand.y + 1]) then
            sand.x = sand.x - 1
            goto falling
        elseif (not flat_table[sand.x + 1] or not flat_table[sand.x + 1][sand.y + 1]) and (not sand_table[sand.x + 1] or not sand_table[sand.x + 1][sand.y + 1]) then
            sand.x = sand.x + 1
            goto falling
        end
    end
    sand_table[sand.x] = sand_table[sand.x] or {}
    sand_table[sand.x][sand.y] = sand.y
    --print("Ended")
until stopSpawning == true -- or i == 700
local sandingFile = assert(io.open("D:\\AoC22\\Advent-of-Code-2022\\AoC22\\Day14\\sanded.txt", "w"),"Failed to open a writeable file")

-- Loop through each coordinate in the flat table and write them to form a visual grid. Fill in gaps with '.'
for y = 0, max_y do
    for x = 0, max_x do
        if flat_table[x] and flat_table[x][y] then
            sandingFile:write("#")
        elseif sand_table[x] and sand_table[x][y] then
            sandingFile:write("o")
        else
            sandingFile:write(".")
        end
    end
    sandingFile:write("\n")
end
sandingFile:close()
print(i)
