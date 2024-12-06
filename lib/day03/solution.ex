defmodule Aoc2024.Day03.Solution do
  @doc """
  # Examples
      iex> Aoc2024.Day03.Solution.solve_part1("xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))")
      161
  """
  def solve_part1(memory) do
    Regex.scan(~r/mul\(\d{1,3},\d{1,3}\)/, memory)
    |> Enum.map(fn x ->
      Regex.scan(~r/(\d{1,3}),(\d{1,3})/, List.first(x), capture: :all_but_first)
    end)
    |> List.flatten()
    |> Enum.map(fn x -> String.to_integer(x) end)
    |> Enum.chunk_every(2)
    |> Enum.map(fn x -> Enum.product(x) end)
    |> Enum.sum()
  end

  @doc """
  # Examples
      iex> Aoc2024.Day03.Solution.split_parts("xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))")
      ["xmul(2,4)&mul[3,7]!^", "don't", "()_mul(5,5)+mul(32,64](mul(11,8)un", "do", "()?mul(8,5))"]
  """
  def split_parts(memory) do
    Regex.split(~r/don't|do/, memory, include_captures: true, trim: true)
  end

  @doc """
  # Examples
      iex> Aoc2024.Day03.Solution.solve_part2("xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))")
      48
  """
  def solve_part2(memory) do
    "do#{memory}"
    |> Aoc2024.Day03.Solution.split_parts()
    |> Enum.chunk_every(2)
    |> Enum.reject(fn x -> List.first(x) == "don't" end)
    |> List.flatten()
    |> Enum.reject(fn x -> x == "do" end)
    |> List.to_string()
    |> Aoc2024.Day03.Solution.solve_part1()
  end
end
