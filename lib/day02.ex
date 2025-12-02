defmodule Aoc2025.Day02 do
  @moduledoc """
  Advent of Code 2025 - Day 2
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
    |> String.split(",")
    |> Enum.map(fn x ->
      [a, b] = String.split(x, "-")
      {a, _} = Integer.parse(a)
      {b, _} = Integer.parse(b)

      a..b |> Enum.to_list()
    end)
  end

  defp solve_part1(data) do
    IO.inspect(data)

    Enum.reduce(data, 0, fn nums, acc ->
      case find_defective(nums) do
        [] ->
          IO.puts("No defective found")
          acc

        defective ->
          IO.inspect(defective)
          acc + (defective |> Enum.sum())
      end
    end)
  end

  defp find_defective(nums) when is_list(nums) do
    Enum.filter(nums, &check_sum/1)
  end

  defp num_length(num) when is_number(num) do
    num |> Integer.to_string() |> String.length()
  end

  defp is_even(num) when is_number(num) do
    rem(num, 2) == 0
  end

  defp check_sum(num) when is_number(num) do
    n = num_length(num)

    if n |> is_even() do
      divisble = (:math.pow(10, div(n, 2)) |> trunc()) + 1

      # IO.puts("#{num}, #{divisble}: #{rem(num, divisble)}")

      rem(num, divisble) == 0
    else
      false
    end
  end

  defp solve_part2(data) do
    # IO.inspect(data)

    Enum.reduce(data, 0, fn nums, acc ->
      case Enum.filter(nums, &find_indivisible/1) do
        [] ->
          IO.puts("No defective found")
          acc

        defective ->
          IO.inspect(defective)
          acc + (defective |> Enum.sum())
      end
    end)
  end

  def divisors(n) when n <= 1 do
    []
  end

  def divisors(n) when n > 0 do
    # Simpler version since l would be quite small
    1..(n - 1)
    |> Enum.filter(&(rem(n, &1) == 0))
  end

  defp find_indivisible(num) do
    l = num_length(num)

    # N = b x (10^m(k-1) + 10^m(k-2) + .... 1)
    # Forms a GP, so
    # N = b x (10^mk -1) / (10^m - 1)
    # We know N, we now have to check all of m and k
    # The sum of all the GP is mk which is l

    divisors(l)
    |> Enum.any?(fn m ->
      upper = Integer.pow(10, l) - 1
      lower = Integer.pow(10, m) - 1

      factor = div(upper, lower)
      # IO.puts("#{num}: #{upper}, #{lower} - #{factor}")

      if factor == 0 do
        false
      else
        if rem(num, factor) == 0 do
          block = div(num, factor)

          num_length(block) == m
        else
          false
        end
      end
    end)
  end
end
