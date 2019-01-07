defmodule UserManagerTest do
  use ExUnit.Case

  test "Generates unique ids" do

    id_len = 10

    ids = [
      UserManager.generate_user_id(id_len),
      UserManager.generate_user_id(id_len),
      UserManager.generate_user_id(id_len),
      UserManager.generate_user_id(id_len),
      UserManager.generate_user_id(id_len),
      UserManager.generate_user_id(id_len),
      UserManager.generate_user_id(id_len),
      UserManager.generate_user_id(id_len),
      UserManager.generate_user_id(id_len),
      UserManager.generate_user_id(id_len),
    ]

    ms_id_list = MapSetStore.get(:user_ids)
                 |> MapSet.to_list()

    assert Enum.sort(ids) == Enum.sort(ms_id_list)

  end

end
