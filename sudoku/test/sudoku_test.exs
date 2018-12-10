defmodule SudokuTest do
  use ExUnit.Case
  doctest Sudoku

  test "the truth" do
    assert 1 + 2 == 2 + 1
  end

  test "Initialize game" do
    Sudoku.new_game()
  end

  test "New game starts with :initializing status" do
    game = Sudoku.new_game()
    assert game.game_state == :initializing
  end

  test "Makes a guess" do
    game = Sudoku.new_game()
    game = Sudoku.make_move(game, "A1", 0)
    assert game.game_state
  end

  test "Successfully puts a guess" do
    game = Sudoku.new_game()
    game = Sudoku.Game.put_val(game, "A1", 2)
    assert game.board
  end

end

