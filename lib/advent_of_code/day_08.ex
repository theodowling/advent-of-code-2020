defmodule AdventOfCode.Day08 do
  def part1(input) do
    program =
      input
      |> File.stream!()
      |> Stream.map(&String.trim/1)
      |> Stream.with_index()
      |> Stream.map(fn {k, v} -> {v, action_and_value(k)} end)
      |> Enum.into(%{})

    run_till_repeat(program, 0, 0, MapSet.new())
  end

  def part2(input) do
    program =
      input
      |> File.stream!()
      |> Stream.map(&String.trim/1)
      |> Stream.with_index()
      |> Stream.map(fn {k, v} -> {v, action_and_value(k)} end)
      |> Enum.into(%{})

    {nop_positions, jmp_positions} =
      Enum.reduce(program, {[], []}, fn {k, {s, _}}, {nop, jmp} ->
        case s do
          :nop -> {[k | nop], jmp}
          :jmp -> {nop, [k | jmp]}
          _ -> {nop, jmp}
        end
      end)

    Enum.find_value(nop_positions, fn nop ->
      valid_program?(update_program_op(program, nop, :jmp))
    end)

    Enum.find_value(jmp_positions, fn jmp ->
      valid_program?(update_program_op(program, jmp, :nop))
    end)
  end

  def update_program_op(program, pos, new_operation) do
    {_k, v} = program[pos]
    Map.put(program, pos, {new_operation, v})
  end

  def run_till_repeat(program, pos, acc, steps) do
    action = program[pos]

    # check if repeated step
    if MapSet.member?(steps, pos) do
      acc
    else
      steps = MapSet.put(steps, pos)

      case action do
        {:jmp, v} ->
          run_till_repeat(program, pos + v, acc, steps)

        {:acc, v} ->
          run_till_repeat(program, pos + 1, acc + v, steps)

        {:nop, _} ->
          run_till_repeat(program, pos + 1, acc, steps)
      end
    end
  end

  def valid_program?(program, pos \\ 0, acc \\ 0, steps \\ %MapSet{})
  def valid_program?(program, pos, acc, _steps) when pos > map_size(program) - 1, do: acc

  def valid_program?(program, pos, acc, steps) do
    action = program[pos]

    # check if repeat step
    if MapSet.member?(steps, pos) do
      false
    else
      steps = MapSet.put(steps, pos)

      case action do
        {:jmp, v} ->
          valid_program?(program, pos + v, acc, steps)

        {:acc, v} ->
          valid_program?(program, pos + 1, acc + v, steps)

        {:nop, _} ->
          valid_program?(program, pos + 1, acc, steps)
      end
    end
  end

  def action_and_value(<<"jmp ", val::binary>>) do
    {:jmp, String.to_integer(val)}
  end

  def action_and_value(<<"acc ", val::binary>>) do
    {:acc, String.to_integer(val)}
  end

  def action_and_value(<<"nop ", val::binary>>) do
    {:nop, String.to_integer(val)}
  end
end
