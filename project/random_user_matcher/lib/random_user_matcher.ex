defmodule RandomUserMatcher do
  @moduledoc """
  Very basic GenServer that matches two random users together.
  """

  alias RandomUserMatcher.Interface

  @doc """
  Attempts to match the passed user with another user.

  If there is noone already in the GenServer, the user is placed in the GenServer and :waiting is returned.
  If there is someone already in the GenServer, {:match, user_id} is returned and the GenServer's state is set to nil.
  """
  defdelegate match(user_id), to: Interface

end
