defmodule Terminal2048Test do
  use ExUnit.Case
  doctest Terminal2048

  describe "a new game" do

    setup do
      [ game: Terminal2048.Board.new_game ]
    end

    test "has a reasonable status", c do
      assert c.game.game_state    == :initializing
      assert length(c.game.board) == 16
      assert c.game.score         == 0
    end
  end

  describe "move left" do
    setup do
      board = [ nil,  2,  nil,  2,
                nil,  4,  nil,  2,
                 2,  nil,  4,  nil,
                 2,  nil,  4,  nil ]
      game = Terminal2048.Board.new_game |> set_board(board)
      { updated_game, updated_game_state } = Terminal2048.Board.make_move(game, :left)
      [ game: updated_game ]
    end

    test "returns the correct status", c do
      assert c.game.game_state  == :continue
      assert c.game.score       == 4
    end
  end

  describe "move right" do
    setup do
      board = [ nil,  2,  nil,  2,
                nil,  4,  nil,  2,
                 2,  nil,  4,  nil,
                 2,  nil,  4,  nil ]
      game = Terminal2048.Board.new_game |> set_board(board)
      { updated_game, updated_game_state } = Terminal2048.Board.make_move(game, :right)
      [ game: updated_game ]
    end

    test "returns the correct status", c do
      assert c.game.game_state  == :continue
      assert c.game.score       == 4
    end
  end

  describe "move up" do
    setup do
      board = [ nil,  2,  nil,  2,
                nil,  4,  nil,  2,
                 2,  nil,  4,  nil,
                 2,  nil,  4,  nil ]
      game = Terminal2048.Board.new_game |> set_board(board)
      { updated_game, updated_game_state } = Terminal2048.Board.make_move(game, :up)
      [ game: updated_game ]
    end

    test "returns the correct status", c do
      assert c.game.game_state  == :continue
      assert c.game.score       == 16
    end
  end

  describe "move down" do
    setup do
      board = [ nil,  2,  nil,  2,
                nil,  4,  nil,  2,
                 2,  nil,  4,  nil,
                 2,  nil,  4,  nil ]
      game = Terminal2048.Board.new_game |> set_board(board)
      { updated_game, updated_game_state } = Terminal2048.Board.make_move(game, :down)
      [ game: updated_game ]
    end

    test "returns the correct status", c do
      assert c.game.game_state  == :continue
      assert c.game.score       == 16
    end
  end

  defp set_board(game, board) do
    %Terminal2048.State{ game |
      game_state: :continue,
      board: board
    }
  end
end
