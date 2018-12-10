defmodule Scope.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    # List all child processes to be supervised
    children = [
     # { Messages.Repo, name: Messages.Repo },
      { Phoenix.PubSub.PG2, name: Scope.PubSub },
      { Scope.ChatServer, name: Scope.ChatServer },
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Scope.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
