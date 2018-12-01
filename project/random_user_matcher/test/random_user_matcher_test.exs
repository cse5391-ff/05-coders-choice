defmodule RandomUserMatcherTest do
  use ExUnit.Case
  doctest RandomUserMatcher

  test "greets the world" do
    assert RandomUserMatcher.hello() == :world
  end
end
