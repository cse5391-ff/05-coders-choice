defmodule RandomUserMatcher do
  @moduledoc """
  Launched as soon as app is up and running.
  Matches random users together.
  """

  alias RandomUserMatcher.Interface

  defdelegate match(user_id), to: Interface

end
