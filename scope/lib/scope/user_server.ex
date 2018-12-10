defmodule UserServer do
  use GenServer

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, opts)
  end

  def init(topic, opts) do
    {:noreply, topic}
  end

  def handle_call(request, from, state) do
    GenServer.call(TopicServer, :return_msgs, state)
  end

  def handle_call(:res, from, result) do
    IO.puts(result)
    {:noreply, state}
  end

end
