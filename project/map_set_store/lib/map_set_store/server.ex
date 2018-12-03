defmodule MapSetStore.Server do

  use GenServer

  # All of these will take mapsets as args

  def init(args) do
    {:ok,      args |> MapSet.new()}
  end

  def handle_cast({:add, args}, state) do
    {:noreply, state |> MapSet.union(args)}
  end

  def handle_cast({:remove, args}, state) do
    {:noreply, state |> MapSet.difference(args)}
  end

  def handle_call(:get, _from, state) do
    {:reply, state, state}
  end

  #defp to_mapset(args), do: args |> MapSet.new()

end
