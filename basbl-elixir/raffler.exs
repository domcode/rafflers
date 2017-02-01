defmodule Raffler do
  def raffle do
    receive do
      {sender, %File.Stream{} = stream} ->
        send sender, {:ok, stream |> Enum.take_random(1) |> Enum.map(&String.trim/1)}
      _ -> :error
    end
  end
end

pid = spawn(Raffler, :raffle, [])
Process.send_after(self, :timedout, 1_000)
send pid, {self, File.stream!(System.argv)}

receive do
  {:ok, name} ->
    IO.puts "The winner is #{name}."
  :error ->
    IO.puts "Something terrible happened."
  :timedout ->
    Process.exit(pid, :kill)
    IO.puts "Raffle killed, took longer than a second."
end
