defmodule Aoc2024.Day01.Solution do
  def load_input() do
    path = "lib/day01/input.txt"
    {:ok, contents} = File.read(path)
    String.split(contents, "\n", trim: true)
  end

  def build_lists(list), do: build_lists(list, [], [])

  def build_lists([], left_list, right_list), do: {left_list, right_list}

  def build_lists([head | tail], left_list, right_list) do
    [l, r] = String.split(head)
    build_lists(tail, [String.to_integer(l) | left_list], [String.to_integer(r) | right_list])
  end

  def solve_part1() do
    load_input()
    |> build_lists()
    |> run()
  end

  def run({l, r}) do
    l = Enum.sort(l)
    r = Enum.sort(r)
    calculate(l, r, 0)
  end

  def calculate([], [], sum), do: sum

  def calculate([head1 | tail1], [head2 | tail2], sum),
    do: calculate(tail1, tail2, abs(head1 - head2) + sum)
end
