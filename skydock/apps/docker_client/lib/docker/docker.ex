defmodule DockerClient.Docker do
  defp socket_message(verb, path, params \\ %{}) do
    uri = "http/#{path}?#{URI.encode_query(params)}"
    {data, _exit_code} = System.cmd("curl", ["--silent", "-X", verb, "--unix-socket", "/var/run/docker.sock", uri])
    data
  end

  def get_containers(), do: Poison.decode(socket_message("GET", "containers/json"))

  def start_container(name_id), do: Poison.decode(socket_message("POST", "containers/#{name_id}/start"))

  def stop_container(name_id), do: Poison.decode(socket_message("POST", "containers/#{name_id}/stop"))

  def kill_container(name_id), do: Poison.decode(socket_message("POST", "containers/#{name_id}/kill"))

  def pause_container(name_id), do: Poison.decode(socket_message("POST", "containers/#{name_id}/pause"))

  def unpause_container(name_id), do: Poison.decode(socket_message("POST", "containers/#{name_id}/unpause"))

  def get_images(), do: Poison.decode(socket_message("GET", "images/json"))

  def get_sys_info(), do: Poison.decode(socket_message("GET", "info"))

  def get_logs(name_id) do
    {data, _exit_code} = System.cmd("docker", ["logs", "--tail", "80", name_id])
    data
  end

end
