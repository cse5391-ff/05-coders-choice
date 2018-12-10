defmodule RandomUserMatcher.Process do

  def matcher(waiting_user \\ nil) do

    receive do
      {:new_user, new_user_id} ->
        new_user_id
        |> match_with(waiting_user)
    end

    matcher(waiting_user)

  end

  def match_with(new_user, _waiting_user = nil), do: new_user

  def match_with(new_user, waiting_user), do
    new_room_id = IdManager.generate_id(:room)
    # Create room
    TwoPianos.Endpoint.broadcast!("user:" <> new_user,     "match", %{room_id: new_room_id})
    TwoPianos.Endpoint.broadcast!("user:" <> waiting_user, "match", %{room_id: new_room_id})
    nil
  end

end
