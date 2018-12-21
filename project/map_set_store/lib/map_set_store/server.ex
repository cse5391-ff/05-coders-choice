defmodule MapSetStore.Server do

  use GenServer

  def init(args) do
    {:ok, args}
  end

  def handle_cast({:add, args}, state) do
    updated_state = state |> MapSet.union(args)
    {:noreply, updated_state}
  end

  def handle_cast({:remove, args}, state) do
    updated_state = state |> MapSet.difference(args)
    {:noreply, updated_state}
  end

  def handle_call(:get, _from, state) do
    return_val    = state
    updated_state = state

    {:reply, return_val, updated_state}
  end

  def handle_call({:contains?, value}, _from, state) do
    return_val = state |> MapSet.member?(value)
    updated_state  = state

    {:reply, return_val, new_state}
  end

end
