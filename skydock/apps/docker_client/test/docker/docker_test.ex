
defmodule DockerClientTest do
  use ExUnit.Case
  doctest DockerClient

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
