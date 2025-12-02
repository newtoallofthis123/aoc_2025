defmodule Aoc2025.Day02Test do
  use ExUnit.Case, async: true

  alias Aoc2025.Day02

  @example_input """
  11-22,95-115,998-1012,1188511880-1188511890,222220-222224,1698522-1698528,446443-446449,38593856-38593862,565653-565659,824824821-824824827,2121212118-2121212124
  """

  test "part1 with example input" do
    assert Day02.part1(@example_input) == 1_227_775_554
  end

  test "part2 with example input" do
    assert Day02.part2(@example_input) == 4_174_379_265
  end
end
