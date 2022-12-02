-- AoC Day 1 (Part 2)
local file = io.open("D:\\AoC22\\Day1\\input.txt", "r")
if not file then return end

local highest = 0
local testHighest = 0

local t = {}

-- Loop through each line
for line in file:lines() do
    -- Check if line is blank
    if line == "" or line == "%s+" then
        -- Check if testHighest is higher than highest
        if testHighest > highest then
            -- Set highest to testHighest
            highest = testHighest
            table.insert(t, testHighest)
            testHighest = 0
        else
            -- Set testHighest to 0
            table.insert(t, testHighest)
            testHighest = 0
        end
    else
        -- Add to testHighest
        testHighest = testHighest + tonumber(line)
    end
end
if testHighest > highest then -- Line == "" won't fire so we have to run it one more time
    highest = testHighest
end

-- Sort table smallest to largest
table.sort(t)
local a,b,c = table.unpack(t,#t-2)
print(a+b+c)