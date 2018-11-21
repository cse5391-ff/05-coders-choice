defmodule Game do



  def new_game() do
    IO.puts "New Game Started"
    %Game.State{game_state: :init}
  end

  def play(game, new_move) do
    g = Game.State.determine_result(game, new_move)
    g
  end

end
