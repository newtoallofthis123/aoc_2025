defmodule Aoc2025 do
  @moduledoc """
  Documentation for `Aoc2025`.
  """

  def run(day, input) do
    module = Module.concat(Aoc2025, "Day#{day}")
    apply(module, :run, [input])
  end

  def part1(day, input) do
    module = Module.concat(Aoc2025, "Day#{day}")
    apply(module, :part1, [input])
  end

  def part2(day, input) do
    module = Module.concat(Aoc2025, "Day#{day}")
    apply(module, :part2, [input])
  end
end
