defmodule RoomTest do
  use ExUnit.Case
  doctest Room

  test "greets the world" do
    assert Room.hello() == :world
  end
end
