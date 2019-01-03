defmodule RoomManager.Application do

  use Application

  def start(_type, _args) do

    children = [
      { DynamicSupervisor, strategy: :one_for_one, name: MapStore.DynamicSupervisor }
    ]

    Supervisor.start_link(children, strategy: :one_for_one)

    MapStore.DynamicSupervisor.start_child(:ms1, :rooms)
    MapStore.DynamicSupervisor.start_child(:ms2, :room_codes)

  end
end
