defmodule Scope.ChannelReadHelper do
  def read_msgs(channel) do
    Scope.ChatFetcher.get_msgs(channel)
    |> count_msgs
    |> Scope.ChannelRead.update_state(channel)
  end

  def count_msgs(payload) do
    # count number from query
  end
end
