defmodule Scope.ChannelReadHelper do

  def read_msgs(msgs) do
    msgs
    |> get_channel
    |> Scope.ChannelRead.update_state(count_msgs(msgs))

    IO.inspect print_new_unread()
  end

  def get_channel(msgs) do
    {:ok, msg_map} = msgs
    |> Enum.fetch(0)
    msg_map.chatroom
  end

  def count_msgs(msgs) do
    # count number from query
    msgs
    |> Enum.count
  end

  def print_new_unread() do
    # find difference of (total - unread) messages for each channel
    Scope.ChatFetcher.get_msgs_count()
    |> Enum.into(%{})
    |> calc_difference(Scope.ChannelRead.get())
    |> remove_all_reads
  end

  def calc_difference(total, read) do
    total
    |> Map.merge(read, fn _k, v1, v2 ->
                  v1 - v2
                end)
  end

  def remove_all_reads(unread) do
    unread
    |> Enum.filter(fn {_k, v} ->v != 0 end)
    |> Enum.into(%{})
  end
end
