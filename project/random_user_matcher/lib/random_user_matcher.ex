defmodule RandomUserMatcher do
  @moduledoc """
  Launched as soon as app is up and running.
  Matches random users together.
  """

  alias RandomUserMatcher.Interface

  defdelegate start(),          to: Interface
  defdelegate place_into_queue, to: Interface

end
