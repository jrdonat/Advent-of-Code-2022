local file = assert(io.open("D:\\AoC22\\Advent-of-Code-2022\\AoC22\\Day5\\input.txt", "r"),"File failed to read")
local tableDictionary = {
    [1] = {"Z","J","N","W","P","S"},
    [2] = {"G","S","T"},
    [3] = {"V","Q","R","L","H"},
    [4] = {"V","S","T","D"},
    [5] = {"Q","Z","T","D","B","M","J"},
    [6] = {"M","W","T","J","D","C","Z","L"},
    [7] = {"L","P","M","W","G","T","J"},
    [8] = {"N","G","M","T","B","F","Q","H"},
    [9] = {"R","D","G","C","P","B","Q","W"}
}
for line in file:lines() do
    local numbers = {}
    for number in string.gmatch(line, "%d+") do
        table.insert(numbers,tonumber(number))
    end
    for i = 1, numbers[1] do
        local log = tableDictionary[numbers[2]][#tableDictionary[numbers[2]]]
        table.remove(tableDictionary[numbers[2]],#tableDictionary[numbers[2]])
        table.insert(tableDictionary[numbers[3]],log)
    end
end

for i, v in pairs(tableDictionary) do
    print(v[#v])
end