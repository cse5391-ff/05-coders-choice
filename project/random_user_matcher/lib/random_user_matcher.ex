defmodule RandomUserMatcher do
  @moduledoc """
  Matches random users together.
  """

  defdelegate start(), to: Impl

end
