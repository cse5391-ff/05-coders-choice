defmodule RoomManager.IdManager do

  alias RoomManager.IdManager.Impl

  defdelegate generate_room_id(length),   to: Impl
  defdelegate generate_room_code(length), to: Impl

end
