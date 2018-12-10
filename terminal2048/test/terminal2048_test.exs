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
                 2,  nil,  4,  nil  ]
      game = Terminal2048.Board.new_game |> set_board(board)
      { updated_game, _ } = Terminal2048.Board.make_move(game, :left)
      [ game: updated_game ]
    end

    test "returns the correct status", c do
      assert c.game.game_state == :continue
      assert c.game.score      == 4
    end
  end

  describe "move right" do
    setup do
      board = [ nil,  2,  nil,  2,
                nil,  4,  nil,  2,
                 2,  nil,  4,  nil,
                 2,  nil,  4,  nil  ]
      game = Terminal2048.Board.new_game |> set_board(board)
      { updated_game, _ } = Terminal2048.Board.make_move(game, :right)
      [ game: updated_game ]
    end

    test "returns the correct status", c do
      assert c.game.game_state == :continue
      assert c.game.score      == 4
    end
  end

  describe "move up" do
    setup do
      board = [ nil,  2,  nil,  2,
                nil,  4,  nil,  2,
                 2,  nil,  4,  nil,
                 2,  nil,  4,  nil  ]
      game = Terminal2048.Board.new_game |> set_board(board)
      { updated_game, _ } = Terminal2048.Board.make_move(game, :up)
      [ game: updated_game ]
    end

    test "returns the correct status", c do
      assert c.game.game_state == :continue
      assert c.game.score      == 16
    end
  end

  describe "move down" do
    setup do
      board = [ nil,  2,  nil,  2,
                nil,  4,  nil,  2,
                 2,  nil,  4,  nil,
                 2,  nil,  4,  nil  ]
      game = Terminal2048.Board.new_game |> set_board(board)
      { updated_game, _ } = Terminal2048.Board.make_move(game, :down)
      [ game: updated_game ]
    end

    test "returns the correct status", c do
      assert c.game.game_state == :continue
      assert c.game.score      == 16
    end
  end

  describe "no move" do
    setup do
      board = [ 2,  nil, nil, nil,
                4,   2,  nil, nil,
                8,   4,   2,  nil,
                16,  8,   4,   2   ]
      game = Terminal2048.Board.new_game |> set_board(board)
      { updated_game, _ } = Terminal2048.Board.make_move(game, :left)
      [ game: updated_game ]
    end

    test "returns the correct status", c do
      assert c.game.game_state == :no_move
      assert c.game.board      == [ 2,  nil, nil, nil,
                                    4,   2,  nil, nil,
                                    8,   4,   2,  nil,
                                    16,  8,   4,   2   ]
      assert c.game.score      == 0
    end
  end

  describe "lost game" do
    setup do
      board = [ 2,  4,  8,  16,
                16, 32, 64, 128,
                2,  4,  8,  16,
                16, 32, 64, nil  ]
      game = Terminal2048.Board.new_game |> set_board(board)
      { updated_game, _ } = Terminal2048.Board.make_move(game, :down)
      [ game: updated_game ]
    end

    test "returns the correct status", c do
      assert c.game.game_state == :lost
      assert c.game.score      == 0
    end
  end

  describe "won game" do
    setup do
      board = [  32,  nil, nil, nil,
                 64,  nil, nil, nil,
                1024, 16,  nil, nil,
                1024, 32,   4,   2   ]
      game = Terminal2048.Board.new_game |> set_board(board)
      { updated_game, _ } = Terminal2048.Board.make_move(game, :down)
      [ game: updated_game ]
    end

    test "returns the correct status", c do
      assert c.game.game_state == :won
      assert c.game.score      == 2048
    end
  end

  defp set_board(game, board) do
    %Terminal2048.State{ game |
      board: board
    }
  end
end
