defmodule Player do
  def play() do
    play(Sudoku.new_game)
  end

  def play(game) do
    get_next_move(game)
  end

  def get_next_move(game) do
    Sudoku.print_board(game)
    {coord_position, move} = guess()
    game
    |> Sudoku.make_move(coord_position, move)
    |> check_status
  end

  def check_status(game = %GameState{game_state: :victory}) do
    IO.puts("")
    IO.puts("Victory! You solved the Sudoku puzzle!")
  end

  def check_status(game = %GameState{game_state: :bad_coordinate}) do
    IO.puts("")
    IO.puts("You chose an original coordinate! Please try again.")
    get_next_move(game)

  end

  def check_status(game = %GameState{game_state: :bad_move}) do
    IO.puts("")
    IO.puts("You can't put that value there! Please try again.")
    get_next_move(game)
  end

  def check_status(game = %GameState{game_state: :good_move}) do
    IO.puts("")
    IO.puts("Value successfully inserted.")
    get_next_move(game)
  end

  def guess() do
    coord = IO.gets("Enter a coordinate {A-I}{1-9} ex. B3:  ") |> String.upcase |> String.trim
    move = IO.gets("Enter a digit 1-9 for the cell: ex. 4: ") |> String.trim |> String.to_integer

    {coord, move}
  end


end
