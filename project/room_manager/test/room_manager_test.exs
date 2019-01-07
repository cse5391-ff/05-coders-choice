defmodule RoomManagerTest do
  use ExUnit.Case

  test "Generates unique room ids" do

    id_len = 10

    ids = [
      RoomManager.IdManager.generate_room_id(id_len),
      RoomManager.IdManager.generate_room_id(id_len),
      RoomManager.IdManager.generate_room_id(id_len),
      RoomManager.IdManager.generate_room_id(id_len),
      RoomManager.IdManager.generate_room_id(id_len),
      RoomManager.IdManager.generate_room_id(id_len),
      RoomManager.IdManager.generate_room_id(id_len),
      RoomManager.IdManager.generate_room_id(id_len),
      RoomManager.IdManager.generate_room_id(id_len),
      RoomManager.IdManager.generate_room_id(id_len),
    ]

    ms_id_list = MapSetStore.get(:room_ids)
                 |> MapSet.to_list()

    assert Enum.sort(ids) == Enum.sort(ms_id_list)

  end

  test "Generates unique room codes" do

    code_len = 5

    ids = [
      RoomManager.IdManager.generate_room_code(code_len),
      RoomManager.IdManager.generate_room_code(code_len),
      RoomManager.IdManager.generate_room_code(code_len),
      RoomManager.IdManager.generate_room_code(code_len),
      RoomManager.IdManager.generate_room_code(code_len),
      RoomManager.IdManager.generate_room_code(code_len),
      RoomManager.IdManager.generate_room_code(code_len),
      RoomManager.IdManager.generate_room_code(code_len),
      RoomManager.IdManager.generate_room_code(code_len),
      RoomManager.IdManager.generate_room_code(code_len),
    ]

    ms_id_list = MapSetStore.get(:room_codes)
                 |> MapSet.to_list()

    assert Enum.sort(ids) == Enum.sort(ms_id_list)

  end

end
