defmodule UserManager do
  @moduledoc """
  Handles generation of user_ids.
  """

  alias UserManager.Interface

  @doc """
  Generates a unique user_id.
  """
  defdelegate generate_user_id(length), to: Interface

end
