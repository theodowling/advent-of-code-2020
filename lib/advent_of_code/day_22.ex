defmodule AdventOfCode.Day22 do
  def part1(input) do
    [player_a, player_b] =
      input
      |> File.read!()
      |> String.split("\n\n")

    a_hand = player_a |> String.split("\n") |> Enum.drop(1) |> Enum.map(&String.to_integer/1)
    b_hand = player_b |> String.split("\n") |> Enum.drop(1) |> Enum.map(&String.to_integer/1)

    {a_hand, b_hand}

    winning_hand = play_until_win(a_hand, b_hand)
    get_value(winning_hand)
  end

  def play_until_win(a_hand, b_hand) when length(a_hand) == 0, do: b_hand
  def play_until_win(a_hand, b_hand) when length(b_hand) == 0, do: a_hand

  def play_until_win([a | rest_a], [b | rest_b]) when a > b,
    do: play_until_win(rest_a ++ [a, b], rest_b)

  def play_until_win([a | rest_a], [b | rest_b]) when a < b,
    do: play_until_win(rest_a, rest_b ++ [b, a])

  def get_value(winning_hand) do
    winning_hand
    |> Enum.reverse()
    |> Enum.with_index(1)
    |> Enum.map(fn {k, v} -> k * v end)
    |> Enum.sum()
  end

  def part2(input) do
    [player_a, player_b] =
      input
      |> File.read!()
      |> String.split("\n\n")

    a_hand = player_a |> String.split("\n") |> Enum.drop(1) |> Enum.map(&String.to_integer/1)
    b_hand = player_b |> String.split("\n") |> Enum.drop(1) |> Enum.map(&String.to_integer/1)

    {a_hand, b_hand}

    {_winner, winning_hand} = recursively_play_until_win(a_hand, b_hand, MapSet.new())
    get_value(winning_hand)
  end

  def recursively_play_until_win(a_hand, b_hand, _) when length(a_hand) == 0, do: {:b, b_hand}
  def recursively_play_until_win(a_hand, b_hand, _) when length(b_hand) == 0, do: {:a, a_hand}

  def recursively_play_until_win([a | rest_a], [b | rest_b], original_state)
      when a <= length(rest_a) and b <= length(rest_b) do
    case recursively_play_until_win(Enum.take(rest_a, a), Enum.take(rest_b, b), MapSet.new()) do
      {:a, _} ->
        recursively_play_until_win(rest_a ++ [a, b], rest_b, original_state)

      {:b, _} ->
        recursively_play_until_win(rest_a, rest_b ++ [b, a], original_state)
    end
  end

  def recursively_play_until_win([a | rest_a], [b | rest_b], state) when a > b do
    if MapSet.member?(state, {[a | rest_a], [b | rest_b]}) do
      {:a, [a | rest_a]}
    else
      recursively_play_until_win(
        rest_a ++ [a, b],
        rest_b,
        MapSet.put(state, {[a | rest_a], [b | rest_b]})
      )
    end
  end

  def recursively_play_until_win([a | rest_a], [b | rest_b], state) when a < b do
    if MapSet.member?(state, {[a | rest_a], [b | rest_b]}) do
      {:a, [a | rest_a]}
    else
      recursively_play_until_win(
        rest_a,
        rest_b ++ [b, a],
        MapSet.put(state, {[a | rest_a], [b | rest_b]})
      )
    end
  end
end
