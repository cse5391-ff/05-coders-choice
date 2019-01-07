defmodule RandomUserMatcher.Server do

  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def init(_) do
    {:ok, nil}
  end

  def handle_call({:match_with, user_id}, _from, nil) do
    {:reply, :waiting, user_id}
  end

  def handle_call({:match_with, user_id}, _from, user_id) do
    {:reply, :already_waiting, user_id}
  end

  def handle_call({:match_with, new_user_id}, _from, waiting_user_id) do
    {:reply, {:match, waiting_user_id}, nil}
  end

end
