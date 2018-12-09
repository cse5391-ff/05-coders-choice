defmodule UserIdGeneratorTest do
  use ExUnit.Case
  doctest UserIdGenerator

  test "greets the world" do
    assert UserIdGenerator.hello() == :world
  end
end
