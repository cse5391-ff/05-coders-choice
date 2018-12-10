defmodule Sudoku.Game.Generator do
  @row_mapping %{:A=>0, :B=>1, :C=>2, :D=>3, :E=>4, :F=>5, :G=>6, :H=>7, :I=>8}
  @rows         ["A", "B", "C", "D", "E", "F", "G", "H", "I"]
  @columns      ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
  @difficulty  %{:easy=>60, :medium=>30, :hard=>25}

  # Supervisors
  def start(_type, _args) do
    children = [
      { Sudoku.Game.GeneratePuzzle, %GameState{}}
    ]

    opts = [strategy: :one_for_one, name: Sudoku.Game.Generator.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def new_game() do
    start(nil, nil)
    Sudoku.Game.GeneratePuzzle.generate_puzzle
  end

  #game=%GameState{game_state: :initializing}
  def generate_puzzle(game) do
      generate_values(game, 23)
  end

  def generate_values(game, 0) do
    %GameState{ game |
      game_state: :initializing
    }
  end

  def generate_values(game, num_left) do
    rand_row = @rows    |> Enum.at(Enum.random(0..8))
    rand_col = @columns |> Enum.at(Enum.random(0..8))
    rand_num = Enum.random(1..9)
    coord_str = Enum.join([rand_row, rand_col])

    Enum.member?(game.originals, coord_str)
    |> valid_coord(game, coord_str, rand_num, num_left)
  end

  def valid_coord(true, game, coord, move, num_left) do
    generate_values(game, num_left)
  end

  # VALID COORDINATE, CONTINUE ON
  def valid_coord(false, game, coord, move, num_left) do
    Sudoku.Game.check_valid_move(game, coord, move)
    |> valid_generated_value(game, coord, move, num_left)
  end

  # NOT A VALID VALUE
  def valid_generated_value(false, game, coord, move, num_left) do
    generate_values(game, num_left)
  end

  def valid_generated_value(true, game, coord, move, num_left) do
    # board = put_val(board, coord, move)
    # generate_values(board, [coord | originals], num_left-1)
    %GameState{game |
      originals: [coord | game.originals]
    }
    |> Sudoku.Game.put_val(coord, move)
    |> generate_values(num_left-1)

  end


end
