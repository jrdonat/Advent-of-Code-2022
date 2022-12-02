-- AoC Day 1 (Part 2)
local file = io.open("D:\\AoC22\\Day1\\input.txt", "r")
if not file then return end

local highest = 0
local testHighest = 0

local t = {}

for line in file:lines() do
    if line == "" or line == "%s+" then
        if testHighest > highest then
            highest = testHighest
            table.insert(t, testHighest)
            testHighest = 0
        else
            table.insert(t, testHighest)
            testHighest = 0
        end
    else
        testHighest = testHighest + tonumber(line)
    end
end
if testHighest > highest then
    highest = testHighest
end

table.sort(t)
local a,b,c = table.unpack(t,#t-2)
print(a+b+c)