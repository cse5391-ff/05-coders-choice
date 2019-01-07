defmodule RandomUserMatcherTest do

  use ExUnit.Case

  test "match when matcher is empty returns :waiting" do
    assert RandomUserMatcher.match("abc") == :waiting
  end

  test "matching same user twice returns already_waiting, keeps them in state" do
    RandomUserMatcher.match("abc")
    assert RandomUserMatcher.match("abc") == :already_waiting
  end

  test "matching new user returns :match and the user that was waiting" do
    RandomUserMatcher.match("abc")
    assert RandomUserMatcher.match("def") == {:match, "abc"}
  end

end
