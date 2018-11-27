defmodule Game do



  def new_game() do
    IO.puts "New Game Started"
    %Game.State{game_state: :init, turn: "R"}
  end

  def play(game, new_move) do
    # IO.inspect(new_move)
    g = Game.State.determine_result(game, new_move)
    g
  end

end
