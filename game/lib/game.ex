defmodule Game do



  def new_game() do
    IO.puts "New Game Started"
    %Game.State{game_state: :init}
  end



end
