defmodule AdventOfCode.Day19 do
  def part1(input) do
    [rules, lines] =
      input
      |> String.split("\n\n")

    [r] =
      rules
      |> String.split("\n", trim: true)
      |> Enum.map(fn line -> String.split(line, ": ") end)
      |> parse_rules()
      |> Map.get(0)

    regex = ("^" <> flatten_rule(r, "") <> "$") |> Regex.compile!()

    lines
    |> String.split("\n", trim: true)
    |> Enum.count(fn line -> check_line(regex, line) end)
  end

  def flatten_rule([], acc), do: acc

  def flatten_rule([r | rest], acc) when is_binary(r) do
    flatten_rule(rest, acc <> r)
  end

  def flatten_rule([r | rest], acc) when is_list(r) do
    flatten_rule(rest, acc <> "(" <> Enum.join(Enum.map(r, &flatten_rule(&1, "")), "|") <> ")")
  end

  def parse_rules(rules) do
    [a_s, _] = Enum.find(rules, fn [_, a] -> a == "\"a\"" end)
    [b_s, _] = Enum.find(rules, fn [_, b] -> b == "\"b\"" end)

    a_n = String.to_integer(a_s)
    b_n = String.to_integer(b_s)

    acc = %{
      a_n => "a",
      b_n => "b"
    }

    rules
    |> Enum.map(fn [k, a] ->
      {String.to_integer(k), a}
    end)
    |> Enum.filter(&(not (elem(&1, 0) in [a_n, b_n])))
    |> parse_rules(acc)
  end

  def parse_rules([], acc), do: acc

  def parse_rules([rule | rest], acc) do
    m =
      rule
      |> elem(1)
      |> String.split(" | ")

    matches =
      for i <- m do
        i
        |> String.split(" ")
        |> Enum.all?(&Map.has_key?(acc, String.to_integer(&1)))
      end
      |> Enum.all?()

    if matches do
      v =
        for i <- m do
          i
          |> String.split(" ")
          |> Enum.map(&Map.get(acc, String.to_integer(&1)))
        end

      parse_rules(rest, Map.put(acc, elem(rule, 0), v))
    else
      parse_rules(rest ++ [rule], acc)
    end
  end

  def check_line(rule, line) do
    Regex.match?(rule, line)
  end

  # 8: 42 | 42 8
  # 11: 42 31 | 42 11 31
  # 42 42 31 31

  def part2(input) do
    [rules, lines] =
      input
      |> String.split("\n\n")

    rules =
      rules
      |> String.split("\n", trim: true)
      |> Enum.map(fn line -> String.split(line, ": ") end)
      |> parse_rules()

    [r] = Map.get(rules, 0)
    [r8] = Map.get(rules, 8)
    [r11] = Map.get(rules, 11)
    rule8 = flatten_rule(r8, "")
    rule11 = flatten_rule(r11, "")

    rest11 = String.replace(rule11, rule8, "")

    for i <- 1..5 do
      rule =
        flatten_rule(r, "")
        |> String.replace(rule11, "rule11")
        |> String.replace(rule8, "(#{rule8}){1,}")
        |> String.replace("rule11", "(#{rule8}){#{i}}(#{rest11}){#{i}}")

      regex = "^" <> rule <> "$"

      lines
      |> String.split("\n", trim: true)
      |> Enum.count(fn line -> check_line(Regex.compile!(regex), line) end)
    end
    |> Enum.sum()
  end
end
