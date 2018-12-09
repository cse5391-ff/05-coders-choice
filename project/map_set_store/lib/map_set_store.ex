defmodule MapSetStore do
  @moduledoc """
  Uses a genserver to store a mapset.
  """

  defdelegate start(default \\ []),     to: Interface
  defdelegate add(server, args),        to: Interface
  defdelegate remove(server, args),     to: Interface
  defdelegate get(server),              to: Interface
  defdelegate contains?(server, value), to: Interface

end
