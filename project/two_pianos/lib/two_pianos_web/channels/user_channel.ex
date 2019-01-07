defmodule TwoPianosWeb.UserChannel do

  use TwoPianosWeb, :channel

  # User joins this channel to be accessbile by an external broadcast to "user:<user_id>"

  def join("user:" <> user_id, _, socket) do
    {:ok, socket |> assign(:user_id, user_id)}
  end

  def broadcast_match(user_id, room_id) do
    TwoPianosWeb.Endpoint.broadcast("user:" <> user_id, "matched_user", %{room_id: room_id})
    :ok
  end

end
