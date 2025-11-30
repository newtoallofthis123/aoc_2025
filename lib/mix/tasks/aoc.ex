defmodule Mix.Tasks.Aoc do
  use Mix.Task

  @shortdoc "Run Advent of Code solution for given day"

  @moduledoc """
  Usage:

      mix aoc 1
      mix aoc 5

  Runs both part1 and part2 for the given day, using input from priv/inputs/dayXX.txt.
  """

  def run([]) do
    Mix.Task.run("app.start")

    IO.puts("Please provide a day number to run, e.g.: 1")
  end

  def run([day_str]) do
    Mix.Task.run("app.start")

    day =
      case Integer.parse(day_str) do
        {d, ""} -> d
        _ -> Mix.raise("Day must be an integer, got: #{inspect(day_str)}")
      end

    mod = day_module(day)

    # Ensure the module exists
    Code.ensure_loaded!(mod)

    input = Aoc2025.Input.read!(day)

    part1 = apply(mod, :part1, [input])
    part2 = apply(mod, :part2, [input])

    IO.puts("Day #{day}")
    IO.puts("  Part 1: #{part1}")
    IO.puts("  Part 2: #{part2}")
  end

  defp day_module(day) do
    mod_name = "Day" <> String.pad_leading(Integer.to_string(day), 2, "0")
    Module.concat(Aoc2025, mod_name)
  end
end
