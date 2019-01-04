defmodule RandomUserMatcher.Interface do

  alias RandomUserMatcher.Server

  def start(name), do: GenServer.start_link(Server, nil, name: name)

  # Consider moving this module into phoenix project, needs access to TwoPianos UserChannel anyway...
  def match(user_id) do

    case GenServer.call(:matcher, {:match, user_id}) do
      :waiting ->
        :waiting
      {:match, matched_user_id} ->
        room_id = RoomManager.new(:match, user_id, matched_user_id)
        TwoPianos.UserChannel.broadcast_match(user_id, matched_user_id, room_id)
    end

  end

end
