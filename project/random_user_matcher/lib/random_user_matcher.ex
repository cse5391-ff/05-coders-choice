defmodule RandomUserMatcher do
  @moduledoc """
  Very basic GenServer that matches two random users together.
  """

  alias RandomUserMatcher.Interface

  defdelegate match(user_id), to: Interface

end
