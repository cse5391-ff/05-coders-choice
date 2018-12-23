defmodule MapSetStore.Interface do
  @moduledoc """
  Directly interacts with the MapSetStore genserver. To keep things simple, we will only accept items and lists of items
  as arguments. (items = strings, atoms, numbers)
  """

  alias MapSetStore.Server

  @type item() :: number() | String.t() | atom()

  def     start(name, args),  do: Server |> GenServer.start_link(to_mapset(args), name: name)
  def       get(name),        do: name   |> GenServer.call(:get)
  def       add(name, args),  do: name   |> GenServer.cast({:add,       to_mapset(args)})
  def    remove(name, args),  do: name   |> GenServer.cast({:remove,    to_mapset(args)})
  def contains?(name, value), do: name   |> GenServer.call({:contains?, value})

  defp to_mapset(args), do: args |> MapSet.new()

end
