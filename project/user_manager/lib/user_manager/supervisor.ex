defmodule UserManager.Supervisor do

  use Supervisor

  def start_link(opts) do
    Supervisor.start_link(__MODULE__, :ok, opts)
  end

  def init(:ok) do

    children = [
      { DynamicSupervisor, strategy: :one_for_one, name: MapSetStore.DynamicSupervisor }
    ]

    Supervisor.init(children, strategy: :one_for_one)

    MapSetStore.DynamicSupervisor.start_child(:mss1, :user_ids)

  end

end
