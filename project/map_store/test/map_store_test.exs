defmodule MapStoreTest do
  use ExUnit.Case

  describe "MapStore Tests" do

    setup do

      fixture = %{
        empty:        :ms_empty,
        with_vals:    :ms_with_vals,
        initial_map: %{:a => "aaa", :b => "bbb", :c => "ccc", :d => "ddd"}
      }

      {:ok, _} = MapStore.start(fixture.empty)
      {:ok, _} = MapStore.start(fixture.with_vals, fixture.initial_map)

      {:ok, fixture}

    end

    test "Get/1 returns accurate map", fixture do
      assert     fixture.empty |> MapStore.get() == %{}
      assert fixture.with_vals |> MapStore.get() == fixture.initial_map
    end

    test "Get/2 successful, doesnt blow up if key doesnt exist", fixture do
      assert fixture.with_vals |> MapStore.get(:a) == "aaa"
      assert fixture.with_vals |> MapStore.get(:d) == "ddd"
      assert fixture.with_vals |> MapStore.get(:f) == nil
    end

    test "add successful", fixture do
      fixture.empty |> MapStore.add(:a, "aaa")
      fixture.empty |> MapStore.add(:b, "bbb")
      fixture.empty |> MapStore.add(:c, "ccc")
      fixture.empty |> MapStore.add(:d, "ddd")

      assert MapStore.get(fixture.empty) == MapStore.get(fixture.with_vals)
    end

    test "remove successful", fixture do
      fixture.with_vals |> MapStore.remove(:a)
      fixture.with_vals |> MapStore.remove(:b)
      fixture.with_vals |> MapStore.remove(:c)
      fixture.with_vals |> MapStore.remove(:d)

      assert MapStore.get(fixture.empty) == MapStore.get(fixture.with_vals)
    end

    test "contains_key? successful", fixture do
      assert fixture.with_vals |> MapStore.contains_key?(:a)

      fixture.with_vals |> MapStore.remove(:a)

      assert !(fixture.with_vals |> MapStore.contains_key?(:a))
    end

  end

end
