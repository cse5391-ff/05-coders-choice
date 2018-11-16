defmodule Terminal2048.State do
  defstruct(
    game_state: :initializing,
    board: List.duplicate(nil, 4) |> List.duplicate(4),
    score: 0
  )
end
