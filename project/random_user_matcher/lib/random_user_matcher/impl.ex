defmodule RandomUserMatcher.Impl do

  # Spins off a process on launch with a simple single-value state (connection_id = nil).
  #
  # Simple api: attempt_match(new_conn_id)
  # |> sends process message with new id. If process's state is nil, add new id (this user is waiting)
  #

  def hello do
    :world
  end

end
