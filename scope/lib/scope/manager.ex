defmodule Manager do

  @server Scope.Server

  def start_link(topic) do
    GenServer.start_link(@server, topic, options \\ [])
  end

  def list_channels do
    GenServer.call(@server, :list_channels)
  end

  def join_channel(topic) do
    GenServer.call(@server, topic, :join)
  end

  def send_message(_case, content) do
    GenServer.call(@server, :send_message, timeout \\ 5000)
  end
end
