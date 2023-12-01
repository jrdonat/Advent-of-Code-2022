-- grid = {}
-- S = nil
-- E = nil

-- local file = io.open('D:\\AoC22\\Advent-of-Code-2022\\AoC22\\Day12\\input.txt', 'r')

-- -- Read the contents of the file into a string
-- local contents = file:read()

-- -- Close the file
-- file:close()

-- -- Split the string into a list of lines by the newline character
-- local inputs = string.split(contents, '\n')

-- for x, line in ipairs(inputs) do
--     table.insert(grid, {})
--     for y, letter in ipairs(line) do
--         if letter == 'S' then
--             S = {x, y}
--             letter = 'a'
--         end
--         if letter == 'E' then
--             E = {x, y}
--             letter = 'z'
--         end
--         table.insert(grid[#grid], {height = string.byte(letter), score = 99999999999})
--     end
-- end

-- grid[E[1]][E[2]].score = 0
-- queue = {E}

-- while #queue > 0 do
--     local x, y = unpack(table.remove(queue, 1))
--     for dx, dy in { {0, 1}, {0, -1}, {1, 0}, {-1, 0} } do
--         local px = x + dx
--         local py = y + dy
--         if px < 0 or px >= #grid or py < 0 or py >= #grid[1] then
--             continue
--         end

--         if (grid[px][py].height+1) >= grid[x][y].height then
--             if grid[px][py].score > (grid[x][y].score+1) then
--                 grid[px][py].score = grid[x][y].score + 1
--                 table.insert(queue, {px, py})
--             end
--         end
        
--     end
-- end

