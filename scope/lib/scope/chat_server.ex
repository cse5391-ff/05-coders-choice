defmodule Scope.ChatServer do
  use GenServer

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, opts)
  end

  def init(init_state \\ []) do
    {:ok, init_state}
  end

  def start(:new, topic) do
    Supervisor.start_link(Channel, topic)
  end

end
