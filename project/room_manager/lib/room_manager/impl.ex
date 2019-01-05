defmodule RoomManager.Impl do

  # Create protected room (generate room id, room code and store info along w/ creators id)
  def new_room(_type = :protected, user_id) do
    # Spawns :protected room process and returns room_id and room_code

    #room_id   = ...
    #room_code = ...

    #{room_id, room_code}
  end

  # Create match room (generate room id, store along w/ both users' ids)
  def new_room(_type = :match, {user_id1, user_id2}) do
    # Spawns :match room process and returns room_id

    #room_id = ...

    #room_id
  end

  # Fetch room id from room code
  def get_id_by_code(code) do
    # Interact w/ MapStore to get relevant id by code
    # Return nil if code doesn't exist (may already be handled by MapStore API)

    #room_id = ...

    #room_id
  end

end
