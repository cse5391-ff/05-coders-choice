defmodule TwoPianosWeb.UserChannel do

  use TwoPianosWeb, :channel

  # User joins this channel to be accessbile by an external broadcast to "user:<user_id>"

  def join("user:" <> user_id, _, socket) do
    {:ok, socket}
  end

  def broadcast_match(user_id, room_id) do
    user_id_str = user_id |> Atom.to_string()
    TwoPianosWeb.Endpoint.broadcast("user:" <> user_id_str, "matched_user", %{room_id: room_id})
    :ok
  end

end
