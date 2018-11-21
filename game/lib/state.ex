defmodule Game.State do
  defstruct(
    board: %{
      a0: 0, a1: 0, a2: 0, a3: 0, a4: 0, a5: 0,
      b0: 0, b1: 0, b2: 0, b3: 0, b4: 0, b5: 0,
      c0: 0, c1: 0, c2: 0, c3: 0, c4: 0, c5: 0,
      d0: 0, d1: 0, d2: 0, d3: 0, d4: 0, d5: 0
    },
    turn: '',
    game_state: :none
  )



end
