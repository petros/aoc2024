defmodule Aoc2024Test.Day01 do
  use ExUnit.Case
  doctest Aoc2024

  alias Aoc2024.Day01.Solution

  test "day 01 part 1" do
    l = [3, 4, 2, 1, 3, 3]
    r = [4, 3, 5, 3, 9, 3]
    assert Solution.run({l, r}) == 11
    assert Solution.solve_part1() == 1_603_498
  end

  test "day 01 part 2" do
    l = [3, 4, 2, 1, 3, 3]
    r = [4, 3, 5, 3, 9, 3]
    assert Solution.similarity({l, r}) == 31
    assert Solution.solve_part2() == 25_574_739
  end
end
