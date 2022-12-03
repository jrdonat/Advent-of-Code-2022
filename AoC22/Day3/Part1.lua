local file = assert(io.open("D:\\AoC22\\Advent-of-Code-2022\\AoC22\\Day3\\input.txt", "r"),"File failed to read")
local allChars = {}
-- Lowercase item types a through z have priorities 1 through 26
-- Uppercase item types A through Z have priorities 27 through 52

local tallyPoints = function()
    local Tvalue = 0
    for line in file:lines() do
        local firstHalf = string.sub(line,1,#line/2)
        local secondHalf = string.sub(line,#line/2+1,#line)
        -- Check if a character is shared by both halves
        for i = 1, #firstHalf do
            local char = string.sub(firstHalf,i,i)
            if string.find(secondHalf,char) then
                table.insert(allChars,char)
                break
            end
        end
    end
        -- Calculate sum of all priorities in allChars
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