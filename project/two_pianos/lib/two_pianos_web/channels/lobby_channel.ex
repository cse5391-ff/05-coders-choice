defmodule TwoPianos.LobbyChannel do

  use TwoPianosWeb, :channel

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

    case RoomManager.get_id_by_code(code) do
      nil -> socket |> push("invalid_code")
      id  -> socket |> push("valid_code", %{room_id: id})
    end

    {:noreply, socket}

  end

  def handle_in("match_with_stranger", _, socket) do

    case RandomUserMatcher.match(socket.assigns.user_id) do
      :waiting                  -> :ok
      {:match, matched_user_id} -> TwoPianos.UserChannel.broadcast_match(socket.assigns.user_id, matched_user_id)
    end

    {:noreply, socket}

  end

end
