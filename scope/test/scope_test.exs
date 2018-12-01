defmodule ScopeTest do
  use ExUnit.Case
  doctest Scope

  test "greets the world" do
    assert Scope.hello() == :world
  end

  test "creates chat server" do
    assert Manager.create_channel(:new, "Test Channel") == {:ok, pid}
  end

  test "sends message to client" do
    assert Server.send_message(:urgent, "test message") == {ok, payload}
  end

  test "lists messages" do
    assert Server.list_messages() != null
  end

  test "deletes supervisor", sup do
    assert stop_supervised(sup) == :ok
  end
end
