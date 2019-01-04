defmodule RoomManager do

  # Create protected room (generate room id, room code and store info along w/ creators id)
  def new(_type = :protected, user_id) do
    # Spawns :protected room process and returns room_id and room_code

    #room_id   = ...
    #room_code = ...

    #{room_id, room_code}
  end

  # Create match room (generate room id, store along w/ both users' ids)
  def new(_type = :match, user_id1, user_id2) do
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

  # Checks if user's authorized to enter room (id needs to be in room's list of users)
  def user_authorized?(room_id, user_id) do

    ###*** UNNECESSARY, REWORK TO ADD TO ROOM MODULE. SHOULD WORK LIKE ACTORS...
    ###*** -> join() SHOULD RETURN :unauthorized, SHOULDNT RELY ON CHECK AT FRONTEND

    # fetch room by room_id: room = room_id |> get_room()

    # if room_type == protected, authorized if...
    #    * user_id is creator's id
    #    * room isnt already occupied (other id is nil)

    # if room_type == match, authorized if...
    #    * user_id is one of the two authorized ids

    # *** CHANGES NEEDED ***
    # Rooms should be genservers, shouldnt be held in map store

  end

end
