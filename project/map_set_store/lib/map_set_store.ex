defmodule MapSetStore do
  @moduledoc """
  Uses a named genserver to maintain / wrap a MapSet.
  """

  alias MapSetStore.Interface

  @doc """
  Starts up a named GenServer which contains / operates on a MapSet. Takes both the desired name and
  a list of contents for the MapSet.
  """
  defdelegate start(name, args \\ []), to: Interface

  @doc """
  Retrieves the MapSet held by the named GenServer.
  """
  defdelegate get(name), to: Interface

  @doc """
  Adds the specified argument(s) to the MapSet held by the named GenServer.
  """
  defdelegate add(name, args), to: Interface

  @doc """
  Removes the specified argument(s) from the MapSet held by the named GenServer
  """
  defdelegate remove(name, args), to: Interface

  @doc """
  Checks if the held MapSet contains the specified value.
  """
  defdelegate contains?(name, value), to: Interface

end
