defmodule Aoc2025.Input do
  @moduledoc """
  Helpers for loading Advent of Code input files.
  """

  @inputs_dir Path.join(:code.priv_dir(:aoc_2025), "inputs")

  def read!(day) when is_integer(day) do
    day
    |> day_to_filename()
    |> File.read!()
  end

  defp day_to_filename(day) do
    filename = "day" <> String.pad_leading(Integer.to_string(day), 2, "0") <> ".txt"
    Path.join(@inputs_dir, filename)
  end
end
