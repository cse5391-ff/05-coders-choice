defmodule ScopeWeb.ChatRoomChannel do
  use ScopeWeb, :channel

  def join("chat_room:lobby", payload, socket) do
    if authorized?(payload) do
      updated_socket = socket
                       |>assign(:channel, "lobby")
      send(self(), :after_join)
      send(self(), :list_channels)
      {:ok, updated_socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  def join("chat_room:" <> room_id, payload, socket) do
    if authorized?(payload) do
      #store room id of channel
      socket = socket
               |>assign(:channel, room_id)
      IO.puts socket.assigns[:channel]

      send(self(), :after_join)

      # Here we can update the room to be the room they wanted to join.
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  # def handle_in("change_channel", payload = %{channel: channel}, socket) do
  #   IO.puts channel
  #   update_active_navbar(channel, socket)
  #   push(socket, "clear_frame", %{})
  #   push(socket, "load_new_channel", %{new: channel})
  #   {:noreply, socket
  #              |>assign(:channel, channel)}
  # end

  def handle_in("shout", payload, socket) do
    spawn(fn -> Scope.ChatFetcher.save_msg(payload) end)
    push(socket, "shout", payload)
    {:noreply, socket}
  end

  def update_active_navbar(channel, socket) do
    push(socket, "update_active_navbar", %{
      active: channel
    })
  end

  def handle_info(:list_channels, socket) do
    Scope.ChannelListFetcher.get_channels()
    |> Enum.each(fn msg -> push(socket, "list_channels",
      %{
        channel: msg,
      }) end)
    {:noreply, socket}
  end

  def handle_info(:after_join, socket) do
    #get room_id from the socket
    get_msgs(socket.assigns[:channel], socket)
    # |> Scope.ChannelReadHelper.read_msgs
    {:noreply, socket}
  end

  def get_msgs(channel, socket) do
    msgs = Scope.ChatFetcher.get_msgs(channel)
    msgs
    |> Enum.each(fn msg -> push(socket, "shout",
      %{
        username: msg.username,
        message: msg.message,
        urgency: msg.urgency,
        chatroom: msg.chatroom,
      }) end)
    msgs

  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end

end
