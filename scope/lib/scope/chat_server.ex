defmodule ChatServer do
  use GenServer

  def start(:new, topic) do
    Supervisor.start_link(Channel, topic)
  end
end
