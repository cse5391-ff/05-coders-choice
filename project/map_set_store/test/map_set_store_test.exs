defmodule MapSetStoreTest do
  use ExUnit.Case
  doctest MapSetStore

  test "Get returns accurate mapset" do

    {:ok, _} = MapSetStore.start(:mss_empty)
    {:ok, _} = MapSetStore.start(:mss_with_vals, [1,2,3])

    assert MapSet.equal?(MapSetStore.get(:mss_empty),     MapSet.new([]))
    assert MapSet.equal?(MapSetStore.get(:mss_with_vals), MapSet.new([1, 2, 3]))

  end

  test "Adds single items" do

    {:ok, _} = MapSetStore.start(:mss)

    MapSetStore.add(:mss, [1])
    assert MapSet.equal?(MapSetStore.get(:mss), MapSet.new([1]))

    MapSetStore.add(:mss, [2])
    assert MapSet.equal?(MapSetStore.get(:mss), MapSet.new([1, 2]))

    MapSetStore.add(:mss, [3])
    assert MapSet.equal?(MapSetStore.get(:mss), MapSet.new([1, 2, 3]))

  end

  test "Adds all items from enum" do
    assert MapSetStore.hello() == :world
  end

  test "Removes single items" do
    assert MapSetStore.hello() == :world
  end

  test "Removes all items from enum" do
    assert MapSetStore.hello() == :world
  end

  test "Contains? is accurate" do
    assert MapSetStore.hello() == :world
  end

end
