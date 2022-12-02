--[[
    X = Loose
    Y = Draw
    Z = Win
]]
local points = {
    -- OUTCOMES --
    ["Win"] = 6,
    ["Draw"] = 3,
    ["Loss"] = 0,
    -- POINTS --
    ["Rock"] = 1,
    ["Paper"] = 2,
    ["Scissors"] = 3,
    -- CONVERSIONS --
    ["X"] = "Loss",
    ["Y"] = "Draw",
    ["Z"] = "Win",
    -- OPPONENT --
    ["A"] = "Rock",
    ["B"] = "Paper",
    ["C"] = "Scissors",
}

-- Calculate the winner of a round
local getResponse = function (Opponent, WinLoss)
    if WinLoss == "Win" then
        if Opponent == "Rock" then
            return "Paper"
        elseif Opponent == "Paper" then
            return "Scissors"
        elseif Opponent == "Scissors" then
            return "Rock"
        end
    elseif WinLoss == "Draw" then
        return Opponent
    elseif WinLoss == "Loss" then
        if Opponent == "Rock" then
            return "Scissors"
        elseif Opponent == "Paper" then
            return "Rock"
        elseif Opponent == "Scissors" then
            return "Paper"
        end
    end
end

local file = assert(io.open("D:\\AoC22\\Advent-of-Code-2022\\AoC22\\Day2\\input.txt", "r"),"File failed to read")
local tallyPoints = function()
    local Tpoints = 0
    for line in file:lines() do
        local opponent = string.match(line,"[A-C]")
        local you = string.match(line,"[X-Z]")
        local response = getResponse(points[opponent], points[you])
        Tpoints = Tpoints + points[response] + points[points[you]]
    end
    return Tpoints
end
print(tallyPoints())