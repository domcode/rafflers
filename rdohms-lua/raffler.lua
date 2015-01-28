-- raffler.lua

function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

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
local winningEntry = math.random(0, tablelength(participants))

print("The Winner is" .. participants[winningEntry])
