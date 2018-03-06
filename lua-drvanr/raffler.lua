local rand = math.random
local readline = io.lines
local filename = arg[1]
local lines,count,choosenOne = {},0,

-- seed the randomizer for at least some randomness ;)
math.randomseed(os.time())

for line in readline(filename) do
    count = count + 1
    lines[#lines+1] = line
end

choosenOne = rand(count)
print('We have a winner: ' .. lines[choosenOne])

