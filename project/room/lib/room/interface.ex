defmodule Room.Interface do

  def start(name, type, startup_state) do
    GenServer.start_link(Room.Server, {type, startup_state}, name: name)
  end

  def join(room_id, user_id),  do: GenServer.call(room_id, {:join, user_id})
  def leave(room_id, user_id), do: GenServer.cast(room_id, {:leave, user_id})

end
