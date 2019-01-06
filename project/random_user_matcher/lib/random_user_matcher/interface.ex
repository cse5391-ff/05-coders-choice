defmodule RandomUserMatcher.Interface do

  alias RandomUserMatcher.Server

  def start(name),    do: GenServer.start_link(Server, nil, name: name)
  def match(user_id), do: GenServer.call(:matcher, {:match, user_id})

end
