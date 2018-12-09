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

  def can_move(game, direction) do
    game != make_move(game, direction)
  end

  def game_over(game) do
    [:left, :right, :up, :down]
    |> Enum.all?(fn direction -> !can_move(game, direction) end)
  end

  defp make_move(game, :left),  do: game |> Move.move_left
  defp make_move(game, :right), do: game |> Move.move_right
  defp make_move(game, :up),    do: game |> Move.move_up
  defp make_move(game, :down),  do: game |> Move.move_down

end
