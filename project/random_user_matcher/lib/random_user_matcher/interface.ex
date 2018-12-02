defmodule RandomUserMatcher.Interface do

  # Spins off a process on launch with a simple single-value state (connection_id = nil).
  #
  # Simple api: attempt_match(new_conn_id)
  # |> sends process message with new id. If process's state is nil, add new id (this user is waiting)
  #


  @doc """
  Launches the matcher process.
  """
  def start() do

  end

  @doc """
  Sends the matcher process a user ID
  """
  def place_into_queue(user_id) do

  end

end
