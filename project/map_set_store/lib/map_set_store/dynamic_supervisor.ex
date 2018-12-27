defmodule MapSetStore.DynamicSupervisor do

  use DynamicSupervisor

  def start_link(arg) do
    DynamicSupervisor.start_link(__MODULE__, arg, name: __MODULE__)
  end

  def start_child(id, name) do
    DynamicSupervisor.start_child(__MODULE__, %{id: id, start: {MapSetStore, :start, [name]}})
  end

  def init(_arg) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end

end
