defmodule TwoPianos.RoomChannel do
  use TwoPianos.Web, :channel
  alias TwoPianos.Presence

  def join("room:lobby", _anon_variable, socket) do
    send self(), :after_join # Sends myself (the current connection) a callback to execute
    {:ok. socket}
  end

  def handle_info(:after_join, socket) do

    Presence.track(socket, socket.assigns.user, %{
      online_at: :os.system_time(:milli_seconds)
    })

    push socket, "presence_state", Presence.list(socket)

    {:noreply, socket}

  end

end
