defmodule Sudoku.Game do
  # To-Do:
  # Generate board function
  # Check board function
  #   contains: check column, check row, check group

  # put move
  # print board

  # Useful lower-level commands so far:
  # board = Sudoku.Game.new_game()
  # board = Sudoku.Game.add_move(board, "A9", 2)
  # Sudoku.Game.print_board(board)

  def new_game() do
    # To-do:
    instantiate_board()
    |> generate_puzzle()
  end

  # The gist of the general algorithm:
  #   1. Assumption: Given the rules of sudoku, given a 9x9 board that can be broken up
  #      into 3x3 segments, the first 3 diagonal 3x3 segments can be randomly generated with numbers 1-9
  #      with no collisions.
  #   2. After the first 3 3x3 diagonal segments are generated, randomly populate each other 3x3 segment
  #      in the board. At each individual square, check to see if there are column collisions or row collisions.
  #   3. Remove elements to complete the "puzzle". There are smart ways to do this and dumb ways to do this.

  # Next steps:
  # 1. Add validation to the "add move" that can't overwrite original generated values
  # 2. Perhaps create a game struct that contains the board.
  # 3. Add concurrency
  # 4. Create GUI for webapp

  @rows   'ABCDEFGHI'
  @columns '123456789'

  def generate_puzzle(board) do
    for row <- @rows do
       for col <- @columns do
        r = List.to_string([row])
        c = List.to_string([col])
        # IO.puts(r)
        # IO.puts(c)
        board = add_move(board, Enum.join([r, c]), Enum.random(1..9))
       end
    end
  end

  def check_column(board, val) do

  end

  def check_row(board, val) do

  end

  def check_group(board, val) do

  end

  # If every value is non-zero, then check for a win.
  def check_win(board) do

  end

  # To-do with add move:
  # once check_group, check_row, and check_column is implemented, integrate this into validity checking
  # for add_move.

  def add_move(board, coord, move) do
    valid_coord = coord
    |> String.match?(~r/[a-iA-I][1-9]$/)

    valid_move = move
    |> Integer.to_string
    |> String.match?(~r/[1-9]$/)

    board
    |> try_move(coord, move, valid_coord, valid_move)
  end

  # Regex: // ~r/[A-I][1-9]/
  def try_move(board, coord, move, true, true) do
    [r, c] = coord
    |> String.capitalize()
    |> String.codepoints()
    row = r |> String.to_atom
    Kernel.put_in(board[row][c], move)
  end

  def try_move(_board, _string, _move, false, true) do
    IO.puts("Invalid coordinate placement!")
    :invalid_coord
  end

  def try_move(_board, _string, _move, true, false) do
    IO.puts("Invalid value!")
    :invalid_value
  end

  def try_move(_board, _string, _move, _valid_coord, _valid_move) do
    IO.puts("Invalid coordinate placement and value!")
    :invalid_both
  end

  def instantiate_board() do
    _board = %{
      A: %{"1" => 0, "2" => 0, "3" => 0,   "4" => 0, "5" => 0, "6" => 0,   "7" => 0, "8" => 0, "9" => 0},
      B: %{"1" => 0, "2" => 0, "3" => 0,   "4" => 0, "5" => 0, "6" => 0,   "7" => 0, "8" => 0, "9" => 0},
      C: %{"1" => 0, "2" => 0, "3" => 0,   "4" => 0, "5" => 0, "6" => 0,   "7" => 0, "8" => 0, "9" => 0},

      D: %{"1" => 0, "2" => 0, "3" => 0,   "4" => 0, "5" => 0, "6" => 0,   "7" => 0, "8" => 0, "9" => 0},
      E: %{"1" => 0, "2" => 0, "3" => 0,   "4" => 0, "5" => 0, "6" => 0,   "7" => 0, "8" => 0, "9" => 0},
      F: %{"1" => 0, "2" => 0, "3" => 0,   "4" => 0, "5" => 0, "6" => 0,   "7" => 0, "8" => 0, "9" => 0},

      G: %{"1" => 0, "2" => 0, "3" => 0,   "4" => 0, "5" => 0, "6" => 0,   "7" => 0, "8" => 0, "9" => 0},
      H: %{"1" => 0, "2" => 0, "3" => 0,   "4" => 0, "5" => 0, "6" => 0,   "7" => 0, "8" => 0, "9" => 0},
      I: %{"1" => 0, "2" => 0, "3" => 0,   "4" => 0, "5" => 0, "6" => 0,   "7" => 0, "8" => 0, "9" => 0},
    }
  end

  # Utility function for printing board on command line (to see if my stuff is working)
  def print_board(board) do
    IO.puts(
      "
           1 2 3   4 5 6   7 8 9
         -------------------------
       A | #{board[:A]["1"]} #{board[:A]["2"]} #{board[:A]["3"]} | #{board[:A]["4"]} #{board[:A]["5"]} #{board[:A]["6"]} | #{board[:A]["7"]} #{board[:A]["8"]} #{board[:A]["9"]} |
       B | #{board[:B]["1"]} #{board[:B]["2"]} #{board[:B]["3"]} | #{board[:B]["4"]} #{board[:B]["5"]} #{board[:B]["6"]} | #{board[:B]["7"]} #{board[:B]["8"]} #{board[:B]["9"]} |
       C | #{board[:C]["1"]} #{board[:C]["2"]} #{board[:C]["3"]} | #{board[:C]["4"]} #{board[:C]["5"]} #{board[:C]["6"]} | #{board[:C]["7"]} #{board[:C]["8"]} #{board[:C]["9"]} |
         --------+-------+--------
       D | #{board[:D]["1"]} #{board[:D]["2"]} #{board[:D]["3"]} | #{board[:D]["4"]} #{board[:D]["5"]} #{board[:D]["6"]} | #{board[:D]["7"]} #{board[:D]["8"]} #{board[:D]["9"]} |
       E | #{board[:E]["1"]} #{board[:E]["2"]} #{board[:E]["3"]} | #{board[:E]["4"]} #{board[:E]["5"]} #{board[:E]["6"]} | #{board[:E]["7"]} #{board[:E]["8"]} #{board[:E]["9"]} |
       F | #{board[:F]["1"]} #{board[:F]["2"]} #{board[:F]["3"]} | #{board[:F]["4"]} #{board[:F]["5"]} #{board[:F]["6"]} | #{board[:F]["7"]} #{board[:F]["8"]} #{board[:F]["9"]} |
         --------+-------+--------
       G | #{board[:G]["1"]} #{board[:G]["2"]} #{board[:G]["3"]} | #{board[:G]["4"]} #{board[:G]["5"]} #{board[:G]["6"]} | #{board[:G]["7"]} #{board[:G]["8"]} #{board[:G]["9"]} |
       H | #{board[:H]["1"]} #{board[:H]["2"]} #{board[:H]["3"]} | #{board[:H]["4"]} #{board[:H]["5"]} #{board[:H]["6"]} | #{board[:H]["7"]} #{board[:H]["8"]} #{board[:H]["9"]} |
       I | #{board[:I]["1"]} #{board[:I]["2"]} #{board[:I]["3"]} | #{board[:I]["4"]} #{board[:I]["5"]} #{board[:I]["6"]} | #{board[:I]["7"]} #{board[:I]["8"]} #{board[:I]["9"]} |
         -------------------------

      "

    )
  end





end
