defmodule ScopeTest do
  use ExUnit.Case
  doctest Scope

  test "greets the world" do
    assert Scope.hello() == :world
  end

  test "creates chat server" do
    assert Manager.create_channel(:new, "Test Channel") == {:ok, :pid}
  end

  test "sends message to client" do
    assert Server.send_message(:peripheral, "test message") == {:noreply, "test message"}
  end

  test "lists messages" do
    assert Server.list_messages() != :null
  end

  test "deletes supervisor", sup do
    assert stop_supervised(sup) == :ok
  end

  test "lists all servers" do
    assert ServerFarm.list_channels == {:ok, []}
  end
  test "creates multiple servers" do
    ServerFarm.create_server(:new, "Test Channel 1") == {:ok, :pid}
    ServerFarm.create_server(:new, "Test Channel 2") == {:ok, :pid}

    assert ServerFarm.list_channels.tuple_size == 2
  end
end
