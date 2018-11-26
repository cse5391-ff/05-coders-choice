defmodule Terminal2048.Move do
  def move_left(game = %Terminal2048.State) do
    updated_board = game.board
      |> Enum.chuck(4)
      |> Enum.map(&left_operation)
      |> List.flatten
    %Terminal2048.State{ game | board: updated_board }
  end

  def move_right(game = %Terminal2048.State) do
    updated_board = game.board
      |> Enum.chuck(4)
      |> Enum.map(&right_operation)
      |> List.flatten
    %Terminal2048.State{ game | board: updated_board }
  end

  defp left_operation(row) do
    row
    |> remove_nil
    |> left_add
  end
end
