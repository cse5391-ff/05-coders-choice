defmodule IdManager.Application do

  use Application

  def start(_type, _args) do

    children = [
      { DynamicSupervisor, strategy: :one_for_one, name: MapSetStore.DynamicSupervisor }
    ]

    Supervisor.start_link(children, strategy: :one_for_one)

    MapSetStore.DynamicSupervisor.start_child(:mss1, :room_ids)
    MapSetStore.DynamicSupervisor.start_child(:mss2, :user_ids)

  end

end
