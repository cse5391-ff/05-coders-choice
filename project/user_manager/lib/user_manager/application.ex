defmodule UserManager.Application do

  use Application

  def start(_type, _args) do

    children = [
      { UserManager.Supervisor, strategy: :one_for_one, name: UserManager.Supervisor }
    ]

    Supervisor.start_link(children, strategy: :one_for_one)

  end

end
