defmodule Channel do
  use GenServer

  def start_link(state \\ []) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  @impl true
  def init(topic) do
    GenServer.start_link(TopicServer, topic, opts)
    Agent.start_link(Users, _from, opts)
    {:ok, topic}
  end

  def handle_call(:add_user, _from, opts) do
    Agent.get_and_update(Users, _from, opts)
  end
end
