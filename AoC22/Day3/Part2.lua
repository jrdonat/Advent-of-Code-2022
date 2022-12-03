local file = assert(io.open("D:\\AoC22\\Advent-of-Code-2022\\AoC22\\Day3\\input.txt", "r"),"File failed to read")
local allChars = {}

local tallyPoints = function()
    local Tvalue = 0
    local fileLines = {}
    for line in file:lines() do
        table.insert(fileLines,line)
    end
    for i=1, #fileLines do
        if i%3 ~= 1 then
            goto continue
        end
        local firstHalf = fileLines[i]
        local secondHalf = fileLines[i+1]
        local thirdHalf = fileLines[i+2]
        for j = 1, #firstHalf do
            local char = string.sub(firstHalf,j,j)
            if string.find(secondHalf,char) and string.find(thirdHalf,char) then
                table.insert(allChars,char)
                break
            end
        end
        ::continue::
    end
    for i = 1, #allChars do
        local char = string.sub(allChars[i],1,1)
        if string.match(char,"%u") then
            Tvalue = Tvalue + string.byte(char) - 64 + 26
        else
            Tvalue = Tvalue + string.byte(char) - 96
        end
    end
    return Tvalue
end
print(tallyPoints())