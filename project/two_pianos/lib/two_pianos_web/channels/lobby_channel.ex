defmodule TwoPianos.LobbyChannel do

  use TwoPianosWeb, :channel

  # REFACTOR IDEA:
  #     Instead of IdManager, create RoomManager
  #       - Generates / stores unique room_ids and room_codes
  #       - Allows or denies access to room channel topic based on qualities of user / associated room

  def join("lobby", _anon_variable, socket) do
    {:ok, socket}
  end

  def handle_in("create_room", _, socket) do
    # Create protected room (Generate unique room ID and code)
    {room_id, room_code} = RoomManager.new(:protected, socket.assigns.user_id)

    # Push room id and room code back to user -> they will join the room's specific channel, will be
    # able to see the code, and will have a piano to mess around with
    socket |> push("room_created", %{room_id: room_id, room_code: room_code})

    # Look into replying with info instead of pushing it (unnecessary to set up js listener for 1-time thing)
    {:noreply, socket}
  end

  def handle_in("join_existing_room", %{"room_code" => code}, socket) do
    case RoomManager.fetch_id_by_code(code) do
      nil -> socket |> push("invalid_code")
      id  -> socket |> push("valid_code", %{room_id: id})
    end
    # Need way to lookup room_id based on code.
    # IDEA: Create queryable RoomManager Module that handles Room creation (Generation of room_id and map w/ code and users),
    # has room_id / room_code lookup as api function
    {:noreply, socket}
  end

  def handle_in("match_with_stranger", _, socket) do
    # Will broadcast room id to both users' user channels on successful match
    RandomUserMatcher.place_into_queue(socket.user_id)
    {:noreply, socket}
  end

end
