defmodule DockerClient.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      # Starts a worker by calling: DockerClient.Worker.start_link(arg)
      # {DockerClient.Worker, arg},
      { DockerClient.CommandHandler, name: DockerClient.CommandHandler},
      { DockerClient.TwilioSender, name: DockerClient.TwilioSender}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: DockerClient.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
