-- Read input file
local inputfile = assert(io.open("D:\\AoC22\\Advent-of-Code-2022\\AoC22\\Day9\\input.txt", "r"), "File failed to read")
local inputs = {}
for line in inputfile:lines() do
    table.insert(inputs, {line:sub(1, 1), tonumber(line:sub(3,3))})
end

local dirs = {
    ["L"] = {-1, 0},
    ["R"] = {1, 0},
    ["U"] = {0, 1},
    ["D"] = {0, -1}
}

local num_knots = 10
local knots = {}
for i = 1, num_knots do
    knots[i] = {0, 0}
end

local part1, part2 = {}, {}



for _, a in ipairs(inputs) do
    local d, n = a[1], a[2]
    for i = 1, n do
        knots[1][1] = knots[1][1] + dirs[d][1]
        knots[1][2] = knots[1][2] + dirs[d][2]

        for j = 2, num_knots do
            local dx, dy = knots[j][1] - knots[j-1][1], knots[j][2] - knots[j-1][2]
            if math.abs(dx) > 1 or math.abs(dy) > 1 then
                dx = math.max(-1, math.min(1, dx))
                dy = math.max(-1, math.min(1, dy))
                knots[j][1] = knots[j][1] - dx
                knots[j][2] = knots[j][2] - dy
            end
        end
        part1[tostring(knots[2][1])..","..tostring(knots[2][2])] = true
        part2[tostring(knots[num_knots][1])..","..tostring(knots[num_knots][2])] = true
        -- table.insert(part1, {knots[2][1], knots[2][2]})
        -- table.insert(part2, {knots[num_knots][1], knots[num_knots][2]})
    end
end

-- print("Part 1: %d", #part1)
-- print("Part 2: %d", #part2)

local count = 0
for k, _ in pairs(part1) do
    count = count + 1
end
print("Part 1: ", count)

count = 0
for k, _ in pairs(part2) do
    count = count + 1
end
print("Part 2: ", count)