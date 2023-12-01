-- Read input file
local inputfile = assert(io.open("D:\\AoC22\\Advent-of-Code-2022\\AoC22\\Day10\\input.txt", "r"), "File failed to read")
local iterator = 0
local total = 0
local waited = false
local X = 1

local screen = {}

local function checkIterator()
    iterator = iterator + 1
    local diff=((iterator-1)%40)-(X-1)
    if diff>=0 and diff<3 then
        screen[iterator] = "#"
    else
        screen[iterator] = "."
    end
end
-- Loop through each line of file
for line in inputfile:lines() do
    local inputs = {}
    for i in line:gmatch("%S+") do
        table.insert(inputs, i)
    end
    ::cycle::
    checkIterator()
    -- Split line into table
    if inputs[1] == "addx" then
        if waited then
            X = X + tonumber(inputs[2])
            waited = false
        else
            waited = true
            goto cycle
        end
    end
end
for i = 1, iterator do
    io.write(screen[i])
    if i%40==0 then
        io.write("\n")
    end
end
