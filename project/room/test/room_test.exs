defmodule RoomTest do

  use ExUnit.Case

  describe "Room tests" do

    setup do

      fixture = %{
        match:     %{:match_room},
        protected: %{:protected_room}
      }

      {:ok, _} = Room.start(:protected)

    end

  end

end
