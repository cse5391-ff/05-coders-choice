defmodule RoomManager do

  # Create protected room (generate room id, room code and store info along w/ creators id)
  def new(_type = :protected, user_id) do
    #room_id   = ...
    #room_code = ...

    #{room_id, room_code}
  end

  # Create match room (generate room id, store along w/ both users' ids)
  def new(_type = :match, user_id1, user_id2) do
    #room_id = ...

    #room_id
  end

  # Fetch room id from room code
  def get_id_by_code(code) do
    #room_id = ...

    #room_id
  end

  # Checks if user's authorized to enter room (needs to be in list of users)
  def user_authorized?(room_id, user_id) do
    #room = ...

  end

end
