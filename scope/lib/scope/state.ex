defmodule State do
  use Agent

  def start_link(opts) do
    Agent.start_link(fn -> %{} end)
  end

  def init(init_state \\ []) do

  end

  def put(state, topic) do
    Agent.update(state, &Map.put(&1, topic))
  end

  def put(state, _from, message) do
    Agent.update(state, &Map.put(&1, _from, message))
  end

  def get(state, topic) do
    Agent.get(state, &Map.get(&1, topic))
  end

end
