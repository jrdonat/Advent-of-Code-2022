-- Read file
local inputfile = assert(io.open("D:\\AoC22\\Advent-of-Code-2022\\AoC22\\Day7\\input.txt", "r"), "File failed to read")


-- Define a metatable for directories
local dir_mt = {
    -- Define an __index metamethod to simulate directory listing
    __index = function(t, k)
        -- Check if the key exists in the table
        if rawget(t, k) == nil then
            -- If the key doesn't exist, return an error message
            return nil
        end
        -- Return the value of the key (the file or subdirectory)
        return t[k]
    end,

    -- Define a __newindex metamethod to simulate file creation
    __newindex = function(t, k, v)
        -- Check if the key already exists in the table
        if rawget(t, k) ~= nil then
            -- If the key exists, return an error message
            error(k .. ": File already exists")
        end
        -- Set the value of the key (the file or subdirectory)
        rawset(t, k, v)
    end
}

-- Define a function to create a new directory
local function new_dir(name, parent)
    -- Create a new table for the directory
    local dir = {name = name, parent = parent}
    -- Set the metatable for the directory
    setmetatable(dir, dir_mt)
    -- Return the directory table
    return dir
end


-- Create the root directory
local root = new_dir("/")

local curr_dir = root

-- Define a function to create a new file
local function new_file(name, size)
    -- Create a new table for the file
    local file = {name = name, size = size}
    -- Return the file table
    return file
end

-- Define a function to insert a file into the current directory
local function insert_file(name, size)
    -- Create a new file
    local file = new_file(name, size)
    -- Add the file to the current directory
    curr_dir[name] = file
end

-- Loop through each line
for line in inputfile:lines() do
    -- Commands start with $. Check for if line is a command
    if line:sub(1, 1) == "$" then
        line = line:gsub("%s", "", 1)
        -- Split the line into a table
        local split_line = {}
        for word in line:gmatch("%S+") do
            table.insert(split_line, word)
        end
        if split_line[1] == "$cd" then
            -- If the command is "cd", change the current directory
            if split_line[2] == "/" then
                -- If the argument is "/", change to the root directory
                curr_dir = root
            elseif split_line[2] == ".." then
                -- If the argument is "..", move to the parent directory
                curr_dir = curr_dir.parent
            else
                -- Otherwise, change to the specified directory
                if curr_dir[split_line[2]] == nil then
                    curr_dir[split_line[2]] = new_dir(split_line[2], curr_dir)
                end
                curr_dir = curr_dir[split_line[2]]
            end
        end
    else
        local lineSplit = {}
        for word in line:gmatch("%S+") do
            table.insert(lineSplit, word)
        end

        if lineSplit[1] ~= "dir" then
            insert_file(lineSplit[2],lineSplit[1])
        end
        -- Ignoring listed directories, they'll be goten to later in the loop
    end
end

-- Print the sum of all directories which each directory holds less than 100000 in file sizes
-- Define a function to calculate the total size of a directory
local function dir_size(dir)
    -- Define a variable to store the total size
    local size = 0

    -- Iterate over the files and subdirectories in the directory
    for _, file in pairs(dir) do
        if type(file) == "table" then
            if file.parent == dir then
                -- If the current value is a subdirectory, calculate its size recursively
                size = size + dir_size(file)
            else
                -- If the current value is a file, add its size to the total
                if file.size then
                    size = size + file.size
                end
            end
        end
    end
    -- Return the total size
    return size
end

-- Too keep me from recalculating everything
local rootSize = dir_size(root)
--print("Space availiable: " .. 70000000 - dir_size(root).."\nBytes required to be deleted: "..30000000-(70000000 - dir_size(root)))
local bestCandidate = {{rootSize,root}}
-- Recursively loop through all directories

local function loop_dir(dir)
    -- Iterate over the files and subdirectories in the directory
    for _, file in pairs(dir) do
        if type(file) == "table" then
            if file.parent == dir and not file.size then
                -- If the current value is a subdirectory, calculate its size recursively
                local tempSize = dir_size(file)
                if tempSize >= 30000000-(70000000 - rootSize) and tempSize <= bestCandidate[1][1] then
                    bestCandidate = {{tempSize,file.name}}
                end
                loop_dir(file)
            end
        end
    end
end
loop_dir(root)
print(bestCandidate[1][2])
inputfile:close()