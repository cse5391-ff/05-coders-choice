defmodule MapSetStore do
  @moduledoc """
  Uses a genserver to store a mapset.
  """

  defdelegate start(name, default \\ []), to: Interface
  defdelegate add(name, args),            to: Interface
  defdelegate remove(name, args),         to: Interface
  defdelegate get(name),                  to: Interface
  defdelegate contains?(name, value),     to: Interface

end
