-- Read input.txt
local inputfile = assert(io.open("D:\\AoC22\\Advent-of-Code-2022\\AoC22\\Day8\\input.txt", "r"), "File failed to read")
local contents = inputfile:read('*all')

-- Split the string into a list of lines
local lines = {}
for line in string.gmatch(contents, "[^\n]+") do
    table.insert(lines, line)
end

-- Create a 2D array to store the characters
local arr = {}

-- Loop through each line and split it into a list of characters
for i, line in ipairs(lines) do
    arr[i] = {}

    -- Split line into a table of characters
    local newLine = {}
    for character in string.gmatch(line, ".") do
        table.insert(newLine, character)
    end

    for j, character in ipairs(newLine) do
        arr[i][j] = tonumber(character)
    end
end

-- Helper function to get the value at a given position in the array if the position is out of bounds, returns 0
local function get(x, y)
    if x < 1 or x > #arr or y < 1 or y > #arr[1] then
        return 0
    end
    return arr[x][y]
end
local log = {}

-- Loop through each position in the array
for x = 1, #arr do
    for y = 1, #arr[1] do
        -- Check the values to the left, right, top, and bottom
        local left = get(x, y - 1)
        local right = get(x, y + 1)
        local top = get(x - 1, y)
        local bottom = get(x + 1, y)

        -- Find the distances to the closest values that are equal to or greater than the target value
        local left_dist = 0
        local right_dist = 0
        local top_dist = 0
        local bottom_dist = 0

        -- Check values to the left
        for i = y - 1, 1, -1 do
            if get(x, i) >= arr[x][y] then
                left_dist = y - i
                break
            end
        end

        -- Check values to the right
        for i = y + 1, #arr[1] do
            if get(x, i) >= arr[x][y] then
                right_dist = i - y
                break
            end
        end

        -- Check values above
        for i = x - 1, 1, -1 do
            if get(i, y) >= arr[x][y] then
                top_dist = x - i
                break
            end
        end

        -- Check values below
        for i = x + 1, #arr do
            if get(i, y) >= arr[x][y] then
                bottom_dist = i - x
                break
            end
        end

        -- If there are no values equal to or greater than the target value in a given direction, use the distance to the outer bound of the array instead
        if left_dist == 0 then
            left_dist = y - 1
        end
        if right_dist == 0 then
            right_dist = #arr[1] - y
        end
        if top_dist == 0 then
            top_dist = x - 1
        end
        if bottom_dist == 0 then
            bottom_dist = #arr - x
        end

        -- Multiply the distances together and log the result
        local result = left_dist * right_dist * top_dist * bottom_dist
        table.insert(log, result)
    end
end

table.sort(log)
print(log[#log])
