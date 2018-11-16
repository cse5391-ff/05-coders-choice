defmodule PianoTest do
  use ExUnit.Case
  doctest Piano

  test "greets the world" do
    assert Piano.hello() == :world
  end
end
