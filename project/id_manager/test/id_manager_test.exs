defmodule IdManagerTest do
  use ExUnit.Case
  doctest IdManager

  test "greets the world" do
    assert IdManager.hello() == :world
  end
end
