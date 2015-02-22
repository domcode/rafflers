:random.seed :erlang.now
IO.puts File.stream!(System.argv) |> Enum.shuffle |> Enum.at(0)
