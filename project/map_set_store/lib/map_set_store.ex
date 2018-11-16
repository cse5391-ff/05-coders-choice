defmodule MapSetStore do
  @moduledoc """
  Uses a genserver to store a mapset. Seriously mindblowing documentation.
  """

  defdelegate start(),  to: Interface
  defdelegate add(),    to: Interface
  defdelegate remove(), to: Interface

end
