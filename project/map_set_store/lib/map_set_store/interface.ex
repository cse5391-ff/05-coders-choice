defmodule MapSetStore.Interface do

  def start(args) do
    GenServer.start_link(MapSetStore.Server, default)
  end

  def add(server, args) do
    server |> GenServer.cast({:add, args})
  end

  def remove(server, args) do
    server |> GenServer.cast({:remove, args})
  end

  def get(server) do
    server |> GenServer.call(:get)
  end

  def contains?(server, value) do
    server |> GenServer.call(:get, value})
  end

end
