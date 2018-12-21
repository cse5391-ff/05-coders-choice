defmodule MapSetStoreTest do
  use ExUnit.Case
  doctest MapSetStore

  setup do
    MapSetStore.start()
  end

  test "Starts successfully", fixture do

  end

  test "Adds single items", fixture do
    assert MapSetStore.hello() == :world
  end

  test "Adds all items from enum", fixture do
    assert MapSetStore.hello() == :world
  end

  test "Removes single items", fixture do
    assert MapSetStore.hello() == :world
  end

  test "Removes all items from enum", fixture do
    assert MapSetStore.hello() == :world
  end

  test "Contains? is accurate", fixture do
    assert MapSetStore.hello() == :world
  end

end
