defmodule MapStore do
  @moduledoc """
  Uses a named genserver to maintain / wrap a Map.
  """

  alias MapStore.Interface

  @doc """
  Starts up a named GenServer which contains / operates on a Map. Takes both the desired name and
  an initial map.
  """
  defdelegate start(name, args \\ %{}), to: Interface

  @doc """
  Retrieves the Map held by the named GenServer.
  """
  defdelegate get(name), to: Interface

  @doc """
  Retrieves the value associated to the passed key from the Map held by the named GenServer.
  """
  defdelegate get(name, key), to: Interface

  @doc """
  Adds the passed key and value to the held Map.
  """
  defdelegate add(name, key, val), to: Interface

  @doc """
  Removes the key and associated value from the map held by the named GenServer.
  """
  defdelegate remove(name, key), to: Interface

  @doc """
  Checks if the passed key is located in the held map.
  """
  defdelegate contains_key?(name, key), to: Interface

end
