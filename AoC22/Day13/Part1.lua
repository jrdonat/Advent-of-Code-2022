-- Read input file
local inputfile = assert(io.open("D:\\AoC22\\Advent-of-Code-2022\\AoC22\\Day13\\input.txt", "r"), "File failed to read")
local sum_wrong = 0
local input = load("return {{" .. inputfile:read("all"):gsub("%[", "{"):gsub("%]", "}"):gsub("[\n]+", "},\n{") .. "}}")()

local function flatten_table(t)


    -- Create a new table to store the flattened elements
    local flat = {}
    -- Iterate over each element in the original table
    for _, v in ipairs(t) do
        -- If the element is a table, recursively flatten it
        if type(v) == "table" and #v == 0 then
            table.insert(flat, "")
        elseif type(v) == "table" then
            local nested = flatten_table(v)
            for _, nv in ipairs(nested) do
                table.insert(flat, nv)
            end
        else
            -- Otherwise, append the element to the new table
            table.insert(flat, v)
        end
    end

    return flat
end

print(utf8.codes("\033[4;31m Test"))


for i in ipairs(input) do
    if i % 2 == 0 then
        goto continue
    end
    local tbl1 = flatten_table(input[i])
    local tbl2 = flatten_table(input[i + 1])



    local testK
    for k = 1, math.min(#tbl1,#tbl2) do
        if tbl1[k] == "" or tbl2[k] == "" then
            if (tbl2[k] == "") and (tbl1[k] ~= "") then
                sum_wrong = sum_wrong + i
                testK = k
                break
            end
        elseif tbl1[k] > tbl2[k] then
            sum_wrong = sum_wrong + i
            testK = k
            break
        end
    end
    -- for k, v in ipairs(tbl1) do
    --     if v == "" then v = "_" end
    --     if testK == k then
    --         io.write("\033[1;31m\033[4;31m"..v.."\033[0m")
    --     else
    --         io.write(v)
    --     end
    -- end
    -- io.write("\n")
    -- for k, v in ipairs(tbl2) do
    --     if v == "" then v = "_" end
    --     if testK == k then
    --         io.write("\033[1;31m\033[4;31m"..v.."\033[0m")
    --     else
    --         io.write(v)
    --     end
    -- end
    -- io.write("\n\n")
    ::continue::
end

local total = 22500

print(total-sum_wrong)