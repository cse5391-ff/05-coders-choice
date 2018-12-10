defmodule GameState do
  defstruct game_state: :initializing,
            board: (for _ <- 0..8, do: (for _ <- 0..8, do: 0)),
            originals: []
end

defmodule Sudoku.Game do

  @row_mapping %{:A=>0, :B=>1, :C=>2, :D=>3, :E=>4, :F=>5, :G=>6, :H=>7, :I=>8}
  @rows         ["A", "B", "C", "D", "E", "F", "G", "H", "I"]
  @columns      ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
  @difficulty  %{:easy=>40, :medium=>30, :hard=>25}

  def check_valid_move(game, coord, move) do
    [r, c] = coord |> coord_split
    # Used "tester" here to make the last line of this function easier to read
    tester = game
    |> put_val(coord, move)
    (tester |> check_column(c)) && (tester |> check_row(r)) && (tester |> check_group(r, c))
  end

  # def check_full(game) do
  #   all_vals = for r <- 0..8 do
  #     for c <- 0..8 do
  #       game.board
  #       |> Enum.at(r)
  #       |> Enum.at(c)
  #     end
  #   end

  #   all_vals
  #   |> List.flatten()
  #   |> Enum.member?(0)
  # end

  # board = Sudoku.Game.new_game()
  # board = Sudoku.Game.make_move(board, "A1", 9)


  # Sudoku.Game.check_row(board, 8)
  def check_column(game, col) do
    col_vals = for r <- 0..8, do: game.board |> Enum.at(r) |> Enum.at(col)
    col_vals |> check_valid()
  end

  # Sudoku.Game.check_row(board, 0)
  def check_row(game, row) do
    reduced = game.board
    |> Enum.at(row)
    |> check_valid()
  end

  def check_group(game, row, col) do
    row_it = div(row, 3) * 3
    col_it = div(col, 3) * 3
    row_lim = row_it + 2
    col_lim = col_it + 2

    group_vals = for r <- row_it..row_lim do
      for c <- col_it..col_lim do
        game.board
        |> Enum.at(r)
        |> Enum.at(c)
      end
    end

    group_vals
    |> List.flatten()
    |> check_valid()
  end

  defp check_valid(list) do
    reduced = list |> Enum.filter(fn x -> x != 0 end)
    uniques = reduced |> Enum.uniq()

    reduced == uniques
  end

  # If every value is non-zero, then check for a win.
  def check_win(game) do
    game.board
    |> List.flatten()
    |> Enum.member?(0)
    |> game_won(game)
  end

  def game_won(true, game) do
    game
  end

  def game_won(false, game) do
    %GameState{ game |
      game_state: :victory
    }
  end

  # Add a move to the board
  def make_move(game, coord, move) do
    valid_coord = coord
    |> String.match?(~r/[a-iA-I][1-9]$/)

    not_original = game.originals |> Enum.member?(coord) |> Kernel.not

    valid_move = move
    |> Integer.to_string

    valid_move = @columns
    |> Enum.member?(valid_move)

    game
    |> try_move(coord, move, (valid_coord && not_original), valid_move)
    |> check_win()
  end

  # Regex: // ~r/[A-I][1-9]/
  defp try_move(game, coord, move, true, true) do
    check_valid_move(game, coord, move)
    |> valid_user_move(game, coord, move)
  end

  defp try_move(game, _string, _move, false, true) do
    %GameState{game |
      game_state: :bad_coordinate
    }
  end


  defp try_move(game, _string, _move, true, false) do
    %GameState{game |
      game_state: :bad_move
    }
  end

  defp try_move(game, _string, _move, _valid_coord, _valid_move) do
    %GameState{game |
      game_state: :invalid_both
    }
  end

  def valid_user_move(false, game, coord, move) do
    %GameState{game |
      game_state: :bad_stuff
    }
  end

  def valid_user_move(true, game, coord, move) do
    put_val(game, coord, move)
  end


  # Get value at coordinate
  def get_val(game, coord) do
    [r, c] = coord |> coord_split

    game.board
    |> Enum.at(r)
    |> Enum.at(c)
  end

  def put_val(game=%GameState{}, coord, val) do
    [r, c] = coord |> coord_split

    temp = game.board |> List.replace_at(r, game.board |> Enum.at(r) |> List.replace_at(c, val))

    %GameState{ game |
      game_state: :good_move,
      board: temp
    }
  end

  # Split coordinate into corresponding atom and integer
  def coord_split(coord) do
    [r, c] = coord
    |> String.capitalize()
    |> String.codepoints()

    [@row_mapping[r |> String.to_atom], (c |> String.to_integer) - 1]
  end

  # Display the board to the user
  def print_board(game) do
    # This is the ugly way of doing it but it works for now
    IO.puts(
      "
           1 2 3   4 5 6   7 8 9
         -------------------------
       A | #{get_val(game, "A1")} #{get_val(game, "A2")} #{get_val(game, "A3")} | #{get_val(game, "A4")} #{get_val(game, "A5")} #{get_val(game, "A6")} | #{get_val(game, "A7")} #{get_val(game, "A8")} #{get_val(game, "A9")} |
       B | #{get_val(game, "B1")} #{get_val(game, "B2")} #{get_val(game, "B3")} | #{get_val(game, "B4")} #{get_val(game, "B5")} #{get_val(game, "B6")} | #{get_val(game, "B7")} #{get_val(game, "B8")} #{get_val(game, "B9")} |
       C | #{get_val(game, "C1")} #{get_val(game, "C2")} #{get_val(game, "C3")} | #{get_val(game, "C4")} #{get_val(game, "C5")} #{get_val(game, "C6")} | #{get_val(game, "C7")} #{get_val(game, "C8")} #{get_val(game, "C9")} |
         --------+-------+--------
       D | #{get_val(game, "D1")} #{get_val(game, "D2")} #{get_val(game, "D3")} | #{get_val(game, "D4")} #{get_val(game, "D5")} #{get_val(game, "D6")} | #{get_val(game, "D7")} #{get_val(game, "D8")} #{get_val(game, "D9")} |
       E | #{get_val(game, "E1")} #{get_val(game, "E2")} #{get_val(game, "E3")} | #{get_val(game, "E4")} #{get_val(game, "E5")} #{get_val(game, "E6")} | #{get_val(game, "E7")} #{get_val(game, "E8")} #{get_val(game, "E9")} |
       F | #{get_val(game, "F1")} #{get_val(game, "F2")} #{get_val(game, "F3")} | #{get_val(game, "F4")} #{get_val(game, "F5")} #{get_val(game, "F6")} | #{get_val(game, "F7")} #{get_val(game, "F8")} #{get_val(game, "F9")} |
         --------+-------+--------
       G | #{get_val(game, "G1")} #{get_val(game, "G2")} #{get_val(game, "G3")} | #{get_val(game, "G4")} #{get_val(game, "G5")} #{get_val(game, "G6")} | #{get_val(game, "G7")} #{get_val(game, "G8")} #{get_val(game, "G9")} |
       H | #{get_val(game, "H1")} #{get_val(game, "H2")} #{get_val(game, "H3")} | #{get_val(game, "H4")} #{get_val(game, "H5")} #{get_val(game, "H6")} | #{get_val(game, "H7")} #{get_val(game, "H8")} #{get_val(game, "H9")} |
       I | #{get_val(game, "I1")} #{get_val(game, "I2")} #{get_val(game, "I3")} | #{get_val(game, "I4")} #{get_val(game, "I5")} #{get_val(game, "I6")} | #{get_val(game, "I7")} #{get_val(game, "I8")} #{get_val(game, "I9")} |
         -------------------------
      "
    )
  end





end
