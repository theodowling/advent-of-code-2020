defmodule AdventOfCode.Day04 do
  @required_params [
    :byr,
    :iyr,
    :eyr,
    :hgt,
    :hcl,
    :ecl,
    :pid,
  ]
  # @optional_params [
  #   :cid
  # ]

  @spec part1(binary) :: non_neg_integer
  def part1(input_path) do
    input_path
    |> chunck_and_trim_passports()
    |> Stream.map(&get_keys/1)
    |> Stream.filter(&!missing_keys(&1, @required_params))
    |> Enum.to_list()
    |> Enum.count()
  end

  @spec part2(binary) :: non_neg_integer
  def part2(input_path) do
    input_path
    |> chunck_and_trim_passports()
    |> Stream.map(&get_key_values/1)
    |> Stream.filter(&!has_missing_items(&1))
    |> Stream.map(&!Enum.any?(&1, fn x -> invalid_entry(x) end))
    |> Enum.count(&(&1 == true))
  end

  @spec chunck_and_trim_passports(binary) :: Stream.t()
  def chunck_and_trim_passports(input_path) do
    chunk_fun = fn element, acc ->
      if element == "" do
        {:cont, Enum.reverse([element | acc]), []}
      else
        {:cont, [element | acc]}
      end
    end

    after_fun = fn
      [] -> {:cont, []}
      acc -> {:cont, Enum.reverse(acc), []}
    end

    input_path
    |> File.stream!()
    |> Stream.map(&String.trim/1)
    |> Stream.chunk_while([], chunk_fun, after_fun)
    |> Stream.map(&Enum.join(&1, " "))
    |> Stream.map(&String.trim/1)
  end
  @spec get_keys(binary) :: MapSet.t(any)
  def get_keys(code) do
    code
    |> String.split(" ")
    |> Enum.map(fn x ->
      String.to_atom(binary_part(x, 0, 3))
    end)
    |> MapSet.new()
  end

  @spec get_key_values(binary) :: [binary]
  def get_key_values(code) do
    code
    |> String.split(" ")
  end

  @spec missing_keys(MapSet.t(any), [atom()]) :: boolean
  def missing_keys(a, required) do
    Enum.any?(required, fn x -> !MapSet.member?(a, x) end)
  end

  @spec has_missing_items([binary()], [atom()]) :: boolean
  def has_missing_items(item, required \\ @required_params) do
    mapset =
      item
      |> Enum.map(&String.to_atom(binary_part(&1, 0, 3)))
      |> MapSet.new()

    Enum.any?(required, &!MapSet.member?(mapset, &1))
  end

  @spec invalid_entry(binary()) :: boolean
  def invalid_entry(<<"byr:", value::binary>>) do
    date = String.to_integer(value)
    date < 1920 || date > 2002
  end

  def invalid_entry(<<"iyr:", value::binary>>) do
    date = String.to_integer(value)
    date < 2010 || date > 2020
  end

  def invalid_entry(<<"eyr:", value::binary>>) do
    date = String.to_integer(value)
    date < 2020 or date > 2030
  end

  def invalid_entry(<<"hgt:", value::binary>>) when binary_part(value, byte_size(value), -2) == "cm" do
    height = String.to_integer(binary_part(value, 0, byte_size(value) - 2))
    height > 193 or height < 150
  end

  def invalid_entry(<<"hgt:", value::binary>>) when binary_part(value, byte_size(value), -2) == "in" do
    height = String.to_integer(binary_part(value, 0, byte_size(value) - 2))
    height > 76 or height < 59
  end

  def invalid_entry(<<"hcl:#", value::binary-size(6)>>) do
    not Regex.match?(~r/^[0-9a-f]{6}$/, value)
  end

  def invalid_entry(<<"ecl:", value::binary-size(3)>>) when value in ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"] do
    false
  end

  def invalid_entry(<<"pid:", value::binary-size(9)>>) do
    not Regex.match?(~r/^[0-9]{9}$/, value)
  end

  def invalid_entry(<<"cid:", _value::binary>>) do
    false
  end

  def invalid_entry(_) do
    true
  end
end
