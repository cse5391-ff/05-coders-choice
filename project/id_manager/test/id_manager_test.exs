defmodule IdManagerTest do
  use ExUnit.Case

  describe "IdManager Tests" do

    test "Generates unique codes" do

      room_ids = [
        IdManager.generate_id(:room, 15),
        IdManager.generate_id(:room, 15),
        IdManager.generate_id(:room, 15),
        IdManager.generate_id(:room, 15)
      ]

      user_ids = [
        IdManager.generate_id(:user, 10),
        IdManager.generate_id(:user, 10),
        IdManager.generate_id(:user, 10),
        IdManager.generate_id(:user, 10)
      ]

      assert room_ids == Enum.uniq(room_ids)
      assert MapSet.equal?(MapSet.new(room_ids), MapSetStore.get(:room_ids))

      assert user_ids == Enum.uniq(user_ids)
      assert MapSet.equal?(MapSet.new(user_ids), MapSetStore.get(:user_ids))

    end

  end

end
