defmodule Room.Server do

  use GenServer

  def init(args) do
    {:ok, args}
  end

  def handle_call(:get, _from, state) do
    {:reply, state, state}
  end

  def handle_cast({:add_user, user_id, code}, state) do

    {:reply, }
  end

  def user_authorized?(args, user_id, code) do
    case args do

    end
  end

end
