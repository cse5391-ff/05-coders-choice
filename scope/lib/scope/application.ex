defmodule Scope.Application do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    # Define workers and child supervisors to be supervised
    children = [
      supervisor(Scope.Repo, []),
      supervisor(ScopeWeb.Endpoint, []),
      {Scope.ChannelRead, name: Scope.ChannelRead}
    ]

    opts = [strategy: :one_for_one, name: Scope.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def config_change(changed, _new, removed) do
    ScopeWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
