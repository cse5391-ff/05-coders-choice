defmodule RoomManager.IdManager.Interface do

  def generate_room_id(length) do

    room_id = IdGenerator.generate_id(length) |> String.to_atom()

    if MapSetStore.contains?(:room_ids, room_id) do
      generate_room_id(length)
    else
      MapSetStore.add(:room_ids, [room_id])
      room_id
    end

  end

  def generate_room_code(length) do

    room_code = IdGenerator.generate_id(length) |> String.to_atom()

    if MapSetStore.contains?(:room_codes, room_code) do
      generate_room_code(length)
    else
      MapSetStore.add(:room_codes, [room_code])
      room_code
    end

  end

end
