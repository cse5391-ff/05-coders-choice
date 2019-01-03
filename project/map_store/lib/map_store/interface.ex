defmodule MapStore.Interface do
  @moduledoc """
  Directly interacts with the MapStore genserver. Accept name and key/value tuple as params.
  """

  alias MapStore.Server

  def start(name, map = %{}),  do: Server |> GenServer.start_link(     map,      name: name)
  def start(name, {key, val}), do: Server |> GenServer.start_link(%{key => val}, name: name)

  def get(name) do
    name |> GenServer.call(:get)
  end

  def get(name, key) do
    name |> GenServer.call({:get, key})
  end

  def add(name, key, val) do
    name |> GenServer.cast({:add, key, val})
  end

  def remove(name, key) do
    name |> GenServer.cast({:remove, key})
  end

  def contains_key?(name, key) do
    get(name)
    |> Map.has_key?(key)
  end

end
