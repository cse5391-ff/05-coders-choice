defmodule Terminal2048Test do
  use ExUnit.Case
  doctest Terminal2048

  test "greets the world" do
    assert Terminal2048.hello() == :world
  end
end
