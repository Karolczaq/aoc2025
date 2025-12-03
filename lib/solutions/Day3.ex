defmodule Aoc2025.Day3 do
  @path "lib/inputs/day3input.txt"
  def solve() do
    @path
    |> File.read!()
    |> String.split()
    |> Enum.map(&find_joltage/1)
    |> Enum.sum()
  end

  def find_joltage(line) do
    line
    |> String.graphemes()
    |> Enum.map(&String.to_integer/1)
    |> find_max_number()
  end

  def find_max_number([], [], acc) do
    acc
  end

  def find_max_number([_single], [], acc), do: acc

  def find_max_number([head | [digit | new_tail] = new_list], [], acc) do
    find_max_number(new_list, new_tail, max(10 * head + digit, acc))
  end

  def find_max_number([lhead | _ltail] = llist, [rhead | rtail], acc) do
    find_max_number(llist, rtail, max(acc, 10 * lhead + rhead))
  end

  def find_max_number([_head | tail] = list) do
    find_max_number(list, tail, 0)
  end

  def solve2() do
    @path
    |> File.read!()
    |> String.split("\n")
    |> Enum.map(&find_max_12/1)
    |> Enum.sum()
  end

  def find_max_12(line) do
    line
    |> String.graphemes()
    |> Enum.map(&String.to_integer/1)
    |> pick_n_max(12, 0, [])
    |> Enum.reverse()
    |> Integer.undigits()
  end

  def pick_n_max(_digits, 0, _start, acc), do: acc

  def pick_n_max(digits, n, start, acc) do
    last_valid = length(digits) - n

    {max_digit, max_id} =
      digits
      |> Enum.with_index()
      |> Enum.slice(start..last_valid)
      |> Enum.max_by(fn x -> elem(x, 0) end)

    pick_n_max(digits, n - 1, max_id + 1, [max_digit | acc])
  end
end
