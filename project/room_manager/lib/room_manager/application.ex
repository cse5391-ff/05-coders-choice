defmodule RoomManager.Application do

  use Application

  def start(_type, _args) do

    children = [
      {RoomManager.Supervisor, strategy: :one_for_one, name: RoomManager.Supervisor}
    ]

    Supervisor.start_link(children, strategy: :one_for_one)

  end

end
