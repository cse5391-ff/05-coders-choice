defmodule Room do
  @moduledoc """
  Uses a genserver to maintain a piano room.

  Rooms can be one of two types:
  1) Protected (has a sole creator and entry code. Creator is always allowed to join, but
  only 1 different user may also join)
    * For jamming with a friend / instructor

  2) Match (has 2 distinct allowed inhabitants)
    * For jamming with a random stranger

  """

  alias Room.Interface

  @doc """
  Starts up GenServer room with the room_id as it's name.

  Types:
  * :protected => startup_state = creator_id
  *   :match   => startup_state = {user_id1, user_id2}
  """
  defdelegate start(room_id, type, startup_state), to: Interface

  @doc """
  Attempts to place user in specified room. Different rooms have different authorization / occupancy rules.
  Returns :success on successful join, {:failure, reason} on failure
  """
  defdelegate join(room_id, user_id), to: Interface

  @doc """
  Removes user from named room.
  """
  defdelegate leave(room_id, user_id), to: Interface

end
