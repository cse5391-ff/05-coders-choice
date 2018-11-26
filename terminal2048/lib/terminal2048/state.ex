defmodule Terminal2048.State do
  defstruct(
    game_state: :initializing,
    board: nil,
    score: 0
  )
end
