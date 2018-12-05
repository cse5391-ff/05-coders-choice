defmodule DockerClient.Docker do
  defp socket_message(verb, path, params \\ %{}) do
    uri = "http/#{path}?#{URI.encode_query(params)}"
    {data, _exit_code} = System.cmd("curl", ["--silent", "-X", verb, "--unix-socket", "/var/run/docker.sock", uri])
    IO.inspect(data)
    Poison.decode(data)
  end

  def get_containers(), do: socket_message("GET", "containers/json")

  def start_container(name_id), do: socket_message("POST", "containers/#{name_id}/start")

  def stop_container(name_id), do: socket_message("POST", "containers/#{name_id}/stop")

  def kill_container(name_id), do: socket_message("POST", "containers/#{name_id}/kill")

  def pause_container(name_id), do: socket_message("POST", "containers/#{name_id}/pause")

  def unpause_container(name_id), do: socket_message("POST", "containers/#{name_id}/unpause")

  def get_volumes(), do: socket_message("GET", "volumes")#TODO: don't need this

  def get_images(), do: socket_message("GET", "images/json")

  def create_image(image, tag), do: socket_message("POST", "images/create", %{"fromImage"=>image, "tag"=>tag})

  def get_sys_info(), do: socket_message("GET", "info")

  #TODO: add ability start an "exec", return its ID, and periodically have a process query it
  # once the ececution has completed, send its "tail" or an image of the output

end
