defmodule Twopianos.UserSocket do
  use Phoenix.Socket

  ## Channels - like web rooms
  channel "room:*", Twopianos.RoomChannel

  ## Transports
  transport :websocket, Phoenix.Transports.WebSocket

  def connect(%{"user" => user}, socket) do
    {:ok, assign(socket, :user, user)}
  end

  def id(_socket), do: nil

end
