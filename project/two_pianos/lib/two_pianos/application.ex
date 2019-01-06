defmodule TwoPianos.Application do

  use Application

  def start(_type, _args) do

    children = [
      { Supervisor, strategy: :one_for_one, name: UserManager.Supervisor },
      { Supervisor, strategy: :one_for_one, name: RoomManager.Supervisor },
      { Supervisor, strategy: :one_for_one, name: RandomUserMatcher.Supervisor }
    ]

    Supervisor.start_link(children, strategy: :one_for_one)

  end

  def config_change(changed, _new, removed) do
    TwoPianosWeb.Endpoint.config_change(changed, removed)
    :ok
  end

end
