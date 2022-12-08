-- Read input.txt
local inputfile = assert(io.open("D:\\AoC22\\Advent-of-Code-2022\\AoC22\\Day8\\input.txt", "r"), "File failed to read")
local contents = inputfile:read('*all')

-- Split the string into a list of lines
local lines = {}
for line in string.gmatch(contents, "[^\n]+") do
  table.insert(lines, line)
end

-- Create a 2D array to store the characters
local array = {}

-- Loop through each line and split it into a list of characters
for i, line in ipairs(lines) do
  array[i] = {}

  -- Split line into a table of characters
    local newLine = {}
    for character in string.gmatch(line, ".") do
      table.insert(newLine, character)
    end

  for j, character in ipairs(newLine) do
    array[i][j] = tonumber(character)
  end
end

-- Check if the array is a table and if it has the expected dimensions
print(#array,#array[1])
if type(array) == 'table' and #array == 99 and #array[1] == 99 then
  print('Array is initialized correctly')
else
  print('Array is not initialized correctly')
end

-- Print the array to check that it contains the expected data
print(array)

-- Initialize the counter
local counter = 0

-- Loop through each element in the square
for i = 1, #array do
  for j = 1, #array[i] do
    -- Get the current element
    local element = array[i][j]

    -- Initialize the counters for each direction
    local up, down, left, right = 0, 0, 0, 0

    -- Loop through the elements in the same row and column
    for row = 1, #array do
      for col = 1, #array[row] do
        -- Check if the element is in the same row or column as the current element and if it is larger than the current element

        if (row == i or col == j) then
          -- Check if the larger number is in the up direction
          if row < i and col == j then
            up = 1
          end
          -- Check if the larger number is in the down direction
          if row > i and col == j then
            down = 1
          end
          -- Check if the larger number is in the left direction
          if row == i and col < j then
            left = 1
          end
          -- Check if the larger number is in the right direction
          if row == i and col > j then
            right = 1
          end
        end
      end
    end

    -- Check if there is a larger number in each of the four directions
    if up == 1 and down == 1 and left == 1 and right == 1 then
      -- Increment the counter by 1
      counter = counter + 1
    end
  end
end

-- Print the number of elements with a larger number in the same row and column, and in all of the four directions
print(counter)

-- That is the number not visible, therefore subtract it from the total and we get the trees visible
print(99*99 - counter)