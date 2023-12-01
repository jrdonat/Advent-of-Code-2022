-- Read input file
local inputfile = assert(io.open("D:\\AoC22\\Advent-of-Code-2022\\AoC22\\Day9\\input.txt", "r"), "File failed to read")

-- Define the starting position of the head and tail
local head_x, head_y, tail_x, tail_y = 0, 0, 0, 0

-- create a table to keep track of all positions visited by the tail
local visited_positions = {}
visited_positions[tail_x..","..tail_y] = true

local function is_touching(one_x, one_y, two_x, two_y)
    -- check if the positions are adjacent horizontally, vertically, or diagonally
    if (one_x == two_x and math.abs(one_y - two_y) == 1) or
        (one_y == two_y and math.abs(one_x - two_x) == 1) or
        (math.abs(one_x - two_x) == 1 and math.abs(one_y - two_y) == 1) then
        return true
    end

    -- check if the positions are on top of each other
    if one_x == two_x and one_y == two_y then
        return true
    end
    return false
end

local function get_direction(one_x, one_y, two_x, two_y)
    -- check if the positions are adjacent horizontally, vertically, or diagonally
    if one_x == two_x and one_y > two_y then
        return "up"
    elseif one_x == two_x and one_y < two_y then
        return "down"
    elseif one_y == two_y and one_x > two_x then
        return "right"
    elseif one_y == two_y and one_x < two_x then
        return "left"
    elseif one_x > two_x and one_y > two_y and ((one_x - two_x) < (one_y - two_y)) then
        return "up"
    elseif one_x > two_x and one_y > two_y and ((one_x - two_x) > (one_y - two_y)) then
        return "right"
    elseif one_x > two_x and one_y < two_y and ((one_x - two_x) < (two_y - one_y)) then
        return "down"
    elseif one_x > two_x and one_y < two_y and ((one_x - two_x) > (two_y - one_y)) then
        return "right"
    elseif one_x < two_x and one_y > two_y and ((two_x - one_x) < (one_y - two_y)) then
        return "up"
    elseif one_x < two_x and one_y > two_y and ((two_x - one_x) > (one_y - two_y)) then
        return "left"
    elseif one_x < two_x and one_y < two_y and ((two_x - one_x) < (two_y - one_y)) then
        return "down"
    elseif one_x < two_x and one_y < two_y and ((two_x - one_x) > (two_y - one_y)) then
        return "left"
    end

    -- check if the positions are on top of each other
    if one_x == two_x and one_y == two_y then
        return "same"
    end
    return nil
  end
  

-- define a function to move the head and update the tail position
local function move(direction)
    -- update the head position based on the direction
    if direction == "U" then
        head_y = head_y + 1
    elseif direction == "D" then
        head_y = head_y - 1
    elseif direction == "L" then
        head_x = head_x - 1
    elseif direction == "R" then
        head_x = head_x + 1
    end

    -- check if the head and tail are in the same row or column
    if not is_touching(head_x, head_y, tail_x, tail_y) then
        local dir = get_direction(head_x, head_y, tail_x, tail_y)
        if dir == "up" then
            tail_y = head_y - 1
            tail_x = head_x
        elseif dir == "down" then
            tail_y = head_y + 1
            tail_x = head_x
        elseif dir == "left" then
            tail_x = head_x + 1
            tail_y = head_y
        elseif dir == "right" then
            tail_x = head_x - 1
            tail_y = head_y
        end
    end
end

-- Loop through inputFile
for line in inputfile:lines() do
    for i = 1, tonumber(line:sub(3, 3)) do
        move(line:sub(1, 1))
        visited_positions[tail_x..","..tail_y] = true
    end
end
-- print the number of unique positions visited by the tail
local ticker = 0
for i, v in pairs(visited_positions) do
    ticker = ticker + 1
end
print(ticker)

print(is_touching(0,0,0,0)) -- True
print(is_touching(0,1,0,0)) -- True
print(is_touching(1,1,0,0)) -- True
print(is_touching(1,0,0,0)) -- True
print(is_touching(1,-1,0,0)) -- True
print(is_touching(0,-1,0,0)) -- True
print(is_touching(-1,-1,0,0)) -- True
print(is_touching(-1,0,0,0)) -- True
print(is_touching(-1,1,0,0)) -- True
print(is_touching(0,2,0,0)) -- False
print(is_touching(1,2,0,0)) -- False
print(is_touching(2,2,0,0)) -- False
print(is_touching(2,1,0,0)) -- False
print(is_touching(2,0,0,0)) -- False
print(is_touching(2,-1,0,0)) -- False
print(is_touching(1,-2,0,0)) -- False
print(is_touching(0,-2,0,0)) -- False
print(is_touching(-1,-2,0,0)) -- False
print(is_touching(-2,-1,0,0)) -- False
print(is_touching(-2,0,0,0)) -- False
print(is_touching(-2,1,0,0)) -- False
print(is_touching(-1,2,0,0)) -- False

print(get_direction(2,1,0,0)) -- Right
print(get_direction(2,0,0,0)) -- Right
print(get_direction(2,-1,0,0)) -- Right
print(get_direction(1,-2,0,0)) -- Down
print(get_direction(0,-2,0,0)) -- Down
print(get_direction(-1,-2,0,0)) -- Down
print(get_direction(-2,-1,0,0)) -- Left
print(get_direction(-2,0,0,0)) -- Left
print(get_direction(-2,1,0,0)) -- Left
print(get_direction(-1,2,0,0)) -- Up
print(get_direction(0,2,0,0)) -- Up
print(get_direction(1,2,0,0)) -- Up
