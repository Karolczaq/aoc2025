defmodule Aoc2025.Day4 do
  @path "lib/inputs/day4input.txt"

  def solve() do
    grid =
      @path
      |> parse_input()

    grid
    |> Enum.with_index()
    |> Enum.map(fn {row, i} ->
      row
      |> Enum.with_index()
      |> Enum.count(fn {_val, j} -> check_if_can_take(grid, i, j) == 1 end)
    end)
    |> Enum.sum()
  end

  def solve2() do
    grid = parse_input(@path)

    remove_loop(grid, 0)
  end

  def convert_to_list(line) do
    line
    |> String.split("")
    |> Enum.map(&roll_to_bin/1)
  end

  def roll_to_bin(str) do
    if str == "@" do
      1
    else
      0
    end
  end

  def check_if_can_take(grid, i, j) do
    cell = get_cell(grid, i, j)

    if cell != 1 do
      0
    else
      offsets = for di <- -1..1, dj <- -1..1, {di, dj} != {0, 0}, do: {di, dj}

      count =
        offsets
        |> Enum.map(fn {di, dj} -> get_cell(grid, i + di, j + dj) end)
        |> Enum.sum()

      if count < 4, do: 1, else: 0
    end
  end

  defp get_cell(_grid, i, j) when i < 0 or j < 0, do: 0

  defp get_cell(grid, i, j) do
    row = Enum.at(grid, i)
    if row == nil, do: 0, else: Enum.at(row, j, 0)
  end

  defp remove_loop(grid, total) do
    to_remove = find_removable(grid)

    if to_remove == [] do
      total
    else
      new_grid = remove_cells(grid, to_remove)
      remove_loop(new_grid, total + length(to_remove))
    end
  end

  defp find_removable(grid) do
    for i <- 0..(length(grid) - 1),
        j <- 0..(length(Enum.at(grid, 0, [])) - 1),
        check_if_can_take(grid, i, j) == 1,
        do: {i, j}
  end

  defp remove_cells(grid, positions) do
    Enum.reduce(positions, grid, fn {i, j}, acc ->
      List.update_at(acc, i, fn row ->
        List.update_at(row, j, fn _ -> 0 end)
      end)
    end)
  end

  defp parse_input(path) do
    path
    |> File.read!()
    |> String.split("\n")
    |> Enum.map(&convert_to_list/1)
  end
end
