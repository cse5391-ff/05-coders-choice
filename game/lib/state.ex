defmodule Game.State do
  defstruct(
    board: [
      0,0,0,0,0,0,
      0,0,0,0,0,0,
      0,0,0,0,0,0,
      0,0,0,0,0,0
    ],
    turn: "",
    game_state: :none
  )

  def determine_result(board, new_move) do
    # IO.inspect(new_move["board"])
    %{board | game_state: :new_move, board: new_move["board"], turn: new_move["turn"]}
  end

end
