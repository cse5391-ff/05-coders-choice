defmodule Scope.ChatServer do
  use GenServer

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, opts)
  end

  def init(init_state \\ []) do
    {:ok, init_state}
  end

  def start(:new, topic) do
    children = [
      %{id: Channel,
      start: {Channel, :start_link, [[topic]]}
    }
    ]
    opts = [strategy: :one_for_one]
    Supervisor.start_link(children, opts)

  end

end
