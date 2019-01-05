defmodule ScopeWeb.ChannelView do
  use ScopeWeb, :channel

  #handle join for lobby
  def handle_info(:after_join, socket) do
    {:noreply, socket}
  end

  def handle_in("shout", payload, socket) do
    spawn(fn -> save_msg(payload) end)
    broadcast socket, "shout", payload
    {:noreply, socket}
  end

  defp save_msg(msg) do
    Scope.Message.changeset(%Scope.Message{}, msg) |> Scope.Repo.insert
  end

  def handle_in("channel_switch", channel, socket) do
    update_active_navbar(channel, socket)
    push(socket, "clear_frame", %{})
    #send message to chatroom:topic to load msgs
    push(socket, "load_new_channel", %{new: channel})
    {:noreply, socket}
  end

  def update_active_navbar(channel, socket) do
    push(socket, "update_active_navbar", %{
      active: channel
    })
  end

  def handle_info(:list_channels, socket) do
    Scope.Message.get_channels()
    |> Enum.each(fn msg -> push(socket, "list_channels",
      %{
        channel: msg,
      }) end)
    {:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
