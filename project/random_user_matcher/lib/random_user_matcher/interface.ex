defmodule RandomUserMatcher.Interface do

  alias RandomUserMatcher.Server

  def match(user_id), do: Server |> GenServer.call({:match_with, user_id})

end
