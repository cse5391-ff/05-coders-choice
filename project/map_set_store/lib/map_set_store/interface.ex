defmodule MapSetStore.Interface do

  def start(args) do
    GenServer.start(MapSetStore.Server, default)
  end

  def add(server, args) do
    GenServer.cast(server, {:add, args})
  end

  def remove(server, args) do
    GenServer.cast(server, {:remove, args})
  end

  def get(server) do
    GenServer.call(server, :get)
  end

end
