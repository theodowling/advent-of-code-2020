defmodule AdventOfCode.Utils do
  def parse_input_lines_to_list_of_integers(input) do
    input |> String.split("\n", trim: true) |> Enum.map(&String.to_integer/1)
  end

  def parse_input_lines_to_list(input) do
    input |> String.split("\n", trim: true)
  end
end
