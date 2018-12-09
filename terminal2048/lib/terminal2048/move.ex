defmodule Terminal2048.Move do

  def move_left(game = %Terminal2048.State{}) do
    row_with_score = game.board
      |> Enum.chunk_every(4)
      |> Enum.map(&leftward_operation(&1))

    board = row_with_score
      |> Enum.map(&List.first/1)
      |> List.flatten

    score = row_with_score
      |> Enum.map(&List.last/1)
      |> List.flatten
      |> Enum.sum

    %Terminal2048.State{ game | board: board, score: score}
  end

  def move_right(game = %Terminal2048.State{}) do
    row_with_score = game.board
      |> Enum.chunk_every(4)
      |> Enum.map(&Enum.reverse/1)
      |> Enum.map(&leftward_operation(&1))

    board = row_with_score
      |> Enum.map(&List.first/1)
      |> Enum.map(&Enum.reverse/1)
      |> List.flatten

    score = row_with_score
      |> Enum.map(&List.last/1)
      |> List.flatten
      |> Enum.sum

    %Terminal2048.State{ game | board: board, score: score}
  end

  def move_up(game = %Terminal2048.State{}) do
    row_with_score = game.board
      |> Enum.chunk_every(4)
      |> rotate_left([])
      |> Enum.map(&leftward_operation(&1))

    board = row_with_score
      |> Enum.map(&List.first/1)
      |> rotate_right([])
      |> List.flatten

    score = row_with_score
      |> Enum.map(&List.last/1)
      |> List.flatten
      |> Enum.sum

    %Terminal2048.State{ game | board: board, score: score}
  end

  def move_down(game = %Terminal2048.State{}) do
    row_with_score = game.board
      |> Enum.chunk_every(4)
      |> rotate_right([])
      |> Enum.map(&leftward_operation(&1))

    board = row_with_score
      |> Enum.map(&List.first/1)
      |> rotate_left([])
      |> List.flatten

    score = row_with_score
      |> Enum.map(&List.last/1)
      |> List.flatten
      |> Enum.sum

    %Terminal2048.State{ game | board: board, score: score}
  end

  def leftward_operation(row) do
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
