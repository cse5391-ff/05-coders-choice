defmodule MapStore.Server do
  @moduledoc """
  Genserver that maintains a Map.
  """

  use GenServer

  def init(map) do
    {:ok, map}
  end

  def handle_call(:get, _from, state) do
    {
      :reply,
      _return_val = state,
      _updated_state = state
    }
  end

  def handle_call({:get, key}, _from, state) do
    {
      :reply,
      _return_val = state |> Map.get(key),
      _updated_state = state
    }
  end

  def handle_cast({:add, key, val}, state) do
    {
      :noreply,
      _updated_state = state |> Map.put(key, val)
    }
  end

  def handle_cast({:remove, key}, state) do

    {_, new_map} = state |> Map.pop(key)

    {
      :noreply,
      _updated_state = new_map
    }

  end

end
