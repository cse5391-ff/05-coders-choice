defmodule Connect4Web.GameState do

  def start_link do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def start_player(player) do
    Agent.update(__MODULE__, &Map.put_new(&1, player.id, player))
    player
  end


end
