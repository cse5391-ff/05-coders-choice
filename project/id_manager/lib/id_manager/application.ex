defmodule IdManager.Application do

  use Application

  def start(_type, _args) do
    children = [
      { DynamicSupervisor, strategy: :one_for_one, name: MapSetStore.DynamicSupervisor }
    ]

    Supervisor.start_link(children, strategy: :one_for_one)

    MapSetStore.DynamicSupervisor.start_child(__MODULE__, %{id: :mss1, start: {MapSetStore, :start, [:room_ids]}})
    MapSetStore.DynamicSupervisor.start_child(__MODULE__, %{id: :mss2, start: {MapSetStore, :start, [:user_ids]}})
  end

end
