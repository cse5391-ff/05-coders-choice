defmodule Channel do
  use GenServer

  @topicserver TopicServer
  @userservers UserServer

  def start_link(state \\ []) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  @impl true
  def init(topic, opts \\ []) do
    GenServer.start_link(__MODULE__, topic)
    GenServer.start_link(TopicServer, topic, name: @topicserver)
    {:noreply, topic}
  end

  def handle_call(:add_usr, _from, opts) do
    {:ok, pid} = GenServer.start_link(UserServer, _from, opts)
    {:noreply, pid}
  end
end
