defmodule Terminal2048.Player do

  def play() do
    play(Terminal2048.Board.new_game)
  end

  defp play(game) do
    get_next_move({game, game.game_state})
  end

  defp get_next_mmove({game, :lost}) do
    draw_current_board(game)
    IO.puts("\nSorry, you lose.")
  end

  def get_next_move({game, _game_state}) do
    draw_current_board(game)
    #report_move_status(game_state)
    move = "\nMake your move: "
      |> IO.gets
      |> String.downcase
      |> String.trim
      |> get_move

    Terminal2048.Board.make_move(game, move)
    |> get_next_move
  end

  def draw_current_board(game) do
    clear_screen()
    IO.puts(Terminal2048.Board.draw_current_board(game))
  end

  defp clear_screen(), do: IO.write("\e[H\e[2J")

  defp get_move("w"), do: :up
  defp get_move("s"), do: :down
  defp get_move("a"), do: :left
  defp get_move("d"), do: :right
  defp get_move(_),   do: nil

end
