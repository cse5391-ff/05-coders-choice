defmodule RoomManager do
  @moduledoc """
  Handles creation of rooms, generation of room codes / ids, and linking protected rooms ids with their codes.
  """

  alias RoomManager.Interface

  @doc """
  Creates a room of designated type. Handles creation and linking of of room code and ID.
  Returns the room's ID, and also returns room's entry code if :protected room was created.

  Types:
  * :protected => startup_state = creator_id
  *   :match   => startup_state = {user_id1, user_id2}
  """
  defdelegate create_room(type, initial_state), to: Interface

  @doc """
  Returns the associated room ID to the specified code, or nil if there is no associated ID.
  """
  defdelegate get_id_by_code(code), to: Interface

end
