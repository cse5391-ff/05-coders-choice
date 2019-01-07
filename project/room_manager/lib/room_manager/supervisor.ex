defmodule RoomManager.Supervisor do

  use Supervisor

  def child_spec(opts) do
    %{
      id:       __MODULE__,
      start:   {__MODULE__, :start_link, [opts]},
      type:    :supervisor,
      restart: :permanent,
      shutdown: 500
    }
  end

  def start_link(opts) do
    Supervisor.start_link(__MODULE__, :ok, opts)
  end

  def init(:ok) do

    children = [
      Room.DynamicSupervisor,
      { MapSetStore.DynamicSupervisor, name: :RoomManagerMSSSupervisor },
      { MapStore.DynamicSupervisor,    name: :RoomManagerMSSupervisor },
      RoomManager.Starter
    ]

    Supervisor.init(children, strategy: :one_for_one)

  end

end
