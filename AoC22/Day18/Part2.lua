local inputFile = assert(io.open("AoC22\\Day18\\input.txt", "r"),"File failed to read")
local blocks = {}
local total = 0
local approxCenter = {}
-- function math.sign(x)
--     if x > 0 then
--         return 1
--     elseif x < 0 then
--         return -1
--     else
--         return 0
--     end
-- end

for line in inputFile:lines() do
    blocks[line] = true
    total = total + 6
end

local counterBlocks = {}

local function findApproximateCenter(inputblocks)
    local xSum, ySum, zSum = 0, 0, 0
    local count = 0
    for i, v in pairs(inputblocks) do
        local x, y, z = i:match("(%d+),(%d+),(%d+)")
        x, y, z = tonumber(x), tonumber(y), tonumber(z)
        xSum = xSum + x
        ySum = ySum + y
        zSum = zSum + z
        count = count + 1
    end
    local xCenter, yCenter, zCenter = xSum / count, ySum / count, zSum / count
    return {math.floor(xCenter + 0.5), math.floor(yCenter + 0.5), math.floor(zCenter + 0.5)}
end

approxCenter = findApproximateCenter(blocks)

local function move_towards_target(target_x, target_y, target_z, block_x, block_y, block_z)
	-- Calculate the distance from the block to the target in each dimension
	local dx = target_x - block_x
	local dy = target_y - block_y
	local dz = target_z - block_z

	-- If the block is already at the target position, return the current position
	if dx == 0 and dy == 0 and dz == 0 then
		return block_x, block_y, block_z
	end

	-- Find the dimension with the greatest distance
	local max_dimension
	local max_distance = math.max(math.abs(dx), math.abs(dy), math.abs(dz))

	if math.abs(dx) == max_distance then
		max_dimension = "x"
	elseif math.abs(dy) == max_distance then
		max_dimension = "y"
	else
		max_dimension = "z"
	end

	-- Move one unit in the direction of the target in the dimension with the greatest distance
	if max_dimension == "x" then
		block_x = block_x + math.sign(dx)
	elseif max_dimension == "y" then
		block_y = block_y + math.sign(dy)
	else
		block_z = block_z + math.sign(dz)
	end

	-- Return the new position of the block
	return block_x, block_y, block_z
end

-- Add a square to each block one unit inwards towards approxCenter. Do not move diagonally
local function fillSphere(inputBlocks)
    local new_blocks = {}
    for i, v in pairs(inputBlocks) do
        local x, y, z = i:match("(%d+),(%d+),(%d+)")
        x, y, z = tonumber(x), tonumber(y), tonumber(z)
        local new_x, new_y, new_z = move_towards_target(approxCenter[1], approxCenter[2], approxCenter[3], x, y, z)
        new_blocks[tostring(new_x)..","..tostring(new_y)..","..tostring(new_z)] = true
    end
    for i, v in pairs(new_blocks) do
        counterBlocks[i] = true
    end
end



local function checkFor3DAdjacents(coords)
    local x, y, z = coords:match("(%d+),(%d+),(%d+)")
    x, y, z = tonumber(x), tonumber(y), tonumber(z)
    local adjacents = {
        {x-1, y, z},
        {x+1, y, z},
        {x, y-1, z},
        {x, y+1, z},
        {x, y, z-1},
        {x, y, z+1}
    }
    local count = 0
    for _, v in ipairs(adjacents) do
        if counterBlocks[tostring(v[1])..","..tostring(v[2])..","..tostring(v[3])] then
            count = count + 1
        end
    end
    total = total - (count)
end
fillSphere(blocks)
for i, v in pairs(blocks) do
    checkFor3DAdjacents(i)
end
print(total)
local outputFile = assert(io.open("AoC22\\Day18\\output.txt", "w+"),"File failed to write")
for i, v in pairs(counterBlocks) do
    outputFile:write("\\n"..i.."\n")
end
outputFile:close()