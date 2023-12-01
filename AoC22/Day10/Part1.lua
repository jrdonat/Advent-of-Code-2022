-- Read input file
local inputfile = assert(io.open("D:\\AoC22\\Advent-of-Code-2022\\AoC22\\Day10\\input.txt", "r"), "File failed to read")
local iterator = 0
local total = 0
local waited = false
local X = 1

local function checkIterator()
    iterator = iterator + 1
    if (iterator-20)%40==0 then
        total = total + (iterator * X)
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
print(total)