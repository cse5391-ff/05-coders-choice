defmodule Room.Interface do

  def start(name, args) do
    GenServer.start_link(MapSetStore.Server, args, name: name)
  end

  def add_user(name, user_id, code) do
    GenServer.cast(name, {:add_user, user_id, code})
  end

end
