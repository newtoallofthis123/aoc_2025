defmodule Aoc2025.Day01 do
  @moduledoc """
  Advent of Code 2025 - Day 1
  """

  @behaviour Aoc2025.Day

  @start_idx 50
  @max_numbers 99

  @impl true
  def run(input) do
    IO.puts("Part 1: #{part1(input)}")
    IO.puts("Part 2: #{part2(input)}")
  end

  @impl true
  def part1(input) do
    input
    |> parse()
    |> solve_part1()
  end

  @impl true
  def part2(input) do
    input
    |> parse()
    |> solve_part2()
  end

  defp parse(input) do
    input
    |> String.trim()
    |> String.split("\n")
  end

  defp solve_part1(data) do
    {idx, zeros} = solve_part1(data, @start_idx, 0)

    IO.puts("Final IDX: #{idx}, Zeroes #{zeros}")

    zeros
  end

  defp solve_part1([], idx, zeros) do
    {idx, zeros}
  end

  defp solve_part1(data, idx, zeros) do
    [curr | data] = data

    {dir, num} = parse_code(curr)

    res = Integer.mod(idx + dir * num, @max_numbers + 1)

    zero_add = if res == 0, do: 1, else: 0

    IO.puts("Curr: #{curr}, Idx: #{idx}, Dir: #{dir}, res: #{res}")

    solve_part1(data, res, zeros + zero_add)
  end

  defp parse_dir(dir) do
    case dir do
      "L" -> -1
      "R" -> 1
    end
  end

  defp parse_code(code) do
    f = String.first(code) |> parse_dir()
    {num, _} = String.slice(code, 1..10) |> Integer.parse()

    {f, num}
  end

  defp solve_part2(data) do
    {idx, zeros} = solve_part2(data, @start_idx, 0)

    IO.puts("Final IDX: #{idx}, Zeroes #{zeros}")

    zeros
  end

  defp solve_part2([], idx, zeros) do
    {idx, zeros}
  end

  defp solve_part2(data, idx, zeros) do
    [curr | data] = data

    {dir, num} = parse_code(curr)

    res = Integer.mod(idx + dir * num, @max_numbers + 1)

    m = @max_numbers + 1

    zero_add =
      cond do
        num == 0 ->
          0

        dir == 1 ->
          if idx == 0 do
            div(num, m)
          else
            first = m - idx
            if num < first, do: 0, else: 1 + div(num - first, m)
          end

        dir == -1 ->
          if idx == 0 do
            div(num, m)
          else
            if num < idx, do: 0, else: 1 + div(num - idx, m)
          end
      end

    IO.puts("Curr: #{curr}, Idx: #{idx}, Dir: #{dir}, res: #{res}, Zeroes: #{zeros}, #{zero_add}")

    solve_part2(data, res, zeros + zero_add)
  end

  #
  # defp calculate_mod(num, mod_max, zeros \\ 0) do
  #   cond do
  #     num == 0 ->
  #       {num, zeros + 1}
  #
  #     num < 0 ->
  #       calculate_mod(num + mod_max, mod_max, zeros + 1)
  #
  #     num >= mod_max ->
  #       calculate_mod(num - mod_max, mod_max, zeros + 1)
  #
  #     true ->
  #       {num, zeros}
  #   end
  # end
end
