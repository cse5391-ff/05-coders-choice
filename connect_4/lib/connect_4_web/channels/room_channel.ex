defmodule Connect4Web.RoomChannel do

  use Phoenix.Channel

  def join("c4:common", _message, socket) do
    { :ok, socket }
  end

  # def handle_in("keypress", msg, socket) do
  #   broadcast!(socket, "echo", msg)
  #   {:reply, {:ok, msg}, socket}

  # end



end
