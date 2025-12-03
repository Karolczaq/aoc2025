defmodule Aoc2025.Day2 do
  @path "lib/inputs/day2input.txt"
  def solve() do
    @path
    |> File.read!()
    |> String.split(",")
    |> Enum.map(&check_range/1)
    |> Enum.sum()
  end

  def check_range(line) do
    line
    |> String.split("-")
    |> make_range()
    |> Enum.to_list()
    |> Enum.reduce(0, &check_single_id/2)
  end

  defp make_range([a, b]) do
    String.to_integer(a)..String.to_integer(b)
  end

  def check_single_id(id, acc) do
    s = to_string(id)
    len = String.length(s)

    case rem(len, 2) do
      1 ->
        acc

      0 ->
        mid = div(len, 2)
        first = String.slice(s, 0, mid)
        second = String.slice(s, mid, mid)

        if first == second, do: IO.inspect(String.to_integer(s) + acc), else: acc
    end
  end

  def check_2_single_id(id, acc) do
    s = to_string(id)
    len = String.length(s)

    found =
      Enum.any?(1..max(1, div(len, 2)), fn x ->
        rem(len, x) == 0 and div(len, x) >= 2 and
          s
          |> String.graphemes()
          |> Enum.chunk_every(x)
          |> then(fn chunks -> length(Enum.uniq(chunks)) == 1 end)
      end)

    if found, do: id + acc, else: acc
  end

  def solve2() do
    @path
    |> File.read!()
    |> String.split(",")
    |> Enum.map(&check_range2/1)
    |> Enum.sum()
  end

  def check_range2(line) do
    line
    |> String.split("-")
    |> make_range()
    |> Enum.to_list()
    |> Enum.reduce(0, &check_2_single_id/2)
  end
end
