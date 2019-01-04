defmodule UserManager.Application do

  use Application

  def start(_type, _args) do

    children = [
      { DynamicSupervisor, strategy: :one_for_one, name: MapSetStore.DynamicSupervisor }
    ]

    Supervisor.start_link(children, strategy: :one_for_one)

    MapSetStore.DynamicSupervisor.start_child(:mss1, :user_ids)

  end

end
