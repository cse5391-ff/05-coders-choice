defmodule TwoPianos.UserChannel do

  use TwoPianosWeb, :channel

  # User joins this channel to be accessbile by an external broadcast to "user:<user_id>"

  def join("user:" <> user_id, _, socket) do
    {:ok, socket}
  end

  # Client-side can handle receiving event "matched_user"

end
