defmodule ScopeWeb.ChatRoomChannel do
  use ScopeWeb, :channel

  def join("chat_room:lobby", payload, socket) do
    if authorized?(payload) do
      send(self(), :after_join)
      send(self(), :list_channels)
      updated_socket = Map.put(socket, :channel, "lobby")
      {:ok, updated_socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  def join("chat_room:" <> room_id, payload, socket) do
    if authorized?(payload) do
      #store room id of channel
      send(self(), :after_join)

      # Here we can update the room to be the room they wanted to join.
      {:ok, Map.put(socket, :channel, room_id)}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  def handle_in("change_channel", payload = %{channel: channel}, socket) do
    {:reply, {:ok, payload}, Map.put(socket, :channel, channel)}
  end

  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  def handle_info(:after_join, socket) do
    #get room_id from the socket
    get_msgs(socket.channel, socket)
    {:noreply, socket}
  end

  def get_msgs(channel, socket) do
    Scope.Message.get_msgs_from(channel)
    |> Enum.each(fn msg -> push(socket, "shout",
      %{
        username: msg.username,
        message: msg.message,
        urgency: msg.urgency,
        chatroom: msg.chatroom,
      }) end)
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end

end
