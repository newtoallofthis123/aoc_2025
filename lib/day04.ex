defmodule Aoc2025.Day04 do
  @moduledoc """
  Advent of Code 2025 - Day 4
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
    |> Enum.map(&String.graphemes/1)
  end

  defp solve_part1(data) do
    max_y = length(Enum.at(data, 0))
    max_x = length(data)

    matrix = index_matrix(data)

    Enum.reduce(Enum.with_index(data), 0, fn {row, i}, acc ->
      acc +
        Enum.reduce(Enum.with_index(row), 0, fn {val, j}, acc2 ->
          if val == "@" and is_removable?({i, j}, matrix, {max_x, max_y}) do
            IO.puts("#{i},#{j} -> true")
            acc2 + 1
          else
            acc2
          end
        end)
    end)
  end

  defp is_removable?({x, y}, matrix, {max_x, max_y}) do
    count =
      get_directions(x, y, max_x, max_y)
      |> Enum.reduce(0, fn {x1, y1}, acc ->
        char = Map.fetch!(matrix, {x1, y1})

        if char == "@" do
          acc + 1
        else
          acc
        end
      end)

    count < 4
  end

  defp index_matrix(matrix) do
    Enum.reduce(Enum.with_index(matrix), %{}, fn {row, i}, acc ->
      Enum.reduce(Enum.with_index(row), acc, fn {val, j}, acc2 ->
        Map.put(acc2, {i, j}, val)
      end)
    end)
  end

  defp get_directions(x, y, max_x, max_y) when is_integer(x) and is_integer(y) do
    [{-1, -1}, {-1, 0}, {-1, 1}, {0, -1}, {0, 1}, {1, -1}, {1, 0}, {1, 1}]
    |> Enum.map(fn {x1, y1} = _add ->
      new_x = x + x1
      new_y = y + y1

      if is_valid_idx?({new_x, new_y}, {max_x, max_y}) do
        {new_x, new_y}
      else
        nil
      end
    end)
    |> Enum.reject(&is_nil/1)
  end

  defp is_valid_idx?({x, y}, {max_x, max_y}) do
    x >= 0 and y >= 0 and x < max_x and y < max_y
  end

  defp solve_part2(data) do
    max_y = length(Enum.at(data, 0))
    max_x = length(data)

    matrix = index_matrix(data)

    {removable, new_matrix} =
      Enum.reduce(matrix, {[], matrix}, fn {{i, j}, val}, {acc, new_matrix} ->
        if val == "@" and is_removable?({i, j}, matrix, {max_x, max_y}) do
          IO.puts("#{i},#{j} -> true")
          {[{i, j} | acc], Map.put(new_matrix, {i, j}, ".")}
        else
          {acc, new_matrix}
        end
      end)

    IO.inspect({removable, new_matrix})

    # print_matrix(new_matrix)

    remove_all(new_matrix, {max_x, max_y}, length(removable), removable)
  end

  defp remove_all(_matrix, _max_idx, count, []) do
    count
  end

  defp remove_all(matrix, {max_x, max_y}, count, _removable) do
    {removable, new_matrix} =
      Enum.reduce(matrix, {[], matrix}, fn {{i, j}, val}, {acc, new_matrix} ->
        if val == "@" and is_removable?({i, j}, matrix, {max_x, max_y}) do
          IO.puts("#{i},#{j} -> true")
          {[{i, j} | acc], Map.put(new_matrix, {i, j}, ".")}
        else
          {acc, new_matrix}
        end
      end)

    # print_matrix(new_matrix)
    remove_all(new_matrix, {max_x, max_y}, count + length(removable), removable)
  end

  def print_matrix(map) do
    {max_i, max_j} =
      map
      |> Map.keys()
      |> Enum.reduce({0, 0}, fn {i, j}, {mi, mj} ->
        {max(i, mi), max(j, mj)}
      end)

    for i <- 0..max_i do
      row =
        for j <- 0..max_j do
          Map.get(map, {i, j}, ".")
        end

      IO.puts(Enum.join(row, " "))
    end
  end
end
