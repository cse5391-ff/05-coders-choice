defmodule Sudoku do
  @moduledoc """
  Sudoku keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  defdelegate new_game(), to: Sudoku.Game.Generator
  defdelegate print_board(game), to: Sudoku.Game
  defdelegate make_move(game, guess, move), to: Sudoku.Game

end
