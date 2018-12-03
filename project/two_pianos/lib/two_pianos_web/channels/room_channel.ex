defmodule TwoPianos.RoomChannel do

  use TwoPianosWeb, :channel

  def join("room:" <> room_id, _, socket) do
    {:ok, socket}
  end

  def handle_in("keys_pressed", keys, socket) do
    socket |> broadcast!("press", keys)
  end

  def handle_in("keys_released", keys, socket) do
    socket |> broadcast!("release", keys)
  end

end
