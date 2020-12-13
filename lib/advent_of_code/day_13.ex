defmodule AdventOfCode.Day13 do
  def part1(input) do
    [time, busses, ""] =
      input
      |> String.split("\n")

    timestamp = String.to_integer(time)

    {id, first_time} =
      busses
      |> String.split(",", trim: true)
      |> Enum.map(&get_closest_time(timestamp, &1))
      |> Enum.min_by(fn {_k, v} -> v end)

    (first_time - timestamp) * id
  end

  def get_closest_time(_timestamp, "x") do
    {"x", nil}
  end

  def get_closest_time(timestamp, id) do
    bus_time = String.to_integer(id)

    a = div(timestamp, bus_time)
    {bus_time, (a + 1) * bus_time}
  end

  def part2(input) do
    [_time, busses, ""] =
      input
      |> String.split("\n")

    busses_with_delays =
      busses
      |> String.split(",", trim: true)
      |> Enum.with_index()
      |> Enum.filter(fn {id, _i} -> id != "x" end)
      |> Enum.map(fn {id, i} -> {i, String.to_integer(id)} end)

    # my cheat -> putting this output into wolframalpha
    # making false for now, to avoid noise in my test outputs
    if false do
      IO.puts(
        busses_with_delays
        |> Enum.map(&"(x + #{elem(&1, 0)}) mod #{elem(&1, 1)} = 0")
        |> Enum.join("\n")
      )

      [{delay, time} | other_busses] = slowest_bus(busses_with_delays)

      -delay
      |> Stream.iterate(&(&1 + time))
      |> Enum.find(&compare_with_other_busses(&1, other_busses))
    end

    # but then I read up on chinese remainder theorem
    n_collection = Enum.map(busses_with_delays, fn {_, n} -> n end)
    bigN = Math.Enum.product(n_collection)

    x =
      for {bi, m} <- busses_with_delays do
        ni = div(bigN, m)
        xi = Math.mod_inv!(ni, m)
        bi * xi * ni
      end
      |> Enum.sum()
      |> Kernel.rem(bigN)

    bigN - x
  end

  def compare_with_other_busses(time, others) do
    if time > 10_000_000_000 do
      raise("This is going to take a very long time")
    end

    Enum.all?(others, fn {delay, route_time} ->
      rem(time + delay, route_time) == 0
    end)
  end

  def slowest_bus(busses) do
    Enum.sort_by(busses, fn {_, v} -> v end)
    |> Enum.reverse()
  end
end
