defmodule Terminal2048.Board do

  def new_game(game = %Terminal2048.State{}) do
    %Terminal2048.State{ game |
      board: game.board |> random_number |> random_number
    }
  end

  defp random_number(board) do

  end
end
