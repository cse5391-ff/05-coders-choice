defmodule TwoPianos.RoomChannel do

  use TwoPianosWeb, :channel

  # As of now, only functionality is to broadcast pressed and released keys to other user in room

  def join("room:" <> room_id, _, socket) do

    if authorized?(socket.assigns.user_id, room_id) do
      # Needs to check if current user is authorized to enter this room's channel
      {:ok, socket}
    else
      {:error, %{reason: "Unauthorized"}}
    end

  end

  def handle_in("keys_pressed", keys, socket) do
    socket |> broadcast!("press", keys)
  end

  def handle_in("keys_released", keys, socket) do
    socket |> broadcast!("release", keys)
  end

  def handle_in("message_posted", message, socket) do
    socket |> broadcast!("chat_message", message)
  end

end
