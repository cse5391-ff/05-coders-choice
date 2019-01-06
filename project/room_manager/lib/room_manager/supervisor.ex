defmodule RoomManager.Supervisor do

  use Supervisor

  def start_link(opts) do
    Supervisor.start_link(__MODULE__, :ok, opts)
  end

  def init(:ok) do

    children = [
      { DynamicSupervisor, strategy: :one_for_one, name: Room.DynamicSupervisor },
      { DynamicSupervisor, strategy: :one_for_one, name: MapSetStore.DynamicSupervisor },
      { DynamicSupervisor, strategy: :one_for_one, name: MapStore.DynamicSupervisor }
    ]

    Supervisor.init(children, strategy: :one_for_one)

     # For IdManager
     MapSetStore.DynamicSupervisor.start_child(:mss1, :room_codes)
     MapSetStore.DynamicSupervisor.start_child(:mss2, :room_ids)

     MapStore.DynamicSupervisor.start_child(:ms1, :code_id_linker)

  end

end
