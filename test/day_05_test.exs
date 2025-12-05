defmodule Aoc2025.Day05Test do
  use ExUnit.Case, async: true

  alias Aoc2025.Day05

  @example_input """
  3-5
  10-14
  16-20
  12-18

  1
  5
  8
  11
  17
  32
  """

  @tag :skip
  test "part1 with example input" do
    assert Day05.part1(@example_input) == 3
  end

  test "part2 with example input" do
    assert Day05.part2(@example_input) == 14
  end
end
