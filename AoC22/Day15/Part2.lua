local inputFile = assert(io.open("D:\\AoC22\\Advent-of-Code-2022\\AoC22\\Day15\\input.txt", "r"), "File failed to read")
local sensor_ranges = {}
local startTime = os.time()
local function manhattan_dist(sensor_x, sensor_y, beacon_x, beacon_y)
    return math.abs(sensor_x - beacon_x) + math.abs(sensor_y - beacon_y)
end

for line in inputFile:lines() do
    local _, _, sensor_x, sensor_y, beacon_x, beacon_y = line:find("Sensor at x=(%-?%d+), y=(%-?%d+): closest beacon is at x=(%-?%d+), y=(%-?%d+)")
    sensor_x, sensor_y, beacon_x, beacon_y = tonumber(sensor_x), tonumber(sensor_y), tonumber(beacon_x), tonumber(beacon_y)
    local distance = manhattan_dist(sensor_x, sensor_y, beacon_x, beacon_y)
    table.insert(sensor_ranges, { sensor_x, sensor_y, distance })
end

-- Sort sensors by smallest X value to greatest
table.sort(sensor_ranges, function(a, b) return a[1] < b[1] end)

local function circle_intersection_length(v, y)
    local h = v[1] -- x-coordinate of the center of the circle
    local k = v[2] -- y-coordinate of the center of the circle
    local r = v[3] -- radius of the circle in Manhattan distance

    -- Check if the distance between the Y coordinate and the center of the circle is greater than the radius of the circle
    local absYK = math.abs(y - k) -- To prevent running more math. functions

    -- Calculate the points where the circle intersects the X axis
    local tbl = { h - (r - absYK), h + (r - absYK) }
    --table.sort(tbl)
    return tbl
end

local endPointP1 = 0
-- Function to check if a line is solid and contiguous
local function is_solid_line(segments, left_limit, right_limit)
    -- Sort the segments by their left endpoints
    table.sort(segments, function(a, b) return a[1] < b[1] end)

    -- I could remove any segments that fully covert the other, but I feel like that'd lead to more loops

    local endPoint = left_limit
    if segments[1][1] > left_limit then
        endPointP1 = 0
        return false
    end
    for _, v in ipairs(segments) do
        if v[1] > endPoint+1 then
            endPointP1 = v[1] - 1
            return false
        else
            endPoint = math.max(endPoint, v[2])
        end
    end
    if endPoint < right_limit then
        endPointP1 = right_limit - 1
        return false
    end
    return true
end

for y = 0, 4000000 do

    local tbl2 = {}
    for _, v in ipairs(sensor_ranges) do
        if math.abs(y-v[2]) <= v[3] then
            local tbl = circle_intersection_length(v, y)
            if #tbl ~= 0 then
                table.insert(tbl2, tbl)
            end
        end
    end
    if not is_solid_line(tbl2,0,4000000) then
        print(endPointP1*4000000+y)
        break
    end
end
-- Print end time
print("Time taken: " .. os.time() - startTime .. " seconds")