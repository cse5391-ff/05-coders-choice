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

  defdelegate start(room_id, type, startup_state), to: Interface
  defdelegate join(room_id, user_id),              to: Interface
  defdelegate leave(room_id, user_id),             to: Interface

end
