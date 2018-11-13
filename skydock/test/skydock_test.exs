defmodule SkyDockTest do
  use ExUnit.Case
  doctest SkyDock

  test "greets the world" do
    assert SkyDock.hello() == :world
  end
end
