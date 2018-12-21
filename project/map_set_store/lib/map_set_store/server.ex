defmodule MapSetStore.Server do
  @moduledoc """
  Genserver that maintains a MapSet.
  """

  use GenServer

  def init(mapset) do
    {:ok, mapset}
  end

  def handle_cast({:add, values}, state) do
    updated_state = state |> MapSet.union(values)
    {:noreply, updated_state}
  end

  def handle_cast({:remove, values}, state) do
    updated_state = state |> MapSet.difference(values)
    {:noreply, updated_state}
  end

  def handle_call(:get, _from, state) do
    return_val    = state
    updated_state = state

    {:reply, return_val, updated_state}
  end

  def handle_call({:contains?, value}, _from, state) do
    return_val     = state |> MapSet.member?(value)
    updated_state  = state

    {:reply, return_val, updated_state}
  end

end
