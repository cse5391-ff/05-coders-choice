defmodule MapStoreTest do
  use ExUnit.Case
  doctest MapStore

  test "greets the world" do
    assert MapStore.hello() == :world
  end
end
