-- I realize I can make this more efficient, but i'm crunched for time rn
--[[ 
    Rock = A and X
    Paper = B and Y
    Scissors = C and Z
]]--
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
    ["X"] = "Rock",
    ["Y"] = "Paper",
    ["Z"] = "Scissors",
    ["A"] = "Rock",
    ["B"] = "Paper",
    ["C"] = "Scissors",
}

-- Calculate the winner of a round
local getWinner = function(opponent, you)
    if opponent == you then
        return "Draw"
    elseif opponent == "Rock" and you == "Paper" then
        return "Win"
    elseif opponent == "Rock" and you == "Scissors" then
        return "Loss"
    elseif opponent == "Paper" and you == "Rock" then
        return "Loss"
    elseif opponent == "Paper" and you == "Scissors" then
        return "Win"
    elseif opponent == "Scissors" and you == "Rock" then
        return "Win"
    elseif opponent == "Scissors" and you == "Paper" then
        return "Loss"
    end
end

local file = assert(io.open("D:\\AoC22\\Advent-of-Code-2022\\AoC22\\Day2\\input.txt", "r"),"File failed to read")
local tallyPoints = function()
    local Tpoints = 0
    for line in file:lines() do
        local opponent = string.match(line,"[A-C]")
        local you = string.match(line,"[X-Z]")
        local winner = getWinner(points[opponent], points[you])
        Tpoints = Tpoints + points[winner] + points[points[you]]
    end
    return Tpoints
end
print(tallyPoints())

-- I could probably represent each value as a number, and calculate winners etc... through arithmatic. Would take some more time to figure out. Same applies for Pt.2