defmodule Aoc2025.Day03Test do
  use ExUnit.Case, async: true

  alias Aoc2025.Day03

  @example_input """
  987654321111111
  811111111111119
  234234234234278
  818181911112111
  """

  @tag :skip
  test "part1 with example input" do
    assert Day03.part1(@example_input) == 357
  end

  test "part2 with example input" do
    assert Day03.part2(@example_input) == 3_121_910_778_619
  end
end
