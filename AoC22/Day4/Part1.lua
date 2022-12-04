local file = assert(io.open("D:\\AoC22\\Advent-of-Code-2022\\AoC22\\Day4\\input.txt", "r"),"File failed to read")

local fileLines = {}
for line in file:lines() do
    local lineSplit = {}
    for word in string.gmatch(line, "[^,]+") do
        table.insert(lineSplit,word)
    end
    table.insert(fileLines,lineSplit)
end
local overlaps = 0
for i, v in pairs(fileLines) do
    local firstNumber = tonumber(string.sub(v[1],1,string.find(v[1],"-")-1))
    local secondNumber = tonumber(string.sub(v[1],string.find(v[1],"-")+1,#v[1]))
    local thirdNumber = tonumber(string.sub(v[2],1,string.find(v[2],"-")-1))
    local fourthNumber = tonumber(string.sub(v[2],string.find(v[2],"-")+1,#v[2]))
    if (firstNumber <= thirdNumber and secondNumber >= fourthNumber) or (firstNumber >= thirdNumber and secondNumber <= fourthNumber) then
        overlaps = overlaps + 1
    end
end

print(overlaps)