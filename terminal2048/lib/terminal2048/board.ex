defmodule Terminal2048.Board do

  def new_game() do
    %Terminal2048.State{
      board: 1..16
        |> Enum.map(fn _ -> nil end)
        |> place_number
        |> place_number
    }
  end

  defp place_number(board) do
    select_free_space(board)
    |> select_2_or_4
    |> update_board(board)
  end

  defp select_free_space(board) do
    :rand.uniform(16) - 1
    |> is_free(board)
    |> set_or_reselect(board)
  end

  # use the same possibility as the original version
  defp select_2_or_4(pos) do
    num = if :rand.uniform < 0.9, do: 2, else: 4
    {pos, num}
  end

  defp update_board({pos, num}, board) do
    List.update_at(board, pos, fn _ -> num end)
  end

  defp is_free(pos, board) do
    is_free = Enum.at(board, pos) == nil
    {pos, is_free}
  end

  defp set_or_reselect({pos, true}, _), do: pos
  defp set_or_reselect({_, false}, board), do: select_free_space(board)
end
