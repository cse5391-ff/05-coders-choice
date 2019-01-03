defmodule RoomManagerTest do
  use ExUnit.Case
  doctest RoomManager

  test "greets the world" do
    assert RoomManager.hello() == :world
  end
end
