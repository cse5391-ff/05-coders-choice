defmodule Skydock.CommandHandler do
  use GenServer
  # Client

  def start_link(name \\ nil) do
    GenServer.start_link(__MODULE__, [], [name: name])
  end

  def get_containers(pid, sender) do
    GenServer.cast(pid, {:get_containers, sender})
  end

  # Server (callbacks)

  @impl true
  def init(state) do
    {:ok, state}
  end

  @impl true
  def handle_cast({:get_containers, sender}, state) do
    Process.sleep(1000)
    IO.puts(inspect(SkyDock.Docker.get_containers()))
    {:noreply, [state | "get_containers"]}
  end
end
# Skydock.CommandHandler.get_containers(CommandHandler, "3098240321")
