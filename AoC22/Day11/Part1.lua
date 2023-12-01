-- Read input file
local inputfile = assert(io.open("D:\\AoC22\\Advent-of-Code-2022\\AoC22\\Day11\\input.txt", "r"), "File failed to read")
local monkeys = {}
local i = 0
-- EmptyLine
for line in inputfile:lines() do
    i = i + 1
    if i%7 == 2 then
        table.insert(monkeys, {0})
    end
    if i%7~=1 and i%7~=0 then
        table.insert(monkeys[#monkeys], line)
    end
end

-- Define the Monkey object
local Monkey = {}
local newmonkeys = {}

-- Create a new Monkey object
function Monkey:new(num,op,divider,inventory,throw_to_true,throw_to_false)
   local obj ={num = num, op = op, divider = divider, inventory = inventory, throw_to_true = throw_to_true+1, throw_to_false = throw_to_false+1,counter=0}
   self.__index = self
   return setmetatable(obj, self)
end

function Monkey:runOp(number)
    local mult = self.op[2]
    if self.op[2] == "old" or self.op[2] == nil then
        mult = number
    end
    if self.op[1] == "+" then
        return number + mult
    else
        return number * mult
    end
end

-- Give monkey an item
function Monkey:giveItem(item)
    table.insert(self.inventory, math.floor(item))
end

function Monkey:runTurn()
    for removeval, v in ipairs(self.inventory) do
        self.counter = self.counter + 1
        if self:runOp(v)/3%self.divider == 0 then
            newmonkeys[self.throw_to_true]:giveItem(self:runOp(v)/3)
        else
            newmonkeys[self.throw_to_false]:giveItem(self:runOp(v)/3)
        end
        table.remove(self.inventory, removeval)
    end
end

for iterator, v in ipairs(monkeys) do
    table.remove(v, 1)
    local inv = {}
    for match in v[1]:gmatch("[^%s]+") do
        table.insert(inv, tonumber(match:sub(1,#match-1)))
    end
    local matches = {}
    for match in v[2]:gmatch("[^%s]+") do
        table.insert(matches, match)
    end
    print("Monkey_"..iterator-1, matches[5], tonumber(matches[6]), tonumber(v[3]:sub(22)), inv[1], tonumber(v[4]:sub(30)), tonumber(v[5]:sub(31)))
    table.insert(newmonkeys,Monkey:new("Monkey_"..iterator-1, {matches[5], tonumber(matches[6])}, tonumber(v[3]:sub(22)), inv, tonumber(v[4]:sub(30)), tonumber(v[5]:sub(31))))
end

for _=1, 20 do
    for _, v in ipairs(newmonkeys) do
        v:runTurn()
    end
end

for _, v in ipairs(newmonkeys) do
    print(v.num, v.counter)
end