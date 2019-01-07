defmodule TwoPianosWeb.LobbyChannel do

  use TwoPianosWeb, :channel

  def join("lobby", _, socket) do
    {:ok, socket}
  end

  def handle_in("create_room", _, socket) do
    # Create protected room (Generate unique room ID and code)
    {room_id, room_code} = RoomManager.create_room(:protected, socket.assigns[:user_id])

    # reply w/ room id and room code -> they will join the room's specific channel, will be
    # able to see the code, and will have a piano to mess around with
    {:reply, {:room_created, %{room_id: room_id, room_code: room_code}}, socket}
  end

  def handle_in("join_existing_room", %{"room_code" => code}, socket) do

    case RoomManager.get_id_by_code(code) do
      nil ->
        {:reply, {:invalid_code, %{}}, socket}
      room_id  ->
        {:reply, {:valid_code, %{room_id: room_id}}}
    end

  end

  def handle_in("match_with_stranger", _, socket) do

    case RandomUserMatcher.match(socket.assigns[:user_id]) do
      :waiting ->
        {:reply, {:waiting, %{}}, socket}
      {:match, matched_user_id} ->
        room_id = RoomManager.create_room(:match, {socket.assigns[:user_id], matched_user_id})
        TwoPianosWeb.UserChannel.broadcast_match(room_id, socket.assigns[:user_id], matched_user_id)
        {:reply, {:match, %{room_id: room_id}}, socket}
    end

  end

end
