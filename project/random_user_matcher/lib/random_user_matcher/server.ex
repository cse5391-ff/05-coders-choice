defmodule RandomUserMatcher.Server do

  use GenServer

  def init(_) do
    {:ok, nil}
  end

  def handle_call({:match_with, user_id1}, _from, nil) do
    {:reply, :waiting, user_id1}
  end

  def handle_call({:match_with, _user_id1}, _from, user_id2) do
    {:reply, {:match, user_id2}, nil}
  end

end
