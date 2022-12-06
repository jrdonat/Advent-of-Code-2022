-- read input.txt
local file = assert(io.open("D:\\AoC22\\Advent-of-Code-2022\\AoC22\\Day6\\input.txt", "r"),"File failed to read")

-- Check if table has duplicate elements
function table.hasDuplicates2(table)
    local hash = {}
    for _, value in pairs(table) do
        if (hash[value]) then
            return true
        end
        hash[value] = true
    end
    return false
end

-- Loop through each line
for line in file:lines() do
    local logged_set = {}
    for i = 1 , #line do
        table.insert(logged_set,line:sub(i,i))
        if #logged_set == 14 then
            if table.hasDuplicates2(logged_set) then
                table.remove(logged_set,1)
            else
                print(i)
                break
            end
        end
    end
end