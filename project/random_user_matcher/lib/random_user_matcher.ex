defmodule RandomUserMatcher do
  @moduledoc """
  Launched as soon as app is up and running.
  Matches random users together.
  """

  defdelegate start(), to: Impl

end
