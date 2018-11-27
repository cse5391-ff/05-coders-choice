defmodule GameTest do
  use ExUnit.Case
  doctest Game

  test "Check Initial Data" do
    assert Game.new_game().game_state == :init
    assert Game.new_game().turn == "R"
  end

  test "New Move" do
    game = %Game.State{
      game_state: :init,
      turn: "R",
      count: 0,
      board: [
        0,0,0,0,0,0,
        0,0,0,0,0,0,
        0,0,0,0,0,0,
        0,0,0,0,0,0
      ]
    }

    new_move = %{
      "board" => [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "R", "B", 0,
       0, 0, 0],
      "diag" => [
        [0, 0, 0, "R"],
        [0, 0, 0, "B"],
        [0, 0, 0, 0],
        [0, 0, 0, 0],
        [0, 0, 0, 0],
        [0, 0, 0, 0]
      ],
      "turn" => "B"
    }

    assert %Game.State{game_state: :new_move} = Game.play(game, new_move)
  end

  test "Win Vertical" do
    game = %Game.State{
      game_state: :init,
      turn: "R",
      count: 0,
      board: [
        0,0,0,0,0,0,
        0,0,0,0,0,0,
        0,0,0,0,0,0,
        0,0,0,0,0,0
      ]
    }

    new_move = %{
      "board" => [
        "R", 0, 0, 0, 0, 0,
        "R", 0, 0, 0, 0, 0,
        "R", 0, 0, 0, 0, 0,
        "R","B", 0, 0, 0, 0],
      "diag" => [
        [0, 0, 0, "R"],
        [0, 0, 0, "B"],
        [0, 0, 0, 0],
        [0, 0, 0, 0],
        [0, 0, 0, 0],
        [0, 0, 0, 0]
      ],
      "turn" => "R"
    }

    assert %Game.State{game_state: :win} = Game.play(game, new_move)
  end

  test "Win Horizontal" do
    game = %Game.State{
      game_state: :init,
      turn: "R",
      count: 0,
      board: [
        0,0,0,0,0,0,
        0,0,0,0,0,0,
        0,0,0,0,0,0,
        0,0,0,0,0,0
      ]
    }

    new_move = %{
      "board" => [
        "R", "R", "R", "R", 0, 0,
        "R", 0, 0, 0, 0, 0,
        "B", 0, 0, 0, 0, 0,
        "R","B", 0, 0, 0, 0],
      "diag" => [
        [0, 0, 0, "R"],
        [0, 0, 0, "B"],
        [0, 0, 0, 0],
        [0, 0, 0, 0],
        [0, 0, 0, 0],
        [0, 0, 0, 0]
      ],
      "turn" => "R"
    }

    assert %Game.State{game_state: :win} = Game.play(game, new_move)
  end


  test "Win Diagnol" do
    game = %Game.State{
      game_state: :init,
      turn: "R",
      count: 0,
      board: [
        0,0,0,0,0,0,
        0,0,0,0,0,0,
        0,0,0,0,0,0,
        0,0,0,0,0,0
      ]
    }

    new_move = %{
      "board" => [
        "R", "R", "R", "B", 0, 0,
        "R", 0, 0, 0, 0, 0,
        "B", 0, 0, 0, 0, 0,
        "R","B", 0, 0, 0, 0],
      "diag" => [
        ["R", "R", "R", "R"],
        [0, 0, 0, "B"],
        [0, 0, 0, 0],
        [0, 0, 0, 0],
        [0, 0, 0, 0],
        [0, 0, 0, 0]
      ],
      "turn" => "R"
    }

    assert %Game.State{game_state: :win} = Game.play(game, new_move)
  end

  test "Tie Game" do
    game = %Game.State{
      game_state: :init,
      turn: "R",
      count: 0,
      board: [
        0,0,0,0,0,0,
        0,0,0,0,0,0,
        0,0,0,0,0,0,
        0,0,0,0,0,0
      ]
    }

    new_move = %{
      "board" => [
        "R", "R", "R", "B", "B", "B",
        "R", "B", "B", "R", "R", "R",
        "B", "B", "R", "R", "R", "B",
        "R", "B", "R", "B", "B", "B"],
      "diag" => [
        ["R", "R", "R", "B"],
        [0, 0, 0, "B"],
        [0, 0, 0, 0],
        [0, 0, 0, 0],
        [0, 0, 0, 0],
        [0, 0, 0, 0]
      ],
      "turn" => "R"
    }

    assert %Game.State{game_state: :tie} = Game.play(game, new_move)
  end

end
