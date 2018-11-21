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

    broadcast!(socket, "echo", msg)
    {:reply, {:ok, msg}, socket}

  end





end
