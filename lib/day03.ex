defmodule Aoc2025.Day03 do
  @moduledoc """
  Advent of Code 2025 - Day 3
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
    |> Enum.map(fn x ->
      x
      |> String.graphemes()
      |> Enum.map(fn a ->
        String.trim(a) |> String.to_integer()
      end)
    end)
  end

  defp solve_part1(data) do
    Enum.reduce(data, [], fn x, acc ->
      n = solve_bank(x)

      IO.puts("Max Bank: #{n}")

      [n | acc]
    end)
    |> Enum.sum()
  end

  defp solve_bank(bank) do
    max_val =
      if length(bank) > 2 do
        Enum.slice(bank, 0..1) |> Integer.undigits()
      else
        Enum.at(bank, 0)
      end

    solve_bank(bank, max_val)
  end

  defp solve_bank([], max) do
    max
  end

  defp solve_bank([curr | bank], max) do
    max_digit = num_in_place(max, 10)

    # IO.puts("#{curr}, #{max}: #{max_digit}")
    # IO.inspect(bank, as: :charlist)

    if curr >= max_digit do
      new_max =
        [
          max
          | Enum.map(bank, fn x ->
              "#{curr}#{x}" |> String.to_integer()
            end)
        ]
        |> Enum.max()

      solve_bank(bank, new_max)
    else
      solve_bank(bank, max)
    end
  end

  def num_in_place(num, place) do
    div(num, place) |> rem(place)
  end

  defp solve_part2(data) do
    IO.inspect(data)

    0
  end
end
