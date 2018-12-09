defmodule Terminal2048.Player do

  def play() do
    {:ok, game} = Game.start_link
    Port.open({:spawn, "tty_sl -c -e"}, [:binary, :eof])

    # reference: https://cultivatehq.com/posts/pseudo-random-number-generator-in-elixir/
    << a :: 32, b :: 32, c :: 32 >> = :crypto.rand_bytes(12)
    :random.seed(a, b, c)

    play(game)
  end

  defp play(game) do
    IO.write([clear_screen(), render(game)])
    move(game)
    play(game)
  end

  defp clear_screen(), do: [ IO.ANSI.home, IO.ANSI.clear ]
  defp render(game), do: Game.state(game) |> inspect

  defp move(game) do
    receive do
      {_port, {:data, data}} ->
        data
        |> get_next_move()
        |> handle_key(game)
        :ok
      _ ->
        :ok
    end
  end

  defp get_next_move("\e[A"), do: :up
  defp get_next_move("\e[B"), do: :down
  defp get_next_move("\e[C"), do: :left
  defp get_next_move("\e[D"), do: :right
  defp get_next_move(_),      do: nil

  defp handle_key(nil, _), do: :ok
  defp handle_key(key, game), do: Game.move(game, key)

end
