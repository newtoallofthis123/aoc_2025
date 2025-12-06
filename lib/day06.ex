defmodule Aoc2025.Day06 do
  @moduledoc """
  Advent of Code 2025 - Day 6
  """

  @behaviour Aoc2025.Day

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
    |> Enum.reverse()
  end

  defp parse_line(line) do
    line |> String.split(" ") |> Enum.reject(&(&1 == ""))
  end

  defp parse_line_to_integers(line) do
    parse_line(line) |> Enum.map(&String.to_integer/1)
  end

  defp solve_part1([ops | num_lines]) do
    {ops, num_lines} =
      {parse_line(ops),
       Enum.reduce(num_lines, [], fn x, acc -> [parse_line_to_integers(x) | acc] end)}

    d =
      ops
      |> Enum.with_index()
      |> Enum.reduce([], fn {op, idx}, acc ->
        nums = Enum.reduce(num_lines, [], fn x, acc -> [Enum.at(x, idx) | acc] end)

        [operate(nums, op) | acc]
      end)

    IO.inspect(d)

    Enum.sum(d)
  end

  defp operate(nums, "*") do
    nums |> Enum.reduce(1, fn x, acc -> acc * x end)
  end

  defp operate(nums, "+") do
    nums |> Enum.reduce(0, fn x, acc -> acc + x end)
  end

  def transpose_digits(nums) do
    rows =
      nums
      |> Enum.map(fn n ->
        n
        |> Integer.to_string()
        |> String.graphemes()
      end)

    max_len =
      rows
      |> Enum.map(&length/1)
      |> Enum.max()

    for i <- 0..(max_len - 1) do
      rows
      |> Enum.reduce([], fn row, acc ->
        case Enum.at(row, i) do
          nil -> acc
          d -> [d | acc]
        end
      end)
      |> Enum.reverse()
      |> Enum.join()
      |> String.to_integer()
    end
  end

  defp solve_part2([ops | num_lines]) do
    {ops, num_lines} =
      {parse_line(ops),
       Enum.reverse(num_lines)
       |> Enum.reduce([], fn x, acc -> [parse_line_to_integers(x) | acc] end)}

    num_lines =
      Enum.reduce(0..length(num_lines), [], fn idx, acc ->
        [Enum.reduce(num_lines, [], fn x, acc1 -> [Enum.at(x, idx) | acc1] end) | acc]
      end)

    num_lines = Enum.map(num_lines, &transpose_digits/1)
    ops = Enum.reverse(ops)

    IO.inspect(num_lines)
    IO.inspect(ops)

    d =
      ops
      |> Enum.with_index()
      |> Enum.reduce([], fn {op, idx}, acc ->
        nums = Enum.at(num_lines, idx)

        [operate(nums, op) | acc]
      end)

    IO.inspect(d)

    Enum.sum(d)
  end
end
