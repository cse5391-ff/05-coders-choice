defmodule RoomManager do

  alias RoomManager.Interface

  defdelegate create_room(type, initial_state), to: Interface
  defdelegate get_id_by_code(code),             to: Interface

end
