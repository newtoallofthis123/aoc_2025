defmodule Aoc2025.Day04Test do
  use ExUnit.Case, async: true

  alias Aoc2025.Day04

  @example_input """
  ..@@.@@@@.
  @@@.@.@.@@
  @@@@@.@.@@
  @.@@@@..@.
  @@.@@@@.@@
  .@@@@@@@.@
  .@.@.@.@@@
  @.@@@.@@@@
  .@@@@@@@@.
  @.@.@@@.@.
  """

  @tag :skip
  test "part1 with example input" do
    assert Day04.part1(@example_input) == 13
  end

  test "part2 with example input" do
    assert Day04.part2(@example_input) == 43
  end
end
