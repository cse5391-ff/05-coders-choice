defmodule TwoPianos.UserChannel do

  use TwoPianosWeb, :channel

  # User joins this channel to be accessbile by an external broadcast to "user:<user_id>"

  def join("user:" <> user_id, _, socket) do
    {:ok, socket}
  end

  def broadcast_match(id1, id2, room_id) do
    TwoPianos.Endpoint.broadcast("user:" <> id1, "matched_user", room_id)
    TwoPianos.Endpoint.broadcast("user:" <> id2, "matched_user", room_id)
    :ok
  end

end
