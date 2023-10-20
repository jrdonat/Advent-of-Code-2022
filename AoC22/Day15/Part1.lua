local inputFile = assert(io.open("D:\\AoC22\\Advent-of-Code-2022\\AoC22\\Day15\\input.txt", "r"), "File failed to read")
local output_line = {}


local function manhattan_dist(sensor_x,sensor_y,beacon_x,beacon_y)
    return math.abs(sensor_x-beacon_x)+math.abs(sensor_y-beacon_y)
end

for line in inputFile:lines() do
    local _, _, sensor_x,sensor_y,beacon_x,beacon_y = line:find("Sensor at x=(%-?%d+), y=(%-?%d+): closest beacon is at x=(%-?%d+), y=(%-?%d+)")
    sensor_x,sensor_y,beacon_x,beacon_y=tonumber(sensor_x),tonumber(sensor_y),tonumber(beacon_x),tonumber(beacon_y)
    local distance=manhattan_dist(sensor_x,sensor_y,beacon_x,beacon_y)
    local dx=distance-math.abs(sensor_y-2000000)
    for i = -dx,dx-1 do
        output_line[sensor_x+i]=true
    end
end

local counter = 0
for _, v in pairs(output_line) do
    if v then counter = counter + 1 end
end
print(counter)