defmodule DockerClient.CommandHandler do
  use GenServer

  # Client

  def start_link(params) do
    GenServer.start_link(__MODULE__, [], params)
  end

  def get_containers(params, {}), do: GenServer.cast(DockerClient.CommandHandler, {:get_containers, params})

  def start_container(params, { name_id }), do: GenServer.cast(DockerClient.CommandHandler, {:start_container, params, name_id})

  def stop_container(params, { name_id }), do: GenServer.cast(DockerClient.CommandHandler, {:stop_container, params, name_id})

  def kill_container(params, { name_id }), do: GenServer.cast(DockerClient.CommandHandler, {:kill_container, params, name_id})

  def pause_container(params, { name_id }), do: GenServer.cast(DockerClient.CommandHandler, {:pause_container, params, name_id})

  def unpause_container(params, { name_id }), do: GenServer.cast(DockerClient.CommandHandler, {:unpause_container, params, name_id})

  def get_volumes(params, {}), do: GenServer.cast(DockerClient.CommandHandler, {:get_volumes, params})

  def get_images(params, {}), do: GenServer.cast(DockerClient.CommandHandler, {:get_images, params})

  def create_image(params, { image, tag }), do: GenServer.cast(DockerClient.CommandHandler, {:create_image, params, image, tag})

  def get_sys_info(params, {}), do: GenServer.cast(DockerClient.CommandHandler, {:get_sys_info, params})

  # Server (callbacks)
  @impl true
  def init(state) do
    {:ok, state}
  end

  @impl true
  def handle_cast({:get_containers, params}, state) do
    IO.puts(inspect(params))
    docker_response = DockerClient.Docker.get_containers()
    DockerClient.TwilioSender.send_message(params["From"], "here's your containers")
    {:noreply, [state | "get_containers"]}
  end

  def handle_cast({:start_container, params}, state) do
    IO.puts(inspect(params))
    docker_response = DockerClient.Docker.start_container("redis")
    DockerClient.TwilioSender.send_message(params["From"], "started container")
    {:noreply, [state | "get_containers"]}
  end

  def handle_cast({:start_container, params}, state) do
    IO.puts(inspect(params))
    docker_response = DockerClient.Docker.start_container("redis")
    DockerClient.TwilioSender.send_message(params["From"], "stopped container")
    {:noreply, [state | "get_containers"]}
  end

end
# DockerClient.CommandHandler.get_containers(CommandHandler, "3098240321")
