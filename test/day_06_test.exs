defmodule Aoc2025.Day06Test do
  use ExUnit.Case, async: true

  alias Aoc2025.Day06

  @example_input """
  123 328  51 64 
   45 64  387 23 
    6 98  215 314
  *   +   *   +  
  """

  @tag :skip
  test "part1 with example input" do
    assert Day06.part1(@example_input) == 4_277_556
  end

  test "part2 with example input" do
    assert Day06.part2(@example_input) == 3_263_827
  end
end
