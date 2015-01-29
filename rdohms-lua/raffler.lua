-- raffler.lua

function readFromFile(file)
    local file = io.open(file, "r");
    local arr = {}

    for line in file:lines() do
        table.insert (arr, line);
    end

    io.close(file)

    return arr
end

math.randomseed (os.time())

local participants = readFromFile("participants.txt")
local winningEntry = math.random(1, #participants)

print("The Winner is " .. participants[winningEntry])
