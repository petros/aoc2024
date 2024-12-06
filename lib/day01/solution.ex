defmodule Aoc2024.Day01.Solution do
  @doc """
  # Examples

      iex> Aoc2024.Day01.Solution.load_input() |> Enum.count()
      1000
  """
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

  def solve_part2() do
    load_input()
    |> build_lists()
    |> similarity()
  end

  @doc """
  # Examples

      iex> l = [3, 4, 2, 1, 3, 3]
      iex> r = [4, 3, 5, 3, 9, 3]
      iex> Aoc2024.Day01.Solution.run({l, r})
      11
  """
  def run({l, r}) do
    l = Enum.sort(l)
    r = Enum.sort(r)
    calculate(l, r, 0)
  end

  @doc """
  # Examples

      iex> l = [3, 4, 2, 1, 3, 3]
      iex> r = [4, 3, 5, 3, 9, 3]
      iex> Aoc2024.Day01.Solution.similarity({l, r})
      31
  """
  def similarity({l, r}) do
    l
    |> Enum.map(&count_occurrences(&1, r))
    |> Enum.sum()
  end

  defp count_occurrences(element, list) do
    element * Enum.count(list, fn x -> x == element end)
  end

  def calculate([], [], sum), do: sum

  def calculate([head1 | tail1], [head2 | tail2], sum),
    do: calculate(tail1, tail2, abs(head1 - head2) + sum)
end
