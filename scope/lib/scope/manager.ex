defmodule Manager do

  @server Scope.Server
  @pubsub_name ""

  def start_link(name, topic) do
    PubSub.start_link()
  end

  def init({name, options}) do
    {:ok, %{}}
  end

  def start(topic) do
    spawn(fn -> GenServer.start_link(Scope.Server, topic) end)
  end

  def broadcast!(server, topic, message) do

  end

  def list_channels do
    GenServer.call(@server, :list_channels)
  end

  def join_channel(pid, topic) do
    PubSub.subscribe(pid, topic)
  end

  def send_message(urgency, topic, message) do
    PubSub.publish(topic, message)
  end
end
