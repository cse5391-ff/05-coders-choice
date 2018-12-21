defmodule MapSetStoreTest do
  use ExUnit.Case

  describe "MapSetStore Tests" do

    setup do

      fixture = [
        empty:        :mss_empty,
        with_vals:    :mss_with_vals,
        initial_vals: [1,3,5,7]
      ]

      {:ok, _} = MapSetStore.start(fixture.empty)
      {:ok, _} = MapSetStore.start(fixture.with_vals, fixture.initial_vals)

      fixture

    end

    test "Get returns accurate mapset", fixture do
      assert MapSet.equal?(MapSetStore.get(fixture.empty),     MapSet.new([]))
      assert MapSet.equal?(MapSetStore.get(fixture.with_vals), MapSet.new(fixture.initial_vals))
    end

    test "Adds single items", fixture do

      mss_name = fixture.empty

      MapSetStore.add(mss_name, [1])
      assert MapSet.equal?(MapSetStore.get(:mss), MapSet.new([1]))

      MapSetStore.add(mss_name, [2])
      assert MapSet.equal?(MapSetStore.get(:mss), MapSet.new([1,2]))

      MapSetStore.add(mss_name, [3])
      assert MapSet.equal?(MapSetStore.get(:mss), MapSet.new([1,2,3]))

    end

    test "Adds all items from enum", fixture do

      mss_name = fixture.empty

      MapSetStore.add(mss_name, [1,3,5])
      assert MapSet.equal?(MapSetStore.get(:mss), MapSet.new([1,3,5]))

      MapSetStore.add(mss_name, [5,7,9])
      assert MapSet.equal?(MapSetStore.get(:mss), MapSet.new([1,3,5,7,9]))

    end

    test "Removes single items", fixture do

      mss_name = fixture.with_vals

      MapSetStore.remove(mss_name, [1])
      assert MapSet.equal?(MapSetStore.get(:mss), MapSet.new([3,5,7]))

      MapSetStore.remove(mss_name, [5])
      assert MapSet.equal?(MapSetStore.get(:mss), MapSet.new([3,7]))

      MapSetStore.remove(mss_name, [3])
      assert MapSet.equal?(MapSetStore.get(:mss), MapSet.new([7]))

      MapSetStore.remove(mss_name, [7])
      assert MapSet.equal?(MapSetStore.get(:mss), MapSet.new([]))

    end

    test "Removes all items from enum", fixture do

      mss_name = fixture.with_vals

      MapSetStore.remove(mss_name, [1, 5])
      assert MapSet.equal?(MapSetStore.get(:mss), MapSet.new([3,7]))

      MapSetStore.remove(mss_name, [3, 7, 9])
      assert MapSet.equal?(MapSetStore.get(:mss), MapSet.new([]))

    end

    test "Contains? is accurate", fixture do

      mss_name = fixture.with_vals

      assert MapSetStore.contains?(mss_name, 3)
      assert MapSetStore.contains?(mss_name, 7)
      assert !MapSetStore.contains?(mss_name, 3)

    end

  end

end
