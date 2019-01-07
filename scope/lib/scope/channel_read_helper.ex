defmodule Scope.ChannelReadHelper do
  def read_msgs(msgs) do
    channel = msgs |> get_channel
    msgs
    |> count_msgs
    |> Scope.ChannelRead.update_state(channel)
  end

  def count_msgs(payload) do
    # count number from query

  end

  def get_channel(msgs) do

  end
end
