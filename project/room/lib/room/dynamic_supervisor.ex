defmodule Room.DynamicSupervisor do

  use DynamicSupervisor

  def init(_arg) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end

  def start_link(arg) do
    DynamicSupervisor.start_link(__MODULE__, arg, name: __MODULE__)
  end

  def start_child(name, type, startup_state) do
    DynamicSupervisor.start_child(__MODULE__, %{start: {Room, :start, [name, type, startup_state]}})
  end

end
