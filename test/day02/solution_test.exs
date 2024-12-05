defmodule Aoc2024Test.Day02 do
  use ExUnit.Case
  doctest Aoc2024

  alias Aoc2024.Day02.Solution

  test "day 02 part 1" do
    reports = [
      [7, 6, 4, 2, 1],
      [1, 2, 7, 8, 9],
      [9, 7, 6, 2, 1],
      [1, 3, 2, 4, 5],
      [8, 6, 4, 4, 1],
      [1, 3, 6, 7, 9]
    ]

    assert Solution.safe_count(reports) == 2
    assert Solution.solve_part1() == 421
  end
end
