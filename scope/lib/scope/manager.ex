defmodule Phoenix.PubSub.Manager do

  @server Scope.Server
  @pubsub_name ""

  def start_link(name, topic) do
    {:ok, name}
  end

  def init({name, options}) do
    PubSub.subscribe(name, options)
    {:ok, %{}}
  end

  def broadcast!(server, topic, message) do

  end

  def list_channels do
    GenServer.call(@server, :list_channels)
  end

  def join_channel(topic) do
    GenServer.call(@server, topic, :join)
  end

  def send_message(topic, message) do
    Phoenix.PubSub.broadcast(@server, topic, {:send_message, message.from, message.content})
  end
end
