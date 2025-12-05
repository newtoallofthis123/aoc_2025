defmodule Aoc2025.Day05 do
  @moduledoc """
  Advent of Code 2025 - Day 5
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
    |> String.split("\n\n")
  end

  defp solve_part1([fresh, ingredients]) do
    ingredients = String.split(ingredients, "\n") |> Enum.map(&String.to_integer/1)

    fresh_ingredients =
      String.split(fresh, "\n")
      |> Enum.map(fn x ->
        [start, last] = String.split(x, "-")
        {String.to_integer(start), String.to_integer(last)}
      end)

    n =
      Enum.reduce(ingredients, [], fn x, acc ->
        case find_any_less(fresh_ingredients, x) do
          nil -> acc
          ingr -> [ingr | acc]
        end
      end)

    IO.inspect(fresh_ingredients)
    IO.inspect(ingredients)

    length(n)
  end

  defp find_any_less(li, n) do
    li
    |> Enum.reduce(nil, fn {start, last}, acc ->
      if n >= start and n <= last, do: {start, last}, else: acc
    end)
  end

  defp solve_part2([fresh, _]) do
    # TODO
    fresh_ingredients =
      String.split(fresh, "\n")
      |> Enum.map(fn x ->
        [start, last] = String.split(x, "-")
        {String.to_integer(start), String.to_integer(last)}
      end)

    Enum.reduce(fresh_ingredients, 0, fn {start, last}, acc ->
      new_s = find_any_less(fresh_ingredients, start)

      new_s =
        cond do
          new_s == {start, last} ->
            start

          true ->
            IO.inspect(new_s)

            nil
        end

      new_e = find_any_less(fresh_ingredients, last)

      new_e =
        cond do
          new_e == {start, last} ->
            last

          true ->
            IO.inspect(new_e)
            nil
        end

      IO.puts("#{new_s}, #{new_e} + #{new_e - new_s + 1}: #{acc}")

      acc + (new_e - new_s + 1)
    end)
  end
end
