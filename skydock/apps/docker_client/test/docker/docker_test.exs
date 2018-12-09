
defmodule DockerClientTest.Docker do
  use ExUnit.Case
  doctest DockerClient.Docker

  # Module is tricky to test because it directly communicates with the live docker sock (if it's even running)
  # Tests on this module should be done at developer or user discretion

  test "fetches container list (ps)" do
    assert DockerClient.Docker.get_containers() |> elem(0) == :ok
  end

  test "fetches images list" do
    assert DockerClient.Docker.get_images() |> elem(0) == :ok
  end

  test "fetches volumes dict" do
    assert DockerClient.Docker.get_images() |> elem(0) == :ok
  end
end
