defmodule DockerClient.CommandHandler do
  use GenServer
  import Ecto

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

  def get_images(params, {}), do: GenServer.cast(DockerClient.CommandHandler, {:get_images, params})

  def get_sys_info(params, {}), do: GenServer.cast(DockerClient.CommandHandler, {:get_sys_info, params})

  def get_logs(params, { name_id }), do: GenServer.cast(DockerClient.CommandHandler, {:get_logs, params, name_id})

  # Server (callbacks)
  @impl true
  def init(state) do
    {:ok, state}
  end

  @impl true
  def handle_cast({:get_containers, params}, state) do
    {_, docker_response } = DockerClient.Docker.get_containers()

    msg = Enum.map(docker_response, fn x -> "#{x["Names"]}:#{x["State"]}" end)
    |> Enum.join(", ")

    DockerClient.TwilioSender.send_sms_response(params, msg)
    {:noreply, [state | "get_containers"]}
  end

  def convert_success_or_error({:error, :invalid, 0}, name_id, verb) do
    "Successfully #{verb} Container #{name_id}"
  end

  def convert_str_or_array(%{"message"=>message}, _name_id) do
    "Error: #{message}"
  end

  def handle_cast({:start_container, params, name_id}, state) do
    docker_response = DockerClient.Docker.start_container(name_id)

    msg = convert_success_or_error(docker_response, name_id, "Started")

    DockerClient.TwilioSender.send_sms_response(params, msg)
    {:noreply, [state | "start_container"]}
  end

  def handle_cast({:stop_container, params, name_id}, state) do
    docker_response = DockerClient.Docker.stop_container(name_id)

    msg = convert_success_or_error(docker_response, name_id, "Stopped")

    DockerClient.TwilioSender.send_sms_response(params, msg)
    {:noreply, [state | "stop_container"]}
  end

  def handle_cast({:kill_container, params, name_id}, state) do
    docker_response = DockerClient.Docker.kill_container(name_id)

    msg = convert_success_or_error(docker_response, name_id, "Killed")

    DockerClient.TwilioSender.send_sms_response(params, msg)
    {:noreply, [state | "kill_container"]}
  end

  def handle_cast({:pause_container, params, name_id}, state) do
    docker_response = DockerClient.Docker.pause_container(name_id)

    msg = convert_success_or_error(docker_response, name_id, "Paused")

    DockerClient.TwilioSender.send_sms_response(params, msg)
    {:noreply, [state | "pause_container"]}
  end

  def handle_cast({:unpause_container, params, name_id}, state) do
    docker_response = DockerClient.Docker.unpause_container(name_id)

    msg = convert_success_or_error(docker_response, name_id, "Unpaused")

    DockerClient.TwilioSender.send_sms_response(params, msg)
    {:noreply, [state | "unpause_container"]}
  end

  def handle_cast({:get_images, params}, state) do
    {_, docker_response } = DockerClient.Docker.get_images()

    msg = Enum.map(docker_response, fn x -> "#{x["RepoTags"]}" end)
    |> Enum.join(", ")

    DockerClient.TwilioSender.send_sms_response(params, msg)
    {:noreply, [state | "get_images"]}
  end

  def handle_cast({:get_sys_info, params}, state) do
    {_, res } = DockerClient.Docker.get_sys_info()

    msg = "Containers:#{res["Containers"]}\nRunning:#{res["ContainersRunning"]}\nMem:#{res["MemTotal"]}"
    DockerClient.TwilioSender.send_sms_response(params, msg)
    {:noreply, [state | "get_sys_info"]}
  end

  def handle_cast({:get_logs, params, name_id}, state) do
    docker_response = DockerClient.Docker.get_logs(name_id)
    filename = "#{Ecto.UUID.generate}.jpg"
    DockerClient.TextToImage.store_txt_as_img(docker_response, "/tmp/#{filename}")

    DockerClient.TwilioSender.send_mms_response(params, "See Image", "http://skydock.ngrok.io/media/#{filename}")

    {:noreply, [state | "start_container"]}
  end

end
