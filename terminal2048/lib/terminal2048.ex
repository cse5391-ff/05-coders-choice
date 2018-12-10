defmodule Terminal2048 do
  @doc """
  This is how you start an interactive game of Terminal2048. Call
      Terminal2048.play
  and it will create a new game, show you the current state, and
  then interact with you as you make moves.
  """
  defdelegate play(), to: Terminal2048.Player
end
