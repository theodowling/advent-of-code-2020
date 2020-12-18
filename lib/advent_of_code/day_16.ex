defmodule AdventOfCode.Day16 do
  def part1(input) do
    data =
      input
      |> File.read!()

    [rules_raw, tickets] = String.split(data, "\nyour ticket:\n", trim: true)
    rules = String.split(rules_raw, "\n", trim: true)

    ranges = interpret_rules(rules)
    [_mine, others] = String.split(tickets, "\nnearby tickets:\n", trim: true)
    other_tickets = String.split(others, "\n", trim: true)

    other_tickets
    |> check_ticket_for_invalid_items(ranges, [])
    |> Enum.sum()
  end

  def interpret_rules(rules) do
    interpret_rules(rules, [])
  end

  def interpret_rules([], acc), do: acc

  def interpret_rules([rule | rest], acc) do
    [_, a, b, c, d] =
      Regex.run(~r/:\s(?<a>\d{1,})-(?<b>\d{1,})\sor\s(?<c>\d{1,})-(?<d>\d{1,})$/, rule)

    acc = [
      Range.new(String.to_integer(a), String.to_integer(b)),
      Range.new(String.to_integer(c), String.to_integer(d)) | acc
    ]

    interpret_rules(rest, acc)
  end

  def interpret_rules_with_names([], acc), do: acc

  def interpret_rules_with_names([rule | rest], acc) do
    [_, name, a, b, c, d] =
      Regex.run(
        ~r/^(?<name>.*):\s(?<a>\d{1,})-(?<b>\d{1,})\sor\s(?<c>\d{1,})-(?<d>\d{1,})$/,
        rule
      )

    acc = [
      {
        name,
        [
          Range.new(String.to_integer(a), String.to_integer(b)),
          Range.new(String.to_integer(c), String.to_integer(d))
        ]
      }
      | acc
    ]

    interpret_rules_with_names(rest, acc)
  end

  def check_ticket_for_invalid_items([], _ranges, invalid), do: invalid

  def check_ticket_for_invalid_items([ticket | rest], ranges, invalid) do
    invalid_numbers =
      ticket
      |> String.split(",", trim: true)
      |> Enum.map(&String.to_integer/1)
      |> Enum.filter(fn value ->
        !Enum.any?(ranges, &Kernel.in(value, &1))
      end)

    check_ticket_for_invalid_items(rest, ranges, List.flatten(invalid, invalid_numbers))
  end

  def get_valid_tickets([], _ranges, valid), do: valid

  def get_valid_tickets([ticket | rest], ranges, valid_tickets) do
    valid =
      ticket
      |> String.split(",", trim: true)
      |> Enum.map(&String.to_integer/1)
      |> Enum.all?(fn value ->
        Enum.any?(ranges, &Kernel.in(value, &1))
      end)

    if valid do
      get_valid_tickets(rest, ranges, [ticket | valid_tickets])
    else
      get_valid_tickets(rest, ranges, valid_tickets)
    end
  end

  def part2(input) do
    data =
      input
      |> File.read!()

    [rules_raw, tickets] = String.split(data, "\nyour ticket:\n", trim: true)
    rules = String.split(rules_raw, "\n", trim: true)

    ranges = interpret_rules(rules)
    [mine, others] = String.split(tickets, "\n\nnearby tickets:\n", trim: true)
    other_tickets = String.split(others, "\n", trim: true)

    columns =
      other_tickets
      |> get_valid_tickets(ranges, [])
      |> combine_columns(%{})

    ranges_with_names = interpret_rules_with_names(rules, [])

    valid_rules_for_columns =
      Enum.reduce(columns, %{}, fn {k, v}, acc ->
        valid_ranges =
          Enum.filter(ranges_with_names, fn {name, ranges} ->
            if Enum.all?(v, fn i -> Enum.any?(ranges, &Kernel.in(i, &1)) end) do
              name
            else
              false
            end
          end)

        Map.put(acc, k, valid_ranges)
      end)

    column_numbers_with_departure_in_rule =
      valid_rules_for_columns
      |> Enum.to_list()
      |> allocate_valid_rules_for_columns(%{})
      |> Enum.reduce([], fn {k, name}, acc -> if name =~ "departure", do: [k | acc], else: acc end)

    mine
    |> String.split(",", trim: true)
    |> Enum.map(&String.to_integer/1)
    |> Enum.with_index(1)
    |> Enum.filter(fn {_, i} -> i in column_numbers_with_departure_in_rule end)
    |> Enum.map(&elem(&1, 0))
    |> Math.Enum.product()
  end

  def allocate_valid_rules_for_columns([], acc), do: acc

  def allocate_valid_rules_for_columns([{k, v} = rule | rest], acc) do
    if length(v) == 1 do
      [{rule, _}] = v
      acc = Map.put(acc, k, rule)

      rest =
        Enum.map(rest, fn {k, rules} ->
          {k, rules |> Enum.filter(fn {name, _} -> name != rule end)}
        end)

      allocate_valid_rules_for_columns(rest, acc)
    else
      allocate_valid_rules_for_columns(rest ++ [rule], acc)
    end
  end

  def combine_columns([], acc), do: acc

  def combine_columns([ticket | rest], acc) do
    column_values =
      ticket
      |> String.split(",", trim: true)
      |> Enum.map(&String.to_integer/1)
      |> Enum.with_index(1)
      |> Enum.reduce(acc, fn {v, i}, acc ->
        Map.update(acc, i, [v], &[v | &1])
      end)

    combine_columns(rest, column_values)
  end
end
