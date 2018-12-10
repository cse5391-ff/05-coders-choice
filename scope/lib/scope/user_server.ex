defmodule UserServer do
  use GenServer

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, opts)
  end

  def init(topic, opts) do
    {:noreply, topic}
  end

  def handle_call(request, from, state) do

  end

end
