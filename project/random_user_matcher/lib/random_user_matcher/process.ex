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
    # send message to whoever needs it: new_user and waiting_user matched
    nil
  end

end
