defmodule Terminal2048.Board do

  def new_game() do
    %Terminal2048.State{
      board: 1..16
        |> Enum.map(fn _ -> nil end)
        |> place_number
        |> place_number
    }
  end

  def place_number(board) do
    board
    |> select_free_tiles
    |> select_2_or_4
    |> update_board(board)
  end

  def make_move(game = %Terminal2048.State{}, direction) do
    updated_game = Terminal2048.Move.handle_move(game, direction)
    {updated_game, updated_game.game_state}
  end

  def draw_current_board(game) do
    size = 4
    max_digits = 5

    game.board
    |> Enum.chunk_every(4)
    |> inspect_rows(max_digits)
    |> get_line(delimiter(size, max_digits), "\r\nScore: #{game.score}\r\n")
  end



  defp select_free_tiles(board) do
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
  defp set_or_reselect({_, false}, board), do: select_free_tiles(board)

  defp inspect_rows(rows, max_digits) do
    rows
    |> Enum.map(&(inspect_row(&1, max_digits)))
  end

  defp inspect_row(tiles, max_digits) do
    tiles
    |> Enum.map(&(inspect_tile(&1, max_digits)))
    |> get_line("|", "\r\n")
  end

  defp inspect_tile(nil, max_digits) do
    pad("", max_digits)
  end

  defp inspect_tile(number, max_digits) do
    number
    |> Integer.to_string
    |> pad(max_digits)
  end

  defp pad(number, length) do
    pad_length = length - String.length(number)
    number
    |> String.pad_leading(String.length(number) + div(pad_length, 2) + rem(pad_length, 2))
    |> String.pad_trailing(length)
  end

  defp delimiter(size, max_digits) do
    get_line(String.duplicate("-", max_digits) |> List.duplicate(size), "|", "\r\n")
  end

  defp get_line(numbers, delimiter, postfix) do
    delimiter <> Enum.join(numbers, delimiter) <> delimiter <> postfix
  end

end
