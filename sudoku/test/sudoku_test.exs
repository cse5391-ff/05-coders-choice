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

  test "New game starts with asdfas:initializing status" do
    game = Sudoku.new_game()
    assert game.game_state == :initializing
  end

end

