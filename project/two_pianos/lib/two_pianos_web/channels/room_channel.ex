defmodule TwoPianosWeb.RoomChannel do

  use TwoPianosWeb, :channel

  def join("room:" <> room_id, _, socket) do

    room_id_atom = room_id |> String.to_atom()

    if RoomManager.room_exists?(room_id_atom) do
      room_id_atom |> attempt_join(socket)
    else
      {:error, %{reason: "Room " <> room_id <> " doesn't exist"}}
    end

  end

  def handle_in("keys_pressed", %{keys_pressed: keys}, socket) do
    socket |> broadcast!("press", keys)
  end

  def handle_in("keys_released", %{keys_released: keys}, socket) do
    socket |> broadcast!("release", keys)
  end

  def handle_in("message_posted", %{message_posted: message}, socket) do
    socket |> broadcast!("chat_message", message)
  end

  # Helpers

  def attempt_join(room_id, socket) do

    case Room.join(room_id, socket.assigns[:user_id]) do
      :success           -> {:ok,    socket}
      {:failure, reason} -> {:error, %{reason: reason}}
    end

  end

end
