defmodule Aoc2024.Day02.Solution do
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

  def solve_part1() do
    load_input()
    |> safe_count()
  end

  def safe_count(reports) do
    reports
    |> Enum.map(&safe?(&1))
    |> Enum.count(fn x -> x end)
  end

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

  defp safe?(report) do
    sorted?(report) and safe_levels?(report)
  end

  defp safe_levels?(report) do
    report
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.map(fn [x, y] -> abs(x - y) end)
    |> Enum.map(fn x -> x >= 1 and x <= 3 end)
    |> Enum.all?()
  end
end
