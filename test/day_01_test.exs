defmodule Aoc2025.Day01Test do
  use ExUnit.Case, async: true

  alias Aoc2025.Day01

  @example_input """
  L68
  L30
  R48
  L5
  R60
  L55
  L1
  L99
  R14
  L82
  """

  @tag :skip
  test "part1 with example input" do
    assert Day01.part1(@example_input) == 3
  end

  test "part2 with example input" do
    assert Day01.part2(@example_input) == 6
  end
end
