defmodule MapSetStore do
  @moduledoc """
  Uses a named genserver to maintain / wrap a MapSet.
  """

  defdelegate     start(name, args \\ []), to: Interface
  defdelegate       add(name, args),       to: Interface
  defdelegate    remove(name, args),       to: Interface
  defdelegate       get(name),             to: Interface
  defdelegate contains?(name, value),      to: Interface

end
