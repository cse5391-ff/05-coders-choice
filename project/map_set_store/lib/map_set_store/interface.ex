defmodule MapSetStore.Interface do

  def start(name, args) do
    GenServer.start_link(MapSetStore.Server, to_mapset(args), name: name)
  end

  def add(name, args) do
    name |> GenServer.cast({:add, to_mapset(args)})
  end

  def remove(name, args) do
    name |> GenServer.cast({:remove, to_mapset(args)})
  end

  def get(name) do
    name |> GenServer.call(:get)
  end

  def contains?(name, value) do
    name |> GenServer.call({:contains?, value})
  end

  defp to_mapset(args), do: args |> MapSet.new()

end
