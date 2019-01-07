defmodule Scope.ChannelRead do
  use Agent

  def start_link(_opts) do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def get() do
    Agent.get(__MODULE__, &(&1))
  end

  def update_state(channel, new_count) do
    Agent.update(__MODULE__,&Map.put(&1, channel, new_count))
  end
end
