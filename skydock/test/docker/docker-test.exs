defmodule SkyDockTest do
  use ExUnit.Case
  doctest SkyDock

  test "fetches container list (ps)" do
    assert SkyDock.Docker.get_containers() |> elem(0) == :ok
  end

  test "fetches images list" do
    assert SkyDock.Docker.get_images() |> elem(0) == :ok
  end

  test "fetches volumes dict" do
    assert SkyDock.Docker.get_images() |> elem(0) == :ok
  end
end
