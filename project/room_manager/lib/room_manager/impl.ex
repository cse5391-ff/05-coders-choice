defmodule RoomManager.Impl do

  alias RoomManager.IdManager

  def create_room(_type = :protected, creator_id) do

    room_id   = IdManager.generate_room_id(10)
    room_code = IdManager.generate_room_code(5)

    # Spawn Room
    Room.DynamicSupervisor.start_child(room_id, :protected, creator_id)

    # Key = code, val = id
    MapStore.add(:code_id_linker, room_code, room_id)

    {room_id, room_code}

  end

  def create_room(_type = :match, user_ids = {_id1, _id2}) do

    room_id = IdManager.generate_room_id(10)

    # Spawn Room
    Room.DynamicSupervisor.start_child(room_id, :match, user_ids)

    room_id

  end

  def get_id_by_code(code), do: :code_id_linker |> MapStore.get(code)

end
