defmodule Scope.ChannelRead do
  use Agent

  def start_link(_opts) do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def get(read_msgs_count, channel) do
    Agent.get(read_msgs_count, &Map.get(&1, channel))
  end

  def update_state(new_count, channel) do
    Agent.update(__MODULE__,&Map.put(&1, channel, new_count))
  end
end
