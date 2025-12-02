defmodule Aoc2025.Day1 do
  @moduledoc false

  @path "lib/inputs/day1input.txt"

  def solve1() do
    dial = 50

    @path
    |> File.read!()
    |> String.split("\n")
    |> Enum.reduce({dial, 0}, fn com, acc -> rotate(com, acc) end)
    |> elem(1)
  end

  def rotate(command, {dial, num0}) do
    case command do
      "L" <> dist ->
        new_dial = Integer.mod(dial - String.to_integer(dist), 100)

        case new_dial == 0 do
          true -> {new_dial, num0 + 1}
          false -> {new_dial, num0}
        end

      "R" <> dist ->
        new_dial = Integer.mod(dial + String.to_integer(dist), 100)

        case new_dial == 0 do
          true -> {new_dial, num0 + 1}
          false -> {new_dial, num0}
        end
    end
  end

  def rotate(command, dial) do
    rotate(command, {dial, 0})
  end

  def solve2() do
    dial = 50

    @path
    |> File.read!()
    |> String.split("\n")
    |> Enum.reduce({dial, 0}, fn com, acc -> rotate_by_one(com, acc) end)
    |> elem(1)
  end

  def rotate_by_one("R0", acc) do
    acc
  end

  def rotate_by_one("L0", acc) do
    acc
  end

  def rotate_by_one(command, {dial, num0}) do
    case command do
      "L" <> dist ->
        new_dial = Integer.mod(dial - 1, 100)
        new_num = num0 + if new_dial == 0, do: 1, else: 0
        rotate_by_one("L" <> Integer.to_string(String.to_integer(dist) - 1), {new_dial, new_num})

      "R" <> dist ->
        new_dial = Integer.mod(dial + 1, 100)
        new_num = num0 + if new_dial == 0, do: 1, else: 0
        rotate_by_one("R" <> Integer.to_string(String.to_integer(dist) - 1), {new_dial, new_num})
    end
  end
end
