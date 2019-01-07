defmodule IdGenerator do
  @moduledoc """
  Handles generation of alpha-numeric IDs.
  """

  alias IdGenerator.Interface

  @doc """
  Generates alpha-numeric ID of specified length.
  """
  defdelegate generate_id(length), to: Interface

end
