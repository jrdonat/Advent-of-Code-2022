-- AoC Day 1
-- Clear output
local file = assert(io.open("D:\\AoC22\\Day1\\input.txt", "r"),"File failed to read")

local highest = 0
local testHighest = 0

-- Loop through each line
for line in file:lines() do
    -- Check if line is blank
    if line == "" or line == "%s+" then
        -- Check if testHighest is higher than highest
        if testHighest > highest then
            -- Set highest to testHighest
            highest = testHighest
            testHighest = 0
        else
            -- Set testHighest to 0
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

print(highest)