defmodule RoomManager do

  alias RoomManager.Impl

  defdelegate create_room(type, initial_state), to: Impl
  defdelegate get_id_by_code(code),             to: Impl

end
