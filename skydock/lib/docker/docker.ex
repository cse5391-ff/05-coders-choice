defmodule SkyDock.Docker do
  defp socket_message(verb, path, params \\ %{}) do
    uri = "http/#{path}?#{URI.encode_query(params)}"
    {data, _exit_code} = System.cmd("curl", ["--silent", "-X", verb, "--unix-socket", "/var/run/docker.sock", uri])
    Poison.decode(data)
  end

  def get_containers(), do: socket_message("GET", "containers/json")

  def start_container(name_id), do: socket_message("POST", "containers/#{name_id}/start")

  def stop_container(name_id), do: socket_message("POST", "containers/#{name_id}/stop")

  def kill_container(name_id), do: socket_message("POST", "containers/#{name_id}/kill")

  def get_volumes(), do: socket_message("GET", "volumes")

  def get_images(), do: socket_message("GET", "images/json")

  def create_image(image, tag), do: socket_message("POST", "images/create", %{"fromImage"=>image, "tag"=>tag})

  def get_sys_info(), do: socket_message("GET", "info")
end
