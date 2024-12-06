defmodule Aoc2024.Day02.Solution do
  @doc """
  # Examples
      iex> Aoc2024.Day02.Solution.sorted?([1, 2, 3])
      true

      iex> Aoc2024.Day02.Solution.sorted?([3, 2, 1])
      true

      iex> Aoc2024.Day02.Solution.sorted?([3, 1, 2])
      false
  """
  def sorted?(list) do
    asc =
      Enum.chunk_while(
        list,
        nil,
        fn
          x, nil -> {:cont, x}
          x, prev when x >= prev -> {:cont, x}
          _, _ -> {:halt, false}
        end,
        fn acc -> {:cont, acc, true} end
      )

    desc =
      Enum.chunk_while(
        list,
        nil,
        fn
          x, nil -> {:cont, x}
          x, prev when x <= prev -> {:cont, x}
          _, _ -> {:halt, false}
        end,
        fn acc -> {:cont, acc, true} end
      )

    List.first(asc) == List.last(list) or List.first(desc) == List.last(list)
  end

  @doc """
  # Examples
      iex> Aoc2024.Day02.Solution.safe_levels?([7, 6, 4, 2, 1])
      true

      iex> Aoc2024.Day02.Solution.safe_levels?([1, 2, 7, 8, 9])
      false
  """
  def safe_levels?(report) do
    report
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.map(fn [x, y] -> abs(x - y) end)
    |> Enum.map(fn x -> x >= 1 and x <= 3 end)
    |> Enum.all?()
  end

  @doc """
  # Examples
      iex> Aoc2024.Day02.Solution.remove_one_level_permutations([1, 2, 3])
      [[2, 3], [1, 3], [1, 2]]

      iex> Aoc2024.Day02.Solution.remove_one_level_permutations([8, 6, 4, 4, 1])
      [[6, 4, 4, 1], [8, 4, 4, 1], [8, 6, 4, 1], [8, 6, 4, 1], [8, 6, 4, 4]]
  """
  def remove_one_level_permutations(report) do
    Enum.with_index(report, fn _level, index ->
      List.delete_at(report, index)
    end)
  end

  @doc """
  7 6 4 2 1: Safe because the levels are all decreasing by 1 or 2.
  1 2 7 8 9: Unsafe because 2 7 is an increase of 5.
  9 7 6 2 1: Unsafe because 6 2 is a decrease of 4.
  1 3 2 4 5: Unsafe because 1 3 is increasing but 3 2 is decreasing.
  8 6 4 4 1: Unsafe because 4 4 is neither an increase or a decrease.
  1 3 6 7 9: Safe because the levels are all increasing by 1, 2, or 3.

  # Examples
      iex> Aoc2024.Day02.Solution.safe?([7, 6, 4, 2, 1])
      true

      iex> Aoc2024.Day02.Solution.safe?([1, 2, 7, 8, 9])
      false

      iex> Aoc2024.Day02.Solution.safe?([9, 7, 6, 2, 1])
      false

      iex> Aoc2024.Day02.Solution.safe?([1, 3, 2, 4, 5])
      false

      iex> Aoc2024.Day02.Solution.safe?([8, 6, 4, 4, 1])
      false

      iex> Aoc2024.Day02.Solution.safe?([1, 3, 6, 7, 9])
      true
  """
  def safe?(report) do
    sorted?(report) and safe_levels?(report)
  end

  @doc """
  7 6 4 2 1: Safe without removing any level.
  1 2 7 8 9: Unsafe regardless of which level is removed.
  9 7 6 2 1: Unsafe regardless of which level is removed.
  1 3 2 4 5: Safe by removing the second level, 3.
  8 6 4 4 1: Safe by removing the third level, 4.
  1 3 6 7 9: Safe without removing any level.

  # Examples
      iex> Aoc2024.Day02.Solution.safe_with_problem_dampener?([7, 6, 4, 2, 1])
      true

      iex> Aoc2024.Day02.Solution.safe_with_problem_dampener?([1, 2, 7, 8, 9])
      false

      iex> Aoc2024.Day02.Solution.safe_with_problem_dampener?([9, 7, 6, 2, 1])
      false

      iex> Aoc2024.Day02.Solution.safe_with_problem_dampener?([1, 3, 2, 4, 5])
      true

      iex> Aoc2024.Day02.Solution.safe_with_problem_dampener?([8, 6, 4, 4, 1])
      true

      iex> Aoc2024.Day02.Solution.safe_with_problem_dampener?([1, 3, 6, 7, 9])
      true
  """
  def safe_with_problem_dampener?(report) do
    remove_one_level_permutations(report)
    |> Enum.map(&safe?(&1))
    |> Enum.any?()
  end

  @doc """
  # Examples
      iex> reports = [
      ...>   [7, 6, 4, 2, 1],
      ...>   [1, 2, 7, 8, 9],
      ...>   [9, 7, 6, 2, 1],
      ...>   [1, 3, 2, 4, 5],
      ...>   [8, 6, 4, 4, 1],
      ...>   [1, 3, 6, 7, 9]
      ...> ]
      iex> Aoc2024.Day02.Solution.solve_part1(reports)
      2
  """
  def solve_part1(reports) do
    reports
    |> Enum.map(&safe?(&1))
    |> Enum.count(fn x -> x end)
  end

  @doc """
  # Examples
      iex> reports = [
      ...>   [7, 6, 4, 2, 1],
      ...>   [1, 2, 7, 8, 9],
      ...>   [9, 7, 6, 2, 1],
      ...>   [1, 3, 2, 4, 5],
      ...>   [8, 6, 4, 4, 1],
      ...>   [1, 3, 6, 7, 9]
      ...> ]
      iex> Aoc2024.Day02.Solution.solve_part2(reports)
      4
  """
  def solve_part2(reports) do
    reports
    |> Enum.map(&safe_with_problem_dampener?(&1))
    |> Enum.count(fn x -> x end)
  end

  @doc """
  # Examples
      iex> Aoc2024.Day02.Solution.load_input() |> Enum.count()
      1000
  """
  def load_input() do
    path = "lib/day02/input.txt"
    {:ok, contents} = File.read(path)

    contents
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      line
      |> String.split(" ", trim: true)
      |> Enum.map(&String.to_integer/1)
    end)
  end
end
