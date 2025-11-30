defmodule Mix.Tasks.Aoc.Bench do
  use Mix.Task

  @shortdoc "Benchmark Advent of Code solutions"

  if Code.ensure_loaded?(Benchee) do
    @benchee_available true
  else
    @benchee_available false
  end

  @moduledoc """
  Benchmark multiple solution functions for a given day using Benchee.

  Usage:

      mix aoc.bench 1 part1 part2
      mix aoc.bench 5 part1 part1_optimized part1_v3

  This will run all specified functions with the same input from priv/inputs/dayXX.txt
  and compare their performance using Benchee.

  You can benchmark any public function from the day module, not just part1/part2.
  This is useful for comparing different implementations or optimizations.
  """

  def run([]) do
    Mix.Task.run("app.start")

    IO.puts("Usage: mix aoc.bench DAY FUNCTION1 FUNCTION2 [FUNCTION3 ...]")
    IO.puts("")
    IO.puts("Example: mix aoc.bench 1 part1 part2")
    IO.puts("Example: mix aoc.bench 5 part1 part1_optimized")
  end

  def run([day_str | function_names]) when length(function_names) >= 1 do
    Mix.Task.run("app.start")

    day =
      case Integer.parse(day_str) do
        {d, ""} -> d
        _ -> Mix.raise("Day must be an integer, got: #{inspect(day_str)}")
      end

    mod = day_module(day)

    # Ensure the module exists
    Code.ensure_loaded!(mod)

    # Load the input once
    input = Aoc2025.Input.read!(day)

    # Convert function names to atoms and validate they exist
    function_atoms =
      Enum.map(function_names, fn name ->
        atom = String.to_atom(name)

        unless function_exported?(mod, atom, 1) do
          Mix.raise(
            "Function #{name}/1 does not exist in module #{inspect(mod)}. " <>
              "Available functions: #{inspect(exported_functions(mod))}"
          )
        end

        atom
      end)

    # Build the benchmark jobs
    jobs =
      function_atoms
      |> Enum.map(fn func_atom ->
        {Atom.to_string(func_atom), fn -> apply(mod, func_atom, [input]) end}
      end)
      |> Enum.into(%{})

    IO.puts(
      "\nBenchmarking Day #{day} with input from priv/inputs/day#{String.pad_leading(Integer.to_string(day), 2, "0")}.txt\n"
    )

    if @benchee_available do
      Benchee.run(
        jobs,
        time: 5,
        memory_time: 2,
        warmup: 2,
        formatters: [
          Benchee.Formatters.Console
        ]
      )
    else
      Mix.raise("Benchee is not available. Make sure it's installed with: mix deps.get")
    end
  end

  def run([_day_str]) do
    Mix.raise("Please provide at least one function name to benchmark.")
  end

  defp day_module(day) do
    mod_name = "Day" <> String.pad_leading(Integer.to_string(day), 2, "0")
    Module.concat(Aoc2025, mod_name)
  end

  defp exported_functions(mod) do
    mod.__info__(:functions)
    |> Enum.filter(fn {_name, arity} -> arity == 1 end)
    |> Enum.map(fn {name, _arity} -> name end)
  end
end
