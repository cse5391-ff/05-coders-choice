defmodule Terminal2048.Move do

  def handle_move(game, direction) do
    {game.board, game.score}
    |> can_move(direction)
    |> return_game(game, direction)
  end

  defp can_move({board, score}, :left),  do: {board, score} != move_left({board, score})
  defp can_move({board, score}, :right), do: {board, score} != move_right({board, score})
  defp can_move({board, score}, :up),    do: {board, score} != move_up({board, score})
  defp can_move({board, score}, :down),  do: {board, score} != move_down({board, score})

  defp return_game(false, game, _direction) do
    %Terminal2048.State{ game |
      game_state: :no_move
    }
  end

  defp return_game(true, game, direction) do
    {new_board, new_score} = move(game, direction)

    new_board = new_board
      |> Terminal2048.Board.place_number

    %Terminal2048.State{ game |
      game_state: update_game_state({new_board, new_score}),
      board: new_board,
      score: new_score
    }
  end

  defp update_game_state({board, score}) do
    [:left, :right, :up, :down]
    |> Enum.all?(fn direction -> !can_move({board, score}, direction) end)
    |> handle_game_state
  end

  defp handle_game_state(true),  do: :lost
  defp handle_game_state(false), do: :continue

  defp move(game, :left),  do: move_left({game.board, game.score})
  defp move(game, :right), do: move_right({game.board, game.score})
  defp move(game, :up),    do: move_up({game.board, game.score})
  defp move(game, :down),  do: move_down({game.board, game.score})

  defp move_left({board, score}) do
    row_with_score = board
      |> Enum.chunk_every(4)
      |> Enum.map(&leftward_operation(&1))

    new_board = row_with_score
      |> Enum.map(&List.first/1)
      |> List.flatten

    new_score = row_with_score
      |> Enum.map(&List.last/1)
      |> List.flatten
      |> Enum.sum

    {new_board, score + new_score}
  end

  defp move_right({board, score}) do
    row_with_score = board
      |> Enum.chunk_every(4)
      |> Enum.map(&Enum.reverse/1)
      |> Enum.map(&leftward_operation(&1))

    new_board = row_with_score
      |> Enum.map(&List.first/1)
      |> Enum.map(&Enum.reverse/1)
      |> List.flatten

    new_score = row_with_score
      |> Enum.map(&List.last/1)
      |> List.flatten
      |> Enum.sum

    {new_board, score + new_score}
  end

  defp move_up({board, score}) do
    row_with_score = board
      |> Enum.chunk_every(4)
      |> rotate_left([])
      |> Enum.map(&leftward_operation(&1))

    new_board = row_with_score
      |> Enum.map(&List.first/1)
      |> rotate_right([])
      |> List.flatten

    new_score = row_with_score
      |> Enum.map(&List.last/1)
      |> List.flatten
      |> Enum.sum

    {new_board, score + new_score}
  end

  defp move_down({board, score}) do
    row_with_score = board
      |> Enum.chunk_every(4)
      |> rotate_right([])
      |> Enum.map(&leftward_operation(&1))

    new_board = row_with_score
      |> Enum.map(&List.first/1)
      |> rotate_left([])
      |> List.flatten

    new_score = row_with_score
      |> Enum.map(&List.last/1)
      |> List.flatten
      |> Enum.sum

    {new_board, score + new_score}
  end

  defp leftward_operation(row) do
    {row, score} = row
      |> remove_nil
      |> merge

    row = fill_nil(row)

    [row, score]
  end

  defp remove_nil(list), do: Enum.filter(list, &(&1))

  defp merge(list), do: merge(list, [], 0)
  defp merge([], output, score), do: {output, score}
  defp merge([ h, h | t ], output, score), do: merge(t, output ++ [ h*2 ], score + h*2)
  defp merge([ h | t ], output, score), do: merge(t, output ++ [ h ], score)

  defp fill_nil(list), do: fill_nil(list, 4 - length(list))
  defp fill_nil(list, 0), do: list
  defp fill_nil(list, n), do: list ++ List.duplicate(nil, n)

  defp rotate_left([ [] | _left ], output), do: output
  defp rotate_left(matrix, output) do
    row = matrix |> Enum.map(&hd/1)
    left_matrix = matrix |> Enum.map(&tl/1)
    rotate_left(left_matrix, [row | output])
  end

  defp rotate_right(matrix, output) do
    rotate_left(matrix, output)
    |> Enum.map(&Enum.reverse/1)
    |> Enum.reverse
  end

end
