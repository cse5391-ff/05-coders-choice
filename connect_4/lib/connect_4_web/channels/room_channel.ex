defmodule Connect4Web.RoomChannel do

  use Phoenix.Channel

  def join("c4:common", _message, socket) do
    game = Game.new_game()
    socket =
      socket
      |> assign(:game, game)
    { :ok, socket }
  end

  def handle_in("turn_played", msg, socket) do
    game = socket.assigns[:game];
    g = Game.play(game, msg);
    socket =
      socket
      |> assign(:game, g)
    broadcast!(socket, "echo", g)
    {:reply, {:ok, g}, socket}

  end

  def handle_in("new_game", _msg, socket) do
    game = Game.new_game()
    socket =
      socket
      |> assign(:game, game)
    broadcast!(socket, "echo", game)
    {:reply, {:ok, game}, socket}
  end





end
