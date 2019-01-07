defmodule RoomManager.IdManager do

  alias RoomManager.IdManager.Interface

  defdelegate generate_room_id(length),   to: Interface
  defdelegate generate_room_code(length), to: Interface

end
