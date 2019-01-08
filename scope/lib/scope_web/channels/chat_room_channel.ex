defmodule ScopeWeb.ChatRoomChannel do
  use ScopeWeb, :channel
  @moduledoc """
    ChatRoomChannel processes all socket calls
    and allows new channel joins and
    message sends via websockets

    Note: chatroom and channel are used interchangably,
    though Phoenix Channels connect to the socket via JS.
  """

  def join("chat_room:" <> room_id, _payload, socket) do
      #store room id of channel (chatroom)
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

  # update the highlighted channel DOM Object
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

  # joining channel calls DOM objects to reflect
  # new connection. Updates all states.
  def handle_info(:after_join, socket) do
    channel = socket.assigns[:channel]
    update_active_navbar(channel, socket)
    load_msgs(channel, socket)
    {:noreply, socket}
  end

  def load_msgs(channel, socket) do
    # push messages and update read status
    msgs = get_msgs(channel)
    msgs
    |> send_msgs_to_socket(socket)

    msgs
    |> read_msgs(socket)

  end

  def read_msgs(msgs, _socket) when msgs == nil, do: IO.puts("no messages found.")

  def read_msgs(msgs, socket) do
    msgs
    |> Scope.ChannelReadHelper.read_msgs
    |> Enum.each(fn {channel, unread} -> push(socket, "read_channel",
      %{
        channel: channel,
        unread: unread
      }) end)
  end

  def get_msgs(channel) do
    Scope.ChatFetcher.get_msgs(channel)
  end

  def send_msgs_to_socket(msgs, socket) do
    msgs
    |> Enum.each(fn msg -> push(socket, "shout",
      %{
        username: msg.username,
        message: msg.message,
        urgency: msg.urgency,
        chatroom: msg.chatroom,
      }) end)
  end

end
