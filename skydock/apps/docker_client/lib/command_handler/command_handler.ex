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
    DockerClient.TwilioSender.send_response(params, "here's your containers")
    {:noreply, [state | "get_containers"]}
  end

  def handle_cast({:start_container, params, name_id}, state) do
    IO.puts(inspect(params))
    docker_response = DockerClient.Docker.start_container(name_id)
    DockerClient.TwilioSender.send_response(params, name_id)
    {:noreply, [state | "start_container"]}
  end

  def handle_cast({:stop_container, params, name_id}, state) do
    IO.puts(inspect(params))
    docker_response = DockerClient.Docker.stop_container(name_id)
    DockerClient.TwilioSender.send_response(params, name_id)
    {:noreply, [state | "stop_container"]}
  end

  def handle_cast({:kill_container, params, name_id}, state) do
    IO.puts(inspect(params))
    docker_response = DockerClient.Docker.kill_container(name_id)
    DockerClient.TwilioSender.send_response(params, name_id)
    {:noreply, [state | "kill_container"]}
  end

  def handle_cast({:pause_container, params, name_id}, state) do
    docker_response = DockerClient.Docker.pause_container(name_id)
    DockerClient.TwilioSender.send_response(params, name_id)
    {:noreply, [state | "pause_container"]}
  end

  def handle_cast({:unpause_container, params, name_id}, state) do
    docker_response = DockerClient.Docker.unpause_container(name_id)
    DockerClient.TwilioSender.send_response(params, name_id)
    {:noreply, [state | "unpause_container"]}
  end

  def handle_cast({:get_volumes, params}, state) do
    docker_response = DockerClient.Docker.get_volumes()
    DockerClient.TwilioSender.send_response(params, "get_volumes")
    {:noreply, [state | "get_volumes"]}
  end

  def handle_cast({:get_images, params}, state) do
    docker_response = DockerClient.Docker.get_images()
    DockerClient.TwilioSender.send_response(params, "get_images")
    {:noreply, [state | "get_images"]}
  end

  def handle_cast({:create_image, params, image, tag}, state) do
    docker_response = DockerClient.Docker.create_image(image, tag)
    DockerClient.TwilioSender.send_response(params, "create_image")
    {:noreply, [state | "create_image"]}
  end

  def handle_cast({:get_sys_info, params}, state) do
    docker_response = DockerClient.Docker.get_sys_info()
    DockerClient.TwilioSender.send_response(params, "sys_info")
    {:noreply, [state | "get_sys_info"]}
  end

end
