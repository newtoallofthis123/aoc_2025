defmodule Mix.Tasks.Aoc.Gen do
  use Mix.Task

  @shortdoc "Generate scaffold for a new Advent of Code day"

  @moduledoc """
  Generates the necessary files for a new Advent of Code day solution.

  Usage:

      mix aoc.gen 1
      mix aoc.gen 15

  This will create:
    - lib/dayXX.ex (solution module)
    - test/day_XX.exs (test file)
    - priv/inputs/dayXX.txt (empty input file)

  If any of these files already exist, they will not be overwritten.
  """

  def run([]) do
    IO.puts("Usage: mix aoc.gen DAY")
    IO.puts("")
    IO.puts("Example: mix aoc.gen 1")
  end

  def run([day_str]) do
    day =
      case Integer.parse(day_str) do
        {d, ""} when d >= 1 and d <= 25 -> d
        {d, ""} -> Mix.raise("Day must be between 1 and 25, got: #{d}")
        _ -> Mix.raise("Day must be an integer, got: #{inspect(day_str)}")
      end

    day_padded = String.pad_leading(Integer.to_string(day), 2, "0")
    module_name = "Day#{day_padded}"

    # File paths
    solution_path = Path.join("lib", "day#{day_padded}.ex")
    test_path = Path.join("test", "day_#{day_padded}.exs")
    input_path = Path.join(["priv", "inputs", "day#{day_padded}.txt"])

    # Generate solution file
    create_file_if_not_exists(solution_path, solution_template(module_name, day))

    # Generate test file
    create_file_if_not_exists(test_path, test_template(module_name, day))

    # Generate empty input file
    create_file_if_not_exists(input_path, "")

    IO.puts("\n✓ Generated files for Day #{day}")
    IO.puts("\nNext steps:")
    IO.puts("  1. Add your puzzle input to #{input_path}")
    IO.puts("  2. Implement your solution in #{solution_path}")
    IO.puts("  3. Run tests with: mix test #{test_path}")
    IO.puts("  4. Run solution with: mix aoc #{day}")
  end

  defp create_file_if_not_exists(path, content) do
    if File.exists?(path) do
      IO.puts("• #{path} already exists, skipping")
    else
      # Ensure directory exists
      path |> Path.dirname() |> File.mkdir_p!()

      File.write!(path, content)
      IO.puts("• Created #{path}")
    end
  end

  defp solution_template(module_name, day) do
    """
    defmodule Aoc2025.#{module_name} do
      @moduledoc \"\"\"
      Advent of Code 2025 - Day #{day}
      \"\"\"

      @behaviour Aoc2025.Day

      @impl true
      def run(input) do
        IO.puts("Part 1: \#{part1(input)}")
        IO.puts("Part 2: \#{part2(input)}")
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
        |> String.split("\\n")
      end

      defp solve_part1(_data) do
        # TODO: Implement part 1
        0
      end

      defp solve_part2(_data) do
        # TODO: Implement part 2
        0
      end
    end
    """
  end

  defp test_template(module_name, day) do
    """
    defmodule Aoc2025.#{module_name}Test do
      use ExUnit.Case, async: true

      alias Aoc2025.#{module_name}

      @example_input \"\"\"
      # TODO: Add example input from puzzle
      \"\"\"

      test "part1 with example input" do
        # TODO: Update expected value
        assert #{module_name}.part1(@example_input) == 0
      end

      @tag :skip
      test "part2 with example input" do
        # TODO: Update expected value
        assert #{module_name}.part2(@example_input) == 0
      end
    end
    """
  end
end
