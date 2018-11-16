defmodule Terminal2048.Application do

  use Application

  def start(_type, _args) do

    import Supervisor.Spec

    children = [
      worker(Terminal2048.Game, [], restart: :permanent)
    ]

    opts = [strategy: :one_for_one, name: Terminal2048.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
