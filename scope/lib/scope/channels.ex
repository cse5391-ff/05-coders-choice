defmodule Channels do
  use Agent

  def start_link(init_state \\ []) do
    Agent.start_link(fn -> [] end)
  end

  def list_channels() do
    Agent.get(__MODULE__, fn state -> state end)
  end

  def add_channel(topic) do
    Agent.get_and_update(__MODULE__, &MapSet.put(&1, topic))
  end

end
