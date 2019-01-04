# defmodule ScopeWeb.ChannelView do
#   use GenServer

#   def handle_info(:list_channels, socket) do
#     Scope.Message.get_channels()
#     |> Enum.each(fn msg -> push(socket, "shout",
#     %{
#       channel: msg.channel,
#     }) end)
#   {:noreply, socket}
#   end
# end
