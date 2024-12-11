defmodule Aoc2024.Day04.Solution do
  @doc """
  # Examples

      iex> \"""
      ...> ABCD
      ...> EFGH
      ...> IKLM
      ...> \"""
      ...> |>
      iex> Aoc2024.Day04.Solution.to_matrix()
      [["A", "B", "C", "D"], ["E", "F", "G", "H"], ["I", "K", "L", "M"]]

      iex> \"""
      ...> ABCD
      ...> EFGH
      ...> IKLM
      ...> \"""
      ...> |>
      iex> Aoc2024.Day04.Solution.to_matrix(true)
      [["D", "C", "B", "A"], ["H", "G", "F", "E"], ["M", "L", "K", "I"]]
  """
  def to_matrix(input, reverse \\ false) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn row ->
      row
      |> maybe_reverse(reverse)
      |> String.graphemes()
    end)
  end

  defp maybe_reverse_matrix(matrix, reverse) do
    if reverse do
      matrix |> Enum.map(fn row -> Enum.reverse(row) end)
    else
      matrix
    end
  end

  defp maybe_reverse(str, reverse) do
    if reverse do
      String.reverse(str)
    else
      str
    end
  end

  @doc """
  # Examples

      iex> \"""
      ...> ABXMASCD
      ...> EFGSAMXH
      ...> IXMASAMX
      ...> \"""
      ...> |> Aoc2024.Day04.Solution.to_matrix()
      iex> |> Aoc2024.Day04.Solution.word_search()
      4
  """
  def word_search(matrix) do
    matrix
    |> Enum.map(fn x -> List.to_string(x) end)
    |> Enum.map(fn x -> [Regex.scan(~r/XMAS/, x), Regex.scan(~r/SAMX/, x)] end)
    |> Enum.map(fn x -> List.flatten(x) end)
    |> Enum.map(fn x -> Enum.count(x) end)
    |> Enum.sum()
  end

  @doc """
  # Examples

      iex> \"""
      ...> ABXMASCD
      ...> EFGSAMXH
      ...> IXMASAMX
      ...> \"""
      ...> |> Aoc2024.Day04.Solution.to_matrix()
      iex> |> Aoc2024.Day04.Solution.x_mas_search()
      4
  """
  def x_mas_search(matrix) do
    matrix
    |> Enum.map(fn x -> List.to_string(x) end)
    |> Enum.map(fn x -> [Regex.scan(~r/MAS/, x), Regex.scan(~r/SAM/, x)] end)
    |> Enum.map(fn x -> List.flatten(x) end)
    |> Enum.map(fn x -> Enum.count(x) end)
    |> Enum.sum()
  end

  @doc """
  # Examples

      iex> \"""
      ...> ABCD
      ...> EFGH
      ...> IKLM
      ...> \"""
      ...> |> Aoc2024.Day04.Solution.to_matrix()
      iex> |> Aoc2024.Day04.Solution.transpose_matrix()
      [["A", "E", "I"], ["B", "F", "K"], ["C", "G", "L"], ["D", "H", "M"]]
  """
  def transpose_matrix(matrix) do
    matrix
    |> Enum.zip()
    |> Enum.map(&Tuple.to_list/1)
  end

  @doc """
  # Examples

      iex> \"""
      ...> ABCD
      ...> EFGH
      ...> IKLM
      ...> \"""
      iex> |> Aoc2024.Day04.Solution.get_rows_and_columns()
      {3, 4}

      iex> \"""
      ...> ABCD
      ...> EFGH
      ...> IKLM
      ...> \"""
      iex> |> Aoc2024.Day04.Solution.to_matrix()
      iex> |> Aoc2024.Day04.Solution.get_rows_and_columns()
      {3, 4}
  """
  def get_rows_and_columns(input) when is_binary(input) do
    matrix = input |> to_matrix()
    {Enum.count(matrix), List.first(matrix) |> Enum.count()}
  end

  def get_rows_and_columns(input) when is_list(input) do
    {Enum.count(input), List.first(input) |> Enum.count()}
  end

  @doc """
  # Examples

      iex> \"""
      ...> ABCD
      ...> EFGH
      ...> IKLM
      ...> NOPQ
      ...> \"""
      ...> |> Aoc2024.Day04.Solution.to_matrix()
      iex> |> Aoc2024.Day04.Solution.get_matrix_top_diagonals()
      [["A", "F", "L", "Q"], ["B", "G", "M"], ["C", "H"], ["D"]]
  """
  def get_matrix_top_diagonals(matrix) do
    {rows, cols} = get_rows_and_columns(matrix)

    0..(cols - 1)
    |> Enum.map(fn c ->
      for r <- 0..(rows - 1) do
        matrix
        |> Enum.at(r)
        |> Enum.at(r + c)
      end
      |> Enum.reject(fn e -> e == nil end)
    end)
  end

  @doc """
  # Examples

      iex> \"""
      ...> MMMSXXMASM
      ...> MSAMXMSMSA
      ...> AMXSXMAAMM
      ...> MSAMASMSMX
      ...> XMASAMXAMM
      ...> XXAMMXXAMA
      ...> SMSMSASXSS
      ...> SAXAMASAAA
      ...> MAMMMXMMMM
      ...> MXMXAXMASX
      ...> \"""
      iex> |> Aoc2024.Day04.Solution.solve_part1()
      18
  """
  def solve_part1(input) do
    matrix = input |> to_matrix()
    reversed_matrix = input |> to_matrix(true)
    horizontal_count = matrix |> word_search()
    vertical_count = matrix |> transpose_matrix() |> word_search()
    d1 = matrix |> get_matrix_top_diagonals()
    d2 = matrix |> transpose_matrix() |> get_matrix_top_diagonals()
    d3 = reversed_matrix |> get_matrix_top_diagonals()
    d4 = reversed_matrix |> transpose_matrix() |> get_matrix_top_diagonals()
    diagonals1_count = Enum.concat(d1, d2) |> Enum.uniq() |> word_search()
    diagonals2_count = Enum.concat(d3, d4) |> Enum.uniq() |> word_search()

    horizontal_count + vertical_count + diagonals1_count + diagonals2_count
  end

  @doc """
  # Examples

      iex> \"""
      ...> .M.S......
      ...> ..A..MSMS.
      ...> .M.S.MAA..
      ...> ..A.ASMSM.
      ...> .M.S.M....
      ...> ..........
      ...> S.S.S.S.S.
      ...> .A.A.A.A..
      ...> M.M.M.M.M.
      ...> ..........
      ...> \"""
      iex> |> Aoc2024.Day04.Solution.solve_part2()
      9
  """
  def solve_part2(input) do
    matrix = input |> to_matrix()
    {rows, cols} = get_rows_and_columns(matrix)

    for row <- 0..(rows - 3) do
      for col <- 0..(cols - 3) do
        x_mas?(get_3_3_matrix(matrix, row, col))
      end
    end
    |> Enum.map(fn row -> Enum.count(row, fn letter -> letter end) end)
    |> Enum.sum()
  end

  @doc """
  # Examples

      iex> \"""
      ...> M.S
      ...> .A.
      ...> M.S
      ...> \"""
      iex> |> Aoc2024.Day04.Solution.x_mas?()
      true

      iex> \"""
      ...> S.S
      ...> .A.
      ...> M.M
      ...> \"""
      iex> |> Aoc2024.Day04.Solution.x_mas?()
      true

      iex> \"""
      ...> ..S
      ...> .A.
      ...> M.M
      ...> \"""
      iex> |> Aoc2024.Day04.Solution.x_mas?()
      false
  """
  def x_mas?(input) when is_binary(input), do: x_mas?(to_matrix(input))

  def x_mas?(matrix) when is_list(matrix) do
    reversed_matrix = maybe_reverse_matrix(matrix, true)
    d1 = matrix |> get_matrix_top_diagonals()
    d2 = matrix |> transpose_matrix() |> get_matrix_top_diagonals()
    d3 = reversed_matrix |> get_matrix_top_diagonals()
    d4 = reversed_matrix |> transpose_matrix() |> get_matrix_top_diagonals()
    diagonals1_count = Enum.concat(d1, d2) |> Enum.uniq() |> x_mas_search()
    diagonals2_count = Enum.concat(d3, d4) |> Enum.uniq() |> x_mas_search()
    {diagonals1_count, diagonals2_count} == {1, 1}
  end

  @doc """
  # Examples

      iex> \"""
      ...> .M.S
      ...> ..A.
      ...> .M.S
      ...> \"""
      iex> |> Aoc2024.Day04.Solution.to_matrix()
      iex> |> Aoc2024.Day04.Solution.get_3_3_matrix(0, 1)
      [["M", ".", "S"], [".", "A", "."], ["M", ".", "S"]]
  """
  def get_3_3_matrix(matrix, row, col) do
    [
      [
        Enum.at(matrix, row) |> Enum.at(col),
        Enum.at(matrix, row) |> Enum.at(col + 1),
        Enum.at(matrix, row) |> Enum.at(col + 2)
      ],
      [
        Enum.at(matrix, row + 1) |> Enum.at(col),
        Enum.at(matrix, row + 1) |> Enum.at(col + 1),
        Enum.at(matrix, row + 1) |> Enum.at(col + 2)
      ],
      [
        Enum.at(matrix, row + 2) |> Enum.at(col),
        Enum.at(matrix, row + 2) |> Enum.at(col + 1),
        Enum.at(matrix, row + 2) |> Enum.at(col + 2)
      ]
    ]
  end
end
