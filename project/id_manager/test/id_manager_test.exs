defmodule IdManagerTest do
  use ExUnit.Case

  describe "IdManager Tests" do

    setup do

      fixture = [

      ]

      {:ok, _} = MapSetStore.start(:room_ids)
      {:ok, _} = MapSetStore.start(:user_ids)

    end

    test "greets the world" do
      assert IdManager.hello() == :world
    end

  end

end
