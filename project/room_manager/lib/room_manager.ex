defmodule RoomManager do
  @moduledoc """
  Handles creation of rooms, generation of room codes / ids, and linking protected rooms ids with their codes.
  """

  alias RoomManager.Interface

  defdelegate create_room(type, initial_state), to: Interface
  defdelegate get_id_by_code(code),             to: Interface

end
