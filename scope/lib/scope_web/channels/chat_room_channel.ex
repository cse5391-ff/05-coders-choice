defmodule ScopeWeb.ChatRoomChannel do
  use ScopeWeb, :channel

  def join("chat_room:" <> room_id, payload, socket) do
      #store room id of channel
      socket = socket
               |>assign(:channel, room_id)

      send(self(), :list_channels)
      send(self(), :after_join)

      {:ok, socket}
  end

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
    Scope.ChatFetcher.get_channels()
    |> Enum.each(fn msg -> push(socket, "list_channels",
      %{
        channel: msg,
      }) end)
    {:noreply, socket}
  end

  def handle_info(:after_join, socket) do
    channel = socket.assigns[:channel]
    update_active_navbar(channel, socket)
    #get room_id from the socket
    unread_map = get_msgs(channel, socket)
    |> Scope.ChannelReadHelper.read_msgs
    |> Enum.each(fn {channel, unread} -> push(socket, "read_channel",
      %{
        channel: channel,
        unread: unread
      }) end)
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

end
