defmodule MapSetStore.Interface do

  def start(name, args) do
    GenServer.start_link(MapSetStore.Server, args, name: name)
  end

  def add(name, args) do
    name |> GenServer.cast({:add, args})
  end

  def remove(name, args) do
    name |> GenServer.cast({:remove, args})
  end

  def get(name) do
    name |> GenServer.call(:get)
  end

  def contains?(name, value) do
    name |> GenServer.call(:get, value})
  end

end
