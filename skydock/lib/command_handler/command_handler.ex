defmodule Skydock.CommandHandler do
  use GenServer

  # Client

  def start_link(name \\ nil) do
    GenServer.start_link(__MODULE__, [], [name: name])
  end

  def get_containers(pid, params) do
    GenServer.cast(pid, {:get_containers, params})
  end

  def get_containers(pid, params), do: GenServer.cast(pid, {:get_containers, params})

  def start_container(pid, params, name_id), do: GenServer.cast(pid, {:start_container, params, name_id})

  def stop_container(pid, params, name_id), do: GenServer.cast(pid, {:stop_container, params, name_id})

  def kill_container(pid, params, name_id), do: GenServer.cast(pid, {:kill_container, params, name_id})

  def pause_container(pid, params, name_id), do: GenServer.cast(pid, {:pause_container, params, name_id})

  def unpause_container(pid, params, name_id), do: GenServer.cast(pid, {:unpause_container, params, name_id})

  def get_volumes(pid, params), do: GenServer.cast(pid, {:get_volumes, params})

  def get_images(pid, params), do: GenServer.cast(pid, {:get_images, params})

  def create_image(pid, params, image, tag), do: GenServer.cast(pid, {:create_image, params, image, tag})

  def get_sys_info(pid, params), do: GenServer.cast(pid, {:get_sys_info, params})

  # Server (callbacks)
  @impl true
  def init(state) do
    {:ok, state}
  end

  @impl true
  def handle_cast({:get_containers, params}, state) do
    IO.puts(inspect(params))
    docker_response = SkyDock.Docker.get_containers()
    Skydock.TwilioSender.send_message(TwilioSender, params["From"], "test response")
    {:noreply, [state | "get_containers"]}
  end

end
# Skydock.CommandHandler.get_containers(CommandHandler, "3098240321")
