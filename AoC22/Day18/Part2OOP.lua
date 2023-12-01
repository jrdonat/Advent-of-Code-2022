-- Create math.sign function
function math.sign(x)
    if x > 0 then
        return 1
    elseif x < 0 then
        return -1
    else
        return 0
    end
end

-- Define the block class
local Block = {}
Block.__index = Block

-- Constructor for a new block
function Block:new(x, y, z)
    local block = {}
    setmetatable(block, Block)

    block.x = x
    block.y = y
    block.z = z

    return block
end

-- Convert the block to a string representation of its coordinates
function Block:__tostring()
    return tostring(self.x) .. "," .. tostring(self.y) .. "," .. tostring(self.z)
end

-- Move the block towards the target coordinates
function Block:moveTowards(targetX, targetY, targetZ)
    -- Calculate the distance from the block to the target in each dimension
    local dx = targetX - self.x
    local dy = targetY - self.y
    local dz = targetZ - self.z

    -- If the block is already at the target position, return the current position
    if dx == 0 and dy == 0 and dz == 0 then
        return self.x, self.y, self.z
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
        self.x = self.x + math.sign(dx)
    elseif max_dimension == "y" then
        self.y = self.y + math.sign(dy)
    else
        self.z = self.z + math.sign(dz)
    end

    -- Return the new position of the block
    return self.x, self.y, self.z
end

-- Define the BlockList class
local BlockList = {}
BlockList.__index = BlockList

-- Constructor for a new block list
function BlockList:new()
    local block_list = {}
    setmetatable(block_list, BlockList)

    block_list.blocks = {}
    block_list.total = 0
    block_list.approxCenter = {}

    return block_list
end

-- Add a block to the list
function BlockList:addBlock(block)
    self.blocks[tostring(block)] = block
    self.total = self.total + 6
end

-- Find the approximate center of the blocks in the list
function BlockList:findApproximateCenter()
    local xSum, ySum, zSum = 0, 0, 0
    local count = 0
    for _, block in pairs(self.blocks) do
        xSum = xSum + block.x
        ySum = ySum + block.y
        zSum = zSum + block.z
        count = count + 1
    end
    local xCenter, yCenter, zCenter = xSum / count, ySum / count, zSum / count
    self.approxCenter = {math.floor(xCenter + 0.5), math.floor(yCenter + 0.5), math.floor(zCenter + 0.5)}
end

-- Move all blocks towards the approximate center
function BlockList:moveTowardsCenter()
    local xCenter, yCenter, zCenter = table.unpack(self.approxCenter)
    for _, block in pairs(self.blocks) do
        block:moveTowards(xCenter, yCenter, zCenter)
    end
end

-- Return the number of blocks in the list
function BlockList:__len()
    return self.total
end

-- Return the number of blocks in the list
function BlockList:__tostring()
    return tostring(self.total)
end

local inputFile = assert(io.open("AoC22\\Day18\\input.txt", "r"),"File failed to read")

local blockList = BlockList:new()

-- Read the input file
for line in inputFile:lines() do
    -- Parse the line
    local x, y, z = line:match("(%d+),(%d+),(%d+)")

    -- Add the block to the list
    blockList:addBlock(Block:new(tonumber(x), tonumber(y), tonumber(z)))
end

-- Find the approximate center of the blocks
blockList:findApproximateCenter()

local outputFileOOP = assert(io.open("AoC22\\Day18\\outputOOP.txt", "w+"),"File failed to write")
-- Write all block positions to file
for _, block in pairs(blockList.blocks) do
    outputFileOOP:write("\\n"..tostring(block) .. "\n")
end
outputFileOOP:close()

-- Move the blocks towards the center
blockList:moveTowardsCenter()

local outputFileMoved = assert(io.open("AoC22\\Day18\\outputMoved.txt", "w+"),"File failed to write")
-- Write all block positions to file
for _, block in pairs(blockList.blocks) do
    outputFileMoved:write("\\n"..tostring(block) .. "\n")
end
outputFileMoved:close()